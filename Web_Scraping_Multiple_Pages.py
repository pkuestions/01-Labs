from bs4 import BeautifulSoup
import requests
import pandas as pd
pd.set_option('display.max_rows', None)
import collections
import difflib
import random

def load_clean_edit_df(df):
    """
    Load dataframe from csv.
    Make columns lowercase.
    Add columns with simplified song names.
    Return reordered dataframe.
    """

    df.columns = [col.lower() for col in df.columns]

    df["song_lower"] = [song.lower() for song in df["song"]]
    df["song_lower_shorthand"] = [song.split("(")[0].lower().replace("'", "").replace(".", "").replace(",", "").strip() 
                                  for song in df["song"]]

    df = df[["song", "song_lower", "song_lower_shorthand", "artist"]]
    
    return df

def get_songs(df):

    song_list = list(df["song"])
    song_list_lower = list(df["song_lower"])
    song_list_lower_shorthand = list(df["song_lower_shorthand"])
    duplicate_songs = [item for item, count in collections.Counter(song_list_lower).items() if count > 1]
    
    return song_list, song_list_lower, song_list_lower_shorthand, duplicate_songs


def get_and_check_user_input():
    """
    Get user's input and check whether the song is in Top 100.
    Ask for input until valid top 100 song is given.
    """
    user_input = input("Pick a hot song: ")
    ui_easified = user_input.split("(")[0].lower().replace("'", "").replace(".", "").replace(",", "").strip()
    #ui_easified = user_input.lower().replace("'", "").replace(".", "").replace(",", "").replace("(","").replace(")","").strip() 
    
    if ui_easified in list(df["song_lower_shorthand"]):
        ui_idx = list(df["song_lower_shorthand"]).index(ui_easified)

        return df["song"][ui_idx]

    else:
        diff_match = difflib.get_close_matches("bad rabit", list(df["song"]))[0]
        yn_input = input(f"I assume you meant {diff_match} [Y] / [N]")
        if yn_input.lower() == "y":
            return diff_match
        else:
            user_input = get_and_check_user_input()
        
    
def check_if_song_duplicate(user_input):
    """
    Check if chosen song exists more than once.
    Prompt user to choose if song is duplicate.
    """
    artists = list(df[df["song_lower_shorthand"].str.contains(user_input, case=False)]["artist"].values)
    
    if len(artists) > 1:
        
        print(f"There is more than one song named '{user_input}'")
        print("------------")
        print(f"Which of the {len(artists)} artists did you mean?")
        
        input_duplicate = input(f"Select {len(artists)-1} for {artists[0]} or \n         {len(artists)} for {artists[1]}")
        
        if input_duplicate not in [str(i) for i in range(1,len(artists)+1)]:
            print("------------")
            print("Invalid input - please choose again!")
            input_duplicate = input(f"Select {len(artists)-1} for {artists[0]} or \n             {len(artists)} for {artists[1]}")
        
        artists = artists[int(input_duplicate)-1]
        
        #print("------------")
        
        print(f"You chose '{user_input}' by {artists}")
        return artists
    return artists

def result():
    
    user_input = get_and_check_user_input()
    #print(user_input)
    
    artist = check_if_song_duplicate(user_input)
    #print(artist)
   
    if len(artist) == 1:
        print(f"You chose '{user_input}' by {artist}")
        
    recom_new_song = random.choice(song_list)
    recom_new_song_artist = list(df[df["song"].str.contains(recom_new_song, case=False)]["artist"].values)
    
    print("------------")    
    print(f"You might also like '{recom_new_song}' by {recom_new_song_artist}.")

result()