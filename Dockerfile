FROM python:3.11 as builder

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y git gcc python3 libxml2-dev libxslt-dev libc-dev

WORKDIR /cwltool
COPY . .
RUN CWLTOOL_USE_MYPYC=1 MYPYPATH=mypy-stubs pip wheel --no-binary schema-salad \
	--wheel-dir=/wheels .[deps]  # --verbose
RUN rm /wheels/schema_salad*
RUN pip install "black~=22.0"
# galaxy-util 22.1.2 depends on packaging<22, but black 23.x needs packaging>22
RUN SCHEMA_SALAD_USE_MYPYC=1 MYPYPATH=mypy-stubs pip wheel --no-binary schema-salad \
	$(grep schema.salad requirements.txt) "black~=22.0" --wheel-dir=/wheels  # --verbose
RUN pip install --force-reinstall --no-index --no-warn-script-location \
	--root=/pythonroot/ /wheels/*.whl
# --force-reinstall to install our new mypyc compiled schema-salad package

# FROM python:3.11 as module
# LABEL maintainer peter.amstutz@curii.com

# RUN apt-get install docker nodejs graphviz libxml2 libxslt
# COPY --from=builder /pythonroot/ /

FROM python:3.11
# LABEL maintainer peter.amstutz@curii.com
# Add the official Docker (apt-get) repository
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
	| gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	focal stable" \
	| tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update -y
RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
RUN apt install -y nodejs
RUN apt-get install -y graphviz libxml2 libxslt-dev
RUN apt-get install -y bash
COPY --from=builder /pythonroot/ /
COPY cwltool-in-docker.sh /cwltool-in-docker.sh

WORKDIR /error
