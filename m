Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1VQyCM-000289-5d
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 11:33:02 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VQyCL-0008B8-8f
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 11:33:02 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r91BWsEr000403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 11:32:55 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r91BWrIY005099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 11:32:54 GMT
Received: from abhmt101.oracle.com (abhmt101.oracle.com [141.146.116.53])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r91BWrMY008772
	for <ltp-list@lists.sourceforge.net>; Tue, 1 Oct 2013 11:32:53 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  1 Oct 2013 15:32:25 +0400
Message-Id: <1380627145-21429-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v4] mk/module.mk: add Makefile to build kernel modules
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

ifneq ($(KERNELRELEASE),)

obj-m := module01.o

else

top_srcdir	?= ../../../..
include $(top_srcdir)/include/mk/testcases.mk

REQ_VERSION_MAJOR	:= 2
REQ_VERSION_PATCH	:= 6
MAKE_TARGETS		:= test01 test02 module01.ko

include $(top_srcdir)/include/mk/module.mk
include $(top_srcdir)/include/mk/generic_leaf_target.mk

endif

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/mk/module.mk |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 include/mk/module.mk

diff --git a/include/mk/module.mk b/include/mk/module.mk
new file mode 100644
index 0000000..b903e8f
--- /dev/null
+++ b/include/mk/module.mk
@@ -0,0 +1,46 @@
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
+# REQ_VERSION_MAJOR and REQ_VERSION_PATCH must be defined beforehand.
+#
+
+$(if $(REQ_VERSION_MAJOR),,$(error You must define REQ_VERSION_MAJOR))
+$(if $(REQ_VERSION_PATCH),,$(error You must define REQ_VERSION_MINOR))
+
+ifneq ($(filter install clean,$(MAKECMDGOALS)),)
+SKIP := 2
+endif
+
+SKIP ?= $(shell [ "$(WITH_MODULES)" = yes ] && \
+	[ $(LINUX_VERSION_MAJOR) -gt $(REQ_VERSION_MAJOR) ] || \
+	[ $(LINUX_VERSION_MAJOR) -eq $(REQ_VERSION_MAJOR) -a \
+	  $(LINUX_VERSION_PATCH) -ge $(REQ_VERSION_PATCH) ]; echo $$?)
+
+ifneq ($(SKIP),0)
+MAKE_TARGETS := $(filter-out %.ko, $(MAKE_TARGETS))
+MAKE_TARGETS += $(if $(filter 2,$(SKIP)),$(wildcard *.ko),)
+endif
+
+# Ignoring the exit status of commands is done to be forward compatible with
+# kernel internal API changes. The user-space test will return TCONF, if it
+# doesn't find the module (i.e. it wasn't built either due to kernel-devel
+# missing or module build failure).
+%.ko: %.c
+	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+	rm -rf *.mod.c *.o modules.order .tmp* .*.ko .*.cmd Module.symvers
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
