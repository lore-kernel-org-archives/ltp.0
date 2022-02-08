Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C208AC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F77F3C9B25
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:04:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F4DA3C2824
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:04:16 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 16DB2601115
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:04:16 +0100 (CET)
Received: by mail-pl1-x62e.google.com with SMTP id y7so8150130plp.2
 for <ltp@lists.linux.it>; Tue, 08 Feb 2022 02:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uKxXfwvPDP3vYCVYPbtvPpXk4VwOR0MzRZuxPZrVsMw=;
 b=m29Mx6sYXq7I/HSFpabu7KYtizDZV8jCtllee2tS3271BVPwoV7PIjeRnMUaQ7SnKx
 gMvS2wJXtuxcgqO262TTzl1tO7FC5xbgIuw+tGS19feVc4RHCUbBuCn46eszf9tM01SZ
 zcpXVEB6Rlm80mNGGOGPvixGb4kgZ1YqaaJ7i3yeFHoyCm1Z4IUnFHitpoxOyYR2gaYP
 84o2wk2Nu+q3QXPW+Ls+zYyII3PjRdwfZEZn+PCmxggy729GpwRzspQpFeJ2tckDC4Vs
 ZP/TCOAJci1gH4nzQD1o50NHHA/XDO6yArEinbAgNcQpOBYA7aqh+Xx2m9+hnnQUqg2j
 n2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uKxXfwvPDP3vYCVYPbtvPpXk4VwOR0MzRZuxPZrVsMw=;
 b=OPJn8wFVSmY06c8Hde/jpTNwF9H+a6KtVgTZmvThd86nAiE3R7nVu22PtpsMF96gK7
 mR3SKigm9uGma2CSangepQqEQv+1/Z5hlRkBbOk32SXfTe79GkGRyvk0IYxn4yMV8R2K
 9VpmA5kYrYsqKpGxWibQmwLdILlQzKO/H2yXX/XpUdLoSYfcLb0lP7rlkBmlaPx/U9X9
 KxtPsSIizglI1LV1EpUmZi0+nlKj0mdOw1/dSDd7x13fz0c63+ehU3h+OMtKe7XGMJdM
 rnxPW0lToFkSnw3+ZkBgFgbVd8oEbfqOW4/pfflBITcBSH2RZMoI64VzYeRhifNDg0AL
 cu7Q==
X-Gm-Message-State: AOAM531UKISlITb+pbJySKwxLWdrDWQzF7eC96UfgTTeyGGcZzE4hFzQ
 xDVava3IDQZO305KvFSHn74XXn5XspA4yA==
X-Google-Smtp-Source: ABdhPJx9nqjF26FX+LGXVNuc6riTcrAaPjU8w8G+1fV81FjX8ImvphAyIk+B9GHUaidpUnwG2ZD5Sg==
X-Received: by 2002:a17:90b:3841:: with SMTP id
 nl1mr508387pjb.24.1644314654056; 
 Tue, 08 Feb 2022 02:04:14 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:88d9:6c7d:e496:54b:a827])
 by smtp.gmail.com with ESMTPSA id
 b11sm15480473pfv.192.2022.02.08.02.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 02:04:13 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 15:33:02 +0530
Message-Id: <20220208100302.44347-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fstat_02: Increase test coverage by creating hard
 links to file and validate using fstat
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
Cc: Kushal Chand <kushalkataria5@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch creates a hard link for a file during setup and checks if number of hardlinks
match with the expected number.

This is discussed here: https://github.com/linux-test-project/ltp/issues/517#issuecomment-533035589

Implements: #517
---
 testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index c0229de44..f6f6ca456 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -17,8 +17,10 @@
 #include "tst_safe_macros.h"
 
 #define TESTFILE        "test_file"
+#define LINK_TESTFILE   "link_test_file"
 #define FILE_SIZE       1024
 #define FILE_MODE	0644
+#define NLINK	        2
 
 static struct stat stat_buf;
 static uid_t user_id;
@@ -61,6 +63,12 @@ static void run(void)
 		fail++;
 	}
 
+	if (stat_buf.st_nlink != NLINK) {
+		tst_res(TFAIL, "stat_buf.st_nlink = %lu expected %o",
+			(stat_buf.st_nlink), NLINK);
+		fail++;
+	}
+
 	if (fail)
 		return;
 
@@ -78,6 +86,8 @@ static void setup(void)
 
 	if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
 		tst_brk(TBROK, "Could not fill Testfile!");
+
+	SAFE_LINK(TESTFILE, LINK_TESTFILE);
 }
 
 static void cleanup(void)
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
