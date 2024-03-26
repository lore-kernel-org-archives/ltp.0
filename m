Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F29C6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:42:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 573A03D0E35
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:42:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94A683CC7D4
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 134C4601405
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:49 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 528125D719;
 Tue, 26 Mar 2024 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0Wn+z+hlmWBOPGNJl+VpbMNXO9YTHqCbIXZkufmuU0=;
 b=IWS93nb0pkNvEaTOn/0dNhGxP9mFX0doE5e4DT5Pfkq/BrPqsZr4GGyaPgnKNG+iHrtkXd
 0PAASiaVIyK62KBgYsKlOQ37KMIwqRnVbg9YiZK1G/mpZ8g5wEP+HvPH2DWP/h+cQi8ccm
 V5T5djTdMUBLKfc15yTSKMnabJ2LW+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0Wn+z+hlmWBOPGNJl+VpbMNXO9YTHqCbIXZkufmuU0=;
 b=YQXNKmm61uZ68zcKaGdCU7Y2M0gfshmzbMwxiC3LCAuaXnMR5N9MviIAjcKKx7irFYFKGx
 JIpa64a4z/7ceKDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0Wn+z+hlmWBOPGNJl+VpbMNXO9YTHqCbIXZkufmuU0=;
 b=IWS93nb0pkNvEaTOn/0dNhGxP9mFX0doE5e4DT5Pfkq/BrPqsZr4GGyaPgnKNG+iHrtkXd
 0PAASiaVIyK62KBgYsKlOQ37KMIwqRnVbg9YiZK1G/mpZ8g5wEP+HvPH2DWP/h+cQi8ccm
 V5T5djTdMUBLKfc15yTSKMnabJ2LW+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0Wn+z+hlmWBOPGNJl+VpbMNXO9YTHqCbIXZkufmuU0=;
 b=YQXNKmm61uZ68zcKaGdCU7Y2M0gfshmzbMwxiC3LCAuaXnMR5N9MviIAjcKKx7irFYFKGx
 JIpa64a4z/7ceKDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F37A13AF2;
 Tue, 26 Mar 2024 14:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id YNxtCq3eAmYTTAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 14:41:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 15:41:45 +0100
Message-ID: <20240326144145.747735-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326144145.747735-1-pvorel@suse.cz>
References: <20240326144145.747735-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IWS93nb0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YQXNKmm6
X-Spamd-Result: default: False [1.23 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-2.26)[96.50%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[linux.ibm.com,gmail.com,suse.cz];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 528125D719
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Mete Durlu <meted@linux.ibm.com>

When SElinux is in enforcing state and SEpolicies disallow anonymous
pipe usage with fanotify_mark(), related fanotify14 testcases fail with
EACCES instead of EINVAL. Accept both errnos when SElinux is in
enforcing state to correctly evaluate test results.

Replace TST_EXP_FD_OR_FAIL with TST_EXP_FAIL when testing
fanotify_mark() as it returns -1 on failure and 0 on success not a file
descriptor.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Co-developed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify14.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index d02d81495..ee583a095 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -47,6 +47,7 @@ static int pipes[2] = {-1, -1};
 static int fanotify_fd;
 static int ignore_mark_unsupported;
 static int filesystem_mark_unsupported;
+static int se_enforcing;
 static unsigned int supported_init_flags;
 
 struct test_case_flags_t {
@@ -274,6 +275,7 @@ static void do_test(unsigned int number)
 
 	/* Set mark on non-dir only when expecting error ENOTDIR */
 	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
+	const int exp_errs[] = {tc->expected_errno, EACCES};
 	int dirfd = AT_FDCWD;
 
 	if (tc->pfd) {
@@ -283,9 +285,9 @@ static void do_test(unsigned int number)
 
 	tst_res(TINFO, "Testing %s with %s",
 		tc->mark.desc, tc->mask.desc);
-	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
-					 tc->mask.flags, dirfd, path),
-					 tc->expected_errno);
+
+	TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+			 tc->mask.flags, dirfd, path), exp_errs, se_enforcing ? 2 : 1);
 
 	/*
 	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
@@ -334,6 +336,8 @@ static void do_setup(void)
 	SAFE_FILE_PRINTF(FILE1, "0");
 	/* Create anonymous pipes to place marks on */
 	SAFE_PIPE2(pipes, O_CLOEXEC);
+
+	se_enforcing = tst_selinux_enforcing();
 }
 
 static void do_cleanup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
