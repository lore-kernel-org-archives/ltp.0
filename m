Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD836C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 16:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47CB33CB91E
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 18:40:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C28483CA513
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:39:42 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4EBE220012C
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:39:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA5AB1F6E6;
 Tue, 15 Apr 2025 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744735181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nto4fuwZQTwmQ8HH2BD5exCspG1n8E2knIAcjpJqIVs=;
 b=xY1Xf1mRAzDyaov24zGeX13A+erN2DLvNT7HIevSIcGtM1PAWRgD3SIW8q8xWVQemRcyRp
 TSXevR9eiAgC2jO5UhDSmDxdeUo7TNrFTdes2qAzjoYguS6VxI8s06WBFDp/Bqj9iMlAbI
 5bUkicj8WRwlrEQ18JS6cOJeLcZHz8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744735181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nto4fuwZQTwmQ8HH2BD5exCspG1n8E2knIAcjpJqIVs=;
 b=6DIQvEgMElDW3ERtCuZ5bAGOesOEwRMEBE1Lj2i4dnNPA1rfk4QeMsQb0drVK53RTybUpo
 GxoEwgRbZsOHUfAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744735180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nto4fuwZQTwmQ8HH2BD5exCspG1n8E2knIAcjpJqIVs=;
 b=j0K8iruYssksMvOIWTq/bsQrs5AIAPao2dzqYcPg2K5Nwt+LxeMAnzauwLsev6seFNeRpW
 ZulFxwjaI1luJnY+lO+lFGRZXBCuq+txDbgafbwyfBimP5tjKj5A935vGOtSIsIO5N9t/l
 cm8zi7CSTlg0JhKJNjwHCR3NGklreqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744735180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nto4fuwZQTwmQ8HH2BD5exCspG1n8E2knIAcjpJqIVs=;
 b=ygBBEJBr+F5d29d6/kO3LzCS+tdzNv6Gz3qccab4QghZ+UMf9AcsdM/Kt89/dh8A0I9y1H
 S60xZ9KcmxOK4NBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B8813A9F;
 Tue, 15 Apr 2025 16:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCPrKsyL/meEZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Apr 2025 16:39:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 15 Apr 2025 18:39:37 +0200
MIME-Version: 1.0
Message-Id: <20250415-patchwork_ci-v7-1-bc0b9adca971@suse.com>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
In-Reply-To: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744735180; l=2303;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uYxfBENUBkMUhfsMrOStU0v+P9YhVtNDaIsyrk+z+Hw=;
 b=ZRGMN1O9P3RLuXmU5NA9zMqyGRc/bux7ij3n6InCUvdqBJ4C3pkOxAvrq75mUpF2aT9cEz5t+
 54zT7y1Lzj9D4HcM7zIlKfW9pTrfS0GKmOrlmhlkGehEn4JKftIxQ2u
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/4] ci: install dependences for patchwork-ci script
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 ci/alpine-runtime.sh | 2 ++
 ci/alpine.sh         | 2 ++
 ci/debian.i386.sh    | 2 ++
 ci/debian.sh         | 2 ++
 ci/fedora.sh         | 2 ++
 ci/tumbleweed.sh     | 2 ++
 6 files changed, 12 insertions(+)

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
index f590b4b9a4f910c7e4229f4e2a818cf5b1e818bb..0445c92ec40819e49c0435b1881cf6b202d14087 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -23,6 +23,8 @@ pkg_minimal="
 	debhelper
 	devscripts
 	clang
+	curl
+	jq
 	gcc
 	git
 	iproute2
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
