Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06625C64ED6
	for <ltp@archiver.kernel.org>; Sun, 26 Feb 2023 19:26:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FDEB3CBA81
	for <ltp@archiver.kernel.org>; Sun, 26 Feb 2023 20:26:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D8F13CAD39
 for <ltp@lists.linux.it>; Sun, 26 Feb 2023 20:26:03 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84BB720098F
 for <ltp@lists.linux.it>; Sun, 26 Feb 2023 20:26:02 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id t15so4127071wrz.7
 for <ltp@lists.linux.it>; Sun, 26 Feb 2023 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U62Arrv6ChKVu1tuCtkM8NMK36ga7uDzNIRKdBNtjBg=;
 b=fHvwyADCZ5Sz8E/+DthJd2q1LLzXMG5x2toKPQJhhvHUviNUSrYyJlbw8grK+fPGuq
 D0LrDLmz/qO1SBddJYhSBFNDcoBpY73slVWMtRnfO48RgtAx3ztT3wuimXL8F5fsDCEv
 V/ggLJaKu6Ncw0MZ4aPC4vqzp4qkMGVEoXacPmeNFbSDduAh9sFinWjzjGJQC+leNN57
 sG61Yt3iZMyYSaued6kkurec+lMq7rNFhCZ2WbeKnGt75UJLD43jYE8HderWtIUIu6jV
 60WBh0schcpvgi+iafR1kUgw7KhHlKhXUy1Ga237T7XEeS0tyjUODN5GEUpkKRAORges
 rqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U62Arrv6ChKVu1tuCtkM8NMK36ga7uDzNIRKdBNtjBg=;
 b=rhefUL9lcUhtz+932qskMU74OzDU7FQuj3dybecKYsJnfkoa8x0/9fBYgYYQn+Euyr
 /yu9DVCZQkdp++BiWZVMDT8QX2B3yo+LSTvlE6LqcgQk3OzCYi/7jZ1kSiTI/eQLUKkx
 nzjdQ4K0Rel7FKZqe57j/DUL92/zmSlDw2bs0Be3EyTrUjgVNJhZIP/0snxHJiLL/JHW
 mcQ1JHcIYPTREFZgkzHTOHytepmNXE3qt9nQI/E2cIOaT8tC2hlJSV8Ixx8uFW/11zyG
 zuGfC6hXX/zn8rHjldid2KTFaiLy8vJZmHJtx47QLGGbBGnkLETq/d/m3GH+8Kdtf2he
 fCZg==
X-Gm-Message-State: AO0yUKWePEIglplesgg8Qg7tJvB3oOWgw3obavBTwqxDh6Gq5wLpIpai
 N9Hnph3Z56MahzCCqLUm8s5W55O/3qo=
X-Google-Smtp-Source: AK7set9LfJ6Yj3xs+lmEenIDZD5MPS5+7dI4Q1lr+BLT+yo0XNaJKz0xnDgNomXVuXjqkxXIhlOglw==
X-Received: by 2002:adf:f208:0:b0:2c8:4bca:7fc2 with SMTP id
 p8-20020adff208000000b002c84bca7fc2mr6568979wro.4.1677439561610; 
 Sun, 26 Feb 2023 11:26:01 -0800 (PST)
Received: from kali.home (lfbn-ren-1-787-165.w83-197.abo.wanadoo.fr.
 [83.197.114.165]) by smtp.gmail.com with ESMTPSA id
 l17-20020a5d6691000000b002c54e26bca5sm5104985wru.49.2023.02.26.11.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Feb 2023 11:26:01 -0800 (PST)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 26 Feb 2023 20:25:54 +0100
Message-Id: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit b857f8723f30a4b9554bf6b0ff8fa52fd07e8b60 tried to fix build with
latest glibc which provides mount_attr in sys/mount.h. Unfortunately,
the following build failure is still raised because sys/mount is now
unconditionally included in include/lapi/fsmount.h:

In file included from fsconfig01.c:9:
../../../../include/lapi/fsmount.h:55:8: error: redefinition of 'struct mount_attr'
   55 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from ../../../../include/lapi/fsmount.h:14:
/home/autobuild/autobuild/instance-4/output-1/host/armeb-buildroot-linux-gnueabi/sysroot/usr/include/sys/mount.h:210:8: note: originally defined here
  210 | struct mount_attr
      |        ^~~~~~~~~~

Fixes:
 - http://autobuild.buildroot.org/results/4dbb72e1bf081afd3cd944571b9beeefc7608865

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index c2b0f48e7..a6d8ac826 100644
--- a/configure.ac
+++ b/configure.ac
@@ -225,10 +225,10 @@ AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struc
 
 AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
 AC_CHECK_TYPES([struct mount_attr],,,[
-#ifdef HAVE_LINUX_MOUNT_H
-# include <linux/mount.h>
-#else
+#ifdef HAVE_MOUNT_SETATTR
 # include <sys/mount.h>
+#elif HAVE_LINUX_MOUNT_H
+# include <linux/mount.h>
 #endif
 ])
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
