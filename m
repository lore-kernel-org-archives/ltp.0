Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D0CC43334
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 18:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C74313C8CE5
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 20:44:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2179F3C8E4D
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:43:44 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 96796140033D
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:43:43 +0200 (CEST)
Received: by mail-qt1-x82d.google.com with SMTP id j8so8252139qtn.13
 for <ltp@lists.linux.it>; Mon, 06 Jun 2022 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bo/fYMmC9rIuON8EeC29aSaS1+pSCBAD7nOrPlT5jIU=;
 b=EJsWfr/JOunHHsiV+gSMdLmWRSxGv1fop2Aq3BzcRn15ieNL2TRFaax87Me4qDH/pJ
 Hz/7BgQCmPTBHvQTXnEWvn/MUeF0VPvH2t453PSp87JaIzgBg/uIaMW/TCc992k7tSLX
 PYgGkm0W0/kkFUChRVBwdLaSkIOA1wbtem5pAydVWG3/0vIDFxlC9ege6uh8xtyN6TlT
 XWJv4U5HqZXYlJSkxfSXJyLUDp5G0Mr1d/Af1fny3VZa7N2B/PBrfm1zCco3c+9Fcl+o
 w6k6KXS1R/ijCKXsM35SLQurALXa0lJth9siW6sgxKI6kwISG6WKL+YaSRZYa0d7ScS3
 radA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bo/fYMmC9rIuON8EeC29aSaS1+pSCBAD7nOrPlT5jIU=;
 b=uWKe4lL7JpuDAQtF262y33LEJS80q/bwMjK5isO0/T6s7fu+MWPh+PxgkgTRf8wJR5
 LnataxuM3XwAROqCJsMWupyzJV3k6mazrtiwTX376XdAKA4/1ZufqihcSeAJl2sAFefF
 KQ+w9RSLdE38+2fPxGXAlpGydbD8JQkGA6L12LCCCBniqJ2GR9zcvqXzIkheF7u6E2tJ
 Q/vzY+9imLQT6c/mUDUPyIWDx3wkVyuf0QwqL4anT/KzU4d//6wSAd6cqpQ5KgJeOGKt
 xPJ5tBbFE6fmrNioC7EY1P0pJO7QKHJtZxvFNSygGpyaSM18h+soykiLhumf732BLOsm
 AEuA==
X-Gm-Message-State: AOAM5320KEi3QidTEJ2y5/2PgPmIbNMEjSF+O5bQb4XRGS7X3s/xK/T1
 jx+cy0zHq4jGGsgcVRmr4AC3bDFOfMB1TeX6
X-Google-Smtp-Source: ABdhPJzwnoWrC0btaqCzezljmOf4hdBNLwVAb3X07pYV4J8QnEMs88qzpj8AY0x72L7SzrrdB0369g==
X-Received: by 2002:a05:622a:134a:b0:304:e0e0:a946 with SMTP id
 w10-20020a05622a134a00b00304e0e0a946mr13710124qtk.215.1654541022426; 
 Mon, 06 Jun 2022 11:43:42 -0700 (PDT)
Received: from dell5510.arch.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a05620a291000b006a6bb044740sm3584880qkp.66.2022.06.06.11.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jun 2022 11:43:42 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  6 Jun 2022 20:43:20 +0200
Message-Id: <20220606184320.8210-3-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606184320.8210-1-petr.vorel@gmail.com>
References: <20220606184320.8210-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] kvm: Fix undefined reference to __stack_chk_fail()
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
Cc: "Yann E. MORIN" <yann.morin.1998@free.fr>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Buildroot Mailing List <buildroot@buildroot.org>,
 Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some x86_64 buildroot toolchains (bootlin-x86-64-glibc,
bootlin-x86-64-musl) try to link to __stack_chk_fail().
-nostdlib is not enough, it requires also -fstack-protector.

x86_64-buildroot-linux-gnu/bin/ld: /tmp/ccgBXEoR.o: in function `handle_page_fault':
kvm_pagefault01.c:(.text+0x5d): undefined reference to `__stack_chk_fail'
collect2: error: ld returned 1 exit status

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index 8d5193d8e..bce1a4eb5 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -9,7 +9,7 @@ ASFLAGS =
 CPPFLAGS += -I$(abs_srcdir)/include
 GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
 GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
-GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none
+GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fstack-protector
 GUEST_LDLIBS =
 
 FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
