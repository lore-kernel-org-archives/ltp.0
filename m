Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744CDC43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:38:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22073C941C
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:38:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E72FE3C04C3
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:32 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E11810008FE
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 16:38:32 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 p6-20020a05600c1d8600b0039c630b8d96so4033648wms.1
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LvNSJuB2jQMB/0yK3t3jv/YB/2zq7GUDB3XmXfCymvI=;
 b=DjP4F39m3D20kLYeIpPeJ61F7MScixq10cDIYDP/JbTJSA0OET0NSVEqz7zlccCJ51
 nDDbvElXBnQi9SfMpWRPVboYxqdw4lDrjLNuuM7/IV4KCbS12BGEj+G4yPFyw4YIvpzt
 jQfQEOeDzLAvVfp8zsD9sMLsMoy7HJlcQibrxj4XTZ9+yMR4SbZ/JfONJQUhdRYoy3za
 mmWi3LObuTiBPRUYONEth9BDNWIZXQX2lpLdIWfzwVFSkbVtyjBIDPDpLfRdjNck+GBh
 2+v/WkayZmLOoynt943KR8DEFuLzX8V6MfSS2DlEKm7qd3a+223FFOUq2m98a5A+LZlO
 0amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LvNSJuB2jQMB/0yK3t3jv/YB/2zq7GUDB3XmXfCymvI=;
 b=hQ7Rw0PzWGfRVEvUq8VSqx+vd/56FKfOG8G+1GKtJNSF398aPeijEOy/zamn9pGjqF
 UEEsEzRm2yI6enhMAfDmmB7TcYvQCwf59u2z4RG+wUCg/EnpW1GX/dLbVV4QQsBi+dvH
 fl64B4hHcYJP6YFAGvQbCGpeENta4KxLE3vIl9C26QAbJiirvp05td6CmaNRrdsT9HYs
 iJNDv05q7RdSDkkk7lNbTEdGtbRHP6M8bGlSlPg8+6QEsEXVWqSbx8tFlTW10FeKjkzf
 M9bpoPWXTSngVmv2RSZhTD6M96x/TM0do8/pZegEhtWpSF6rm8PKffApN5GFnJoFyC/D
 jMbw==
X-Gm-Message-State: AOAM532MRsyrL9/vgxb+yZbWBhWrd0px/rXNrxZqaexGh3om36leI8dX
 V/lFvyGEeSNxyNbK7BIvpXI=
X-Google-Smtp-Source: ABdhPJwg8gtyb9Rh/HNCnhYSqkF7rPaZ4RV3tZye/wsqTwLl1BAD9xhlMVErjz71baoizZKIkzLFoQ==
X-Received: by 2002:a1c:e903:0:b0:397:36b8:795a with SMTP id
 q3-20020a1ce903000000b0039736b8795amr15414546wmc.98.1655131111859; 
 Mon, 13 Jun 2022 07:38:31 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b0039c55bc2c97sm14833072wmq.16.2022.06.13.07.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:38:31 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Jun 2022 17:38:21 +0300
Message-Id: <20220613143826.1328830-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] Fanotify tests for FAN_MARK_EVICTABLE
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

FAN_MARK_EVICTABLE feature was merge in v5.19-rc1.

Here are the tests for it.

inotify12 is a test for an unrelated fix.

Note that fanotify23 is run on ext2.
That is because, I could not find a way to reliably evict
an inode on any filesystem and the rain dance I did with
vfs_cache_pressure and drop_caches works reliably with ext2
on my test setup.

If that turns out not to work on other systems, we will need
to re-think of a more aggressive way to force inode eviction.

Thanks,
Amir.

Amir Goldstein (5):
  syscalls/inotify12: Introduce test for inotify mask flags
  syscalls/fanotify23: Introduce FAN_MARK_EVICTABLE test
  syscalls/fanotify10: Watch directory that is not the mount path
  syscalls/fanotify10: Mount cycle between test cases
  syscalls/fanotify10: Add test cases for evictable ignore mark

 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |   4 +
 .../kernel/syscalls/fanotify/fanotify10.c     | 131 +++++++--
 .../kernel/syscalls/fanotify/fanotify23.c     | 258 ++++++++++++++++++
 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify12.c | 168 ++++++++++++
 7 files changed, 546 insertions(+), 19 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify23.c
 create mode 100644 testcases/kernel/syscalls/inotify/inotify12.c

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
