Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73609CA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:27:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1EDF3E4E11
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:27:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79EB93E52CF
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3FE3F10001F1
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:25:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A1481F7DC;
 Mon,  5 Oct 2026 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcY+fvg03jrvLrmFPuoOnz9Oyxr6RmVk0mtebBXpjAo=;
 b=rFAo37te+HH+iwlCjEjLya3VSJoPxx8cfBJeGMjpG41WDdSeAdStUabHqrWysIFdWFR+lU
 /wEgoYvb7qduTSt/9DFG3ePxS9YLjothBzIi4fkhTeBmDW1ZxFu+6id8O7Q22BWzov8JHq
 aWw3tHSLtQICd+nsqGkm0ZFYy3W9Vak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcY+fvg03jrvLrmFPuoOnz9Oyxr6RmVk0mtebBXpjAo=;
 b=fkthO4fDgIn9SJTyPAzPnh/IjzrwAYbP6aEIO2tcE265GfPTwguyp9qwxm07mXES7CbuWl
 b6fecnz3BsRtJhCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791206743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcY+fvg03jrvLrmFPuoOnz9Oyxr6RmVk0mtebBXpjAo=;
 b=lGE0zG/0+3dAkQQU8tR/vo1899fFbEdA9COFVqg2FahB5tx0GMmW89uTD4XbagnxacstiJ
 yQ1qXuV4Rtwv/C5LHVsGf7/tPevtqE49Iqdc0AmDsTN6ab3WCwh8lHbwcpIf6/fCQSj5K/
 rQqTOj3aNoR4gSjrucpr3WdEyj1aKnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791206743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcY+fvg03jrvLrmFPuoOnz9Oyxr6RmVk0mtebBXpjAo=;
 b=736QzoVU0ue5BWPIu7pCtfWJA/moaK5KOtE/jpBkIk6FPbkbhwPSSTWj3pvgC67QLBZ31P
 vKd7q+3XCXHiixCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C15E13AEE;
 Mon,  5 Oct 2026 13:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q4tkH06lw2oibAAAD6G6ig:T7
 (envelope-from <andrea.cervesato@suse.de>); Mon, 05 Oct 2026 13:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 05 Oct 2026 15:25:34 +0200
MIME-Version: 1.0
Message-Id: <20261005-fix_core_lib_deepseek-v1-6-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206734; l=1729;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=2VztXnG+7wuRrNIZYdWaqnkzQe4dxcYxqcx50SP1Wz8=;
 b=qn7OLuq4g8c/eRT6o6YbHtCnWIrbtfa1/ocPzDx1t/pROjjXJWA8W2iU2gAD2Ged2Zh6oHw22
 7ah/QAMO37wD+ToH7EMeRRm291+9AzHn1PF9YZW+MjDT5qKNWj4JesN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.11)[-0.549]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/15] ujson: reader: Check for signed integer overflow
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
index 0975ca1a1..272df4d55 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <stdint.h>
+#include <limits.h>
 
 #include "ujson_utf.h"
 #include "ujson_reader.h"
@@ -309,7 +310,7 @@ static int is_digit(char b)
 
 static int get_int(ujson_reader *buf, struct ujson_val *res)
 {
-	long val = 0;
+	unsigned long val = 0;
 	int sign = 1;
 
 	if (eatb(buf, '-')) {
@@ -325,17 +326,25 @@ static int get_int(ujson_reader *buf, struct ujson_val *res)
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
+		res->val_int = (long)(0UL - val);
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
