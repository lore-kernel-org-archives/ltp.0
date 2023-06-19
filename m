Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1ADEB64D9
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 10:32:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73D3B3CC4E7
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 12:31:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A6EA3C0973
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 12:31:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67085200224
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 12:31:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63A2421898;
 Mon, 19 Jun 2023 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687170708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nZj0BzW0gX0tXHPpzqstdF6w9Ybc2WbkpZM3np/I3ys=;
 b=Z72a24c/9SeDooPWyvg/0BCAK7W866fnsKz/FbygBd0F7lbvapLE3D7LEussAuxJ0/BdcN
 TgL1w0k+jo77R06vYBjv0y7pc26NVhIUqTxeUksXmFRrS1EKPMtsonVH7Fiywtg/4SIcMs
 etHRBydsH8prWlJFv9VUfwagzkSbD3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687170708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nZj0BzW0gX0tXHPpzqstdF6w9Ybc2WbkpZM3np/I3ys=;
 b=sAs/72L1BcMN04X0RlweMqeNUdAIxsM/CEBGQsNngMVM6i595pM9q4EiG+VSFoiyv8662I
 JtxG2MoGYH4V5yAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34A8E139C2;
 Mon, 19 Jun 2023 10:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DS9hC5QukGTTRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Jun 2023 10:31:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 19 Jun 2023 12:31:40 +0200
Message-ID: <20230619103140.13925-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] ci/debian.minimal.sh: Keep libcap2
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

Trying to remove libcap2 for minimal environment no longer works for
Debian 12 bookworm (the new Debian stable release). It looks like
libcap2 is required by apt itself:

apt remove -y libcap2
The following packages have unmet dependencies:
 apt : Depends: libapt-pkg6.0 (>= 2.6.1) but it is not going to be installed
       Depends: libsystemd0
 bsdutils : PreDepends: libsystemd0
 util-linux : PreDepends: libsystemd0
E: Error, pkgProblemResolver::Resolve generated breaks, this may be caused by held packages.

Reported-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/debian.minimal.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/debian.minimal.sh b/ci/debian.minimal.sh
index c314d93fe..b51154b05 100755
--- a/ci/debian.minimal.sh
+++ b/ci/debian.minimal.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2023 Petr Vorel <pvorel@suse.cz>
 set -ex
 
 apt="apt remove -y"
@@ -11,7 +11,6 @@ $apt \
 	libaio-dev \
 	libaio1 \
 	libcap-dev \
-	libcap2 \
 	libkeyutils-dev \
 	libnuma-dev \
 	libnuma1 \
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
