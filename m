Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A01BC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:36:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C33D33C9288
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:36:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8003C9277
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:48 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89E79600202
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4556B1F397;
 Thu,  6 Feb 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B0A813A7F;
 Thu,  6 Feb 2025 14:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SBujA4fIpGfvJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 14:34:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 15:34:21 +0100
Message-ID: <20250206143421.1571918-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206143421.1571918-1-pvorel@suse.cz>
References: <20250206143421.1571918-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4556B1F397
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/7] doc/Makefile: Add dependency on metadata/ltp.json
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: this should be applied after Andrea's work gets merged.
https://patchwork.ozlabs.org/project/ltp/patch/20250206-doc_tests_list-v5-2-52110e1421a9@suse.com/

Kind regards,
Petr

 doc/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/doc/Makefile b/doc/Makefile
index c6dadfd521..dc4cee6d3d 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -1,6 +1,10 @@
 # Copyright (c) Linux Test Project, 2024-2025
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
 PYTHON := python3
 
 # install sphinx only if needed
@@ -10,7 +14,10 @@ INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo "true
 	$(PYTHON) -m virtualenv .venv
 	. .venv/bin/activate && pip install -r requirements.txt && $(INSTALL_SPHINX)
 
-all: .venv
+${abs_top_builddir}/metadata/ltp.json:
+	$(MAKE) -C ${abs_top_builddir}/metadata
+
+all: ${abs_top_builddir}/metadata/ltp.json .venv
 	. .venv/bin/activate && sphinx-build -b html . html
 
 spelling:
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
