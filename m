Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F13FCD98CE
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 05:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781587553; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=AdlmUXRDWH6dU/cUom/6qcGYwHzXlOO0Blr5Xp0aB08=;
 b=PKZ2y1pBS02ANdNFrhSfG3xwknpiiUkNUSAJJW8bc26XrrSCaO3IER/fciAUB0IZaKTv+
 kTcbJNypWSpiTmx067UIMyUBNSD2HWos6PxECl3Ehqn0fAP0lqnWYzUUN+E0O0Ja39O/iAH
 /J2oxColh4ZBU/iQi/7kUAhm+XFU4wg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BBCC3E2258
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:25:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06573E223B
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:24:59 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5ED1D601293
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:24:59 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4921e4dd62dso23490505e9.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 22:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781587499; x=1782192299; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uG2hocwAIGGlst+S9OcGWFxrx4C3gtAio8/VEaZzQdM=;
 b=b+FcnrCZtxXeCvnL/GHGamAng3ooM4gVZK5y4FT/XmyHJpVeQTswimfIJJKGsltpnm
 HkRTYOFp5RZP0SWLNMszj8kf3a0w6kdZCFQWEgQjCBJiHqe7RvKkdsqBY9KF5i+kKKYi
 VM2W1I9cA7EiToodJ+X+sEtApIgABpdRLco9fPJybtHBd78c7mgkmdom4VYT9zGX6Kmi
 ZN9WITFTLfgP57uOsE8G5yzHZfQCyIIbPKbZJGG+/nXKV8xH0+tVDoenPEGSewwjJCwL
 jlWRTNie2MJun3lCTZvX/Pd4gX8EGpM/hAB9rdiU2cgdK1hXFtkEMI4NdErVTED0NPdm
 QePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781587499; x=1782192299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uG2hocwAIGGlst+S9OcGWFxrx4C3gtAio8/VEaZzQdM=;
 b=ak1YQH5STJ2UbZh+AByO+A/J2y85F8lv0ABjnEuLC8x2GzpF+QvD+VzKWV4PMlOr1M
 LDiTLLkYU1IF9/eSET4oZREB/Bm4Ja+7X55ellEN73jOs8uYCpsA9W2SK8+tmkCLu8Ws
 6Wd6M9Xi4OyW+Uyu3GsWRxVaYEwtZptCtAv2G1sWTkVEm2K0NGTvdGb1yMjavtSC/4MJ
 zdJw5gZk77l4zFC7mmrxQ3wZ1K6C/TVrlnn9j6nmzvl5qzAEIzlPe/1PewK/wvh2YmQP
 l8LyJXCVGzAfwy7V3Zn/IEWcqjduHYf997c9cHF8AixF7ozp3ojksZPseyfKs9XtCEOZ
 6A6A==
X-Gm-Message-State: AOJu0YyZsnC8MiWv5TBqwwNobFEa4L5JGGQ+5Ge0NbM3gLVX+QGIwyci
 mv6DqXvaYUceYh39iOcQSbDcVDJR8ZOM4Dp9u3nLIgZNpU6kZZAjv5nr0Sbi8GMpVr7VE2NpDFk
 q7QE=
X-Gm-Gg: Acq92OGn3Q7WMEIMOUVT/YnSr7CBid96AyN2mBubeZ58093fB/BLZT7DuLNmdv1i0X4
 8CnTZSJZbR+Ty/FJxXM55A52xNMWPG3t2xhtrXAECW6ShlWQK7tnUGPQwXh2dtThLfuJOmlSwqS
 xbKBTrHibn4LzZqWk7CqUqC7yg1MAeiloj6FGe0vyxmvGh01FIFr0GCRrpMiMhjNN2ByuqXkDvR
 Rk06xFjfXaXX9TlWP23VAwRjCWu4DLHMfdYhkt2bnp82Xim+Ur1/WOaMuCKGVDsGiH87zT6m/5E
 UEkicQen2W2WFw0YEcQqwjKBhotfSbPrLoOeVNT0UsKy28Upo8la21jexO3gp1Gf08wnyMszMGt
 HLUBXlhLKoJHMs2gV/IVoEBr2SR6xEQO9ru9nfpVBXZZteoFyLfNjMGg2PHH3EvQABRhqrpKzVq
 wrjmlhlRnpl1nbiofdzKaI/Q==
X-Received: by 2002:a05:600c:56c4:b0:488:a502:8955 with SMTP id
 5b1f17b1804b1-4922faa14d5mr25942725e9.4.1781587498777; 
 Mon, 15 Jun 2026 22:24:58 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4606f26f23fsm40397473f8f.9.2026.06.15.22.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 22:24:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 05:24:20 +0000
Message-ID: <20260616052452.8353-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616052452.8353-1-wegao@suse.com>
References: <20260616014747.8220-2-wegao@suse.com>
 <20260616052452.8353-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/2] connect01: Add negative tests
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
 testcases/kernel/syscalls/connect/connect01.c | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index fd288559e..7b18b664e 100644
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
@@ -115,6 +141,12 @@ static void cleanup(void)
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
@@ -127,8 +159,18 @@ static void verify_connect(unsigned int i)
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
@@ -137,4 +179,6 @@ static struct tst_test test = {
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
