Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WTAnZ-0007nO-8D
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:49 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTAnV-0006fT-3k
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:56:49 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2RDudW0012792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:39 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2RDuckT008432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:38 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s2RDub7K012417
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 13:56:37 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 27 Mar 2014 17:56:24 +0400
Message-Id: <1395928590-28408-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395928590-28408-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/7] rpc-tirpc: introduced a common library
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
Cc: vasily.isaenko@oracle.com

This library will contain common functions and etc which may be used
by some of the binaries.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../network/rpc/rpc-tirpc/tests_pack/Makefile      |   16 ++++++++++++
 .../network/rpc/rpc-tirpc/tests_pack/Makefile.inc  |   18 +++++++++++++-
 .../network/rpc/rpc-tirpc/tests_pack/lib/Makefile  |   25 ++++++++++++++++++++
 .../rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c    |   17 +++++++++++++
 .../rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h    |   17 +++++++++++++
 5 files changed, 92 insertions(+), 1 deletions(-)
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/lib/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
index 6703ebb..d16e1ca 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
@@ -19,5 +19,21 @@
 top_srcdir		?= ../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
+
+LIBDIR			:= lib
+FILTER_OUT_DIRS		:= $(LIBDIR)
+LIB			:= $(LIBDIR)/librpc-tirpc.a
+
+$(LIBDIR):
+	mkdir -p "$@"
+
+$(LIB): $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+
+trunk-clean:: | lib-clean
+
+lib-clean:: $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+
 include ./Makefile.inc
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
index 8513677..636f0d1 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
@@ -16,5 +16,21 @@
 #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
-LDLIBS		+= $(TIRPC_LIBS) -lpthread
+LIBRELDIR	:= testcases/network/rpc/rpc-tirpc/tests_pack/lib
+LIBDIR		:= $(abs_top_builddir)/$(LIBRELDIR)
+LIBSRCDIR	:= $(abs_top_srcdir)/$(LIBRELDIR)
+LIBRPC-TIRPC	:= $(LIBDIR)/librpc-tirpc.a
+
+$(LIBDDIR):
+	mkdir -p "$@"
+
+$(LIBRPC-TIRPC): $(LIBDIR)
+	$(MAKE) -C $^ -f "$(LIBSRCDIR)/Makefile" all
+
+MAKE_DEPS	+= $(LIBRPC-TIRPC)
+
+LDLIBS		+= $(TIRPC_LIBS) -lpthread -lrpc-tirpc
+LDFLAGS		+= -L$(LIBDIR)
+
 CPPFLAGS	+= $(TIRPC_CPPFLAGS)
+CPPFLAGS	+= -I$(LIBSRCDIR)
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/lib/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/Makefile
new file mode 100644
index 0000000..8afb3da
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+LIB	:= librpc-tirpc.a
+
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c
new file mode 100644
index 0000000..68abbd8
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.c
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h
new file mode 100644
index 0000000..68abbd8
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/lib/librpc-tirpc.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
