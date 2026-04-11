Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92845F45A1B
	for <ltp@archiver.kernel.org>; Sat, 11 Apr 2026 09:25:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A58FB3E2697
	for <ltp@archiver.kernel.org>; Sat, 11 Apr 2026 11:25:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC8713E0E67
 for <ltp@lists.linux.it>; Sat, 11 Apr 2026 11:24:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4968B600A6F
 for <ltp@lists.linux.it>; Sat, 11 Apr 2026 11:24:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C71905BCD8;
 Sat, 11 Apr 2026 09:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775899495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5VNFKs+qGsrj4d0YjqpXgq32ih+wFrpTGf94TKctzEA=;
 b=Bli+syPSSpLS72a3WM2sERwezdaau3uY7vNtpKZNLiWjXMqFDSI4XSub8kk1eJ69qbd+hW
 SbmKjqOvNVnm4BpFAAfJAj6eWztqUh88QygxY0sKVYRtc47ymxAKDYC7uz2/pI/Nen6CrO
 yhbMZW+5SfSSXjgCgGk5j7ZSp5hVgQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775899495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5VNFKs+qGsrj4d0YjqpXgq32ih+wFrpTGf94TKctzEA=;
 b=nD8PmTFAkk5W3StsjJBfZBHeV8IGsvKAxmTC2MCLeEqg8jyuzKm+Ro9uQ1bCze+xbUxTu5
 iIUpu4KUqPAWHsDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775899495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5VNFKs+qGsrj4d0YjqpXgq32ih+wFrpTGf94TKctzEA=;
 b=Bli+syPSSpLS72a3WM2sERwezdaau3uY7vNtpKZNLiWjXMqFDSI4XSub8kk1eJ69qbd+hW
 SbmKjqOvNVnm4BpFAAfJAj6eWztqUh88QygxY0sKVYRtc47ymxAKDYC7uz2/pI/Nen6CrO
 yhbMZW+5SfSSXjgCgGk5j7ZSp5hVgQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775899495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5VNFKs+qGsrj4d0YjqpXgq32ih+wFrpTGf94TKctzEA=;
 b=nD8PmTFAkk5W3StsjJBfZBHeV8IGsvKAxmTC2MCLeEqg8jyuzKm+Ro9uQ1bCze+xbUxTu5
 iIUpu4KUqPAWHsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5D7B4A2B4;
 Sat, 11 Apr 2026 09:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z/zaJmcT2mm+JgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Sat, 11 Apr 2026 09:24:55 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Sat, 11 Apr 2026 11:24:51 +0200
Message-ID: <20260411092452.211540-1-rbranco@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] userfaultfd: Use two-step handshake to probe features
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

Also remove userfaultfd05's needs_kconfigs check, since runtime
feature probing is sufficient here.

Link: https://github.com/linux-test-project/ltp/issues/1289

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd05.c | 11 +++++++----
 testcases/kernel/syscalls/userfaultfd/userfaultfd06.c | 10 +++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
index e25a227cf..5412f12e1 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
@@ -89,7 +89,14 @@ static void run(void)
 	set_pages();
 
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
+		tst_brk(TCONF, "UFFD_FEATURE_PAGEFAULT_FLAG_WP not supported");
+	SAFE_CLOSE(uffd);
 
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
 
@@ -124,8 +131,4 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.min_kver = "5.7",
-	.needs_kconfigs = (const char *[]) {
-		"CONFIG_HAVE_ARCH_USERFAULTFD_WP=y",
-		NULL
-	}
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
index 5b1252c35..7ad682f5a 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -100,15 +100,19 @@ static void run(void)
 	set_pages();
 
 	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
+		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
+	SAFE_CLOSE(uffd);
 
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
