Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4897ECD6E6D
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 15:07:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD2683E618C
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 17:07:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5A813E1D91
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 17:07:10 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2C523100098E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 17:07:10 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-36d5fd50d20so508817a91.1
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780585628; x=1781190428; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fpro9ICUs6RXBVxDiRI3uM+xnLXPpa5u3Hlw5ScHuCs=;
 b=f1PThqvCQYz7K6iAP23IbkNy8YYVnFhstIRPMh9x/2Lay7Qhwvysg98hGMMLcC3Mhs
 KtkrvtBygHHmIau0FLUdkQE1PGSHAFSpTEkozMKAWBXtISqpXtdLL14nnr8PfCx00drw
 L9ZvXbjqyGfl7QewYAkmveqp+eWQ0vWldEquQVuZzyEhL6bYdmMQBiYQ3mTaEROlSkUk
 4+TWa6UgQ1EfJIA6TqjsT4iU+9aFxv/eyL7O/reu6WlwFSV4xLhy2vJhqCxTQ9QcB/Og
 l4ijePlrjr+PZ+fPU55K1tVa4Tl1esRgrsa8Ej6TDybpA8MN3nHg1huIP7/HLAUr5u2v
 5A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780585628; x=1781190428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fpro9ICUs6RXBVxDiRI3uM+xnLXPpa5u3Hlw5ScHuCs=;
 b=DmDoDNI5UVKm+t7Hpb2rk3+E6AhMd6fSJCyzqJBuKM3CwYsDDj3OtwZ9EuteMCsMJY
 Y3jLK6/M81P0zdB8REeK6fnUN1+ckyo8od083jTgEmyJ7+qqcOmNkdefHEoQsjp25fcG
 mYRGFiEFfOYs4+1dkrh9ZiQP/GTr/eFwdXhKaTTLNcCw4uUf84xAejFl2WQACEJqbmpW
 TVBdAKxC7owJ2ZpgZHCapw4ddaJfcmN+lCG6vioZ1/H5MoqERCjVm7lCYmvK3uDQZTT0
 TbYdUK/siUMH0Vyzr6LvsQLAQlpUomdJ3tDg9Rs4O7lgIbAsghrJUUcgzXYAMd1H88pE
 fHPQ==
X-Gm-Message-State: AOJu0YxUaRTtsAApAruTDqmidclnusDtb+yqV/nSLj3ADnen0OIc35U/
 8yAM4JpvUqGpbF8V7qXKPrS2MwPvbOUMTr5TzDYFPCjGgXOnAbK1Jt/0OEfEbiSwdw==
X-Gm-Gg: Acq92OF5eIvDxECR61qZySOgCzDmMWncx22SMjX/if5LicTqF/uR31g5JriihKKYsHQ
 KN0EC3bhOcDOJqVPEpuJPJhjiMsmlyRT/f2+1aFUCTmWVX6/hyDsB+H8Vixy5XXiUAX14B1QjjB
 v2m4i5a6GkYg1lZdPUqi3sMbZqFOlbFicfO2eoeaYAznoVan1p5r31DuQ/fIKAu75wu4hkj5d4y
 0IAZA+CTcPuMMOQClcQ6SIWhqnTfgeDFqAbrsSaoHMEOrT/Qh4eDfV1lUUwrHgqCbT9cFaLN/vQ
 ixjqS/Pj26TNqcOw13l8kEFLqcoF1ZC4UEoKRHWgnghKudIYTbLk6LKgxlGheN15rvqcKwqrd+o
 rqD2ubEd+ZLYzvvWnsIu0EynskvI0aO+trTCSB9oj7ODP4YI5zihLlJJSP0820tTx0FpvH9Awmn
 kWVTM6PabM8ExiQFzul93gvKqoSd7Ipiqi+KTsYbvMmpf2Uj+o4aSthimdtLTNddq9dA==
X-Received: by 2002:a17:90a:dfcc:b0:36e:2106:ded8 with SMTP id
 98e67ed59e1d1-36e34770ccdmr9170496a91.25.1780585628387; 
 Thu, 04 Jun 2026 08:07:08 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a29cd6sm3352666a91.11.2026.06.04.08.07.07
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:07:08 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Fri,  5 Jun 2026 00:06:41 +0900
Message-ID: <20260604150643.3433-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fstat02: Verify st_ino field
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

fstat01 does not currently verify the st_ino field.

Add a check to verify that fstat() reports the expected inode number,
improving coverage of the metadata returned by fstat().

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/fstat/fstat02.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index 68cbe82f0..e7175cfac 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -19,6 +19,7 @@
 #define NLINK	        2

 static struct stat stat_buf;
+static struct stat link_stat_buf;
 static uid_t user_id;
 static gid_t group_id;
 static int fildes;
@@ -31,6 +32,7 @@ static void run(void)
 	TST_EXP_EQ_LI(stat_buf.st_size, FILE_SIZE);
 	TST_EXP_EQ_LU(stat_buf.st_mode & 0777, FILE_MODE);
 	TST_EXP_EQ_LU(stat_buf.st_nlink, NLINK);
+	TST_EXP_EQ_LU(stat_buf.st_ino, link_stat_buf.st_ino);
 }

 static void setup(void)
@@ -46,6 +48,8 @@ static void setup(void)
 		tst_brk(TBROK, "Could not fill test file");

 	SAFE_LINK(TESTFILE, LINK_TESTFILE);
+
+	SAFE_STAT(LINK_TESTFILE, &link_stat_buf);
 }

 static void cleanup(void)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
