Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2524EC3DA6F
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 15:47:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C686A3CC560
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 17:47:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A6163CC4B5
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 17:47:10 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 62B8D1A00E20
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 17:47:10 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1bf56d92231so503935ad.1
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692892029; x=1693496829;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5GoBsJeMVRfyqUyHmVPKYWT5Kn96l13eG5VbdJ1tmy4=;
 b=4zi7vPmQS9xaa6Eds7Mcu5JMoRram4Pl6Ssa2mfY/mROEKtMyiCu4yGmvrd/vzJtSQ
 hXtzM6Qqf6modk1gBhIPMymhojN0MkXtwZLjLRFLZRDti9YbIaWGSsiJHCi6JT7E3SVU
 VIK8dMcQu85+acNYcmiKonT8WhqwQgdZqcUXAw6xWGV7J+BKCebqyRs1vDu6ujBCTzCc
 DBRyWUEFENMhTut25GnlOdN44uDcx0fVclH4w3lvENBjoeWgSztnCj+ftpxsMrtV44uk
 OghsjwIpndfLkUERu4E2AyX5b04PUu+b7OsmrduvV8fUndVH4xikwVVisJOqtWMb0M/X
 NrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892029; x=1693496829;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5GoBsJeMVRfyqUyHmVPKYWT5Kn96l13eG5VbdJ1tmy4=;
 b=GmgCub65hGN7xNsA+fBbNOZaWJUWX2u3Ifs1kKMBrmG58INxY8PkK9jNT6uNxcmLct
 qYAWrkRLptFZEinKzAu90NvBnSoA9qHl5124dRsLnH4BkXa2XzisvxL7OxaQ1+R2e44Y
 ZlIMtUPzWutZ8PIHvDcXnHxyGqPANxrgf/Mc2EQ7XgAXE5+1NUHPRrt9YM6vmjWOeNBz
 3fssocdMnlT5qpv0XTzlekhQEdiyToVUk0xTIovExfr27hbVqRi2Jbw8IituYWWuSDHc
 elDczWpNngY8re/SgDvo+eNn8VutHYcGbN75QtyDRhxiZHhT37Zgamcht31QUQa9xyfy
 o10Q==
X-Gm-Message-State: AOJu0YyneGQOaoMKWDCy9Nr8/RquRQUy3LwPK2VvSDu0Mx13M9/G5I1Q
 MKrEN7n5OIQuVHZ422EvL0GVD5wlebVKvqCYY4s1bIaHCnLThJjnPIjD3dY7UhEkGOdfSh7UC9R
 grtO20KPxfZXCmRPz2fOk5i0iNHkM/O9wFOY6Ll1sDEQo0mqtiLHriTDT
X-Google-Smtp-Source: AGHT+IGUX/EGYDWyA23dNIxqfoAPPZVQUqjDonBTc0jh+cgw0uzt65Kg7wXqchgjODy8piE/rvuVArVuZog=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e548:b0:1bd:df9a:4fc6 with SMTP id
 n8-20020a170902e54800b001bddf9a4fc6mr7085162plf.4.1692892028428; Thu, 24 Aug
 2023 08:47:08 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:47:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824154704.2598018-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] epoll_pwait_var.h: check for syscall availability
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: enh@google.com, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Check that epoll_pwait or epoll_pwait2 is available before running the
corresponding test.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../kernel/syscalls/epoll_pwait/epoll_pwait01.c     | 13 ++-----------
 .../kernel/syscalls/epoll_pwait/epoll_pwait02.c     |  2 +-
 .../kernel/syscalls/epoll_pwait/epoll_pwait03.c     |  2 +-
 .../kernel/syscalls/epoll_pwait/epoll_pwait04.c     |  2 +-
 .../kernel/syscalls/epoll_pwait/epoll_pwait05.c     |  2 ++
 .../kernel/syscalls/epoll_pwait/epoll_pwait_var.h   |  9 ++++++---
 6 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index f4a55e008..05addf4b0 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -73,16 +73,10 @@ static void run(unsigned int n)
 	tst_reap_children();
 }
 
-static void epoll_pwait_support(void)
-{
-	if (tst_variant == 0)
-		epoll_pwait_supported();
-	else
-		epoll_pwait2_supported();
-}
-
 static void setup(void)
 {
+	epoll_pwait_init();
+
 	SAFE_SIGEMPTYSET(&signalset);
 	SAFE_SIGADDSET(&signalset, SIGUSR1);
 
@@ -91,9 +85,6 @@ static void setup(void)
 	SAFE_SIGEMPTYSET(&sa.sa_mask);
 	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
 
-	epoll_pwait_info();
-	epoll_pwait_support();
-
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
 
 	efd = epoll_create(1);
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
index 7914f1c50..1387eb6c9 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
@@ -32,7 +32,7 @@ static void run(void)
 
 static void setup(void)
 {
-	epoll_pwait_info();
+	epoll_pwait_init();
 
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
index 2ad1a6abc..8b0f07ecc 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
@@ -40,7 +40,7 @@ int sample_fn(int clk_id, long long usec)
 
 static void setup(void)
 {
-	epoll_pwait_info();
+	epoll_pwait_init();
 
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
index 54b9be975..b9808375b 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
@@ -28,7 +28,7 @@ static void run(void)
 
 static void setup(void)
 {
-	epoll_pwait_info();
+	epoll_pwait_init();
 
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
index 4c4aeb77d..d87646490 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
@@ -38,6 +38,8 @@ static void run_all(unsigned int n)
 
 static void setup(void)
 {
+	epoll_pwait2_supported();
+
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sfd);
 
 	efd = epoll_create(1);
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
index 60ee128c3..58a3f15a2 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
@@ -32,12 +32,15 @@ static int do_epoll_pwait(int epfd, struct epoll_event *events, int
 
 }
 
-static void epoll_pwait_info(void)
+static void epoll_pwait_init(void)
 {
-	if (tst_variant == 0)
+	if (tst_variant == 0) {
 		tst_res(TINFO, "Test epoll_pwait()");
-	else
+		epoll_pwait_supported();
+	} else {
 		tst_res(TINFO, "Test epoll_pwait2()");
+		epoll_pwait2_supported();
+	}
 }
 
 #endif /* LTP_EPOLL_PWAIT_VAR_H */
-- 
2.42.0.rc1.204.g551eb34607-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
