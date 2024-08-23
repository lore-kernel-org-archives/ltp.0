Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0EBC531DC
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 11:42:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D3FB3D233A
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 13:42:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E5193D2258
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:27 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C09E600B08
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 327532266D;
 Fri, 23 Aug 2024 11:42:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C75711398B;
 Fri, 23 Aug 2024 11:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eBKwLqB1yGbeRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 11:42:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Aug 2024 13:42:16 +0200
Message-ID: <20240823114217.1261861-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823114217.1261861-1-pvorel@suse.cz>
References: <20240823114217.1261861-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 327532266D
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ci/debian: Speedup minimal variant installation
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

We installed full dependencies and then remove them. Faster and easier
to review is to install only what will not be later removed.
But still attempt to remove (in case something was installed for
whatever reason - this should not happen in containers which are
minimal, but 1) just in case 2) can be used on VM for testing.

Implement this by several lists of packages and usual passing
environment variables.

In the end speedup is ~ 1 min 20 sec, but it's also easier to see what
happen.

Reported-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci-docker-build.yml |  2 +-
 ci/debian.minimal.sh                  | 17 +-----
 ci/debian.sh                          | 84 +++++++++++++++++----------
 3 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 322c06efa3..0445a35384 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -128,7 +128,7 @@ jobs:
         INSTALL=${{ matrix.container }}
         INSTALL="${INSTALL%%:*}"
         INSTALL="${INSTALL%%/*}"
-        ./ci/$INSTALL.sh
+        ACTION="$VARIANT" ./ci/$INSTALL.sh
         if [ "$VARIANT" ]; then ./ci/$INSTALL.$VARIANT.sh; fi
 
     - name: Compiler version
diff --git a/ci/debian.minimal.sh b/ci/debian.minimal.sh
index 2ccd161c46..1e8dd19af2 100755
--- a/ci/debian.minimal.sh
+++ b/ci/debian.minimal.sh
@@ -2,19 +2,4 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
 
-apt="apt remove -y"
-
-$apt \
-	asciidoc-base \
-	asciidoctor \
-	libacl1-dev \
-	libaio-dev \
-	libcap-dev \
-	libkeyutils-dev \
-	libnuma-dev \
-	libselinux1-dev \
-	libsepol-dev \
-	libssl-dev
-
-# Missing on Ubuntu 18.04 LTS (Bionic Beaver)
-$apt ruby-asciidoctor-pdf || true
+ACTION="remove-nonessential" $(dirname $0)/debian.sh
diff --git a/ci/debian.sh b/ci/debian.sh
index c413ef457b..68cf1509fc 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -11,39 +11,61 @@ apt update
 # workaround for Ubuntu impish asking to interactively configure tzdata
 export DEBIAN_FRONTEND="noninteractive"
 
-apt="apt install -y --no-install-recommends"
-
-$apt \
-	acl-dev \
-	asciidoc-base \
-	asciidoc-dblatex \
-	asciidoctor \
-	autoconf \
-	automake \
-	build-essential \
-	debhelper \
-	devscripts \
-	clang \
-	gcc \
-	git \
-	iproute2 \
-	libacl1-dev \
-	libaio-dev \
-	libcap-dev \
-	libc6-dev \
-	libjson-perl \
-	libkeyutils-dev \
-	libmnl-dev \
-	libnuma-dev \
-	libselinux1-dev \
-	libsepol-dev \
-	libssl-dev \
-	libtirpc-dev \
-	linux-libc-dev \
-	lsb-release \
+install="apt install -y --no-install-recommends"
+remove="apt remove -y"
+
+pkg_minimal="
+	acl-dev
+	autoconf
+	automake
+	build-essential
+	debhelper
+	devscripts
+	clang
+	gcc
+	git
+	iproute2
+	libc6-dev
+	libjson-perl
+	libmnl-dev
+	libtirpc-dev
+	linux-libc-dev
+	lsb-release
 	pkg-config
+"
+
+pkg_nonessential="
+	asciidoc-base
+	asciidoc-dblatex
+	asciidoctor
+	libacl1-dev
+	libaio-dev
+	libcap-dev
+	libkeyutils-dev
+	libnuma-dev
+	libselinux1-dev
+	libsepol-dev
+	libssl-dev
+"
 
 # Missing on Ubuntu 18.04 LTS (Bionic Beaver)
-$apt ruby-asciidoctor-pdf || true
+pkg_maybe_nonessential="ruby-asciidoctor-pdf"
+
+case "$ACTION" in
+	minimal)
+		echo "=== Installing only minimal dependencies ==="
+		$install $pkg_minimal
+		;;
+	remove-nonessential)
+		echo "=== Make sure devel libraries are removed ==="
+		$remove $pkg_nonessential
+		$remove $pkg_maybe_nonessential || true
+		;;
+	*)
+		echo "=== Installing dependencies ==="
+		$install $pkg_minimal $pkg_nonessential
+		$install $pkg_maybe_nonessential || true
+		;;
+esac
 
 df -hT
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
