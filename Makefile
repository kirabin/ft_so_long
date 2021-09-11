NAME		=	so_long
FLAGS		=	-Wall -Wextra -Werror
LIBFT		=	libft/libft.a

SRC			=	main.c

OBJ			= $(SRC:.c=.o)
INC_DIRS	=  -I. -I./libft -I./mlx_mms
HEADERS		= so_long.h libft/libft.h
MLX_OG		= -framework OpenGL -framework AppKit -lmlx
MLX_MM		= -framework OpenGL -framework AppKit -L. -lmlx

all: $(NAME)

$(LIBFT):
	make -C libft

%.o: %.c $(HEADERS)
	 gcc $(FLAGS) $(INC_DIRS) -c $< -o $@

$(NAME): $(LIBFT) $(OBJ) $(INC)
	make -C mlx_mms
	mv mlx_mms/libmlx.dylib libmlx.dylib
	gcc $(FLAGS) $(OBJ) $(MLX_MM) -L./libft -lft -o $(NAME) $(INC_DIRS)

clean:
	mv libmlx.dylib mlx_mms/libmlx.dylib
	make clean -C mlx_mms; cd ..
	make clean -C libft
	rm -f $(OBJ)

fclean: clean
	make fclean -C libft
	rm -f $(NAME)

re: fclean all

run:
	./$(NAME) map.ber

save:
	./$(NAME) map.ber --save

norm:
	norminette *.{c,h}
