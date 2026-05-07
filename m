Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E18CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:32:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD4133E614C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:32:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB9DF3E5F70
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:31:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 49DD31A00613
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:31:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1CAE5D566;
 Thu,  7 May 2026 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778142697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJXJaCFsp9x9ZT2qU1yvR1zKMiBe/Dc59GMwhu9IVDM=;
 b=1aziWkby05ZKEaZYVXG0xWuKGbPNrPRo/LX+mnrblzCmFc4qXf91CBXxKWZQ3PzgUmIYyB
 z6oQHtIO+trmWGfj82G48mm5lPVHCSwNAlNXMDvK+HkzwG5TTJ2kqse44CWRrQL8mQNUfU
 flzdFRg560KQHMIs6IOvzC01pKIrR7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778142697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJXJaCFsp9x9ZT2qU1yvR1zKMiBe/Dc59GMwhu9IVDM=;
 b=U4XcCJLpaSWi63tqv5fjiSq22QLfyC9s36fNTpjY0q0MrcUN9Z2MUBRy9ZIkPr6SQq+uSM
 5JqBRqxlFEo6nZBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EXWplfdo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3kz7qDsh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778142696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJXJaCFsp9x9ZT2qU1yvR1zKMiBe/Dc59GMwhu9IVDM=;
 b=EXWplfdomay8220rbRbZCxRtklRjfFJXsNnT6tPKzBBuEVY3ocJal+f5OXFVR+yFJYgm6c
 9eHu6RqE7AUoRLjPWQ6FdUPLTjj0twxBVB0L0HSCqntPRONd9qIYzTm7dP7XNFLfinDr/B
 4JG6P/zG4znpY1W9chSwM7LKBl3tcHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778142696;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJXJaCFsp9x9ZT2qU1yvR1zKMiBe/Dc59GMwhu9IVDM=;
 b=3kz7qDshmd/gePOcMQ6p63wpp8LWNhbyredfKnJymodEinFi6RVvu2tCzxsW+jqq0Hkbis
 Oc03yFwPeK4oG6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0129593A7;
 Thu,  7 May 2026 08:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mH2FI+hN/GnVRwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 07 May 2026 08:31:36 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 10:31:24 +0200
Message-ID: <20260507083131.28197-2-rbranco@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507083131.28197-1-rbranco@suse.de>
References: <20260507083131.28197-1-rbranco@suse.de>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E1CAE5D566
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] userfaultfd: Use two-step handshake to probe
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
 testcases/kernel/syscalls/userfaultfd/userfaultfd05.c | 4 +++-
 testcases/kernel/syscalls/userfaultfd/userfaultfd06.c | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index 59956d85d..55ddc1a69 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -87,10 +87,12 @@ static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 static void run(void)
 {
 	pthread_t thr;
-	struct uffdio_api uffdio_api;
+	struct uffdio_api uffdio_api = {};
 	struct uffdio_register uffdio_register;
 	struct uffdio_writeprotect uffdio_writeprotect;
 
+	CHECK_UFFD_FEATURE(UFFD_FEATURE_PAGEFAULT_FLAG_WP);
+
 	set_pages();
 
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
index ec93d8ad6..c06de4ca2 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -99,6 +99,9 @@ static void run(void)
 
 	poison_fault_seen = 0;
 	sigbus_seen = 0;
+
+	CHECK_UFFD_FEATURE(UFFD_FEATURE_POISON);
+
 	set_pages();
 
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
@@ -108,9 +111,6 @@ static void run(void)
 
 	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
 
-	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
-		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
-
 	uffdio_register.range.start = (unsigned long) page;
 	uffdio_register.range.len = page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
