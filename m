Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4D4C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 11:19:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EDED3C9EEB
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 12:19:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ED203C6D9E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 12:19:27 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B99F600830
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 12:19:27 +0100 (CET)
Received: by mail-pl1-x62c.google.com with SMTP id w20so1522666plq.12
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uOh+tCxwu5YoVMDEis+lAnsAfLcNCjo4dliKJ0GAtpQ=;
 b=dvvdiCG2ZssQ6UuAtR8gerGoEpHsfElFTAfc+SO9KKA8YNXKn1Q6u52JomC1gpYrUA
 jEIVrTDwiCNSpZRwB/K7hqkUxQcTYAG7jTXwVPeUSpw6ql/MhwI4lnO4m31JrJ2m8GUZ
 H9mbmdbkWZXgwA2QSK28v2aQScTDypLd35xFxOXQtQ3+qteW9hViU0vOuDSROFCkbGDA
 qMT0AnRmP9Er53VP1ik4by16k+AmTxIzHGPG2qzMbV82e8i7G0CMBB62+OU58OrddxBW
 QBPQJ0Yg4WdSRjNn+a+ufa0JKKdOVS+7D7zPitccOU6zWrAqNjv2BbuWKlyPYDGZWdye
 NfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uOh+tCxwu5YoVMDEis+lAnsAfLcNCjo4dliKJ0GAtpQ=;
 b=EBCCXT6q4gmYAI+Uakl7Fid4bchfkZvC9UUqn7J7VTJhXu1gPF4EoYauNaTXGFUe25
 1pAvjyWw//q+yH7MimjhOXIn4xzYG3T1LWwl7ARbksAB3DNW6+D9NpTLw/6l8hzmqaJ+
 NiJEKJd6JKiEiSJDEwvYfAZAbAMU72+bhBaDtJ6xh4Cl8ZOTLFADp7e63djBxPREHIqr
 FuRBVivNGlTM0ndxtm9F3uM4AyLRAGaVoRG2RgbRSvP+GatoS6TG4TcT7UTkNGj9U1l5
 MYW18KXFRcdQk+RiukKqBUyg4UaZ7l2MiuBHOGkimZGSuUC4rQ7sK2bxBAnXRyoxJiHC
 QGDA==
X-Gm-Message-State: AOAM532gKs2dKAABoR9jtzebS1eu6yRcw1dahEGFfyRHUcxnEyO2emJg
 zTal68rq67Swmp1cHgmlw9SJ+E+qDH3Ezg==
X-Google-Smtp-Source: ABdhPJzo3vHdg2FRQSweBMlpd+PxKdb0hfdcYMg/uZ6dGWBUj7738U+HQYdd1dS4rrdbXkFOzpdHDA==
X-Received: by 2002:a17:90b:3a90:: with SMTP id
 om16mr2222376pjb.111.1644491965641; 
 Thu, 10 Feb 2022 03:19:25 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:88d9:c143:e4b1:355b:28be])
 by smtp.gmail.com with ESMTPSA id k26sm11632093pgl.46.2022.02.10.03.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Feb 2022 03:19:25 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 16:48:28 +0530
Message-Id: <20220210111828.39927-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] fstat_02: Increase test coverage by creating hard
 link to file and validate using fstat
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

Please ignore patch v2, I think that is wrong.

Fix format specfiers and cast to correct type when printing.
Implements: #517
---
 testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index c0229de44..8084cd4c2 100644
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
+		tst_res(TFAIL, "stat_buf.st_nlink = %i expected %i",
+			(int)stat_buf.st_nlink, NLINK);
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
