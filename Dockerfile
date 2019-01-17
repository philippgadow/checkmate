FROM rootproject/root-cc7
MAINTAINER Philipp Gadow <paul.philipp.gadow@cern.ch>

RUN yum -y install scipy wget

# install BOOST libraries
RUN wget https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.gz
RUN mkdir /boost && tar xvf boost_1_61_0.tar.gz -C /boost --strip-components 1
WORKDIR /boost
RUN source /boost/bootstrap.sh && /boost/b2 && /boost/b2 install

ENV DELPHES_VER 3.4.0
ENV LHAPDF_VER 6.1.6
ENV MG5_VER 2.5.5
ENV PYTHIA_VER 8230
ENV CHECKMATE_VER 2.0.26

# install delphes
WORKDIR /
RUN wget http://cp3.irmp.ucl.ac.be/downloads/Delphes-${DELPHES_VER}.tar.gz
RUN mkdir /delphes && tar -xzf Delphes-${DELPHES_VER}.tar.gz -C /delphes --strip-components 1
WORKDIR /delphes
RUN source /usr/local/bin/thisroot.sh
RUN ./configure
RUN make -j8

# install lhapdf6
WORKDIR /
RUN wget https://lhapdf.hepforge.org/downloads/LHAPDF-${LHAPDF_VER}.tar.gz
RUN mkdir /lhapdf6 && tar -xzf /LHAPDF-${LHAPDF_VER}.tar.gz -C /lhapdf6 --strip-components 1
WORKDIR /lhapdf6
RUN ./configure
RUN make -j8 && make install

# install pythia
WORKDIR /
RUN wget http://home.thep.lu.se/~torbjorn/pythia8/pythia${PYTHIA_VER}.tgz
RUN tar -xzf pythia${PYTHIA_VER}.tgz
WORKDIR pythia${PYTHIA_VER}
RUN mkdir /pythia
RUN ./configure --prefix=/pythia
RUN make -j8
RUN make install
RUN rm -r /pythia${PYTHIA_VER}

# install madgraph
WORKDIR /
RUN wget --no-check-certificate https://launchpad.net/mg5amcnlo/2.0/2.5.x/+download/MG5_aMC_v${MG5_VER}.tar.gz
RUN mkdir /madgraph && tar -xzf MG5_aMC_v${MG5_VER}.tar.gz -C /madgraph --strip-components 1

# install checkmate
WORKDIR /
RUN wget --no-check-certificate http://www.hepforge.org/archive/checkmate/CheckMATE-${CHECKMATE_VER}.tar.gz
RUN mkdir /checkmate && tar -xzf CheckMATE-${CHECKMATE_VER}.tar.gz -C /checkmate --strip-components 1

WORKDIR /checkmate
RUN ./configure --with-python=/usr/bin/python \
                --with-pythia=/pythia \
                --with-delphes=/delphes \
                --with-rootsys=/usr/local \
                --with-madgraph=/madgraph
RUN make -j8
RUN make AnalysisManager

# add workdir
ADD ./work /code

# clean up
WORKDIR /
RUN rm *.tar.gz *.tgz
CMD /bin/bash
