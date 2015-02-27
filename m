Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YRG6E-00089u-Of
	for ltp-list@lists.sourceforge.net; Fri, 27 Feb 2015 08:16:42 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YRG6D-0007u3-HP
	for ltp-list@lists.sourceforge.net; Fri, 27 Feb 2015 08:16:42 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1R8Fn79019187
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Feb 2015 16:15:49 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 27 Feb 2015 16:12:10 +0800
Message-ID: <1425024732-30751-7-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1425024732-30751-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1425024732-30751-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 7/9] power_management: install lib/pm_sched_mc.py
	into testcases/bin directory
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Install lib/pm_sched_mc.py into testcases/bin instead of
testcases/bin/lib directory, and modify the corresponding
call files, eg. pm_cpu_consolidation.py.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/power_management/Makefile         | 10 ++++-----
 testcases/kernel/power_management/lib/Makefile     | 25 ++++++++++++++++++++++
 .../power_management/pm_cpu_consolidation.py       |  3 ++-
 testcases/kernel/power_management/pm_ilb_test.py   |  3 ++-
 .../kernel/power_management/pm_sched_domain.py     |  3 ++-
 5 files changed, 35 insertions(+), 9 deletions(-)
 create mode 100644 testcases/kernel/power_management/lib/Makefile

diff --git a/testcases/kernel/power_management/Makefile b/testcases/kernel/power_management/Makefile
index 24f75f8..935f47e 100644
--- a/testcases/kernel/power_management/Makefile
+++ b/testcases/kernel/power_management/Makefile
@@ -13,8 +13,8 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
 
@@ -22,10 +22,8 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-vpath %.c $(srcdir):$(top_srcdir)/lib
-
-INSTALL_TARGETS		:= lib/*.py *.py *.sh
+INSTALL_TARGETS 	:= *.py *.sh
 
 MAKE_DEPS		+= $(APICMDS_DIR)/tst_kvercmp
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/power_management/lib/Makefile b/testcases/kernel/power_management/lib/Makefile
new file mode 100644
index 0000000..2aadac0
--- /dev/null
+++ b/testcases/kernel/power_management/lib/Makefile
@@ -0,0 +1,25 @@
+#
+# Copyright (c) 2015 Fujitsu Ltd.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir 		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS 	:= *.py
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/power_management/pm_cpu_consolidation.py b/testcases/kernel/power_management/pm_cpu_consolidation.py
index 5aa3948..72822b7 100755
--- a/testcases/kernel/power_management/pm_cpu_consolidation.py
+++ b/testcases/kernel/power_management/pm_cpu_consolidation.py
@@ -7,7 +7,8 @@ import os
 import sys
 import time
 LIB_DIR = "%s/lib" % os.path.dirname(__file__)
-sys.path.append(LIB_DIR)
+if os.path.exists(LIB_DIR):
+    sys.path.append(LIB_DIR)
 from optparse import OptionParser
 from pm_sched_mc import *
 
diff --git a/testcases/kernel/power_management/pm_ilb_test.py b/testcases/kernel/power_management/pm_ilb_test.py
index 3f6ad46..b6a87e8 100755
--- a/testcases/kernel/power_management/pm_ilb_test.py
+++ b/testcases/kernel/power_management/pm_ilb_test.py
@@ -6,7 +6,8 @@
 import os
 import sys
 LIB_DIR = "%s/lib" % os.path.dirname(__file__)
-sys.path.append(LIB_DIR)
+if os.path.exists(LIB_DIR):
+    sys.path.append(LIB_DIR)
 from optparse import OptionParser
 from pm_sched_mc import *
 
diff --git a/testcases/kernel/power_management/pm_sched_domain.py b/testcases/kernel/power_management/pm_sched_domain.py
index a9e62a2..96cc355 100755
--- a/testcases/kernel/power_management/pm_sched_domain.py
+++ b/testcases/kernel/power_management/pm_sched_domain.py
@@ -6,7 +6,8 @@
 import os
 import sys
 LIB_DIR = "%s/lib" % os.path.dirname(__file__)
-sys.path.append(LIB_DIR)
+if os.path.exists(LIB_DIR):
+    sys.path.append(LIB_DIR)
 from pm_sched_mc import *
 from optparse import OptionParser
 
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
