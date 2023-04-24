Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4273C77B73
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 18:47:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49BBC3CE9FE
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 20:47:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7B5F3CBC8E
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 20:46:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF4A01A006FD
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 20:46:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 152AE1F74D;
 Mon, 24 Apr 2023 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682362011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=w8z7RjC7lJsaqlTKb1TuRM0+LdyCJGlGA3M5Udfodzc=;
 b=K/Bc9nw2x+VCwl/pHwZfL6qTO+1jllReKNNOIyHEUkyRW6zHUOoJoE9V5vhdIwyB/zMt0P
 fTn9ke8sWZ86Z8sjmeSQiFt366kFqQW8tpxrnhwgKAEu3N3UCfPCiQ1YPdEhfDOR5qVzfp
 9+VRRhkZW6HlU8T+b9ypCXzkcK7Mmtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682362011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=w8z7RjC7lJsaqlTKb1TuRM0+LdyCJGlGA3M5Udfodzc=;
 b=i+22/RLLficIVDP/XXzTH9vXypQKgKwBXqNpFbVh215O51LJWaYYU89heCqYEzoF2mx8xU
 N7a8zgC11H06CkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2A6A1390E;
 Mon, 24 Apr 2023 18:46:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ab0oIJrORmSKVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 18:46:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Apr 2023 20:46:57 +0200
Message-Id: <20230424184658.2858634-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] nfslock01: Add GPL-2.0-or-later license,
 copyright
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
 testcases/network/nfs/nfslock01/nfs_flock.c      | 3 +++
 testcases/network/nfs/nfslock01/nfs_flock.h      | 5 +++++
 testcases/network/nfs/nfslock01/nfs_flock_dgen.c | 3 +++
 testcases/network/nfs/nfslock01/nfs_flock_func.c | 5 +++++
 4 files changed, 16 insertions(+)

diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
index 92acceee9..fe345780e 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock.c
@@ -1,4 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2001-2023
+ *
  * Program for testing file locking. The original data file consists of
  * characters from 'A' to 'Z'. The data file after running this program
  * would consist of lines with 1's in even lines and 0's in odd lines.
diff --git a/testcases/network/nfs/nfslock01/nfs_flock.h b/testcases/network/nfs/nfslock01/nfs_flock.h
index 09e3845f4..6ed9eb689 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.h
+++ b/testcases/network/nfs/nfslock01/nfs_flock.h
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2001-2009
+ */
+
 #include <stdio.h>
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
index 39abc549f..129121d9e 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock_dgen.c
@@ -1,4 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2001-2023
+ *
  * This program generates data for testing file locking
  */
 
diff --git a/testcases/network/nfs/nfslock01/nfs_flock_func.c b/testcases/network/nfs/nfslock01/nfs_flock_func.c
index 811136188..0896e9ae6 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock_func.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock_func.c
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2001-2012
+ */
+
 #include <stdlib.h>
 #include <unistd.h>
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
