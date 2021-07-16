From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 16 Jul 2021 08:43:03 +0200
Subject: [LTP] [question] tst_rhost_run.sh not installed
In-Reply-To: <CAHLe9YYCDFxqoaciAcz4Ec9bU7cQPJM9SDL2_4ygjcaWx967-A@mail.gmail.com>
References: <CAHLe9YYCDFxqoaciAcz4Ec9bU7cQPJM9SDL2_4ygjcaWx967-A@mail.gmail.com>
Message-ID: <48573d84-20e4-11a1-6306-d82b6ada6efd@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Sorry for the duplicate, I forgot to add the mailing list...

On 7/16/2021 8:13 AM, Boyang Xue wrote:
> Hi,
>
> I'm trying to build, install and run LTP like this:
> ```
> git clone https://github.com/linux-test-project/ltp.git repo_ltp
> pushd repo_ltp/
> make autotools
> ./configure
> make
> make install
> # export RHOST, LHOST, etc. test vars
> export LTPROOT=/opt/ltp; export PATH=$LTPROOT/bin:$LTPROOT/testcases/bin:$PATH
> ./runltp -d /test -f net.nfs
> ```
>
> During the test run, it complains that
> ```
> /opt/ltp/testcases/bin/tst_net.sh: line 979: bash:: command not found
> ```
> line#979 is:
> ```
> eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST || echo "exit $?")
> ```
>
> I can find tst_net_iface_prefix in the $PATH, so it should be
> tst_rhost_run which leads to the error.
> Searching for tst_rhost_run in /opt/ltp and $PATH shows not found, so
> is it a bug or did I miss something that the file wasn't installed?
No tst_rhost_run is a shell function defined in tst_net.sh.
I guess the problem is your RHOST setup.
LTP supports two setups for network tests:
1. network namespace based. This is used if you don't set RHOST and LHOST.
2. Two-host setup, where RHOST points to a second host.

The important thing in two host setup is, that $LTP_ROOT/testcases/bin 
is in the PATH for the user, that is used on the RHOST.
I guess what happens in your setup is that tst_net_iface_prefix is not 
found on the RHOST, because it is not in the path.

Joerg
