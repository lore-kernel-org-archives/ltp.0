From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 09:21:18 +0100
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <46954cdf-042b-fffd-583d-b1494d7747dd@cn.fujitsu.com>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510> <20191120151610.GB28197@dell5510>
 <efb495a4-1071-68fd-d5a2-7597646228e1@cn.fujitsu.com>
 <20191121051022.GA59487@x230>
 <46954cdf-042b-fffd-583d-b1494d7747dd@cn.fujitsu.com>
Message-ID: <20191121082118.GA14920@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Yes. I check <sys/quota.h> and <sys/prctl.h> on musl libc[1] and they don't include linux header files.
> So I think checking both kernel and libc headers on other libc(musl,bionic) is meaningful.
But in single C file we decide only on one of these two.
It's a similar problem as testing raw syscall or libc wrapper (which we already
solved with .test_variants).
NOTE: Bionic has generate it's headers from linux headers.

> ps: If our travis-ci has a target with musl, I think it will be better. I don't know whether possible.
It's here. But it requires some more fixes (in a meantime files are deleted),
so I'll post it once it's everything fixed
https://github.com/pevik/ltp/commits/travis/musl
https://travis-ci.org/pevik/ltp/builds/614575796

There is also CI on LTP on all glibc/uclibc-ng/musl in Buildroot
http://autobuild.buildroot.net/index.php?reason=ltp-testsuite-20190930

+ There are other CI based on yocto/openembedded on glibc/uclibc-ng/musl

> [1]http://git.musl-libc.org/cgit/musl/tree/include/sys/quota.h

Kind regards,
Petr
