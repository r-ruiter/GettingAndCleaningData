is.installed <- function(x) {
    if(!require(x, character.only = T)) {
        install.packages(x)
        if(!require(x, character.only = T)) {
            stop(paste("Package", x, "not found"))
        }
    }
}

is.installed("dplyr")
is.installed("tidyr")

# read features and select only rows with mean and standard deviation (std)
ft <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = F, col.names = c("feature_id", "feature"))
ft <- ft[grep("mean\\(|std\\(", ft$feature), ]

# change names to camelCase notation and remove () and dash for more readable columnnames in the test and trainingdata
ft$feature <- gsub("mean", "Mean", ft$feature)
ft$feature <- gsub("std", "Std", ft$feature)
ft$feature <- gsub("[\\()-]", "", ft$feature)

# add a V to id to match the columnnumbers in the test and trainingdata
ft <- transform(ft, feature_id=paste("V", feature_id, sep = ""))

# read the testdata, all columns are numeric (double)
txt <- read.csv("UCI HAR Dataset/test/X_test.txt", header = F, sep = "", colClasses = c(rep("numeric", 561)))
# select only the columns with mean and std and give proper columnnames
txt <- select(txt, one_of(ft$feature_id))
colnames(txt) <- ft$feature

# read the subjects
txtSubject <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = F, col.names = "subject")

# read the activities and add an id for sorting
txtY <- read.csv("UCI HAR Dataset/test/y_test.txt", header = F, col.names = "activity_id")
txtY$id <- as.numeric(rownames(txtY))

# read the activity names and convert them to lowercase for readability
actLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", header = F, sep = "", col.names = c("activity_id", "activity"))
actLabels <- mutate(actLabels, activity = tolower(activity))

# merge the activity labels and names
dfActivity <- merge(txtY, actLabels)
dfActivity <- dfActivity %>% arrange(id) %>% select(activity)

# merge the subjects and activities to the test data
dfTest <- tbl_df(bind_cols(bind_cols(txt, txtSubject), dfActivity))

# remove unused objects
rm(txt, txtY, dfActivity, txtSubject)

# read the training data, all columns are numeric (double)
txt <- read.csv("UCI HAR Dataset/train/X_train.txt", header = F, sep = "", colClasses = c(rep("numeric", 561)))
# select only the columns with mean and std and give proper columnnames
txt <- select(txt, one_of(ft$feature_id))
colnames(txt) <- ft$feature

# read the subjects
txtSubject <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = F, col.names = "subject")

# read the activities and add an id for sorting
txtY <- read.csv("UCI HAR Dataset/train/y_train.txt", header = F, col.names = "activity_id")
txtY$id <- as.numeric(rownames(txtY))

# merge the activity labels and names
dfActivity <- merge(txtY, actLabels)
dfActivity <- dfActivity %>% arrange(id) %>% select(activity)

# merge the subjects and activities to the training data
dfTrain <- tbl_df(bind_cols(bind_cols(txt, txtSubject), dfActivity))

# remove unused objects
rm(txt, txtY, dfActivity, actLabels, txtSubject, ft)

# add a column to identify the source of the data
dfTest$source <- "test"
dfTrain$source <- "train"

# concatenate the test and train data to 1
dfTotal <- bind_rows(dfTest, dfTrain)

# clean up unused objects
rm(dfTest, dfTrain)

# Make a tidy dataset with the mean of each variable for each subject and activity
dfTidy <- dfTotal %>% 
    select(-source) %>% 
    gather(measure, variable, -(subject:activity)) %>%
    group_by(subject, activity, measure) %>%
    summarise(variable = mean(variable)) %>%
    unite(temp, activity, measure) %>%
    spread(temp, variable)

# print(object.size(dfTotal), units = "MB")
# print(object.size(dfTidy), units = "MB")

# write the data to csv files
write.table(dfTotal, "mergeddata.csv", sep = "\t", row.names = F)
write.table(dfTidy, "tidydata.csv", sep = "\t", row.names = F)

# x <- read.csv("tidydata.csv", header = T, sep = "\t")
# y <- read.csv("mergeddata.csv", header = T, sep = "\t")
