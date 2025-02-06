Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1214C02196
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:36:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FB823C12C2
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:36:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A47A3C91BA
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:47 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0DD57142509A
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:34:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 794012115F;
 Thu,  6 Feb 2025 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT+WZp7huMKadRIfQCaJsezzT8wqum4RSkww7ZJt0bs=;
 b=tMxxXJkv3gGy4GzMsYUvOYBZWpzf8w8CCUe5+Oh6B4BAlUo8rWrPAi6DYchzl4CT/PTngO
 fgjqVfho4KZ+INF2GgzbDD+cSAN6gmX4CkWoit8wEeoOE0FAp6ml6A2cQK3R46Qd7DZ6OI
 RNZ0o28t2k+1RqOTnAdKWgYFtVL3sEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT+WZp7huMKadRIfQCaJsezzT8wqum4RSkww7ZJt0bs=;
 b=wUrCEFTzCkETTfFdIZJ4lzS2cE+iGK6WZouiau6A0ufyCKy34D2s1YFftZ4qqwUk2o4HOV
 ByoR7wnCcMLlr0Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738852486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT+WZp7huMKadRIfQCaJsezzT8wqum4RSkww7ZJt0bs=;
 b=tMxxXJkv3gGy4GzMsYUvOYBZWpzf8w8CCUe5+Oh6B4BAlUo8rWrPAi6DYchzl4CT/PTngO
 fgjqVfho4KZ+INF2GgzbDD+cSAN6gmX4CkWoit8wEeoOE0FAp6ml6A2cQK3R46Qd7DZ6OI
 RNZ0o28t2k+1RqOTnAdKWgYFtVL3sEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738852486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT+WZp7huMKadRIfQCaJsezzT8wqum4RSkww7ZJt0bs=;
 b=wUrCEFTzCkETTfFdIZJ4lzS2cE+iGK6WZouiau6A0ufyCKy34D2s1YFftZ4qqwUk2o4HOV
 ByoR7wnCcMLlr0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44ABE13A7F;
 Thu,  6 Feb 2025 14:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uLezDobIpGfvJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 14:34:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 15:34:18 +0100
Message-ID: <20250206143421.1571918-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206143421.1571918-1-pvorel@suse.cz>
References: <20250206143421.1571918-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/7] doc: documentation.rst: Update build instructions
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

Makefile now supports building docs, use it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/documentation.rst | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
index 0cd3173fa7..ccee461379 100644
--- a/doc/developers/documentation.rst
+++ b/doc/developers/documentation.rst
@@ -11,23 +11,13 @@ and it's built on top of `Sphinx <https://www.sphinx-doc.org/en/master/>`_.
 Building documentation
 ~~~~~~~~~~~~~~~~~~~~~~
 
-First of all, to build the documentation we must be sure that all dependencies
-have been installed (please check :master:`doc/requirements.txt` file). Sometimes the
-Linux distros are providing them, but the best way is to use ``virtualenv``
-command as following:
+Before building, make sure you have python3 ``virtualenv`` module installed.
 
 .. code-block:: bash
 
+    make autotools
+    ./configure
     cd doc
-
-    # prepare virtual environment
-    python3 -m virtualenv .venv
-    . .venv/bin/activate
-
-    pip install sphinx # usually packaged in distros
-    pip install -r requirements.txt
-
-    # build documentation
     make
 
 Once the procedure has been completed, documentation will be visible at
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
