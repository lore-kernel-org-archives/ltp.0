Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F2ECD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 04:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780548673; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=XF69tWiy0T795KpFPl2TCLmLBFT6xWlqT+C8Oj6qAkc=;
 b=hhI6fqzRZoB2p3cl3/JtHa/2kPUdr/TZRnJ7nLcg5I81zUgxI1bX7ucAmnrF1TGXSlUzn
 y7zJ8cOwHPnVvmqABUr1b2aExXTPdVltYmncqlPswVbhZt5C6oSzxTniEW/hNrvSOpNCsfd
 HgCf0OfzAxAnMXUFSsXEUSEgItXFnWU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD9BA3E0D3C
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 06:51:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 063FD3E0D3C
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:50:20 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 426F92002C1
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:50:18 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so1785675e9.2
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780548618; x=1781153418; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1EHKs1pgqOWGZPhYwOjSmRFtyWOzmyKWXvjVhbjVXk=;
 b=ft1zMLmj/woRJhxdjeGEPuampSq6xV23tpHcsQIyt9PmZt08W9Lj8zDgGRSdGQlhgG
 sriJafRkDClQ3PC0BncfOUeSZf6rqeZ+gsbIakVRbuCqCBExNUnZea7rlZj2QA0rlKLx
 kmZa02ow4f37GFEGsVvFxIK51mVW+7x9CZFWfWzgBMPPs5ljtp3jVhl1n0gqjC1Zq2he
 ijKkq9aPFhiR+jKIQ/tGM+tKXw7/QCoc1apQAoFIK2Kd3l+F5FCgZaU0k5PlaWd/9UeX
 0TN+usl9E/6tNB+FRNjMl+QYO5qlojt0UgaPGyyI3/XbSkfs5g8izpiy/4HKa7zg+9Fq
 Apcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780548618; x=1781153418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z1EHKs1pgqOWGZPhYwOjSmRFtyWOzmyKWXvjVhbjVXk=;
 b=rhaXunm9zf4WPyhOov88mH1su4JbAmf3RCI35fjk104GTFRLJUryjYdciv9xxqH1hg
 mpUrX5codNZI1HrL9RmZ/HtVvOfgVy2S7Va+AXkgRdjJR53uKIWbpWDEvDn9U9bmQqgU
 7Fq9G/uINPTYqle6UCsD2vN3uCfemr7yQqVavfLAHuA+60II1bebd/vcPLagwvDmvBSM
 z0tVWNXRlDrn2nfgIn2bZD51Ravo+51Y27YyZp6NUnixVcLxGHS1Bu+0msZ5+jaWigAc
 RcLNTv35/zYdabheL+8hV9Hz1/3k+FonFu7hmE+a0DmXB8xRfadgx6cXRzMHn/uOKbtu
 aC8Q==
X-Gm-Message-State: AOJu0YzKE3rMWeDn2xzXUJ3Kx2RJegDPhtPQkC3Fg6wub+I+FGCuyxBA
 b+zChwH8gUju5DQGnxjcRu6u8mrm9iL8EWow9LpR8JbM/eZ7LBJRiHy3RuwcXv80YidwD+ouB1Z
 earM=
X-Gm-Gg: Acq92OH1jD5kC0nfoe5bkGXEWu7eOcy9ZW9hCzzu1cPGpxhsSHdXyfOMCpt47LUTZwh
 5Fx7/JQeV8oRZ5kl0weua4tW/a4swXTiMi8PdO6Hlliq0hNM1UY0fxw3vAqbfbD0T/APVvz/1WI
 9cghFfBsxh4CrwYCrCbKfiLn1rZiPm9fJETJRox6oq3U4pkd+A6h3RtgtkMPz94e4h4vtPMe8/0
 JI6d9JiR1DwxFBpO31A0DIs3tcRTtuAZH89ijYGmBUeQQAductNFuHnlD+8N8nylukZEQFsMdv8
 /m3L+M12Cw3peVDq7H8LNDLhLy0Gq0AF8edkOjA7rI+QokWLcIbi/5EwxG6ADALpbZXnzn5adem
 bbypO14BgUpkeJ7rg0Qc/Glmpngfj/9if/VircRqCBQ4o82hnX9j5Kuzwn9k4FHVSNvZgKT0LhM
 c2u6V5yzQRMxxHiLNcZ6bSpg==
X-Received: by 2002:a05:600c:4f44:b0:490:b26f:a512 with SMTP id
 5b1f17b1804b1-490b5acf6d2mr106407385e9.0.1780548617712; 
 Wed, 03 Jun 2026 21:50:17 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490bc3e5a00sm41782015e9.15.2026.06.03.21.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 21:50:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 04:49:56 +0000
Message-ID: <20260604045008.29021-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604045008.29021-1-wegao@suse.com>
References: <20260525090228.11895-2-wegao@suse.com>
 <20260604045008.29021-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] connect01: Add negative tests
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for connect(), when errno is EPROTOTYPE or EACCES.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/connect/connect01.c | 47 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 565148fc5..76836ce20 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -11,20 +11,29 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
+#include <sys/un.h>
 #include <netinet/in.h>
+#include <pwd.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
+#define SOCK_FILE "sock_file"
+
 static int fd_invalid = -1;
 static int fd_socket;
 static int fd_null;
 static int fd_connected;
 static int fd_server;
+static int fd_unix_dgram;
+static int fd_unix_stream;
+static int fd_unix_server;
 
 static struct sockaddr_in sock1;
 static struct sockaddr_in sock2;
 static struct sockaddr_in sock3;
+static struct sockaddr_un sock4;
 static void *bad_addr;
+static struct passwd *pw;
 
 static pid_t pid;
 
@@ -49,6 +58,10 @@ static struct test_case_t {
 		"connect on a socket found no one listening on remote address"},
 	{&fd_socket, &sock3, sizeof(sock3), EAFNOSUPPORT,
 		"address doesn't have the correct address family in sa_family"},
+	{&fd_unix_dgram, &sock4, sizeof(sock4), EPROTOTYPE,
+		"socket type does not support the protocol"},
+	{&fd_unix_stream, &sock4, sizeof(sock4), EACCES,
+		"write permission is denied on the socket file"},
 };
 
 static int sys_connect(int sockfd, const struct sockaddr *addr,
@@ -103,6 +116,19 @@ static void setup(void)
 	sock3.sin_family = 47;
 	sock3.sin_port = 0;
 	sock3.sin_addr.s_addr = htonl(0x0AFFFEFD);
+
+	sock4.sun_family = AF_UNIX;
+	strncpy(sock4.sun_path, SOCK_FILE, sizeof(sock4.sun_path));
+
+	fd_unix_server = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+	SAFE_BIND(fd_unix_server, (struct sockaddr *)&sock4, sizeof(sock4));
+	SAFE_CHMOD(SOCK_FILE, 0700);
+	SAFE_LISTEN(fd_unix_server, 5);
+
+	fd_unix_dgram = SAFE_SOCKET(AF_UNIX, SOCK_DGRAM, 0);
+	fd_unix_stream = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
+
+	pw = SAFE_GETPWNAM("nobody");
 }
 
 static void cleanup(void)
@@ -113,6 +139,12 @@ static void cleanup(void)
 		SAFE_CLOSE(fd_null);
 	if (fd_connected > 0)
 		SAFE_CLOSE(fd_connected);
+	if (fd_unix_dgram > 0)
+		SAFE_CLOSE(fd_unix_dgram);
+	if (fd_unix_stream > 0)
+		SAFE_CLOSE(fd_unix_stream);
+	if (fd_unix_server > 0)
+		SAFE_CLOSE(fd_unix_server);
 
 	if (pid > 0) {
 		SAFE_KILL(pid, SIGKILL);
@@ -125,8 +157,17 @@ static void verify_connect(unsigned int i)
 	struct test_case_t *tc = &tcases[i];
 	void *addr = tc->addr ? tc->addr : bad_addr;
 
-	TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
-		tc->exp_errno, "%s", tc->desc);
+	if (tc->exp_errno == EACCES) {
+		if (!SAFE_FORK()) {
+			SAFE_SETUID(pw->pw_uid);
+			TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
+				tc->exp_errno, "%s", tc->desc);
+			exit(0);
+		}
+	} else {
+		TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
+			tc->exp_errno, "%s", tc->desc);
+	}
 }
 
 static struct tst_test test = {
@@ -135,4 +176,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_connect,
 	.forks_child = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
 };
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
