"""
Pseudocode to gather Twitter data feed as json objects.
"""


class TwitterCrawler:
    def __init__(self):
        self.api = self.initialize_twitter_api()

    def crawl(self, limit: int):
        # check if user is authorized to access data feed
        authorization = check_authorization(self.api)
        if not authorization:
            return "Unauthorized access."

        # get data feed
        data_feeds = []
        feeds_count = 0
        while feeds_count < limit:
            data_feed = retrieve_data_feed(self.api)
            data_feeds.append(data_feed)
            feeds_count += 1

        return data_feeds

    def initialize_twitter_api(self):
        # code to initialize Twitter API
        ...
        return api


def check_authorization(api):
    # code to check if user is authorized to access data feed
    ...
    return authorization or None


def retrieve_data_feed(api):
    # code to retrieve data feed
    ...
    return data_feed_json_object
