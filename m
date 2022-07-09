Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8232C43334
	for <ltp@archiver.kernel.org>; Sat,  9 Jul 2022 16:50:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A5303CA4D0
	for <ltp@archiver.kernel.org>; Sat,  9 Jul 2022 18:50:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2F473CA2E9
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 18:50:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0B10B6006C4
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 18:50:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C4761FA93
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657385403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OPO22BOfM7w7U9ktN84mul4JVwffo+7Z6DwM0rrsKW0=;
 b=DBxprMyYAIxvIopb1kxV7sCJPVa9UYVJ45K/y1CbTh1qpyWAWIRluAh5Xf+gKau+FD0B2F
 tmlRWkLpE8iPmmcTMmTSASXokzvBKBJRi20mEc1z9fPvXjbf2jOSMh4F3tixxOlverAGsD
 BtVCL+Nb00MvhyYw/EoLe65uqg66cjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657385403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OPO22BOfM7w7U9ktN84mul4JVwffo+7Z6DwM0rrsKW0=;
 b=RjpvUmfUPmhKxta8xilhpiOKkEcwuplSe/+8xAHf9G/hb9XLGmr4pY0lFHhh0UBTkVy8rn
 sDIdKg4OWCFayIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9CCC13482
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 16:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P18qGrqxyWJMagAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sat, 09 Jul 2022 16:50:02 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Sat,  9 Jul 2022 22:19:58 +0530
Message-Id: <20220709165000.27830-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open08.c: Docparse format and rewording of description
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/open/open08.c | 38 +++++++------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 10f55fb90..5e1cf82f9 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -4,35 +4,17 @@
  *   Copyright (c) 2018 Linux Test Project
  */
 
-/*
- * DESCRIPTION
- *	Check for the following errors:
- *	1.	EEXIST
- *	2.	EISDIR
- *	3.	ENOTDIR
- *	4.	ENAMETOOLONG
- *	5.	EACCES
- *	6.	EFAULT
- *
- * ALGORITHM
- *	1. Open a file with O_CREAT and O_EXCL, when the file already
- *	   exists. Check the errno for EEXIST
- *
- *	2. Pass a directory as the pathname and request a write access,
- *	   check for errno for EISDIR
- *
- *	3. Specify O_DIRECTORY as a parameter to open and pass a file as the
- *	   pathname, check errno for ENOTDIR
- *
- *	4. Attempt to open() a filename which is more than VFS_MAXNAMLEN, and
- *	   check for errno to be ENAMETOOLONG.
- *
- *	5. Attempt to open a (0600) file owned by different user in WRONLY mode,
- *	   open(2) should fail with EACCES.
+/*\
+ * [Description]
  *
- *	6. Attempt to pass an invalid pathname with an address pointing outside
- *	   the accessible address space of the process, as the argument to open(),
- *	   and expect to get EFAULT.
+ * Verify that open() fails with:
+ * - EEXIST when pathname already exists and O_CREAT and O_EXCL were used.
+ * - EISDIR when pathname refers to a directory and the access requested
+ * involved writing.
+ * - ENOTDIR when O_DIRECTORY was specified and pathname was not a directory.
+ * - ENAMETOOLONG when pathname was too long.
+ * - EACCES when requested access to the file is not allowed.
+ * - EFAULT when pathname points outside the accessible address space.
  */
 
 #define _GNU_SOURCE		/* for O_DIRECTORY */
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
