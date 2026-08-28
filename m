Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EA3C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:11:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07B2D3E2FC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:11:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 662813DFABE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:11:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5E76200B09
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:11:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1F821FE39;
 Fri, 28 Aug 2026 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787915460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVGNAffLzrhVTegdICzkzD+pgr1W8clOUCXS61L+Wyg=;
 b=0dCjxeLshug5AHQhmYKTM6McqNzw/oGXbAeyD7oYsIIp75mZKaOQPn8l4+DSfqcW2d/jyo
 Ba+alWPPs3hs76sX9lz8JQIlia9YwxbDArO86SZgNJ0FSH6StmD5Bl0Kb81n7o+JurJXOb
 4AuDA5SRAVJzhCb0dAkWghTItD/UDc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787915460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVGNAffLzrhVTegdICzkzD+pgr1W8clOUCXS61L+Wyg=;
 b=5fMTFpozcXSbcxAx4mi2kiOhn9Dk41F5oJ9Ctdp41/fimXDq77M4ym/ZDwcYB3L6IlvnMa
 4ndVfGOciw+vTbAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wozczJRH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z7HzPdFz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787915456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVGNAffLzrhVTegdICzkzD+pgr1W8clOUCXS61L+Wyg=;
 b=wozczJRHVcYZF77s8vl1brxQv3vZ++OBA8Gen8XrY+tTYIzrorzNwDzC/DT5uJ8vlXd2J2
 glTAGAZGP/1/G+jQGXWVfcLnykoiV2oD5CDbro7ngB7SktAboYXjKHefR7lBs8+1EaBq+y
 DAcPTXVIU2b1kv7f/qtsJqKwlYjVpKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787915456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVGNAffLzrhVTegdICzkzD+pgr1W8clOUCXS61L+Wyg=;
 b=Z7HzPdFzmpVa8E7/TAhM6eXM2dNs2/0/MwZxHu8dIU9bBjhI3bgMIHCnK/TiKk5kyGxQCh
 HZpLPG6mw62J6LDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39E0C13686;
 Fri, 28 Aug 2026 11:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mIilDMBskWriYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 11:10:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 13:10:54 +0200
MIME-Version: 1.0
Message-Id: <20260828-swapon_discard_coverage-v3-3-136924a1a730@suse.com>
References: <20260828-swapon_discard_coverage-v3-0-136924a1a730@suse.com>
In-Reply-To: <20260828-swapon_discard_coverage-v3-0-136924a1a730@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787915455; l=3413;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Yz9iiH0qrSFmVkXb4m2hlOLLhYBb+3yFhoaJwgkouDw=;
 b=2096lbrKsAerORK8+1Mqh5RGxB5l2gTBn0NKlh55rPnGk5SLa8zbJ7SCr/5Q+Li9qg9tU0z3S
 exqo3b31mzNCFbvDvxanHKqR2v0XA4Il683IP1iZWyblA+PLhmSXZYm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A1F821FE39
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] swapon02: Add test cases for invalid swapflags
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
 testcases/kernel/syscalls/swapon/swapon02.c | 60 +++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index d3e528c94..fcf68acfa 100644
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
@@ -66,20 +96,20 @@ static void cleanup(void)
 
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
+	/* If swapon() unexpectedly succeeded, undo it for the next iteration */
+	if (TST_RET == 0 && tst_syscall(__NR_swapoff, tc->path) != 0)
+		tst_res(TWARN | TTERRNO, "swapoff(%s) failed", tc->path);
 }
 
 static struct tst_test test = {

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
