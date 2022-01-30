
# Background --------------------------------------------------------------


# Comment to trigger diff.




# Load packages -----------------------------------------------------------

library("googlesheets4")
library("rtweet")
library("dplyr")
library("stringr")



# Load data ---------------------------------------------------------------

gs4_deauth()

archive <- read_sheet("https://docs.google.com/spreadsheets/d/1wZhPLMCHKJvwOkP4juclhjFgqIY8fQFMemwKL2c64vk/edit#gid=0")

head(archive)



# Choose entry and create URL ---------------------------------------------

entry <- archive %>% 
  slice_sample(n = 1) %>% 
  mutate(edition_url = paste0("https://www.data-is-plural.com/archive/", str_replace_all(edition, "[.]", "-"), "-edition/"))

entry$edition
entry$edition_url



# Create the tweet --------------------------------------------------------

tweet_status <- paste(entry$headline, entry$edition_url, "#opendata" ,  sep= "\n")
tweet_status



# Send tweet --------------------------------------------------------------

rbot_token <- rtweet::create_token(
  app = "DataIsPlural_bot",
  consumer_key = Sys.getenv("CONSUMER_KEY"),
  consumer_secret = Sys.getenv("CONSUMER_SECRET"),
  access_token = Sys.getenv("ACCESS_TOKEN"),
  access_secret = Sys.getenv("ACCESS_SECRET"),
  set_renv = FALSE
)
  
  
post_tweet(status = tweet_status,
           token = rbot_token)  
  
  



