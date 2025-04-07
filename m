Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6F0C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 15:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F055A3CB1CB
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 17:02:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E72633C071D
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 17:01:43 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 082331A00CC2
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 17:01:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91E7C1F393;
 Mon,  7 Apr 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DC6313AB8;
 Mon,  7 Apr 2025 15:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8PQMBNbo82dhNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 15:01:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 17:01:32 +0200
Message-ID: <20250407150133.115790-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407150133.115790-1-pvorel@suse.cz>
References: <20250407150133.115790-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 91E7C1F393
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] doc/Makefile: Allow to create and use .venv
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add 'setup' target (alias to '.venv') to create virtualenv directory.
This is an optional target (not run by default).
If .venv exists, it's used in other targets, activation supports only
fish and bash/zsh (known shells used by LTP developers, csh/tcsh is
ignored atm).

This helps to use virtualenv for development, but avoid using it by
default (readthedoc uses container with virtualenv, creating it would be
waste of time).

Add 'distclean' target which removes also .venv/ directory.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* The same as v4

NOTE: doc/Makefile should be rewritten to use generic_leaf_target.mk,
then integration to the top level Makefile will not be a hack).

 doc/Makefile | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/doc/Makefile b/doc/Makefile
index 3c5682ad00..2062d6e935 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -5,15 +5,33 @@ top_srcdir		?= ..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
+PYTHON := python3
+VENV_DIR := .venv
+
+# only fish and bash/zsh supported
+VENV_CMD := if [ "x${FISH_VERSION}" != "x" ]; then . $(VENV_DIR)/bin/activate.fish; else . $(VENV_DIR)/bin/activate; fi
+
+RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
+
+$(VENV_DIR):
+	$(PYTHON) -m virtualenv $(VENV_DIR)
+	$(VENV_CMD) && pip install -r requirements.txt
+
+.PHONY: setup
+setup: $(VENV_DIR)
+
 ${abs_top_builddir}/metadata/ltp.json:
 	$(MAKE) -C ${abs_top_builddir}/metadata
 
 all: ${abs_top_builddir}/metadata/ltp.json
-	sphinx-build -b html . html
+	$(RUN_VENV); sphinx-build -b html . html
 
 spelling:
-	sphinx-build -b spelling -d build/doctree . build/spelling
+	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
 
 clean:
 	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
 		${abs_top_builddir}/metadata/ltp.json
+
+distclean: clean
+	rm -rf $(VENV_DIR)
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
