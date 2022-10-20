Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F371C43217
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:09:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676313CB1AE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 15:09:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBA883CAFB4
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 123471401174
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 15:08:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FDDF1FEFA;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666271324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kh/CH2C4Yk8mu5OB0NR5brcWTQe5T/3Crs/RwSpwqPM=;
 b=nsQgVldiGiI2tC+UuuBOSIQBkjW1SW5iygCmOlwX92RUPT1Iw3EDTGpdCpiWmTjVpnWzwK
 D4K7ic8dHXNZPI4DNNW91z72YOoj/MTW/L+lEtrt5s/oIJyNeRI14CpfjcpH5CO6R2xSgb
 0sQtApQQ9l38Q+b2ak6LH+3DuBEUqy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666271324;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kh/CH2C4Yk8mu5OB0NR5brcWTQe5T/3Crs/RwSpwqPM=;
 b=iMRY7vL2c6sZOwDA1V5qzforfxca2Slnvnr8vgOJM0rfF1O8K+bYNkVFt7Mym6GQypdz1N
 WVVWZuT33NUiVMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DAA913B72;
 Thu, 20 Oct 2022 13:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MAHuIVxIUWNLOgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 20 Oct 2022 13:08:44 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Thu, 20 Oct 2022 15:08:43 +0200
Message-Id: <20221020130843.15147-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020130843.15147-1-mdoucha@suse.cz>
References: <20221020130843.15147-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] fanotify14: Improve check for unsupported init
 flags
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

Test case 8 of fanotify14 uses init flags supported only on kernel 5.9+
but does not properly check for their support. Rewrite fanotify feature
checks using new helper function.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Added FAN_CLASS_* constants to support check in setup()
- Added longer patch description

I'd rather not squash this patch so that it can be reverted without
potentially breaking other tests.

 testcases/kernel/syscalls/fanotify/fanotify14.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index bfa0349fe..8d7282d43 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -41,8 +41,8 @@
 #define FLAGS_DESC(flags) {(flags), (#flags)}
 
 static int fanotify_fd;
-static int fan_report_target_fid_unsupported;
 static int ignore_mark_unsupported;
+static unsigned int supported_init_flags;
 
 struct test_case_flags_t {
 	unsigned long long flags;
@@ -157,9 +157,8 @@ static void do_test(unsigned int number)
 	tst_res(TINFO, "Test case %d: fanotify_init(%s, O_RDONLY)", number,
 		tc->init.desc);
 
-	if (fan_report_target_fid_unsupported && tc->init.flags & FAN_REPORT_TARGET_FID) {
-		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
-					    fan_report_target_fid_unsupported);
+	if (tc->init.flags & ~supported_init_flags) {
+		tst_res(TCONF, "Unsupported init flags");
 		return;
 	}
 
@@ -222,11 +221,15 @@ out:
 
 static void do_setup(void)
 {
+	unsigned int all_init_flags = FAN_REPORT_DFID_NAME_TARGET |
+		FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | FAN_CLASS_PRE_CONTENT;
+
 	/* Require FAN_REPORT_FID support for all tests to simplify per test case requirements */
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, MNTPOINT);
 
-	fan_report_target_fid_unsupported =
-		fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME_TARGET, MNTPOINT);
+	supported_init_flags = fanotify_get_supported_init_flags(all_init_flags,
+		MNTPOINT);
+
 	ignore_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_IGNORE_SURV);
 
 	/* Create temporary test file to place marks on */
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
