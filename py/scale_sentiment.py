"""
Pseudocode for scaling intensity on the Likert scale
    Set up a Google Cloud Platform account and create a project
    Enable the Google Cloud Natural Language API for the project
    Install the Google Cloud Client Library for Python
    Import the required libraries in your code (e.g. google.cloud, google.cloud.language)
    Set up authentication to access your Google Cloud account (e.g. using a service account key file)
    Use the LanguageClient class to create a client object
    Call the analyze_sentiment method on the client object, passing in the text you want to analyze
    The method returns a Sentiment object that includes the overall sentiment score and magnitude
    Scale the sentiment score on a scale of 1 to 10, with 1 being strongly opposed, 10 being strongly for, and 5 being
    indifferent.
"""

"""
    !!PSEUDOCODE!! Is not intended to run/does NOT run.
"""
    from google.cloud import language
    from google.cloud.language import enums
    from google.cloud.language import types


# Create a client object
    client = language.LanguageServiceClient()

# Define the text to analyze
    text = "Soylent Green is made out of people"

# Call the analyze_sentiment method
    document = types.Document(content=text, type=enums.Document.Type.PLAIN_TEXT)
    sentimentToIntensity = client.analyze_sentiment(document=document).document_sentiment

# Scale the sentiment score on a scale of 1 to 10. Googles scale is 0 to 1.
    scale = (sentimentToIntensity.score * 9) + 1

# Print the scaled sentiment score
    print("Sentiment score (1-10):", scale)
"""
    Code would run pre-processing by another team and replace json
    intensity text with a Likert scale representation
"""