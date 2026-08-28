Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE48CC61DC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 418913E2F0F
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:05:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33AB33DEBF8
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:05:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D055600B23
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:05:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C8FE1F88E;
 Fri, 28 Aug 2026 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787907909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK9nmNuZ9r2eOZtrJNL400BmWYUymfin5OfwVXCdR8A=;
 b=qdVxTi+FL7+h1ryGzOxqXpK+RnaHE//xBl+h7+7xWDfdEwqtnl7JHIwCt7ytuJWnJY270H
 ihknIe+SX3JVtsolwvRBa3BPWWemItft8+OLR7vYeQXzg6ga2K7iN8goC5xzwUu+hKbCGd
 kAHQzCkg/rz/jewD12C3qsemax1CplU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787907909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK9nmNuZ9r2eOZtrJNL400BmWYUymfin5OfwVXCdR8A=;
 b=K1iwlg6FbWxvBAyV8nFVsWvWNthr2iKul+cteaHFBHL3vSRfcti6F+2DaePfqco88YGwKP
 DmJFVzrKNu2ap6Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u9YD2DQe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UnJCFjhk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787907905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK9nmNuZ9r2eOZtrJNL400BmWYUymfin5OfwVXCdR8A=;
 b=u9YD2DQedV33oc8YlGrnDWJ5XEoPF/sHtlG1Gx4TG3ypXadh8SLDvWXlczZPVqx0gGOqtb
 N5P++VEsWwf7buheSuMZuUOx5agD3kIFaEuYC+9WUVfmTiKh6Zy+gBlJ3asRXWIlCZSeD3
 GYeU4x3XRSud7WQjPlZ60/L09saqj6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787907905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK9nmNuZ9r2eOZtrJNL400BmWYUymfin5OfwVXCdR8A=;
 b=UnJCFjhkQVFq42xZKLJvqQOjKLMHFYx9ugG5Ooey/JvrxAtYG9/9clGUUkrp72+3rk1vH4
 eTGGh37dx0B5JNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EFA413686;
 Fri, 28 Aug 2026 09:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mBYAAUFPkWrVYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 09:05:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 11:05:05 +0200
MIME-Version: 1.0
Message-Id: <20260828-swapon_discard_coverage-v2-3-e55a86dad729@suse.com>
References: <20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com>
In-Reply-To: <20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787907904; l=3210;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=/aKJ7hWdrwZKc5aZIQsfnJ+DxU9IyrPXzuhwX7eSSdU=;
 b=JrEDnZS5w3xp1Ebv6VNFmaJtS8eExEunI3Ogm6QD9+I1K5bKrc8n3T/8nNj7OVT82VEEx5RZ/
 TjSziLgLczCDOOHFU4bL0BXyxoB2OdtRpfjajENNtiagNvU90VAIjzr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6C8FE1F88E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] swapon02: Add test cases for invalid swapflags
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
