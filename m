From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Aug 2018 10:36:30 +0200
Subject: [LTP] [PATCH v5] Testing statx syscall
In-Reply-To: <20180817055702.2731-1-vaishnavi.d@zilogic.com>
References: <20180817055702.2731-1-vaishnavi.d@zilogic.com>
Message-ID: <20180820083629.GB14682@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

Found more things. BTW from my point of view well done, it's a big patch.


> Signed-off-by: Tarun.T.U <tarun@zilogic.com>
> Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
> ---

> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
...
> +#ifndef STATX_H
> +#define STATX_H
Better would be LAPI_STAT_H or least STAT_H.

> +
> +#include <stdint.h>
> +#include "lapi/syscalls.h"
> +#include "tst_test.h"
You probably don't want to add tst_test.h to lapi file. It's meant to be used by
actual tests.

> +/*
> + * Timestamp structure for the timestamps in struct statx.
> + *
> + * tv_sec holds the number of seconds before (negative) or after (positive)
> + * 00:00:00 1st January 1970 UTC.
> + *
> + * tv_nsec holds a number of nanoseconds (0..999,999,999) after the tv_sec time.
> + *
> + * __reserved is held in case we need a yet finer resolution.
> + */
> +struct statx_timestamp {
> +	int64_t 	tv_sec;
> +	uint32_t	tv_nsec;
> +	int32_t __reserved;
> +};
You want to add this structure and other definitions only if not defined in
<sys/stat.h>. Something like:

#if !defined(HAVE_STRUCT_STATX_TIMESTAMP) ...
#include <sys/stat.h>
#else
struct statx_timestamp {
	int64_t 	tv_sec;
	uint32_t	tv_nsec;
	int32_t __reserved;
};
#fi

> +++ b/m4/ltp-statx.m4
...
> +AC_DEFUN([LTP_CHECK_STATX],[
You don't call LTP_CHECK_STATX function. It should be in configure.ac.
Without that HAVE_STATX is never defined.

> +AC_CHECK_FUNCS(statx,,)
> +])
> +AC_CHECK_MEMBERS([struct statx.stx_mask, struct statx.stx_blksize, struct statx.stx_attributes, struct statx.stx_nlink, struct statx.stx_uid, struct statx.stx_gid, struct statx.stx_mode, struct statx.stx_ino, struct statx.stx_size, struct statx.stx_blocks, struct statx.stx_attributes_mask, struct statx.stx_rdev_minor, struct statx.stx_mtime, struct statx.stx_atime, struct statx.stx_btime, struct statx.stx_ctime, struct statx.stx_rdev_major, struct statx.stx_dev_major, struct statx.stx_dev_minor])
> +
> +AC_CHECK_MEMBERS([struct statx_timestamp tv_sec, struct statx_timestamp tv_nsec])

There is error in definition (end of function before AC_CHECK_MEMBERS calls +
missing dot in second AC_CHECK_MEMBERS). Diff with fixes:

diff --git a/configure.ac b/configure.ac
index df64ce2e2..e1ecb32a7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -200,6 +200,7 @@ LTP_CHECK_OPENAT
 LTP_CHECK_EXECVEAT
 LTP_CHECK_RENAMEAT
 LTP_CHECK_RENAMEAT2
+LTP_CHECK_STATX
 LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
diff --git a/m4/ltp-statx.m4 b/m4/ltp-statx.m4
index 547172ebc..dec161567 100644
--- a/m4/ltp-statx.m4
+++ b/m4/ltp-statx.m4
@@ -22,7 +22,7 @@ dnl ----------------------------
 dnl
 AC_DEFUN([LTP_CHECK_STATX],[
 AC_CHECK_FUNCS(statx,,)
-])
 AC_CHECK_MEMBERS([struct statx.stx_mask, struct statx.stx_blksize, struct statx.stx_attributes, struct statx.stx_nlink, struct statx.stx_uid, struct statx.stx_gid, struct statx.stx_mode, struct statx.stx_ino, struct statx.stx_size, struct statx.stx_blocks, struct statx.stx_attributes_mask, struct statx.stx_rdev_minor, struct statx.stx_mtime, struct statx.stx_atime, struct statx.stx_btime, struct statx.stx_ctime, struct statx.stx_rdev_major, struct statx.stx_dev_major, struct statx.stx_dev_minor])
 
-AC_CHECK_MEMBERS([struct statx_timestamp tv_sec, struct statx_timestamp tv_nsec])
+AC_CHECK_MEMBERS([struct statx_timestamp.tv_sec, struct statx_timestamp.tv_nsec])
+])

...

> diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
...
> +	if (buf.stx_size == SIZE)
> +		tst_res(TPASS,
> +			"stx_size(%llu) obtained is correct", buf.stx_size);
> +	else
> +		tst_res(TFAIL,
> +			"stx_size(%llu) obtained is not same as expected(%u)",
> +			buf.stx_size, SIZE);
On my system (x86_64) there is a warning asking to use %lu
statx01.c: In function ‘test_normal_file’:
../../../../include/tst_test.h:53:40: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘uint64_t’ {aka ‘long unsigned int’} [-Wformat=]
  tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
                                        ^~~~~~~~~
statx01.c:103:3: note: in expansion of macro ‘tst_res’
   tst_res(TPASS, " stx_blocks(%llu) obtained is valid",
   ^~~~~~~

It is for all llu usage.


Kind regards,
Petr
