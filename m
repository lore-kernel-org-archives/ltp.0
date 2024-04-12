Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A41FC4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 08:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712911337; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=I63nKDHNRPpqab/ylX81cRXG+gdpvk7oRGfZoa61d+I=;
 b=Vvr9rYf75BF+P99B2j/Jng4JEHhMaAXEQFRuDJMto5s/7MbrH4h5vnlfqrBx43Q02RSzE
 1EfW3Aqivu/+hzPcwW3rajotIMFMikFr4l/sVGIhOllNqpxecBk1eo1bKSQvWzuhgQWdLDL
 w+4LDyunaV+7tRQ++S90wsxc/EPMbVg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 131393CF8D8
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 10:42:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 008363CF887
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:41:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5763E609A2E
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712911316; x=1744447316;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HM9hxUaBEPdFZDzZOPwL1DuedBhprNO4K1tnT2COu1Q=;
 b=RHHERzHECTwyVzw3SuvZ9qBUVN2L1Ku8FB4OaHQIi9jLNiTcuytndO4s
 L4uje6RXPGpY3X5tGJpbbA+oUrNAkmWP3xSaKSPXFmO05MquXUGGspyQp
 Ysd+mFmP3FtqLU74Rthobudhlbka+WfSuJoPCgyBAfIrtYVlRROvdachs
 6YD5kmG4PQ4/LpsCGAmr3iPbiFzb6H/s1cU88IkHy0eLOoHlcW8B5xoC4
 6FZiTUYozHbDaDmFcDHrqGAv5qEn/xiLTK49seR6uc4zSAzD/2lBSQHZL
 kKACL9d4KFNmdttHIjvb3a13DWeHuL6VxMYxsapwlyu1IQLFBrWUgloFy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="155449727"
X-IronPort-AV: E=Sophos;i="6.07,195,1708354800"; d="scan'208";a="155449727"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2024 17:41:54 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 04578127CCD
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 17:41:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3A9F3340EF
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 17:41:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CBAD9E2B3B
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 17:41:49 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 7B6191A000A;
 Fri, 12 Apr 2024 16:41:49 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 12 Apr 2024 04:07:39 -0400
Message-Id: <20240412080739.18933-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28314.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28314.006
X-TMASE-Result: 10--11.089800-10.000000
X-TMASE-MatchedRID: kREspPIIG7RSuJfEWZSQfBvMKxHA9efN2FA7wK9mP9dgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoh2P280ZiGmRCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeIuA1iha0SDtEvtdGUvF12zWzoxmRe9hVoMLOoNHsM9n2/mTu5B5RIgLKGgWgNCVm4kR
 SZ1g8ZJaH3E3UlyJO9hBax1yAmf0pcvC2bT9P9zmQYj6+BFPEwLGGfhb0UUN3ebsVFPGXfZBZaD
 voiUT/MmiLgWTVbD0+AMuqetGVetnyef22ep6XYOwBXM346/+yLLs/gf1vmfh/2Dqv5GEMuqgsG
 bvw27lVOWRal6QGxj+Fopv27ZE9l
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] connect: Add negative tests for connect
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for connect(), when errno is EACCES and EPROTOTYPE

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/connect/.gitignore  |   1 +
 testcases/kernel/syscalls/connect/connect03.c | 121 ++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/connect/connect03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 71579cde4..cb2c001a0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -131,6 +131,7 @@ confstr01 confstr01
 
 connect01 connect01
 connect02 connect02
+connect03 connect03
 
 creat01 creat01
 creat03 creat03
diff --git a/testcases/kernel/syscalls/connect/.gitignore b/testcases/kernel/syscalls/connect/.gitignore
index 0a3fc90bf..7ef5fef1a 100644
--- a/testcases/kernel/syscalls/connect/.gitignore
+++ b/testcases/kernel/syscalls/connect/.gitignore
@@ -1,2 +1,3 @@
 /connect01
 /connect02
+/connect03
diff --git a/testcases/kernel/syscalls/connect/connect03.c b/testcases/kernel/syscalls/connect/connect03.c
new file mode 100644
index 000000000..367b9d172
--- /dev/null
+++ b/testcases/kernel/syscalls/connect/connect03.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that connect(2) fails with
+ *
+ * - EACCES when write permission is denied on the socket file
+ * - EPROTOTYPE when socket type does not support the protocol
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <pwd.h>
+#include "tst_test.h"
+
+#define CLIENT_EACCES "client_eacces"
+#define SERVER_EACCES "server_eacces"
+#define CLIENT_EPROTOTYPE "client_eprototype"
+#define SERVER_EPROTOTYPE "server_eprototype"
+
+static struct passwd *pw;
+
+static struct sockaddr_un client_eacces;
+static struct sockaddr_un server_eacces;
+static struct sockaddr_un client_eprototype;
+static struct sockaddr_un server_eprototype;
+
+static struct test_case_t {
+	struct sockaddr *client;
+	socklen_t len_client;
+	int type_client;
+	int protocol_client;
+	struct sockaddr *server;
+	socklen_t len_server;
+	char *file_server;
+	int type_server;
+	int protocol_server;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{(struct sockaddr *)&client_eacces, sizeof(client_eacces),
+		SOCK_STREAM, 0, (struct sockaddr *)&server_eacces,
+		sizeof(server_eacces), SERVER_EACCES, SOCK_STREAM, 0, EACCES,
+		"connect() write permission is denied on the socket file"},
+	{(struct sockaddr *)&client_eprototype, sizeof(client_eprototype),
+		SOCK_DGRAM, 0, (struct sockaddr *)&server_eprototype,
+		sizeof(server_eprototype), SERVER_EPROTOTYPE, SOCK_STREAM, 0,
+		EPROTOTYPE,
+		"connect() socket type does not support the protocol"},
+};
+
+static void setup(void)
+{
+	pw = SAFE_GETPWNAM("nobody");
+
+	client_eacces.sun_family = AF_UNIX;
+	strncpy(client_eacces.sun_path, CLIENT_EACCES,
+		sizeof(client_eacces.sun_path));
+
+	server_eacces.sun_family = AF_UNIX;
+	strncpy(server_eacces.sun_path, SERVER_EACCES,
+		sizeof(server_eacces.sun_path));
+
+	client_eprototype.sun_family = AF_UNIX;
+	strncpy(client_eprototype.sun_path, CLIENT_EPROTOTYPE,
+		sizeof(client_eprototype.sun_path));
+
+	server_eprototype.sun_family = AF_UNIX;
+	strncpy(server_eprototype.sun_path, SERVER_EPROTOTYPE,
+		sizeof(server_eprototype.sun_path));
+}
+
+static void verify_connect(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	pid_t pid;
+
+	int fd_server = SAFE_SOCKET(tc->server->sa_family, tc->type_server,
+		tc->protocol_server);
+	int fd_client = SAFE_SOCKET(tc->client->sa_family, tc->type_client,
+		tc->protocol_client);
+
+	SAFE_BIND(fd_server, tc->server, tc->len_server);
+	SAFE_LISTEN(fd_server, 5);
+
+	if (tc->expected_errno == EACCES) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			SAFE_SETUID(pw->pw_uid);
+			TST_EXP_FAIL(connect(fd_client, tc->server,
+				tc->len_server), tc->expected_errno,
+				"%s", tc->desc);
+			exit(0);
+		}
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		TST_EXP_FAIL(connect(fd_client, tc->server, tc->len_server),
+			tc->expected_errno, "%s", tc->desc);
+	}
+
+	if (fd_client > 0)
+		SAFE_CLOSE(fd_client);
+	if (fd_server > 0)
+		SAFE_CLOSE(fd_server);
+	SAFE_UNLINK(tc->file_server);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_connect,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
