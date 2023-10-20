Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C5CDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 15:08:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B85A13CF534
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 17:08:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3B9A3CD0FD
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:07:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51C0C2000E9
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:07:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A2B71F86B;
 Fri, 20 Oct 2023 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697814470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8GqFitmn/JYCfIMmxFLDkUXTHIxxxTnPg9BKZUzyks=;
 b=26j4qWxu+2oJqShQf4E0OItBxm9IWKUgzoMCwW/T4ih1xctEfDeusRka3RSij/ahZDgomG
 FYvW5efS5f+cD1HkFuss43J7TZkbYe88u/O+nYmwz8YWpkN/VGmMY84idQmlh7RwwYeyBd
 tRO4MMBqAlp10BcyPMlGBClSbygIRW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697814470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8GqFitmn/JYCfIMmxFLDkUXTHIxxxTnPg9BKZUzyks=;
 b=jiM7nPJ9WjI5TOuOtLd/Vd/4+n4DHWFbtCc8KI7mLhd6tp6PnkOSS+kiSCdERR9kOPNQpw
 Fj7ljExQ2tfU1yCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DC0D138E2;
 Fri, 20 Oct 2023 15:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WAISFsaXMmW6WgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 20 Oct 2023 15:07:50 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Date: Fri, 20 Oct 2023 17:06:03 +0200
Message-ID: <20231020150749.21165-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020150749.21165-1-mdoucha@suse.cz>
References: <20231020150749.21165-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.79 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FREEMAIL_TO(0.00)[gmail.com,suse.cz,lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.11)[65.81%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] fanotify14: Improve check for unsupported init
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

Changes since v2: None

I'd rather not squash this patch so that it can be reverted without
potentially breaking other tests.

 testcases/kernel/syscalls/fanotify/fanotify14.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 4596511f0..0bb789188 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -45,8 +45,8 @@
 
 static int pipes[2] = {-1, -1};
 static int fanotify_fd;
-static int fan_report_target_fid_unsupported;
 static int ignore_mark_unsupported;
+static unsigned int supported_init_flags;
 
 struct test_case_flags_t {
 	unsigned long long flags;
@@ -246,9 +246,8 @@ static void do_test(unsigned int number)
 	tst_res(TINFO, "Test case %d: fanotify_init(%s, O_RDONLY)", number,
 		tc->init.desc);
 
-	if (fan_report_target_fid_unsupported && tc->init.flags & FAN_REPORT_TARGET_FID) {
-		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
-					    fan_report_target_fid_unsupported);
+	if (tc->init.flags & ~supported_init_flags) {
+		tst_res(TCONF, "Unsupported init flags");
 		return;
 	}
 
@@ -317,11 +316,15 @@ out:
 
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
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
