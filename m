Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F413C28B28
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 09:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E52B13CA437
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 10:28:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B0A53CA420
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 10:28:27 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.207.19.206; helo=smtpbgbr1.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 411816006E4
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 10:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1741771696;
 bh=FitYNveJXbjDk+cGyFHQmWd6LC1P3UlWA+jIoMvuDbY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=SbtoKKn0rMONo0Kl2GyAWOiadu6NTPVTJ+g0Yy/jrSth8Pfouo9r7MgEOq/CTViQE
 NW+l2HBQWEktQ/i6LU91EQk/UnOTP1heJhXDwHBOHcZa0s1Ejc4rihWLf0VRiOd3Ip
 4Krfc9Ur+LsrDjFoFuX1Fuq91+gyXk2TP/6kL8Vw=
X-QQ-mid: bizesmtp90t1741771692tca70y4x
X-QQ-Originating-IP: ahiSqirmIlB3B5EbNM6Q4iSJpp+Ny/nFCS83LUuok8w=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Mar 2025 17:28:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9114036923966425133
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Wed, 12 Mar 2025 17:28:09 +0800
Message-Id: <20250312092809.1668719-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: Mguck03q1giDIchtER5bCr9saMY8LuF18mt2MbVapjEFBuART3Yr+op7
 2lnVm/dgAxwuT5/RW9pdKjfh4VypEQxnvbfNcPV1P6cuU0eUYCIUjMqgwT2vl7ynT95yKW4
 yDoz36WPi+0T+QysGkAiMKHFBkcEhDqUrh1e133F+vv7spz9y6Nm+oZ2w817dt+R5L11o8M
 OEkIkTWY6DDBm+BNCLqchlzwtLs0G2CYxsUzJJG2C1F2QJAxFMu949dT4CU9zWdL9HVhgmC
 UGY0KYNVrhBtGIZxjyNsVmwhOg9HtEVk4V0Jcp0BWveKJOfqkNW92TK+MJuAERZ/V9p1sLl
 VHRtLivrtyi1yjiRtnC9iYr7P8LE9ivI444xq/aLIMFVSR5nPQ9+U3ZQ8ioGJ6xklQqOfrC
 kzMXNL3RoR2cV0qMYG2t9z+NL29k2wxjvaHu7ZYhqsZisAZ7xJd8PlQLm/SL6RYewZVe3At
 t6Fdkzp57momkeZVM3Ot5/m2jKTCuV4Hg8A6Ms/aOBEDXEU723x8edczCyEm+0Lv/deCt4m
 3fhgZjVK+V9V7yPSTjCckVrqBWurHKd9Z4XnFmGH1AijAyhqhVOM/AtfTucdf8fbau0jIcY
 LfY5yep9tSWfd8vGaO8G4gwNnbJHO4D+WpjWMmNC5UyRP3OliMy/kbjhZUcfY9KIST5Ze44
 vwYbT4ohra4DNrr5u3oXt71+9o+O89XORiEs9YlwtiBYHbXVPjf3qj6Mjeb7IpaqE3davAe
 6nszURNzxQVjLpWbePv4ojhSqRg5LaxrVzdyQIh2xYRaPbZ5SkWpbUXWKaG/So9sE0Jwu7Q
 yfpQGISBE3Hlx7dRtIZ6cSrVzO1H89z2fOZk/Fyi8XpgmsGy5fWeay97aHZj3VT5aZrxL8Z
 xYXaKVW0slQFxhSkubSEITLa+hD4Kq7icvtrduNagSBTm3g3A3bLb6cnr8pOrk9+F4yR8Sn
 4lOMrsZGSPA3WCA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unshare01: add EINVAL check
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

---
 testcases/kernel/syscalls/unshare/unshare01.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index 6e6315b11..ce1ed2e14 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -28,21 +28,30 @@
 #include "config.h"
 
 #ifdef HAVE_UNSHARE
+#define INV_FLAG 0x0123
+
 
 static struct test_case_t {
 	int mode;
 	const char *desc;
+	const int eno;
 } tc[] = {
-	{CLONE_FILES,	"CLONE_FILES"},
-	{CLONE_FS,	"CLONE_FS"},
-	{CLONE_NEWNS,	"CLONE_NEWNS"},
+	{CLONE_FILES,	"CLONE_FILES",	0},
+	{CLONE_FS,	"CLONE_FS",	0},
+	{CLONE_NEWNS,	"CLONE_NEWNS",	0},
+	{INV_FLAG,	"INV_FLAG",	EINVAL},
 };
 
 static void run(unsigned int i)
 {
 	pid_t pid = SAFE_FORK();
-	if (pid == 0)
-		TST_EXP_PASS(unshare(tc[i].mode), "unshare(%s)", tc[i].desc);
+
+	if (pid == 0) {
+		if (tc[i].eno)
+			TST_EXP_FAIL(unshare(tc[i].mode), tc[i].eno, "unshare(%s)", tc[i].desc);
+		else
+			TST_EXP_PASS(unshare(tc[i].mode), "unshare(%s)", tc[i].desc);
+	}
 }
 
 static struct tst_test test = {
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
