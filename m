From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Aug 2018 12:03:12 +0200
Subject: [LTP] [PATCH v6] Testing statx syscall
In-Reply-To: <20180822105747.4251-1-vaishnavi.d@zilogic.com>
References: <20180822105747.4251-1-vaishnavi.d@zilogic.com>
Message-ID: <20180831100312.GB13058@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Vaishnavi,


> From: vaishnavid <vaishnavi.d@zilogic.com>

> * statx01.c: This file will check metadata of files like uid, gid,
> size, blocks, mode for normal file(1) and rdev_major, rdev_minor
> number for device file(2)

> * statx02.c: This file will check flag like AT_EMPTY_PATH,
> AT_SYMLINK_NOFOLLOW
> * AT_EMPTY_PATH: If pathname is an empty string,
> operate on the file referred to by dirfd.
> * AT_SYMLINK_NOFOLLOW:If pathname is a symbolic link, do not
> dereference it: instead return information about the link itself.

> * stat03.c: This file will check error code(errno) by providing
> required input in statx argument syscall. The following errno are
> checked: EBADF, EBADF, ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT.

> * statx04.c: This file will check attribute flag by defining flag
> to that directory and checks another directory with no flags.
> Changes from V5 to V6:
> * Made changes in the m4 file and LTP_CHECK_STATX added to configure.ac
> * Replaced arch-specific printf format with general one.
> * Added ifndef cases for structs in stat.h.
...
>  19 files changed, 1110 insertions(+)

You know what prevents you patch to get better review: it's huge.
Splitting it a bit would help the review process.


> +++ b/include/lapi/fs.h
...
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + * Referred from linux kernel -github/torvalds/linux/include/uapi/linux/=
fs.h
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email: code@zilogic.com
This GPL info should be omitted, as it's what SPDX-License-Identifier does.
(+ preferred form is without spaces: SPDX-License-Identifier: GPL-2.0-or-la=
ter).
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */

I'd prefer first include <linux/fs.h> (or wherever these definitions origin=
) to
have a chance to get these definitions.

#ifdef  HAVE_LINUX_FS_H
# include <linux/fs.h>
#endif

+ Add this header to AC_CHECK_HEADERS in configure.ac

> +#ifndef FS_H
> +#define FS_H
Also please use LAPI_FS_H (be consistent with include/lapi/stat.h).

> +
> +#ifndef FS_IOC_GETFLAGS
> +#define	FS_IOC_GETFLAGS	_IOR('f', 1, long)
> +#endif
> +
> +#ifndef FS_IOC_SETFLAGS
> +#define	FS_IOC_SETFLAGS	_IOW('f', 2, long)
> +#endif
> +
> +#ifndef FS_COMPR_FL
> +#define	FS_COMPR_FL        0x00000004 /* Compress file */
> +#endif
> +
> +#ifndef FS_IMMUTABLE_FL
> +#define FS_IMMUTABLE_FL	   0x00000010 /* Immutable file */
> +#endif
> +
> +#ifndef FS_APPEND_FL
> +#define FS_APPEND_FL	   0x00000020 /* writes to file may only append */
> +#endif
> +
> +#ifndef FS_NODUMP_FL
> +#define FS_NODUMP_FL	   0x00000040 /* do not dump file */
> +#endif
> +
> +#endif
...

> +++ b/m4/ltp-statx.m4
...
> +AC_DEFUN([LTP_CHECK_STATX],[
> +AC_CHECK_FUNCS(statx,,)
> +AC_MSG_CHECKING([for struct statx])
> +AC_COMPILE_IFELSE([AC_LANG_SOURCE([
> +#define _GNU_SOURCE
Why _GNU_SOURCE? IMHO not needed.
> +#include <sys/stat.h>
struct statx is in <linux/stat.h>
Using <sys/stat.h> give wrong result (+ the same for statx_timestamp).

> +int main(void) {
> +	struct statx buff_obj;
> +	return 0;
> +}])],[has_statx=3D"yes"])
> +
> +if test "x$has_statx" =3D xyes; then
> +	AC_DEFINE(HAVE_STRUCT_STATX,1,[Define to 1 if you have struct statx])
> +	AC_MSG_RESULT(yes)
> +else
> +	AC_MSG_RESULT(no)
> +fi
> +AC_MSG_CHECKING([for struct statx_timestamp])
> +AC_COMPILE_IFELSE([AC_LANG_SOURCE([
> +#define _GNU_SOURCE
> +#include <sys/stat.h>
> +int main(void) {
> +	struct statx_timestamp time;
> +	return 0;
> +}])],[has_statx_timestamp=3D"yes"])
> +
> +if test "x$has_statx_timestamp" =3D xyes; then
> +	AC_DEFINE(HAVE_STRUCT_STATX_TIMESTAMP,1,[Define to 1 if you have struct=
 statx_timestamp])
> +	AC_MSG_RESULT(yes)
> +else
> +	AC_MSG_RESULT(no)
> +fi
> +])

IMHO the previous version was simpler (testing just some members of statx =
=E2=80=93
testing all takes too much time. Not sure which ones make sense to test):
dnl SPDX-License-Identifier: GPL-2.0-or-later
dnl Copyright (c) Zilogic Systems Pvt. Ltd., 2018
dnl Email: code@zilogic.com

AC_DEFUN([LTP_CHECK_STATX],[
AC_CHECK_FUNCS([statx])
AC_CHECK_MEMBERS([struct statx.stx_mask, struct statx.stx_blksize],,, [[#in=
clude <linux/stat.h>]])
AC_CHECK_MEMBERS([struct statx_timestamp.tv_sec, struct statx_timestamp.tv_=
nsec],,, [[#include <linux/stat.h>]])
])


Kind regards,
Petr
