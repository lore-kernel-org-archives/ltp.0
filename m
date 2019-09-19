From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Sep 2019 16:09:31 +0200
Subject: [LTP] [PATCH v2] cgroup_regression_test.sh: Remove obselte
 test_5
In-Reply-To: <1568889488-4032-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190919094544.GA21345@rei>
 <1568889488-4032-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190919140931.GA14614@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> test_5 is a very old regresstion test and kernel code has been
> rewritten completely since 2.6. No user will use such old kernel
> code to test. So I think we can remove it.

> Also rename test10 as test5, modify TST_CNT.

Merged, with additional note, why it's safe to remove it:

    [ pvorel: test_5 is testing 839ec5452ebf ("cgroup: fix root_count when
    mount fails due to busy subsystem") from v2.6.29-rc4 which fixes
    e5f6a8609bab ("cgroups: make root_list contains active hierarchies
    only") from v2.6.24-rc1. While there are still people testing LTP on
    2.6.x, nobody should be using -rc version now. ]

Kind regards,
Petr
