import logging

FORMAT = '%(message)s'
logging.basicConfig(filename='/waf/logs/waf.log', level=logging.DEBUG, format=FORMAT)

def log_debug(log_string):
    logging.info(log_string)

# Somehow this is logging everything, not sure why
def log_data(log_string):
    logging.debug(log_string)