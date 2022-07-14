Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790A7C43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 15:25:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9DE83CAA08
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 17:25:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0219B3CA8F5
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 17:25:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 002F660146E
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 17:24:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16DC71FB71
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657812299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O/nav+YXIj5BWPmCxElO1JX4bXuzfUwPeQVXeZKa20s=;
 b=AvTAzl+a+s4DR0QCBgSkbXdIM+ROb0Iebwmjp0TouUWdiP3ESrXbcEPouGOSJf1MWegv2X
 +2EiVik0rmPM7xc5w2pkG6hMjU4yeb2WBlYT+L2Y/K1LhUGiKV6NTNxkETsOz+5+DCKT1j
 vbQgQ7XIcDl9oXbVZkNL+IDCvXyMTlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657812299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O/nav+YXIj5BWPmCxElO1JX4bXuzfUwPeQVXeZKa20s=;
 b=HgiWxwAZ5Kr7NiK58u2MJp5Y5JstPI3g1yY2KdZcK33h/jWqH4M64x/n7VYLTjTIhnBIFr
 GEni1WNCRaIJLkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8636813A61
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 15:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rf/BEUo10GJATAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 15:24:58 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 14 Jul 2022 20:54:55 +0530
Message-Id: <20220714152455.18050-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nice01/02/03/04: docparse comment
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
 testcases/kernel/syscalls/nice/nice01.c | 10 ++++++----
 testcases/kernel/syscalls/nice/nice02.c | 11 +++++++----
 testcases/kernel/syscalls/nice/nice03.c | 11 +++++++----
 testcases/kernel/syscalls/nice/nice04.c |  9 ++++++---
 4 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index aee5ea043..ee360bfbf 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -5,10 +5,12 @@
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
- *  Verify that root can provide a negative value to nice()
- *  and hence root can decrease the nice value of the process
- *  using nice() system call
+/*\
+ * [Description]
+ *
+ * Verify that root can provide a negative value to nice()
+ * and hence root can decrease the nice value of the process
+ * using nice() system call
  */
 #include <unistd.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index 036301000..1c7103758 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -4,10 +4,13 @@
  * Ported to LTP: Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
- *  Verify that any user can successfully increase the nice value of
- *  the process by passing a higher increment value (> max. applicable limits)
- *  to nice() system call.
+
+/*\
+ * [Description]
+ *
+ * Verify that any user can successfully increase the nice value of
+ * the process by passing a higher increment value (> max. applicable limits)
+ * to nice() system call.
  */
 #include <unistd.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/nice/nice03.c b/testcases/kernel/syscalls/nice/nice03.c
index 6047dd4cc..8198f2cf0 100644
--- a/testcases/kernel/syscalls/nice/nice03.c
+++ b/testcases/kernel/syscalls/nice/nice03.c
@@ -4,10 +4,13 @@
  * Ported to LTP: Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
- *  Verify that any user can successfully increase the nice value of
- *  the process by passing an increment value (< max. applicable limits) to
- *  nice() system call.
+
+/*\
+ * [Description]
+ *
+ * Verify that any user can successfully increase the nice value of
+ * the process by passing an increment value (< max. applicable limits) to
+ * nice() system call.
  */
 #include <unistd.h>
 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index 1d64311b3..ac156008e 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -4,9 +4,12 @@
  * Ported to LTP: Wayne Boyer
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
- *  Verify that, nice(2) fails when, a non-root user attempts to increase
- *  the priority of a process by specifying a negative increment value.
+
+/*\
+ * [Description]
+ *
+ * Verify that, nice(2) fails when, a non-root user attempts to increase
+ * the priority of a process by specifying a negative increment value.
  */
 #include <pwd.h>
 #include <unistd.h>
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
