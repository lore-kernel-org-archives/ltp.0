Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA235CD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 14:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 691E43E5884
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:11:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC5F3E5897
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:10:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5F87F14010EF
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:10:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACAED6D3CF;
 Thu, 18 Jun 2026 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5orWt9J2Gtc16XzJaXq8IHTSOEH2WncirOjlNLY3vw=;
 b=nOk5r+edoEQZkViRcVGbX1df2mkdEA1WesrMovkuLT+6eHVombwBsXxd3lSlLs6equdbGE
 isav//gSQECAuuP5RAX3zGVtVORRf48ihyQKZ6uTPOtO+taWiiYk/LbGuWVEYoqN3in+/i
 BO7jK/mRiIfaVZUBs083h1+Wrv8IjeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5orWt9J2Gtc16XzJaXq8IHTSOEH2WncirOjlNLY3vw=;
 b=b+3okEcmJqAas6eL0Rv/UpMIqwC5/Yd82yrG9fI3rYIyCFOrpQO2N47qRtUVuT4uhPeGuG
 4qeJQCF6xL5jr+AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5orWt9J2Gtc16XzJaXq8IHTSOEH2WncirOjlNLY3vw=;
 b=nOk5r+edoEQZkViRcVGbX1df2mkdEA1WesrMovkuLT+6eHVombwBsXxd3lSlLs6equdbGE
 isav//gSQECAuuP5RAX3zGVtVORRf48ihyQKZ6uTPOtO+taWiiYk/LbGuWVEYoqN3in+/i
 BO7jK/mRiIfaVZUBs083h1+Wrv8IjeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5orWt9J2Gtc16XzJaXq8IHTSOEH2WncirOjlNLY3vw=;
 b=b+3okEcmJqAas6eL0Rv/UpMIqwC5/Yd82yrG9fI3rYIyCFOrpQO2N47qRtUVuT4uhPeGuG
 4qeJQCF6xL5jr+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88862779A8;
 Thu, 18 Jun 2026 14:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8PTnHlT8M2p7CgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jun 2026 14:10:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 18 Jun 2026 16:10:27 +0200
MIME-Version: 1.0
Message-Id: <20260618-metadata_groups-v2-2-6ab298932233@suse.com>
References: <20260618-metadata_groups-v2-0-6ab298932233@suse.com>
In-Reply-To: <20260618-metadata_groups-v2-0-6ab298932233@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781791828; l=1146;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=uyg+rQD0OdIIfufRivLyhxRGmGi+YOr7Jk3hvZqQMeo=;
 b=LYXwgS9usuVvLqcSOa/8dQJN/tbr33tSbxkgfaoX7hNk2UThKGDCWRE6O69hUzJepEiZUGYsY
 BDabYW3iKxKDTW0LG8qXnkM2pG1SrDsN36WgAddFoKfDy+sswC3TFVa
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] doc: conf.py: Show groups in test catalog
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

Display the groups field from metadata in the generated test catalog
pages. Groups appear after the source link and before the test
description.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index 591c1534dfa7e54b816e88b9eca1dd7fb91df255..c28db7af1622d28ff79d128c73e3e3c9d8dea112 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -394,6 +394,7 @@ def _generate_setup_table(keys):
         'needs_checkpoints',
         'forks_child',
         'tags',
+        'groups',
     ]
     my_keys = {k: v for k, v in keys.items() if k not in exclude}
     if len(my_keys) == 0:
@@ -482,6 +483,15 @@ def generate_test_catalog(_):
                 ''
             ])
 
+        # groups information
+        groups = conf.get('groups', None)
+        if groups:
+            text.extend([
+                '',
+                f"**Groups**: {', '.join(groups)}",
+                ''
+            ])
+
         # test description
         desc = conf.get('doc', None)
         if desc:

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
