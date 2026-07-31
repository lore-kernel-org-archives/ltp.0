Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4488C55171
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 05:46:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD31B3E71D6
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 07:46:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0ED273CF29D
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 07:46:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 643551A00924
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 07:46:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55B7F7D3E6;
 Fri, 31 Jul 2026 05:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785476761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W3/E7LSVbXJJWXelX2Ed3QSHQs379facTNhl+KGkrLc=;
 b=15GyBWbR5YBuSP0u3GOa5hjQVqbtU/wFcVVCVAO8R1LdV60NNdkAW6SoYfAYL3GdBHlDJ6
 RK2xnRbcq1+KlIaIzoTkMKH1He6RsgSmkjDi01HdcdaQ73+guirLCCjud+PZw7qrEWjRa8
 scHsW+q0Jx+butdZZqQaXkKm5T5++vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785476761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W3/E7LSVbXJJWXelX2Ed3QSHQs379facTNhl+KGkrLc=;
 b=+g3uIc2Qcnp7G+u8PR+0kp65OD4V45PLmebB53wWrW1AjD+4+CY5ntYGpscelT9+hOF/bn
 oldBPO7oCni3IbBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="nl/rL/tB";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fBZm1nFH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785476757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W3/E7LSVbXJJWXelX2Ed3QSHQs379facTNhl+KGkrLc=;
 b=nl/rL/tBKq/Mztb2iWTaMr9sA/fCt/RNqUdbzzRHApyEpzZGidT+/S3t3UEDeXrjjlMyFv
 1YmNGSlqnpK5ywAMpbswnJBc43fPP8IcuMj2+82F0/2ii4olGYMp5GubktMnqknqIdaZxM
 AwhIx+5WcQhHHIB8fEblnHd2/ZttyFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785476757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W3/E7LSVbXJJWXelX2Ed3QSHQs379facTNhl+KGkrLc=;
 b=fBZm1nFH+nrTCFh6agyCberRyxVBHr5jIQ5dwQhZuwe5AUIYdfdxbksBkpht0lOlo9mSwn
 CGi3YGGEHfoDRUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7894779B0;
 Fri, 31 Jul 2026 05:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 37xcH5M2bGptfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 05:45:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 07:45:47 +0200
Message-ID: <20260731054548.133241-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 55B7F7D3E6
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email, suse.cz:dkim,
 suse.com:email, checkpatch.pl:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

LTP project decided to move from https://patchwork.ozlabs.org/
to https://patchwork.kernel.org/.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .b4-config                       | 2 +-
 .github/pull_request_template.md | 2 +-
 README.rst                       | 2 +-
 ci/tools/patchwork.sh            | 2 +-
 doc/maintainers/patch_review.rst | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.b4-config b/.b4-config
index aea68ad8f6..c2766cd4fb 100644
--- a/.b4-config
+++ b/.b4-config
@@ -2,7 +2,7 @@
 # See https://b4.docs.kernel.org/en/latest/config.html
 [b4]
     send-series-to = Linux Test Project <ltp@lists.linux.it>
-    pw-url = https://patchwork.ozlabs.org/
+    pw-url = https://patchwork.kernel.org/
     pw-project = ltp
 
     # other checkpatch.pl options from .checkpatch.conf are used
diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md
index e2c076ddd5..1149edf7c5 100644
--- a/.github/pull_request_template.md
+++ b/.github/pull_request_template.md
@@ -4,7 +4,7 @@
 * Although we *occasionally* also accept GitHub pull requests, the *preferred* way is sending patches to our mailing list: https://lore.kernel.org/ltp/
 There is an example how to use it: https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial#7-submitting-the-test-for-review (using git format-patch and git send-email).
 LTP mailing list is archived at: https://lore.kernel.org/ltp/.
-We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list/.
+We also have a patchwork instance: https://patchwork.kernel.org/project/ltp/list/.
 
 * Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
 https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
diff --git a/README.rst b/README.rst
index 9853222fbe..06600cf20f 100644
--- a/README.rst
+++ b/README.rst
@@ -24,6 +24,6 @@ Some references:
 * `Source code <https://github.com/linux-test-project/ltp>`_
 * `Releases <https://github.com/linux-test-project/ltp/releases>`_
 * `Mailing List <http://lists.linux.it/listinfo/ltp>`_
-* `Working patches (patchwork) <https://patchwork.ozlabs.org/project/ltp/list/>`_
+* `Working patches (patchwork) <https://patchwork.kernel.org/project/ltp/list/>`_
 * `Working patches (lore.kernel.org) <https://lore.kernel.org/ltp>`_
 * `#ltp @ libera chat <https://libera.chat/>`_
diff --git a/ci/tools/patchwork.sh b/ci/tools/patchwork.sh
index 5c58bee5d8..71155704c0 100755
--- a/ci/tools/patchwork.sh
+++ b/ci/tools/patchwork.sh
@@ -7,7 +7,7 @@
 #
 # Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
 
-PATCHWORK_URL="${PATCHWORK_URL:-https://patchwork.ozlabs.org}"
+PATCHWORK_URL="${PATCHWORK_URL:-https://patchwork.kernel.org}"
 PATCHWORK_SINCE="${PATCHWORK_SINCE:-3600}"
 PATCHWORK_MAX_SINCE="${PATCHWORK_MAX_SINCE:-86400}"
 PATCHWORK_CI_PREFIX="${PATCHWORK_CI_PREFIX:-github-build}"
diff --git a/doc/maintainers/patch_review.rst b/doc/maintainers/patch_review.rst
index 50e4f8ccf8..0665e492ec 100644
--- a/doc/maintainers/patch_review.rst
+++ b/doc/maintainers/patch_review.rst
@@ -126,7 +126,7 @@ Commit messages should have
 * LTP documentation should be kept up to date.
 
 After patch is accepted or rejected, set correct state and archive in the
-`LTP patchwork instance <https://patchwork.ozlabs.org/project/ltp/list/>`_.
+`LTP patchwork instance <https://patchwork.kernel.org/project/ltp/list/>`_.
 
 New tests
 ---------
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
