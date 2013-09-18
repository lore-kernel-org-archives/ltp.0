Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VMD8J-0004E2-MK
	for ltp-list@lists.sourceforge.net; Wed, 18 Sep 2013 08:29:11 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VMD8H-0002LS-SQ
	for ltp-list@lists.sourceforge.net; Wed, 18 Sep 2013 08:29:11 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8I8T3aG012331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Sep 2013 08:29:03 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8I8T2lN021992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Sep 2013 08:29:02 GMT
Received: from abhmt116.oracle.com (abhmt116.oracle.com [141.146.116.68])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8I8T1Ds016572
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Sep 2013 08:29:01 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Sep 2013 12:28:29 +0400
Message-Id: <1379492909-19596-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2] mk/module.mk: add Makefile to build kernel modules
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
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Makefile example:

top_srcdir	?= ../../../..

REQ_VERSION_MAJOR	:= 2
REQ_VERSION_PATCH	:= 6

MODULE_NAMES	:= Module01 Module02 ...
MAKE_TARGETS	:= test01 test02 ...

include $(top_srcdir)/include/mk/module.mk

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/mk/module.mk |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100644 include/mk/module.mk

diff --git a/include/mk/module.mk b/include/mk/module.mk
new file mode 100644
index 0000000..25f0903
--- /dev/null
+++ b/include/mk/module.mk
@@ -0,0 +1,69 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+#
+# Include it to build kernel modules.
+# MODULE_NAMES must be defined beforehand.
+#
+
+ifneq ($(KERNELRELEASE),)
+
+obj-m		:= $(addsuffix .o, $(MODULE_NAMES))
+
+else
+
+# included in case user-space tests must be built as well
+include $(top_srcdir)/include/mk/testcases.mk
+
+export top_srcdir	:= $(abs_srcdir)/$(top_srcdir)
+
+ifeq ($(MAKECMDGOALS),clean)
+SKIP := 0
+endif
+
+ifeq ($(WITH_MODULES),yes)
+
+ifneq ($(REQ_VERSION_MAJOR),)
+SKIP ?= $(shell test $(LINUX_VERSION_MAJOR) -gt $(REQ_VERSION_MAJOR); echo $$?)
+
+ifeq ($(SKIP),1)
+SKIP := $(shell test $(LINUX_VERSION_MAJOR) -eq $(REQ_VERSION_MAJOR); echo $$?)
+ifeq ($(SKIP),0)
+SKIP := $(shell test $(LINUX_VERSION_PATCH) -ge $(REQ_VERSION_PATCH); echo $$?)
+endif
+endif
+
+else
+SKIP ?= 0
+endif
+
+endif
+
+ifeq ($(SKIP),0)
+MAKE_TARGETS	+= $(addsuffix .ko, $(MODULE_NAMES))
+endif
+
+# Ignoring the exit status of commands is done to be forward compatible with
+# kernel internal API changes. The user-space test will return TCONF, if it
+# doesn't find the module (i.e. it wasn't built either due to kernel-devel
+# missing or module build failure).
+%.ko: %.c
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+	-rm -rf *.mod.c *.o modules.order .tmp* .*.ko .*.cmd Module.symvers
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+endif
-- 
1.7.1


------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
