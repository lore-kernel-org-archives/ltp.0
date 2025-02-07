Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405D1C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:57:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C73F63C9342
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 11:57:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1256B3C9365
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 840861BDC582
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 90FD621161;
 Fri,  7 Feb 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 651D513694;
 Fri,  7 Feb 2025 10:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sNADF8PmpWddeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 10:56:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Feb 2025 11:55:48 +0100
Message-ID: <20250207105551.1736356-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207105551.1736356-1-pvorel@suse.cz>
References: <20250207105551.1736356-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 90FD621161
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] ci: Don't install asciidoc{,tor}
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

It was removed from GitHub Actions build previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/alpine.sh     | 2 --
 ci/debian.sh     | 8 --------
 ci/fedora.sh     | 2 --
 ci/tumbleweed.sh | 3 ---
 4 files changed, 15 deletions(-)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index 93acd6267b..f486cd51ea 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -6,8 +6,6 @@ apk update
 
 apk add \
 	acl-dev \
-	asciidoc \
-	asciidoctor \
 	autoconf \
 	automake \
 	clang \
diff --git a/ci/debian.sh b/ci/debian.sh
index fc1c1b3ec6..06eedb47c9 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -35,9 +35,6 @@ pkg_minimal="
 
 pkg_nonessential="
 	acl-dev
-	asciidoc-base
-	asciidoc-dblatex
-	asciidoctor
 	libacl1-dev
 	libaio-dev
 	libcap-dev
@@ -50,9 +47,6 @@ pkg_nonessential="
 	libssl-dev
 "
 
-# Missing on Ubuntu 18.04 LTS (Bionic Beaver)
-pkg_maybe_nonessential="ruby-asciidoctor-pdf"
-
 case "$ACTION" in
 	minimal)
 		echo "=== Installing only minimal dependencies ==="
@@ -61,12 +55,10 @@ case "$ACTION" in
 	remove-nonessential)
 		echo "=== Make sure devel libraries are removed ==="
 		$remove $pkg_nonessential
-		$remove $pkg_maybe_nonessential || true
 		;;
 	*)
 		echo "=== Installing dependencies ==="
 		$install $pkg_minimal $pkg_nonessential
-		$install $pkg_maybe_nonessential || true
 		;;
 esac
 
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 623dbb5cb6..d1f3c78113 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -5,7 +5,6 @@
 yum="yum -y install --skip-broken"
 
 $yum \
-	asciidoc \
 	autoconf \
 	automake \
 	make \
@@ -24,4 +23,3 @@ $yum \
 
 # CentOS 8 fixes
 $yum libmnl-devel || $yum libmnl
-$yum rubygem-asciidoctor || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index 42d62c0e05..841ed67869 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -5,7 +5,6 @@
 zyp="zypper --non-interactive install --force-resolution --no-recommends"
 
 $zyp \
-	asciidoc \
 	autoconf \
 	automake \
 	clang \
@@ -29,5 +28,3 @@ $zyp \
 	lsb-release \
 	perl-JSON \
 	pkg-config
-
-$zyp ruby2.7-rubygem-asciidoctor || $zyp ruby2.5-rubygem-asciidoctor || true
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
