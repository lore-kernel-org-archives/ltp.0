Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C51CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 13:27:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F6093E1DB7
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 15:26:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA2983C2B0D
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 15:26:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 270E160097F
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 15:26:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E853C76744;
 Fri, 12 Jun 2026 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781267392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDwtWxli1AMj526Ng70V8fyFJN9n6M4HcYva/Ha+9Dc=;
 b=MzwMr+Tk6jhh73ehRcT4qQgRyenpqZPxHSH4qZblGjqHy8c08X9ZIAqNulFt+YgacZEewA
 X5La2Jn7esfz/EOaHwzcZzXlb+LVwk4SN5YHxBCMT1GfOQ6mkf4Z1x9czNIf4mRXUbNPAl
 fQFro9qJ4dLQRArkOgWtEIGKyED8oCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781267392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDwtWxli1AMj526Ng70V8fyFJN9n6M4HcYva/Ha+9Dc=;
 b=EbNBibu5vyzGjRMXqt53+87yG79bSDMOnOum4FYrS7QN8EQ6a4sVX56DXrXGnZAl8pKUVM
 Lvwq/MxMQbK4A/CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781267391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDwtWxli1AMj526Ng70V8fyFJN9n6M4HcYva/Ha+9Dc=;
 b=MmN3CQJWDCfq42xapqm5arKh42q9LN86b6d/G6ks0J8455cQjJLvyYal9mhTVVHo97cUib
 f54+PtFYtczpkQ9qfsK4cjXz8rA9qsb981lXTQBntCIdbePQIdgyffme6qZu2LfQL/0UHQ
 EfGlouUCTgOgdhYLuIHlFWypQzY8xdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781267391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IDwtWxli1AMj526Ng70V8fyFJN9n6M4HcYva/Ha+9Dc=;
 b=FMo+n8mMaIPEZQT5ck5KwC5sGdteD/2QgJYSHRD8F79pGc+BKV4mKEDY013+EyLokuIjBi
 bhWWVH/KRJQoi0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBD55779A7;
 Fri, 12 Jun 2026 12:29:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YTN+L7/7K2ovMAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Jun 2026 12:29:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 14:29:46 +0200
MIME-Version: 1.0
Message-Id: <20260612-metadata_extension-v1-1-ac9999d74a6c@suse.com>
X-B4-Tracking: v=1; b=H4sIALn7K2oC/x2MQQqAIBAAvxJ7TlArg74SEVtutYcsVCKQ/p51H
 JiZBIE8U4CuSODp4sCHy6DKAuYN3UqCbWbQUhtplBY7RbQYcaQ7kvt00U5S1Y3BubIWcnh6Wvj
 +p/3wPC96mOBWZAAAAA==
X-Change-ID: 20260612-metadata_extension-7b01456ac3dd
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781267391; l=1540;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=gLhJ9z+kcIxpcCYZRcRlYrb6IfUt4FFqCu/D5KmUb88=;
 b=JINlEzEKr44cddw1b7x/3TbOp/1O/sim/ZxopSUkt2jLRv4kB+HVqMEzBXcqD0rgYaKlYGSyl
 i19TFrW/xMgCYowo652yQghVBf28pwaqd1RJ4nlshTw+kmuMUJsHGkY
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] metadata: update stale test expected outputs
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 metadata/tests/expand_flags.c.json |  6 +++---
 metadata/tests/tags.c.json         | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/metadata/tests/expand_flags.c.json b/metadata/tests/expand_flags.c.json
index cd79dd296b9cbc2cfd61fffc8a84634bbe313b94..079972e4a7cf65a3717c179f7ddeb30c49964820 100644
--- a/metadata/tests/expand_flags.c.json
+++ b/metadata/tests/expand_flags.c.json
@@ -1,6 +1,6 @@
   "expand_flags": {
-   "all_filesystems": "1",
-   "needs_device": "1",
-   "needs_tmpdir": "1",
+   "all_filesystems": true,
+   "needs_device": true,
+   "needs_tmpdir": true,
    "fname": "expand_flags.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/tags.c.json b/metadata/tests/tags.c.json
index 14cc14f1c1e110a5a0a1425d3e9a23179baff09f..d45c9f447f1337c9bed86edb7fd71a134db5d25e 100644
--- a/metadata/tests/tags.c.json
+++ b/metadata/tests/tags.c.json
@@ -1,13 +1,13 @@
   "tags": {
    "tags": [
-     [
-      "tag-name-1",
-      "tag-value-1"
-     ],
-     [
-      "tag-name-2",
-      "tag-value-2"
-     ]
+    [
+     "tag-name-1",
+     "tag-value-1"
     ],
+    [
+     "tag-name-2",
+     "tag-value-2"
+    ]
+   ],
    "fname": "tags.c"
   }
\ No newline at end of file

---
base-commit: a3fda1dc1ce7da882a592a4877da7f214e468650
change-id: 20260612-metadata_extension-7b01456ac3dd

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
