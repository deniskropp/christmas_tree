CFLAGS=-Wall -Wno-pedantic $(shell pkg-config --cflags sfml-graphics sfml-window) -g
CXXFLAGS=-std=c++2a $(CFLAGS)
LIBRARIES := $(shell pkg-config --libs sfml-graphics sfml-window) -lm
UNAME := $(shell uname -s)

ifeq ($(UNAME), Darwin)
	LIBRARIES += -framework OpenGL
else ifeq ($(UNAME), Linux)
	LIBRARIES += -lGL
endif

.DEFAULT_GOAL := all

christmas_tree.o: christmas_tree.cpp shader.h spiral.h
	g++ $(CXXFLAGS) -c -o $@ $<

christmas_tree: christmas_tree.o shader.o spiral.o
	g++ -o $@ $^ $(LIBRARIES)

all: christmas_tree

clean:
	rm -f *.o christmas_tree || true