Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09944C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 11:38:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17ACA3C94B3
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 13:38:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07C263C91F1
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B80914000E5
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D47837986;
 Mon,  8 Aug 2022 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659958682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuQFlsi9xFlsvW9m3zSVoMzGCvic80f9VJmocYWKTZE=;
 b=zNtmj1klxX97u4EsHYBm5cUrsrdm0nd7jQPU6iI3e1+fHCTA/1Aw/3l7r2qsNt2wlB9J4M
 lZOnmNC/xv3IOPlH7Jw3KC+Cll6Ll60YKc4lVUjmNMdL+eHwrcJ6GAtxgVZiyzZl039Uba
 +X0py23mHUuMhB78Oc1OsIiE+3jza+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659958682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuQFlsi9xFlsvW9m3zSVoMzGCvic80f9VJmocYWKTZE=;
 b=kqWuvLm1yYoA9VDRZwMvy66nlG7fNbBTaZGKsY9lBCaXkLliVtfRRvil5jxXRe9qwYuSZF
 6ztbO6i012KL1OBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D75F113AB3;
 Mon,  8 Aug 2022 11:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8C4fMJn18GJ0LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 11:38:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 13:37:56 +0200
Message-Id: <20220808113756.11582-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808113756.11582-1-pvorel@suse.cz>
References: <20220808113756.11582-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] generate_lvm_runfile.sh: Fix bashism
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

using -e (i.e. implying 'set -e') is required to exit on any non zero
exit code. It requires 2 previous fixes.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/misc/lvm/generate_lvm_runfile.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 72b286a69..aba706c64 100755
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
+	trap '[ $? -eq 0 ] || tst_brk TBROK "Cannot create LVM runfile"' EXIT
 	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
 	OUTFILE="$LTPROOT/runtest/lvm.local"
 	FS_LIST=`tst_supported_fs`
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
