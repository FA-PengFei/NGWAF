from datetime import datetime
from urllib.parse import urlparse

# from Knowledge_Base import log, to_json
# from Knowledge_Base.enums.logs_enums import LogLevel


class HttpResponse(object):

    def __init__(self, request_id=None, content=None, headers=None, status_code=None, cookies=None, original=None,
                 is_redirect=None, response_url=None, from_server_id=None, to_ip=None, decision=None, time_stamp=None):
        self.original = original
        self.request_id = request_id
        self.content = content
        self.headers = headers
        self.status_code = status_code
        self.cookies = cookies
        self.is_redirect = is_redirect
        self.response_url = response_url
        self.from_server_id = from_server_id
        self.to_ip = to_ip
        self.decision = decision
        self.time_stamp = time_stamp


class HttpRequest(object):

    def __init__(self, method=None, content=None, headers=None, path=None,
                 host_name=None, to_server_id=None, from_ip=None, decision=None, time_stamp=None):
        self.method = method
        self.content = content
        self.headers = headers
        self.path = path
        self.host_name = host_name
        self.from_ip = from_ip
        self.to_server_id = to_server_id
        self.decision = decision
        self.time_stamp = time_stamp
        self.text = None
        self.form = None
        self.args = None


class Parser(object):

    def parse(self, data_to_parse):
        """
        This method will parse the data.
        :data: the request / response
        :method: the request / response method (e.g GET)
        :data_type: Enum of DataType to identify.
        :return: ORM HttpRequest/HttpResponse Object
        """
        raise NotImplementedError()


class BaseHTTPRequestParser(Parser):

    def parse(self, data_to_parse):
        parsed_data = HttpRequest()
        parsed_data.method = "{}".format(data_to_parse.command).upper()
        content_length = int(data_to_parse.headers.get('Content-Length', 0))
        parsed_data.content = data_to_parse.rfile.read(content_length)
        parsed_data.headers = data_to_parse.headers
        parsed_data.query = '{uri.query}'.format(uri=urlparse(data_to_parse.path))
        parsed_data.path = '{uri.path}'.format(uri=urlparse(data_to_parse.path))
        parsed_data.host_name = '{uri.netloc}'.format(uri=urlparse(
            "https://{}".format(data_to_parse.headers.get('HOST').replace("http://", "").replace("https://", ""))))
        parsed_data.from_ip = data_to_parse.client_address[0]
        parsed_data.time_stamp = data_to_parse.log_date_time_string()
        return parsed_data


class HTTPResponseParser(Parser):

    def __init__(self, request):
        """
        :param request: The original request
        """
        self.__request = request

    def parse(self, data_to_parse, is_user_protection=False):
        parsed_data = HttpResponse()
        parsed_data.original = data_to_parse
        parsed_data.text = data_to_parse.text
        parsed_data.content = data_to_parse.text
        parsed_data.headers = data_to_parse.headers
        parsed_data.status_code = data_to_parse.status_code
        parsed_data.cookies = data_to_parse.cookies
        parsed_data.is_redirect = data_to_parse.is_redirect
        parsed_data.response_url = data_to_parse.url
        parsed_data.time_stamp = datetime.now()
        if not is_user_protection:
            parsed_data.from_server_id = self.__request.to_server_id
            parsed_data.to_ip = self.__request.from_ip
            parsed_data.from_dns_name = self.__request.host_name
        # log("The Parsed data is: {}".format(to_json(parsed_data)), LogLevel.DEBUG, self.parse)
        # log("Finish parsing the request.", LogLevel.INFO, self.parse)
        return parsed_data


class FlaskHTTPRequestParser(Parser):

    def parse(self, data_to_parse):
        parsed_data = HttpRequest()
        # log("Parse the url {}".format(data_to_parse.url), LogLevel.DEBUG, self.parse)
        url = urlparse(data_to_parse.url)
        # log("The Parsed url is: {}".format(url), LogLevel.DEBUG, self.parse)
        parsed_data.method = "{}".format(data_to_parse.method).upper()
        parsed_data.content = data_to_parse.get_data()
        parsed_data.headers = data_to_parse.headers
        parsed_data.query = '{uri.query}'.format(uri=url)
        parsed_data.path = '{uri.path}'.format(uri=url)
        parsed_data.host_name = '{uri.netloc}'.format(uri=url)
        parsed_data.from_ip = data_to_parse.remote_addr
        parsed_data.time_stamp = datetime.now()
        parsed_data.args = data_to_parse.args
        parsed_data.form = data_to_parse.form
        # log("The Parsed data is: {}".format(to_json(parsed_data)), LogLevel.DEBUG, self.parse)
        # log("Finish parsing the request.", LogLevel.INFO, self.parse)
        return parsed_data
