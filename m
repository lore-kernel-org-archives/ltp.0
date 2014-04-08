Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WXQDT-0001Wp-TM
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 07:13:07 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WXQDS-0007qT-NZ
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 07:13:07 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s387D0A2016383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Apr 2014 07:13:00 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s387CxVZ007337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Apr 2014 07:13:00 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s387CxJe022952
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Apr 2014 07:12:59 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  8 Apr 2014 11:12:54 +0400
Message-Id: <1396941174-25187-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <5343A0AC.6010803@oracle.com>
References: <5343A0AC.6010803@oracle.com>
Subject: [LTP] [PATCH] rpc01: moved the library into a separate directory
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

Cyril Hrubis noticed that including both
  * lib.mk and
  * generic_trunk_target.mk
in one Makefile results in a situation when MAKE_TARGETS are installed twice,
into /testcases/bin and /lib.

Therefore we are moving the library into a separate directory.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/Makefile   |   22 +++++++--
 .../network/rpc/basic_tests/rpc01/lib/Makefile     |   25 ++++++++++
 .../network/rpc/basic_tests/rpc01/lib/librpc01.c   |   49 ++++++++++++++++++++
 .../network/rpc/basic_tests/rpc01/lib/librpc01.h   |   34 ++++++++++++++
 testcases/network/rpc/basic_tests/rpc01/librpc01.c |   49 --------------------
 testcases/network/rpc/basic_tests/rpc01/librpc01.h |   34 --------------
 6 files changed, 125 insertions(+), 88 deletions(-)
 create mode 100644 testcases/network/rpc/basic_tests/rpc01/lib/Makefile
 create mode 100644 testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c
 create mode 100644 testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h
 delete mode 100644 testcases/network/rpc/basic_tests/rpc01/librpc01.c
 delete mode 100644 testcases/network/rpc/basic_tests/rpc01/librpc01.h

diff --git a/testcases/network/rpc/basic_tests/rpc01/Makefile b/testcases/network/rpc/basic_tests/rpc01/Makefile
index 7815cbb..af945bc 100644
--- a/testcases/network/rpc/basic_tests/rpc01/Makefile
+++ b/testcases/network/rpc/basic_tests/rpc01/Makefile
@@ -30,13 +30,25 @@ CPPFLAGS		+= -Wno-error
 INSTALL_TARGETS		:= rpc01
 SUBDIRS			:= datafiles
 
-LIBSRCS			:= $(abs_srcdir)/librpc01.c
-INTERNAL_LIB		:= librpc01.a
-LDFLAGS			+= -L$(abs_builddir)
+CPPFLAGS		+= -I$(abs_srcdir)/lib
+LDFLAGS			+= -L$(abs_builddir)/lib
 LDLIBS			+= -lrpc01
 
+LIBDIR			:= lib
+LIB			:= $(LIBDIR)/librpc01.a
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
 MAKE_TARGETS		:= rpc1 rpc_server
-$(MAKE_TARGETS): $(INTERNAL_LIB)
+MAKE_DEPS		:= $(LIB)
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/lib/Makefile b/testcases/network/rpc/basic_tests/rpc01/lib/Makefile
new file mode 100644
index 0000000..387b5dc
--- /dev/null
+++ b/testcases/network/rpc/basic_tests/rpc01/lib/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (c) 2014 Linux Test Project.
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
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INTERNAL_LIB		:= librpc01.a
+
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c
new file mode 100644
index 0000000..d2810d8
--- /dev/null
+++ b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2013 Linux Test Project.
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
+
+#include <rpc/xdr.h>
+#include "librpc01.h"
+
+bool_t xdr_receive_data(XDR *xdrs, struct data **buffer)
+{
+	struct data *bp;
+	int i, rc;
+	char *p;
+
+	bp = *buffer = (struct data *)malloc(sizeof(struct data));
+	rc = xdr_long(xdrs, &(bp->address));
+	rc = rc && xdr_long(xdrs, &bp->request_id);
+	rc = rc && xdr_long(xdrs, &bp->data_length);
+	p = (*buffer)->data = malloc(bp->data_length);
+	for (i = 0; rc && i < bp->data_length; p++, i++)
+		rc = xdr_char(xdrs, p);
+	return rc;
+}
+
+bool_t xdr_send_data(XDR *xdrs, struct data *buffer)
+{
+	int i, rc;
+	char *p;
+
+	rc = xdr_long(xdrs, &buffer->address);
+	rc = rc && xdr_long(xdrs, &buffer->request_id);
+	rc = rc && xdr_long(xdrs, &buffer->data_length);
+	for (i = 0, p = buffer->data; rc && i < buffer->data_length; i++, p++)
+		rc = xdr_char(xdrs, p);
+	return rc;
+}
diff --git a/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h
new file mode 100644
index 0000000..0fa7969
--- /dev/null
+++ b/testcases/network/rpc/basic_tests/rpc01/lib/librpc01.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2013 Linux Test Project.
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
+
+#ifndef __LIBRPC_H__
+#define __LIBRPC_H__
+
+#include <rpc/xdr.h>
+
+struct data {
+	long address;
+	long request_id;
+	long data_length;
+	char *data;
+};
+
+bool_t xdr_receive_data(XDR *xdrs, struct data **buffer);
+bool_t xdr_send_data(XDR *xdrs, struct data *buffer);
+
+#endif /* __LIBRPC_H__ */
diff --git a/testcases/network/rpc/basic_tests/rpc01/librpc01.c b/testcases/network/rpc/basic_tests/rpc01/librpc01.c
deleted file mode 100644
index d2810d8..0000000
--- a/testcases/network/rpc/basic_tests/rpc01/librpc01.c
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * Copyright (c) 2013 Linux Test Project.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <rpc/xdr.h>
-#include "librpc01.h"
-
-bool_t xdr_receive_data(XDR *xdrs, struct data **buffer)
-{
-	struct data *bp;
-	int i, rc;
-	char *p;
-
-	bp = *buffer = (struct data *)malloc(sizeof(struct data));
-	rc = xdr_long(xdrs, &(bp->address));
-	rc = rc && xdr_long(xdrs, &bp->request_id);
-	rc = rc && xdr_long(xdrs, &bp->data_length);
-	p = (*buffer)->data = malloc(bp->data_length);
-	for (i = 0; rc && i < bp->data_length; p++, i++)
-		rc = xdr_char(xdrs, p);
-	return rc;
-}
-
-bool_t xdr_send_data(XDR *xdrs, struct data *buffer)
-{
-	int i, rc;
-	char *p;
-
-	rc = xdr_long(xdrs, &buffer->address);
-	rc = rc && xdr_long(xdrs, &buffer->request_id);
-	rc = rc && xdr_long(xdrs, &buffer->data_length);
-	for (i = 0, p = buffer->data; rc && i < buffer->data_length; i++, p++)
-		rc = xdr_char(xdrs, p);
-	return rc;
-}
diff --git a/testcases/network/rpc/basic_tests/rpc01/librpc01.h b/testcases/network/rpc/basic_tests/rpc01/librpc01.h
deleted file mode 100644
index 0fa7969..0000000
--- a/testcases/network/rpc/basic_tests/rpc01/librpc01.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright (c) 2013 Linux Test Project.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef __LIBRPC_H__
-#define __LIBRPC_H__
-
-#include <rpc/xdr.h>
-
-struct data {
-	long address;
-	long request_id;
-	long data_length;
-	char *data;
-};
-
-bool_t xdr_receive_data(XDR *xdrs, struct data **buffer);
-bool_t xdr_send_data(XDR *xdrs, struct data *buffer);
-
-#endif /* __LIBRPC_H__ */
-- 
1.7.1


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
