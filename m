Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99039109447E
	for <ltp@archiver.kernel.org>; Sat, 21 Mar 2026 14:09:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6DBC3E2B2C
	for <ltp@archiver.kernel.org>; Sat, 21 Mar 2026 15:09:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A4A33C76D1
 for <ltp@lists.linux.it>; Sat, 21 Mar 2026 15:08:46 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A562F200275
 for <ltp@lists.linux.it>; Sat, 21 Mar 2026 15:08:45 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c741db5d610so611756a12.3
 for <ltp@lists.linux.it>; Sat, 21 Mar 2026 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774102124; x=1774706924; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PACKm29HH5vHP+i0DXV1RwibiK0rg7rlDIgPPV5V4yQ=;
 b=LEfr8PjJ8E+fxl+vm+sKEShRc+y6B1YuqUmiTw0E0ijtKto3tof6ArQgrjCqB/FeIu
 TYU5TIsP97lJOjFtBiwECbk3jUQQKc8zMvsUUPtdwBwjOyKdrnCLBoyZ8d5jN5uq2kIs
 TOiTdUpLxVQGY4a6r+ECVcPscyIQ0Km81IqINTMy+RO9KNGxKjGqkYYaxcIuUS21E29g
 Qke/jo9tEPYrWpGdjNmgrDGRbFrGBZc1uAvrMlLkDToFRbawAx92Xj91WYZao5BZZTja
 FJukdWRegN3A2pQBkCu3gwwv7UZ+owLQkJc8CH4ErDJXJlyaWvnfBApc2OI4Rsz/2Gq1
 VSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774102124; x=1774706924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PACKm29HH5vHP+i0DXV1RwibiK0rg7rlDIgPPV5V4yQ=;
 b=rKBvCI98aXyqohyZDX0Z1ECKEuOU4cuIXNDcO/JwA7PZHLy8JGsXwUnm2MogbVx6eQ
 iket9sfdUgMyAE2ckZyX+k/B22oE3FN8/67oClSLNo97WP2OkJEhXSuSCAZHrkhOHHvZ
 RdgN3jZkkG4Z2CEdNPJIrXfLti1qeIMVnx9r1soCUrRXL8jxN/suF748FHDSJlkGpLF9
 Tze7hyKaqLNP1bQXo2kCzgq4O5pWxyclFiWZv5puJbPOtIv4AvGroV9tP6DAhnkBjCtY
 5bF4hGHoNHTyvcxqL36X93mzrZ/yoravQX08t2do8Twg17eoZKSJ5HR5G+q0wD1WY1v7
 H0aw==
X-Gm-Message-State: AOJu0YwmZoBmxZa6pUtkILo3l2pjl/xTAbmiBwCynrAubA1GI9AdZA9k
 CLbEUjmtjjToToVPjfDYxFZsVzAO8zf7G26dagbAeX3VaYHg3KzHh8OjlntiqHYxWQ==
X-Gm-Gg: ATEYQzx9IO1KQvUa94t/B2BMg0e+MUmyp5de55OkwPtY4qWwVMOtd7njkTZ8fN4tmjv
 3z8HK+LSGhea80NfGuhsSOhNOmpkSsMh+8rlVdsMKkT7RP9Zp7oqNt51rA+tZx0CLJyUaXfkeqr
 Tji31vpqudhIYNoI5jfZWWn0HkhBKc9pVKoG/zTwsNY1B1W4aGzjVrCsNlhZGjAoxzC0UEDxElA
 ykjfErbZ1FqFNHChMTZ14NqO42vRlui7SM1U23DFw7HyoCMH0hnad6RuIhrU0BE3wuCrfp/9AzI
 Qavdods3wLviq1+0BNQAs5P0e4de1IIqhcXusOoo/aD1545r0ErLh/EN/EKP3R57K9vU5uLNWHn
 Zu9xOIM0VM5yBL70jJmqMWLp0NYaBZDWlDSDt2fsHVRtlHS0tsXeYmF5qFxoglphkidqc990Eky
 4qRJF6jtxKZCLuESMSsCiGRRpSydYpIzi0D4wC3/sJzg==
X-Received: by 2002:a17:903:2f87:b0:2b0:7d3d:756a with SMTP id
 d9443c01a7336-2b0827d2c55mr57476945ad.35.1774102123531; 
 Sat, 21 Mar 2026 07:08:43 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836b6dc8sm55980085ad.82.2026.03.21.07.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:08:43 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Sat, 21 Mar 2026 23:08:13 +0900
Message-ID: <20260321140819.4157-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69bd5204.050a0220.1a0553.f197@mx.google.com>
References: <69bd5204.050a0220.1a0553.f197@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] open: fix cleanup condition and use snprintf
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Replace sprintf() with snprintf() for safer string handling.

The cleanup logic checked '!first' to decide whether to close file
descriptors. Since file descriptor 0 is valid, this may incorrectly
skip cleanup and leak descriptors.

Also initialize "first" to -1 and set the fds array to -1 after
allocation. Skip such entries in cleanup() to avoid calling SAFE_CLOSE()
on invalid file descriptors.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open04.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 7573af1c8..78254d397 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -15,7 +15,8 @@

 #define FNAME "open04"

-static int fds_limit, first, i;
+static int fds_limit, i;
+static int first = -1;
 static int *fds;
 static char fname[20];

@@ -29,10 +30,11 @@ static void setup(void)
 	first = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0777);

 	fds = SAFE_MALLOC(sizeof(int) * (fds_limit - first));
+	memset(fds, -1, sizeof(int) * (fds_limit - first));
 	fds[0] = first;

 	for (i = first + 1; i < fds_limit; i++) {
-		sprintf(fname, FNAME ".%d", i);
+		snprintf(fname, sizeof(fname), FNAME ".%d", i);
 		fd = open(fname, O_RDWR | O_CREAT, 0777);
 		if (fd == -1) {
 			if (errno != EMFILE)
@@ -46,17 +48,19 @@ static void setup(void)

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

-	for (i = first; i < fds_limit; i++)
-		SAFE_CLOSE(fds[i - first]);
+	for (i = first; i < fds_limit; i++) {
+		if (fds[i - first] != -1)
+			SAFE_CLOSE(fds[i - first]);
+	}

 	if (fds)
 		free(fds);
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
