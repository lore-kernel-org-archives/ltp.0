Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B7DCC6B08
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:05:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 234183EA82A
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:05:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 202BB3EA828
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C923200991
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D0FB01F74D;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbFltjbdIgkp8De+TOW21omLdhHjUOKg37j4wTyLlks=;
 b=B1z+6/R3vvvPdfFL0UlADSUWtw5z81nw/smSluUW7ufoqZwvRGHp2CR9eC6Z+BynI+WwVD
 0iJrZPnAVbxIAcfeHBsS/32gQHPFngitLcsto4UxJzt7tlbcKCCtagfLuXGiXl2EMfLswU
 hTQ24DUfhyPMV66lvmyeWtGp66AP1dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbFltjbdIgkp8De+TOW21omLdhHjUOKg37j4wTyLlks=;
 b=tu0cxZAGFzDRwEkE+P3c8qpQxzqFM8cyVSmeaUQ7HywJ6Kd+2n/hmVibnj6p8x6FGS/www
 kHkO+nc3tvvwMEAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="B1z+6/R3";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tu0cxZAG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbFltjbdIgkp8De+TOW21omLdhHjUOKg37j4wTyLlks=;
 b=B1z+6/R3vvvPdfFL0UlADSUWtw5z81nw/smSluUW7ufoqZwvRGHp2CR9eC6Z+BynI+WwVD
 0iJrZPnAVbxIAcfeHBsS/32gQHPFngitLcsto4UxJzt7tlbcKCCtagfLuXGiXl2EMfLswU
 hTQ24DUfhyPMV66lvmyeWtGp66AP1dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbFltjbdIgkp8De+TOW21omLdhHjUOKg37j4wTyLlks=;
 b=tu0cxZAGFzDRwEkE+P3c8qpQxzqFM8cyVSmeaUQ7HywJ6Kd+2n/hmVibnj6p8x6FGS/www
 kHkO+nc3tvvwMEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5446213341;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T14
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:09 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-13-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1203;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=TtX0VxAVHqCQKkyq9U0nJTnFNDk3tyq5lZOHblLFiK0=;
 b=i34y0oLHXSZvSuy0sKymTS/o9zXbmjg0GY2LZOC0PKwmZvOXuMZbgAddiUG4jWaJ+kaKuvGcZ
 EMsdLs4aTq/BG4NyVmm5ZFrfJ7UPYfbt2LjIyMyfCujmyRYGCIrstvg
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
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D0FB01F74D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/15] ujson: writer: Set errno when a flush fails
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

ujson_writer_file_close() uses errno to decide whether flushing the
buffered data failed. out_writer_file_write() can fail without setting
errno, when write() returns 0 or more bytes than requested, so close
could report success even though data was lost. Set errno to EAGAIN or
EIO in these cases.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index 7882a5ab5..eb446749f 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -404,13 +404,20 @@ static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ss
 {
 	do {
 		ssize_t ret = write(fd, buf, buf_len);
-		if (ret <= 0) {
+		if (ret < 0) {
 			err(self, "Failed to write to a file");
 			return 1;
 		}
 
+		if (ret == 0) {
+			err(self, "The write() syscall returned 0");
+			errno = EAGAIN;
+			return 1;
+		}
+
 		if (ret > buf_len) {
 			err(self, "Wrote more bytes than requested?!");
+			errno = EIO;
 			return 1;
 		}
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
