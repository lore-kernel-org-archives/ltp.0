Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABD1CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:02:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDC153EB0F1
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:02:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4E03EA812
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1B9E200961
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0ED411F452;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=YdE/eFsrgXnbRIfix3nfOyxQBMtry9GNDmXM6sOoWQG9pRx3B9rGeMqqOTZe7hvgaT/Imk
 S3eJrNROApnjvaY+5arBvfWRtQiOz5IT2s9Mmp0wVOmUUN0x8XuaIJVQZgGgDVbG14Bjmj
 OrLd+pDiqArXFO4AEpTqIE9Bwp6Avqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=2uCP47CSKFiIg7smF12gEfE+jzgcmLHhBdkw5XB1RyjV/sIce7Q4rXOoqA885gRGrBDkHv
 iJ49ffkOu+vDAJBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uWfDnVIF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o1GLZewx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=uWfDnVIF3QY3o9X3Tz1XkEXeJk/9Ph6gmbkaS8nk6Yb6B+72HfQMWdTuq6D7dm24nTp+8o
 ybMYDjPnzCAXjHREUmsD+06Gk/rVrxzz7r4ZYPNEZnTdH9lJJUXuKgZ36r4JDUNa00scfi
 WwfidRXXcZFReuRy8aD7Mq+wDyuGUmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VNTI/HHRbn7l+sY8krdftSx+7i7o2HozttW+REqTTg=;
 b=o1GLZewxRF3HqUDKp7nu5ZYQhxATx+FhFWLTSGik3e8Vc6l+fgjHbDylKIhzHmnzOuNqUq
 7cPhWCr1kDru+OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CE0F13432;
 Tue, 13 Oct 2026 12:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T2
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:01:57 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-1-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1057;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pi8lw39mp9h2inIkW2RlEJyvqpFrgulq7SUbm7pBov4=;
 b=FnO0XiU/YnsUZVqPEIhgVDpIOlf3Y5YaxGB5tJcHlTQBAe/dpXU2satw8UgrlSO7pamgkOPVR
 L2ECdXHQs4OBrCQXBOBPbqgG4IC7zjuhEpqZOyaG30qAsbliYvt693q
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0ED411F452
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:email, suse.de:dkim]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/15] ujson: Fix 4-byte UTF-8 sequence decoding
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
