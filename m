Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1150BC433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 07:39:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D9973C968F
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 08:39:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA68D3C732F
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 08:39:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 47E5814002A7
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 08:39:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A97B1F384;
 Wed, 19 Jan 2022 07:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642577983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l/2+RGwqT3bN8yh1Wbr35JU2GCsGVg51fHuS4isAtOg=;
 b=Dvna4wm4rx9WWFmbPdRag2q/9OzCWNAOfKGsNpaAn9yKCoTMfB/iymroMIcTB3b2HKPGgg
 hUxHjD2/2J3vWT/ss+iH7CGViGCtkLXMpZq95MERstiEIDQOKjb8QdJhUZg30RcuI5+qgP
 haGLRs+c4t8t6vV2Z81NpfJUmAM8Ka0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642577983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l/2+RGwqT3bN8yh1Wbr35JU2GCsGVg51fHuS4isAtOg=;
 b=0hBUbd8wHnCjujXAXybmcjd7PcRqk4pHICfEf18DzIz4+toBWF0MU6Wwg4RLGc20O9qmm5
 l1rLmaRpkj3q2UBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 270AD13B2A;
 Wed, 19 Jan 2022 07:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9atcBz/A52HPaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jan 2022 07:39:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Jan 2022 08:39:39 +0100
Message-Id: <20220119073939.8543-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] ci: Replace groovy -> impish
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <petr.vorel@gmail.com>

in both GitHub Actions and Travis.

groovy is EOL, which is probably the reason why it's archives has been
removed:

Ign:1 http://security.ubuntu.com/ubuntu groovy-security InRelease
Ign:2 http://archive.ubuntu.com/ubuntu groovy InRelease
Err:3 http://security.ubuntu.com/ubuntu groovy-security Release
  404  Not Found [IP: 91.189.91.39 80]
Ign:4 http://archive.ubuntu.com/ubuntu groovy-updates InRelease
Ign:5 http://archive.ubuntu.com/ubuntu groovy-backports InRelease
Err:6 http://archive.ubuntu.com/ubuntu groovy Release
  404  Not Found [IP: 91.189.88.142 80]
Err:7 http://archive.ubuntu.com/ubuntu groovy-updates Release
  404  Not Found [IP: 91.189.88.142 80]
Err:8 http://archive.ubuntu.com/ubuntu groovy-backports Release
  404  Not Found [IP: 91.189.88.142 80]
Reading package lists...
E: The repository 'http://security.ubuntu.com/ubuntu groovy-security Release' does not have a Release file.
E: The repository 'http://archive.ubuntu.com/ubuntu groovy Release' does not have a Release file.
E: The repository 'http://archive.ubuntu.com/ubuntu groovy-updates Release' does not have a Release file.
E: The repository 'http://archive.ubuntu.com/ubuntu groovy-backports Release' does not have a Release file.

Using impish requires to use workaround to avoid apt asking to
interactively configure tzdata.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .github/workflows/ci.yml | 2 +-
 .travis.yml              | 2 +-
 ci/debian.sh             | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index ad611ad..4316ede 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -59,7 +59,7 @@ jobs:
               CC: gcc
               TSS: tpm2-tss
 
-          - container: "ubuntu:groovy"
+          - container: "ubuntu:impish"
             env:
               CC: gcc
               TSS: ibmtss
diff --git a/.travis.yml b/.travis.yml
index 534c41d..bdf78a1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,7 +40,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:groovy TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=ubuntu:impish TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
           compiler: gcc
 
         - os: linux
diff --git a/ci/debian.sh b/ci/debian.sh
index ae5c9c1..005b1f6 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -2,6 +2,9 @@
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 set -ex
 
+# workaround for Ubuntu impish asking to interactively configure tzdata
+export DEBIAN_FRONTEND="noninteractive"
+
 if [ -z "$CC" ]; then
 	echo "missing \$CC!" >&2
 	exit 1
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
