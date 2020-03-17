From: Enji Cooper <yaneurabeya@gmail.com>
Date: Tue, 17 Mar 2020 04:26:22 -0700
Subject: [LTP] [PATCH] open_posix_testsuite: Enable the testsuite
In-Reply-To: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
References: <1584430400-47359-1-git-send-email-zou_wei@huawei.com>
Message-ID: <21681327-BC61-4A15-8980-AA1A6402C863@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NAK.

This will build the suite on the build host, which includes a number of build time tests, which will slow down hosts and 

It?s better to flip the default in configure, but I think the build machinery needs to be reworked so runtime tests and build and installed and build time tests are just installed.

-Enji

> On Mar 17, 2020, at 00:27, Zou Wei <zou_wei@huawei.com> wrote:
> 
> ?Enable open posix testsuite compilation by default
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
> testcases/Makefile | 4 ----
> 1 file changed, 4 deletions(-)
> 
> diff --git a/testcases/Makefile b/testcases/Makefile
> index b04e630..ae1cafc 100644
> --- a/testcases/Makefile
> +++ b/testcases/Makefile
> @@ -30,10 +30,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
> #    run).
> FILTER_OUT_DIRS        := kdump
> 
> -ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)
> -FILTER_OUT_DIRS        += open_posix_testsuite
> -endif
> -
> ifneq ($(WITH_REALTIME_TESTSUITE),yes)
> FILTER_OUT_DIRS        += realtime
> endif
> --
> 2.6.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
