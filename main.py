import json


def read_facebook_json():
    # load json object from file
    with open('facebook_data.json', 'r') as json_file:
        data = json.load(json_file)

    # open text file to write to
    with open('output.txt', 'w') as text_file:
        # write section headings
        text_file.write("Personal Information\n")
        text_file.write('\tname: ' + data['name'] + '\n')
        text_file.write('\tid: ' + data['id'] + '\n\n')

        text_file.write('Picture Data\n')
        text_file.write("\tH: " + str(data['picture']['data']['height']) + " W: "
                        + str(data['picture']['data']['width']) + '\n')
        text_file.write("\tpicture url: " + data['picture']['data']['url'] + '\n\n')

        # write contact information
        text_file.write('Contact Information\n')
        text_file.write('\tEmail: ' + data['email'] + '\n\n')

        # write location
        text_file.write('Location\n')
        text_file.write('\tid: ' + data['location']['id'] + '\n')
        text_file.write('\tid: ' + data['location']['name'] + '\n\n')

        # write posts
        text_file.write("Posts\n")
        for post in data['posts']['data']:
            if 'message' in post:
                text_file.write('\tmessage: ' + post['message'] + '\n')
            else:
                text_file.write('\tmessage: none\n')
            text_file.write('\ttime created: ' + post['created_time'] + '\n')
            text_file.write('\tid: ' + post['id'] + '\n\n')
        text_file.write('\n')

        # write likes
        text_file.write("Likes\n")
        for like in data['likes']['data']:
            text_file.write('\tname: ' + like['name'] + '\n')
            text_file.write('\tid: ' + like['id'] + '\n')
            text_file.write('\tcreated time: ' + like['created_time'] + '\n')
        text_file.write('\n')

        # write groups
        text_file.write("Groups\n")
        for group in data['groups']['data']:
            text_file.write('\tname: ' + group['name'] + '\n')
            text_file.write('\tid: ' + group['id'] + '\n')
        text_file.write('\n')

    print("json parsed and written to output.txt")


if __name__ == '__main__':
    read_facebook_json()
