Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZEcaB-00079h-M7
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 12:11:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEca7-0002Xd-NZ
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 12:11:39 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 46658C0179
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Jul 2015 12:11:29 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t6DCBRBQ009410
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jul 2015 08:11:28 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 Jul 2015 14:11:25 +0200
Message-Id: <fd54e759e3f74f43ac1076107c6d2f83f368ae10.1436789330.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] syscalls/getrandom: add configure check for
	linux/random.h
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

Old distros (such as RHEL5.6) break, when they try to include
some kernel headers directly. Add configure check to make sure
linux/random.h kernel header can be compiled without errors.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 configure.ac                                      |  1 +
 include/lapi/getrandom.h                          |  6 ++++++
 m4/ltp-linuxrandom.m4                             | 21 +++++++++++++++++++++
 testcases/kernel/syscalls/getrandom/getrandom01.c |  1 -
 testcases/kernel/syscalls/getrandom/getrandom02.c |  1 -
 testcases/kernel/syscalls/getrandom/getrandom03.c |  1 -
 testcases/kernel/syscalls/getrandom/getrandom04.c |  1 -
 7 files changed, 28 insertions(+), 4 deletions(-)
 create mode 100644 m4/ltp-linuxrandom.m4

diff --git a/configure.ac b/configure.ac
index 0ca21a6..0198ac7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -176,5 +176,6 @@ LTP_CHECK_TIMERFD
 LTP_CHECK_CAN_SUPPORT
 LTP_CHECK_IOVEC
 LTP_CHECK_KEYCTL
+LTP_CHECK_LINUXRANDOM
 
 AC_OUTPUT
diff --git a/include/lapi/getrandom.h b/include/lapi/getrandom.h
index 6d24c5d..f5609fc 100644
--- a/include/lapi/getrandom.h
+++ b/include/lapi/getrandom.h
@@ -19,6 +19,12 @@
 #ifndef __GETRANDOM_H__
 #define __GETRANDOM_H__
 
+#include "config.h"
+
+#if HAVE_LINUX_RANDOM_H
+#include <linux/random.h>
+#endif
+
 /*
  * Flags for getrandom(2)
  *
diff --git a/m4/ltp-linuxrandom.m4 b/m4/ltp-linuxrandom.m4
new file mode 100644
index 0000000..30c099e
--- /dev/null
+++ b/m4/ltp-linuxrandom.m4
@@ -0,0 +1,21 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2015
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
+
+dnl
+dnl LTP_CHECK_LINUXRANDOM
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_LINUXRANDOM],[
+AC_CHECK_HEADERS(linux/random.h, [], [], [])]
+)
diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
index 818372e..103748a 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -26,7 +26,6 @@
  *
  */
 
-#include <linux/random.h>
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
 #include "test.h"
diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index 905917b..0ac8bd2 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -27,7 +27,6 @@
  *
  */
 
-#include <linux/random.h>
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
 #include "test.h"
diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index 9c13d09..03950e0 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -30,7 +30,6 @@
  *  number of bytes required and expects success.
  */
 
-#include <linux/random.h>
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
 #include "test.h"
diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
index 4e099e1..10ab44b 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -30,7 +30,6 @@
  *  descriptors to 3 and expects success.
  */
 
-#include <linux/random.h>
 #include <sys/resource.h>
 #include "lapi/getrandom.h"
 #include "linux_syscall_numbers.h"
-- 
1.8.3.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
