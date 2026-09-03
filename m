Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFA3C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:04:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 807453EAD93
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:04:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B9D43EAD42
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:04:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BCC686012DC
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:04:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D70B21DE1;
 Thu,  3 Sep 2026 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kmX92ArHn8qaxGaBqCXLpfk+1HYCBlOcCvDCm6lj6k=;
 b=ghBY0uAw0sc4GdIWKqXKV7vcFvnQ2F9vug9mSO5VI8Ye9g/awGwULduSdyMtNS8zLpu0jD
 zPhVs/NBzq8MxTDDsxy8AHZf/tJ16Kt3z5Mu6hXeZtiMI3km3eyAJbOziEhjdUKflyymOb
 op8Qq9a+GCw9EkKj83BpOyYviSrU03o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kmX92ArHn8qaxGaBqCXLpfk+1HYCBlOcCvDCm6lj6k=;
 b=V2AZZYT7EkGwR5jeSxShOy8XwwlZ0up0NJPejvYYm2DUpy4Bv9GUmhu0k+vZhWocy1QjJs
 e4jNGkbe4ofhTxCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xiJSXLEy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=czMPRxWW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kmX92ArHn8qaxGaBqCXLpfk+1HYCBlOcCvDCm6lj6k=;
 b=xiJSXLEyfe5+jZT0v4vFQDO4Wwg36nSTaGT1ApMt534EXWGqrFjdpbzmceR8/JnWZ/o3JL
 ShhXs5c/w73B/zf8Czld7L5Qpo9QMMgx4apP43sXqD+qWRXihG4nyIKui1vJRNkXDEo8GB
 DIrOpCA1XCCyshCXzu6l74JPpl9m3Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kmX92ArHn8qaxGaBqCXLpfk+1HYCBlOcCvDCm6lj6k=;
 b=czMPRxWWje7z4qUAC4fGp2CyhyX/P3H+FG0PDUVc0p6E1ZKZV2tw5PnEhv67xfCrtnMBfp
 vSWx/5i8xljFVsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 133E413869;
 Thu,  3 Sep 2026 13:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OO3EAU1wmWojPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 13:04:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 15:04:13 +0200
MIME-Version: 1.0
Message-Id: <20260903-swapon_discard_coverage-v4-3-2a9f721ad954@suse.com>
References: <20260903-swapon_discard_coverage-v4-0-2a9f721ad954@suse.com>
In-Reply-To: <20260903-swapon_discard_coverage-v4-0-2a9f721ad954@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788440652; l=3336;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=zrAzB2QM805D+0P/JWUnre93oHnqw/UPckdQUV7ZSUw=;
 b=/qrLv604ww4qaKtULyTZX6RXP9DwjylHFB2BDDIHImLhyYQZF5tqBe/mHYPPlTpKYCdkOBXct
 5Kr0WiW6BMYB31Th6YEaZO9oEgRAhau9Mg3uXQVWEnInmXgjaY6RRRq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 7D70B21DE1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] swapon02: Add test cases for invalid swapflags
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

Reviewed-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/swapon/swapon02.c | 59 +++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index d3e528c94..7319e8c03 100644
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
@@ -66,20 +96,19 @@ static void cleanup(void)
 
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
 
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "swapon(2) failed unexpectedly, expected: %s",
-			tst_strerrno(tc->exp_errno));
-	}
+	if (TST_RET == 0 && tst_syscall(__NR_swapoff, tc->path) != 0)
+		tst_res(TWARN | TERRNO, "swapoff(%s) failed", tc->path);
 }
 
 static struct tst_test test = {

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
