Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8794CC28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:59:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FF473CA25B
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 10:59:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69B1A3CA305
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:57:57 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E8640200C05
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:57:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C7E01F38F;
 Fri, 28 Mar 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uP3sLVNZiCvk1MEswni9SwRcz97pcUQkErSZs8EXHo=;
 b=w+XcPtv+DPKSMBz9h2cHY7nCLhqWfbIVayjh9exBBNo2HzwapzFjWFnJWDe9PkCezVXZoO
 cAfrzMT9uFiQIJT7HNLRRokDZeS0ca9QqBGKrsHG3xvZLJoMEDno54GEmlwzOtHvZD9+iP
 okyV1sv58b3T5VKdJt0C8t2BKW+G3i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uP3sLVNZiCvk1MEswni9SwRcz97pcUQkErSZs8EXHo=;
 b=LLCQyq+2Hy2HKqG3G86qqt1/wzmZC1CfBnKG/IsHCf+w/T/5HAxf3hYDEb40Vy2tHvkFSZ
 ApmQYPMectqHm6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uP3sLVNZiCvk1MEswni9SwRcz97pcUQkErSZs8EXHo=;
 b=w+XcPtv+DPKSMBz9h2cHY7nCLhqWfbIVayjh9exBBNo2HzwapzFjWFnJWDe9PkCezVXZoO
 cAfrzMT9uFiQIJT7HNLRRokDZeS0ca9QqBGKrsHG3xvZLJoMEDno54GEmlwzOtHvZD9+iP
 okyV1sv58b3T5VKdJt0C8t2BKW+G3i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uP3sLVNZiCvk1MEswni9SwRcz97pcUQkErSZs8EXHo=;
 b=LLCQyq+2Hy2HKqG3G86qqt1/wzmZC1CfBnKG/IsHCf+w/T/5HAxf3hYDEb40Vy2tHvkFSZ
 ApmQYPMectqHm6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DC5013A52;
 Fri, 28 Mar 2025 09:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yCLSFZ5y5mcWHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 09:57:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 10:57:45 +0100
Message-ID: <20250328095747.169011-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328095747.169011-1-pvorel@suse.cz>
References: <20250328095747.169011-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/5] doc/Makefile: Allow to create and use .venv
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes in v4:
* Add setup (alias to .venv)
* Move sphinx to requirements.txt (therefore remove handling in Makefile)
* Add support also for fish (csh/tcsh ignored, supporting: fish, bash/zsh)

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
