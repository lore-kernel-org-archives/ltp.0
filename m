Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C07C00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 07:05:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEB7A3C9486
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 09:05:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FE103C0CC0
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 09:05:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B436860076C
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 09:05:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 89A545C75F;
 Fri,  5 Aug 2022 07:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659683119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KYSjNu2vmwn8rMn2k476jGo2Hj47Jm8dC9rNBAsBuB0=;
 b=ErKxEgiWfZlj/bb8j3EJr91/F4iAm5beNGcHbep10UoBZjk/8wINPTd/+kG5h3A2xYdwdW
 gvArN97fBmbTKGXbyIuSDbj9Or+g4BTMJLCY9JiC9BhrWf27d0KVqBoC+HeR1/pG3/tCBK
 jQ06DP9TKHoImfkdjK8hB/b9he6JW6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659683119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KYSjNu2vmwn8rMn2k476jGo2Hj47Jm8dC9rNBAsBuB0=;
 b=y+/liW+6NEAp3f100t4Se57ZSVpb3hbJFtWs+DgatgYS0B97bT+5V+wOKZLNt8igDUtoyX
 Vf1Tkx2gHcIbfHBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E61D133B5;
 Fri,  5 Aug 2022 07:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id J6S7GS/B7GKqIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Aug 2022 07:05:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 Aug 2022 09:05:12 +0200
Message-Id: <20220805070512.31805-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] generate_lvm_runfile.sh: Fix bashism
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

ERR is not on dash (tested on 0.5.11).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1-v2:
* add -e (i.e. set -e)

 testcases/misc/lvm/generate_lvm_runfile.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 72b286a69..599d6c0e7 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -1,6 +1,7 @@
-#!/bin/sh
+#!/bin/sh -e
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+# Copyright (c) Linux Test Project, 2022
 #
 # Generate LTP runfile for LVM tests (runtest/lvm.local)
 
@@ -13,7 +14,7 @@ LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
 
 generate_runfile()
 {
-	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
+	trap '[ $? -eq 0 ] && exit 0 || tst_brk TBROK "Cannot create LVM runfile"' EXIT
 	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
 	OUTFILE="$LTPROOT/runtest/lvm.local"
 	FS_LIST=`tst_supported_fs`
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
