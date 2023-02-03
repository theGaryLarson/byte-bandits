import json

"""
Pseudocode to write the datafeeds from each social media platform to file
"""


def write_to_file(self, data_feeds, filename):
    with open(filename, "w") as file:
        for feed in data_feeds:
            file.write(json.dumps(feed) + "\n")