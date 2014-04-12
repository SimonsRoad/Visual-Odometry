CXXFLAGS := -g -O4 -mtune=native -Wall `pkg-config --cflags opencv`
LDFLAGS := `pkg-config --libs opencv`
OBJ := main.o

all: main

clean:
	rm -rf *.o main

main: $(OBJ)
	g++ -o $@ $(OBJ) $(LDFLAGS)

