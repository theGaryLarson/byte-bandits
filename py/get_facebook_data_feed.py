"""
Pseudocode to crawl facebook and gather data feed json objects
"""


class FacebookCrawler:
    def __init__(self):
        self.api = self.initialize_facebook_api()

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

    def initialize_facebook_api(self):
        # code to initialize Facebook API
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

