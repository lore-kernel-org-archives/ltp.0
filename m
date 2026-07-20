Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1C0C4452A
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:32:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADFF23E930A
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 16:32:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F36A3E92C3
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:31:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D62D16002FD
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:31:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDCAE3E25;
 Mon, 20 Jul 2026 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784557912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qovagNb5TAXtnQOe02SyHrnIX1vEae4Brnr2CMvI6g=;
 b=eBQJt6yK7gJTBuZKeH1mTHfKjsDRVpNV8xkzzgdYSEd93oWDxMYYsYsIf5h9f1R9aeDcUm
 gmzi7WkeqJEbAnvnevWkBRagSVWJ5PO1wylTklYnmcAcPkemDcVZF2KHuQM7V63qk+yGuX
 0yRVHEpgH/fDxB6gft5FjUkfAa6Y1nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784557912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qovagNb5TAXtnQOe02SyHrnIX1vEae4Brnr2CMvI6g=;
 b=sTgJ8bzz+9yzqS3tIyU7z6DdszGKVx3OzYHGCrJmBcJ0osBe6kPgHgen2OkZjw4ucPP51f
 G+UAmAVN6cAQLPAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784557912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qovagNb5TAXtnQOe02SyHrnIX1vEae4Brnr2CMvI6g=;
 b=eBQJt6yK7gJTBuZKeH1mTHfKjsDRVpNV8xkzzgdYSEd93oWDxMYYsYsIf5h9f1R9aeDcUm
 gmzi7WkeqJEbAnvnevWkBRagSVWJ5PO1wylTklYnmcAcPkemDcVZF2KHuQM7V63qk+yGuX
 0yRVHEpgH/fDxB6gft5FjUkfAa6Y1nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784557912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qovagNb5TAXtnQOe02SyHrnIX1vEae4Brnr2CMvI6g=;
 b=sTgJ8bzz+9yzqS3tIyU7z6DdszGKVx3OzYHGCrJmBcJ0osBe6kPgHgen2OkZjw4ucPP51f
 G+UAmAVN6cAQLPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CAAB779AB;
 Mon, 20 Jul 2026 14:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6KxuJFgxXmrEUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 20 Jul 2026 14:31:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 16:31:51 +0200
MIME-Version: 1.0
Message-Id: <20260720-fix_cve-2026-46331_enoent-v3-1-9f216efdd661@suse.com>
References: <20260720-fix_cve-2026-46331_enoent-v3-0-9f216efdd661@suse.com>
In-Reply-To: <20260720-fix_cve-2026-46331_enoent-v3-0-9f216efdd661@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784557912; l=793;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=eTtA37EjArmOwr8eV8u0H3FGzFzPGd6LZMaFNPwmof4=;
 b=5M3cBi04fQuYXRykobr6J0fr7hEh6dL1BneVKwKHueEq55kM5xKDX2UtKMUaAF8iPmcGUqtT4
 R2uYUEX43AvBRyjDuNQH40ATkfZYioEwzqnz+AGAESyUxhquYOiVO9s
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] tst_kconfig: add module mappings for
 ingress/matchall/pedit
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

Map CONFIG_NET_SCH_INGRESS, CONFIG_NET_CLS_MATCHALL and CONFIG_NET_ACT_PEDIT
to their kernel modules (sch_ingress, cls_matchall, act_pedit).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_kconfig.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 44eacc7c2989a5af3347b8f7ed16393fde0122a6..277ac606895046e072cf8f86076ecf7d79f9b1e6 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -162,6 +162,9 @@ static struct config_module_map {
 	{"CONFIG_CAN_RAW", "can-raw"},
 	{"CONFIG_CAN_BCM", "can-bcm"},
 	{"CONFIG_IP_SCTP", "sctp"},
+	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
+	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
+	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
 	{}
 };
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
