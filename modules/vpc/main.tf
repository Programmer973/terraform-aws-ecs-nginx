resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.name}-vpc"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.name}-igw"
    }
  
}

resource "aws_subnet" "public" {
    count = length(var.azs)
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
    availability_zone = var.azs[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.name}-public-${count.index}"
    }
  
}

resource "aws_eip" "nat" {
    count = length(var.azs)
    domain = "vpc"
    depends_on = [aws_internet_gateway.igw]
    tags = {
        Name = "${var.name}-nat-${count.index}"
    }

}


resource "aws_nat_gateway" "nat" {
    count = length(var.azs)
    allocation_id = aws_eip.nat[count.index].id
    subnet_id = aws_subnet.public[count.index].id
    depends_on = [aws_internet_gateway.igw]
    tags = {
        Name = "${var.name}-nat-${count.index}"
    }

  
}

resource "aws_subnet" "private" {
    count = length(var.azs)
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + length(var.azs))
    availability_zone = var.azs[count.index]
    tags = {
        Name = "${var.name}-private-${count.index}"
    }
  
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  count  = length(var.azs)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "${var.name}-private-route-table-${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id

  depends_on = [aws_nat_gateway.nat]
}

