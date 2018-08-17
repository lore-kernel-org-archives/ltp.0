From: vaishnavi.d <vaishnavi.d@zilogic.com>
Date: Fri, 17 Aug 2018 05:57:02 -0000
Subject: [LTP] [PATCH v5] Testing statx syscall
Message-ID: <20180817055702.2731-1-vaishnavi.d@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


From: vaishnavi <vaishnavi.d@zilogic.com>

* statx01.c: This file will check metadata of files like uid, gid,
size, blocks, mode for normal file(1) and rdev_major, rdev_minor
number for device file(2)

* statx02.c: This file will check flag like AT_EMPTY_PATH,
AT_SYMLINK_NOFOLLOW
* AT_EMPTY_PATH: If pathname is an empty string,
operate on the file referred to by dirfd.
* AT_SYMLINK_NOFOLLOW:If pathname is a symbolic link, do not
dereference it: instead return information about the link itself.

* stat03.c: This file will check error code(errno) by providing
required input in statx argument syscall. The following errno are
checked: EBADF, EBADF, ENAMETOOLONG, ENOENT, ENOTDIR, EFAULT.

* statx04.c: This file will check attribute flag by defining flag
to that directory and checks another directory with no flags.
Changes from V4 to V5:
* Modified header name to stat.h
* Added check for structure in m4 file.
* Modified test case for stx_blocks in statx01.c.

Signed-off-by: Tarun.T.U <tarun@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 include/lapi/fs.h                          |  47 +++++
 include/lapi/stat.h                        | 264 +++++++++++++++++++++++++++++
 include/lapi/syscalls/arm.in               |   1 +
 include/lapi/syscalls/i386.in              |   1 +
 include/lapi/syscalls/powerpc.in           |   1 +
 include/lapi/syscalls/powerpc64.in         |   1 +
 include/lapi/syscalls/s390.in              |   1 +
 include/lapi/syscalls/sparc.in             |   1 +
 include/lapi/syscalls/sparc64.in           |   1 +
 include/lapi/syscalls/x86_64.in            |   1 +
 m4/ltp-statx.m4                            |  28 +++
 runtest/syscalls                           |   5 +
 testcases/kernel/syscalls/statx/.gitignore |   4 +
 testcases/kernel/syscalls/statx/Makefile   |  25 +++
 testcases/kernel/syscalls/statx/statx01.c  | 199 ++++++++++++++++++++++
 testcases/kernel/syscalls/statx/statx02.c  | 144 ++++++++++++++++
 testcases/kernel/syscalls/statx/statx03.c  | 135 +++++++++++++++
 testcases/kernel/syscalls/statx/statx04.c  | 217 ++++++++++++++++++++++++
 18 files changed, 1076 insertions(+)
 create mode 100644 include/lapi/fs.h
 create mode 100644 include/lapi/stat.h
 create mode 100644 m4/ltp-statx.m4
 create mode 100644 testcases/kernel/syscalls/statx/.gitignore
 create mode 100644 testcases/kernel/syscalls/statx/Makefile
 create mode 100644 testcases/kernel/syscalls/statx/statx01.c
 create mode 100644 testcases/kernel/syscalls/statx/statx02.c
 create mode 100644 testcases/kernel/syscalls/statx/statx03.c
 create mode 100644 testcases/kernel/syscalls/statx/statx04.c

diff --git a/include/lapi/fs.h b/include/lapi/fs.h
new file mode 100644
index 000000000..e3cf2673e
--- /dev/null
+++ b/include/lapi/fs.h
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Referred from linux kernel -github/torvalds/linux
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef FS_H
+#define FS_H
+
+#ifndef FS_IOC_GETFLAGS
+#define	FS_IOC_GETFLAGS	_IOR('f', 1, long)
+#endif
+
+#ifndef FS_IOC_SETFLAGS
+#define	FS_IOC_SETFLAGS	_IOW('f', 2, long)
+#endif
+
+#ifndef FS_COMPR_FL
+#define	FS_COMPR_FL        0x00000004 /* Compress file */
+#endif
+
+#ifndef FS_IMMUTABLE_FL
+#define FS_IMMUTABLE_FL	   0x00000010 /* Immutable file */
+#endif
+
+#ifndef FS_APPEND_FL
+#define FS_APPEND_FL	   0x00000020 /* writes to file may only append */
+#endif
+
+#ifndef FS_NODUMP_FL
+#define FS_NODUMP_FL	   0x00000040 /* do not dump file */
+#endif
+
+#endif
diff --git a/include/lapi/stat.h b/include/lapi/stat.h
new file mode 100644
index 000000000..9f7418a1a
--- /dev/null
+++ b/include/lapi/stat.h
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Referred from linux kernel -github/torvalds/linux
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef STATX_H
+#define STATX_H
+
+#include <stdint.h>
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+/*
+ * Timestamp structure for the timestamps in struct statx.
+ *
+ * tv_sec holds the number of seconds before (negative) or after (positive)
+ * 00:00:00 1st January 1970 UTC.
+ *
+ * tv_nsec holds a number of nanoseconds (0..999,999,999) after the tv_sec time.
+ *
+ * __reserved is held in case we need a yet finer resolution.
+ */
+struct statx_timestamp {
+	int64_t 	tv_sec;
+	uint32_t	tv_nsec;
+	int32_t __reserved;
+};
+
+/*
+ * Structures for the extended file attribute retrieval system call
+ * (statx()).
+ *
+ * The caller passes a mask of what they're specifically interested in as a
+ * parameter to statx().  What statx() actually got will be indicated in
+ * st_mask upon return.
+ *
+ * For each bit in the mask argument:
+ *
+ * - if the datum is not supported:
+ *
+ *   - the bit will be cleared, and
+ *
+ *   - the datum will be set to an appropriate fabricated value if one is
+ *     available (eg. CIFS can take a default uid and gid), otherwise
+ *
+ *   - the field will be cleared;
+ *
+ * - otherwise, if explicitly requested:
+ *
+ *   - the datum will be synchronised to the server if AT_STATX_FORCE_SYNC is
+ *     set or if the datum is considered out of date, and
+ *
+ *   - the field will be filled in and the bit will be set;
+ *
+ * - otherwise, if not requested, but available in approximate form without any
+ *   effort, it will be filled in anyway, and the bit will be set upon return
+ *   (it might not be up to date, however, and no attempt will be made to
+ *   synchronise the internal state first);
+ *
+ * - otherwise the field and the bit will be cleared before returning.
+ *
+ * Items in STATX_BASIC_STATS may be marked unavailable on return, but they
+ * will have values installed for compatibility purposes so that stat() and
+ * co. can be emulated in userspace.
+ */
+struct statx {
+	/* 0x00 */
+	uint32_t	stx_mask;
+	uint32_t	stx_blksize;
+	uint64_t	stx_attributes;
+	/* 0x10 */
+	uint32_t	stx_nlink;
+	uint32_t	stx_uid;
+	uint32_t	stx_gid;
+	uint16_t	stx_mode;
+	uint16_t	__spare0[1];
+	/* 0x20 */
+	uint64_t	stx_ino;
+	uint64_t	stx_size;
+	uint64_t	stx_blocks;
+	uint64_t	stx_attributes_mask;
+	/* 0x40 */
+	const struct statx_timestamp	stx_atime;
+	const struct statx_timestamp	stx_btime;
+	const struct statx_timestamp	stx_ctime;
+	const struct statx_timestamp	stx_mtime;
+	/* 0x80 */
+	uint32_t	stx_rdev_major;
+	uint32_t	stx_rdev_minor;
+	uint32_t	stx_dev_major;
+	uint32_t	stx_dev_minor;
+	/* 0x90 */
+	uint64_t	__spare2[14];
+	/* 0x100 */
+};
+
+#if !defined(HAVE_STATX)
+
+/*
+ * statx: wrapper function of statx
+ *
+ * Returns: It returns status of statx syscall
+ */
+static inline int statx(int dirfd, const char *pathname, unsigned int flags,
+			    unsigned int mask, struct statx *statxbuf)
+{
+	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+}
+
+#endif
+
+/*
+ * Flags to be stx_mask
+ *
+ * Query request/result mask for statx() and struct statx::stx_mask.
+ *
+ * These bits should be set in the mask argument of statx() to request
+ * particular items when calling statx().
+ */
+#ifndef STATX_TYPE
+# define STATX_TYPE		0x00000001U
+#endif
+
+#ifndef STATX_MODE
+# define STATX_MODE		0x00000002U
+#endif
+
+#ifndef STATX_NLINK
+# define STATX_NLINK		0x00000004U
+#endif
+
+#ifndef STATX_UID
+# define STATX_UID		0x00000008U
+#endif
+
+#ifndef STATX_GID
+# define STATX_GID		0x00000010U
+#endif
+
+#ifndef STATX_ATIME
+# define STATX_ATIME		0x00000020U
+#endif
+
+#ifndef STATX_MTIME
+# define STATX_MTIME		0x00000040U
+#endif
+
+#ifndef STATX_CTIME
+# define STATX_CTIME		0x00000080U
+#endif
+
+#ifndef STATX_INO
+# define STATX_INO		0x00000100U
+#endif
+
+#ifndef STATX_SIZE
+# define STATX_SIZE		0x00000200U
+#endif
+
+#ifndef STATX_BLOCKS
+# define STATX_BLOCKS		0x00000400U
+#endif
+
+#ifndef STATX_BASIC_STATS
+# define STATX_BASIC_STATS	0x000007ffU
+#endif
+
+#ifndef STATX_BTIME
+# define STATX_BTIME		0x00000800U
+#endif
+
+#ifndef STATX_ALL
+# define STATX_ALL		0x00000fffU
+#endif
+
+#ifndef STATX__RESERVED
+# define STATX__RESERVED	0x80000000U
+#endif
+
+/*
+ * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
+ *
+ * These give information about the features or the state of a file that might
+ * be of use to ordinary userspace programs such as GUIs or ls rather than
+ * specialised tools.
+ *
+ * Note that the flags marked [I] correspond to generic FS_IOC_FLAGS
+ * semantically.  Where possible, the numerical value is picked to correspond
+ * also.
+ */
+#ifndef STATX_ATTR_COMPRESSED
+# define STATX_ATTR_COMPRESSED	0x00000004
+#endif
+
+#ifndef STATX_ATTR_IMMUTABLE
+# define STATX_ATTR_IMMUTABLE	0x00000010
+#endif
+
+#ifndef STATX_ATTR_APPEND
+# define STATX_ATTR_APPEND	0x00000020
+#endif
+
+#ifndef STATX_ATTR_NODUMP
+# define STATX_ATTR_NODUMP	0x00000040
+#endif
+
+#ifndef STATX_ATTR_ENCRYPTED
+# define STATX_ATTR_ENCRYPTED	0x00000800
+#endif
+
+#ifndef STATX_ATTR_AUTOMOUNT
+# define STATX_ATTR_AUTOMOUNT	0x00001000
+#endif
+
+#ifndef AT_SYMLINK_NOFOLLOW
+# define AT_SYMLINK_NOFOLLOW	0x100
+#endif
+
+#ifndef AT_REMOVEDIR
+# define AT_REMOVEDIR		0x200
+#endif
+
+#ifndef AT_SYMLINK_FOLLOW
+# define AT_SYMLINK_FOLLOW	0x400
+#endif
+
+#ifndef AT_NO_AUTOMOUNT
+# define AT_NO_AUTOMOUNT	0x800
+#endif
+
+#ifndef AT_EMPTY_PATH
+# define AT_EMPTY_PATH		0x1000
+#endif
+
+#ifndef AT_STATX_SYNC_TYPE
+# define AT_STATX_SYNC_TYPE	0x6000
+#endif
+
+#ifndef AT_STATX_SYNC_AS_STAT
+# define AT_STATX_SYNC_AS_STAT	0x0000
+#endif
+
+#ifndef AT_STATX_FORCE_SYNC
+# define AT_STATX_FORCE_SYNC	0x2000
+#endif
+
+#ifndef AT_STATX_DONT_SYNC
+# define AT_STATX_DONT_SYNC	0x4000
+#endif
+
+#endif
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index c44adcd7e..a355ba36b 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -342,3 +342,4 @@ getrandom (__NR_SYSCALL_BASE+384)
 memfd_create (__NR_SYSCALL_BASE+385)
 execveat (__NR_SYSCALL_BASE+387)
 copy_file_range (__NR_SYSCALL_BASE+391)
+statx (__NR_SYSCALL+397)
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 19f0148fe..fa4b529ad 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -342,3 +342,4 @@ getrandom 355
 memfd_create 356
 execveat 358
 copy_file_range 377
+statx 383
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 11ddca34e..10fb238bf 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -348,3 +348,4 @@ renameat2 357
 getrandom 359
 memfd_create 360
 copy_file_range 379
+statx 383
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 11ddca34e..10fb238bf 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -348,3 +348,4 @@ renameat2 357
 getrandom 359
 memfd_create 360
 copy_file_range 379
+statx 383
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index d95b282f8..66ee19e61 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -333,3 +333,4 @@ getrandom 349
 memfd_create 350
 execveat 354
 copy_file_range 375
+statx 379
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 296d694a8..bbab51b72 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -337,3 +337,4 @@ renameat2 345
 getrandom 347
 memfd_create 348
 copy_file_range 357
+statx 360
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 169347a6a..ebff38265 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -313,3 +313,4 @@ renameat2 345
 getrandom 347
 memfd_create 348
 copy_file_range 357
+statx 360
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index 7907c3108..5d926dfff 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -309,3 +309,4 @@ getrandom 318
 memfd_create 319
 execveat 322
 copy_file_range 326
+statx 332
diff --git a/m4/ltp-statx.m4 b/m4/ltp-statx.m4
new file mode 100644
index 000000000..547172ebc
--- /dev/null
+++ b/m4/ltp-statx.m4
@@ -0,0 +1,28 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2014
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_STATX
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_STATX],[
+AC_CHECK_FUNCS(statx,,)
+])
+AC_CHECK_MEMBERS([struct statx.stx_mask, struct statx.stx_blksize, struct statx.stx_attributes, struct statx.stx_nlink, struct statx.stx_uid, struct statx.stx_gid, struct statx.stx_mode, struct statx.stx_ino, struct statx.stx_size, struct statx.stx_blocks, struct statx.stx_attributes_mask, struct statx.stx_rdev_minor, struct statx.stx_mtime, struct statx.stx_atime, struct statx.stx_btime, struct statx.stx_ctime, struct statx.stx_rdev_major, struct statx.stx_dev_major, struct statx.stx_dev_minor])
+
+AC_CHECK_MEMBERS([struct statx_timestamp tv_sec, struct statx_timestamp tv_nsec])
diff --git a/runtest/syscalls b/runtest/syscalls
index e2c937b02..275f955a7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1285,6 +1285,11 @@ statfs03_64 statfs03_64
 statvfs01 statvfs01
 statvfs02 statvfs02
 
+statx01 statx01
+statx02 statx02
+statx03 statx03
+statx04 statx04
+
 stime01 stime01
 stime02 stime02
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
new file mode 100644
index 000000000..47c415e10
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -0,0 +1,4 @@
+/statx01
+/statx02
+/statx03
+/statx04
diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
new file mode 100644
index 000000000..3a9523a1e
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
new file mode 100644
index 000000000..0133f50be
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test statx
+ *
+ * This code tests the functionality of statx system call.
+ *
+ * TESTCASE 1:
+ * The metadata for normal file are tested against predefined values:
+ * 1) gid
+ * 2) uid
+ * 3) mode
+ * 4) blocks
+ * 5) size
+ *
+ * A file is created and metadata values are set with
+ * predefined values.
+ * Then the values obtained using statx is checked against
+ * the predefined values.
+ *
+ * TESTCASE 2:
+ * The metadata for device file are tested against predefined values:
+ * 1) MAJOR number
+ * 2) MINOR number
+ *
+ * A device file is created seperately using mknod(must be a root user).
+ * The major number and minor number are set while creation.
+ * Major and minor numbers obtained using statx is checked against
+ * predefined values.
+ * Minimum kernel version required is 4.11.
+ */
+#include <stdio.h>
+#include <string.h>
+#include <pwd.h>
+#include <sys/types.h>
+#include <sys/sysmacros.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/stat.h"
+#include <unistd.h>
+
+#define TESTFILE "test_file"
+#define DEVICEFILE "blk_dev"
+#define MODE 0644
+
+static int file_fd;
+#define SIZE 256
+#define MAJOR 8
+#define MINOR 1
+
+static void test_normal_file(void)
+{
+	struct statx buff;
+	uint64_t blocks;
+
+	TEST(statx(AT_FDCWD, TESTFILE, 0, 0, &buff));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(AT_FDCWD, %s, 0, 0, &buff)", TESTFILE);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, 0, &buff)", TESTFILE);
+
+	if (geteuid() == buff.stx_uid)
+		tst_res(TPASS,
+			"stx_uid(%u) obtained is correct", buff.stx_uid);
+	else
+		tst_res(TFAIL,
+			"stx_uid(%u) obtained is different from euid(%u)",
+			buff.stx_uid, geteuid());
+
+	if (getegid() == buff.stx_gid)
+		tst_res(TPASS,
+			"stx_gid(%u) obtained is correct", buff.stx_gid);
+	else
+		tst_res(TFAIL,
+			"stx_gid(%u) obtained is different from egid(%u)",
+			buff.stx_gid, getegid());
+
+	if (buff.stx_size == SIZE)
+		tst_res(TPASS,
+			"stx_size(%llu) obtained is correct", buff.stx_size);
+	else
+		tst_res(TFAIL,
+			"stx_size(%llu) obtained is different from expected(%u)",
+			buff.stx_size, SIZE);
+
+	if ((buff.stx_mode & ~(S_IFMT)) == MODE)
+		tst_res(TPASS,
+			"stx_mode(%u) obtained is correct", buff.stx_mode);
+	else
+		tst_res(TFAIL,
+			"stx_mode(%u) obtained is different from expected(%u)",
+			buff.stx_mode, MODE);
+
+
+	blocks = buff.stx_blocks >> 50;
+	if (blocks == 0)
+		tst_res(TPASS, " stx_blocks(%llu) obtained is valid",
+			buff.stx_blocks);
+
+	else
+		tst_res(TFAIL,
+			"stx_blocks(%llu) obtained is invalid",
+			buff.stx_blocks);
+
+}
+
+static void test_device_file(void)
+{
+	struct statx buff;
+
+	TEST(statx(AT_FDCWD, DEVICEFILE, 0, 0, &buff));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(AT_FDCWD, %s, 0, 0, &buff)", DEVICEFILE);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, 0, &buff)", DEVICEFILE);
+
+	if (buff.stx_rdev_major == MAJOR)
+		tst_res(TPASS,
+			"stx_rdev_major(%u) obtained is correct",
+			buff.stx_rdev_major);
+	else
+		tst_res(TFAIL,
+			"stx_rdev_major(%u) obtained is different from expected(%u)",
+			buff.stx_rdev_major, MAJOR);
+
+	if (buff.stx_rdev_minor == MINOR)
+		tst_res(TPASS,
+			"stx_rdev_minor(%u) obtained is correct",
+			buff.stx_rdev_minor);
+	else
+		tst_res(TFAIL,
+			"stx_rdev_minor(%u) obtained is different from expected(%u)",
+			buff.stx_rdev_minor, MINOR);
+}
+
+
+struct tcase {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&test_normal_file},
+	{&test_device_file}
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *t;
+
+	t = &tcases[i];
+	t->tfunc();
+}
+
+static void setup(void)
+{
+	char data_buff[SIZE];
+
+	memset(data_buff, '@', sizeof(data_buff));
+
+	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR|O_CREAT, MODE);
+	SAFE_WRITE(0, file_fd, data_buff, sizeof(data_buff));
+
+	SAFE_MKNOD(DEVICEFILE, S_IFBLK | 0777, makedev(MAJOR, MINOR));
+}
+
+static void cleanup(void)
+{
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
new file mode 100644
index 000000000..2f37b3af7
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test statx
+ *
+ * This code tests the following flags:
+ * 1) AT_EMPTY_PATH
+ * 2) AT_SYMLINK_NOFOLLOW
+ *
+ * A test file and a link for it is created.
+ *
+ * To check empty path flag, test file fd alone is passed.
+ * Predefined size of testfile is checked against obtained value.
+ *
+ * To check symlink no follow flag, the linkname is statxed.
+ * To ensure that link is not dereferenced, obtained inode is compared
+ * with test file inode.
+ * Minimum kernel version required is 4.11.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/stat.h"
+
+#define TESTFILE "test_temp"
+#define LINK_FILE "test_temp_ln"
+#define MODE 0644
+#define SIZE 14
+
+static int file_fd;
+
+static void test_empty_path(void)
+{
+	struct statx buf;
+
+	TEST(statx(file_fd, "", AT_EMPTY_PATH, 0, &buf));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(file_fd, \" \", AT_EMPTY_PATH, 0, &buf)");
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(file_fd, \" \", AT_EMPTY_PATH, 0, &buff)");
+
+	if (buf.stx_size == SIZE)
+		tst_res(TPASS,
+			"stx_size(%llu) obtained is correct", buf.stx_size);
+	else
+		tst_res(TFAIL,
+			"stx_size(%llu) obtained is not same as expected(%u)",
+			buf.stx_size, SIZE);
+
+}
+
+static void test_sym_link(void)
+{
+	struct statx fbuf;
+	struct statx lbuf;
+
+	TEST(statx(AT_FDCWD, TESTFILE, 0, 0, &fbuf));
+
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(AT_FDCWD, %s, 0, 0, &fbuf)", TESTFILE);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, 0, 0, &fbuf)", TESTFILE);
+
+	TEST(statx(AT_FDCWD, LINK_FILE, AT_SYMLINK_NOFOLLOW, 0, &lbuf));
+
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"statx(AT_FDCWD, %s, AT_SYMLINK_NOFOLLOW, 0,&lbuf)",
+			LINK_FILE);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"statx(AT_FDCWD, %s, AT_SYMLINK_NOFOLLOW, 0,&lbuf)",
+			LINK_FILE);
+
+	if (fbuf.stx_ino != lbuf.stx_ino)
+		tst_res(TPASS, "Statx symlink flag worked as expected");
+	else
+		tst_res(TFAIL,
+			"Statx symlink flag failed to work as expected");
+}
+
+struct tcase {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&test_empty_path},
+	{&test_sym_link}
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *t;
+
+	t = &tcases[i];
+	t->tfunc();
+}
+
+static void setup(void)
+{
+	char data_buf[SIZE] = "LinusTorvalds";
+
+	file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, MODE);
+	SAFE_WRITE(0, file_fd, data_buf, sizeof(data_buf));
+
+	SAFE_SYMLINK(TESTFILE, LINK_FILE);
+}
+
+static void cleanup(void)
+{
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
new file mode 100644
index 000000000..dab368106
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx03.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test statx
+ *
+ * This code tests if expected error values are returned for specific cases by
+ * statx.
+ * The error cases are simulated and the return value is checked against
+ * expected error number value.
+ * The following error values are tested:
+ * 1) EBADF - Bad file descriptor
+ * 2) EFAULT - Bad address
+ * 3) EINVAL - Invalid argument
+ * 4) ENOENT - No such file or directory
+ * 5) ENOTDIR - Not a directory
+ * 6) ENAMETOOLONG - Filename too long
+ *
+ * Error scenario is simulated for each listed flag by passing
+ * respective arguments.
+ * The obtained error flag is checked against the expected
+ * flag value for that scenario.
+ *
+ * Minimum Kernel version required is 4.11.
+ */
+#include <stdio.h>
+#include <string.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_get_bad_addr.h"
+#include "lapi/stat.h"
+
+#define TESTFILE "test_file"
+#define MODE 0644
+
+static int file_fd;
+static char long_pathname[257];
+
+static char *test_fname = TESTFILE;
+static char *efault_fname;
+static char *empty_fname = "";
+static char *etoolong_fname = long_pathname;
+
+static struct test_case {
+	uint32_t dfd;
+	char **filename;
+	uint32_t flag;
+	uint32_t mask;
+	int32_t errnum;
+} tcases[] = {
+	{.dfd = -1, .filename = &test_fname, .flag = 0,
+	 .mask = 0, .errnum = EBADF},
+
+	{.dfd = AT_FDCWD, .filename = &efault_fname, .flag = 0,
+	 .mask = 0, .errnum = EFAULT},
+
+	{.dfd = AT_FDCWD, .filename = &test_fname, .flag = -1,
+	 .mask = 0, .errnum = EINVAL},
+
+	{.dfd = AT_FDCWD, .filename = &test_fname, .flag = 0,
+	 .mask = -1, .errnum = EINVAL},
+
+	{.dfd = AT_FDCWD, .filename = &empty_fname, .flag = 0,
+	 .mask = 0, .errnum = ENOENT},
+
+	{.dfd = 1, .filename = &test_fname, .flag = 0,
+	 .mask = 0, .errnum = ENOTDIR},
+
+	{.dfd = AT_FDCWD, .filename = &etoolong_fname, .flag = 0,
+	 .mask = 0, .errnum = ENAMETOOLONG},
+};
+
+static void run_test(unsigned int i)
+{
+	struct statx buf;
+	struct test_case *tc = &tcases[i];
+
+	TEST(statx(tc->dfd, *(tc->filename), tc->flag,
+		   tc->mask, &buf));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "statx() returned with %ld", TST_RET);
+		return;
+	}
+
+	if (tc->errnum == TST_ERR) {
+		tst_res(TPASS | TTERRNO, "statx() failed with");
+		return;
+	}
+
+	tst_res(TFAIL | TTERRNO,
+		"statx() should fail with %s", tst_strerrno(tc->errnum));
+}
+
+static void setup(void)
+{
+	file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, MODE);
+
+	memset(long_pathname, '@', sizeof(long_pathname));
+	long_pathname[sizeof(long_pathname) - 1] = 0;
+
+	efault_fname = tst_get_bad_addr(NULL);
+}
+
+static void cleanup(void)
+{
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
new file mode 100644
index 000000000..d811c1aed
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
+ * Email: code@zilogic.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test statx
+ *
+ * This code tests the functionality of statx system call.
+ * This code tests if the attributes field of statx received expected value.
+ * File set with following flags by using SAFE_IOCTL and e4crypt:
+ * 1) STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
+ * 2) STATX_ATTR_IMMUTABLE - The file cannot be modified.
+ * 3) STATX_ATTR_APPEND - The file can only be opened in append mode for
+ *                        writing.
+ * 4) STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
+ *                        program such as dump(8) is run.
+ * 5) STATX_ATTR_ENCRYPTED - A key is required for the file to be encrypted by
+ *                          the filesystem.
+ *
+ * A test directory is created with flags added to it.
+ *
+ * SAFE_IOCTL() is used to modify the atttributes of the directory such as
+ * compressed, append, nodump and immutable.
+ *
+ * e4crypt is used to set the encrypt flag.
+ *
+ * Two directory are tested.
+ * First directory has all flags set.
+ * Second directory has no flags set.
+ *
+ * Minimum kernel version required is 4.11.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+#include <stdlib.h>
+#include "lapi/stat.h"
+
+#define MOUNT_POINT "mnt_point"
+#define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
+#define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
+#define COMMAND_NOT_FOUND 127
+
+static int encrypt_flag;
+
+static void test_flagged(void)
+{
+	struct statx buf;
+
+	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
+
+	if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
+		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_COMPRESSED flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_APPEND)
+		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_APPEND flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
+		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_IMMUTABLE flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_NODUMP)
+		tst_res(TPASS, "STATX_ATTR_NODUMP flag is set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_NODUMP flag is not set");
+
+	if (buf.stx_attributes & STATX_ATTR_ENCRYPTED)
+		tst_res(TPASS, "STATX_ATTR_ENCRYPTED flag is set");
+	else if (encrypt_flag == 1)
+		tst_res(TCONF, "e4crypt tool not available");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_ENCRYPTED flag is not set");
+}
+
+static void test_unflagged(void)
+{
+	struct statx buf;
+
+	TEST(statx(AT_FDCWD, TESTDIR_UNFLAGGED, 0, 0, &buf));
+	if (TST_RET == 0)
+		tst_res(TPASS,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
+			TESTDIR_UNFLAGGED);
+	else
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
+			TESTDIR_UNFLAGGED);
+
+	if ((buf.stx_attributes & STATX_ATTR_COMPRESSED) == 0)
+		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_COMPRESSED flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_APPEND) == 0)
+		tst_res(TPASS, "STATX_ATTR_APPEND flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_APPEND flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_IMMUTABLE) == 0)
+		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_IMMUTABLE flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_NODUMP) == 0)
+		tst_res(TPASS, "STATX_ATTR_NODUMP flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_NODUMP flag is set");
+
+	if ((buf.stx_attributes & STATX_ATTR_ENCRYPTED) == 0)
+		tst_res(TPASS, "STATX_ATTR_ENCRYPTED flag is not set");
+	else
+		tst_res(TFAIL,
+			"STATX_ATTR_ENCRYPTED flag is set");
+}
+
+struct test_cases {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&test_flagged},
+	{&test_unflagged},
+};
+
+static void run(unsigned int i)
+{
+	struct test_cases *tc = &tcases[i];
+
+	tc->tfunc();
+}
+
+static void caid_flags_setup(void)
+{
+	int fd;
+	int attr;
+
+	fd = SAFE_OPEN(TESTDIR_FLAGGED, O_RDONLY | O_DIRECTORY);
+
+	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
+
+	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
+
+	SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
+
+	SAFE_CLOSE(fd);
+}
+
+static void encrypt_flag_setup(void)
+{
+	TEST(tst_system("echo qwery | e4crypt add_key "TESTDIR_FLAGGED));
+
+	if (TST_RET == 0)
+		tst_res(TINFO, "Encryption flag is added to %s",
+			TESTDIR_FLAGGED);
+	else
+		tst_res(TFAIL | TERRNO,
+			"Encryption flag failed to add to %s", TESTDIR_FLAGGED);
+
+	if (WEXITSTATUS(TST_RET) == COMMAND_NOT_FOUND)
+		encrypt_flag = 1;
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
+	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
+
+	encrypt_flag_setup();
+	caid_flags_setup();
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_device = 1,
+	.mntpoint = MOUNT_POINT,
+	.mount_device = 1,
+	.dev_fs_type = "ext4",
+	.dev_extra_opt = "-O encrypt",
+	.dev_min_size = 512,
+};
-- 
2.11.0

