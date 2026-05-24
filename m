Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924D0CD5BB1
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 16:17:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56E2F3E9E3D
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 18:17:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4B293C064D
 for <ltp@lists.linux.it>; Sun, 24 May 2026 18:17:33 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A14C2002BE
 for <ltp@lists.linux.it>; Sun, 24 May 2026 18:17:33 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so4230556a12.0
 for <ltp@lists.linux.it>; Sun, 24 May 2026 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779639451; x=1780244251; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dd7WbEWrEg6O6GEr9HVw87LkyAeVtB3bBsW+YCT2ME4=;
 b=j+98pGVVIDY6L91l+PKEw12iTwWFWE7F0ra9x9k85rIHbP/8nwaqf63NEYtFd7J/ri
 I1hj2wt3w2garYWDyGF9fISQOUy2jvVX5uUrRufFt/tmAz1Tu5cwcGHR6dCABGmSN9Dh
 8S1qDceJLafwf35vtZplzX+D7kfPrAkCkqOxad2QAabfcHEkxkUSiZMaf8aSmrDwQfXr
 P16HRIsOLaVwti9xMONJW5nR26G7ujU7G+nVgmXmia304JKHtxwyTEn6ScBWYqyjAb6S
 Sx+Bzuz/V2QW+bVi/SdQG9g9qwKFHV2BF3DCgtN5JY/xn1mkLsr/S11hI/2wPv1UTHI0
 Y7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779639451; x=1780244251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dd7WbEWrEg6O6GEr9HVw87LkyAeVtB3bBsW+YCT2ME4=;
 b=ii3owoOYWi/P+faY8v08AoKScnzqTbepHRPzt9D4Rc5dKQHME+fg7Pen0Xv6sm9DLt
 nQPE1bFTXo2weIspbfHvqTT4i9Fmc/e57E6qZnMMn6L9PaETk+ulxjVsYWZX+c6uSzJE
 hkpn13ECUrrcco69pRCwMGC1KekKuRGRrZfADpVQIYZqdESEoaAh5IAe0fk6qX5VSYBa
 HMn8yarD7x5Qggvwn6LvEGWe+i58WZwSC5i5ihtrjYGtyHN7P8VKR+hc4H+Mr5YgmLDW
 IHpRUQem8HBuHDhNvuvLhcEPIWcWF18DaE1I+5cRPFu5dy2ezvULmSYPQgN1rLRikZ5M
 r/xw==
X-Gm-Message-State: AOJu0Yyj1Or9T3Fg9++B8RPxVniD1LepnUy4w7mH7yLmARsP7WtFxYso
 X+M/Zc1SSayZAJYUz8ZRq5GK1Chz2f4ikczsFzp+qi6zrrZKAhxEFxiXMfjQbtprlQ==
X-Gm-Gg: Acq92OEEmY7w+oM6MjqQ5f1nmEHmyqdTb2x74EjEzMEj3lng6dvj8lEFq+GpEtFknCB
 SI5WQo0WZnCAeMAnLhkoyNDWNpYTNqLVfc6QMjb33VqzmoPG5VGIcmiUh54D3zKagWszty36a9p
 hh9InMFUyjtrsne7/gTRumTS4UHlUOUak1rNh/ht0advPlHlgyhR/c7Qd5knhH/CkpGIAl41jAN
 DfSFDAfXLwrUqIYZDVK7zSQ5jbO8nsBtRAyIFFZgsjfk0HGRAILWrBs/AZsz/Ah+WBABsJiWACe
 DJtxPVSQdk+aP9yzNRhRR3DBpKRJpjOnE7abCXyVaG53b8EB+cR2jNkfJ3jpFWAnASfvugUSOrX
 6sfPL+E4Mxd/xD/EjvRnzCwrEzQWAkj89TChM5ZT4zm3RlFO5P2ltRJdF6v22HRckjd+exfu4JC
 I9SCArSUmHgxAwprx9BCISgJUzQULUeWtMn2RCemz0fg==
X-Received: by 2002:a05:6a20:7f8c:b0:39b:ffd1:123a with SMTP id
 adf61e73a8af0-3b307ff2681mr13820994637.39.1779639451198; 
 Sun, 24 May 2026 09:17:31 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202ad588sm5832690a12.10.2026.05.24.09.17.29
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 09:17:30 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 01:17:03 +0900
Message-ID: <20260524161706.3510-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] getpid: Link manpage in docparse comments
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

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
Changes in v2:
- Split indentation changes into a separate commit
- Link to v1: https://lore.kernel.org/ltp/20260503085544.16915-2-always.starving0@gmail.com
---
 testcases/kernel/syscalls/getpid/getpid01.c | 3 ++-
 testcases/kernel/syscalls/getpid/getpid02.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index d9ba0953c..8fcd351d6 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -4,7 +4,8 @@
  */

 /*\
- * Verify that getpid() system call returns process ID in range <2, PID_MAX>.
+ * Verify that :manpage:`getpid(2)` system call returns process ID in range
+ * <2, PID_MAX>.
  */

 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 3da853d48..4d2402932 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -6,8 +6,10 @@
 /*\
  * Check that:
  *
- * - fork() in parent returns the same pid as getpid() in child
- * - getppid() in child returns the same pid as getpid() in parent
+ * - :manpage:`fork(2)` in parent returns the same pid as
+ *   :manpage:`getpid(2)` in child
+ * - :manpage:`getppid(2)` in child returns the same pid as
+ *   :manpage:`getpid(2)` in parent
  */

 #include <errno.h>
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
