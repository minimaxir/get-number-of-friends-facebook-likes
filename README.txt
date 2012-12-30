This R code calculates the # of Facebook Likes for brand pages for each of the specified users' friends on Facebooks using its Graph API, and outputs it in a tab-delimited spreadsheet. The purpose of this is to identify which of your friends has Liked the most brand page to see who are the most likely contributors towards your Suggested Post News Feed spam.


The # of Likes will not exactly match what is shown on the Facebook profile since this counting method this includes Pages which have been deleted (Facebook does not make it easy to get this value). However, you'll still be able to identify your friends who are the most egregrious likers.

The code has three prerequisites:

1. the rjson R library
2. The username of the person whose friends are being analyzed
3. A valid access token for that user with the friends_likes permission. (go to http://developers.facebook.com/tools/explorer/ , select "Get Access Token," enable the "friends_likes" permission, and use the token that is generated)