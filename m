Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C386E95A97
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 10:24:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 873783CB2E7
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 12:24:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F90F3C8961
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 12:24:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69D4D10028B4
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 12:24:09 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6D2EA1F750;
 Mon,  9 Oct 2023 10:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1696847049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86ezkKhvW/jA7kIuxfEmoo0EwEfHx6RERG8UEk3I7pU=;
 b=pePz33xNFZ6OtThaetB7jJOjSNDdFvax4Sx7adgL3KJqUtryFP2jObVkH5YJ75ikh9hdPO
 jyZW5V0WXrLEDvKrj2fUra4p7hb1BSThqi+k6ouG++ox/IQj9dt61SaLgWZb3Tp6mXtFSI
 ZdYdi74QRsi+4+cDj1d1XhQIvkNLDLY=
Received: from g78.cable.virginm.net (unknown [10.163.25.62])
 by relay2.suse.de (Postfix) with ESMTP id 14D642C143;
 Mon,  9 Oct 2023 10:24:09 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  9 Oct 2023 11:24:05 +0100
Message-ID: <20231009102405.26471-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009102405.26471-1-rpalethorpe@suse.com>
References: <20231009102405.26471-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] ci: Check for undefined variables in all
 scripts
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
---
 ci/alpine.sh               | 3 +--
 ci/debian.cross-compile.sh | 3 +--
 ci/debian.i386.sh          | 3 +--
 ci/debian.minimal.sh       | 3 +--
 ci/debian.sh               | 3 +--
 ci/fedora.sh               | 3 +--
 ci/tumbleweed.sh           | 3 +--
 7 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index 9ae5a8d07..efd1f6de4 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -1,6 +1,5 @@
-#!/bin/sh
+#!/bin/sh -eux
 # Copyright (c) 2019-2022 Petr Vorel <petr.vorel@gmail.com>
-set -ex
 
 apk update
 
diff --git a/ci/debian.cross-compile.sh b/ci/debian.cross-compile.sh
index 0a7ef7710..e2dea2ee0 100755
--- a/ci/debian.cross-compile.sh
+++ b/ci/debian.cross-compile.sh
@@ -1,6 +1,5 @@
-#!/bin/sh
+#!/bin/sh -eux
 # Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
-set -ex
 
 if [ -z "$ARCH" ]; then
 	echo "missing \$ARCH!" >&2
diff --git a/ci/debian.i386.sh b/ci/debian.i386.sh
index 707a23ca6..e6017de65 100755
--- a/ci/debian.i386.sh
+++ b/ci/debian.i386.sh
@@ -1,6 +1,5 @@
-#!/bin/sh
+#!/bin/sh -eux
 # Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
-set -ex
 
 dpkg --add-architecture i386
 apt update
diff --git a/ci/debian.minimal.sh b/ci/debian.minimal.sh
index b51154b05..780258676 100755
--- a/ci/debian.minimal.sh
+++ b/ci/debian.minimal.sh
@@ -1,6 +1,5 @@
-#!/bin/sh
+#!/bin/sh -eux
 # Copyright (c) 2018-2023 Petr Vorel <pvorel@suse.cz>
-set -ex
 
 apt="apt remove -y"
 
diff --git a/ci/debian.sh b/ci/debian.sh
index da92337fb..6d0c9eb13 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -1,6 +1,5 @@
-#!/bin/sh
+#!/bin/sh -eux
 # Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
-set -ex
 
 # workaround for missing oldstable-updates repository
 # W: Failed to fetch http://deb.debian.org/debian/dists/oldstable-updates/main/binary-amd64/Packages
diff --git a/ci/fedora.sh b/ci/fedora.sh
index a603bcbe3..2e4e87bca 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -1,6 +1,5 @@
-#!/bin/sh
+#!/bin/sh -eux
 # Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
-set -ex
 
 yum="yum -y install --skip-broken"
 
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index f1e7252f2..2e2b05aa5 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -1,6 +1,5 @@
-#!/bin/sh
+#!/bin/sh -eux
 # Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
-set -ex
 
 zyp="zypper --non-interactive install --force-resolution --no-recommends"
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
