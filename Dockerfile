FROM python:latest
ADD . /
RUN pip install -r requirements.txt
CMD python main.py