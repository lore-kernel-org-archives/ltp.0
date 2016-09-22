From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Sep 2016 16:27:45 +0200
Subject: [LTP] [PATCH v2] syscalls/fanotify*: Cleanup
In-Reply-To: <1466044235-27952-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160517121121.GB12051@rei.lan>
 <1466044235-27952-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160922142745.GB10292@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/configure.ac b/configure.ac
> index e0e9c1b..548bc3a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -43,7 +43,6 @@ AC_CHECK_HEADERS([ \
>      linux/netlink.h \
>      sys/epoll.h \
>      sys/inotify.h \
> -    sys/fanotify.h \
>      sys/jfsdmapi.h \
>      sys/prctl.h \
>  ])
> @@ -188,5 +187,6 @@ LTP_CHECK_PWRITEV
>  LTP_CHECK_EPOLL_PWAIT
>  LTP_CHECK_KEYUTILS_SUPPORT
>  LTP_CHECK_SYNC_ADD_AND_FETCH
> +LTP_CHECK_FANOTIFY
>  
>  AC_OUTPUT
> diff --git a/m4/ltp-fanotify.m4 b/m4/ltp-fanotify.m4
> new file mode 100644
> index 0000000..f9e26a0
> --- /dev/null
> +++ b/m4/ltp-fanotify.m4
> @@ -0,0 +1,22 @@
> +dnl
> +dnl Copyright (c) 2016 Fujitsu Ltd.
> +dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +dnl
> +dnl This program is free software; you can redistribute it and/or modify it
> +dnl under the terms of version 2 of the GNU General Public License as
> +dnl published by the Free Software Foundation.
> +dnl
> +dnl This program is distributed in the hope that it would be useful, but
> +dnl WITHOUT ANY WARRANTY; without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl alone with this program.
> +dnl
> +dnl
> +dnl LTP_CHECK_FANOTIFY
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_FANOTIFY],[
> +AC_CHECK_HEADERS([sys/fanotify.h linux/fanotify.h])
> +])

No need to start a new m4 file just for one more hader, it's much easier
just to add the linux/fanotify.h into the AC_CHECK_HEADERS().

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> deleted file mode 100644
> index 518d05e..0000000
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -/*
> - * fanotify testcase common definitions.
> - *
> - * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Jan Kara, November 2013
> - */
> -
> -#ifndef	__FANOTIFY_H__
> -#define	__FANOTIFY_H__
> -
> -#include "config.h"
> -
> -#if defined(HAVE_SYS_FANOTIFY_H)
> -
> -#include <sys/fanotify.h>
> -
> -#else /* HAVE_SYS_FANOTIFY_H */
> -
> -/* fanotify(7) wrappers */
> -
> -#include <stdint.h>
> -#include "linux_syscall_numbers.h"
> -
> -static int fanotify_init(unsigned int flags, unsigned int event_f_flags)
> -{
> -	return syscall(__NR_fanotify_init, flags, event_f_flags);
> -}
> -
> -static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
> -                     int dfd, const char *pathname)
> -{
> -	return syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
> -}
> -
> -#endif /* HAVE_SYS_FANOTIFY_H */
> -
> -#endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> index fb0f6eb..e8c3c1d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -36,15 +36,14 @@
>  #include <string.h>
>  #include <sys/syscall.h>
>  #include "test.h"
> -#include "linux_syscall_numbers.h"
> -#include "fanotify.h"
>  #include "safe_macros.h"
>  
>  char *TCID = "fanotify01";
>  int TST_TOTAL = 12;
>  
> -#if defined(HAVE_SYS_FANOTIFY_H)
> +#if defined(HAVE_SYS_FANOTIFY_H) && defined(HAVE_LINUX_FANOTIFY_H)
>  #include <sys/fanotify.h>
> +#include <linux/fanotify.h>

This is not correct either.

The reasoning should be:

* If sys/fanotify.h is present, just include it and be done with it
  (as this defines all that is needed)

* If linux/fanotify.h is present but sys/fanotify.h is missing
  include linux/fanotify.h + define fanotify_init() and fanotify_mark()
  wrappers

* If none of them is present, we either have to define the wrappers +
  fanotify constants and structures, or skip the test compilation and
  just report TCONF

Which is nearly what the fanotify.h in the test directory does. We just
have to include linux/fanotify.h there, if it's present and the
sys/fanotify.h is not present. And also strip the sys/fanotify.h include
from the testcases. Then we can let the testcase code compile if either
of the sys/fanotify.h or linux/fanotify.h is present:

#if defined(HAVE_SYS_FANOTIFY_H) || defined(HAVE_LINUX_FANOTIFY_H)

-- 
Cyril Hrubis
chrubis@suse.cz
