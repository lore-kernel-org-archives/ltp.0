Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WL1ZY-0000YS-2z
	for ltp-list@lists.sourceforge.net; Wed, 05 Mar 2014 02:28:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WL1ZW-0001TU-Gz
	for ltp-list@lists.sourceforge.net; Wed, 05 Mar 2014 02:28:40 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s252SUC5012078
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Mar 2014 10:28:30 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 5 Mar 2014 10:26:50 +0800
Message-Id: <1393986411-29379-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1393986411-29379-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1393986411-29379-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH v2 2/3] m4/ltp-fallocate.m4: add configure check for
	fallocate(2)
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

ltp-fallocate.m4: create a configure check for fallocate() syscall and
define the wrapper only when it's not available.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 configure.ac                                    |  1 +
 m4/ltp-fallocate.m4                             | 25 +++++++++++++++++++++++++
 testcases/kernel/syscalls/fallocate/fallocate.h |  3 +++
 3 files changed, 29 insertions(+)
 create mode 100644 m4/ltp-fallocate.m4

diff --git a/configure.ac b/configure.ac
index ea6fa85..0004a55 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,5 +172,6 @@ LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
 LTP_CHECK_MKDIRAT
 LTP_CHECK_FCHOWNAT
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
-- 
1.8.2.1


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
