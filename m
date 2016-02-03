From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Feb 2016 15:14:02 +0100
Subject: [LTP] [PATCH V2 02/32] Add knob to control whether numa support
 should be checked
In-Reply-To: <1452302060-103643-2-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-2-git-send-email-raj.khem@gmail.com>
Message-ID: <20160203141402.GF30788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> signed-off-by: Roy.Li <rongqing.li@windriver.com>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  m4/ltp-numa.m4 | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
> index 60ae07b..ed7078d 100644
> --- a/m4/ltp-numa.m4
> +++ b/m4/ltp-numa.m4
> @@ -24,7 +24,13 @@ dnl ----------------------------
>  dnl
>  AC_DEFUN([LTP_CHECK_SYSCALL_NUMA],
>  [dnl
> -AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
> +AC_MSG_CHECKING([for numa])

This causes the output messages to be interleaved when configure is
executed without the --without-numa parameter.

> +AC_ARG_WITH(
> +	[numa],
> +	AC_HELP_STRING([--without-numa],
> +	[without numa support]),
> +	[],
> +	[AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
>  	LTP_SYSCALL_NUMA_HEADERS=yes
>  	AC_CHECK_LIB(numa,numa_alloc_onnode,[have_numa_alloc_onnode="yes"])
>  	if  test "x$have_numa_alloc_onnode" = "xyes"; then
> @@ -48,3 +54,5 @@ if test "x$have_mpol_constants" = "xyes"; then
>  	AC_DEFINE(HAVE_MPOL_CONSTANTS,1,[define to 1 if you have all constants required to use mbind tests])
>  fi
>  )])
> +AC_MSG_RESULT([$with_numa])

And this genereates empty line in that case.

> +])

If you want to print "Checking for numa... disabled" or something
similar in the output you should do it only in the case that the
--without-numa flag was passed.

-- 
Cyril Hrubis
chrubis@suse.cz
