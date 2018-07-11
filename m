From: tarun <tarun@zilogic.com>
Date: Wed, 11 Jul 2018 13:24:09 -0000
Subject: [LTP] [PATCH v1] Testing statx syscall
Message-ID: <20180711132409.3992-1-tarun@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


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

 * statx04.sh: This script will check attribute flag by defining flag
   to that directory and checks another directory no flags. It
   contains helper c file to get attribute status

Signed-off-by: Tarun.T.U <tarun@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
---
 include/lapi/statx.h                          | 161 ++++++++++++++++
 include/lapi/syscalls/arm.in                  |   1 +
 include/lapi/syscalls/i386.in                 |   1 +
 include/lapi/syscalls/powerpc.in              |   1 +
 include/lapi/syscalls/powerpc64.in            |   1 +
 include/lapi/syscalls/s390.in                 |   1 +
 include/lapi/syscalls/sparc.in                |   1 +
 include/lapi/syscalls/sparc64.in              |   1 +
 include/lapi/syscalls/x86_64.in               |   1 +
 runtest/syscalls                              |   8 +
 testcases/kernel/syscalls/statx/Makefile      |  29 +++
 .../kernel/syscalls/statx/helper_statx04.c    |  84 ++++++++
 testcases/kernel/syscalls/statx/statx01.c     | 164 ++++++++++++++++
 testcases/kernel/syscalls/statx/statx02.c     | 133 +++++++++++++
 testcases/kernel/syscalls/statx/statx03.c     | 136 +++++++++++++
 testcases/kernel/syscalls/statx/statx04.sh    | 179 ++++++++++++++++++
 16 files changed, 902 insertions(+)
 create mode 100644 include/lapi/statx.h
 create mode 100644 testcases/kernel/syscalls/statx/Makefile
 create mode 100644 testcases/kernel/syscalls/statx/helper_statx04.c
 create mode 100644 testcases/kernel/syscalls/statx/statx01.c
 create mode 100644 testcases/kernel/syscalls/statx/statx02.c
 create mode 100644 testcases/kernel/syscalls/statx/statx03.c
 create mode 100755 testcases/kernel/syscalls/statx/statx04.sh

diff --git a/include/lapi/statx.h b/include/lapi/statx.h
new file mode 100644
index 000000000..e59d3bef6
--- /dev/null
+++ b/include/lapi/statx.h
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+#ifndef STATX_H
+#define STATX_H
+
+#include <asm-generic/types.h>
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
+	__s64	tv_sec;
+	__u32	tv_nsec;
+	__s32	__reserved;
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
+	__u32	stx_mask;
+	__u32	stx_blksize;
+	__u64	stx_attributes;
+	/* 0x10 */
+	__u32	stx_nlink;
+	__u32	stx_uid;
+	__u32	stx_gid;
+	__u16	stx_mode;
+	__u16	__spare0[1];
+	/* 0x20 */
+	__u64	stx_ino;
+	__u64	stx_size;
+	__u64	stx_blocks;
+	__u64	stx_attributes_mask;
+	/* 0x40 */
+	const struct statx_timestamp	stx_atime;
+	const struct statx_timestamp	stx_btime;
+	const struct statx_timestamp	stx_ctime;
+	const struct statx_timestamp	stx_mtime;
+	/* 0x80 */
+	__u32	stx_rdev_major;
+	__u32	stx_rdev_minor;
+	__u32	stx_dev_major;
+	__u32	stx_dev_minor;
+	/* 0x90 */
+	__u64	__spare2[14];
+	/* 0x100 */
+};
+
+/*
+ * Flags to be stx_mask
+ *
+ * Query request/result mask for statx() and struct statx::stx_mask.
+ *
+ * These bits should be set in the mask argument of statx() to request
+ * particular items when calling statx().
+ */
+#define STATX_TYPE		0x00000001U
+#define STATX_MODE		0x00000002U
+#define STATX_NLINK		0x00000004U
+#define STATX_UID		0x00000008U
+#define STATX_GID		0x00000010U
+#define STATX_ATIME		0x00000020U
+#define STATX_MTIME		0x00000040U
+#define STATX_CTIME		0x00000080U
+#define STATX_INO		0x00000100U
+#define STATX_SIZE		0x00000200U
+#define STATX_BLOCKS		0x00000400U
+#define STATX_BASIC_STATS	0x000007ffU
+#define STATX_BTIME		0x00000800U
+#define STATX_ALL		0x00000fffU
+#define STATX__RESERVED		0x80000000U
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
+#define STATX_ATTR_COMPRESSED	0x00000004
+#define STATX_ATTR_IMMUTABLE	0x00000010
+#define STATX_ATTR_APPEND	0x00000020
+#define STATX_ATTR_NODUMP	0x00000040
+#define STATX_ATTR_ENCRYPTED	0x00000800
+
+#define STATX_ATTR_AUTOMOUNT	0x00001000
+#define AT_SYMLINK_NOFOLLOW	0x100
+#define AT_REMOVEDIR		0x200
+#define AT_SYMLINK_FOLLOW	0x400
+#define AT_NO_AUTOMOUNT		0x800
+#define AT_EMPTY_PATH		0x1000
+
+#define AT_STATX_SYNC_TYPE	0x6000
+#define AT_STATX_SYNC_AS_STAT	0x0000
+#define AT_STATX_FORCE_SYNC	0x2000
+#define AT_STATX_DONT_SYNC	0x4000
+
+#endif
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 71a4b713d..784b64004 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -341,3 +341,4 @@ renameat2 (__NR_SYSCALL_BASE+382)
 getrandom (__NR_SYSCALL_BASE+384)
 memfd_create (__NR_SYSCALL_BASE+385)
 copy_file_range (__NR_SYSCALL_BASE+391)
+statx (__NR_SYSCALL+397)
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 0f9601472..453ac3e4e 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -341,3 +341,4 @@ renameat2 354
 getrandom 355
 memfd_create 356
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
index 98c861f36..486205030 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -332,3 +332,4 @@ renameat2 347
 getrandom 349
 memfd_create 350
 copy_file_range 375
+statx 379
\ No newline at end of file
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
index 89db79404..11a7b74ca 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -308,3 +308,4 @@ renameat2 316
 getrandom 318
 memfd_create 319
 copy_file_range 326
+statx 332
diff --git a/runtest/syscalls b/runtest/syscalls
index a9afecf57..f77e535c3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1275,6 +1275,14 @@ statfs03_64 statfs03_64
 statvfs01 statvfs01
 statvfs02 statvfs02
 
+statx01 statx01
+statx01_64 statx01_64
+statx02 statx02
+statx02_64 statx02_64
+statx03 statx03
+statx03_64 statx03_64
+statx04 statx04.sh
+
 stime01 stime01
 stime02 stime02
 
diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
new file mode 100644
index 000000000..11585938d
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/Makefile
@@ -0,0 +1,29 @@
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
+include $(abs_srcdir)/../utils/newer_64.mk
+
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
+
+
+INSTALL_TARGETS	:= statx04.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/statx/helper_statx04.c b/testcases/kernel/syscalls/statx/helper_statx04.c
new file mode 100644
index 000000000..8f5d05728
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/helper_statx04.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+/*
+ *
+ * This code will check the state of the attribute flag for the file
+ * which is passed by command line argument. If the flag is set, it will
+ * return "yes" along with flag name. If the flag is not set, it will
+ * return no along with flag name.
+ *
+ * Minimum Kernel version required is 4.11.
+ */
+#include <stdio.h>
+#include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <pwd.h>
+#include <errno.h>
+#include <error.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <fcntl.h>
+#include "lapi/statx.h"
+#include "lapi/syscalls.h"
+
+static int sys_statx(int dirfd, const char *pathname, int flags,
+		     unsigned int mask, struct statx *statxbuf)
+{
+	return syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+}
+
+static void check_flag_state(uint32_t attr, uint32_t flag, char *flag_name)
+{
+	if (attr & flag)
+		printf("%s: Yes\n", flag_name);
+	else
+		printf("%s: No\n", flag_name);
+}
+
+int main(int argc, char *argv[])
+{
+	struct statx buff;
+	int ret;
+
+	if (argc != 2)
+		error(1, 0, "Usage error: ./helper_statx04 <file-name>");
+
+	ret = sys_statx(AT_FDCWD, argv[1], 0, 0, &buff);
+	if (ret != 0)
+		error(1, errno, "Error statx");
+
+	check_flag_state(buff.stx_attributes, STATX_ATTR_COMPRESSED,
+			 "STATX_ATTR_COMPRESSED");
+
+	check_flag_state(buff.stx_attributes, STATX_ATTR_APPEND,
+			 "STATX_ATTR_APPEND");
+
+	check_flag_state(buff.stx_attributes, STATX_ATTR_IMMUTABLE,
+			 "STATX_ATTR_IMMUTABLE");
+
+	check_flag_state(buff.stx_attributes, STATX_ATTR_ENCRYPTED,
+			 "STATX_ATTR_ENCRYPTED");
+
+	check_flag_state(buff.stx_attributes, STATX_ATTR_NODUMP,
+			 "STATX_ATTR_NODUMP");
+
+	return 0;
+}
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
new file mode 100644
index 000000000..e00c088ed
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/syscalls.h"
+#include "lapi/statx.h"
+
+#define TESTFILE "tst_file"
+#define DEVICEFILE "blk_dev"
+#define MODE 0644
+
+static int tst_file_fd;
+static uint32_t uid;
+static uint32_t gid;
+#define SIZE 256
+#define MAJOR 8
+#define MINOR 1
+
+static int sys_statx(int dirfd, const char *pathname, unsigned int flags,
+		     unsigned int mask, struct statx *statxbuf)
+{
+	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+}
+
+static void assert_are_equal(uint32_t expected_data, uint32_t obtained_data,
+			     char *meta_data_name)
+{
+	if (expected_data == obtained_data)
+		tst_res(TPASS, "Statx metadata %s obtained as expected"
+			, meta_data_name);
+	else
+		tst_res(TFAIL, "Statx metadata %s failed to get expected data"
+			, meta_data_name);
+}
+
+static void test_normal_file(void)
+{
+	struct statx buff;
+	uint32_t blocks;
+
+	TEST(sys_statx(AT_FDCWD, TESTFILE, 0, 0, &buff));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "Syscall passed for normal file");
+	else
+		tst_res(TFAIL, "Syscall failed for normal file");
+
+	if ((SIZE % buff.stx_blksize) == 0)
+		blocks = (SIZE / 512);
+	else
+		blocks = (((SIZE / buff.stx_blksize) + 1) *
+			  (buff.stx_blksize / 512));
+
+	assert_are_equal(uid, buff.stx_uid, "uid");
+	assert_are_equal(gid, buff.stx_gid, "gid");
+	assert_are_equal(SIZE, buff.stx_size, "size");
+	assert_are_equal(MODE, (buff.stx_mode & ~(S_IFMT)), "mode");
+	assert_are_equal(blocks, buff.stx_blocks, "blocks");
+}
+
+static void test_device_file(void)
+{
+	struct statx buff;
+
+	TEST(sys_statx(AT_FDCWD, DEVICEFILE, 0, 0, &buff));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "Syscall for dev file passed");
+	else
+		tst_res(TFAIL, "Syscall for dev file failed");
+
+	assert_are_equal(MAJOR, buff.stx_rdev_major, "Rdev MAJOR number");
+	assert_are_equal(MINOR, buff.stx_rdev_minor, "Rdev Minor number");
+}
+
+static void run(void)
+{
+	test_normal_file();
+	test_device_file();
+}
+
+static void setup(void)
+{
+	char data_buff[SIZE];
+	struct passwd *ltpuser;
+
+	memset(data_buff, '@', sizeof(data_buff));
+
+	tst_file_fd =  SAFE_OPEN(TESTFILE, O_RDWR|O_CREAT, MODE);
+	SAFE_WRITE(0, tst_file_fd, data_buff, sizeof(data_buff));
+
+	ltpuser = SAFE_GETPWNAM("nobody");
+	uid = ltpuser->pw_uid;
+	gid = ltpuser->pw_gid;
+
+	SAFE_CHOWN(TESTFILE, uid, gid);
+
+	SAFE_MKNOD(DEVICEFILE, S_IFBLK | 0777, makedev(MAJOR, MINOR));
+}
+
+static void cleanup(void)
+{
+	if (tst_file_fd > 0)
+		SAFE_CLOSE(tst_file_fd);
+
+	SAFE_UNLINK(TESTFILE);
+	SAFE_UNLINK(DEVICEFILE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
new file mode 100644
index 000000000..85497c3de
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+#include "lapi/syscalls.h"
+#include "lapi/statx.h"
+
+#define TESTFILE "tst_temp"
+#define LINK_FILE "tst_temp_ln"
+#define MODE 0644
+#define SIZE 14
+
+static int tst_file_fd;
+
+static int sys_statx(int dirfd, const char *pathname, int flags,
+		     unsigned int mask, struct statx *statxbuf)
+{
+	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+}
+
+static void test_empty_path(void)
+{
+	struct statx buf;
+
+	TEST(sys_statx(tst_file_fd, "", AT_EMPTY_PATH, 0, &buf));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "Syscall passed for flag empty pathname");
+	else
+		tst_res(TFAIL, "Syscall failed for flag empty pathname");
+
+	if (buf.stx_size == SIZE)
+		tst_res(TPASS, "Statx got metadata by using empty_pathname");
+	else
+		tst_res(TFAIL,
+			"Statx failed to get metadata by using empty_pathname");
+
+}
+
+static void test_sym_link(void)
+{
+	struct statx test_file_buf;
+	struct statx link_file_buf;
+
+	TEST(sys_statx(AT_FDCWD, TESTFILE, 0, 0, &test_file_buf));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "Syscall passed for testfile");
+	else
+		tst_res(TFAIL, "Syscall failed for testfile");
+
+	TEST(sys_statx(AT_FDCWD, LINK_FILE, AT_SYMLINK_NOFOLLOW, 0,
+		       &link_file_buf));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "Syscall passed for flag symlink");
+	else
+		tst_res(TFAIL, "Syscall failed for flag symlink");
+
+	if (test_file_buf.stx_ino != link_file_buf.stx_ino)
+		tst_res(TPASS, "Statx got metadata of symlink file");
+	else
+		tst_res(TFAIL, "Statx failed to get symlink data");
+}
+
+static void run_test(void)
+{
+	test_empty_path();
+	test_sym_link();
+}
+
+static void setup(void)
+{
+	char data_buf[SIZE] = "LinusTorvalds";
+
+	tst_file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, MODE);
+	SAFE_WRITE(0, tst_file_fd, data_buf, sizeof(data_buf));
+
+	SAFE_SYMLINK(TESTFILE, LINK_FILE);
+}
+
+static void cleanup(void)
+{
+	if (tst_file_fd > 0)
+		SAFE_CLOSE(tst_file_fd);
+
+	SAFE_UNLINK(TESTFILE);
+	SAFE_UNLINK(LINK_FILE);
+}
+
+static struct tst_test test = {
+	.test_all = run_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
new file mode 100644
index 000000000..afe4af9da
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx03.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0 or later
+/*
+ * Copyright (c) Zilogic Systems Pvt. Ltd., 2007
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
+#include "lapi/syscalls.h"
+#include "lapi/statx.h"
+
+#define TESTFILE "tst_temp"
+#define MODE 0644
+
+static int tst_file_fd;
+static char long_pathname[257];
+
+static const struct test_case_t {
+	uint32_t dfd;
+	char *filename;
+	uint32_t flag;
+	uint32_t mask;
+	int32_t errnum;
+	char *error_name;
+} test_cases[] = {
+	{.dfd = -1, .filename = TESTFILE, .flag = 0,
+	 .mask = 0, .errnum = EBADF, .error_name = "EBADF"},
+
+	{.dfd = AT_FDCWD, .filename = NULL, .flag = 0,
+	 .mask = 0, .errnum = EFAULT, .error_name = "EFAULT"},
+
+	{.dfd = AT_FDCWD, .filename = TESTFILE, .flag = -1,
+	 .mask = 0, .errnum = EINVAL, .error_name = "EINVAL"},
+
+	{.dfd = AT_FDCWD, .filename = TESTFILE, .flag = 0,
+	 .mask = -1, .errnum = EINVAL, .error_name = "EINVAL"},
+
+	{.dfd = AT_FDCWD, .filename = "", .flag = 0,
+	 .mask = 0, .errnum = ENOENT, .error_name = "ENOENT"},
+
+	{.dfd = 1, .filename = TESTFILE, .flag = 0,
+	 .mask = 0, .errnum = ENOTDIR, .error_name = "ENOTDIR"},
+
+	{.dfd = AT_FDCWD, .filename = long_pathname, .flag = 0,
+	 .mask = 0, .errnum = ENAMETOOLONG, .error_name = "ENAMETOOLONG"},
+};
+
+static int sys_statx(int dirfd, const char *pathname, int flags,
+		     unsigned int mask, struct statx *statxbuf)
+{
+	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+}
+
+
+static void run_test(unsigned int i)
+{
+	struct statx buf;
+
+	TEST(sys_statx(test_cases[i].dfd,
+		       test_cases[i].filename,
+		       test_cases[i].flag, test_cases[i].mask, &buf));
+
+	if (TEST_RETURN == 0)
+		tst_res(TFAIL, "statx didn't set errno to %s as expected",
+			test_cases[i].error_name);
+	else if (test_cases[i].errnum == TEST_ERRNO)
+		tst_res(TPASS, "statx set errno to %s as expected",
+			test_cases[i].error_name);
+	else
+		tst_res(TFAIL | TERRNO,
+			"statx set errno to some unexpected value");
+}
+
+static void setup(void)
+{
+	tst_file_fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, MODE);
+
+	memset(long_pathname, '@', sizeof(long_pathname));
+	long_pathname[sizeof(long_pathname) - 1] = 0;
+}
+
+static void cleanup(void)
+{
+	if (tst_file_fd > 0)
+		SAFE_CLOSE(tst_file_fd);
+
+	SAFE_UNLINK(TESTFILE);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(test_cases),
+	.test = run_test,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.11",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/statx/statx04.sh b/testcases/kernel/syscalls/statx/statx04.sh
new file mode 100755
index 000000000..0e358197d
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx04.sh
@@ -0,0 +1,179 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0 or later
+#
+# Copyright (c) Zilogic Systems Pvt. Ltd., 2007
+# Email: code@zilogic.com
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+#
+# Test statx
+#
+# This code tests if the attributes field of statx received expected value.
+# File set with following flags by using chattr and encrypt:
+# 1) STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
+# 2) STATX_ATTR_IMMUTABLE - The file cannot be modified.
+# 3) STATX_ATTR_APPEND - The file can only be opened in append mode for writing.
+# 4) STATX_ATTR_NODUMP - File is not a candidate for backup when a backup program
+#                        such as dump(8) is run.
+# 5) STATX_ATTR_ENCRYPTED - A key is required for the file to be encrypted by
+#                          the filesystem.
+#
+# A test directory is created with a file in it.
+# chattr command is used to modify the atttributes of the file such as
+# compressed, append, nodump and immutable.
+# tune2fs tool is used to set the encrypt flag.
+# Two files are tested.
+# First file has all flags set.
+# Second file has no flags set.
+# A helper function in C is used to execute statx syscall.
+#
+# Minimum Kernel version required is 4.11.
+#
+
+TST_MIN_KVER=4.11
+TST_CNT=2
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMD="truncate chattr tune2fs mount chattr"
+TST_TESTFUNC=test
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+. tst_test.sh
+
+setup()
+{
+    # FIXME: Encrypt requirement 512 MB needs to be checked   
+    truncate -s 512M storage
+
+    tst_mkfs ext4 storage
+    tune2fs -O encrypt storage
+
+    mkdir mnt_point
+    mount storage mnt_point
+    
+    cd mnt_point
+    mkdir dir_attr_defined
+    mkdir dir_attr_undefined
+    echo "qwerty" | e4crypt add_key dir_attr_defined
+    cd ..
+    chattr -RV +aidc mnt_point/dir_attr_defined
+}
+
+test1()
+{
+    output_attr_defined=$($LTPROOT/testcases/bin/helper_statx04 ./mnt_point/dir_attr_defined)
+
+    ret_val=$?
+
+    if [ $ret_val -eq 0 ]
+    then
+        tst_res TINFO "Succesfully ran executable"
+    else
+	tst_brk "Fail to run executable"
+    fi
+
+    if [ $(echo "$output_attr_defined" | grep "STATX_ATTR_COMPRESSED" | grep -o Yes) = "Yes" ]
+    then
+        tst_res TPASS "statx compressed flag is set"
+    else
+        tst_res TFAIL "statx compressed flag is not set"
+    fi
+
+    if [ $(echo "$output_attr_defined" | grep "STATX_ATTR_IMMUTABLE" | grep -o Yes) = "Yes" ]
+    then
+        tst_res TPASS "statx immutable flag is set"
+    else
+        tst_res TFAIL "statx immutable flag is not set"
+    fi
+
+    if [ $(echo "$output_attr_defined" | grep "STATX_ATTR_ENCRYPTED" | grep -o Yes)  = "Yes" ]
+    then
+        tst_res TPASS "statx encrypted flag is set"
+    else
+        tst_res TFAIL "statx encrypted flag is not set"
+    fi
+
+    if [ $(echo "$output_attr_defined" | grep "STATX_ATTR_NODUMP" | grep -o Yes)  = "Yes" ]
+    then
+        tst_res TPASS "statx nodump flag is set"
+    else
+        tst_res TFAIL "statx nodump flag is not set"
+    fi
+
+    if [ $(echo "$output_attr_defined" | grep "STATX_ATTR_APPEND" | grep -o Yes)  = "Yes" ]
+    then
+        tst_res TPASS "statx append flag is set"
+    else
+        tst_res TFAIL "statx append flag is not set"
+    fi
+}
+
+test2()
+{
+    output_attr_undefined=$($LTPROOT/testcases/bin/helper_statx04 ./mnt_point/dir_attr_undefined)
+
+    ret_val=$?
+
+    if [ $ret_val -eq 0 ]
+    then
+        tst_res TINFO "Succesfully ran executable"
+    else
+	tst_brk "Fail to run executable"
+    fi
+
+    if [ $(echo "$output_attr_undefined" | grep "STATX_ATTR_COMPRESSED" | grep -o No) = "No" ]
+    then
+        tst_res TPASS "statx compressed flag is Not set"
+    else
+        tst_res TFAIL "statx compressed flag is set"
+    fi
+
+    if [ $(echo "$output_attr_undefined" | grep "STATX_ATTR_IMMUTABLE" | grep -o No) = "No" ]
+    then
+        tst_res TPASS "statx immutable flag is Not set"
+    else
+        tst_res TFAIL "statx immutable flag is set"
+    fi
+
+    if [ $(echo "$output_attr_undefined" | grep "STATX_ATTR_ENCRYPTED" | grep -o No) = "No" ]
+    then
+        tst_res TPASS "statx encrypted flag is Not set"
+    else
+        tst_res TFAIL "statx encrypted flag is set"
+    fi
+
+    if [ $(echo "$output_attr_undefined" | grep "STATX_ATTR_NODUMP" | grep -o No) = "No" ]
+    then
+        tst_res TPASS "statx Nodump flag is Not set"
+    else
+        tst_res TFAIL "statx Nodump flag is set"
+    fi
+
+    if [ $(echo "$output_attr_undefined" | grep "STATX_ATTR_APPEND" | grep -o No) = "No" ]
+    then
+        tst_res TPASS "statx append flag is Not set"
+    else
+        tst_res TFAIL "statx append flag is set"
+    fi
+}
+
+cleanup()
+{
+    chattr -RV -aidc mnt_point/dir_attr_defined
+    umount mnt_point/
+    rm -rf mnt_point
+    rm -rf storage
+}
+
+tst_run
-- 
2.17.1

