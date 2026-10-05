Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A058CA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:29:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E008C3E53C6
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:29:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D1563E527B
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 712A914001FD
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBC011F7DD;
 Mon,  5 Oct 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGEA4SGkwsHdzEu5isiZeVTi/KaxVnOXw3XwcwTJw9I=;
 b=BVX1QxtGHYmnKIetG63bTnL0PtcG/jikFTXvWvNSbazh1KUqrAf4nBoPA/V76sssldu1ch
 +sdru8ED4JN45G6FXjhu644xLEQCZycLSxJf3iK3504GUZjqHXDmKckcMg5i5zDjIBOkXv
 16HKUKxcwIYSayfaXvHfE5iLFz07o2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGEA4SGkwsHdzEu5isiZeVTi/KaxVnOXw3XwcwTJw9I=;
 b=skgLTqvJ7mZVoK3klLmi6gVRrxuMa/UR3hR4hV8l/GAC+PxZrEbYgRlJeEi8g5F2jYbFoh
 Ls474fNCm96s/KBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OJNHBnZH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3ZTxByfj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGEA4SGkwsHdzEu5isiZeVTi/KaxVnOXw3XwcwTJw9I=;
 b=OJNHBnZHO8NHl6N3LQhMyPNsHfzQtSZ3jOhoq+9LUBclLgycqr6HIF4FENnUqieDG/oXZl
 20YzZQApN1TchSWnNRWPPMR+o7l3FsNoVTy3Dsk8cxyAeWxgrwIQubN4gv96lLxlwFl+3P
 UBa53ix8HgqsyA0x/xxT3i+xFcIhstc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGEA4SGkwsHdzEu5isiZeVTi/KaxVnOXw3XwcwTJw9I=;
 b=3ZTxByfj/UAURm4RYiU6PcSK3dqPyV7hweTqm50CVImesNJdDMtgKZ7M/+PeHOsdTj5hDx
 QFY0Acai0dnL2zCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E7813AF2;
 Mon,  5 Oct 2026 13:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T11
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:38 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-10-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1535;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=iDyM8MKtCHRci/MS0GdIQf3oSdVgQXF9t8GGtpsfU/8=;
 b=uXlemNV/i7XNtFFEQd2OeSAklK8A6OwmVpNJyCGsvKLzeNeAvmonICQ+2OjI4SOY7rKM8OGUZ
 JozabZ1b5SFCBaiXisWfeomLQH3ejQ+C7vszPhwMDahBmdr2sQlhI7Z
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EBC011F7DD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.961]; MIME_GOOD(-0.10)[text/plain];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/15] ujson: reader: Parse escape sequences in object
 IDs
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

copy_id_str() copied characters verbatim without handling escape
sequences, which caused escaped quotes \" to prematurely terminate
the key and left other escape sequences such as \uXXXX unparsed.
Reuse copy_str() to parse object ID strings with full escape support.

As a side effect, too long and unterminated IDs now report the generic
copy_str() errors ("String buffer too short!", "Unterminated string")
instead of the ID-specific ones.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index b73a31b8f..f4335407a 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -256,32 +256,14 @@ static int copy_str(ujson_reader *buf, char *str, size_t len)
 
 static int copy_id_str(ujson_reader *buf, char *str, size_t len)
 {
-	size_t pos = 0;
-
 	if (eatws(buf))
 		goto err0;
 
-	if (!eatb(buf, '"'))
+	if (peekb(buf) != '"')
 		goto err0;
 
-	for (;;) {
-		if (buf_empty(buf)) {
-			ujson_err(buf, "Unterminated ID string");
-			return 1;
-		}
-
-		if (eatb(buf, '"')) {
-			str[pos] = 0;
-			break;
-		}
-
-		if (pos >= len-1) {
-			ujson_err(buf, "ID string too long");
-			return 1;
-		}
-
-		str[pos++] = getb(buf);
-	}
+	if (copy_str(buf, str, len))
+		return 1;
 
 	if (eatws(buf))
 		goto err1;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
