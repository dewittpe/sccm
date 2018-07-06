all: ../data/CircleLimitI.rda ../data/HexagonalFish.rda

../data/CircleLimitI.rda: ./mcescher.R
	Rscript --quiet --vanilla mcescher.R

../data/HexagonalFish.rda: ./hexagonal-fish.R
	Rscript --quiet --vanilla hexagonal-fish.R
