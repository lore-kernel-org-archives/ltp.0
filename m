Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC8EE3683
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 13:23:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7CD53CF350
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 14:23:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45B373CF2AE
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 14:22:48 +0100 (CET)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E426520033D
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 14:22:47 +0100 (CET)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so3210860a91.0
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 05:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770902566; x=1771507366; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KuclO23CJsFpJaRHLAe4VpOpTwjOT4IpZT0HpUcJ2DE=;
 b=e08L4zWxL3NFVM2pbUB83pBMVVwadkO3Kr5JFPYRcOsHJVTs3fksGEGxx/AZfL3HWO
 Fl/NchmLLzUuutop/Vdv0cmMaF93EEqlSXYb4mAOhlvsw1ZKf7xe3lwkj2mAcgnVMlOB
 dwAAvzvtg90yvKPSN9NbP/2HkcmZow8HU8Ff1b/1NwApGgihg/Qtbyx6cqvS+GOCEvRz
 N2mZXoPifBsMbqxiVHjyZsE2PO07FMmoBW1+CtYK5yr1fc7qSXyAwHdS+pJufUAVJB0j
 tQeNL3pxijC3uVjXnDEKSGXi3KK9WmIW1QRYKT9A/CGFzM5FyDKq20Q54UyA6oN0bkyQ
 3yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770902566; x=1771507366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KuclO23CJsFpJaRHLAe4VpOpTwjOT4IpZT0HpUcJ2DE=;
 b=X4GkXLfbICNh/PhDAuYRvirsRet5WA4I0I2OOFPOCdyH8B6SIrqrdGhd5hVPou29zS
 YeVT4Bs0dd9r88wuoI/39O+8NR5CS+hKhrZ4rzi2VZg6eiHVGDtnkWlubc7vII/UFK2k
 iKCKbW2TXq4iN0umosc0UuYy04njpLfBRklZ5IPwpo5a/Gg8zCo9Y/mPWY5iXTy6CHqq
 lFrnq3gNiPRgs68UJaQ0xXr2CPcY7gfE90h23Gm/VjOr6g39WqNCQyBQEEo4Ed3urchm
 r40KCCS7TSlH24BCpZPw6W18sLrKNpDDkKlKhhanU9To+/dDr35MDhCUDgqp3YmLoCYu
 804A==
X-Gm-Message-State: AOJu0YzFlarea/FmN8tLOXNXwXl/2C4A2U3Lu9lihCZ8JbyPWC5wSd0w
 S+ciKVElR+QZkr3PGpegeR17WjFDI6PfrCOSToT2ecGRazvizM1ilMiu/JMB8J/QbQ==
X-Gm-Gg: AZuq6aLX2SmG1Fng6Vn9T8BtfOQOWikqIRwhVri/ttpHoQfcEVUZ5TZNpYR6pELLowk
 4VstDg53QKi9jl7nJ0zWAAlmvgRy/6rVnLhqpLHrQ694vyS4WMNt69wiGQhJKIeSIB9+gVsfRjN
 bJhtm6p82/StVZWedvo0pMbRlOVRCxzyrpyZziQ+jX3Fn25Nl3qKoZ7pLMiKnDXVbKTJCYiy7aa
 VGRc65BRJfpbPg+U5eIC+OGuso7t5IUSVS6a3JwqsLpZwhNgJdS4ZbY4FAIFMBD6ZvkuVlhGcYr
 tJF7+uh0fVw6HG1rodDErwpd6r+w9BPDOjIxDil1paIJKQSODsg+qxPfD3atNTPZQCpMSYZJXFj
 uciGKc2C+MJye1HG7YyY/DYOOvJe639klwzpSIjh5A6/Me+Pi75/G0LR04yA49wnGiHeIKnLoo5
 mIcacDOcdcZQIeGd/mRfZBQoPLA8kRXc3KtQwa917Gp6XmMb1V3f5l
X-Received: by 2002:a17:90b:3d8a:b0:34c:a29d:992a with SMTP id
 98e67ed59e1d1-3568f51ef20mr2314717a91.34.1770902566033; 
 Thu, 12 Feb 2026 05:22:46 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d9537sm5403920a91.4.2026.02.12.05.22.44
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 05:22:45 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 12 Feb 2026 22:22:13 +0900
Message-ID: <20260212132221.4231-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] open: fix cleanup condition and use snprintf
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

The test uses sprintf() to build temporary file names, which may
overflow the fixed-size buffer. Replace it with snprintf() to avoid
potential buffer overflows.

The cleanup logic also checked '!first' to decide whether to close
file descriptors. Since file descriptor 0 is valid, this condition
can incorrectly skip cleanup and leak file descriptors.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open04.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 3dc3486d3..ed5dd27bb 100644
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
@@ -50,7 +50,7 @@ static void run(void)

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
