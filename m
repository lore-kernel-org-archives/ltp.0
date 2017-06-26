From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Jun 2017 12:46:36 +0200
Subject: [LTP] LTP Ipv6_lib failures
In-Reply-To: <CACUy5SPm3hZrx+1-+w5UFNvkKpF341cSfpjTUqy+LdtkNWaa1A@mail.gmail.com>
References: <CACUy5SN4anXf9wE+wCTjSHK5O6EXtTCTfL96tvJJHtcOS3KSBA@mail.gmail.com>
 <20170626084952.whrq5i6s3hdm3w4n@dell5510>
 <CACUy5SPm3hZrx+1-+w5UFNvkKpF341cSfpjTUqy+LdtkNWaa1A@mail.gmail.com>
Message-ID: <20170626104636.n22y6y7ieeent4qi@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ankit,

> Hi Petr,

> I couldn't try it with latest version.
> I used Yocto poky Distro version 1.8.1 to build my image.

> Is there some issue with LTP(20160126) version for ipv6_lib testsuite?


> Thanks & Regards,
> Ankit

Your log shows:
asapi_04   11  TBROK  :  safe_net.c:162: asapi_01.c:369: connect(7, 127.0.0.1:49266, 16) failed: errno=ENETUNREACH(101): Network is unreachable
Do you have correct settings? These commands should reveal it:
ping -c 2 $IPV4_NETWORK.$LHOST_IPV4_HOST
ping -c 2 $IPV4_NETWORK.$RHOST_IPV4_HOST
ping6 -c 2 $IPV6_NETWORK:$LHOST_IPV6_HOST
ping6 -c 2 $IPV6_NETWORK:$RHOST_IPV6_HOST

If ping works,could you please post the command you use for running tests? I'd also appreciate to know
environment variables (run: env) and kernel configuration (run: sysctl -a). This also
helps me to indicate whether you use RSH, SSH or network namespaces for testing.

For networking tests it's preferred to run $LTPROOT/testscripts/network.sh
There is some network related doc:
https://github.com/linux-test-project/ltp/tree/master/testcases/network#ltp-network-tests
https://github.com/linux-test-project/ltp/blob/master/INSTALL
https://github.com/linux-test-project/ltp/blob/master/doc/namespaces-helper-tools.txt

What a shame you cannot use poky Pyro 2.3, or compile newest LTP release.
Although source code in testcases/network/lib6/ haven't changed (except some minor
cleanup), there have been other fixes in LTP tree which may affect the test.

BTW Poky 1.8.1 is tagged as released in 2015-11-06 [1], but upgrade to 20160126 was done in
2016-02-12 [2]. Aren't you using version 1.8.2? (released 2016-05-27 [3])

[1] http://git.yoctoproject.org/cgit/cgit.cgi/poky/tag/?id=yocto-1.8.1
[2] http://git.yoctoproject.org/cgit/cgit.cgi/poky/commit/?id=b5b8003a0b99fb591f2e2a0a5ed74e60a120dc87
[3] http://git.yoctoproject.org/cgit/cgit.cgi/poky/tag/?id=yocto-1.8.2


Kind regards,
Petr
