Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28629C0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 23:36:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94A1E3C99B6
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 00:36:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A9A43C9967
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:36:06 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2053635320
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:36:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C23EF1F788;
 Tue, 11 Feb 2025 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739316964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v5ExUjBn/0Wftl3d8VRtqUYdE4FIz/XRBJSB1be6PpQ=;
 b=Omjtj//IcCU6JIIJP6zMFZl9BieMu0ic2YVUIvhtqFjNuhm/GFtaYX0p22uRzevpZDK6Og
 SVU1zQI2W0Ksxf4ZaCuAa1Gcjkgl3NRSOBgAju9ZiBucvDI7qBUeJpOa+sPIl9AJWwYraC
 lOvOCr0Utwc+18MxGFhGx30K9qclNdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739316964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v5ExUjBn/0Wftl3d8VRtqUYdE4FIz/XRBJSB1be6PpQ=;
 b=ozBzCZfqXJVSI9VP/5iw9CymgGdkL60jyi+sKYgsYVhSR0Yq8ZeKVpCfFFFFPmCDOg8pBe
 WzyHhojEADptOuAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=acVDK1W+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IMGX7I7x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739316963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v5ExUjBn/0Wftl3d8VRtqUYdE4FIz/XRBJSB1be6PpQ=;
 b=acVDK1W+g1MrErAxJyUWbNcLj7ZXTTC7ZG8IFaFiX+Tju8uMXPCir586hAxSyYnK/JYBHF
 4fFyr6Oy17s7FN/JYHhtUk4hX7rj8ophMycgJSpzi4cbk/fncVlBnxgCjauEucbl9VxxwT
 bF2fG72qoK1J6ewS/NQ9se0YmdeTxqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739316963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v5ExUjBn/0Wftl3d8VRtqUYdE4FIz/XRBJSB1be6PpQ=;
 b=IMGX7I7xcJN+crXMyHJmtMyDqe1pi8SzzX9nQOr3CSLJ4VKxMy6yoRnCy2gqwam+cvM23u
 mLopXjRAN22fN1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93A3A13782;
 Tue, 11 Feb 2025 23:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LEIbI+Peq2fPdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 23:36:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Feb 2025 00:35:51 +0100
Message-ID: <20250211233552.1990618-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: C23EF1F788
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] doc/Makefile: Allow to create and use .venv
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

This is an optional target (not run by default).
If .venv exists, it's used in other targets.

This helps to use virtualenv for development, but avoid using it by
default (readthedoc uses container with virtualenv, creating it would be
waste of time).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v1: https://patchwork.ozlabs.org/project/ltp/patch/20250206143421.1571918-4-pvorel@suse.cz/

Changes v1->v2:
* virtualenv is optional
* use variables

 doc/Makefile | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/doc/Makefile b/doc/Makefile
index a07df04d5c..909d9687b8 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -5,14 +5,26 @@ top_srcdir		?= ..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
+PYTHON := python3
+VENV_DIR := .venv
+VENV_CMD := . $(VENV_DIR)/bin/activate
+RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
+
+# install sphinx only if needed
+INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx")
+
+$(VENV_DIR):
+	$(PYTHON) -m virtualenv $(VENV_DIR)
+	$(VENV_CMD) && pip install -r requirements.txt && $(INSTALL_SPHINX)
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
-	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl
+	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl $(VENV_DIR)
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
