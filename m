Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EC2C02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:16:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0A383C9C5D
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:16:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 559A93C91B5
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:15:58 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8618E102B137
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:15:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36F1E1F399;
 Tue, 18 Feb 2025 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739880956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+U0EFWl9OBtZFm/MY/S6lZ8/Rtat+VmNl6OwetoJAM=;
 b=f1CNYC/EI+CUZHkFxQaJJXWZwZkjS8SB+ylmcrjAuLRyszfzDGvepgCw7F/1w5lRgdibDh
 Uudq7BNU+07GvXD/dSodrIpY7upI2ji04E8Suyk0T6dGrppbJQhXJqgP36r4VF02RhBs5n
 86/O2oFEg7tdqcBsNGB/6tr1pbBjUW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739880956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+U0EFWl9OBtZFm/MY/S6lZ8/Rtat+VmNl6OwetoJAM=;
 b=FgHArIueMmtALzxbUy7M6BOr2X3y/NIOVZHB18ve84RJpmB/RlaGhGDdPPzshzhmYfQryW
 GrBn24us/cc/V3AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="f1CNYC/E";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FgHArIue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739880956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+U0EFWl9OBtZFm/MY/S6lZ8/Rtat+VmNl6OwetoJAM=;
 b=f1CNYC/EI+CUZHkFxQaJJXWZwZkjS8SB+ylmcrjAuLRyszfzDGvepgCw7F/1w5lRgdibDh
 Uudq7BNU+07GvXD/dSodrIpY7upI2ji04E8Suyk0T6dGrppbJQhXJqgP36r4VF02RhBs5n
 86/O2oFEg7tdqcBsNGB/6tr1pbBjUW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739880956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c+U0EFWl9OBtZFm/MY/S6lZ8/Rtat+VmNl6OwetoJAM=;
 b=FgHArIueMmtALzxbUy7M6BOr2X3y/NIOVZHB18ve84RJpmB/RlaGhGDdPPzshzhmYfQryW
 GrBn24us/cc/V3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0862E132C7;
 Tue, 18 Feb 2025 12:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADyIAPx5tGeJMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 12:15:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Feb 2025 13:15:53 +0100
Message-ID: <20250218121553.2470592-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 36F1E1F399
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc/conf.py: Replace all titles
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

This fixes titles like "[Race Description]".

Fixes: 1bf344a3db ("doc: add tests catalog page")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 03fcff67e8..e1d02d63e8 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -455,12 +455,8 @@ def generate_test_catalog(_):
         if desc:
             desc_text = []
             for line in desc:
-                if line.startswith("[Description]"):
-                    desc_text.append("**Description**")
-                elif line.startswith("[Algorithm]"):
-                    desc_text.append("**Algorithm**")
-                else:
-                    desc_text.append(line)
+                line = re.sub(r'^\[([A-Za-z][\w\W]+)\]', r'**\1**', line)
+                desc_text.append(line)
 
             text.extend([
                 '\n'.join(desc_text),
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
