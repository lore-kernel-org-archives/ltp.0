Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048ABCC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:04:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57AA83EA834
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:04:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 504793EA822
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 194A91400986
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3ABB621E7E;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMW2kIkGlNlvomuWVNaEOGKn6CSc3PqzYuE6PKoO57A=;
 b=eCcxaJEWL6wyNtdL5+LravsDyd130nKCMt4SLCCnoK6mvl3FknhUrMkB+nAPmG9MSCeSfl
 CRzJ0nFbsx8CfCgDWZaAOqXXVBvyF0dVRKxOXkyoAf+iATGgED25/omaDs9FZIvRUZ8xKy
 t7X+/UcINbGaU2e94AJIdXTy0nt8jUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMW2kIkGlNlvomuWVNaEOGKn6CSc3PqzYuE6PKoO57A=;
 b=q7USXnYU8Lz3sJEOsdnNmPPINl7GZvmoqDCWopITIy20ccm7vuYlPmmGOOhkdD0Mz7qsTJ
 5M4Shgrx9KHnzRBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kjQu7yAB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O7fVxOTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMW2kIkGlNlvomuWVNaEOGKn6CSc3PqzYuE6PKoO57A=;
 b=kjQu7yABzWhm7kaLLmTqwgAQjmk8o05+JzYKqhuLYEmoxdykQe8BczV8Wj5eUb2vRy1q1N
 aLX6TqVxoZ5wyY/MyH1uVeHv11dTVDD+ewIoHwomDoIWzTOo2kO2HDhHbvWOjIIYUHR4Vh
 IddyYe1E68cbPnH4dfGeFMzgX/RJhF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMW2kIkGlNlvomuWVNaEOGKn6CSc3PqzYuE6PKoO57A=;
 b=O7fVxOTHOMpBK24vYnZ3t0T4l+NRuPgJ+1ogyyVXr3XjQ3V/smMq3E2tQmNGiaYDN78VUg
 nEOAlWGr2lg9JRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE628134B8;
 Tue, 13 Oct 2026 12:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:01:58 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-2-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1234;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=6hyOQJYf6mOLDfigA7j5ROMXGT+7ltnEUAlcXJiQN8Y=;
 b=39Xcel1BLIb4aMXstYqAOPB4wPHvveXSFz0HvvLxEce0SODuDjpknS5S7dVnj1DqjFrARlqpa
 v7Q2Nx5TdTDBjIIgCVXOiaYhn+thrme2tdUwGOgGwAl7evohj5eiQmf
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3ABB621E7E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/15] ujson: writer: Fix OOB read on invalid UTF-8
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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
