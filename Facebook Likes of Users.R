library(rjson)

username <- "INSERT FACEBOOK USERNAME HERE"
access_token <- "INSERT ACCESS TOKEN HERE"

nrows <- 5000 # max number of friends

data<- data.frame(b=rep(NA,nrows), c=rep(NA,nrows),d=rep(NA,nrows))

getSTDFriendURL <- function(name,token) {
  return (paste("https://graph.facebook.com/", name,"/friends?access_token=", token, sep = ""))
}

getSTDLikesURL <- function(name,token) {
  return (paste("https://graph.facebook.com/", name,"/likes?access_token=", token, sep = ""))
}

getProfileURL <- function(ID) {
  return (paste("https://facebook.com/", ID, sep = ""))
}



JSONfriends <- fromJSON(paste(readLines(getSTDFriendURL(username,access_token)), collapse=""))
numFriends <- floor(length(JSONfriends[[1]]))



  for (JSONindex in 1:numFriends) {
    ID <- JSONfriends[[1]][[JSONindex]]$id
    JSONLikes <- fromJSON(paste(readLines(getSTDLikesURL(ID,access_token)), collapse=""))
    
    try ({
      name <- JSONfriends[[1]][[JSONindex]]$name
      profileURL <- getProfileURL(ID)
      numLikes <- floor(length(JSONLikes[[1]]))
      
      data[JSONindex,]<-c(name,profileURL,numLikes)
      
    }, silent=T)

  }

data <- na.omit(data)

data[,3] <- as.numeric(data[,3])
data<-data[with(data, order(-d,b)), ] # sorts Likes, descending

names(data) <- c("Name","Profile URL", "# Likes")
write.table(data, paste(username,"-FriendLikeCounts.txt",sep=""),sep="\t",row.names=F,qmethod="d") # tab-delimited text file, easily opens in Excel

# If you want a bonus histogram of the likes:
# hist(data[,3], n=500, main=paste("Distribution of " ,username,"'s friends' Facebook Likes",sep=""), xlab="Likes", col="red", xlim=c(0,1000))
