Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2083C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 16:02:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3927B3C4B5C
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 17:02:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DAAC3C302F
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 17:01:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5D14B62226F
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 17:01:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 949BE218F9;
 Wed, 19 Feb 2025 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739980908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cwg/ebF/qQTa/FiXmp0sSP8r2JXA28iNOc1cKtonhmI=;
 b=Kh0j1T1T4O3lzU983RO9cvlp48bP9+G8eKTd6wXrhxy6d7qcqqfi23I8bigY3Fd4aFnfxC
 zB27ExZujB3dDqh/PjD6AJqUxTMabzihKa6MDWQVbp1WCd7UPcNNjomTiUd8g+1xDlyGLA
 OxuAkfujAXya8bMzXZHBNyeORKIIE2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739980908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cwg/ebF/qQTa/FiXmp0sSP8r2JXA28iNOc1cKtonhmI=;
 b=WaQlay1q8pmDdJwoIfqrE6uo/tUKcWe/taZdNfJUTE8rxraWXP59PXtHLY+61NnD4PdQTJ
 HRia7t2NGwE111Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Kh0j1T1T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WaQlay1q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739980908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cwg/ebF/qQTa/FiXmp0sSP8r2JXA28iNOc1cKtonhmI=;
 b=Kh0j1T1T4O3lzU983RO9cvlp48bP9+G8eKTd6wXrhxy6d7qcqqfi23I8bigY3Fd4aFnfxC
 zB27ExZujB3dDqh/PjD6AJqUxTMabzihKa6MDWQVbp1WCd7UPcNNjomTiUd8g+1xDlyGLA
 OxuAkfujAXya8bMzXZHBNyeORKIIE2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739980908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cwg/ebF/qQTa/FiXmp0sSP8r2JXA28iNOc1cKtonhmI=;
 b=WaQlay1q8pmDdJwoIfqrE6uo/tUKcWe/taZdNfJUTE8rxraWXP59PXtHLY+61NnD4PdQTJ
 HRia7t2NGwE111Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23BEC13715;
 Wed, 19 Feb 2025 16:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QAoJBGwAtmdoPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Feb 2025 16:01:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 17:01:43 +0100
Message-ID: <20250219160143.2589026-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 949BE218F9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Link struct tst_test and tst_tag
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

Although it's currently impossible to link to tst_test members,
it's still useful to make links to allow user to read the actual code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index 2be847d90b..8cc890fcc8 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -286,7 +286,7 @@ def _generate_tags_table(tags):
             tag_val = f'`{tag_val} <{tag_url}{tag_val}>`_'
 
         table.extend([
-            f'   * - {tag_key}',
+            f'   * - :c:struct:`{tag_key} <tst_tag>`',
             f'     - {tag_val}',
         ])
 
@@ -331,6 +331,7 @@ def _generate_table_cell(key, values):
     Generate a cell which can be multiline if value is a list.
     """
     cell = []
+    key = f' :c:struct:`{key} <tst_test>`'
 
     if len(values) > 1:
         cell.extend([
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
