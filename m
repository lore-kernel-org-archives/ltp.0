Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2492CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:28:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C65C3E4E38
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:28:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0C63E9D05
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E8099200381
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7C3921DD0;
 Mon,  5 Oct 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RFP5IZsWGgPWOPMGY39vSHMgYd3Ib1tOaOghULQfAc=;
 b=za+ni2ukqlmUj4t47WJJuhuf2js0ZGikSPZusQM6a2Rcr9AssVMxXdFe3mdolYz+pe6Yu+
 X4esneud6qJI6UC/gAp4SdxG9LFg9l7AY7frAUb2oJUSkBjvX7ziM2iq8JFCAIAyI8ujOG
 HqcEMNeRAZ+9fwcqgdBIo+Zqm+mYVLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RFP5IZsWGgPWOPMGY39vSHMgYd3Ib1tOaOghULQfAc=;
 b=p3o0P2P4Kbsy/Y/vBydy/0z3lLF0SYSfv85aR8Y5fPzCvZHtpn2V6oyyFEDjT8K8g09pA7
 tKCfjVrcfRL3osBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RFP5IZsWGgPWOPMGY39vSHMgYd3Ib1tOaOghULQfAc=;
 b=Y7NdJRxhyvt+/VAK54GGAkbtON7xbBhZRVFrPxf0I7rholv6I0bAwzY9znES9vAc280hTC
 Qn/Coi4tMwhH13NbriW3hqJhD0LLbF+S2Vrty+JwKpUkQjdcSVDIywXGlAqOIjZlk72yFu
 boEX8ffal30Hh0YBC3bUGZbqBRv6CFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RFP5IZsWGgPWOPMGY39vSHMgYd3Ib1tOaOghULQfAc=;
 b=MrLaNBeK/8uxikN0MxYUdXNh7BM4CdJXxhlAlkiCUqnyzs9C/LZ2IG3J4sizqMd/FN+eor
 NCS+xOor1gYRjiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCFDB13AF0;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T9
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:36 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-8-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1006;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=FOpu9o9INj8YKFM8Qen6dCYUrLH0usUjw/MonaFQFsQ=;
 b=HSn64pQaS4mBhzTrOjzc7q0N/1EdynHaN7C/7om9X7IG6B0yh1NSVAvOY/B2t03vE1j1v2Qzb
 Hiwn2v4Qd94BWKEOudZ8cci58jirSJxeePT8jCuO2iruzFakDxKdeKQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.11)[-0.556]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 08/15] ujson: writer: Check return value in ESC_FLUSH
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

ESC_FLUSH ignores the return values of out() and out_str().
If an output error occurs while flushing escaped characters, the error
is ignored and writing continues. Check the return values and return
immediately on failure.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index c203ee079..15faca9be 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -98,10 +98,12 @@ static inline int out_ch(ujson_writer *self, char ch)
 }
 
 #define ESC_FLUSH(esc_char) do {\
-	out(self, val, i); \
+	if (out(self, val, i)) \
+		return 1; \
 	val += i + 1; \
 	i = 0; \
-	out_str(self, esc_char); \
+	if (out_str(self, esc_char)) \
+		return 1; \
 } while (0)
 
 static inline int out_esc_str(ujson_writer *self, const char *val)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
