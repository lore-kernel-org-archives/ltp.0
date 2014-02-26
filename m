Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WIWgX-0002Tr-Ew
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 05:05:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WIWgU-0000Ct-T0
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 05:05:33 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1Q55JhF009926
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 13:05:19 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 26 Feb 2014 13:03:48 +0800
Message-Id: <1393391028-9854-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] fallocate/fallocate02.c: fix compilation error on
	RHEL5.10
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

add #define _GNU_SOURCE in order to have LLONG_MAX defined in RHEL5.10.

ltp-fallocate.m4: create a configure check for fallocate() syscall and
define the wrapper only when it's not available.

fallocate02.c: delete this test item "{&fdw, FNAMEW, DEFAULT_TEST_MODE,
BLOCKS_WRITTEN-OFFSET, 1, 0}". Fallocate02 is to test various error
conditions for fallocate() syscall, usually these error conditions
can be checked in vfs layer. Here this test item, which the expected
return value is 0, is dependent on whether the underlying file systems
implement fallocate. So here we choose to remove it, or may specify a
block device, which contains a ext4 file system.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 configure.ac                                      |  1 +
 m4/ltp-fallocate.m4                               | 25 +++++++++++++++++++++++
 testcases/kernel/syscalls/fallocate/fallocate.h   |  3 +++
 testcases/kernel/syscalls/fallocate/fallocate02.c |  2 +-
 4 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 m4/ltp-fallocate.m4

diff --git a/configure.ac b/configure.ac
index 89a86b3..b954ede 100644
--- a/configure.ac
+++ b/configure.ac
@@ -171,5 +171,6 @@ LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_MKDIRAT
+LTP_CHECK_FALLOCATE
 
 AC_OUTPUT
diff --git a/m4/ltp-fallocate.m4 b/m4/ltp-fallocate.m4
new file mode 100644
index 0000000..c7d509e
--- /dev/null
+++ b/m4/ltp-fallocate.m4
@@ -0,0 +1,25 @@
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
+dnl LTP_CHECK_FALLOCATE
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_FALLOCATE],[
+AC_CHECK_FUNCS(fallocate,,)
+])
diff --git a/testcases/kernel/syscalls/fallocate/fallocate.h b/testcases/kernel/syscalls/fallocate/fallocate.h
index 358e610..22b2f51 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate.h
+++ b/testcases/kernel/syscalls/fallocate/fallocate.h
@@ -23,8 +23,10 @@
 
 #include <sys/types.h>
 #include <endian.h>
+#include "config.h"
 #include "linux_syscall_numbers.h"
 
+#if !defined(HAVE_FALLOCATE)
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 	/* Deal with 32bit ABIs that have 64bit syscalls. */
@@ -40,5 +42,6 @@ static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 						  (off_t) len));
 #endif
 }
+#endif
 
 #endif /* FALLOCATE_H */
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index 6412050..f2d466b 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -24,6 +24,7 @@
  *	check fallocate() with various error conditions that should produce
  *	EBADF, EINVAL and EFBIG.
  */
+#define _GNU_SOURCE
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -73,7 +74,6 @@ static struct test_data_t {
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
-	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN-OFFSET, 1, 0},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, MAX_FILESIZE, 1, EFBIG},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 1, MAX_FILESIZE, EFBIG},
 };
-- 
1.8.2.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
