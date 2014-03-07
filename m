Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WLt7j-0007EY-Vm
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 11:39:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLt7i-0002kj-Jm
	for ltp-list@lists.sourceforge.net; Fri, 07 Mar 2014 11:39:31 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s27BdOi4028174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Mar 2014 06:39:24 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s27BdMtv019923
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Mar 2014 06:39:23 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  7 Mar 2014 12:39:24 +0100
Message-Id: <b187cebc670c5e8d23f2405d95f82405a0416095.1394190599.git.jstancek@redhat.com>
In-Reply-To: <cover.1394190599.git.jstancek@redhat.com>
References: <cover.1394190599.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/2] add tst_get_unused_port()
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
 lib/tst_net.c  |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 0 deletions(-)
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
index 0000000..4b30410
--- /dev/null
+++ b/lib/tst_net.c
@@ -0,0 +1,81 @@
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
+	struct sockaddr_in addr4;
+	struct sockaddr_in6 addr6;
+	socklen_t slen;
+	struct sockaddr *addr;
+
+	switch (family) {
+	case AF_INET:
+		addr4.sin_family = AF_INET;
+		addr4.sin_port = 0;
+		addr4.sin_addr.s_addr = INADDR_ANY;
+		slen = sizeof(addr4);
+		addr = (struct sockaddr *)&addr4;
+		break;
+
+	case AF_INET6:
+		addr6.sin6_family = AF_INET6;
+		addr6.sin6_port = 0;
+		addr6.sin6_addr = in6addr_any;
+		slen = sizeof(addr6);
+		addr = (struct sockaddr *)&addr6;
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
+		return addr4.sin_port;
+	case AF_INET6:
+		return addr6.sin6_port;
+	default:
+		return -1;
+	}
+}
-- 
1.7.1


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
