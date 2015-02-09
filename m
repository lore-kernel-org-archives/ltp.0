Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YKp2e-0002KA-VZ
	for ltp-list@lists.sourceforge.net; Mon, 09 Feb 2015 14:10:24 +0000
Date: Mon, 9 Feb 2015 15:10:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150209141006.GA7605@rei.suse.de>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1423212090-24164-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1423212090-24164-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/6] power_management: compile and install
 testcases/kernel/power_management by default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -# testcases/kernel/power_management requires python.
> -if test "x$with_python" = xyes; then
> -    AC_ARG_WITH([power-management-testsuite],
> -      [AC_HELP_STRING([--with-power-management-testsuite],
> -        [compile and install the x86 power management testsuite (default=no)])],
> -      [with_power_management_testsuite=yes],
> -    )
> -fi
> -if test "x$with_power_management_testsuite" = xyes; then
> -    AC_SUBST([WITH_POWER_MANAGEMENT_TESTSUITE],["yes"])
> -else
> -    AC_SUBST([WITH_POWER_MANAGEMENT_TESTSUITE],["no"])
> -fi

Well, it's true that the testsuite needs python, so technically this is
correct but I agree that this is not the best way to do that.

The question is, does the testsuite need python in compile or install
phase? If not we can safely remove this and change it to runtime check.

>  AC_ARG_WITH([open-posix-testsuite],
>    [AC_HELP_STRING([--with-open-posix-testsuite],
>      [compile and install the open posix testsuite (default=no)])],
> diff --git a/include/mk/features.mk.default b/include/mk/features.mk.default
> index c9edc1c..69425ca 100644
> --- a/include/mk/features.mk.default
> +++ b/include/mk/features.mk.default
> @@ -34,13 +34,6 @@ HAVE_SECUREBITS			:= no
>  
>  # Test suite knobs
>  
> -# Enable testcases/kernel/power_management's compile and install?
> -ifeq ($(UCLINUX),1)
> -WITH_POWER_MANAGEMENT_TESTSUITE	:= no
> -else
> -WITH_POWER_MANAGEMENT_TESTSUITE	:=
> -endif

What is wrong with these configure knobs?

I think that this is far better than the runtime test you introduced in
later patches.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
