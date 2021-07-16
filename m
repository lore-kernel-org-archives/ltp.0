From: Boyang Xue <bxue@redhat.com>
Date: Fri, 16 Jul 2021 14:13:38 +0800
Subject: [LTP] [question] tst_rhost_run.sh not installed
Message-ID: <CAHLe9YYCDFxqoaciAcz4Ec9bU7cQPJM9SDL2_4ygjcaWx967-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm trying to build, install and run LTP like this:
```
git clone https://github.com/linux-test-project/ltp.git repo_ltp
pushd repo_ltp/
make autotools
./configure
make
make install
# export RHOST, LHOST, etc. test vars
export LTPROOT=/opt/ltp; export PATH=$LTPROOT/bin:$LTPROOT/testcases/bin:$PATH
./runltp -d /test -f net.nfs
```

During the test run, it complains that
```
/opt/ltp/testcases/bin/tst_net.sh: line 979: bash:: command not found
```
line#979 is:
```
eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST || echo "exit $?")
```

I can find tst_net_iface_prefix in the $PATH, so it should be
tst_rhost_run which leads to the error.
Searching for tst_rhost_run in /opt/ltp and $PATH shows not found, so
is it a bug or did I miss something that the file wasn't installed?

It happens on the latest LTP:
```
# git rev-parse --short HEAD
5d8f9dfd6
```

Thanks,
Boyang

