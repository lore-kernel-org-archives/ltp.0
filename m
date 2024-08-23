Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8A8C531DC
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 11:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D6BA3D2333
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 13:43:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9018C3D2332
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:27 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DCAEB200BC0
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B576220308;
 Fri, 23 Aug 2024 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724413344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8Itj+5wOtRpnisVeSWjm9aGUb6LeAh16zttx6mezmA=;
 b=CI1oEqk2S2wCJ9qgkRTQ9E/XR0kxj1uFO+cKMXH1cALIywfJvzlFGg3pWe/yxC/k9Yi3W6
 x+YYazJCJXA9vs14HWerLTt7OcJNdsRQSa+SjmQ8y6CZ6KUfGLYCrI14dNsThLRiyv9OcE
 D452Ja5hLSqPWThrkSBDOQkmKFIxafM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724413344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8Itj+5wOtRpnisVeSWjm9aGUb6LeAh16zttx6mezmA=;
 b=yVVUEKBfF9XTsnzxakvu/1mDowv1QdwbtOVU17WZsH6biBptJEvkEo7nNwyHM32Wmhwwhe
 4dkIz3Wp4dtHHbDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724413344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8Itj+5wOtRpnisVeSWjm9aGUb6LeAh16zttx6mezmA=;
 b=CI1oEqk2S2wCJ9qgkRTQ9E/XR0kxj1uFO+cKMXH1cALIywfJvzlFGg3pWe/yxC/k9Yi3W6
 x+YYazJCJXA9vs14HWerLTt7OcJNdsRQSa+SjmQ8y6CZ6KUfGLYCrI14dNsThLRiyv9OcE
 D452Ja5hLSqPWThrkSBDOQkmKFIxafM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724413344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8Itj+5wOtRpnisVeSWjm9aGUb6LeAh16zttx6mezmA=;
 b=yVVUEKBfF9XTsnzxakvu/1mDowv1QdwbtOVU17WZsH6biBptJEvkEo7nNwyHM32Wmhwwhe
 4dkIz3Wp4dtHHbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6259313A61;
 Fri, 23 Aug 2024 11:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJFhFqB1yGbeRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 11:42:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Aug 2024 13:42:15 +0200
Message-ID: <20240823114217.1261861-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823114217.1261861-1-pvorel@suse.cz>
References: <20240823114217.1261861-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] ci/debian: Simplify dependencies installation /
 removal
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

1) Use asciidoc-base instead of asciidoc for both installation and
   removal (it contains the asciidoc binary, asciidoc is a metapackage,
   thus removing it would not remove the asciidoc binary).

2) asciidoc-base asciidoc-dblatex and ruby-asciidoctor-pdf are available
   on all current not yet EOL versions (from buster (oldoldstable) to
   trixie (testing)), thus it can be safely used without '|| true' fallback.

3) asciidoctor contains the asciidoctor binary and have ruby-asciidoctor
   (ruby asciidoc library) as a dependency. It can be used instead.

4) Remove also ruby-asciidoctor-pdf. It should be removed in flow
   asciidoc => ruby-asciidoctor => ruby-asciidoctor-pdf, but explicit
   remove is more obvious.

5) Don't try to install libc6 (it's an obvious base package, it cannot
   be removed). But it's not working on Ubuntu 18.04 LTS (Bionic Beaver)
   (package not there yet).

This also unifies packages, which is a preparation for a next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/debian.minimal.sh | 5 +++--
 ci/debian.sh         | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/ci/debian.minimal.sh b/ci/debian.minimal.sh
index 0584192721..2ccd161c46 100755
--- a/ci/debian.minimal.sh
+++ b/ci/debian.minimal.sh
@@ -5,7 +5,7 @@
 apt="apt remove -y"
 
 $apt \
-	asciidoc \
+	asciidoc-base \
 	asciidoctor \
 	libacl1-dev \
 	libaio-dev \
@@ -16,4 +16,5 @@ $apt \
 	libsepol-dev \
 	libssl-dev
 
-$apt asciidoc-base ruby-asciidoctor || true
+# Missing on Ubuntu 18.04 LTS (Bionic Beaver)
+$apt ruby-asciidoctor-pdf || true
diff --git a/ci/debian.sh b/ci/debian.sh
index 63cf242d2a..c413ef457b 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -15,7 +15,8 @@ apt="apt install -y --no-install-recommends"
 
 $apt \
 	acl-dev \
-	asciidoc \
+	asciidoc-base \
+	asciidoc-dblatex \
 	asciidoctor \
 	autoconf \
 	automake \
@@ -29,7 +30,6 @@ $apt \
 	libacl1-dev \
 	libaio-dev \
 	libcap-dev \
-	libc6 \
 	libc6-dev \
 	libjson-perl \
 	libkeyutils-dev \
@@ -43,7 +43,7 @@ $apt \
 	lsb-release \
 	pkg-config
 
+# Missing on Ubuntu 18.04 LTS (Bionic Beaver)
 $apt ruby-asciidoctor-pdf || true
-$apt asciidoc-dblatex || true
 
 df -hT
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
