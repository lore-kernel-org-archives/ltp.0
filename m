Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9745AC02196
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 09:41:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CE593C2CCC
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:41:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1807F3C1BCB
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:41:16 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26D7220B9E9
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:41:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BE4F1F38D;
 Fri,  7 Feb 2025 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738921273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nocMQdYFsAn/QORGOeKn+ADMPgU/pCkXy+1RLs68z0=;
 b=vzpHGn5jzCPXFsmJSt6NYrrlnH08liKZcC9O9d5z5Qvo7efQ7yWBtFCGmFie4NZ3bbvetx
 ppxiBaUJhtqe8u5P3HJEn/yJEzocHOSgzSF3mL5eFoEALZJVpTfyV60GebR8Q7GI+nF3q8
 UQUq8WlspzVRxA3z32QiF1GF5LOH6rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738921273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nocMQdYFsAn/QORGOeKn+ADMPgU/pCkXy+1RLs68z0=;
 b=ERmz+t0mwlYAMQGK2ptXdT9mLr30QHxkq9Yj3/Vf6R7s34+9fkpCF/AJ9DSmq0g5T/Lbc2
 XU6D1WfypOviShCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vzpHGn5j;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ERmz+t0m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738921273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nocMQdYFsAn/QORGOeKn+ADMPgU/pCkXy+1RLs68z0=;
 b=vzpHGn5jzCPXFsmJSt6NYrrlnH08liKZcC9O9d5z5Qvo7efQ7yWBtFCGmFie4NZ3bbvetx
 ppxiBaUJhtqe8u5P3HJEn/yJEzocHOSgzSF3mL5eFoEALZJVpTfyV60GebR8Q7GI+nF3q8
 UQUq8WlspzVRxA3z32QiF1GF5LOH6rU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738921273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5nocMQdYFsAn/QORGOeKn+ADMPgU/pCkXy+1RLs68z0=;
 b=ERmz+t0mwlYAMQGK2ptXdT9mLr30QHxkq9Yj3/Vf6R7s34+9fkpCF/AJ9DSmq0g5T/Lbc2
 XU6D1WfypOviShCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F063413694;
 Fri,  7 Feb 2025 09:41:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hNPcOTjVpWfvYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 09:41:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Feb 2025 10:41:04 +0100
Message-ID: <20250207094105.1720944-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1BE4F1F38D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED] .readthedocs.yml: Fix building generation
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

readthedocs now needs to configure LTP and build metadata/ first.

Fixes: 1bf344a3db ("doc: add tests catalog page")
Co-developed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .readthedocs.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.readthedocs.yml b/.readthedocs.yml
index 28e8c88a5c..5434ef49d6 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -5,8 +5,16 @@ build:
   tools:
     python: "3.6"
   apt_packages:
+    - autoconf
     - enchant-2
     - hunspell-en-us
+    - make
+  jobs:
+    # Doc requires to have ltp.json
+    pre_build:
+      - make autotools
+      - ./configure
+      - make -C metadata/
 
 # Build from the doc/ directory with Sphinx
 sphinx:
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
