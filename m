Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86876EB64DA
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 07:58:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FAD13CB80D
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 09:58:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E9DC3CB4BD
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 06:41:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 433A91A006BB
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 06:41:36 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B73E060C56;
 Mon,  5 Jun 2023 04:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE9C4339B;
 Mon,  5 Jun 2023 04:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685940094;
 bh=LEpVpPKWYJm4F/1zu3FBl+m4etzbcVjCV4qKtbsx1KM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l/VJM5thT7aE9nfnCFdUO7ajlZEckDkRjrSqVrawowVvGbj5UxlCOItaEaUgzgDOd
 WN2FffiLKhJS02ZPlzAofPloFtkevQRrihEZ0L9y5l7RnOkT4nCpJQcAqwmZek5Uw7
 0WKTTA82gnValy3cGVo5PndTttG67SSCAumzIWfguXOdKXIg8Ive5V8JAembx6pLGW
 ygxxbG5uPeQgS0qLy+XmpQuS6ss7Duv8J+axbWTKDye067NLnDFoYMNNJIcMhCHHYB
 tnnzQodQhOExa4os5Gco25VEi/JVYaRTA16V2pt9gY9K2R0XaSTGzM3ljnzT33Cm/H
 Lvk6h8NVu9o9w==
From: Damien Le Moal <dlemoal@kernel.org>
To: ltp <ltp@lists.linux.it>,
	Linus Walleij <linus.walleij@linaro.org>
Date: Mon,  5 Jun 2023 13:41:31 +0900
Message-Id: <20230605044131.798383-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605044131.798383-1-dlemoal@kernel.org>
References: <20230605044131.798383-1-dlemoal@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 19 Jun 2023 09:58:05 +0200
Subject: [LTP] [PATCH 2/2] ioprio: Use IOPRIO_PRIO_NUM to check prio range
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
