Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AF4CA9ED2
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:06:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA0543EA815
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:06:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A744E3EA833
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA1CB1A00914
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3F781F74A;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qm1M8Kg1taS1f1O8I8RSHBfYbrz7xZpyh1Vo8v193Ok=;
 b=xeDC154pLWkRFASyIMXfnqoiKubIvvLx2Qmf8rFeRCM4E02mR+vB8ySaA0/mRKro7mLlbC
 7pFTMzxSMvni14SlChk4r+qe2wj0nu4/Qn3kvlwtA37eU+7LFKxuctGk9snUDXO1qCRs7b
 FmYJMUdnV70BERPu2CmDK3H8+67Wwx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qm1M8Kg1taS1f1O8I8RSHBfYbrz7xZpyh1Vo8v193Ok=;
 b=xRD7YfKYaa+qqZ0C4sjEWJM3R3akAu4yd9aYZXc5kHMtGDfrL9I2fetcU3Q5qE8F6vlKob
 uJ1gWOYW0JYGZ8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qm1M8Kg1taS1f1O8I8RSHBfYbrz7xZpyh1Vo8v193Ok=;
 b=PSyN39WrOBuDjO0462C4dwWXKPEgdkUpaHUK76onQmjl7mFpPRtD5WIgwSqQz7g65FqfMS
 sGQHNcB9WjNULG7ec5hvfsPXneEnROpFHvxjRGHsvYEyhrHvtxRPZzsS6e0BrXvqWIgsry
 +ikC+byiWWl118+bmlXfgquztAat/BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qm1M8Kg1taS1f1O8I8RSHBfYbrz7xZpyh1Vo8v193Ok=;
 b=4vjaXEfVtV2GTK8ggwKz4UzytG7rH+j9QsMcDVSx5llLRv2IeNBMh3LNuZ3dGWRzpGnG2a
 OAdUxi93e64TJJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C4B3134C7;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T13
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:08 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-12-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1009;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=sAyohHnh9cJEAIVnRpX56bYchimDNuMLrQd28QswD4Q=;
 b=HEUjcpHG4PPRhM43d6KEzGw5/6NhU8rN3bBDGmmfsQ9ZJ6gvBF0e4Hh+65b/KywE/8tu4SxjT
 6KSC5U8WB2fD8t34aKRTo/g+QBkg6LfnRYUvtDCVnoAO3BHoFIRixwx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 12/15] ujson: reader: Reject \u0000 escape in
 strings
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

String values and object IDs are returned as NUL-terminated C strings.
A \u0000 escape was written as a NUL byte into the output buffer,
silently truncating the string. Report an error instead.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 9d17bbf4b..dae45ebb9 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -135,6 +135,12 @@ static unsigned int parse_ucode_esc(ujson_reader *buf, char *str,
 	if (ucode < 0)
 		return 0;
 
+	/* Strings are NUL-terminated, an embedded NUL would truncate them */
+	if (!ucode) {
+		ujson_err(buf, "\\u0000 is not supported");
+		return 0;
+	}
+
 	if (ucode >= 0xdc00 && ucode <= 0xdfff) {
 		ujson_err(buf, "Unpaired low surrogate");
 		return 0;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
