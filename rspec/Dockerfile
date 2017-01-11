FROM centos:6.6
MAINTAINER Luca De Vitis <luca.devitis at moneysupermarket.com>
RUN yum --assumeyes install nc tar xz zlib-devel openssl-devel                          && \
    yum --assumeyes groupinstall "Development Tools"                                    && \
    curl --remote-name http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz          && \
    tar --extract --gzip --file ruby-2.1.5.tar.gz                                       && \
    pushd ruby-2.1.5                                                                    && \
        ./configure --prefix=/usr                                                       && \
        make                                                                            && \
        make install                                                                    && \
    popd                                                                                && \
    rm --recursive --force ruby-2.1.5                                                   && \
    curl --remote-name http://production.cf.rubygems.org/rubygems/rubygems-1.8.25.tgz   && \
    tar --extract --gzip --file rubygems-1.8.25.tgz                                     && \
    pushd rubygems-1.8.25                                                               && \
        ruby setup.rb config                                                            && \
        ruby setup.rb setup                                                             && \
        ruby setup.rb install                                                           && \
    popd                                                                                && \
    rm --recursive --force "rubygems-1.8.25"                                            && \
    gem install puppet --no-rdoc --no-ri --version 3.7.4                                && \
    gem install facter --no-rdoc --no-ri --version 2.4.6                                && \
    gem install hiera  --no-rdoc --no-ri --version 3.0.6
