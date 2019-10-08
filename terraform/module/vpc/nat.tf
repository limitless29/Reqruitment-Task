resource "aws_eip" "Oct9eip" {
       vpc      = true
}


resource "aws_nat_gateway" "Oct9natgw" {
     allocation_id = "${aws_eip.Oct9eip.id}"
     subnet_id = "${aws_subnet.Oct9pub-snet.id}"
     depends_on = ["aws_internet_gateway.Oct9igw"]
    tags =  {
        Name = "Oct9Nat-GW"
    }


}


resource "aws_route_table" "Oct9prv-rt" {
    vpc_id = "${aws_vpc.Oct9vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.Oct9natgw.id}"
    }

    tags = {
        Name = "Oct9Nat-RT"
    }
}


resource "aws_route_table_association" "Oct9prv-route-asso" {
    subnet_id = "${aws_subnet.Oct9prv-snet.id}"
    route_table_id = "${aws_route_table.Oct9prv-rt.id}"
}

