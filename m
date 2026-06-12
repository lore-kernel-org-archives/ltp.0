Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDDCD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 16:20:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACC1B3E6B3E
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 18:20:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C122C3E2A97
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:20:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 487A51000B70
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:20:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4F42757B7;
 Fri, 12 Jun 2026 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781272455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1nrK6rej62PZ/j02eSqVVvQM2DUC+Hs2TcDgrMC7BM=;
 b=PuYulSzEWcVHyeC9+piMW+yWxBEytHbNm0Q7rcMOi9maNX501jk/Px/GU0356iwE9y7hoN
 q2aRIHIc4nZ7ey7/P4YHdGuX7xfusH+q5L4mpL4u6h1P8+/a/7KV5TBt1WOpM88vHL89Gw
 fJbFF9o2tvi/rSJLKNRsfgzVYjIroiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781272455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1nrK6rej62PZ/j02eSqVVvQM2DUC+Hs2TcDgrMC7BM=;
 b=WrZZ5dejuNWv9fGCsUoxTtJhbEnyu7m8v7zpl1BFxfmc419Ojv9GSxJttdhRn784PHXkkf
 kLIwUWn8l9tsh1DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781272455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1nrK6rej62PZ/j02eSqVVvQM2DUC+Hs2TcDgrMC7BM=;
 b=PuYulSzEWcVHyeC9+piMW+yWxBEytHbNm0Q7rcMOi9maNX501jk/Px/GU0356iwE9y7hoN
 q2aRIHIc4nZ7ey7/P4YHdGuX7xfusH+q5L4mpL4u6h1P8+/a/7KV5TBt1WOpM88vHL89Gw
 fJbFF9o2tvi/rSJLKNRsfgzVYjIroiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781272455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1nrK6rej62PZ/j02eSqVVvQM2DUC+Hs2TcDgrMC7BM=;
 b=WrZZ5dejuNWv9fGCsUoxTtJhbEnyu7m8v7zpl1BFxfmc419Ojv9GSxJttdhRn784PHXkkf
 kLIwUWn8l9tsh1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACAAF779A7;
 Fri, 12 Jun 2026 13:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GNIQKIcPLGrGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Jun 2026 13:54:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 15:54:15 +0200
MIME-Version: 1.0
Message-Id: <20260612-metadata_groups-v1-2-d7a24a7ac7a8@suse.com>
References: <20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com>
In-Reply-To: <20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781272455; l=1595;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=S8HY9FTac/Dgnvhirb7JNVOF0QcLXMoW1GbMGU1J/l8=;
 b=biEIuWGqI5/pjlUX5LbSVd7EqBLb03C5/jlisPuWN7CrT0jFOQEHBfl21DYHNyYksnkwWL7yV
 0U344uCvzyCDtePF47w8/VSB8JEUH2y54f3QSyLl7WRQiDQMf6zrnA9
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: conf.py: Show groups in test catalog
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

Filter out @group tag lines from the test description to avoid
duplication since they are already shown in the groups list.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index 591c1534dfa7e54b816e88b9eca1dd7fb91df255..bf2eaa898ac49debee88ccc1d26a584ffe20bb7d 100644
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
@@ -482,11 +483,22 @@ def generate_test_catalog(_):
                 ''
             ])
 
-        # test description
+        # groups information
+        groups = conf.get('groups', None)
+        if groups:
+            text.extend([
+                '',
+                f"**Groups**: {', '.join(groups)}",
+                ''
+            ])
+
+        # test description (filter out @group tags)
         desc = conf.get('doc', None)
         if desc:
             desc_text = []
             for line in desc:
+                if line.lstrip().startswith('@group '):
+                    continue
                 line = regexp.sub(r'**\1**', line)
                 desc_text.append(line)
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
