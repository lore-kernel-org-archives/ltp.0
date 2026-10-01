Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAF9CA5FB3
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 11:01:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC8BA3E54CC
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 13:01:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FA8D3C2AB8
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 13:00:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EFDFA140111D
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 13:00:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4087E1F847;
 Thu,  1 Oct 2026 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790852448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6+oI9ZHILxM9QVp6NaBIyrhL0bzKXjFREG/1bFQBwr0=;
 b=J48HyeZC74jBOOa6scuUfpWGfspSF/W54TBtkuP3dIbBYEt7EP8kWU25JLZV9g7znHysB8
 dA8YFwVokzPS+jFJeJb8a2+7qEyzdvSGWM+tmDkuJvJDL53FR0VK+Tv7cEJSKJdMlv8pAm
 mHeVC+xzZaHkyOrENy8QcL1ZEGxMvYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790852448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6+oI9ZHILxM9QVp6NaBIyrhL0bzKXjFREG/1bFQBwr0=;
 b=kVAOfxj2tw+8PdBgYXj2L+xF+g8AEavJKvB3VHtseu7eqUj7/ZywJHwKhDhsyikqzks5J2
 Zi1F2R3u/aw6Z0Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=arYQ7t9s;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LBuQhYQK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790852444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6+oI9ZHILxM9QVp6NaBIyrhL0bzKXjFREG/1bFQBwr0=;
 b=arYQ7t9s7BAEnvJFkauHgWz/S5pEVGDv0TPh65OVZWzAdUzOn29Xm492RCQ3Dzzvv26XoF
 1o8WwMF3+g2roJ+ApoNRDGDW9QoLZEqxHZxAXJtSKnN///YiDzp8X5yYDLow7HkluF0RWH
 T4ZDN6ugHD5KNu0NouCTsiWyAMvQ+Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790852444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6+oI9ZHILxM9QVp6NaBIyrhL0bzKXjFREG/1bFQBwr0=;
 b=LBuQhYQKbN0147RqFZvI8wb460n7dUqIkl+iR5FHsLCChWnFGOyvRk8dO93v2skj88nrIV
 ZvTkj/oLUPpcKbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F32AE134B3;
 Thu,  1 Oct 2026 11:00:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4YJwMVs9vmpbDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Oct 2026 11:00:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Oct 2026 13:00:42 +0200
MIME-Version: 1.0
Message-Id: <20261001-fix_aio_suspend-1-1-v1-1-ac365dc874ef@suse.com>
X-B4-Tracking: v=1; b=H4sIAFk9vmoC/yWMQQqEMAxFryJZW2g71IVXEZFq4hgXVRoVQbz7R
 Ie/evDfu0AoMwnUxQWZDhZekoIrCximmL5kGJXBW185a50Z+ewiL53sslJC43S+tyGGERHDB9R
 cM+ntrTbtn2XvZxq2JwX3/QPTbJbQdwAAAA==
X-Change-ID: 20261001-fix_aio_suspend-1-1-2b05a5fddd53
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852443; l=2408;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=d5WpuYTtHTTvsM4TU2n66deVdKO9IAol9GNR4R8fFUg=;
 b=5VsXOtCkAeUgfgDSxbx32WlErT5NCe4gW1UdaniD3ke3e4iL8aXjf9q7KI7i19Uf5Sf3vd2AC
 cy8UMLD+vWiC/nwqqTm88DA+MbH+O8XYe/a5V4qApuJvG3q01XvTHH7
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; TO_DN_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4087E1F847
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: Fix aio_suspend/1-1 completion race
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The selected read may finish before the test calls aio_suspend().
Treating this as an unresolved result makes the test depend on I/O
speed and scheduling.

POSIX permits aio_suspend() to return immediately for a completed
request. Drop the racy precondition and retain the completion checks.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Two aio_suspend tests assume that queued I/O cannot complete before
the test checks its status. Depending on I/O speed and scheduling,
this can produce an unresolved result or a false test failure.

In 1-1, early completion is valid: aio_suspend() must return
immediately when a listed request has already completed. Remove the
check that rejects this case.
---
 .../conformance/interfaces/aio_suspend/1-1.c             | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
index 8f0c9ae95..2de7c87d2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
@@ -25,7 +25,6 @@
  *
  *	- write to a file
  *	- submit a list of read requests
- *	- check that the selected request has not completed
  *	- suspend on selected request
  *	- check that the selected request has completed using aio_error and
  *	  aio_return
@@ -146,20 +145,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		exit(PTS_UNRESOLVED);
 	}
 
-	/* Check selected request has not completed yet */
-	err = aio_error(aiocbs[WAIT_FOR_AIOCB]);
-	if (!err) {
-		printf(TNAME " Error : AIOCB %d already completed before "
-		       "suspend\n", WAIT_FOR_AIOCB);
-		for (i = 0; i < NUM_AIOCBS; i++)
-			free(aiocbs[i]);
-		free(bufs);
-		free(aiocbs);
-		close(fd);
-		exit(PTS_UNRESOLVED);
-	}
-
-	/* Suspend on selected request */
+	/* The selected request may have already completed, which is valid. */
 	ret = aio_suspend((const struct aiocb **)plist, 2, NULL);
 	if (ret) {
 		printf(TNAME " Error at aio_suspend() %d: %s\n",

---
base-commit: 65c0cffc7dda79320e551f6437327a5625e88d65
change-id: 20261001-fix_aio_suspend-1-1-2b05a5fddd53

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
