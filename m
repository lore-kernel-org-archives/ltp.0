Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D4CE9A02C
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 14:48:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D5223C60F2
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 15:48:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2BF73C60F2
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 15:48:18 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8EC306009EA
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 15:48:17 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a9296b3926so37252655ad.1
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771426096; x=1772030896; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=a3mf7qw2je1qP7dVrI9xYHmoYwlB/FmMaT0gqyHrIaY=;
 b=fBv96an9OxWx0Q0F/o1N7WrYi9hI4xDP7i2o6CaJxwV8NbXirUPNXlVtGAYF6/UOb/
 zu0FnI7LrKSLHjs4T3EbCN8N89C3iXPBEBJfQmiYgP36Trt0BNLEXP9hwVvoEY5mhBqO
 0TKPd0aiiz3N2/sMNfXyJQTXBlEbEGoGTmDs7jjruXO5pu0IkGPQMBTDIj0vVQ9CwGZi
 /Gbgq8i2G+3UfCEVulksqKOSCQdVdt7N9Cbz9uFl8nZSpTloc+sS6L6WWoUlMQjLyWeq
 1a1soeVfuJWTjQcW++qcXF0kjEbP58AJKnh4BCtX4LNoREQPTbT8PjPEe5cxidt6adyf
 DHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771426096; x=1772030896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3mf7qw2je1qP7dVrI9xYHmoYwlB/FmMaT0gqyHrIaY=;
 b=MnxSj4iDLL1FsF5HJ+MqvnXG6lsuMCUTi24MXd92QlRzb+pLQDrd9ln3BCf/IWCXNz
 4WYBswVreQDMC/WRcUgG0Lvf5AbgQDuhoYDWOGbirZssBpz/cHDyziqvLMewnN0w2J8t
 /VS3gJlUKGJi3AscTTr0CZuV7dA+Zu7kaAJ/w3B7loFaqSfVCMKQUeyY8NJWPhkyUva3
 eiAgQRTvt4CSYnCNcRXr4BJutn8ahFT1xf+ptR4uWc2SUd8ZRYKdZVOXhTVunED2Hdae
 gIvp850gru64gOShJl3xDGRgpFaCQN1vxsmADPgO8ouUAVwYCxDOPANWX5MJOuM68zGr
 2y3Q==
X-Gm-Message-State: AOJu0YwY1wIYRT3czpyqWDJYenrh+CwF3KZVAQNsZpNwQ2t79I5w0oqv
 azSBmSXjjs942NvEJhdHQLrr5/HX0ZxaGblhcVYKIWK4lLnh4IL/Lh3vPSikk74PpA==
X-Gm-Gg: AZuq6aIR3kjQ0NAidkG4Ig5B3efdgrqJQvDjOVD4YlkajzHrDPePsuIdWxAewrTI+ZG
 i3pIR83eb0Ydo9KBZu+KQJRVmWgKiMZV9LBvVmY3HUzzbY0rTbi84rV7CqRmpKNF3Tx2D6dMi2Z
 ezcahzhCj0NhW8wSXpQugL9rqFA52+SlfUgLK8q+2p646ULFB6bPSit2Jl1Wr4dRoU3Q4M0g83M
 Gvh5mKHukvha7uDL0fmx2NOhml5oVeYeQT+oGBJPcqcHW/IujUiyKON2nLVJTKvmoK+6vuvhz7+
 CcLfqcLhmqJy9Rau5eDpuOPQHooqd4Aaodql/QEJ5UerAuQ4n94eZDXsB1hFYVLs2x0Mzdgdlo7
 fK9GV6KNINwkzEv/XLv0+0j7o+OWZRB3vcnl1wtdNnc89iKfcr5UZA3YlvUzTXqdYtkxYoRe49M
 HCiK2Nuh/oO+bR/KFkONmGdhJaCDPcHPjCA4UMrKvSUQ==
X-Received: by 2002:a17:903:2445:b0:2aa:cfee:a47c with SMTP id
 d9443c01a7336-2ad50fbfccamr19180535ad.52.1771426095623; 
 Wed, 18 Feb 2026 06:48:15 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a7145cbsm188539455ad.30.2026.02.18.06.48.14
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 06:48:15 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 18 Feb 2026 23:47:26 +0900
Message-ID: <20260218144747.2771-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] open: fix cleanup condition and use snprintf
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

Replace remaining sprintf() with snprintf() in setup()

Thanks for the review.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open04.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 3dc3486d3..5d39c1569 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -30,7 +30,7 @@ static void setup(void)
 	fds[0] = first;

 	for (i = first + 1; i < fds_limit; i++) {
-		sprintf(fname, FNAME ".%d", i);
+		snprintf(fname, sizeof(fname), FNAME ".%d", i);
 		fd = open(fname, O_RDWR | O_CREAT, 0777);
 		if (fd == -1) {
 			if (errno != EMFILE)
@@ -44,13 +44,13 @@ static void setup(void)

 static void run(void)
 {
-	sprintf(fname, FNAME ".%d", fds_limit);
+	snprintf(fname, sizeof(fname), FNAME ".%d", fds_limit);
 	TST_EXP_FAIL2(open(fname, O_RDWR | O_CREAT, 0777), EMFILE);
 }

 static void cleanup(void)
 {
-	if (!first || !fds)
+	if (first < 0 || !fds)
 		return;

 	for (i = first; i < fds_limit; i++)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
