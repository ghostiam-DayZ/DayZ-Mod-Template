#!/bin/bash
astyle --recursive --style=google --indent-switches --add-braces --unpad-paren *.c *.cpp
find . -name '*.orig' -delete