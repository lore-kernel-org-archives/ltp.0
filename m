Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E60D6A25D
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 23:49:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67F953D71FD
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 00:49:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E64E3D71FA
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 00:48:45 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 22E081BBF491
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 00:48:45 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so1019376f8f.2
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731628124; x=1732232924; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5XOSjKokoBwvjZP1LdheMUaTb3ntcK/kz8rjyToRCA=;
 b=Ux0yIZVCmVilOCCom84vqbVa4//htd9gAU3ZeDAprADQyTT6pYeyqYs3dZzY0+YFqq
 YpH5Tk7OvV0EpefvOQDOTIHTZHZ6/9+9UXKhoOxnk4aAVmC2+eecOOp4N2mlS/yzwJ6y
 1qPwaGm4ncx/eoA+4WCMcmXGR6WEz6wJhG4n0Yp0M+au6WQUCNoSSJv63qBSXXRRUXXF
 VFBcHDoWrMXXAKW2f/DS6IYimeP8L9ZKDxP2I2eV4VTPV7NUf+A6+cDVMZVoHP6vcZlO
 LlEbLP3kC2LXDXp2MhRjQd3llp8VsRklDSsNrBRd200ch07FzV1Qw3MRM8yVXzVjEbJ+
 qj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731628124; x=1732232924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5XOSjKokoBwvjZP1LdheMUaTb3ntcK/kz8rjyToRCA=;
 b=KMwmZh48JpFiXqLbs1C8CYlXA0vV9YaV12b2IhAEKonGa4c5sQnlHO8t6O5SjMz4B8
 X4zx3pRhA4rvOXanijjnEaLBxAhdXk+wDIvIEv+cKJMLS7EjGugrGgXN7gEbGcfYq/7V
 7Kwcr06VJxvbgF7FSVh5gV/l0FXNtj3O18Kv4/FiKnVi6rgDyiphq2L4JP5on632ExVH
 sd16MagGscDBW5L7dmxsClVQBMLJ/kBCqRKrHi8LOk/S5LgDBtTeUmDr9bp5oedd6Q7T
 3hcCeX2UIN8DEaCl1WJVdFCfpqeZromBULfoHlO46cCIRUhmBqF6bPowq98XuDLOsmuW
 dD9g==
X-Gm-Message-State: AOJu0Yx8kWp3ZofS94vi4tNNG6Ks165oRsbjC72C2+M2sjchYM8YIrOx
 8UxHE4dIAcO5gWgx5K4OXk6hytsS3gj2Ez4gUwt9NpZ/snBtUwxE1vDsNw==
X-Google-Smtp-Source: AGHT+IH0czxFe1NIzZKs9HbHSF2tmU1e3gwvl/aUKOYycaRIEq5q4snNTMXXznOsxE8qfCno8dqNRg==
X-Received: by 2002:a05:6000:4023:b0:37d:4319:f8c6 with SMTP id
 ffacd0b85a97d-38225a21e11mr442058f8f.7.1731628124479; 
 Thu, 14 Nov 2024 15:48:44 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada2e35sm2789402f8f.5.2024.11.14.15.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 15:48:44 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 00:48:36 +0100
Message-ID: <20241114234839.1680432-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114234839.1680432-1-petr.vorel@gmail.com>
References: <20241114234839.1680432-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] rt_tgsigqueueinfo01: Use siginfo_t portable
 members
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

POSIX API for siginfo_t expect simple struct members (see man
sigaction(2)). Most of the implementations (including glibc, uclibc,
musl, bionic) combine many fields into union due optimisation. To
achieve POSIX API compatibility implementations provide definitions
to access members.

Depending on glibc/uclibc specific internal implementation was wrong.
eea3ba496b attempt to add bionic support. To get musl (or whatever libc)
support do what should have been done from the beginning: use portable
members.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 .../rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c        | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
index bee6a62713..2f603be945 100644
--- a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
@@ -25,12 +25,6 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-#ifndef __ANDROID__
-#define SI_SIGVAL si_sigval
-#else
-#define SI_SIGVAL _sigval
-#endif
-
 static char sigval_send[] = "rt_tgsigqueueinfo data";
 static volatile int signum_rcv;
 static char *sigval_rcv;
@@ -39,7 +33,7 @@ static void sigusr1_handler(int signum, siginfo_t *uinfo,
 			    void *p LTP_ATTRIBUTE_UNUSED)
 {
 	signum_rcv = signum;
-	sigval_rcv = uinfo->_sifields._rt.SI_SIGVAL.sival_ptr;
+	sigval_rcv = uinfo->si_ptr;
 }
 
 void *send_rcv_func(void *arg)
@@ -51,7 +45,7 @@ void *send_rcv_func(void *arg)
 
 	uinfo.si_errno = 0;
 	uinfo.si_code = SI_QUEUE;
-	uinfo._sifields._rt.SI_SIGVAL.sival_ptr = sigval_send;
+	uinfo.si_ptr = sigval_send;
 
 	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
 			 syscall(__NR_gettid), SIGUSR1, &uinfo));
@@ -113,7 +107,7 @@ static void verify_signal_parent_thread(void)
 
 	uinfo.si_errno = 0;
 	uinfo.si_code = SI_QUEUE;
-	uinfo._sifields._rt.SI_SIGVAL.sival_ptr = sigval_send;
+	uinfo.si_ptr = sigval_send;
 
 	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
 			 tid, SIGUSR1, &uinfo));
@@ -130,7 +124,7 @@ void *sender_func(void *arg)
 
 	uinfo.si_errno = 0;
 	uinfo.si_code = SI_QUEUE;
-	uinfo._sifields._rt.SI_SIGVAL.sival_ptr = sigval_send;
+	uinfo.si_ptr = sigval_send;
 
 	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
 			 *tid, SIGUSR1, &uinfo));
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
