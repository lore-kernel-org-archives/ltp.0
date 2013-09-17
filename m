Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VLtNA-0004as-Bd
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 11:23:12 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VLtN6-0005LT-Re
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 11:23:12 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8HBN1MW007045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 11:23:02 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8HBN13K015343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 11:23:01 GMT
Received: from abhmt110.oracle.com (abhmt110.oracle.com [141.146.116.62])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8HBN1aU015333
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 11:23:01 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 Sep 2013 15:22:24 +0400
Message-Id: <1379416944-25583-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] mk/module.mk: add Makefile to build kernel modules
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

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/mk/module.mk |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 include/mk/module.mk

diff --git a/include/mk/module.mk b/include/mk/module.mk
new file mode 100644
index 0000000..99d4c0a
--- /dev/null
+++ b/include/mk/module.mk
@@ -0,0 +1,43 @@
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
+include $(top_srcdir)/include/mk/env_pre.mk
+
+export abs_srcdir
+
+MAKE_TARGETS	+= $(addsuffix .ko, $(MODULE_NAMES))
+
+# Ignoring the exit status of commands is done to be forward compatible with
+# kernel internal API changes. The user-space test will return TCONF, if it
+# doesn't find the module (i.e. it wasn't built either due to kernel-devel
+# missing or module build failure).
+%.ko: %.c
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+	-rm -rf *.mod.c *.o modules.order .tmp* .*.ko .*.cmd Module.symvers
+
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
