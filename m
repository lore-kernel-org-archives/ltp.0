Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013FB1094489
	for <ltp@archiver.kernel.org>; Sat, 21 Mar 2026 15:38:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18E443E2B32
	for <ltp@archiver.kernel.org>; Sat, 21 Mar 2026 16:38:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CEC43CA61D
 for <ltp@lists.linux.it>; Sat, 21 Mar 2026 16:38:03 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9CFFB14000E8
 for <ltp@lists.linux.it>; Sat, 21 Mar 2026 16:38:02 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so1987575a12.3
 for <ltp@lists.linux.it>; Sat, 21 Mar 2026 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774107480; x=1774712280; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BJuLBjNWLxrMXxetKfkepCwpePV+vQ3mlMA/aHYTGgw=;
 b=XEBq9XNAawGEEZhPd/pzez/Okynj6ewXTgqexC4tR/rTsHSQo5kNG5r7IpxHa2Gmwp
 4LwL5FwqJStKjfJWwj13snO0ypoQ5y1if5pkx7EXfFwt8ImVduQFS4Jm0cFmdFOfERxK
 atKvE7w7xJhUDA8q83Y/BGtnhw3XGrJW8p3Bhk7Pt1BQcblNYQHpoEaWIEseEIkGcgP1
 k/qx+MlJZLWhdnlWPVO4NxRj+qRpp96qwvR1amTDCrf+5cvL20IyHZhKOPi44Qjk/pQK
 Et7GgjOQQdImkSAAf9AH/umYHCjkapKIuwIR8lXY9bHr7YLbWr0Q2legYwd/FtwdQusA
 wnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774107480; x=1774712280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJuLBjNWLxrMXxetKfkepCwpePV+vQ3mlMA/aHYTGgw=;
 b=hRK4YuR+UQ+E0idgmw4ZUVNuQ6IKSxyfHtn7gf19ah/3pWwiZQGXKLnzjFO2FjbCag
 TCVHqDNIphcy8HhKFa617IhgrI9Z0ukMHfUqojJT700VbmoanUdRVF+rNVsFEf381MI7
 xJG3WsT5JZdkcxD1SRRKUDYT3PB9LPJY8TimcldFocEsJpjebm2ZHSE1q5qSnoLPpUV+
 AXueE5dw4D+WFTZ3XB27FDfoEF0zn8nbaU5H1HC4vJPlWt3Kj9eEUuLrAluF4Vvfg4wE
 Tc4Qkn08fl1RxzBnZIyNMt5RonRI+TbnQt7OzuePIXd+Yyp54AzRb8/67dA+bqhUmGlE
 0+Lw==
X-Gm-Message-State: AOJu0YytNAHdaz7Guy9DBH9I4FCeeojn8zwiAeA/gMSqcnkvsNgV3+hF
 fFj72zfj8ZEvds/bqpdWD8DGQBGfyuzvAu7YurxbTQ/oQ6LKXxsBZXykKCHFneYHVQ==
X-Gm-Gg: ATEYQzyb67DQdNYvvndXaz0Qnz4EXaBgiSHvotvVHFlGKhbpuCY6Pk+/vJCct93wg4l
 KFYO00vtJQXXElQR7v8ihyPOaES/zF7eKUYdRdg2tSl6/oNQ2zBUkgEeum8gLXE5MeHj7cNjsMk
 1s1qlrXD+RfDX9wkiMIwjz8R4gvCoHNnCsPlI3qSosCIrKd4N/Y0wDlK5ZvL/ry9sIFS1AN6+G7
 0qQbcK3O3CIFr9Tn0Bs6O33Epq6q5p6vpauHl1uJmqFoM+/PHzGpRaESJT3Kmt64IA4aKX917IW
 yaK87UjVfntYX8+Qw6qwjTiXyaU8j+YudEwe9lbNmZ3Yy86RWU9WrdiIlRXLY50naQdbza6Gknu
 jVJlm2dmc+na+rk2GA65uztBv+4Dkg6E0nB+L3A7pJuWDncWLw90vKtMF09xeFYze4YrSCfgZZJ
 j9drNQqjvdEFn3scgaDC2GH3ruEurL88BXl4Fowyb/lA==
X-Received: by 2002:a05:6a21:3283:b0:398:b5c0:583 with SMTP id
 adf61e73a8af0-39bcebbd4b5mr6061947637.40.1774107480440; 
 Sat, 21 Mar 2026 08:38:00 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c763ef3a0aasm1678963a12.10.2026.03.21.08.37.59
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 08:38:00 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 22 Mar 2026 00:37:21 +0900
Message-ID: <20260321153734.5590-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] read: verify read size and data correctness
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

The test only checked that read(2) did not fail, which allows
partial reads or unexpected data to pass unnoticed.

Verify that read(2) returns the expected number of bytes and
that the read data matches the written buffer.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/read/read01.c | 27 ++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index 68d6346c5..f205979b9 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -10,25 +10,38 @@
 #define SIZE 512

 static int fd;
-static char buf[SIZE];
+static char write_buf[SIZE];
+static char read_buf[SIZE];

 static void verify_read(void)
 {
 	SAFE_LSEEK(fd, 0, SEEK_SET);

-	TEST(read(fd, buf, SIZE));
+	TEST(read(fd, read_buf, SIZE));

-	if (TST_RET == -1)
+	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "read(2) failed");
-	else
-		tst_res(TPASS, "read(2) returned %ld", TST_RET);
+		return;
+	}
+
+	if (TST_RET != SIZE) {
+		tst_res(TFAIL, "read(2) returned %ld, expected %d", TST_RET, SIZE);
+		return;
+	}
+
+	if (memcmp(write_buf, read_buf, SIZE)) {
+		tst_res(TFAIL, "read(2) returned unexpected data");
+		return;
+	}
+
+	tst_res(TPASS, "read(2) returned expected data %ld", TST_RET);
 }

 static void setup(void)
 {
-	memset(buf, '*', SIZE);
+	memset(write_buf, '*', SIZE);
 	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
-	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, SIZE);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, write_buf, SIZE);
 }

 static void cleanup(void)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
