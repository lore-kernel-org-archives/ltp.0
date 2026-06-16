Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1E4CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781602342; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=AyMafWU0Ndm5TdPuUEHnuMT6lpWfSOaW+zffAo2rGTc=;
 b=KC21+NivXsho+dSNXLzz+nOyDQ0qhrpQWi6Pghd8OJ87JwwONzJex4gV5xaC0GOWRlSTS
 hYnJvclpyMG4mdmFZzuGkd20NWcL3qaZhDPKBKfIvuQDuaUqYmA57Qd+ZaF1rtxIWCeASTo
 urq96ZbZz5wbCTYujbNuRT9DCnuELOk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C63B3E5970
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:32:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B67A13E5969
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:31:27 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E7AEF100077B
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:31:26 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so3176180f8f.0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781602286; x=1782207086; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lH2qScYBWwDsndh7tkYiZUrohGLIsy8piigzo/Q9+I=;
 b=W9WW4ssW+DLUgH0KRzU6O6s/53pM39cXxzZ9fmafUrQAOSb63qMtp6MInVizfOMalb
 NtaBKHtqLo8U7tpGkc056sbvVHGyO5PZdfUL3kR75r0ONnrBsHaY3QaxgMFkP3opd1P+
 yQtBSI9be4Jp6dmOWuy0cY/iVKuBI2nU3ZJccU6HqWBgkBl7SH06RNST73+CoKQRVzhe
 n5QqmQJ92lptrK8g5nzXBtL/JwQsyMewLd7nQYMP/eh9d21RwroM4pQ4LHtFvmVZDM2U
 BT18gBrlI5XN+LqOHX9V7PQSPoyfHfwPEdsipJ3Xrh1DAAkLJrHRxEpiMp5YFuPAm6JI
 QHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602286; x=1782207086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8lH2qScYBWwDsndh7tkYiZUrohGLIsy8piigzo/Q9+I=;
 b=RdjCw9LuDefohl/DvX8XLvQxB3C/H7FI+LUhYxLlsBN9K5G8VkDSgn95MRP2dtD3Af
 C/FO9Mvk612TKnHy+ma3vrk9diuWh7222WOZsETXeBd//hCiLzWQ/P8VFFY8O6T6h77m
 5egW3DU9EO/pIZ8VI8LVdJMT87HHCPFSWLaf5Tfsc7Qbqdbo57uBrcoSiNxum9RJJeSS
 x7xUGhq4+Nhi5NZAP6R5z2wbfvm1As/NoVr8LWKRJ45G54rT8raeP2t6Ck0iPl+uScOW
 DZD4Ycp7koo4yHLx+LvAFkh6tF91vypEEmG+F1WUfvrwsD7fy3sNkPfs0cqoRxMZdzCe
 Fl7A==
X-Gm-Message-State: AOJu0Yxku4fsCjgM/E2YZaAkJ8aI4oUpZcGrDXq7vmZo0y/ibOKb1jTd
 6XC59kqodBA5/VT4ucEBgDPJYkzcte9Z3DzLyDvqwI3s2HhSBE9r024BeGLk+b/byldSCUYaEM4
 dHiQ=
X-Gm-Gg: Acq92OGWhIOVUkj2/kXOvDjQ+PokQmM6aMLD1iwWdHBSsoBocuT12oMd5jpUPHX6aBz
 RQTifoWUWmu/drVgnrt9gkl2jz4pG2Xm0H7vnDG1G4vwoNcRGTN3nyH8c0et5g0KpUOS7wfhpe7
 roj4KIhQ2AX7C9ekRNUe8V7U8Oyac1laDuht8wR3CxHagMi7x6XOQj5EOmEawlstnFWn86jLWyF
 XKZsqNBHav/f7qWO/UmAo4Kvy9Bg1Rm2UWMoD+BNW7ukDC5p/WOIwLKZ7dIdRJEuP/T97jV4SER
 tiTBEnxuNZXaysovzEOZ+xEU98Y+GohDF7TMSx+GmiXQ/h/YvDH1fuQC5NeTAokY/pm17+Qpir1
 WKe4LSLOQ+SMOfpSRaEUa6VOlL9eUbMU1Oa61h4z9eqxhab3SO96uEjPL/V1kcn7gFNrc3cNIBq
 8DHwkVxnPz9JKIeCOVoAOLJg==
X-Received: by 2002:a05:6000:22c5:b0:45e:e50e:3bc with SMTP id
 ffacd0b85a97d-4607e261871mr19600458f8f.29.1781602286057; 
 Tue, 16 Jun 2026 02:31:26 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm43281995f8f.37.2026.06.16.02.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:31:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 09:31:05 +0000
Message-ID: <20260616093119.8654-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093119.8654-1-wegao@suse.com>
References: <20260616052452.8353-2-wegao@suse.com>
 <20260616093119.8654-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/2] connect01: Add negative tests
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
These error paths were not exercised by the existing test.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/connect/connect01.c | 54 +++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index fd288559e..79aa899eb 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -5,26 +5,39 @@
  */
 
 /*\
- * Verify that :manpage:`connect(2)` returns the proper errno for various failure cases.
+ * Verify that :manpage:`connect(2)` returns the proper errno
+ * for various failure cases.
+ *
+ * Requires root to test EACCES by dropping privileges to an
+ * unprivileged user.
  */
 
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
 static int fd_socket = -1;
 static int fd_null = -1;
 static int fd_connected = -1;
 static int fd_server = -1;
+static int fd_unix_dgram = -1;
+static int fd_unix_stream = -1;
+static int fd_unix_server = -1;
 
 static struct sockaddr_in sock1;
 static struct sockaddr_in sock2;
 static struct sockaddr_in sock3;
+static struct sockaddr_un sock4;
 static void *bad_addr;
+static struct passwd *pw;
 
 static pid_t pid;
 
@@ -49,6 +62,10 @@ static struct test_case_t {
 		"connect on a socket found no one listening on remote address"},
 	{&fd_socket, &sock3, sizeof(sock3), EAFNOSUPPORT,
 		"address doesn't have the correct address family in sa_family"},
+	{&fd_unix_dgram, &sock4, sizeof(sock4), EPROTOTYPE,
+		"socket type does not support the protocol"},
+	{&fd_unix_stream, &sock4, sizeof(sock4), EACCES,
+		"write permission is denied on the socket file"},
 };
 
 static int sys_connect(int sockfd, const struct sockaddr *addr,
@@ -103,6 +120,19 @@ static void setup(void)
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
@@ -115,6 +145,12 @@ static void cleanup(void)
 		SAFE_CLOSE(fd_connected);
 	if (fd_server != -1)
 		SAFE_CLOSE(fd_server);
+	if (fd_unix_dgram != -1)
+		SAFE_CLOSE(fd_unix_dgram);
+	if (fd_unix_stream != -1)
+		SAFE_CLOSE(fd_unix_stream);
+	if (fd_unix_server != -1)
+		SAFE_CLOSE(fd_unix_server);
 
 	if (pid > 0) {
 		SAFE_KILL(pid, SIGKILL);
@@ -127,8 +163,18 @@ static void verify_connect(unsigned int i)
 	struct test_case_t *tc = &tcases[i];
 	void *addr = tc->addr ? tc->addr : bad_addr;
 
-	TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
-		     tc->exp_errno, "%s", tc->desc);
+	if (tc->exp_errno == EACCES) {
+		if (!SAFE_FORK()) {
+			SAFE_SETUID(pw->pw_uid);
+			TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
+				     tc->exp_errno, "%s", tc->desc);
+			exit(0);
+		}
+		tst_reap_children();
+	} else {
+		TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
+			     tc->exp_errno, "%s", tc->desc);
+	}
 }
 
 static struct tst_test test = {
@@ -137,4 +183,6 @@ static struct tst_test test = {
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
