Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WN1BS-0003Zb-17
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 14:28:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WN1BQ-0000cc-QI
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 14:28:01 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2AERsTv026942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Mar 2014 10:27:54 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id s2AERrgB028596
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Mar 2014 10:27:54 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Mar 2014 15:28:18 +0100
Message-Id: <2618bd2ff004c79412ab2045f9a1d6c9f8afccec.1394461554.git.jstancek@redhat.com>
In-Reply-To: <b187cebc670c5e8d23f2405d95f82405a0416095.1394190599.git.jstancek@redhat.com>
References: <b187cebc670c5e8d23f2405d95f82405a0416095.1394190599.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2 1/2] add tst_get_unused_port()
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

Returns unused port number for specified domain/type.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/test.h |    7 +++++
 lib/tst_net.c  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 lib/tst_net.c

diff --git a/include/test.h b/include/test.h
index 81fca3e..49a0f47 100644
--- a/include/test.h
+++ b/include/test.h
@@ -288,6 +288,13 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 uid_t tst_get_unused_uid(void);
 gid_t tst_get_unused_gid(void);
 
+/* lib/tst_net.c
+ *
+ * Return unused port
+ */
+unsigned short tst_get_unused_port(unsigned short family, int type,
+	void (cleanup_fn)(void));
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_net.c b/lib/tst_net.c
new file mode 100644
index 0000000..3391dee
--- /dev/null
+++ b/lib/tst_net.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2014 Linux Test Project, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation, Inc.
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "test.h"
+
+unsigned short tst_get_unused_port(unsigned short family, int type,
+	void (cleanup_fn)(void))
+{
+	int sock;
+	socklen_t slen;
+	struct sockaddr_storage _addr;
+	struct sockaddr *addr = (struct sockaddr *)&_addr;
+	struct sockaddr_in *addr4 = (struct sockaddr_in *)addr;
+	struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
+
+	switch (family) {
+	case AF_INET:
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = 0;
+		addr4->sin_addr.s_addr = INADDR_ANY;
+		slen = sizeof(*addr4);
+		break;
+
+	case AF_INET6:
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = 0;
+		addr6->sin6_addr = in6addr_any;
+		slen = sizeof(*addr6);
+		break;
+
+	default:
+		tst_brkm(TBROK, cleanup_fn,
+			"tst_get_unused_port unknown family");
+	}
+
+	sock = socket(addr->sa_family, type, 0);
+	if (sock < 0)
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "socket failed");
+
+	if (bind(sock, addr, slen) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "bind failed");
+
+	if (getsockname(sock, addr, &slen) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "getsockname failed");
+
+	if (close(sock) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup_fn, "close failed");
+
+	switch (family) {
+	case AF_INET:
+		return addr4->sin_port;
+	case AF_INET6:
+		return addr6->sin6_port;
+	default:
+		return -1;
+	}
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
