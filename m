Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WBmLR-0003mm-4A
	for ltp-list@lists.sourceforge.net; Fri, 07 Feb 2014 14:23:53 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WBmLQ-0000zn-87
	for ltp-list@lists.sourceforge.net; Fri, 07 Feb 2014 14:23:53 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s17ENj0x027404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 14:23:46 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s17ENic9017357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 14:23:45 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s17ENhs4020325
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Feb 2014 14:23:44 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  7 Feb 2014 18:23:47 +0400
Message-Id: <1391783027-24290-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 3/4] lib: compile *_r.c to libltp_r library,
	add testcases_r.mk
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

Add rules to build *_r.c files. All compiled lib/*_r.c files will be
included in libltp_r.a library.
testcases_r.mk can be used in multi-threaded tests.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/mk/lib.mk         |   15 ++++++++++++++-
 include/mk/testcases_r.mk |   26 ++++++++++++++++++++++++++
 lib/Makefile              |    3 +++
 3 files changed, 43 insertions(+), 1 deletions(-)
 create mode 100644 include/mk/testcases_r.mk

diff --git a/include/mk/lib.mk b/include/mk/lib.mk
index 456db24..3bec31c 100644
--- a/include/mk/lib.mk
+++ b/include/mk/lib.mk
@@ -20,6 +20,7 @@
 # Garrett Cooper, July 2009
 #
 # Copyright (C) Cyril Hrubis <chrubis@suse.cz> 2012
+# Copyright (C) 2014 Oracle and/or its affiliates. All Rights Reserved.
 #
 
 # Makefile to include for libraries.
@@ -46,7 +47,7 @@ ifneq ($(MAKECMDGOALS),install)
 LIB ?= $(INTERNAL_LIB)
 endif
 
-MAKE_TARGETS	+= $(LIB)
+MAKE_TARGETS	+= $(LIB) $(LIB_R)
 
 LIBSRCS		?= $(wildcard $(abs_srcdir)/*.c)
 
@@ -60,7 +61,11 @@ LIBSRCS		:= $(subst $(abs_srcdir)/,,$(wildcard $(LIBSRCS)))
 
 LIBSRCS		:= $(filter-out $(FILTER_OUT_LIBSRCS),$(LIBSRCS))
 
+LIBSRCS_R	:= $(filter %_r.c,$(LIBSRCS))
+LIBSRCS		:= $(filter-out %_r.c,$(LIBSRCS))
+
 LIBOBJS		:= $(LIBSRCS:.c=.o)
+LIBOBJS_R	:= $(LIBSRCS_R:.c=.o)
 
 $(LIB): $(notdir $(LIBOBJS))
 	if [ -z "$(strip $^)" ] ; then \
@@ -70,4 +75,12 @@ $(LIB): $(notdir $(LIBOBJS))
 	$(if $(AR),$(AR),ar) -rc "$@" $^
 	$(if $(RANLIB),$(RANLIB),ranlib) "$@"
 
+$(LIB_R): $(notdir $(LIBOBJS_R))
+	if [ -z "$(strip $^)" ] ; then \
+		echo "Cowardly refusing to create empty archive"; \
+		exit 1; \
+	fi
+	$(if $(AR),$(AR),ar) -rc "$@" $^
+	$(if $(RANLIB),$(RANLIB),ranlib) "$@"
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/include/mk/testcases_r.mk b/include/mk/testcases_r.mk
new file mode 100644
index 0000000..f3f2a76
--- /dev/null
+++ b/include/mk/testcases_r.mk
@@ -0,0 +1,26 @@
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+# For inclusion in multi-threaded test-cases
+#
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/functions.mk
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS		+= -pthread -lltp_r
diff --git a/lib/Makefile b/lib/Makefile
index c92225c..3a0226c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -19,6 +19,8 @@
 #
 # Garrett Cooper, July 2009
 #
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+#
 
 top_srcdir		?= ..
 
@@ -31,6 +33,7 @@ CFLAGS			+= -I.
 FILTER_OUT_LIBSRCS	:= mount_utils.c
 
 LIB			:= libltp.a
+LIB_R			:= libltp_r.a
 
 pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
 
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
