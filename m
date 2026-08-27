Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933D4C61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:54:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00CB23C210D
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:54:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD2643C210D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A0206008E6
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:54:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5155E21C43;
 Thu, 27 Aug 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+533WkCvem/Ecey10uH296joLIaCV6yFpBxg/r3RxTc=;
 b=xHbbadDbht7bqLMC0Huqxp3LQ2Vgfp2M0g6QiJU6gW45j2p19yH77NsXtKA7jIg5SzuiQY
 QWr0TdN3eSNyoAKMhaukzxDPVJoQpDK9s0wFsS+6C5uD5Rf3LV18so54thfKZe4snrwgr+
 zYS2zeFlbKYZQWbwLWJBL5EH+Zmfh5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+533WkCvem/Ecey10uH296joLIaCV6yFpBxg/r3RxTc=;
 b=qyNMzqLOLzq3YKXqq62m1vqXoW9fL6tMspQrvYpR8cfaMTthQJuztMGXFqI5guukB4Q6sp
 XO/E6RobF3pQD5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787831651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+533WkCvem/Ecey10uH296joLIaCV6yFpBxg/r3RxTc=;
 b=Jlb2WjPp334DbVmpasDhCJJdaOcHaAJLiREDyySx4+dK5GB3XO4PJzs1m7kKZy0bzxbNsm
 Hu+a9NBWz6AOhYFjgo68KhunbsW6M9lPFn/BYMkC8NCdbYl1IwUGNQ+NR5/MTGmgJjAzMz
 PJNF4sDzbw/aEhXzvzdM1W6/H9pPuJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787831651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+533WkCvem/Ecey10uH296joLIaCV6yFpBxg/r3RxTc=;
 b=wSw9B7XlT2c0LhkNbDFuNXm9Ih4wKhfSQyS74K5kf2yY0iFkf1vhty0c3SKbyox/om4GlQ
 gt8JXr7dyn7vy/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3268B13682;
 Thu, 27 Aug 2026 11:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aH3JCmMlkGq6DAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 11:54:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 13:54:06 +0200
MIME-Version: 1.0
Message-Id: <20260827-swapon_discard_coverage-v1-3-633bcb11c181@suse.com>
References: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
In-Reply-To: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787831650; l=3168;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=97mQM39sr7Lkmg/1e01pwmr1X/vpYQzWCS17LtmF8ZM=;
 b=IIt//DIMRkHDca3WmQMxfJp9Lgbke2wymNqsk/C3W5JrP3pSXVOo44dqW2Pp1Oq8knyp62W8s
 gU9I1ulGVWTAGMwQJ0ZHWCV8a2cGMjNaPf0iYS2Mfd37pBoNZHT/yCO
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] swapon02: Add test cases for invalid swapflags
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add test cases verifying that swapon(2) returns EINVAL when swapflags
contains undefined or invalid flag bits.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/swapon/swapon02.c | 58 +++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index d3e528c94..9d30f8527 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -5,10 +5,11 @@
  */
 
 /*\
- * This test case checks whether swapon(2) system call returns:
+ * This test case checks whether :manpage:`swapon(2)` system call returns:
  *
  * - ENOENT when the path does not exist
  * - EINVAL when the path exists but is invalid
+ * - EINVAL when swapflags contains invalid or undefined flag bits
  * - EPERM when user is not a superuser
  * - EBUSY when the specified path is already being used as a swap area
  */
@@ -20,10 +21,10 @@
 #include "tse_swap.h"
 
 #define MNTPOINT	"mntpoint"
-#define TEST_FILE	MNTPOINT"/testswap"
-#define NOTSWAP_FILE	MNTPOINT"/notswap"
-#define SWAP_FILE	MNTPOINT"/swapfile"
-#define USED_FILE	MNTPOINT"/alreadyused"
+#define TEST_FILE	MNTPOINT "/testswap"
+#define NOTSWAP_FILE	MNTPOINT "/notswap"
+#define SWAP_FILE	MNTPOINT "/swapfile"
+#define USED_FILE	MNTPOINT "/alreadyused"
 
 static uid_t nobody_uid;
 static int do_swapoff;
@@ -32,11 +33,40 @@ static struct tcase {
 	char *err_desc;
 	int exp_errno;
 	char *path;
+	int flags;
 } tcases[] = {
-	{"Path does not exist", ENOENT, "./doesnotexist"},
-	{"Invalid path", EINVAL, NOTSWAP_FILE},
-	{"Permission denied", EPERM, SWAP_FILE},
-	{"File already used", EBUSY, USED_FILE},
+	{
+		.err_desc = "Path does not exist",
+		.exp_errno = ENOENT,
+		.path = "./doesnotexist",
+	},
+	{
+		.err_desc = "Invalid path",
+		.exp_errno = EINVAL,
+		.path = NOTSWAP_FILE,
+	},
+	{
+		.err_desc = "Permission denied",
+		.exp_errno = EPERM,
+		.path = SWAP_FILE,
+	},
+	{
+		.err_desc = "File already used",
+		.exp_errno = EBUSY,
+		.path = USED_FILE,
+	},
+	{
+		.err_desc = "Invalid swapflags (undefined flag bits)",
+		.exp_errno = EINVAL,
+		.path = SWAP_FILE,
+		.flags = 0x80000,
+	},
+	{
+		.err_desc = "Invalid swapflags (high bits set)",
+		.exp_errno = EINVAL,
+		.path = SWAP_FILE,
+		.flags = ~0,
+	},
 };
 
 static void setup(void)
@@ -66,20 +96,16 @@ static void cleanup(void)
 
 static void verify_swapon(unsigned int i)
 {
-	struct tcase *tc = tcases + i;
+	struct tcase *tc = &tcases[i];
+
 	if (tc->exp_errno == EPERM)
 		SAFE_SETEUID(nobody_uid);
 
-	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, 0), tc->exp_errno,
+	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, tc->flags), tc->exp_errno,
 		     "swapon(2) fail with %s", tc->err_desc);
 
 	if (tc->exp_errno == EPERM)
 		SAFE_SETEUID(0);
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "swapon(2) failed unexpectedly, expected: %s",
-			tst_strerrno(tc->exp_errno));
-	}
 }
 
 static struct tst_test test = {

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
