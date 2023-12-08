FROM nvcr.io/nvidia/pytorch:23.11-py3

WORKDIR /vfcfinder
COPY . .
RUN useradd -ms /bin/bash user
RUN chown -R user:user /vfcfinder
RUN apt update -y && apt install -y python3.10-venv
USER user
RUN python3 -m venv .venv && source .venv/bin/activate && pip install .

# README.md EXAMPLE
RUN curl https://raw.githubusercontent.com/github/advisory-database/main/advisories/github-reviewed/2022/08/GHSA-v65g-f3cj-fjp4/GHSA-v65g-f3cj-fjp4.json -o GHSA-v65g-f3cj-fjp4.json
RUN mkdir ./clones/
RUN source .venv/bin/activate && vfcfinder --advisory_path ./GHSA-v65g-f3cj-fjp4.json --clone_path ./clones/ --output_path ./ranked_commits_GHSA-v65g-f3cj-fjp4.csv