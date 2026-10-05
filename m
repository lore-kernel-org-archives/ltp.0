Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CCCCA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:26:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65B563E4E58
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15C383DD461
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8A8156005D1
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 34F0B1F769;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5z59r5etl/T3B7VLkTso3Q71wPVRpxZaH/fNaRIQZg=;
 b=x8kSa+ZTtkKtAUf974Kmigy2Tp31n4yoHRMWokyVlfdFWAHhU/dyEWAow8D3WDcMs041HF
 9sS4O1XX7qsqN81TIrTUAAPdkr+7+6oXIEox0KUUPW6O99sbXVXCUIa4rpiAxEXTRUFDKw
 yGUwcVanwO9gmmfDtqAAUJ6Yt81v/6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5z59r5etl/T3B7VLkTso3Q71wPVRpxZaH/fNaRIQZg=;
 b=+WnZewfJdzm04obLTyH/KdrQBN3ER6ls/tOtoH7lV0ohaZdjCJ59Yow17LfNtS+COROoQH
 alWCa91mE9GdUiDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=teODKh6X;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9qHWZl2N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5z59r5etl/T3B7VLkTso3Q71wPVRpxZaH/fNaRIQZg=;
 b=teODKh6XyXapvQY07f6LWharIoyHRavLIk6CHTq2cl8E0pQqNSG8sn+VwLV8IIFcC88VTn
 sqIE4CXPNuxz7Zjn+2kQYe/+L7tv+/a8N4dcX0Tav9vJ2AUUulYTNcD+Vu0X4Mel3Y2mm/
 6X8FLVWj3fznx9bLiv70rohyTQCKyfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5z59r5etl/T3B7VLkTso3Q71wPVRpxZaH/fNaRIQZg=;
 b=9qHWZl2NghaDUmnflEsUyOuv3Um64u1VOEZ+lSj4au20+7UYr5khnqBF62piuwDGLhMPY3
 5077//5UCrzdZBAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEC0613AE7;
 Mon,  5 Oct 2026 13:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:30 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-2-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1189;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=IHj05Bn75M/K69gUVA6SCOOTaAwplYr9NJHtr98giyo=;
 b=38QswgInP18iyHCX0Mvd+vR2w5EBSMWz4dDoevkjlmnf7HunkLrNZLY+jipYwrm+gFb8V797g
 eE1AvAYETNjDUXusM95LLsg5Sb50ywgytC5L3Q6pVXKecxkRj/55ori
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 34F0B1F769
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.963]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/15] ujson: writer: Fix OOB read on invalid UTF-8
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

ujson_utf8_next_chsz() returns -1 on invalid UTF-8 sequences.
Because i is unsigned (size_t), adding -1 moves i back by one byte.
When i > 0, the loop steps back to the previous character and then
forward onto the invalid byte again, looping forever. When i == 0
(invalid byte at the start of the string or right after an escaped
character), i wraps to SIZE_MAX, causing out-of-bounds reads in
subsequent iterations and during output flushing. Stop and set an
error when an invalid UTF-8 byte sequence is encountered.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index c86a3b2af..b5da494d1 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -114,6 +114,10 @@ static inline int out_esc_str(ujson_writer *self, const char *val)
 
 	do {
 		next_chsz = ujson_utf8_next_chsz(val, i);
+		if (next_chsz < 0) {
+			err(self, "Invalid UTF-8 sequence");
+			return 1;
+		}
 
 		if (next_chsz == 1) {
 			switch (val[i]) {

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
