import sqlalchemy as db
from sqlalchemy import Column, String, DateTime
from datetime import datetime, timedelta
# https://auth0.com/blog/sqlalchemy-orm-tutorial-for-python-developers/
import os

from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()
# class TrainingJob(Base):
#     __tablename__ = 'training_jobs'
   
#     job_id = Column(String(256), primary_key=True)
#     date_created = Column(DateTime)

class WafConfig(Base):
    __tablename__ = 'waf_config'
   
    config_name = Column(String(256), primary_key=True)
    config_value = Column(String(256))

    # date_created = Column(DateTime)

def test_connection():
    try:
        connect()
        return True
    except:
        False

def connect():
    username = os.environ['SQL_USERNAME']
    password = os.environ['SQL_PASSWORD']
    sqlserver = os.environ['SQL_SERVER']
    database_name = os.environ['SQL_DATABASE_NAME']
    engine = db.create_engine(f"mysql://{username}:{password}@{sqlserver}:3306/{database_name}")
    # connection = engine.connect()
    # meta = db.MetaData()
    # Check if current table has data
    # init(meta, connection)
    Base.metadata.create_all(engine)
    return engine

from sqlalchemy.orm import sessionmaker

# async def store_job_id(job_id):
#     engine = connect()
#     Session = sessionmaker(bind = engine)
#     session = Session()
#     session.add(TrainingJob(job_id=job_id, date_created=datetime.now()))
#     session.commit()
#     session.close()

# async def fetch_job_ids():
#     engine = connect()
#     Session = sessionmaker(bind = engine)
#     session = Session()
#     # Fetch only jobs that have been created in the past 30 mins as the jobs will be terminated past 30 mins
#     # jobs = session.query(TrainingJob).filter(TrainingJob.date_created >= (datetime.now() - timedelta(minutes=30))).all()
#     jobs = session.query(TrainingJob).all()
#     job_ids = []
#     for job in jobs:
#         job_ids.append(job.job_id)

#     session.close()

#     return job_ids

async def store_config_value(config_name, config_value):
    engine = connect()
    Session = sessionmaker(bind = engine)
    session = Session()
    # Add or Update depending if object is present

    # Ideally should have only one such result
    query_config = session.query(WafConfig).filter(WafConfig.config_name == config_name).all()

    if len(query_config) > 0:
        for c in query_config:
            c.config_value = config_value
        # session.execute(update(WafConfig).where(WafConfig.config_name == config_name).values(config_value=config_value))
    else:
        session.add(WafConfig(config_name=config_name, config_value=config_value))
    session.commit()
    session.close()

async def fetch_config_value(config_name):
    engine = connect()
    Session = sessionmaker(bind = engine)
    session = Session()
    config_values = session.query(WafConfig).filter(WafConfig.config_name == config_name).all()
    session.close()

    if len(config_values) > 0:
        return {config_name: config_values[0].config_value}
    else:
        return None

async def fetch_all_config():
    engine = connect()
    Session = sessionmaker(bind = engine)
    session = Session()
    configs = session.query(WafConfig).all()
    session.close()

    config_obj = {}
    for config in configs:
        config_obj[config.config_name] = config.config_value

    return config_obj