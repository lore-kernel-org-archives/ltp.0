Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A54C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:50:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F0DD3CAEE9
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 17:50:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A5203CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 17:49:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C467A600F29
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 17:49:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA31C21E0E;
 Thu, 13 Oct 2022 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665676176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrKY1gtH2bzX2NBAx2Q8D3KRx3PPRYMcQE9dVpRumF8=;
 b=iUm5zQf4Yvp4p8+zWJD1dFCUihiLjhAsdLU1D5Jj6OnHpc5d2wV9pOl4EUOu3f1lgVkg6K
 Ugr87n3LyIjFxKE4Fru/DHoYAGWB+pBALe/+fLmqGafTEopEYAxXgvLvhEeXN1pCHMetGO
 PbF6kG8uRrWLXqTEqSf0dJsW2GRFD10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665676176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrKY1gtH2bzX2NBAx2Q8D3KRx3PPRYMcQE9dVpRumF8=;
 b=aXatOsy0Et8DJedbF/h4qkp8fEzGWbnnyadOIh06T529NCJjOY4WiyjNtCO8J16aqzvCcT
 P12pep2ZJC93sUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 921B913AAA;
 Thu, 13 Oct 2022 15:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sOBlIpAzSGMnDQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 13 Oct 2022 15:49:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: amir73il@gmail.com,
	ltp@lists.linux.it
Date: Thu, 13 Oct 2022 17:49:35 +0200
Message-Id: <20221013154935.20461-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221013154935.20461-1-mdoucha@suse.cz>
References: <20221013154935.20461-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] fanotify14: Improve check for unsupported init
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify14.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index ee42aaf68..b98ec4652 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -41,8 +41,8 @@
 #define FLAGS_DESC(flags) (flags), (#flags)
 
 static int fanotify_fd;
-static int fan_report_target_fid_unsupported;
 static int ignore_mark_unsupported;
+static unsigned int supported_init_flags;
 
 /*
  * Each test case has been designed in a manner whereby the values defined
@@ -158,9 +158,8 @@ static void do_test(unsigned int number)
 	tst_res(TINFO, "Test case %d: fanotify_init(%s, O_RDONLY)", number,
 		tc->init_desc);
 
-	if (fan_report_target_fid_unsupported && tc->init_flags & FAN_REPORT_TARGET_FID) {
-		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TARGET_FID,
-					    fan_report_target_fid_unsupported);
+	if (tc->init_flags & ~supported_init_flags) {
+		tst_res(TCONF, "Unsupported init flags");
 		return;
 	}
 
@@ -223,11 +222,14 @@ out:
 
 static void do_setup(void)
 {
+	unsigned int all_init_flags = FAN_REPORT_DFID_NAME_TARGET;
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
