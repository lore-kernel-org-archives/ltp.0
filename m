Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B91CFA0C47
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 08:06:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E82C23E20E4
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 10:06:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB67A3C0E3B
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 10:06:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2038F600A64
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 10:06:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C2816A7DF;
 Wed, 15 Apr 2026 08:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776240387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nc+arbe9x86F+gpf8loQwFenhsS//6ydZrs7EUmzgxY=;
 b=XFXgLzlgY4g6HS5m6MUxCj4IlxKLyTb6X0U0NTI6bz/mrU/IkwRtFZtOpFZX5eOGGcamLC
 neH9G0FVh4jWIvS1/v5no4UuUTRlgTJmEg8iqQrbr9MLZ9R5bjmVqk5WTfQDgvPQ2jn02S
 hclmwUGGXmJC7QuJHzB7hRBz/3pDBRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776240387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nc+arbe9x86F+gpf8loQwFenhsS//6ydZrs7EUmzgxY=;
 b=SRXowny8EoV93VRngoyhPbj2f+YTfnaquB+qL68r6Ba3ilY9qsOnMLfC9zwkI/oOGRKsoY
 wFVBAGkdYP0q06CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XFXgLzlg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SRXowny8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776240387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nc+arbe9x86F+gpf8loQwFenhsS//6ydZrs7EUmzgxY=;
 b=XFXgLzlgY4g6HS5m6MUxCj4IlxKLyTb6X0U0NTI6bz/mrU/IkwRtFZtOpFZX5eOGGcamLC
 neH9G0FVh4jWIvS1/v5no4UuUTRlgTJmEg8iqQrbr9MLZ9R5bjmVqk5WTfQDgvPQ2jn02S
 hclmwUGGXmJC7QuJHzB7hRBz/3pDBRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776240387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nc+arbe9x86F+gpf8loQwFenhsS//6ydZrs7EUmzgxY=;
 b=SRXowny8EoV93VRngoyhPbj2f+YTfnaquB+qL68r6Ba3ilY9qsOnMLfC9zwkI/oOGRKsoY
 wFVBAGkdYP0q06CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A4A54B8DF;
 Wed, 15 Apr 2026 08:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7f16EANH32ldJAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Wed, 15 Apr 2026 08:06:27 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 10:06:15 +0200
Message-ID: <20260415080623.164440-1-rbranco@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411092452.211540-1-rbranco@suse.de>
References: <20260411092452.211540-1-rbranco@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6C2816A7DF
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] userfaultfd: Use two-step handshake to probe
 features
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

userfaultfd05 and userfaultfd06 assume that
UFFD_FEATURE_PAGEFAULT_FLAG_WP and UFFD_FEATURE_POISON are available
when setting up userfaultfd.

On kernels where either feature is unavailable at runtime,
UFFDIO_API fails with EINVAL and the tests end up as TBROK instead of
being skipped.

Fix this by using the required two-step handshake and skip with TCONF
if the required feature bit is absent.

Fixes: 1840ee23d172b5ab04cca7c2acfa48755b041911
Link: https://github.com/linux-test-project/ltp/issues/1289

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 .../kernel/syscalls/userfaultfd/userfaultfd05.c   | 12 +++++++++++-
 .../kernel/syscalls/userfaultfd/userfaultfd06.c   | 15 +++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index e25a227cf..e6386ce76 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -82,10 +82,20 @@ static void *handle_thread(void)
 static void run(void)
 {
 	pthread_t thr;
-	struct uffdio_api uffdio_api;
+	struct uffdio_api uffdio_api = {};
 	struct uffdio_register uffdio_register;
 	struct uffdio_writeprotect uffdio_writeprotect;
 
+	/*
+	 * Two-step handshake to check if feature is available
+	 */
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+	uffdio_api.api = UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
+		tst_brk(TCONF, "UFFD_FEATURE_PAGEFAULT_FLAG_WP not supported");
+	SAFE_CLOSE(uffd);
+
 	set_pages();
 
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
index 5b1252c35..e1b3c2f6f 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -97,18 +97,25 @@ static void run(void)
 
 	poison_fault_seen = 0;
 	sigbus_seen = 0;
-	set_pages();
 
+	/*
+	 * Two-step handshake to check if feature is available
+	 */
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+	uffdio_api.api = UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
+		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
+	SAFE_CLOSE(uffd);
 
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_POISON;
 
 	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
 
-	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
-		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
-
 	uffdio_register.range.start = (unsigned long) page;
 	uffdio_register.range.len = page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
