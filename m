Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB388CA5FF0
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 13:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB99F3E4A65
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 15:03:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA5833E4A0E
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 729EE20076A
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 15:02:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D26BA21FF4;
 Tue,  6 Oct 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+tFDGzWfWDJbMxmlv86SJSv5G2QwZZP6tHz8YwwOlY=;
 b=v1zqtAMCclv63jpAj9pxifm9qn08yBGYVBiB0c+e+qNclD5aBxW1d6AiS5XaBhx2xGYDit
 Nqrrf3m8JTTdXvVPayHzOjWSTNCvZfSBqiOD0o+tnjS4H2AEd04SI1nmj4QhzyeqHS6Bls
 nUFqAaM3dC+/S9WKxzHLL38BrnNJ1Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+tFDGzWfWDJbMxmlv86SJSv5G2QwZZP6tHz8YwwOlY=;
 b=LSv68D3HvKHNXikQk84lDdnkBVOwWhYdtoIdSnEu8YoX+jzTJK9uLEPwYWdLHwBIF1Ac6T
 eFNEgvOCywzZ+SDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IKWNJKHQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1CMrek+X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791291759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+tFDGzWfWDJbMxmlv86SJSv5G2QwZZP6tHz8YwwOlY=;
 b=IKWNJKHQl3ftUG4IFxYGNoJcN1rlu47URxpJyg05pdwsvlD/u17lFYwIv8h+I6K5rz3DH7
 NCT4bsPzhF6IyZVJ38HjklK89mOWl3gnQJMgL8Xrf2wQoT7DB8/RjsIXVETGqGwCSKZGQD
 0pUDVuGXfHlJ9umgHNjn1IvMm6OPKCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791291759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+tFDGzWfWDJbMxmlv86SJSv5G2QwZZP6tHz8YwwOlY=;
 b=1CMrek+XJpbnBnkRpjv3CE6F6AwKq7XsVz2Ep3fIWkz/I2KcyDcky6/TIgArK+mRJC2Rpo
 nMxjcDBvQjgA40CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70F5513C7C;
 Tue,  6 Oct 2026 13:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGTTAG/xxGqLRQAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Tue, 06 Oct 2026 13:02:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 06 Oct 2026 15:02:38 +0200
MIME-Version: 1.0
Message-Id: <20261006-fix_simple_bugs_core_lib-v1-2-c94199a46ec5@suse.com>
References: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
In-Reply-To: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791291759; l=995;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xwd754JZHSNtHbqw/g3WPh7HvGgUrwQ7kEg8+9LVqY4=;
 b=w16xS+gBor4J4z1VNp/h/newJXKTtrwGOKmGb+sH7zhXWV1p0LZ60LxPtpCmmII6TSoKsWEf+
 SYtfch/PDycDXg3j/sWy2dz8oKaRYpn3xOrfLocSy5HU0FQsTx9Vhyb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D26BA21FF4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] tst_memutils: Fix mapping overlap predicate
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

tst_mapping_in_range() checks whether either mapping endpoint falls
inside [low, high). This misses existing mappings that completely
enclose the requested range, and falsely treats an adjacent mapping
ending exactly at low as an overlap.

Use the standard half-open interval overlap check
(start < high && end > low).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_memutils.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index e49684ba1..81467fef7 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -202,11 +202,7 @@ int tst_mapping_in_range(unsigned long low, unsigned long high)
 			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/self/maps line.");
 		}
 
-		if ((start >= low) && (start < high)) {
-			fclose(fp);
-			return 1;
-		}
-		if ((end >= low) && (end < high)) {
+		if (start < high && end > low) {
 			fclose(fp);
 			return 1;
 		}

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
