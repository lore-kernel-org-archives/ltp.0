Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97247C36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 23:41:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FC793C9909
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 00:41:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C243F3C98E7
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 00:40:25 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B334A60564B
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 00:40:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3FED2118A;
 Mon, 24 Mar 2025 23:40:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4C5813874;
 Mon, 24 Mar 2025 23:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +HxnMmPt4WdEbAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Mar 2025 23:40:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Mar 2025 00:40:15 +0100
Message-ID: <20250324234016.367228-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324234016.367228-1-pvorel@suse.cz>
References: <20250324234016.367228-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: F3FED2118A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] Makefile: Update 'doc' target, add 'doc-clean'
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

'doc' target previously run docparse documentation. Point it to doc/
directory so that it build sphinx docs. doc/ dir has metadata/ dir as
dependency, no need to specify it. Call also '.venv' target.

NOTE: it's still possible to avoid virtualenv by calling 'make -C doc'

Add 'doc-clean': to remove only generated data (not optional .venv).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes since v2:
* 'doc' target: call also '.venv' target
* Add 'doc-clean' target

 Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5066789349..0c572248a4 100644
--- a/Makefile
+++ b/Makefile
@@ -169,8 +169,14 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
 
 $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
 
-.PHONY: doc
-doc: metadata-all
+.PHONY: doc doc-clean
+
+doc:
+	$(MAKE) -C $(abs_builddir)/doc .venv
+	$(MAKE) -C $(abs_builddir)/doc
+
+doc-clean:
+	$(MAKE) -C $(abs_builddir)/doc clean
 
 .PHONY: check
 check: $(CHECK_TARGETS)
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
