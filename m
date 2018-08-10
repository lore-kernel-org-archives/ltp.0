From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 10 Aug 2018 13:14:25 +0200
Subject: [LTP] [PATCH v4] Testing statx syscall
In-Reply-To: <20180729081607.27044-1-vaishnavi.d@zilogic.com>
References: <20180729081607.27044-1-vaishnavi.d@zilogic.com>
Message-ID: <87tvo24goe.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

vaishnavid <vaishnavi.d@zilogic.com> writes:

>      * statx01.c: This file will check metadata of files like uid, gid,
>        size, blocks, mode for normal file(1) and rdev_major, rdev_minor
>        number for device file(2)
>
>      * statx02.c: This file will check flag like AT_EMPTY_PATH,
>              AT_SYMLINK_NOFOLLOW
>        * AT_EMPTY_PATH: If pathname is an empty string,
>           operate on the file referred to by dirfd.
>        * AT_SYMLINK_NOFOLLOW:If pathname is a symbolic link, do not
>           dereference it: instead return information about the link itself.
>
>      * stat03.c: This file will check error code(errno) by providing
>        required input in statx argument syscall. The following errno are
>        checked: EBADF, EBADF, ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT.
>
>      * statx04.sh: This script will check attribute flag by defining flag
>        to that directory and checks another directory no flags. It
>        contains helper c file to get attribute status
>
>     Changes from V3 to V4:
>     * Added fs.h header file.
>     * Renamed statx wrapper function.
>     * Handled command_not_found for e4crypt in statx04.c.
>     * used tst_get_bad_addr() to simulate EFAULT scenario.
>     * Modified log messages in tst_res.
>
>     Signed-off-by: Tarun.T.U <tarun@zilogic.com>
>     Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
> ---
>  include/lapi/fs.h                          |  47 +++++
>  include/lapi/sys_statx.h                   | 264 +++++++++++++++++++++++++++++
>  include/lapi/syscalls/arm.in               |   1 +
>  include/lapi/syscalls/i386.in              |   1 +
>  include/lapi/syscalls/powerpc.in           |   1 +
>  include/lapi/syscalls/powerpc64.in         |   1 +
>  include/lapi/syscalls/s390.in              |   1 +
>  include/lapi/syscalls/sparc.in             |   1 +
>  include/lapi/syscalls/sparc64.in           |   1 +
>  include/lapi/syscalls/x86_64.in            |   1 +
>  m4/ltp-statx.m4                            |  25 +++
>  runtest/syscalls                           |   9 +
>  testcases/kernel/syscalls/statx/.gitignore |   8 +
>  testcases/kernel/syscalls/statx/Makefile   |  26 +++
>  testcases/kernel/syscalls/statx/statx01.c  | 200 ++++++++++++++++++++++
>  testcases/kernel/syscalls/statx/statx02.c  | 144 ++++++++++++++++
>  testcases/kernel/syscalls/statx/statx03.c  | 135 +++++++++++++++
>  testcases/kernel/syscalls/statx/statx04.c  | 217 ++++++++++++++++++++++++
>  18 files changed, 1083 insertions(+)
>  create mode 100644 include/lapi/fs.h
>  create mode 100644 include/lapi/sys_statx.h
>  create mode 100644 m4/ltp-statx.m4
>  create mode 100644 testcases/kernel/syscalls/statx/.gitignore
>  create mode 100644 testcases/kernel/syscalls/statx/Makefile
>  create mode 100644 testcases/kernel/syscalls/statx/statx01.c
>  create mode 100644 testcases/kernel/syscalls/statx/statx02.c
>  create mode 100644 testcases/kernel/syscalls/statx/statx03.c
>  create mode 100644 testcases/kernel/syscalls/statx/statx04.c
>
> diff --git a/include/lapi/fs.h b/include/lapi/fs.h
> new file mode 100644
> index 000000000..e3cf2673e
> --- /dev/null
> +++ b/include/lapi/fs.h
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + * Referred from linux kernel -github/torvalds/linux
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email: code@zilogic.com
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
> +#ifndef FS_H
> +#define FS_H
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
> diff --git a/include/lapi/sys_statx.h b/include/lapi/sys_statx.h
> new file mode 100644
> index 000000000..d1f29a3fa
> --- /dev/null
> +++ b/include/lapi/sys_statx.h
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + * Referred from linux kernel -github/torvalds/linux
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email: code@zilogic.com
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
> +#ifndef STATX_H
> +#define STATX_H
> +
> +#include <stdint.h>
> +#include "lapi/syscalls.h"

It is quite likely that these definitions will be added to libc in the
near future. So we should check to see if these functions and structures
exist in sys/stat.h and only define them oursevles if they do not.

See https://sourceware.org/ml/libc-alpha/2018-06/msg01038.html for an
idea of what the libc library may look like.

Assuming statx is added to sys/stat.h as in the patch above and not
sys/statx.h, this file should simply be named stat.h and include
sys/stat.h. This is consistent with the existing headers in lapi which
wrap headers in sys.

> +
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
> +
> +/*
> + * Structures for the extended file attribute retrieval system call
> + * (statx()).
> + *
> + * The caller passes a mask of what they're specifically interested in as a
> + * parameter to statx().  What statx() actually got will be indicated in
> + * st_mask upon return.
> + *
> + * For each bit in the mask argument:
> + *
> + * - if the datum is not supported:
> + *
> + *   - the bit will be cleared, and
> + *
> + *   - the datum will be set to an appropriate fabricated value if one is
> + *     available (eg. CIFS can take a default uid and gid), otherwise
> + *
> + *   - the field will be cleared;
> + *
> + * - otherwise, if explicitly requested:
> + *
> + *   - the datum will be synchronised to the server if AT_STATX_FORCE_SYNC is
> + *     set or if the datum is considered out of date, and
> + *
> + *   - the field will be filled in and the bit will be set;
> + *
> + * - otherwise, if not requested, but available in approximate form without any
> + *   effort, it will be filled in anyway, and the bit will be set upon return
> + *   (it might not be up to date, however, and no attempt will be made to
> + *   synchronise the internal state first);
> + *
> + * - otherwise the field and the bit will be cleared before returning.
> + *
> + * Items in STATX_BASIC_STATS may be marked unavailable on return, but they
> + * will have values installed for compatibility purposes so that stat() and
> + * co. can be emulated in userspace.
> + */
> +struct statx {
> +	/* 0x00 */
> +	uint32_t	stx_mask;
> +	uint32_t	stx_blksize;
> +	uint64_t	stx_attributes;
> +	/* 0x10 */
> +	uint32_t	stx_nlink;
> +	uint32_t	stx_uid;
> +	uint32_t	stx_gid;
> +	uint16_t	stx_mode;
> +	uint16_t	__spare0[1];
> +	/* 0x20 */
> +	uint64_t	stx_ino;
> +	uint64_t	stx_size;
> +	uint64_t	stx_blocks;
> +	uint64_t	stx_attributes_mask;
> +	/* 0x40 */
> +	const struct statx_timestamp	stx_atime;
> +	const struct statx_timestamp	stx_btime;
> +	const struct statx_timestamp	stx_ctime;
> +	const struct statx_timestamp	stx_mtime;
> +	/* 0x80 */
> +	uint32_t	stx_rdev_major;
> +	uint32_t	stx_rdev_minor;
> +	uint32_t	stx_dev_major;
> +	uint32_t	stx_dev_minor;
> +	/* 0x90 */
> +	uint64_t	__spare2[14];
> +	/* 0x100 */
> +};
> +
> +#if !defined(HAVE_STATX)
> +
> +/*
> + * statx: wrapper function of statx
> + *
> + * Returns: It returns status of statx syscall
> + */
> +static inline int statx(int dirfd, const char *pathname, unsigned int flags,
> +			    unsigned int mask, struct statx *statxbuf)
> +{
> +	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
> +}
> +
> +#endif
> +
> +/*
> + * Flags to be stx_mask
> + *
> + * Query request/result mask for statx() and struct statx::stx_mask.
> + *
> + * These bits should be set in the mask argument of statx() to request
> + * particular items when calling statx().
> + */
> +#ifndef STATX_TYPE
> +# define STATX_TYPE		0x00000001U
> +#endif
> +
> +#ifndef STATX_MODE
> +# define STATX_MODE		0x00000002U
> +#endif
> +
> +#ifndef STATX_NLINK
> +# define STATX_NLINK		0x00000004U
> +#endif
> +
> +#ifndef STATX_UID
> +# define STATX_UID		0x00000008U
> +#endif
> +
> +#ifndef STATX_GID
> +# define STATX_GID		0x00000010U
> +#endif
> +
> +#ifndef STATX_ATIME
> +# define STATX_ATIME		0x00000020U
> +#endif
> +
> +#ifndef STATX_MTIME
> +# define STATX_MTIME		0x00000040U
> +#endif
> +
> +#ifndef STATX_CTIME
> +# define STATX_CTIME		0x00000080U
> +#endif
> +
> +#ifndef STATX_INO
> +# define STATX_INO		0x00000100U
> +#endif
> +
> +#ifndef STATX_SIZE
> +# define STATX_SIZE		0x00000200U
> +#endif
> +
> +#ifndef STATX_BLOCKS
> +# define STATX_BLOCKS		0x00000400U
> +#endif
> +
> +#ifndef STATX_BASIC_STATS
> +# define STATX_BASIC_STATS	0x000007ffU
> +#endif
> +
> +#ifndef STATX_BTIME
> +# define STATX_BTIME		0x00000800U
> +#endif
> +
> +#ifndef STATX_ALL
> +# define STATX_ALL		0x00000fffU
> +#endif
> +
> +#ifndef STATX__RESERVED
> +# define STATX__RESERVED	0x80000000U
> +#endif
> +
> +/*
> + * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
> + *
> + * These give information about the features or the state of a file that might
> + * be of use to ordinary userspace programs such as GUIs or ls rather than
> + * specialised tools.
> + *
> + * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
> + * semantically.  Where possible, the numerical value is picked to correspond
> + * also.
> + */
> +#ifndef STATX_ATTR_COMPRESSED
> +# define STATX_ATTR_COMPRESSED	0x00000004
> +#endif
> +
> +#ifndef STATX_ATTR_IMMUTABLE
> +# define STATX_ATTR_IMMUTABLE	0x00000010
> +#endif
> +
> +#ifndef STATX_ATTR_APPEND
> +# define STATX_ATTR_APPEND	0x00000020
> +#endif
> +
> +#ifndef STATX_ATTR_NODUMP
> +# define STATX_ATTR_NODUMP	0x00000040
> +#endif
> +
> +#ifndef STATX_ATTR_ENCRYPTED
> +# define STATX_ATTR_ENCRYPTED	0x00000800
> +#endif
> +
> +#ifndef STATX_ATTR_AUTOMOUNT
> +# define STATX_ATTR_AUTOMOUNT	0x00001000
> +#endif
> +
> +#ifndef AT_SYMLINK_NOFOLLOW
> +# define AT_SYMLINK_NOFOLLOW	0x100
> +#endif
> +
> +#ifndef AT_REMOVEDIR
> +# define AT_REMOVEDIR		0x200
> +#endif
> +
> +#ifndef AT_SYMLINK_FOLLOW
> +# define AT_SYMLINK_FOLLOW	0x400
> +#endif
> +
> +#ifndef AT_NO_AUTOMOUNT
> +# define AT_NO_AUTOMOUNT	0x800
> +#endif
> +
> +#ifndef AT_EMPTY_PATH
> +# define AT_EMPTY_PATH		0x1000
> +#endif
> +
> +#ifndef AT_STATX_SYNC_TYPE
> +# define AT_STATX_SYNC_TYPE	0x6000
> +#endif
> +
> +#ifndef AT_STATX_SYNC_AS_STAT
> +# define AT_STATX_SYNC_AS_STAT	0x0000
> +#endif
> +
> +#ifndef AT_STATX_FORCE_SYNC
> +# define AT_STATX_FORCE_SYNC	0x2000
> +#endif
> +
> +#ifndef AT_STATX_DONT_SYNC
> +# define AT_STATX_DONT_SYNC	0x4000
> +#endif
> +
> +#endif
> diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> index 71a4b713d..784b64004 100644
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -341,3 +341,4 @@ renameat2 (__NR_SYSCALL_BASE+382)
>  getrandom (__NR_SYSCALL_BASE+384)
>  memfd_create (__NR_SYSCALL_BASE+385)
>  copy_file_range (__NR_SYSCALL_BASE+391)
> +statx (__NR_SYSCALL+397)
> diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
> index 0f9601472..453ac3e4e 100644
> --- a/include/lapi/syscalls/i386.in
> +++ b/include/lapi/syscalls/i386.in
> @@ -341,3 +341,4 @@ renameat2 354
>  getrandom 355
>  memfd_create 356
>  copy_file_range 377
> +statx 383
> diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
> index 11ddca34e..10fb238bf 100644
> --- a/include/lapi/syscalls/powerpc.in
> +++ b/include/lapi/syscalls/powerpc.in
> @@ -348,3 +348,4 @@ renameat2 357
>  getrandom 359
>  memfd_create 360
>  copy_file_range 379
> +statx 383
> diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
> index 11ddca34e..10fb238bf 100644
> --- a/include/lapi/syscalls/powerpc64.in
> +++ b/include/lapi/syscalls/powerpc64.in
> @@ -348,3 +348,4 @@ renameat2 357
>  getrandom 359
>  memfd_create 360
>  copy_file_range 379
> +statx 383
> diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
> index 98c861f36..486205030 100644
> --- a/include/lapi/syscalls/s390.in
> +++ b/include/lapi/syscalls/s390.in
> @@ -332,3 +332,4 @@ renameat2 347
>  getrandom 349
>  memfd_create 350
>  copy_file_range 375
> +statx 379
> \ No newline at end of file
> diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
> index 296d694a8..bbab51b72 100644
> --- a/include/lapi/syscalls/sparc.in
> +++ b/include/lapi/syscalls/sparc.in
> @@ -337,3 +337,4 @@ renameat2 345
>  getrandom 347
>  memfd_create 348
>  copy_file_range 357
> +statx 360
> diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
> index 169347a6a..ebff38265 100644
> --- a/include/lapi/syscalls/sparc64.in
> +++ b/include/lapi/syscalls/sparc64.in
> @@ -313,3 +313,4 @@ renameat2 345
>  getrandom 347
>  memfd_create 348
>  copy_file_range 357
> +statx 360
> diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
> index 89db79404..11a7b74ca 100644
> --- a/include/lapi/syscalls/x86_64.in
> +++ b/include/lapi/syscalls/x86_64.in
> @@ -308,3 +308,4 @@ renameat2 316
>  getrandom 318
>  memfd_create 319
>  copy_file_range 326
> +statx 332
> diff --git a/m4/ltp-statx.m4 b/m4/ltp-statx.m4
> new file mode 100644
> index 000000000..52823b5ed
> --- /dev/null
> +++ b/m4/ltp-statx.m4
> @@ -0,0 +1,25 @@
> +dnl
> +dnl Copyright (c) Linux Test Project, 2014
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_STATX
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_STATX],[
> +AC_CHECK_FUNCS(statx,,)

We also need to check here that the structures exist.

> +])
> diff --git a/runtest/syscalls b/runtest/syscalls
> index dc72484cb..bc84c0df7 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1277,6 +1277,15 @@ statfs03_64 statfs03_64
>  statvfs01 statvfs01
>  statvfs02 statvfs02
>
> +statx01 statx01
> +statx01_64 statx01_64
> +statx02 statx02
> +statx02_64 statx02_64
> +statx03 statx03
> +statx03_64 statx03_64
> +statx04 statx04
> +statx04_64 statx04_64
> +
>  stime01 stime01
>  stime02 stime02
>
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> new file mode 100644
> index 000000000..474871dd1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -0,0 +1,8 @@
> +/statx01
> +/statx01_64
> +/statx02
> +/statx02_64
> +/statx03
> +/statx03_64
> +/statx04
> +/statx04_64
> diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
> new file mode 100644
> index 000000000..bf1201019
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/Makefile
> @@ -0,0 +1,26 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2001
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../utils/newer_64.mk
> +
> +%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
> new file mode 100644
> index 000000000..24dce1adc
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email: code@zilogic.com
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
> +
> +/*
> + * Test statx
> + *
> + * This code tests the functionality of statx system call.
> + *
> + * TESTCASE 1:
> + * The metadata for normal file are tested against predefined values:
> + * 1) gid
> + * 2) uid
> + * 3) mode
> + * 4) blocks
> + * 5) size
> + *
> + * A file is created and metadata values are set with
> + * predefined values.
> + * Then the values obtained using statx is checked against
> + * the predefined values.
> + *
> + * TESTCASE 2:
> + * The metadata for device file are tested against predefined values:
> + * 1) MAJOR number
> + * 2) MINOR number
> + *
> + * A device file is created seperately using mknod(must be a root user).
> + * The major number and minor number are set while creation.
> + * Major and minor numbers obtained using statx is checked against
> + * predefined values.
> + * Minimum kernel version required is 4.11.
> + */
> +#include <stdio.h>
> +#include <string.h>
> +#include <pwd.h>
> +#include <sys/types.h>
> +#include <sys/sysmacros.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "lapi/sys_statx.h"
> +#include <unistd.h>
> +
> +#define TESTFILE "test_file"
> +#define DEVICEFILE "blk_dev"
> +#define MODE 0644
> +
> +static int file_fd;
> +#define SIZE 256
> +#define MAJOR 8
> +#define MINOR 1
> +
> +static void test_normal_file(void)
> +{
> +	struct statx buff;
> +	uint32_t blocks;
> +
> +	TEST(statx(AT_FDCWD, TESTFILE, 0, 0, &buff));
> +	if (TST_RET == 0)
> +		tst_res(TPASS,
> +			"statx(AT_FDCWD, %s, 0, 0, &buff)", TESTFILE);
> +	else
> +		tst_brk(TFAIL | TTERRNO,
> +			"statx(AT_FDCWD, %s, 0, 0, &buff)", TESTFILE);
> +
> +	if (geteuid() == buff.stx_uid)
> +		tst_res(TPASS,
> +			"stx_uid(%u) obtained is correct", buff.stx_uid);
> +	else
> +		tst_res(TFAIL,
> +			"stx_uid(%u) obtained is different from euid(%u)",
> +			buff.stx_uid, geteuid());
> +
> +	if (getegid() == buff.stx_gid)
> +		tst_res(TPASS,
> +			"stx_gid(%u) obtained is correct", buff.stx_gid);
> +	else
> +		tst_res(TFAIL,
> +			"stx_gid(%u) obtained is different from egid(%u)",
> +			buff.stx_gid, getegid());
> +
> +	if (buff.stx_size == SIZE)
> +		tst_res(TPASS,
> +			"stx_size(%llu) obtained is correct", buff.stx_size);
> +	else
> +		tst_res(TFAIL,
> +			"stx_size(%llu) obtained is different from expected(%u)",
> +			buff.stx_size, SIZE);
> +
> +	if ((buff.stx_mode & ~(S_IFMT)) == MODE)
> +		tst_res(TPASS,
> +			"stx_mode(%u) obtained is correct", buff.stx_mode);
> +	else
> +		tst_res(TFAIL,
> +			"stx_mode(%u) obtained is different from expected(%u)",
> +			buff.stx_mode, MODE);
> +
> +	blocks = (((SIZE + buff.stx_blksize - 1) / buff.stx_blksize)
> +		  * (buff.stx_blksize / 512));

According to the man page, the blksize is the _prefered_ size for
efficient I/O, not necessarily the minimum size allocatable on
disk. Although they may be the equivalent on some FSs we can't assume
that, it needs to be specified somewhere.

Also it appears that the FS can choose to report whatever number of
blocks it wants and it can allocate whatever number it wants as
well. AFAICT it could allocate zero and just link the inode to some
section of memory already allocated with 256 bytes of '@' with a COW
flag attached. It doesn't have to comply with the equation above. If it
did, libc could calculate the number of blocks in user land.

All you can really do here is check that the returned value is
sane e.g. the high bits are not set to one.

--
Thank you,
Richard.
