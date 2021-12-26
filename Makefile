# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rbourgea <rbourgea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/25 15:17:31 by rbourgea          #+#    #+#              #
#    Updated: 2021/12/26 12:05:48 by rbourgea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DCOMPOSE	=	./srcs/docker-compose.yaml

all:
	echo "127.0.0.1 rbourgea.42.fr" | sudo tee -a /etc/hosts
	docker-compose -f $(DCOMPOSE) build
	docker-compose -f $(DCOMPOSE) up -d
	
fclean:	stop rm_cont rm_volumes rm_network rm_images rm_data

stop:
	- docker stop $$(docker ps -qa)

rm_cont:
	- docker rm $$(docker ps -qa)

rm_volumes:
	- docker volume rm $$(docker volume ls -q)

rm_network:
	- docker network rm $$(docker network ls -q) 2>/dev/null

rm_images:
	- docker rmi -f $$(docker images -qa)

rm_data:
	sudo rm -rf /home/parallels/data/wordpress
	sudo rm -rf /home/parallels/data/database
	mkdir -p /home/parallels/data/
	mkdir -p /home/parallels/data/wordpress
	mkdir -p /home/parallels/data/database

up:
	docker-compose ./srcs/docker-compose.yaml up -d
down:
	docker-compose down
ps:
	docker-compose ./srcs/docker-compose.yaml ps