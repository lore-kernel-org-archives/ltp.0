Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B22C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 15:02:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C08F23CAFA9
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 17:02:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 436E13CB2BB
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 17:01:53 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8425E1A00CAE
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 17:01:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0594C21180;
 Mon,  7 Apr 2025 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744038102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oaOghw6wuztVNKlRY5MCFyno6nN9CItpGLxc/Zlh0w=;
 b=IEJsCSTb/iwcxuNPAGQYhvj2tvQDhTbXdZo+f1wHSIXQ2qCkhbU8iUHFfXx4G4Bd8e/cCB
 fleEktNIeQCC1ZqHvPCtfr2Z0QKCWF1pkdT02gowDdsc5CvjSfvdb8WG5D/mhLeidN6AuM
 cipz2qC4NJ2s67U5+JbYPREJtW7r+Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744038102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oaOghw6wuztVNKlRY5MCFyno6nN9CItpGLxc/Zlh0w=;
 b=k3ACjEJhqgcY5SIEGc3oS9TZnsIhZiuMNzkkFl6khfMODAI+PJD49KdD+dCORtz9ne3FJx
 2eQQ54b4YjVCG2Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744038102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oaOghw6wuztVNKlRY5MCFyno6nN9CItpGLxc/Zlh0w=;
 b=IEJsCSTb/iwcxuNPAGQYhvj2tvQDhTbXdZo+f1wHSIXQ2qCkhbU8iUHFfXx4G4Bd8e/cCB
 fleEktNIeQCC1ZqHvPCtfr2Z0QKCWF1pkdT02gowDdsc5CvjSfvdb8WG5D/mhLeidN6AuM
 cipz2qC4NJ2s67U5+JbYPREJtW7r+Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744038102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oaOghw6wuztVNKlRY5MCFyno6nN9CItpGLxc/Zlh0w=;
 b=k3ACjEJhqgcY5SIEGc3oS9TZnsIhZiuMNzkkFl6khfMODAI+PJD49KdD+dCORtz9ne3FJx
 2eQQ54b4YjVCG2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B55F713691;
 Mon,  7 Apr 2025 15:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFY6KdXo82dhNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 15:01:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 17:01:31 +0200
Message-ID: <20250407150133.115790-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407150133.115790-1-pvorel@suse.cz>
References: <20250407150133.115790-1-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] doc: Add sphinx to requirements.txt
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

Although that slightly prolongs creating virtualenv (and CI job), but
it's probably better to handle it as the other requirements.

Use the same sphinx and sphinx-rtd-theme versions as on readthedocs.org.
That way we get doc generation tested by CI and by local build (to avoid
incompatibility changes).

Also don't install python3-sphinx via apt in CI job to keep usage the
same as in readthedocs.org.

Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes from v4:
* Use sphinx version used on readthedocs.org (to really test in devel
  and github CI what will be deployed).
* Don't install sphinx in github CI (python3-sphinx package)

 .github/workflows/ci-sphinx-doc.yml | 2 +-
 doc/developers/documentation.rst    | 2 --
 doc/requirements.txt                | 4 ++++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
index a5f9d74d1f..e77c766871 100644
--- a/.github/workflows/ci-sphinx-doc.yml
+++ b/.github/workflows/ci-sphinx-doc.yml
@@ -23,7 +23,7 @@ jobs:
       - name: Install sphinx and autotools
         run: |
           sudo apt update
-          sudo apt install autoconf make python3-sphinx python3-virtualenv
+          sudo apt install autoconf make python3-virtualenv
 
       - name: Run configure
         run: |
diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
index 27c847e125..a303253693 100644
--- a/doc/developers/documentation.rst
+++ b/doc/developers/documentation.rst
@@ -23,8 +23,6 @@ Before building, make sure you have python3 ``virtualenv`` module installed.
     # prepare virtual environment
     python3 -m virtualenv .venv
     . .venv/bin/activate
-
-    pip install sphinx # usually packaged in distros
     pip install -r requirements.txt
 
     # build documentation
diff --git a/doc/requirements.txt b/doc/requirements.txt
index 742fb8b4bb..6302ecd9f2 100644
--- a/doc/requirements.txt
+++ b/doc/requirements.txt
@@ -1,3 +1,7 @@
+# Use the same sphinx as on readthedocs.org. When updated, make sure
+# sphinx-rtd-theme is compatible with sphinx.
+sphinx==5.3.0
 sphinx-rtd-theme==2.0.0
+
 linuxdoc==20231020
 sphinxcontrib-spelling==7.7.0
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
