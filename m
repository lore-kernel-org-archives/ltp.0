Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F62CA9ED2
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:03:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AAC13EA829
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:03:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2A233EA818
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0DB4560080A
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFF511F788;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFqXaOE+gQusroHOvXxIH0wWXvPh95dnenIqMMfRbAs=;
 b=s69TwCWLtg7dBh1p4GwCRXKpLgGqANYIYdna70ctZ0CakgLu6mw5IBVX0/C0gnOvbY+UGU
 jYdOPnVLZhc/abda4j53zF/fJZXF1OIlJERPDeW08FHACdSkKr7aSrEAWUOwsgsZMJhl6W
 gi5vu1G5RtWYV9UVvkMGsjyK1w+txNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFqXaOE+gQusroHOvXxIH0wWXvPh95dnenIqMMfRbAs=;
 b=Lma2aXWuCmjZto5VsCo04/CS2EFNZePq2Oj0kwHQjlmM0ZOnYGzziGAINtovywJlzKdWhk
 Y4gs9XaV/fWghhCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s69TwCWL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Lma2aXWu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFqXaOE+gQusroHOvXxIH0wWXvPh95dnenIqMMfRbAs=;
 b=s69TwCWLtg7dBh1p4GwCRXKpLgGqANYIYdna70ctZ0CakgLu6mw5IBVX0/C0gnOvbY+UGU
 jYdOPnVLZhc/abda4j53zF/fJZXF1OIlJERPDeW08FHACdSkKr7aSrEAWUOwsgsZMJhl6W
 gi5vu1G5RtWYV9UVvkMGsjyK1w+txNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFqXaOE+gQusroHOvXxIH0wWXvPh95dnenIqMMfRbAs=;
 b=Lma2aXWuCmjZto5VsCo04/CS2EFNZePq2Oj0kwHQjlmM0ZOnYGzziGAINtovywJlzKdWhk
 Y4gs9XaV/fWghhCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D93F13503;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T16
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:11 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-15-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1518;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=u/smh43ym2iLR/pq9S2Ctz3myosQOYHXunPyAO1kVr4=;
 b=3AP45x6LvwENAFW/lrcKwWR38EFjpmRXCDp8lr+VPtG2DUDiVBabyN+xM4USwgsx2zNngunXc
 JuooGnRJ7lxCZZiv2zXWqg1DAQdH/R0ck6oMCAHUAZ4wAK/6BAuBK5Z
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DFF511F788
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 15/15] ujson: writer: Flush buffer before direct
 writes
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
 libs/ujson/ujson_writer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index ac21ab442..7874735a1 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -402,6 +402,9 @@ struct json_writer_file {
 
 static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ssize_t buf_len)
 {
+	if (!buf_len)
+		return 0;
+
 	do {
 		ssize_t ret = write(fd, buf, buf_len);
 		if (ret < 0) {
@@ -434,8 +437,15 @@ static int out_writer_file(ujson_writer *self, const char *buf, size_t buf_len)
 	size_t buf_size = sizeof(writer_file->buf);
 	size_t buf_avail = buf_size - writer_file->buf_used;
 
-	if (buf_len > buf_size/4)
+	if (buf_len > buf_size / 4) {
+		if (out_writer_file_write(self, writer_file->fd,
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
