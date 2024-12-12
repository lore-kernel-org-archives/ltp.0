Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7288FE7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 13:30:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 577093E98C5
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 14:30:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AAA33E2B67
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 14:30:38 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98754668EDE
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 14:30:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 688F01F37C;
 Thu, 12 Dec 2024 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734010236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hCaaqGMYf8XvRrIoSZFhhVc+xrC0TxhWoXCFPz8fyek=;
 b=3c+6qGj+/wbMj/G4h2Xib9igCPQkkfcJoUdHbAOI8JKStaEAGCvxhY/N+QxTYBpzaGtAwV
 UCE7UzTvgzdI+h9YDuMBFJnPJS9tZCrF49LGpzDN+G39tau7SUlAnlqFkhWGKYj9GNdfmj
 Dy3mmEA4znvkz4FE8q9dU5GW5tfTN+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734010236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hCaaqGMYf8XvRrIoSZFhhVc+xrC0TxhWoXCFPz8fyek=;
 b=+3ACY88AcyBmrXIRJktRFm4uEn08Hp9eUUr36Fu8m/ThpdBp84gy0969maW7WcY00ZxwQe
 j2+vbI2DuBi1AWAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3c+6qGj+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+3ACY88A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734010236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hCaaqGMYf8XvRrIoSZFhhVc+xrC0TxhWoXCFPz8fyek=;
 b=3c+6qGj+/wbMj/G4h2Xib9igCPQkkfcJoUdHbAOI8JKStaEAGCvxhY/N+QxTYBpzaGtAwV
 UCE7UzTvgzdI+h9YDuMBFJnPJS9tZCrF49LGpzDN+G39tau7SUlAnlqFkhWGKYj9GNdfmj
 Dy3mmEA4znvkz4FE8q9dU5GW5tfTN+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734010236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hCaaqGMYf8XvRrIoSZFhhVc+xrC0TxhWoXCFPz8fyek=;
 b=+3ACY88AcyBmrXIRJktRFm4uEn08Hp9eUUr36Fu8m/ThpdBp84gy0969maW7WcY00ZxwQe
 j2+vbI2DuBi1AWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C18113508;
 Thu, 12 Dec 2024 13:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gLsmFnzlWmfeXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 12 Dec 2024 13:30:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 Dec 2024 14:30:24 +0100
Message-ID: <20241212133024.1480177-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 688F01F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] doc: Update blacklist and whitelist
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

getmsg, getpmsg, putmsg, putpmsg in man UNIMPLEMENTED(2),
put them to blacklist. This way they aren't shown in "Untested syscalls"
table, which is supposed to be only or syscalls which should be tested.

Fixes: 7248e5c5f7 ("doc: update syscalls statistics")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Rebased patch to the Andreas patchset
https://patchwork.ozlabs.org/project/ltp/list/?series=436387&state=*
(originally in v1 it was moved from whitelist)

Kind regards,
Petr

 doc/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index 258a1b9e28..514bba05a5 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -103,8 +103,12 @@ def generate_syscalls_stats(_):
         'cachectl',
         'create_module',
         'get_kernel_syms',
+        'getmsg',
+        'getpmsg',
         'mq_getsetattr',
         'nfsservctl',
+        'putmsg',
+        'putpmsg',
         'query_module',
         'reserved177',
         'reserved193',
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
