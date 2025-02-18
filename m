Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A9EC02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:35:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 781143C9C8E
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 14:35:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFD603C91B5
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:34:48 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0BB2D141D08E
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:34:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D45771F396;
 Tue, 18 Feb 2025 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739885686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=05OgedPfQZMpggpPnXuLMuvLHtbQ60ICzdOwmB57RW0=;
 b=Z60i5+smOWij+SqZVrnOgmeQcNpEJS1V9+vwJ+h9NK1MO2tMs5mi3CDcQ9PmiLJZps/l4j
 AFaALCVGrVsIBZjo5drJSdNarjfxa1GCNn0lVKpRb0oT1iNfMgE/op8a5mia4XbVuifgLS
 eRzLk9ghEXzIDSL9/SVMCo5jl9eXFxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739885686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=05OgedPfQZMpggpPnXuLMuvLHtbQ60ICzdOwmB57RW0=;
 b=jwcEF7SENALAlEdClQsvOF+975RyvFQ0vpLpG+vhZ9Sr8qEc++uGXz0LmmGegtuARS25j+
 xNSPiYjCri3+MsBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2Uc6lN2/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H99JRm5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739885685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=05OgedPfQZMpggpPnXuLMuvLHtbQ60ICzdOwmB57RW0=;
 b=2Uc6lN2/SEd1EuSrwy/MUAgyet6q9U1SUv78q9RmqNnCEldjQU9iJSvGtlNb9wj/qZ5FZ2
 +cWUeN897JimQWyHKESNC3kwILbbzbU9xQdVGcO7liKdko1+i6IBPBQerlg6Qq+fWMWvug
 MEJW50jfgkmpVKkORiznbF1subHGkzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739885685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=05OgedPfQZMpggpPnXuLMuvLHtbQ60ICzdOwmB57RW0=;
 b=H99JRm5FTzjvQU6wawWfbrOSy8/C8HyJUyNmk0DTIgZ8qOwEFmoiMnFINQsM2y7lhMQlAz
 1NlqOS1hRpfcwsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9B0713A1D;
 Tue, 18 Feb 2025 13:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d0dsLHWMtGfXTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 13:34:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Feb 2025 14:34:43 +0100
Message-ID: <20250218133443.2484512-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: D45771F396
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] doc/conf.py: Replace all titles
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
Link to v1:
https://patchwork.ozlabs.org/project/ltp/patch/20250218121553.2470592-1-pvorel@suse.cz/

Changes from v1:
* Use re.compile (Andrea)

 doc/conf.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index 03fcff67e8..2be847d90b 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -434,6 +434,7 @@ def generate_test_catalog(_):
         metadata = json.load(data)
 
     timeout_def = metadata['defaults']['timeout']
+    regexp = re.compile(r'^\[([A-Za-z][\w\W]+)\]')
 
     for test_name, conf in sorted(metadata['tests'].items()):
         text.extend([
@@ -455,12 +456,8 @@ def generate_test_catalog(_):
         if desc:
             desc_text = []
             for line in desc:
-                if line.startswith("[Description]"):
-                    desc_text.append("**Description**")
-                elif line.startswith("[Algorithm]"):
-                    desc_text.append("**Algorithm**")
-                else:
-                    desc_text.append(line)
+                line = regexp.sub(r'**\1**', line)
+                desc_text.append(line)
 
             text.extend([
                 '\n'.join(desc_text),
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
