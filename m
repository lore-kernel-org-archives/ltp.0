Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C86CD6E7A
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 14:30:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 305AD3CEE59
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 16:29:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B9DA3CD4C7
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 16:29:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DDC981400768
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 16:29:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9703B21861;
 Wed, 11 Oct 2023 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697034586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yfiGtL+7O9o0dQhkPOilSzG4k8dfexvfibcMYPM6tLo=;
 b=SS7Gnzw5PpN003vcnF4mIQCl9g9Zsw40XKkKGojjIRNOaZFm0G+B7jkA/9FYi04+LflVQK
 K8xYiuHqiQRC1T5KFTueV9J0SehBjrWX6oP8nSWRKL+Id+IQb8Rq+RqQcE1JcQE4GzXOOe
 8sex89S31KYNXV9mdhqMw1X1gAQtl2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697034586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yfiGtL+7O9o0dQhkPOilSzG4k8dfexvfibcMYPM6tLo=;
 b=N7GCGgbyXtjiZQ16xy+wLE1tyXjzp4+8+80RlYF7MujUE+XKmHVHZib3vLXZk7vqCh2l21
 Ph6nZgz8JjYGeuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7240D138EF;
 Wed, 11 Oct 2023 14:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UEZjGlqxJmU7bQAAMHmgww
 (envelope-from <mkittler@suse.de>); Wed, 11 Oct 2023 14:29:46 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 16:29:27 +0200
Message-ID: <20231011142927.29699-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[29.31%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Prevent vma05 from passing wrongly when no
 coredump generated at all
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

When debugging this test I noticed that it passes when no coredump could
be generated at all. This change adds a check to verify whether the test is
provoking a coredump as intended.

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/mem/vma/vma05.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index c9e4becdb..bcc3b9623 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -54,6 +54,7 @@ vma_report_check()
 
 	rm -rf core*
 	{ vma05_vdso; } > /dev/null 2>&1
+	[ -s ./core* ] || tst_brk TBROK "[vdso] no backtrace generated"
 	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
 		vma05_vdso ./core* 2> /dev/null)
 	if echo "$TRACE" | grep -qF "??"; then
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
