Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B103C19F2C
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 05:16:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 399A83C98AA
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 07:16:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F76F3C96E5
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 07:15:46 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8564710006C5
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 07:15:45 +0200 (CEST)
Received: by mail-pl1-x635.google.com with SMTP id t3so356575ply.2
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=LO2SjgNkaYYExEEDtxNJ+NTRG5h3aa/zS0/+WKK/gX8=;
 b=AJpn8508PRkrQpoMHzuaCA7YC/Ys7Eo+LLn9FKWNK/5Zq/elPE9BDVygCpiYaBqTOT
 0x7UvXoGD/FIM88tXJup2otJfKk7Bmmzr3+mQSW1f0H7uFMswD/qEOBA9kueZAac+Nia
 pXZz695+1P1KvgX2d2iQotfshEEOFncbF97azi3hlux2g49bBjJJtnVFhEsqvpvPnqQH
 7BWbE3SYFQiSSY+0BzEFrkZFa0uYKlQnqNsIRIpmF8sWmWHYJfwCB6FR0VStKaGfe4qn
 cK+oC9Q4yBRmi9ndpIGzZCMveyF97hDRG6vh287clAXhgBGS6bBKDqVzEtWgu2EAbJhs
 GDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=LO2SjgNkaYYExEEDtxNJ+NTRG5h3aa/zS0/+WKK/gX8=;
 b=co9qhoPButzvcz1vrLPGDI8q+aiRmQfUfd7Dz0wt6wS9gOWJNNnWGHv7SnII0eT5Bt
 sfRYCFrmzaCEzLzMurbYTczWDIpdfi5b+mEjrsRyRhkqS+9R7U+DG2bSAyGvBFzRCrxV
 uiI+sv6in5ZWhKJkPTYQ9XeO0FlFNmx8Wjnhk5cwmrQyyM+imsOWVauGHtmyZiplQDjQ
 npiQaLWbyN/JGpLHkhXM5AhCzLbWDS5ZfKgSsAQ/fpMh5odWg0YClBRrJztlf3HWsl21
 suuuZIKdB1OjZ1Fzcye+WlOGRmAbwf2Ohff1G7Pi3UCYm50TcdTkpj6xGJlnTYNOrIF+
 0PpA==
X-Gm-Message-State: ACgBeo2PpBrEVLZL3Npep3m9Bj5/c5pnsoLWsGNYvRWAOQ01MVA4uGJy
 L5OipYboNEG925XZAFKcMr2DmTegQ7CMKA==
X-Google-Smtp-Source: AA6agR7YuUP9K4SUnVWuI23CClxA4go4fAr1hpiWps5s8mmtDu+TQXt7BZJe91ogXWM06tqgdZtZ4A==
X-Received: by 2002:a17:902:ce0e:b0:172:69cc:60aa with SMTP id
 k14-20020a170902ce0e00b0017269cc60aamr9838333plg.31.1660626943456; 
 Mon, 15 Aug 2022 22:15:43 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::bb7a])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a170903245200b001641b2d61d4sm7965252pls.30.2022.08.15.22.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 22:15:42 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 15 Aug 2022 22:15:39 -0700
Message-Id: <20220816051539.2948547-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816051539.2948547-1-raj.khem@gmail.com>
References: <20220816051539.2948547-1-raj.khem@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Fix conflicting linux/mount.h and sys/mount.h
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
Cc: Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

glibc 2.36 mount.h is conflicting with linux/mount.h [1] which is included
by linux/fs.h via lapi/fs.h, as a compromize define needed macros from
linux/fs.h and avoid the conflict

[1] https://sourceware.org/glibc/wiki/Release/2.36#Usage_of_.3Clinux.2Fmount.h.3E_and_.3Csys.2Fmount.h.3E
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 include/lapi/fsmount.h                    |  5 +----
 testcases/kernel/syscalls/statx/statx09.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 3609855f6..a61711d52 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -12,11 +12,8 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 
-#ifdef HAVE_LINUX_MOUNT_H
-# include <linux/mount.h>
-#endif
-
 #include "lapi/fcntl.h"
+#include "lapi/mount.h"
 #include "lapi/syscalls.h"
 
 #ifndef HAVE_FSOPEN
diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index aea329e08..e03f29613 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -18,14 +18,22 @@
  */
 
 #define _GNU_SOURCE
-#include <sys/mount.h>
 #include <stdlib.h>
 #include "tst_test.h"
-#include "lapi/fs.h"
 #include "lapi/fsverity.h"
 #include "lapi/stat.h"
+#include "lapi/mount.h"
 #include <inttypes.h>
 
+/* define neded FS_* macros to avoid linux/fs.h conflict with sys/mount.h */
+#ifndef FS_IOC_GETFLAGS
+#define FS_IOC_GETFLAGS _IOR('f', 1, long)
+#endif
+
+#ifndef FS_VERITY_FL
+#define FS_VERITY_FL 0x00100000 /* Verity protected inode */
+#endif
+
 #define MNTPOINT "mnt_point"
 #define TESTFILE_FLAGGED MNTPOINT"/test_file1"
 #define TESTFILE_UNFLAGGED MNTPOINT"/test_file2"
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
