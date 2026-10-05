Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A13CCA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:30:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C11F83E53C6
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:30:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F5B13E6B3B
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:26:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF8D8600750
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:26:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 02A401F7AF;
 Mon,  5 Oct 2026 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl8/BkWx83miqWA9N84v/2RMWn9yRuThRwAfxn9DIjA=;
 b=HJYZ50LoRVYJiOtNgECWs32/kc+Owj0W4lCxJkEOA2SE9VjvMitGvGQDZiy9C4vCnszQW1
 PFjx1DNTNd7X9eOIK/3P6jKbAeHLwL35dTjF2jsh8r7NXsXTdALB++72dz50gudzVR2+sQ
 mv4TyYkhCs6br9EHvT2TOL666EihdKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl8/BkWx83miqWA9N84v/2RMWn9yRuThRwAfxn9DIjA=;
 b=IuPRacc74efCrNBUZgWbCTN8nxzaTn3xIvWfzcAVmO2Z0rNQy5cjMUdgTcuNWFEUOAK8zw
 z/XktdKEpLLLjWCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=biA5MCwy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gT+nQmzb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl8/BkWx83miqWA9N84v/2RMWn9yRuThRwAfxn9DIjA=;
 b=biA5MCwy3+3WBqiIYmGyFuymrJj/d5SQ6WJPQs509mwutRlWvHeVix4DXQJBZecZ1+DUOC
 C0sUhT9eKYvzjOj2aFZYy+36DMotnU4ocEgGyhCKGI4jDNxPWxtYyjrj4RqnI4aVKzyRZw
 DMtQSTW2up4427D22NcMBqRWMknn8bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zl8/BkWx83miqWA9N84v/2RMWn9yRuThRwAfxn9DIjA=;
 b=gT+nQmzbKUOLy3oHmGyTeCosRb4c1HuAswMNmny5QdqzwV+Qll1t/Tg7iAymcfczsJk3pt
 0InopnWFgvKKcMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA6F413AF7;
 Mon,  5 Oct 2026 13:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T16
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:43 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-15-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1293;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=qfY4V/s5SZrkuLLu+Gd/wz/+HzI/ea+zSfd9GHCR9T4=;
 b=upSoiEnGrb1k8ovSrZlu51eKSbUumQ+ypdHk5PYd2sUXlbusjmh+wjxSqWF9If19wNJ6l0WnA
 qwoQJnyljH/BFZwGof7sWrdO1zT/LZsQGOiae6gAVxL0T+KWzY/7kHK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 02A401F7AF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.963]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 15/15] ujson: writer: Flush buffer before direct writes
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

out_writer_file() writes chunks larger than a quarter of its buffer
directly to the file, bypassing data still sitting in the buffer. Any
string longer than 256 bytes was therefore written before the preceding
output, producing corrupted JSON. Flush the buffer first.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index 2553d8cd2..df67b1f4d 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -424,8 +424,16 @@ static int out_writer_file(ujson_writer *self, const char *buf, size_t buf_len)
 	size_t buf_size = sizeof(writer_file->buf);
 	size_t buf_avail = buf_size - writer_file->buf_used;
 
-	if (buf_len > buf_size/4)
+	if (buf_len > buf_size / 4) {
+		if (writer_file->buf_used &&
+		    out_writer_file_write(self, writer_file->fd,
+					  writer_file->buf, writer_file->buf_used))
+			return 1;
+
+		writer_file->buf_used = 0;
+
 		return out_writer_file_write(self, writer_file->fd, buf, buf_len);
+	}
 
 	if (buf_len >= buf_avail) {
 		if (out_writer_file_write(self, writer_file->fd,

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
