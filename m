Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F311BCA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:26:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D74233E6B3D
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A1243DD461
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF38C20006B
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 554DF1F7C5;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gy+pqQGFItPCJKgDKaRA8zP2riPpt39B9KqGBlIU8yM=;
 b=JHwmulOCo85tUqEredHATxU72n/TbWlrn4An6GiuDWnr+9D9scxLXOkUNl4HDKHuzQarmP
 bjLG/bhvgdNCPTAzgPDbFZuBIztQPlkybz3gxAryM9mPjv4ioVVxyCVad7Bb2H9DperyXv
 y7bunc3sLkKDKK57L3/dUctqI/tylLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gy+pqQGFItPCJKgDKaRA8zP2riPpt39B9KqGBlIU8yM=;
 b=ayZQJELdrEELZJRBKJBIrJzwFmKdxeY7102UXd8lkTK9Fs/h/cYhRy+fXsPr9vDwebrT6v
 9nx/JofTdwJQlQAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AJqjXQK1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4h8B7/tL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gy+pqQGFItPCJKgDKaRA8zP2riPpt39B9KqGBlIU8yM=;
 b=AJqjXQK1uMs6g+GHROzHzAxHj/k9UgabmMxaG5WL9bGXb7Y07SDfsx7DbbrVkaZwuQXVjs
 RYYlYC6fNmixR4Ryxo+Zs+Z1JdghgIuuYguaGxORDJjZyKoZ9KvyhfakrhDxjBE5ME/0JO
 PYdoKXxAlkVV0NAFsNeeKHzZ6xPbl8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gy+pqQGFItPCJKgDKaRA8zP2riPpt39B9KqGBlIU8yM=;
 b=4h8B7/tLOFNmsoiB6ntOP+kiomH1Cia9DUlHuZqgfF5BshWn60+iK66//bn8VO9LUzsF5l
 ZPe+lZhyR9zVb8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A56113AEB;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T4
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:31 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-3-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=868;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=jh6wSG+Wwul3T3Tz1Y7PqN2CdAXFiaP8s/Puocyb/gY=;
 b=ROIZsx1EC86O/FGkkcuA/U6ipOFJUg2Sr3yDkLEDJXROywa8JTtDP2WWaRzcGnmE3Hmjuc3eD
 pTsVhIJMR1TDmI4Y3YBY8UDeLkVbI4bbFciXWGSDq+15XCqL+v/P1pr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 554DF1F7C5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.962]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/15] ujson: reader: Prevent infinite loop on EOF
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

When read() returns 0 before reaching the size reported by lseek()
(e.g. sysfs files or truncated files), off does not advance and the
loop spins indefinitely. Treat read() == 0 as EOF by breaking the loop
and updating the buffer length and terminator.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 9f86f25b7..2219c5801 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -1032,9 +1032,15 @@ ujson_reader *ujson_reader_load(const char *path)
 			goto err1;
 		}
 
+		if (res == 0)
+			break;
+
 		off += res;
 	}
 
+	ret->buf[off] = 0;
+	ret->len = off;
+
 	close(fd);
 
 	return ret;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
