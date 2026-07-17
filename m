Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D635C44520
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16DB83E269F
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 14:33:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E265A3E24F5
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3CF4600BAD
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C62F3CCD;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wnEONZucjNXzfxHZ9mnA6V4ESXR2RDiSQVRQKvtRTA=;
 b=Rfbd4XLM9PLqAt4MAYOF/ewU0yJ2TGD0BPVGFLDDRXHp9sP0oqR4Qif050Gmu4ge2jNldL
 ZwRLwjDedYLV9/ENkReToVSADBK+u4kAvgxuji2kUSjpkEw1ABaj26ChUX9sYQOe5MF4VL
 byl6ZcSd7gVmFhXfaE/Ey7ucWCAxhSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wnEONZucjNXzfxHZ9mnA6V4ESXR2RDiSQVRQKvtRTA=;
 b=zIK8t/J2ttpNaaU6qs2dlmzR1zNncxIfmUKrkofCgWm7i+PC9AICmSwDZG5XoKpRs5mhjO
 DBjkUZQYPYLvTlCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rfbd4XLM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="zIK8t/J2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wnEONZucjNXzfxHZ9mnA6V4ESXR2RDiSQVRQKvtRTA=;
 b=Rfbd4XLM9PLqAt4MAYOF/ewU0yJ2TGD0BPVGFLDDRXHp9sP0oqR4Qif050Gmu4ge2jNldL
 ZwRLwjDedYLV9/ENkReToVSADBK+u4kAvgxuji2kUSjpkEw1ABaj26ChUX9sYQOe5MF4VL
 byl6ZcSd7gVmFhXfaE/Ey7ucWCAxhSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wnEONZucjNXzfxHZ9mnA6V4ESXR2RDiSQVRQKvtRTA=;
 b=zIK8t/J2ttpNaaU6qs2dlmzR1zNncxIfmUKrkofCgWm7i+PC9AICmSwDZG5XoKpRs5mhjO
 DBjkUZQYPYLvTlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72932779AD;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +IU6Gg8hWmr7LgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 17 Jul 2026 12:33:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 14:33:18 +0200
MIME-Version: 1.0
Message-Id: <20260717-fix_core_library-v1-1-c575fcbb2cb3@suse.com>
References: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
In-Reply-To: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784291599; l=913;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nv4IJ1pFyievSkE+vGsIcvthY6FvU9UcVA2IGwqzSEs=;
 b=mv3KOtqB+jrYpTy1mjDifcnrbylhZheQz7/9TGYLOANtyLfwaX4250TyFyolOrjRN3Vo3gQVH
 nTdlbKZwP1yAZOqT1v1nKnHZyfIuk7vzxDpRntx0ytehaTzA4ysUmhY
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8C62F3CCD
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib: Avoid loop_info.lo_name buffer overflow
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

The backing file path may be longer than the fixed-size lo_name field,
so an unbounded strcpy() can overflow the loop_info structure. Copy at
most the field size and rely on the preceding memset() for termination.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index d3c53a1a18d2e4948ebff21d6d66c0ccd1590c6f..b5c3ccdb7be52ce600fbd7d7a83f6081df65d616 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -182,7 +182,7 @@ int tst_attach_device(const char *dev, const char *file)
 	 * LOOP_SET_FD and LOOP_SET_STATUS.
 	 */
 	memset(&loopinfo, 0, sizeof(loopinfo));
-	strcpy(loopinfo.lo_name, file);
+	strncpy(loopinfo.lo_name, file, sizeof(loopinfo.lo_name) - 1);
 
 	if (ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo)) {
 		close(dev_fd);

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
