Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220C2C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 11:55:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F05753CF666
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 12:54:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAED43CD94C
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A87010007C1
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 12:54:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4AA1FCEC;
 Wed, 29 Nov 2023 11:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701258885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilvRiwLKxLGEhHIEgVMTtH0wcayN/uMJVaE1WyhiCHo=;
 b=mVDwS20aAmGQ/W0BOJOFjWlVfj6sQeaTW83YLVbMpRAZfjxRpr6qJAdAsVmgfMst5r7EG4
 EJgjmpyYTyGdSLU7YHNROFJU8CYtyNpo2LbkrlQkEvAPOoFuzJoj/sgXfsBiIpDHX3MIJq
 GRby2U96aZoPidUW92I10mqG1Mgpl+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701258885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilvRiwLKxLGEhHIEgVMTtH0wcayN/uMJVaE1WyhiCHo=;
 b=NiBlVI8yRL+nm57IdwWxISIUe67zFiekDBWJPHD8Qo+ZZHazBfnyZvX2L17Ljy/DTgS+dd
 7q7k/rh6IVO8iwBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F7181376F;
 Wed, 29 Nov 2023 11:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 00hkE4UmZ2VefwAAn2gu4w
 (envelope-from <jack@suse.cz>); Wed, 29 Nov 2023 11:54:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id B56FEA07EA; Wed, 29 Nov 2023 12:54:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Nov 2023 12:54:33 +0100
Message-Id: <20231129115440.19100-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231129114617.12660-1-jack@suse.cz>
References: <20231129114617.12660-1-jack@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLY(-4.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_CC(0.00)[gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] fanotify: Convert remaining init_flags tests to
 be performed on target fs
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Convert remaining tests using
REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL to be performed on
target filesystem using REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS and
remove the now unused macro and functions.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 9 ---------
 testcases/kernel/syscalls/fanotify/fanotify20.c | 3 ++-
 testcases/kernel/syscalls/fanotify/fanotify21.c | 3 ++-
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index e02ea8c24dcb..052b29a7cedc 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -198,11 +198,6 @@ static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const
 	return fanotify_flags_supported_on_fs(flags, FAN_MARK_INODE, FAN_ACCESS, fname);
 }
 
-static inline int fanotify_init_flags_supported_by_kernel(unsigned int flags)
-{
-	return fanotify_init_flags_supported_on_fs(flags, NULL);
-}
-
 static inline int fanotify_mark_supported_on_fs(uint64_t flag, const char *fname)
 {
 	return fanotify_flags_supported_on_fs(FAN_CLASS_CONTENT, flag, FAN_ACCESS, fname);
@@ -277,10 +272,6 @@ static inline void fanotify_flags_err_msg(const char *flags_str,
 	fanotify_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
 		fanotify_init_flags_supported_on_fs(flags, fname))
 
-#define REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(flags) \
-	fanotify_flags_err_msg(#flags, __FILE__, __LINE__, tst_brk_, \
-		fanotify_init_flags_supported_by_kernel(flags))
-
 static inline int fanotify_handle_supported_by_kernel(int flag)
 {
 	/*
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 71310fb86e9e..1d249ac9cfcc 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -50,7 +50,8 @@ static void do_setup(void)
 	 * An explicit check for FAN_REPORT_PIDFD is performed early on in the
 	 * test initialization as it's a prerequisite for all test cases.
 	 */
-	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(FAN_REPORT_PIDFD);
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
+						    MOUNT_PATH);
 }
 
 static void do_test(unsigned int i)
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 8a1028086237..d54930f05161 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -119,7 +119,8 @@ static void do_setup(void)
 	 * on in the test initialization as it's a prerequisite for
 	 * all test cases.
 	 */
-	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL(FAN_REPORT_PIDFD);
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
+						    TEST_FILE);
 
 	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDONLY);
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
