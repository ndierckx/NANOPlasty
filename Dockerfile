# 1. Base image
FROM ubuntu:24.04

# 2. Metadata
LABEL maintainer="ndierckx@github" \
      version="1.0" \
      description="NANOPlasty: BLAST+ • kalign3 • Perl MCE & Parallel::ForkManager"

# 3. Environment
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    PATH=/usr/local/bin:/usr/bin:$PATH

# 4. Install system packages & Perl deps
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ncbi-blast+ \
      kalign \
      cpanminus \
      libparallel-forkmanager-perl \
      libmce-perl \
      build-essential \
      curl && \
    cpanm --notest MCE Parallel::ForkManager && \
    rm -rf /var/lib/apt/lists/*

# 5. Copy your code in
COPY . /opt/nanoplasty

# 6. Make scripts executable
RUN chmod -R +x /opt/nanoplasty

# 7. Set working dir
WORKDIR /opt/nanoplasty

ENV PATH=/opt/nanoplasty:$PATH

# 8. Default entrypoint
ENTRYPOINT ["perl", "NANOPlasty0.4.pl"]
