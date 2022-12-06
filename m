Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96529C352A1
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 11:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D1E03CC182
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 12:53:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 513F33CA9B6
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 12:53:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8970B1001182
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 12:53:43 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id BF0CF21BF9;
 Tue,  6 Dec 2022 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1670327622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dqt4jCrJ/A+H0/tzHVMo0OVJ2D3AlleayIXlfn/suPU=;
 b=IAlthZOEve1/5V7pqqDfyGBRZckkXUzwM8n9DwwMLQ4D3B0uMkXzuZk2Po8lSwduTj308i
 2vPq3oWJkYP5f2gozzw0/An1hMQ4+Msb0rSU/ynaMQ8tYI1qYt/5KYxQoS82DzZugUoVqW
 nnsDNKb0uQYla6Rw5dH26njQqsQ2dSk=
Received: from g78.cable.virginm.net (unknown [10.163.17.14])
 by relay2.suse.de (Postfix) with ESMTP id 88AD52C141;
 Tue,  6 Dec 2022 11:53:42 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  6 Dec 2022 11:53:28 +0000
Message-Id: <20221206115329.17760-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fs_fill: Add max_runtime = 60
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Usually it takes a few seconds (3-6) to fill up the device with
default settings. Which is too close to the default runtime.

This sets the max_runtime to 10x that to avoid random failures caused
by rare events.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Petr Cervinka <pcervinka@suse.com>
---
 testcases/kernel/fs/fs_fill/fs_fill.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 66b3974fc..95dfc2cb6 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -109,6 +109,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.max_runtime = 60,
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
