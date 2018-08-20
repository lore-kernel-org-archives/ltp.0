From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Aug 2018 11:12:55 +0200
Subject: [LTP] [PATCH v5] Testing statx syscall
In-Reply-To: <20180820083629.GB14682@dell5510>
References: <20180817055702.2731-1-vaishnavi.d@zilogic.com>
 <20180820083629.GB14682@dell5510>
Message-ID: <20180820091255.GA20974@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +AC_CHECK_FUNCS(statx,,)
> > +])
> > +AC_CHECK_MEMBERS([struct statx.stx_mask, struct statx.stx_blksize, struct statx.stx_attributes, struct statx.stx_nlink, struct statx.stx_uid, struct statx.stx_gid, struct statx.stx_mode, struct statx.stx_ino, struct statx.stx_size, struct statx.stx_blocks, struct statx.stx_attributes_mask, struct statx.stx_rdev_minor, struct statx.stx_mtime, struct statx.stx_atime, struct statx.stx_btime, struct statx.stx_ctime, struct statx.stx_rdev_major, struct statx.stx_dev_major, struct statx.stx_dev_minor])
> > +
> > +AC_CHECK_MEMBERS([struct statx_timestamp tv_sec, struct statx_timestamp tv_nsec])

> There is error in definition (end of function before AC_CHECK_MEMBERS calls +
> missing dot in second AC_CHECK_MEMBERS). Diff with fixes:

> diff --git a/configure.ac b/configure.ac
> index df64ce2e2..e1ecb32a7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -200,6 +200,7 @@ LTP_CHECK_OPENAT
>  LTP_CHECK_EXECVEAT
>  LTP_CHECK_RENAMEAT
>  LTP_CHECK_RENAMEAT2
> +LTP_CHECK_STATX
>  LTP_CHECK_FALLOCATE
>  LTP_CHECK_SYSCALL_FCNTL
>  LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
> diff --git a/m4/ltp-statx.m4 b/m4/ltp-statx.m4
> index 547172ebc..dec161567 100644
> --- a/m4/ltp-statx.m4
> +++ b/m4/ltp-statx.m4
> @@ -22,7 +22,7 @@ dnl ----------------------------
>  dnl
>  AC_DEFUN([LTP_CHECK_STATX],[
>  AC_CHECK_FUNCS(statx,,)
> -])
>  AC_CHECK_MEMBERS([struct statx.stx_mask, struct statx.stx_blksize, struct statx.stx_attributes, struct statx.stx_nlink, struct statx.stx_uid, struct statx.stx_gid, struct statx.stx_mode, struct statx.stx_ino, struct statx.stx_size, struct statx.stx_blocks, struct statx.stx_attributes_mask, struct statx.stx_rdev_minor, struct statx.stx_mtime, struct statx.stx_atime, struct statx.stx_btime, struct statx.stx_ctime, struct statx.stx_rdev_major, struct statx.stx_dev_major, struct statx.stx_dev_minor])

> -AC_CHECK_MEMBERS([struct statx_timestamp tv_sec, struct statx_timestamp tv_nsec])
> +AC_CHECK_MEMBERS([struct statx_timestamp.tv_sec, struct statx_timestamp.tv_nsec])
> +])

Actually, #include <linux/stat.h> is required for AC_CHECK_MEMBERS:
AC_CHECK_MEMBERS([struct statx.stx_mask, struct statx.stx_blksize, struct statx.stx_attributes, struct statx.stx_nlink, struct statx.stx_uid, struct statx.stx_gid, struct statx.stx_mode, struct statx.stx_ino, struct statx.stx_size, struct statx.stx_blocks, struct statx.stx_attributes_mask, struct statx.stx_rdev_minor, struct statx.stx_mtime, struct statx.stx_atime, struct statx.stx_btime, struct statx.stx_ctime, struct statx.stx_rdev_major, struct statx.stx_dev_major, struct statx.stx_dev_minor],,, [[#include <linux/stat.h>]])
AC_CHECK_MEMBERS([struct statx_timestamp.tv_sec, struct statx_timestamp.tv_nsec],,, [[#include <linux/stat.h>]])
+])

BTW: not sure if all struct members need to be checked for.


Kind regards,
Petr
