Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B90CCD98DE
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 01:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781574511; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jSUl22AVkeEvtBjTjsED4AD6TAirPzO7gEiHRuAhYWo=;
 b=OWqiPpondTJ6OgNDGN22/WgH4tqE+Km7BniEvryvPS0OopkehO+Rt8i5qTWUP/rK+UsVY
 3Twr1WBrTFAF7TAGBhOC29+2e0fbxX1nbRh10ao3GpMyG0rPU7Tpxh+paMlcDV3KSW0w2lv
 LWnBuSKwD07uJPSxfVJVTEy+wJnvfzc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A09603E6CE8
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 03:48:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE55F3E6CE5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:47:56 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7B70C1000524
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:47:55 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so4513912f8f.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 18:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781574475; x=1782179275; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYY6/w7T2B5kON6pkQPfj4T/VLfo2M7Slcv6FtJRGU0=;
 b=O1U3iJSiqBml83NAGrNIqm7kpWllG4QI+yHK5h1km59EuJB+io4T3ZwvzuhVC558Ns
 Hb8MDjq9r0USPUwqiVDBlTDahzmBAKZxwliFo3wfEyr5E2I/6I3I0pzUenzPsTO8jVYS
 NTUOXRsIR4rQL6xvQg5kN0vaaWKv9ymxwFqftmsMicSh3FUrNysqLH/I4ZCthx8Yl2Hl
 5071ma4AMbSgdItEBA0uTe8fT5yHpmeYpiQBQ355KR4W4KkoW5pR3yeWXM3sgff+7epq
 GMi2PFrVZSMiVuI/BW1rK6KqfJOUJo7Lu8UI/GBBjAnWeSOqrXfSP1DCZ65KHGIrUG1d
 eN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781574475; x=1782179275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qYY6/w7T2B5kON6pkQPfj4T/VLfo2M7Slcv6FtJRGU0=;
 b=RMOjweII3j8Q7iwVVceq9VOVs7zFvt/kkK6vnj/z6xavx88nZew1wEAxHOoD5lL4YU
 amNdADqnicG2mm2eIjVGL4oK0w5lG5xJHwaliMWKFIED75OTO7auU/qiS+ythKHsjuVW
 v+xNgYi7HhGb4hB5FaLbbBxHDJg9027xkC0l7fIB+is52BXYE2fvLKPO+Rh1Y3GlB4xH
 oSv9uGoIPiPBXZI4eePTs8fernfOdpMCf6LtHqZAAbhplqYRkVyiL3sppjASQwX2NUXA
 afAsE22BG72F3yDR03f6jsZQmN3lY6gY8ra4vapI/phaznBfRXzSSX3f59PusUJHlzBO
 OCXQ==
X-Gm-Message-State: AOJu0YzWEwyw1RXYRn1XHeKkx4rF0WkjpulZOQj6+BaMDuZ4XTyoQLzX
 DzO/YTEUyabT0orTlmX9mQKuIqp0pPfZdVJ+Aw5xJSEFbbaZe6WBlFy+8wbq9UH5Utd3I7tE3fP
 L3s8=
X-Gm-Gg: Acq92OH6dvlArJmly8tLWihkq54zRtKloejrdMmt9QsjTb6tGnq1fgWE4WV3+0Vwbz0
 7DTQu2exLgpD2mCSKvZI46jNS6pFCAciObbT/OtRlFGGdoCAyfCnS2kPFgX4+QyiNCTP27pCiOK
 ZFKY3yCvTDUBsD70LHYrbcSPyWzMFHUsHh1eyYVSP/VtUMYz6iaamVlMkNPHdXQmxT5GH1u/C4G
 qjkA4hEsDWobSND2BdgFn82tTY5nrATT6+YP+3cuqtQuh2u4uC3Cesl7HaiCk/PPVYOwIOuiwfG
 Xe9FPGd7azBb5LAUsccDrqDzua+V62CdpC1pcltWgZvhbiB3ZgBKedAnR3d/equJZRYkmoQw0br
 20fXHEMTnpiZU/qJSoFWi0ompkB+Q+KHWOT9UeX8VGwebOkeKv0Xial6WIl3onPjdurQ3ac+HCi
 IYROBliuy+0Cw=
X-Received: by 2002:a05:6000:43c5:10b0:441:1e41:19c with SMTP id
 ffacd0b85a97d-4619f3ac5afmr1956376f8f.20.1781574474917; 
 Mon, 15 Jun 2026 18:47:54 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm40022900f8f.37.2026.06.15.18.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 18:47:54 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 01:47:34 +0000
Message-ID: <20260616014747.8220-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616014747.8220-1-wegao@suse.com>
References: <20260604045008.29021-2-wegao@suse.com>
 <20260616014747.8220-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] connect01: Add negative tests
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
 testcases/kernel/syscalls/connect/connect01.c | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 5a3ff2fcc..6b88c5e42 100644
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
@@ -104,6 +117,19 @@ static void setup(void)
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
@@ -116,6 +142,12 @@ static void cleanup(void)
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
@@ -128,8 +160,18 @@ static void verify_connect(unsigned int i)
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
@@ -138,4 +180,6 @@ static struct tst_test test = {
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
