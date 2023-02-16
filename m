Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4B3C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:48:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA6003CBEE2
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 12:48:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60CA73CB10B
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:48:40 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8456F1A00881
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 12:48:39 +0100 (CET)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 19BE43F206
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1676548118;
 bh=2lmFE1xXscjKzIm6+mh7CDVPJU0g2NCKJiynfa+myfI=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=daa66/XSFxMeGCuD2VhwuZZfXcEAJNkLTLJGZ0OhJ/1uGLB6STeihE9xHchC7Q9jL
 SIBpELRpdUTD6SdzdASE8rxa0G4sx9XzN0xScHOE6LB3oNZBvJYDWmny5K01Ujch/f
 nAZ5m9Uuse4O1TJqScA4bI60j5djGny5bM7SpqlTD32ayjAHGDNIfXG5RFM0oSUjmn
 AWjadc/MwZb197Ljfv/denqXJoDeI7RMvBv1ysAzEBCdg6WpzqroYwDxRfLpA3rB7z
 z0pxEvrrTz8ki82ldi4+qveNBwOnrgJrwJueJbHJzTJdxPBOvK3Sj+NBUbT0T33HlA
 PJ2fAizGh5PKQ==
Received: by mail-wm1-f69.google.com with SMTP id
 o42-20020a05600c512a00b003dc5341afbaso993973wms.7
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 03:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2lmFE1xXscjKzIm6+mh7CDVPJU0g2NCKJiynfa+myfI=;
 b=kF395/9i+o5hbEdT8TNSY1aHebC07WWnMw/10e43T0yAo2jWxzU0y1G/40Kqd1znI8
 S4rT9q2YIf3xPiie6W0iMO5rUHuEMCWjVPAs+hb5WB44eyVXbBGMPt77B31AAJa4pqz2
 3WcgfXWipGvvXJFvYmgtSMqK59AniNhHLRaPDM/4AzuwHq+90QS5mszbjUNT7iPI2pf/
 Lwlo3MqLw47+BJ9I1gcfz4ntA4GS0GSDN9IHnlzzCQeSIA449dZcZZw7HItIWjhKpBWq
 jA/4rHHxOI3ZnyRnNzTfgnmqu/oeS+OLhkbqwNVuZPNsa81Uey9xciAPdmKtzdWu1FLJ
 /8Fw==
X-Gm-Message-State: AO0yUKVxB4D/cedYjMMyDycItAW87kjPmfGc5lQucZ3Obc4GyQ09PHRz
 t31OMIeseWvYqraOFELYW699b358oBPrT6nGIYPHZKAWATsrKzti4cfdXg2ZsYnd/2TpXayno8t
 CGpgqnI0SoD0PLX3KHIcdDHlUK/ukQtDjFmKKKvU=
X-Received: by 2002:a05:600c:1987:b0:3df:f3df:29b0 with SMTP id
 t7-20020a05600c198700b003dff3df29b0mr4600849wmq.14.1676548117136; 
 Thu, 16 Feb 2023 03:48:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/HnnDJCKoOukI/fzU7Gtf/XLwmKt6nMi4Rv5LK445IpGkUoUNqo/9ZBUtmr+uUoUxvKB1Ykg==
X-Received: by 2002:a05:600c:1987:b0:3df:f3df:29b0 with SMTP id
 t7-20020a05600c198700b003dff3df29b0mr4600841wmq.14.1676548116887; 
 Thu, 16 Feb 2023 03:48:36 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c4dd])
 by smtp.gmail.com with ESMTPSA id
 bg30-20020a05600c3c9e00b003db012d49b7sm12655757wmb.2.2023.02.16.03.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 03:48:36 -0800 (PST)
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 16 Feb 2023 11:47:45 +0000
Message-Id: <20230216114745.2389810-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fs_fill: Fix test when running on a 256 CPU+ machine
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
Cc: Andrei Gherzan <andrei.gherzan@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The fs_fill test runs a fill test on all the supported filesystems. One
of them being vfat. This filesystem is configured dynamically or through
flags/arguments for its file allocation table type (12/16/32).

The size of the test device (which is a loop-mounted fs) is 300MB. When
not instructed, mkfs will "automatically select between 12, 16 and 32
bit, whatever fits better for the filesystem size"[1]. In the case of
a 300Mb that would end up as FAT16.

This is linked with another configuration that is the actual impact on
this issue: the maximum number of directories in the root of the
filesystem. FAT12 and FAT16 use a special system region: "Root Directory
Region". And by default (there is also an argument to configure this at
mkfs-time) this ends up being 256 when no custom arguments are provided.

On the other hand, the test sets up the filesystem with a
"tst_ncpus_conf + 2" number of directories in the test filesystem's root
which can break the limit explained above on systems with a number of
CPUs that would amount above the limit.

This change addresses this situation by using a subdirectory in the test
filesystem which is not subject to this limit.

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 testcases/kernel/fs/fs_fill/fs_fill.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 2027b6df1..dd8ad2935 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -18,6 +18,7 @@
 #include "tst_test.h"
 
 #define MNTPOINT "mntpoint"
+#define THREADS_SUBDIR "subdir"
 
 static volatile int run;
 static unsigned int nthreads;
@@ -99,9 +100,13 @@ static void setup(void)
 	nthreads = tst_ncpus_conf() + 2;
 	workers = SAFE_MALLOC(sizeof(struct worker) * nthreads);
 
+	// Avoid creating the thread directories in the root of the filesystem
+	// to not hit the root entries limit on a  FAT16 filesystem.
+	SAFE_MKDIR(MNTPOINT "/" THREADS_SUBDIR, 0700);
+
 	for (i = 0; i < nthreads; i++) {
 		snprintf(workers[i].dir, sizeof(workers[i].dir),
-			 MNTPOINT "/thread%i", i + 1);
+			 MNTPOINT "/" THREADS_SUBDIR "/thread%i", i + 1);
 		SAFE_MKDIR(workers[i].dir, 0700);
 	}
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
