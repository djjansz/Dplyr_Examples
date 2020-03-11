###################################################################################################
## PROGRAM: dplyr_examples.r
## PURPOSE: To provide a demo of using the dplyr data manipution functions on the iris dataset
## Iris Data: https://warwick.ac.uk/fac/sci/moac/people/students/peter_cock/r/iris_plots
## Git Crash Course: https://www.youtube.com/watch?v=SWYqp7iY_Tc&t=1024s
## SAS and R Book: https://labstatunisba.files.wordpress.com/2015/02/sas-and-r_-data-management-statistical-analysis-and-graphics-second-edition-chapman-and-hall_crc-2014.pdf
## NOTES ON THE IRIS DATASET
##    The iris dataset contains four measurements for 150 flowers from three species of iris 
##    1.Iris setosa, 2. versicolor and 3. virginica
##    the Petal is the flower and the Sepal is the leaves around the flower
##    Petal.Length, Petal.Width, Sepal.Length, Sepal.Width are measured by Species
###################################################################################################
#show that the iris data is stored as a data frame
class(iris)
#show the variable names in the data frame
toupper(colnames(iris))
#save the petal length to a vector
petal_length<-iris[,"Petal.Length"] # or iris[,3] 
#scatterplot the length vs. width by species with red dots for Iris setosa, green dots for versicolor, and blue dots for virginica
plot(iris$Petal.Length, iris$Petal.Width, pch=21, bg=c("red","green3","blue")[unclass(iris$Species)], main="Edgar Anderson's Iris Data")
#Draftsman display of the scatterplot - note that virginica (blue) usually has greater lengths and widths of both the Petal and Sepal
#   however, versicolor (green) and virginica (blue) have similar Sepal Width and Length making it difficult to use Sepal measurements to differentiate the two 
pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species", pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)], lower.panel=NULL, labels=c("SL","SW","PL","PW"), font.labels=2, cex.labels=4.5) 
setosa_data<-subset(iris,Species=="setosa")
summary(setosa_data)
versicolor_data<-subset(iris,Species=="versicolor")
summary(versicolor_data)
virginica_data<-subset(iris,Species=="virginica")
summary(virginica_data)
#SHOW THE MEAN LENGTHS AND WIDTHS
paste0("The Setosa (Red) has Petal Length Avg=",with(setosa_data,mean(Petal.Length)),", Petal Width Avg=",with(setosa_data,mean(Petal.Width)),", Sepal Width Avg=",with(setosa_data,mean(Sepal.Width)),", Sepal Width Avg=",with(setosa_data,mean(Sepal.Width)))
paste0("The Versicolor (Green) has Petal Length Avg=",with(versicolor_data,mean(Petal.Length)),", Petal Width Avg=",with(versicolor_data,mean(Petal.Width)),", Sepal Width Avg=",with(versicolor_data,mean(Sepal.Width)),", Sepal Width Avg=",with(versicolor_data,mean(Sepal.Width)))
paste0("The Virginica (Blue) has Petal Length Avg=",with(virginica_data,mean(Petal.Length)),", Petal Width Avg=",with(virginica_data,mean(Petal.Width)),", Sepal Width Avg=",with(virginica_data,mean(Sepal.Width)),", Sepal Width Avg=",with(virginica_data,mean(Sepal.Width)))
#USE THE DPLYR PACKAGE ON THE IRIS DATA
library(dplyr)
#make the names all lower case
names(iris) <- tolower(names(iris))
names(iris)
#show only observations for the virginica species with a sepal length greater than 5 - Note the triple colon operator as filter() is in more than one package
virginica_Length5 <- dplyr::filter(iris, species == "virginica",sepal.length>5)
virginica_Length5
# create a new variable that stores logical values saying whether sepal.width is greater than half of sepal.length
newVar <- mutate(iris, greater.half = sepal.width > 0.5 * sepal.length)
head(newVar)
tail(newVar)
# the pipeline %>% aka the chain operator allows us to first filter, and then arrange our data. 
arr.setosa <- newVar %>% dplyr::filter(species == "setosa") %>% arrange(desc(sepal.length))
arr.setosa[1:25,] # will show us rows 1 through 25
#show the average sepal length for the setosa species
summarise(arr.setosa, mean.length.setosa = mean(sepal.length, na.rm = TRUE))
arr.virg <- newVar %>% dplyr::filter(species == "virginica") %>% arrange(desc(sepal.length))
#show the average sepal length for the virginica species
summarise(arr.virg, mean.length.virg = mean(sepal.length, na.rm = TRUE))
#make a versicolor dataset that is sorted by sepal length
arr.versi <- newVar %>% dplyr::filter(species == "versicolor") %>% arrange(sepal.length)
#show the max sepal length for the versicolor species
summarise(arr.versi, mean.length.versi = mean(sepal.length, na.rm = TRUE))
