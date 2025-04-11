Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9B1C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 08:03:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FB9C3CB59B
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 10:03:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC5B53C581C
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 10:02:44 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 986DE6009D1
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 10:02:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DDC91F456;
 Fri, 11 Apr 2025 08:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744358562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7uTF8mcKMZn5xr3AWOsLJkHajxKcB3AvUzQkFgIqOs=;
 b=10NwwkgLtHlLld/XqD8Gfj9SyAqtWngGc4h2vQ0MiiCkwrNWjB0A5hTHvNubJyzC4fRE68
 grMrZ65Q71zFYU9wtO4Y6fPMx3v1P4oJToD0Et4fvmLqBma9aRWi+AhxonKlU1p4U29G0a
 v40d1qWRUf4pksk9S0twHvozM9CDN/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744358562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7uTF8mcKMZn5xr3AWOsLJkHajxKcB3AvUzQkFgIqOs=;
 b=VnxLJZvpsMRYeJHcQLaWsW2Dotd9aFQxfIe/hdzZNr0vsgTLdBchlpfEysafza6JGHaJ2B
 azpubL9maBomDxDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744358562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7uTF8mcKMZn5xr3AWOsLJkHajxKcB3AvUzQkFgIqOs=;
 b=10NwwkgLtHlLld/XqD8Gfj9SyAqtWngGc4h2vQ0MiiCkwrNWjB0A5hTHvNubJyzC4fRE68
 grMrZ65Q71zFYU9wtO4Y6fPMx3v1P4oJToD0Et4fvmLqBma9aRWi+AhxonKlU1p4U29G0a
 v40d1qWRUf4pksk9S0twHvozM9CDN/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744358562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7uTF8mcKMZn5xr3AWOsLJkHajxKcB3AvUzQkFgIqOs=;
 b=VnxLJZvpsMRYeJHcQLaWsW2Dotd9aFQxfIe/hdzZNr0vsgTLdBchlpfEysafza6JGHaJ2B
 azpubL9maBomDxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F7EF13A67;
 Fri, 11 Apr 2025 08:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0GryCaLM+GeKDAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Apr 2025 08:02:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Apr 2025 10:01:56 +0200
MIME-Version: 1.0
Message-Id: <20250411-patchwork_ci-v4-1-7f3c5ba298a1@suse.com>
References: <20250411-patchwork_ci-v4-0-7f3c5ba298a1@suse.com>
In-Reply-To: <20250411-patchwork_ci-v4-0-7f3c5ba298a1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744358561; l=3406;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=HrfKO2aoOr9b8u2OmHZTTwhzIXeje5Jx1/vNmI5iHq0=;
 b=wUdc004asYjzoxdGYutjHKBS8vmSr5yc9bpj2DVsGcbkoEYJyR5XwRRmsQIG0+yzGRT2k4RGn
 mP5C1PGFOvLDq0hOz2TJEVIIvO1bmPib/KwKA1LRiWP6eAg0dIcYp2p
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] ci: install dependences for patchwork-ci script
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 ci/alpine-runtime.sh |  2 ++
 ci/alpine.sh         |  2 ++
 ci/debian.i386.sh    |  2 ++
 ci/debian.sh         | 28 +++++++++++++++-------------
 ci/fedora.sh         |  2 ++
 ci/tumbleweed.sh     |  2 ++
 6 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/ci/alpine-runtime.sh b/ci/alpine-runtime.sh
index 3bff42770bd8ae7da3e6e571a843e44c7a56181b..d0e1990d2c25c9f300dd47fb979af4d38e3ad3f9 100755
--- a/ci/alpine-runtime.sh
+++ b/ci/alpine-runtime.sh
@@ -4,6 +4,8 @@
 
 apk add \
         acl \
+        curl \
+        jq \
         keyutils \
         libaio \
         libacl \
diff --git a/ci/alpine.sh b/ci/alpine.sh
index 5a44a6687b9eb7743c0fbbb288a133366b17da75..254f4aaece66ef177bc5b4a92cf5160443552378 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -9,6 +9,8 @@ apk add \
 	autoconf \
 	automake \
 	clang \
+	curl \
+	jq \
 	gcc \
 	git \
 	acl-dev \
diff --git a/ci/debian.i386.sh b/ci/debian.i386.sh
index 2846053098033dd0215aa724738a90baff290430..44c7ddf2ff6f049ab847b374213c6aee74fbc130 100755
--- a/ci/debian.i386.sh
+++ b/ci/debian.i386.sh
@@ -6,6 +6,8 @@ dpkg --add-architecture i386
 apt update
 
 apt install -y --no-install-recommends \
+	curl \
+	jq \
 	linux-libc-dev:i386 \
 	gcc-multilib \
 	libacl1-dev:i386 \
diff --git a/ci/debian.sh b/ci/debian.sh
index f590b4b9a4f910c7e4229f4e2a818cf5b1e818bb..96c2651b3e5919d3c4dece50164fab41e3929fa0 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -4,7 +4,7 @@
 
 # workaround for missing oldstable-updates repository
 # W: Failed to fetch http://deb.debian.org/debian/dists/oldstable-updates/main/binary-amd64/Packages
-grep -v oldstable-updates /etc/apt/sources.list > /tmp/sources.list && mv /tmp/sources.list /etc/apt/sources.list
+grep -v oldstable-updates /etc/apt/sources.list >/tmp/sources.list && mv /tmp/sources.list /etc/apt/sources.list
 
 apt update
 
@@ -23,6 +23,8 @@ pkg_minimal="
 	debhelper
 	devscripts
 	clang
+	curl
+	jq
 	gcc
 	git
 	iproute2
@@ -47,18 +49,18 @@ pkg_nonessential="
 "
 
 case "$ACTION" in
-	minimal)
-		echo "=== Installing only minimal dependencies ==="
-		$install $pkg_minimal
-		;;
-	remove-nonessential)
-		echo "=== Make sure devel libraries are removed ==="
-		$remove $pkg_nonessential
-		;;
-	*)
-		echo "=== Installing dependencies ==="
-		$install $pkg_minimal $pkg_nonessential
-		;;
+minimal)
+	echo "=== Installing only minimal dependencies ==="
+	$install $pkg_minimal
+	;;
+remove-nonessential)
+	echo "=== Make sure devel libraries are removed ==="
+	$remove $pkg_nonessential
+	;;
+*)
+	echo "=== Installing dependencies ==="
+	$install $pkg_minimal $pkg_nonessential
+	;;
 esac
 
 df -hT
diff --git a/ci/fedora.sh b/ci/fedora.sh
index bef5bcd2b519f4a32533a2d52f182c6dd5e1b7d0..494de928f7434f3310979e595e18162c2042f1e8 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -9,6 +9,8 @@ $yum \
 	automake \
 	make \
 	clang \
+	curl \
+	jq \
 	gcc \
 	git \
 	findutils \
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index 33937ec63a372ed92e8d4f05ecd435ce902fa5bb..d0607eed25f06fec3064ca75ec7875ce833f9d96 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -8,6 +8,8 @@ $zyp \
 	autoconf \
 	automake \
 	clang \
+	curl \
+	jq \
 	findutils \
 	gcc \
 	git \

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
