Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C520C7113C
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 13:19:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 217533CCAD4
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 15:19:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 620E53CCB51
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 04:47:58 +0200 (CEST)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 206751400060
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 04:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oR/F1
 yNyt1kET33YuaI2BI26NcqG5qBCkx8m4D+mhvg=; b=L1SKEQkJdjllgbPn5S/+C
 k/CjYvIz8yKjIks9frxinFI914X7RDau5qeDEn8gREUY2wFSpRK8VWWR687cqCwS
 +meHsoVxHX4P2eUBI8XZKRlPsRQFmQEiASnSnZ5nkuPBlld8y1qkj7v+M55jYpBm
 NRmQQ2SSJ+Jyf6QPn+Db/4=
Received: from localhost.localdomain (unknown [139.159.170.26])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wBHf1PU295kS9vhDQ--.11029S2;
 Fri, 18 Aug 2023 10:47:49 +0800 (CST)
From: bingdoumi@163.com
To: ltp@lists.linux.it,
	liqiang64@huawei.com
Date: Fri, 18 Aug 2023 10:47:47 +0800
Message-Id: <20230818024747.37062-1-bingdoumi@163.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
X-CM-TRANSID: _____wBHf1PU295kS9vhDQ--.11029S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1DXF1xKF1UKF4ruFW3ZFb_yoWfKF4xpF
 1xXryFyFn5AF95JF13XF1qgr48Zr97Xa1fGwsIkrWrGr4kZ3s8GFZYg3WaqryYgrWUKayq
 vFZ5GF43Jw1kGFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UEPfLUUUUU=
X-Originating-IP: [139.159.170.26]
X-CM-SenderInfo: pelqwvprxpxqqrwthudrp/xtbBbBjP5Fc7QGeFjQAAsc
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 18 Aug 2023 15:19:24 +0200
Subject: [LTP] [PATCH 1/1] fix the typos of 'epoll_clt' to 'epoll_ctl'
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: liqiang <liqiang64@huawei.com>

Fixed some typos related to epoll under testcases/kernel/syscalls.

Signed-off-by: liqiang <liqiang64@huawei.com>
---
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c     | 4 ++--
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c     | 2 +-
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c     | 4 ++--
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c     | 6 +++---
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c | 2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c | 2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c | 2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c | 2 +-
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c | 2 +-
 testcases/kernel/syscalls/epoll_wait/epoll_wait02.c   | 2 +-
 testcases/kernel/syscalls/epoll_wait/epoll_wait03.c   | 2 +-
 testcases/kernel/syscalls/epoll_wait/epoll_wait04.c   | 2 +-
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
index fe16ad1cb..dcf74bf77 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl02.c
@@ -67,7 +67,7 @@ static void setup(void)
 	events[1].data.fd = fd[1];
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd[0], &events[0]))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void cleanup(void)
@@ -85,7 +85,7 @@ static void cleanup(void)
 static void verify_epoll_ctl(unsigned int n)
 {
 	TST_EXP_FAIL(epoll_ctl(*tc[n].epfd, tc[n].opt, *tc[n].fd, tc[n].event),
-		     tc[n].exp_err, "epoll_clt(...) if %s", tc[n].desc);
+		     tc[n].exp_err, "epoll_ctl(...) if %s", tc[n].desc);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
index c92b0b62e..f617295cc 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
@@ -55,7 +55,7 @@ static void setup(void)
 	events.data.fd = fds[0];
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &events))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
index 5173755f7..bc015c01b 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
@@ -36,7 +36,7 @@ static void setup(void)
 
 		events.data.fd = epfd;
 		if (epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events))
-			tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+			tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 
 		epfd = new_epfd;
 	}
@@ -59,7 +59,7 @@ static void verify_epoll_ctl(void)
 
 	events.data.fd = epfd;
 	TST_EXP_FAIL(epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events), EINVAL,
-		     "epoll_clt(..., EPOLL_CTL_ADD, ...) with number of nesting is 5");
+		     "epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5");
 	SAFE_CLOSE(new_epfd);
 }
 
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
index d03009cf3..71e300daa 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl05.c
@@ -40,12 +40,12 @@ static void setup(void)
 
 		events.data.fd = epfd;
 		if (epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events))
-			tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+			tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 	}
 
 	events.data.fd = fd[0];
 	if (epoll_ctl(origin_epfd, EPOLL_CTL_DEL, fd[0], &events))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_DEL, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_DEL, ...)");
 }
 
 static void cleanup(void)
@@ -61,7 +61,7 @@ static void verify_epoll_ctl(void)
 {
 	events.data.fd = epfd;
 	TST_EXP_FAIL(epoll_ctl(origin_epfd, EPOLL_CTL_ADD, epfd, &events),
-		     ELOOP, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		     ELOOP, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index f4a55e008..928d57803 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -102,7 +102,7 @@ static void setup(void)
 
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
index 7914f1c50..2ae32519f 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
@@ -42,7 +42,7 @@ static void setup(void)
 
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 	SAFE_WRITE(SAFE_WRITE_ALL, sfd[1], "w", 1);
 }
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
index 2ad1a6abc..aa08daa1b 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
@@ -50,7 +50,7 @@ static void setup(void)
 
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
index 54b9be975..4be33488d 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
@@ -38,7 +38,7 @@ static void setup(void)
 
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 	SAFE_WRITE(SAFE_WRITE_ALL, sfd[1], "w", 1);
 
 	bad_addr = tst_get_bad_addr(NULL);
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
index 4c4aeb77d..ed8f3e4f8 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait05.c
@@ -46,7 +46,7 @@ static void setup(void)
 
 	e.events = EPOLLIN;
 	if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 	SAFE_WRITE(SAFE_WRITE_ALL, sfd[1], "w", 1);
 }
 
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index d2c0b6ef4..93ada1cf3 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -50,7 +50,7 @@ static void setup(void)
 	epevs[0].data.fd = fds[0];
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
index 4b21aba4c..d31e49864 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
@@ -57,7 +57,7 @@ static void setup(void)
 	epevs[0].data.fd = fds[1];
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[0]))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void verify_epoll_wait(unsigned int n)
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
index dc62e9202..bd8baca22 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
@@ -49,7 +49,7 @@ static void setup(void)
 	epevs[0].data.fd = fds[0];
 
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0]))
-		tst_brk(TBROK | TERRNO, "epoll_clt(..., EPOLL_CTL_ADD, ...)");
+		tst_brk(TBROK | TERRNO, "epoll_ctl(..., EPOLL_CTL_ADD, ...)");
 }
 
 static void cleanup(void)
-- 
2.37.1 (Apple Git-137.1)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
