From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Jan 2016 23:24:11 +0100
Subject: [LTP] [PATCH 2/3] Add knob to control whether numa support
 should be checked
In-Reply-To: <1452188804-8959-2-git-send-email-raj.khem@gmail.com>
References: <1452188804-8959-1-git-send-email-raj.khem@gmail.com>
 <1452188804-8959-2-git-send-email-raj.khem@gmail.com>
Message-ID: <20160107222410.GB14431@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +AC_ARG_WITH([numa],
> +  AC_HELP_STRING([--without-numa],
> +    [without the numa support]),
> +  [],[with_numa=yes],
> +)
> +
>  AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2])
>  
>  # END testsuites knobs
> @@ -145,7 +151,9 @@ LTP_CHECK_SELINUX
>  LTP_CHECK_SIGNAL
>  LTP_CHECK_SYSCALL_EVENTFD
>  LTP_CHECK_SYSCALL_MODIFY_LDT
> +if test "x$with_numa" = xyes; then
>  LTP_CHECK_SYSCALL_NUMA
> +fi
>  LTP_CHECK_SYSCALL_QUOTACTL
>  LTP_CHECK_SYSCALL_SIGNALFD
>  LTP_CHECK_SYSCALL_UNSHARE

This is way to ugly. You should add the AC_ARG_WITH() to the
corresponding m4/ltp-numa.m4 file instead.


-- 
Cyril Hrubis
chrubis@suse.cz
