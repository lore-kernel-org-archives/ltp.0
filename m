Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5F4C54E67
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 10:23:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ADC43CEC1E
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 11:23:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82ECE3CE64F
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:55 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 15E091A010E2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4821520C97;
 Wed, 20 Mar 2024 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbGrt+gUX+nW/HNo9QwcRk8hQB9H/FwU/nYUCuan0Zo=;
 b=SuPTOGXG1gA9vN6IIYT5xi12UiO32Svqj4vl9Xs5erKNsYDEiwOS+JVFqUeg28H/SxqO8v
 toslUIfdAKOqc9vD1RpqpdgD3HdDAOWaAeJzAL6zS0OeU4NNAdc09EyXDstC983wRG09Tf
 WVT0X2ju7jLdHiUF9UAJQe3K9eKK+Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbGrt+gUX+nW/HNo9QwcRk8hQB9H/FwU/nYUCuan0Zo=;
 b=o/xWv4/d0p3OnKfcjdU8cIHvTDNOETkScaUPf5qM67pa3TfzajnVRlzdi+oc1kCaYKXN5G
 SNcxfSIgRxxmcVCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbGrt+gUX+nW/HNo9QwcRk8hQB9H/FwU/nYUCuan0Zo=;
 b=SuPTOGXG1gA9vN6IIYT5xi12UiO32Svqj4vl9Xs5erKNsYDEiwOS+JVFqUeg28H/SxqO8v
 toslUIfdAKOqc9vD1RpqpdgD3HdDAOWaAeJzAL6zS0OeU4NNAdc09EyXDstC983wRG09Tf
 WVT0X2ju7jLdHiUF9UAJQe3K9eKK+Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbGrt+gUX+nW/HNo9QwcRk8hQB9H/FwU/nYUCuan0Zo=;
 b=o/xWv4/d0p3OnKfcjdU8cIHvTDNOETkScaUPf5qM67pa3TfzajnVRlzdi+oc1kCaYKXN5G
 SNcxfSIgRxxmcVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 178F813942;
 Wed, 20 Mar 2024 10:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0LEfBP64+mWyaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 10:22:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 11:22:04 +0100
Message-ID: <20240320102204.475230-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240320102204.475230-1-pvorel@suse.cz>
References: <20240320102204.475230-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SuPTOGXG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="o/xWv4/d"
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.82 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-2.67)[98.56%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[linux.ibm.com,suse.cz,redhat.com,gmail.com];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4821520C97
Subject: [LTP] [PATCH v2 3/3] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, Mete Durlu <meted@linux.ibm.com>
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
changes v1->v2:
* Do not include library header in fanotify14 (not needed)

 .../kernel/syscalls/fanotify/fanotify14.c      | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index d02d81495..82725f317 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -47,6 +47,7 @@ static int pipes[2] = {-1, -1};
 static int fanotify_fd;
 static int ignore_mark_unsupported;
 static int filesystem_mark_unsupported;
+static int se_enforcing;
 static unsigned int supported_init_flags;
 
 struct test_case_flags_t {
@@ -283,9 +284,18 @@ static void do_test(unsigned int number)
 
 	tst_res(TINFO, "Testing %s with %s",
 		tc->mark.desc, tc->mask.desc);
-	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
-					 tc->mask.flags, dirfd, path),
-					 tc->expected_errno);
+
+	if (tc->pfd && se_enforcing) {
+		const int exp_errs[] = {tc->expected_errno, EACCES};
+
+		TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+				 tc->mask.flags, dirfd, path),
+				 exp_errs);
+	} else {
+		TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+						 tc->mask.flags, dirfd, path),
+						 tc->expected_errno);
+	}
 
 	/*
 	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
@@ -334,6 +344,8 @@ static void do_setup(void)
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
