Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB43C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 10:51:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8646D3C9E3B
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 11:51:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00D6E3C8FB5
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 11:51:22 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 64F46200DDB
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 11:51:22 +0100 (CET)
Received: by mail-pf1-x429.google.com with SMTP id l19so3708504pfu.2
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6lKV6SombxypFVoalYuhEE1PMHu90Pn4buOA5IzYbLM=;
 b=JOHfDYMGkpmUdd9z0v5QXz7D8emrsilMGCuGajkSs9CUBf2N4ZhNLBMJ7uymWEUrgf
 f4TZF4B6w2KgSegfVSADDqxg9V2s8qzzolg814NhV6Law9kHjIo6wypT15Wo+aXvVC5k
 aY9F1I16IThAAY49GU8otuOMC0DY9TmXQtWUOAbNSumc/JlzDTQ2BUQwt5TO6I36cHnd
 hTNKMHXSrdFP6aoyDUbVFlv6cz21IO7u1GnxlDov9CGeOZc5CdlwcZSAG0vqeICKaQww
 dS9LVhyWLZfLNrQDtXaWKKl4veRZuMW9zAPLr2/v/bkU+me1vhM1qJyXw+IVq0I5R1g0
 VF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6lKV6SombxypFVoalYuhEE1PMHu90Pn4buOA5IzYbLM=;
 b=UqrAmjzirTobC5qtipzlRPgdCCub5o3NJWXunWa08h8ub6v4/JPDYWwSk8kV/hh+7N
 ohzLB+N+wIW6iAukpNxA5fuSXGCtU1bMt1M4BMJ+04f/y6cQHNw9sKnQrNDHQBWzRRMY
 XhF0stQJM3KE6d3dFJ27xlzxqbqGY5ALBjS6uHmBj+zm9Ye5Wi9SvL0ZU6hyjOugTt4k
 wMLk1UOt+KWeR7Jy3Prd7Y5rn1jELjOlLz0/MXCbChM8Y/8ysVaR405ag7kgsYEeqqnb
 azjX3snEmIo1AiP3HA/sE6CxWFexVcrHbFMoxDL0oP7VLKDvtJmZDi4aKDgWnX97QD3g
 65vQ==
X-Gm-Message-State: AOAM533opXMvmdRUUsmObfdSKN51NsEEXQdejZ84BI/MioZuxiwoe3HG
 LDCQqZhSfP3KfmgrBoGr4S35/PUfHV/cgA==
X-Google-Smtp-Source: ABdhPJzGzGUHbqpDwA4q0Ct+iPDG7rlgscydyiIC2T+pbNEudpPd7CPPc4amEhnJAHLd47QgyQlS5Q==
X-Received: by 2002:a63:f711:: with SMTP id x17mr5721054pgh.274.1644490280614; 
 Thu, 10 Feb 2022 02:51:20 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:88d9:c143:e4b1:355b:28be])
 by smtp.gmail.com with ESMTPSA id g126sm2009232pgc.31.2022.02.10.02.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Feb 2022 02:51:20 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 16:21:01 +0530
Message-Id: <20220210105101.38337-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fstat_02: Increase test coverage by creating hard
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

Implements: #517

This patch creates a hard link for a file during setup and checks if number of hardlinks
match with the expected number.
---
 testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index c0229de44..2f9632edf 100644
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
+		tst_res(TFAIL, "stat_buf.st_nlink = %li expected %i",
+			(long)stat_buf.st_nlink, NLINK);
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
