Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B57C77B61
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 17:59:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47A2F3CE579
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 19:59:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 048AC3C26E5
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 19:59:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4072214001EA
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 19:59:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B98BE218FD;
 Mon, 24 Apr 2023 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682359166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xs11g4FHnoUnB7wdmL2kcDNjob3hRJzcVuIngj6R+Wg=;
 b=lG3rO8M3ZvlScHhAcccnsnUT934Fx6erk8MVNomumMNMWsGxl7knsmJY1q7Dz2e3lwG1N1
 VUxl5fnNKpqEQzMqgSBpIa3c7lYoKbO5fzY645gnC4AK6Y2Xf0SJjwUVAcFtiWWRgAVLz0
 grnsFNqXQGmduD0m4dpFPf/N60diUHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682359166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xs11g4FHnoUnB7wdmL2kcDNjob3hRJzcVuIngj6R+Wg=;
 b=Gh6CWnQu+spzlS3gRPBJTEGdskNBYYIFsP9m8kpmpMAVV7d8WCqamfXB+xnSJ49uITxLpn
 opqK1qie1LmO2bAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FF8113780;
 Mon, 24 Apr 2023 17:59:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NRwqFX7DRmTFPQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 17:59:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Apr 2023 19:59:34 +0200
Message-Id: <20230424175934.2847088-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] nfslock01: Add GPL-2.0-or-later license
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

C sources and headers in nfslock01 directory don't have a license.
Add GPL 2+.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfslock01/nfs_flock.c      | 1 +
 testcases/network/nfs/nfslock01/nfs_flock.h      | 2 ++
 testcases/network/nfs/nfslock01/nfs_flock_dgen.c | 1 +
 testcases/network/nfs/nfslock01/nfs_flock_func.c | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
index 92acceee9..5aba3340a 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Program for testing file locking. The original data file consists of
  * characters from 'A' to 'Z'. The data file after running this program
diff --git a/testcases/network/nfs/nfslock01/nfs_flock.h b/testcases/network/nfs/nfslock01/nfs_flock.h
index 09e3845f4..1cf7f45a3 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.h
+++ b/testcases/network/nfs/nfslock01/nfs_flock.h
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 #include <stdio.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
index 39abc549f..19acbd743 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * This program generates data for testing file locking
  */
diff --git a/testcases/network/nfs/nfslock01/nfs_flock_func.c b/testcases/network/nfs/nfslock01/nfs_flock_func.c
index 811136188..180338c57 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock_func.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock_func.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 #include <stdlib.h>
 #include <unistd.h>
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
