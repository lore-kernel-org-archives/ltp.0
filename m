Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182F4C369D7
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C9FF3CB9E7
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 17:32:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211913CB918
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:31:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD09B60046E
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 17:31:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC76F1F44F;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A014313A79;
 Fri, 25 Apr 2025 15:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIANJqmqC2gSdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 15:30:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Apr 2025 17:30:44 +0200
Message-ID: <20250425153046.63853-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425153046.63853-1-pvorel@suse.cz>
References: <20250425153046.63853-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: CC76F1F44F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 3/4] ci/tumbleweed.sh: Retry on broken repos
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

opensuse/leap:latest container repos are sometimes broken:

zypper --non-interactive install --force-resolution --no-recommends autoconf ...
...
(86/88) Installing: kernel-default-devel-6.4.0-150600.23.47.2.x86_64 [..............done]
(87/88) Installing: libopenssl-devel-3.1.4-150600.2.1.noarch [..done]
(88/88) Installing: clang-17-bp156.1.1.x86_64 [..done]
Error: Process completed with exit code 106.

Restarts later help, but let's try to recover with retry 10x with 5 sec
sleep before give up. It slightly prolong the testing, but it might
avoid having to restart the test manually and avoid get permanent
failure in Patchwork, because Patchwork API does not update results, it
just adds a new result.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Not 100% about this (the breakage is usually hour or something).

 ci/tumbleweed.sh | 67 +++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index d0607eed25..8a30b02c2d 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -1,31 +1,46 @@
 #!/bin/sh -eux
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2025 Petr Vorel <pvorel@suse.cz>
 
 zyp="zypper --non-interactive install --force-resolution --no-recommends"
 
-$zyp \
-	autoconf \
-	automake \
-	clang \
-	curl \
-	jq \
-	findutils \
-	gcc \
-	git \
-	gzip \
-	iproute2 \
-	make \
-	kernel-default-devel \
-	keyutils-devel \
-	libacl-devel \
-	libaio-devel \
-	libcap-devel \
-	libmnl-devel \
-	libnuma-devel \
-	libopenssl-devel \
-	libselinux-devel \
-	libtirpc-devel \
-	linux-glibc-devel \
-	lsb-release \
-	pkg-config
+i=10
+while [ $i != 0 ]; do
+	$zyp \
+		autoconf \
+		automake \
+		clang \
+		curl \
+		jq \
+		findutils \
+		gcc \
+		git \
+		gzip \
+		iproute2 \
+		make \
+		kernel-default-devel \
+		keyutils-devel \
+		libacl-devel \
+		libaio-devel \
+		libcap-devel \
+		libmnl-devel \
+		libnuma-devel \
+		libopenssl-devel \
+		libselinux-devel \
+		libtirpc-devel \
+		linux-glibc-devel \
+		lsb-release \
+		pkg-config
+
+	ret=$?
+
+	if [ $ret -eq 106 ]; then
+		echo "Broken repositories, try $i..."
+		sleep 5
+		i=$((i-1))
+		continue
+	fi
+	break
+done
+
+exit $ret
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
