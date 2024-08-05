Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A3C3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 13:46:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 902DC3D1FD5
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 15:46:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F8563D1A32
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 15:46:26 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD25C600693
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 15:46:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8877D21B85;
 Mon,  5 Aug 2024 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722865584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yH3rinS2GZNDhICgj0iYSbgFSlAh7nEwJcxJ8tjye70=;
 b=Os+wDHPFNkQ3e8Onko+KNJOLsa5GxHzEqPKq1dcs8kR+F/68uxsGYPC9bCsjhim85R2Jnl
 XKW49800x6leh7kQfnpkv2w/UmYqsYQ6KB1ByFadiNPChD7cCj/GrrGY4hLSpnt7dQUSyz
 TgistuDj8QxsCSeu1kbqL5vNnBMlLXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722865584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yH3rinS2GZNDhICgj0iYSbgFSlAh7nEwJcxJ8tjye70=;
 b=T1IRlHGsIoibFsHP7WFnfu5WxIOIdPhSndRdb8pCfsrdPD05SVdv9RTNKDVfivc94fBIDf
 ChOhgiC9peW1WpAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722865584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yH3rinS2GZNDhICgj0iYSbgFSlAh7nEwJcxJ8tjye70=;
 b=Os+wDHPFNkQ3e8Onko+KNJOLsa5GxHzEqPKq1dcs8kR+F/68uxsGYPC9bCsjhim85R2Jnl
 XKW49800x6leh7kQfnpkv2w/UmYqsYQ6KB1ByFadiNPChD7cCj/GrrGY4hLSpnt7dQUSyz
 TgistuDj8QxsCSeu1kbqL5vNnBMlLXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722865584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yH3rinS2GZNDhICgj0iYSbgFSlAh7nEwJcxJ8tjye70=;
 b=T1IRlHGsIoibFsHP7WFnfu5WxIOIdPhSndRdb8pCfsrdPD05SVdv9RTNKDVfivc94fBIDf
 ChOhgiC9peW1WpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D10813254;
 Mon,  5 Aug 2024 13:46:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gv3wFLDXsGZWPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Aug 2024 13:46:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 Aug 2024 15:46:17 +0200
Message-ID: <20240805134618.41203-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [0.21 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.19)[-0.964]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lapi/stat.h: Handle invalid __NR_fchmodat2
 syscall return value
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

Only 0 and -1 are valid for __NR_fchmodat2. Reporting invalid return
value is current approach for LTP safe macros.

While at it, unify the error message with safe macros.

Fixes: 49e1c012d3 ("Add fchmodat2 fallback definition")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/stat.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 8e38ecfef1..030646a9e3 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -238,9 +238,15 @@ static inline int safe_fchmodat2(const char *file, const int lineno,
 	int ret;
 
 	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
-	if (ret == -1)
-		tst_brk_(file, lineno, TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
-			__func__, dfd, filename, mode, flags);
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "syscall(__NR_fchmodat2,%d,%s,%d,%d) failed",
+			 dfd, filename, mode, flags);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "Invalid syscall(__NR_fchmodat2,%d,%s,%d,%d) return value %d",
+			 dfd, filename, mode, flags, ret);
+	}
 
 	return ret;
 }
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
