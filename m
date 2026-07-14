Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72141C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:33:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5DB23E56B0
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:33:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 917033C5E52
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:32:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DBEDA6008B0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:32:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15E9877D74;
 Tue, 14 Jul 2026 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784017967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yYEhPBamIG92/muLmFT3gRRi8Uqf/v0wOKP1Xouhfk4=;
 b=k+O+oLlb06Uta3thjLmWnUWuggPn38ttc+Nvcix4pydvb2Z2YirrcyfeDL5IhBe09/7AdJ
 ZhI/c9wthWWCsVQxvgt7SBKTObBtBOoefI6TRWf1pZKW+Ju7V9pAhZGyZKV56ZMjRoGGKJ
 NYffzk7TFJN3QJmrd3dJSbC1H9tPBow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784017967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yYEhPBamIG92/muLmFT3gRRi8Uqf/v0wOKP1Xouhfk4=;
 b=p7rXKtByjAPgrI92q/hmfilMRCyyWdQnoFo7KgdiOGx5ZJz3kobv3wx/nCW8hTeGJEwGTx
 HlTOr0LJ/T01IhAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784017967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yYEhPBamIG92/muLmFT3gRRi8Uqf/v0wOKP1Xouhfk4=;
 b=k+O+oLlb06Uta3thjLmWnUWuggPn38ttc+Nvcix4pydvb2Z2YirrcyfeDL5IhBe09/7AdJ
 ZhI/c9wthWWCsVQxvgt7SBKTObBtBOoefI6TRWf1pZKW+Ju7V9pAhZGyZKV56ZMjRoGGKJ
 NYffzk7TFJN3QJmrd3dJSbC1H9tPBow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784017967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yYEhPBamIG92/muLmFT3gRRi8Uqf/v0wOKP1Xouhfk4=;
 b=p7rXKtByjAPgrI92q/hmfilMRCyyWdQnoFo7KgdiOGx5ZJz3kobv3wx/nCW8hTeGJEwGTx
 HlTOr0LJ/T01IhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE32F779AE;
 Tue, 14 Jul 2026 08:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id adcyMy70VWo+MwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Jul 2026 08:32:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:32:46 +0200
MIME-Version: 1.0
Message-Id: <20260714-checkpatch_remove_rules-v1-1-b5c561f2dc16@suse.com>
X-B4-Tracking: v=1; b=H4sIAC30VWoC/x3MSwqEMBBF0a1IjQ1oDC3tVkRCiM9O0f6oqAji3
 g0Oz+DeiyKEEanJLhIcHHmZE8o8Ix/c/IPiPpl0oT9FXRrlA/x/dZsPVjAtB6zsI6LC12gMpna
 66inVq2Dg8z233X0/OKGXoGkAAAA=
X-Change-ID: 20260714-checkpatch_remove_rules-e942ef47a23d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784017966; l=858;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=26g0ZchGytbHeDNsuCcKoCoOiqXrxF5gC4AxX+WXHr8=;
 b=Vq2CpbgcDzdSZ+C3vyss4E9j4EhoPYEJMAk+RAHmR9PDvk871MRjdVesi1zXpqC7IKjX+I0wQ
 E2gOitdpGhUAxx8o1OgmujOCtG+7SwXeU+DL7FU0abXVwd/YcL8MXOl
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] checkpatch: relax parenthesis style checks
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

The PARENTHESIS_ALIGNMENT and OPEN_ENDED_LINE strict checks flag common
LTP formatting that is otherwise accepted, so disable them.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .checkpatch.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.checkpatch.conf b/.checkpatch.conf
index a7b6219adac5fff663c99a4cafaafb7c609233a6..0b22f7811cc891e91c62565edb0663df1e0f2622 100644
--- a/.checkpatch.conf
+++ b/.checkpatch.conf
@@ -17,3 +17,6 @@
 
 # ENOSYS is used in test error macros
 --ignore ENOSYS
+
+# LTP does not enforce open parenthesis alignment nor forbid a trailing '('
+--ignore PARENTHESIS_ALIGNMENT,OPEN_ENDED_LINE

---
base-commit: 7ca5dc366a558f3666223e6abe579edd90bafd38
change-id: 20260714-checkpatch_remove_rules-e942ef47a23d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
