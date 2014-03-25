Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSI9-0007wG-LZ
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:25 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSI8-000654-J7
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:25 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPI9b031006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:19 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPHGv015339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:18 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPHrA018158
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:17 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:33 +0400
Message-Id: <1395757480-27424-8-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 07/14] rpc-tirpc: fixed the cleaner binaries
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

Renamed cleaner.c.src to tirpc_cleaner.c (to make it build).

For consistency added rpc_cleaner.c, which utilise only TS-RPC
functions.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/network/rpc/rpc-tirpc/.gitignore         |    2 +
 .../network/rpc/rpc-tirpc/tests_pack/cleaner.c.src |   48 --------------------
 .../network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c |   34 ++++++++++++++
 .../rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c       |   48 ++++++++++++++++++++
 4 files changed, 84 insertions(+), 48 deletions(-)
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/cleaner.c.src
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c

diff --git a/testcases/network/rpc/rpc-tirpc/.gitignore b/testcases/network/rpc/rpc-tirpc/.gitignore
index 0db3f81..adcd811 100644
--- a/testcases/network/rpc/rpc-tirpc/.gitignore
+++ b/testcases/network/rpc/rpc-tirpc/.gitignore
@@ -1,3 +1,5 @@
+/tests_pack/rpc_cleaner
+/tests_pack/tirpc_cleaner
 /tests_pack/rpc_svc_1/rpc_svc_1
 /tests_pack/rpc_svc_2/rpc_svc_2
 /tests_pack/tirpc_svc_1/tirpc_svc_1
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/cleaner.c.src b/testcases/network/rpc/rpc-tirpc/tests_pack/cleaner.c.src
deleted file mode 100644
index a23d378..0000000
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/cleaner.c.src
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
-* Copyright (c) Bull S.A.  2007 All Rights Reserved.
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* Further, this software is distributed without any warranty that it is
-* free of the rightful claim of any third person regarding infringement
-* or the like.  Any license provided herein, whether implied or
-* otherwise, applies only to this software file.  Patent licenses, if
-* any, provided herein do not apply to combinations of this program with
-* other software, or any other product whatsoever.
-*
-* You should have received a copy of the GNU General Public License along
-* with this program; if not, write the Free Software Foundation, Inc.,
-* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-*
-* History:
-* Created by: Cyril Lacabanne (Cyril.Lacabanne@bull.net)
-*
-*/
-
-#include <stdio.h>
-#include <tirpc/netconfig.h>
-#include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
-#include <errno.h>
-
-//Standard define
-#define VERSNUM 1
-
-int main(int argn, char *argc[])
-{
-	//Server parameter is : argc[1] : Server Program Number
-	int progNum = atoi((char *)argc[1]);
-
-	svc_unreg(progNum, VERSNUM);
-
-	return 0;
-}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c
new file mode 100644
index 0000000..e17430f
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_cleaner.c
@@ -0,0 +1,34 @@
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
+ *
+ */
+
+#include <stdio.h>
+#include <rpc/rpc.h>
+
+#define VERSNUM 1 /* Default version used in the test binaries */
+
+int main(int argc, char *argv[])
+{
+	/* Server program number */
+	int prog_num = atoi(argv[1]);
+
+	pmap_unset(prog_num, VERSNUM);
+	svc_unregister(prog_num, VERSNUM);
+
+	return 0;
+}
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
new file mode 100644
index 0000000..a23d378
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c
@@ -0,0 +1,48 @@
+/*
+* Copyright (c) Bull S.A.  2007 All Rights Reserved.
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* Further, this software is distributed without any warranty that it is
+* free of the rightful claim of any third person regarding infringement
+* or the like.  Any license provided herein, whether implied or
+* otherwise, applies only to this software file.  Patent licenses, if
+* any, provided herein do not apply to combinations of this program with
+* other software, or any other product whatsoever.
+*
+* You should have received a copy of the GNU General Public License along
+* with this program; if not, write the Free Software Foundation, Inc.,
+* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+*
+* History:
+* Created by: Cyril Lacabanne (Cyril.Lacabanne@bull.net)
+*
+*/
+
+#include <stdio.h>
+#include <tirpc/netconfig.h>
+#include <sys/socket.h>
+#include <tirpc/rpc/rpc.h>
+#include <tirpc/rpc/types.h>
+#include <tirpc/rpc/xdr.h>
+#include <tirpc/rpc/svc.h>
+#include <errno.h>
+
+//Standard define
+#define VERSNUM 1
+
+int main(int argn, char *argc[])
+{
+	//Server parameter is : argc[1] : Server Program Number
+	int progNum = atoi((char *)argc[1]);
+
+	svc_unreg(progNum, VERSNUM);
+
+	return 0;
+}
-- 
1.7.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
