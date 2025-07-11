Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9E3C83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 13:29:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EAEA3CB294
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 15:29:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F57C3C2F9D
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:29:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 56CC1600A91
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 15:29:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6366E21188;
 Fri, 11 Jul 2025 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752240562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hr+UHIGuHwQUu3IQTckkbAHmgi7tGdZyPmg7w6JLZe4=;
 b=AXLce+Hw9G9TNeaN5yXh8T/yZZ7RIU7srkC4lYnCsH8c8Ynfkg9K8yZK2M8P4vGTANr9gI
 vZgXrE/7txTdnKWz1HzVUftHw0M7otBtMwEHt/1Fsl7AAHC8KFAjWF0vCvbS4H7iH/+/ky
 CCXQZkTbDysXh6HaORifiDjlfk6kFFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752240562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hr+UHIGuHwQUu3IQTckkbAHmgi7tGdZyPmg7w6JLZe4=;
 b=J1MndJc19vRL7t3rrYFHI9p0r4YTBAyGf0Hvz5by3hMRYb/dvDA7Jlunmz7IXdq3216LhO
 SeWaH9IBJYqL6wBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AXLce+Hw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J1MndJc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752240562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hr+UHIGuHwQUu3IQTckkbAHmgi7tGdZyPmg7w6JLZe4=;
 b=AXLce+Hw9G9TNeaN5yXh8T/yZZ7RIU7srkC4lYnCsH8c8Ynfkg9K8yZK2M8P4vGTANr9gI
 vZgXrE/7txTdnKWz1HzVUftHw0M7otBtMwEHt/1Fsl7AAHC8KFAjWF0vCvbS4H7iH/+/ky
 CCXQZkTbDysXh6HaORifiDjlfk6kFFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752240562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hr+UHIGuHwQUu3IQTckkbAHmgi7tGdZyPmg7w6JLZe4=;
 b=J1MndJc19vRL7t3rrYFHI9p0r4YTBAyGf0Hvz5by3hMRYb/dvDA7Jlunmz7IXdq3216LhO
 SeWaH9IBJYqL6wBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D77C1388B;
 Fri, 11 Jul 2025 13:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4OrvDLIRcWgAQQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Jul 2025 13:29:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Jul 2025 15:29:19 +0200
Message-ID: <20250711132920.920494-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6366E21188
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] doc: update filesystems info according to new
 metadata
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

New metadata is now using a dictionary definition for
tst_test.filesystems. This patch will correctly show the filesystems
setup information inside the html page.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Follow up patch for
https://patchwork.ozlabs.org/project/ltp/list/?series=464762

 doc/conf.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index da768232b..cadfeb2b3 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -406,13 +406,12 @@ def _generate_setup_table(keys):
             else:
                 values.append(f'{value[0]}, {value[1]}')
         elif key == 'filesystems':
-            for v in value:
-                for item in v:
-                    if isinstance(item, list):
-                        continue
-
-                    if item.startswith('.type'):
-                        values.append(item.replace('.type=', ''))
+            for params in value:
+                for pkey, pval in params.items():
+                    if pkey == "type":
+                        values.append(f"- {pval}")
+                    else:
+                        values.append(f" {pkey}: {pval}")
         elif key == "save_restore":
             for item in value:
                 values.append(item[0])
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
