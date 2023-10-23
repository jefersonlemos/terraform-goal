# terraform {
#   required_version = ">= 0.12"
# }

# required_providers {
#   aws = {
#     source = "hashicorp/aws"
#     version = "> 5"
#   }
# }

#VPC com 4 subnets (2pub, 2priv), rotas, IG, SG liberando porta 80 (in) nas pub



resource aws_vpc "this" {
    name = "vpc_name_djow"
    cidr = ""
}


resource aws_subnets "subnets" {
    vpc_id = #TODO - pegar dinamicament o vpc id
    cidr_block = #TODO - criar as 4 subnets

}



#TODO - DESAFIO DESSE MÓDULO
Tentar otimizar o código pra que nao precise duplicar o resource da subnet
Usar um  unico recurso de subnet que vai criar subnets publicas e privadas
