Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2EDCA9ED2
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:04:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0714B3EA822
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:04:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840423EA825
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 08D41200967
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6407821F3C;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lpu78uR7Fy3qQctVOHbEASRMmCLh9ZC3bTXPGarI1e8=;
 b=yGSDzBHuXougX/bjSK0nkPje4e3Yd6ywRxHvsgP2kCOTpCCnhANBzQm9ThkYXFOxXa6Gsd
 tQl1x7ym6WFHg2te1cI3wGrWUN1WlQsxKDilaShbhWWPww3PSB5vNEmjg6qYn3AtZybGMP
 8pCnW0jMW7jgRmlKi1kpo2+nQ9B8fYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lpu78uR7Fy3qQctVOHbEASRMmCLh9ZC3bTXPGarI1e8=;
 b=w2ocj22fqZVNfgwTKkUF9+8PGz61UI9bLfNkS7hsN2Oonv00H0ka+rsZRkhsNBC/vTWR1j
 mwlOdo+XAQvf7rDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yGSDzBHu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w2ocj22f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lpu78uR7Fy3qQctVOHbEASRMmCLh9ZC3bTXPGarI1e8=;
 b=yGSDzBHuXougX/bjSK0nkPje4e3Yd6ywRxHvsgP2kCOTpCCnhANBzQm9ThkYXFOxXa6Gsd
 tQl1x7ym6WFHg2te1cI3wGrWUN1WlQsxKDilaShbhWWPww3PSB5vNEmjg6qYn3AtZybGMP
 8pCnW0jMW7jgRmlKi1kpo2+nQ9B8fYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lpu78uR7Fy3qQctVOHbEASRMmCLh9ZC3bTXPGarI1e8=;
 b=w2ocj22fqZVNfgwTKkUF9+8PGz61UI9bLfNkS7hsN2Oonv00H0ka+rsZRkhsNBC/vTWR1j
 mwlOdo+XAQvf7rDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DD5313515;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T8
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:03 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-7-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1722;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=sCwu5a9bQ3s2uDtubo4/75R3PhNkICGZxWX++kxRjjk=;
 b=EqejPAsnkhBzcHgvRRmS5+WnI0HKkRnHKPLubiGlEHCiQnvN51ClitRRIf34tLdoIurSFngzu
 wfQBMv4WnH2Cwvwas2S7LU6zxHh1SyZP7JimVutKoYxO9GGCLuCZzEM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6407821F3C
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
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/15] ujson: reader: Check for signed integer
 overflow
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

In get_int(), integers longer than LONG_MAX overflow long during
multiplication and addition, resulting in undefined behavior.
Accumulate the value in unsigned long, check against LONG_MAX or
LONG_MIN limits on each digit, and report an error on overflow.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_reader.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 7bf5b91f2..890d07b35 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <stdint.h>
+#include <limits.h>
 
 #include "ujson_utf.h"
 #include "ujson_reader.h"
@@ -311,7 +312,7 @@ static int is_digit(char b)
 
 static int get_int(ujson_reader *buf, struct ujson_val *res)
 {
-	long val = 0;
+	unsigned long val = 0;
 	int sign = 1;
 
 	if (eatb(buf, '-')) {
@@ -327,17 +328,25 @@ static int get_int(ujson_reader *buf, struct ujson_val *res)
 		return 1;
 	}
 
+	unsigned long max = (sign < 0) ? (unsigned long)LONG_MAX + 1UL : (unsigned long)LONG_MAX;
+
 	while (is_digit(peekb(buf))) {
-		val *= 10;
-		val += getb(buf) - '0';
-		//TODO: overflow?
+		unsigned int d = getb(buf) - '0';
+
+		if (val > (max - d) / 10) {
+			ujson_err(buf, "Integer overflow");
+			return 1;
+		}
+
+		val = val * 10 + d;
 	}
 
 	if (sign < 0)
-		val = -val;
+		res->val_int = -(long)val;
+	else
+		res->val_int = (long)val;
 
-	res->val_int = val;
-	res->val_float = val;
+	res->val_float = res->val_int;
 
 	return 0;
 }

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
