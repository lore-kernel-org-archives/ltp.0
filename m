Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vv7OV-0006JQ-CO
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 15:26:11 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vv7OM-0002vt-DI
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 15:26:11 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBNFPu1O011360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:56 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBNFPtoN025225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:56 GMT
Received: from ubhmt102.oracle.com (ubhmt102.oracle.com [156.151.24.7])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBNFPtWL008904
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Dec 2013 15:25:55 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 23 Dec 2013 19:25:47 +0400
Message-Id: <1387812348-23017-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1387812348-23017-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1387812348-23017-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/3] rpc01: moved common functions to a lib
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

"Decipher"-functions xdr_receive_data and xdr_send_data are used
by both rpc_server and rpc1, so moved them to a separate library.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/network/rpc/basic_tests/rpc01/Makefile   |   10 ++++-
 testcases/network/rpc/basic_tests/rpc01/librpc01.c |   49 ++++++++++++++++++++
 testcases/network/rpc/basic_tests/rpc01/librpc01.h |   34 ++++++++++++++
 testcases/network/rpc/basic_tests/rpc01/rpc1.c     |   39 +---------------
 .../network/rpc/basic_tests/rpc01/rpc_server.c     |   39 +---------------
 5 files changed, 94 insertions(+), 77 deletions(-)
 create mode 100644 testcases/network/rpc/basic_tests/rpc01/librpc01.c
 create mode 100644 testcases/network/rpc/basic_tests/rpc01/librpc01.h

diff --git a/testcases/network/rpc/basic_tests/rpc01/Makefile b/testcases/network/rpc/basic_tests/rpc01/Makefile
index 732d816..68ea85e 100644
--- a/testcases/network/rpc/basic_tests/rpc01/Makefile
+++ b/testcases/network/rpc/basic_tests/rpc01/Makefile
@@ -28,7 +28,15 @@ include $(top_srcdir)/include/mk/env_pre.mk
 CPPFLAGS		+= -Wno-error
 
 INSTALL_TARGETS		:= rpc01
-
 SUBDIRS			:= datafiles
 
+LIBSRCS			:= $(abs_srcdir)/librpc01.c
+INTERNAL_LIB		:= librpc01.a
+LDFLAGS			+= -L$(abs_srcdir)
+LDLIBS			+= -lrpc01
+
+MAKE_TARGETS		:= rpc1 rpc_server
+$(MAKE_TARGETS): $(INTERNAL_LIB)
+
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/network/rpc/basic_tests/rpc01/librpc01.c b/testcases/network/rpc/basic_tests/rpc01/librpc01.c
new file mode 100644
index 0000000..b726aa0
--- /dev/null
+++ b/testcases/network/rpc/basic_tests/rpc01/librpc01.c
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
+int xdr_receive_data(XDR *xdrs, struct data **buffer)
+{
+	struct data *bp;
+	int i, rc;
+	char *p;
+
+	bp = *buffer = (struct data *)malloc(sizeof(struct data));
+	rc = xdr_long(xdrs, &(bp->address));
+	rc = rc && xdr_long(xdrs, &bp->request_id);
+	rc = rc && xdr_long(xdrs, &bp->data_length);
+	p = (*buffer)->data = (char *)malloc(bp->data_length);
+	for (i = 0; rc && i < bp->data_length; p++, i++)
+		rc = xdr_char(xdrs, p);
+	return rc;
+}
+
+int xdr_send_data(XDR *xdrs, struct data *buffer)
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
diff --git a/testcases/network/rpc/basic_tests/rpc01/librpc01.h b/testcases/network/rpc/basic_tests/rpc01/librpc01.h
new file mode 100644
index 0000000..aae3901
--- /dev/null
+++ b/testcases/network/rpc/basic_tests/rpc01/librpc01.h
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
+int xdr_receive_data(XDR *xdrs, struct data **buffer);
+int xdr_send_data(XDR *xdrs, struct data *buffer);
+
+#endif /* __LIBRPC_H__ */
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc1.c b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
index 946cb21..57a338e 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc1.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc1.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include "librpc01.h"
 
 int program = 2000333;
 int version = 10;
@@ -17,15 +18,6 @@ char *file_name = NULL;
 char host_name[100];
 long host_address;
 
-struct data {
-	long address;
-	long request_id;
-	long data_length;
-	char *data;
-};
-
-int xdr_receive_data(XDR *, struct data **);
-int xdr_send_data(XDR *, struct data *);
 void do_compare(int, char *, struct data *, char *);
 void usage_error(char *program_name);
 
@@ -187,35 +179,6 @@ void do_compare(int rpc_rc, char *msg, struct data *buffer, char *ret_data)
 	}
 }
 
-int xdr_receive_data(XDR * xdrs, struct data **buffer)
-{
-	struct data *bp;
-	int i, rc;
-	char *p;
-
-	bp = *buffer = (struct data *)malloc(sizeof(struct data));
-	rc = xdr_long(xdrs, &(bp->address));
-	rc = rc && xdr_long(xdrs, &bp->request_id);
-	rc = rc && xdr_long(xdrs, &bp->data_length);
-	p = (*buffer)->data = (char *)malloc(bp->data_length);
-	for (i = 0; rc && i < bp->data_length; p++, i++)
-		rc = xdr_char(xdrs, p);
-	return (rc);
-}
-
-int xdr_send_data(XDR * xdrs, struct data *buffer)
-{
-	int i, rc;
-	char *p;
-
-	rc = xdr_long(xdrs, &buffer->address);
-	rc = rc && xdr_long(xdrs, &buffer->request_id);
-	rc = rc && xdr_long(xdrs, &buffer->data_length);
-	for (i = 0, p = buffer->data; rc && i < buffer->data_length; i++, p++)
-		rc = xdr_char(xdrs, p);
-	return (rc);
-}
-
 void usage_error(char *program_name)
 {
 	fprintf(stderr,
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
index 4fdff8e..e0b5001 100644
--- a/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc_server.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <rpc/rpc.h>
+#include "librpc01.h"
 
 int debug = 0;
 int program = 2000333;
@@ -13,17 +14,8 @@ int version = 10;
 char host_name[100];
 long host_address;
 
-struct data {
-	long address;
-	long request_id;
-	long data_length;
-	char *data;
-};
-
 void breakpoint(void);
 void service_request(struct svc_req *rqstp, SVCXPRT * transp);
-int xdr_receive_data(XDR * xdrs, struct data **buffer);
-int xdr_send_data(XDR * xdrs, struct data *buffer);
 
 int main(int argc, char *argv[])
 {
@@ -125,35 +117,6 @@ void service_request(struct svc_req *rqstp, SVCXPRT * transp)
 	}
 }
 
-int xdr_receive_data(XDR * xdrs, struct data **buffer)
-{
-	struct data *bp;
-	int i, rc;
-	char *p;
-
-	bp = *buffer = (struct data *)malloc(sizeof(struct data));
-	rc = xdr_long(xdrs, &(bp->address));
-	rc = rc && xdr_long(xdrs, &bp->request_id);
-	rc = rc && xdr_long(xdrs, &bp->data_length);
-	p = (*buffer)->data = (char *)malloc(bp->data_length);
-	for (i = 0; rc && i < bp->data_length; p++, i++)
-		rc = xdr_char(xdrs, p);
-	return (rc);
-}
-
-int xdr_send_data(XDR * xdrs, struct data *buffer)
-{
-	int i, rc;
-	char *p;
-
-	rc = xdr_long(xdrs, &buffer->address);
-	rc = rc && xdr_long(xdrs, &buffer->request_id);
-	rc = rc && xdr_long(xdrs, &buffer->data_length);
-	for (i = 0, p = buffer->data; rc && i < buffer->data_length; i++, p++)
-		rc = xdr_char(xdrs, p);
-	return (rc);
-}
-
 void breakpoint(void)
 {
 	if (debug)
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
