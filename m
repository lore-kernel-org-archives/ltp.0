Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3B9C4332F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 11:08:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90DDC3CC72B
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 12:08:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C1F83CC72B
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 12:08:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57F74602F71
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 12:08:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1593B21838;
 Mon,  6 Nov 2023 11:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699268914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=R5fvcd3MPsFjVqn/N8kYjXWYkqwE6RLRJvWwB9DXE4E=;
 b=WJIAju+s/XKAOPR4UHj5as+gtOew7CAADDbMIHQ4DfvtW8T3a+TBZsJ0k50EjJ6R2ohIwM
 8N5F8ntM2k4liDMjTb4fUs+JZ1dbQTxclLvgPuU+xJYzWhMCkzctsosPQXCtv8p9b1Z0Tr
 iazfMesw1Q6yEIv0gYQcA1x15YB7cD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699268914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=R5fvcd3MPsFjVqn/N8kYjXWYkqwE6RLRJvWwB9DXE4E=;
 b=jciQupVClEUtsR3Rz8dHDaM1HyM1h0c6Ll0L6oSlgUzmNuGIpmEfeP9pH3UUmQG5TDdfGe
 uB8uzwG+WuZkG3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E786138E5;
 Mon,  6 Nov 2023 11:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1Wk8ITHJSGVKJwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Nov 2023 11:08:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Nov 2023 12:08:19 +0100
Message-ID: <20231106110819.1243292-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ci: doc: Remove Ubuntu 16.04 LTS xenial
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
Cc: Ulrich Hecht <uli@kernel.org>, Richard Palethorpe <rpalethorpe@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To keep number of CI jobs reasonable remove Ubuntu 16.04 LTS xenial.
The oldest distro is now openSUSE Leap 42.2 (the same kernel, glibc is
one release older, older gcc).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

anybody who wants to keep it please shout. But, please explain why
(openSUSE Leap 42.2 should satisfy testing old compilers).

Kind regards,
Petr

 .github/workflows/ci.yml                                | 6 ------
 doc/Supported-kernel,-libc,-toolchain-versions.asciidoc | 5 ++---
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 64aac4580..a632ed96b 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -63,12 +63,6 @@ jobs:
             env:
               CC: gcc
 
-          - container: "ubuntu:xenial"
-            env:
-              CC: gcc
-              METADATA: asciidoc-pdf
-              TREE: out
-
           - container: "quay.io/centos/centos:stream9"
             env:
               CC: gcc
diff --git a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
index dcc0cb79c..bdb3e44f3 100644
--- a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
+++ b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
@@ -19,12 +19,11 @@ NOTE: GitHub Actions does only build testing, passing the CI means only that
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 [align="center",options="header"]
-|==============================================================
+|===============================================================
 | Distro                       | kernel  | glibc | gcc   | clang
 | openSUSE Leap 42.2           | 4.4     | 2.22  | 4.8.5 | -
-| Ubuntu 16.04 LTS xenial      | 4.4     | 2.23  | 5.3.1 | -
 | Ubuntu 18.04 LTS bionic      | 4.15    | 2.27  | 7.3.0 | -
-|==============================================================
+|===============================================================
 
 Older distributions are not officially supported, which means that it
 may or may not work. It all depends on your luck. It should be possible
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
