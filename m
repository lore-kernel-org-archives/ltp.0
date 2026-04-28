Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0D7FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:11:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAF7C3E2D7C
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 18:11:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2E93DEFF3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:10:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 896AB1400332
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:10:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 727F86A833;
 Tue, 28 Apr 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777392643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
 b=SLqZUTuiRnkvt1+LYmjen9bfwFzz1c9DH1XkZRTn9F+5jufVi2StfiYOlkzp+jQtCj6ksu
 A9N6r4n9ANCj1mlGCaLTKGZgt0LHGVj0O7Q5XRrVH4rCmHISR0EpbqSpXR+XH6oXiE9ii8
 +/GvWKElwlzDjl5Az9ABKD3i15JXeDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777392643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
 b=D4bxaCBetY0m1Nl7eCJYcCsIlxeIQ6LiVMNNXCbCl/EL4L11V8staXnd6AgXxN3fy5Mri9
 qgxIkaCWUfVY+QDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SLqZUTui;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D4bxaCBe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777392643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
 b=SLqZUTuiRnkvt1+LYmjen9bfwFzz1c9DH1XkZRTn9F+5jufVi2StfiYOlkzp+jQtCj6ksu
 A9N6r4n9ANCj1mlGCaLTKGZgt0LHGVj0O7Q5XRrVH4rCmHISR0EpbqSpXR+XH6oXiE9ii8
 +/GvWKElwlzDjl5Az9ABKD3i15JXeDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777392643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
 b=D4bxaCBetY0m1Nl7eCJYcCsIlxeIQ6LiVMNNXCbCl/EL4L11V8staXnd6AgXxN3fy5Mri9
 qgxIkaCWUfVY+QDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0159E593B0;
 Tue, 28 Apr 2026 16:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NoI0OQLc8Gm6EgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 16:10:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Apr 2026 18:10:33 +0200
Message-ID: <20260428161034.947614-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Queue-Id: 727F86A833
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ima_violations.sh: Wait for ima_mmap to exit
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This fixes a race when even 2 sec sleep is not enough (f26399583e was
a wrong approach).

While at it, check for ima_mmap exit code (missing since ever).

Fixes: f26399583e ("ima/{ima_measurements,ima_violations}.sh: Avoid running on tmpfs")
Fixes: 3a8efbcc46 ("This patch adds Integrity Measurement Architecture(IMA) testing support ...")
Reported-by: Martin Doucha <mdoucha@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 13cc9d804d..0c03c30786 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -157,6 +157,8 @@ test2()
 
 test3()
 {
+	local pid
+
 	tst_res TINFO "verify open_writers using mmapped files"
 
 	local search="open_writers"
@@ -168,6 +170,7 @@ test3()
 	echo 'testing testing' > $FILE
 
 	ima_mmap -f $FILE &
+	pid=$!
 	# wait for violations appear in logs
 	tst_sleep 1s
 
@@ -177,7 +180,10 @@ test3()
 	validate $num_violations $count $search
 
 	# wait for ima_mmap to exit, so we can umount
-	tst_sleep 2s
+	wait $pid
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "failed to execute ima_mmap"
+	fi
 }
 
 test4()
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
