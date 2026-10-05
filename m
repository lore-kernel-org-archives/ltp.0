Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51069CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:26:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BC843E53CB
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF5063E4E3E
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CE99C20034E
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F7E51F7BA;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=DzNDT5g02AsXHE2j1jdMF/M5RX6ZpKE/e/f9YWE02deBB6e1fhPtc0CPmdNP+q2EQS9/GH
 KZqHffo+BgGQvhezV+6Av7+2tZIm7NHyyje0VppJbOIsK1/sb67ttejhT82nHBy0Vez/fp
 /Jr2oMDjMao5cYjrYdKIOTryE1bQGCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=kWlWzt0QQIeWQZdYtMKLzayroBCGPwIunFCH6lbq0Al8MQBexKdZCFJZpQDeG6Gmn++bKS
 QGA0UGM4hjFyEyAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=AsS5nEdzXmyvXbQ3eZ11UlAJfQbkx3P6j7yRAWxDulvByriwVpDhL7g2XKOWqVER59L1iC
 YhqyTZ3N62BYYWYdo2X1oRCbv28tiYIKIN8nLvg68WjjNlqJM4qle+6E5cAVhARq9J/n7e
 sV4SxUuOO3vvdRlDRmtnF1VRXGxHIZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=N9Qlz2FhjmX5SHzIMzEY8/gyE0M5zD87UPMviL3MRGoWA+NUqlHlHw/xXu+xlgbtlbsjvr
 K9PGcvOd/eHM+7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE40613AE4;
 Mon,  5 Oct 2026 13:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T2
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:29 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-1-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1057;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pi8lw39mp9h2inIkW2RlEJyvqpFrgulq7SUbm7pBov4=;
 b=bZAADQQUJUxlaRuD4KLqw9H1IU1hTZMAnTCJaah2L6US0D1nxiIHeFfS3oG76BY24XHGJ/mww
 tdwtVASA33NC63vZ87y2GiaFO/sR2SFUjK1GCUKrdvuBIlDgNEpPaW8
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.22 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.12)[-0.578]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/15] ujson: Fix 4-byte UTF-8 sequence decoding
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

In ujson_utf8_next(), decoding 4-byte UTF-8 sequences read past the
byte boundary, verified the already-masked byte s2 instead of the
fourth byte s3, and failed to advance the string pointer correctly.
As a result, any 4-byte UTF-8 sequence was rejected and returned 0.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/ujson_utf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/ujson_utf.h b/include/ujson_utf.h
index 83fe8ab09..801a1fcb2 100644
--- a/include/ujson_utf.h
+++ b/include/ujson_utf.h
@@ -65,15 +65,15 @@ static inline uint32_t ujson_utf8_next(const char **str)
 	if (UJSON_UTF8_IS_3BYTE(s0))
 		return (s0 & 0x0f)<<12 | s1<<6 | s2;
 
-	(*str)++;
-
 	uint32_t s3 = *str[0];
 
-	if (!UJSON_UTF8_IS_NBYTE(s2))
+	if (!UJSON_UTF8_IS_NBYTE(s3))
 		return 0;
 
 	s3 &= UJSON_UTF8_NBYTE_MASK;
 
+	(*str)++;
+
 	if (UJSON_UTF8_IS_4BYTE(s0))
 		return (s0 & 0x07)<<18 | s1<<12 | s2<<6 | s3;
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
