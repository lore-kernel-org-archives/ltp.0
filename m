Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7B3C7EE23
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 00:53:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC6ED3CE6C2
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 02:53:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8833CC9C8
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 02:53:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2492A600BCB
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 02:53:20 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D3F7C64331;
 Thu,  8 Jun 2023 00:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B75C4339B;
 Thu,  8 Jun 2023 00:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686185598;
 bh=ckZUQJ4k9bHV93Lbybprr2a1+wwU3UqcaDZ1z0K/q4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gSps5DnJ5zmCNOhTCkm93Jwg4xz2cCLGmh896eafl10pjyiVpNVbLaHZ5nCjuuo38
 Ro55QSx8LFELY90ffn9NciF2wPHNbNHOCb7wHXx0roAoPbt9h5e4TCjLUsPhLBMRcA
 3mWdYaarRT0MDVpTvxAvNbJQkmdmnoaJJJg2TdDU6NxLvjtdM0xEHioX/iZZiTsZu6
 5XtErj1Mqd8IDfZS2Zv2RPr0gtJEwrWYXilWQhDbfafT1myZ9l4wkfdrVQiPlPgEt8
 XwwksKlwLMjeoXmFLaBLEB1szh4Fe3bLME279C3Urg5r+XEJ3dfw3Z3fE22dM66Ehm
 e4dH3yCLXxLzQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: ltp <ltp@lists.linux.it>,
	Linus Walleij <linus.walleij@linaro.org>
Date: Thu,  8 Jun 2023 09:53:15 +0900
Message-Id: <20230608005315.3703446-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608005315.3703446-1-dlemoal@kernel.org>
References: <20230608005315.3703446-1-dlemoal@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] ioprio: Use IOPRIO_PRIO_NUM to check prio range
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use the macro IOPRIO_PRIO_NUM in prio_in_range() to check the upper
bound of the valid range for priority levels. Similarly, in the test
case ioprio_set03, use this macro to check for failures when the user
attempts using a priority level out of range.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 testcases/kernel/syscalls/ioprio/ioprio.h       | 4 ++--
 testcases/kernel/syscalls/ioprio/ioprio_set03.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ioprio/ioprio.h b/testcases/kernel/syscalls/ioprio/ioprio.h
index 6ca134a54..c2115bf20 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio.h
+++ b/testcases/kernel/syscalls/ioprio/ioprio.h
@@ -61,10 +61,10 @@ static inline int sys_ioprio_set(int which, int who, int ioprio)
 	return tst_syscall(__NR_ioprio_set, which, who, ioprio);
 }
 
-/* Priority range from 0 (highest) to 7 (lowest) */
+/* Priority range from 0 (highest) to IOPRIO_PRIO_NUM (lowest) */
 static inline int prio_in_range(int prio)
 {
-	if ((prio < 0) || (prio > 7))
+	if ((prio < 0) || (prio >= IOPRIO_PRIO_NUM))
 		return 0;
 	return 1;
 }
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set03.c b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
index b2c962a6f..d6b44df85 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set03.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
@@ -27,7 +27,7 @@ static void run(void)
 	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0,
 		       IOPRIO_PRIO_VALUE(class, 4));
 	TEST(sys_ioprio_set(IOPRIO_WHO_PROCESS, 0,
-			    IOPRIO_PRIO_VALUE(class, 8)));
+			    IOPRIO_PRIO_VALUE(class, IOPRIO_PRIO_NUM)));
 	if (TST_RET == -1) {
 		ioprio_check_setting(class, 4, 1);
 		if (errno == EINVAL)
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
