Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFCEC02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 21:03:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1451E3C8F80
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 22:02:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A22003C6F70
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 22:02:41 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F0AC11BD7DBC
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 22:02:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7F3E1F381;
 Mon,  3 Feb 2025 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738616557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
 b=KwBOLN4zPfkBTD8wnGTE+DNlEI8LzHYPsvUnVLW0PBeUT8gPWJEUAla84gkmvZgVyfVIO+
 nLMTvNzNnxl2g0TaBcj7k4WXucl4+o+pVcS7Ar5hUEWN1phWhJvyFxZkN8IXbJuPOL731y
 TzkJTbl6qZWmOFcOKty6Dla9S033A/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738616557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
 b=JjF1T9uW14iLbkYTaPlUonguQ0RKXOaw/4p070szSyU7/q/YYT+Wcukr+piwzFSYXOFi4c
 ZFwh1tQH8gYv1HAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KwBOLN4z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JjF1T9uW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738616557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
 b=KwBOLN4zPfkBTD8wnGTE+DNlEI8LzHYPsvUnVLW0PBeUT8gPWJEUAla84gkmvZgVyfVIO+
 nLMTvNzNnxl2g0TaBcj7k4WXucl4+o+pVcS7Ar5hUEWN1phWhJvyFxZkN8IXbJuPOL731y
 TzkJTbl6qZWmOFcOKty6Dla9S033A/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738616557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
 b=JjF1T9uW14iLbkYTaPlUonguQ0RKXOaw/4p070szSyU7/q/YYT+Wcukr+piwzFSYXOFi4c
 ZFwh1tQH8gYv1HAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4173913A78;
 Mon,  3 Feb 2025 21:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VA4HC+0uoWfXMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Feb 2025 21:02:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  3 Feb 2025 22:02:33 +0100
Message-ID: <20250203210233.1407530-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: A7F3E1F381
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] IMA: measure.policy: limit dont_measure tmpfs policy
 to func=FILE_CHECK
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

add func=FILE_CHECK to dont_measure tmpfs

Similarly to tcb.policy limit dont_measure tmpfs policy to func=FILE_CHECK.
This allows to do extra measurements, e.g. kexec boot command line, see
kernel commit

7eef7c8bac9a ("ima: limit the builtin 'tcb' dont_measure tmpfs policy rule")

Also remove leading 0 from tmpfs magic (to match IMA docs and tcb.policy).

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/datafiles/ima_policy/measure.policy  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
index 9976ddf2de..8abd05fb1a 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
@@ -8,7 +8,7 @@ dont_measure fsmagic=0x62656572
 # DEBUGFS_MAGIC
 dont_measure fsmagic=0x64626720
 # TMPFS_MAGIC
-dont_measure fsmagic=0x01021994
+dont_measure fsmagic=0x1021994 func=FILE_CHECK
 # SECURITYFS_MAGIC
 dont_measure fsmagic=0x73636673
 measure func=FILE_MMAP mask=MAY_EXEC
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
