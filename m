Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7366C433FE
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 13:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BECF03CA446
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 15:49:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C53EC3CA445
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 15:48:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B686C1000985
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 15:48:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F016E210EE;
 Tue,  5 Apr 2022 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649166525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syHKqFWBPueBdrkLr7zumpAkbEf4Hh0xF98XaT1sWEQ=;
 b=hB3aYfyjFxNTDho4oE4qH1VLpitN4XK7XVK5NUGRGp6OjeMrxhxG/HlX6Dg1KrRc/zlKPm
 2zkdNdJKS1ho5aIYczEKkzsVVsrfCvhcm5foRNBngYEruaxV1pSYgMtl8J3XRiBLyNXHVJ
 uUPfUbpr1DTIPdpGKhzGn84pHfiXOC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649166525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syHKqFWBPueBdrkLr7zumpAkbEf4Hh0xF98XaT1sWEQ=;
 b=VOVPDQ6Ae0TtfXoyrW545xvSpNYTFadIKeqymw+8AH4jcAQ+Gs8LQi9likvsGlv8B5WSN6
 S7F4NgmR3MyxLrDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8014B13522;
 Tue,  5 Apr 2022 13:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EFHmF71ITGIUOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 05 Apr 2022 13:48:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  5 Apr 2022 15:48:38 +0200
Message-Id: <20220405134838.9440-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405134838.9440-1-pvorel@suse.cz>
References: <20220405134838.9440-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ci/alpine.sh: Build confstr01.c
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

It was fixed in ba5c725879.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/alpine.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index d93a576167..4cbaaa5d3f 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2019-2021 Petr Vorel <petr.vorel@gmail.com>
+# Copyright (c) 2019-2022 Petr Vorel <petr.vorel@gmail.com>
 set -ex
 
 apk update
@@ -33,7 +33,6 @@ cat /etc/os-release
 echo "WARNING: remove unsupported tests (until they're fixed)"
 cd $(dirname $0)/..
 rm -rfv \
-	testcases/kernel/syscalls/confstr/confstr01.c \
 	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
 	testcases/kernel/syscalls/getcontext/getcontext01.c \
 	testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c \
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
