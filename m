Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73121C43334
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 18:43:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0C4C3C8D6D
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 20:43:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6277A3C01AA
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:43:40 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F15411A003D0
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:43:39 +0200 (CEST)
Received: by mail-qv1-xf2d.google.com with SMTP id i19so10786418qvu.13
 for <ltp@lists.linux.it>; Mon, 06 Jun 2022 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iqu941lzTAMX+oaALcJPphLtVNbm3omYD1fanuV+3bQ=;
 b=UodjcFvV2gT88Pd59oJsueHKUtddZZ4+1d6GaYSBAqRND/g6Tebt6flUgNZE3YQzSa
 F3A5VTAT4ipV3OC2X8abfr2sbYaazV/lj9+QiA12TMb0f8IE7a1M4ktkKHtSAOyznb/l
 4peHVkEaeYnoZ2bbEIXTAux063xy0dGiSA99yBhf3BpGlTjxqrM1n5Xfdj4l5+kXZa1E
 ff2rWfcAqrvjJI0VXo0CscO1pyNrGb/zu1sf3Ig2mF4zQgbd0Q5gkBTwB0phkPpvNCbt
 YG8J6GaNA+jiy/oDKvuxpKLDYmk0C72RwLBS6xWWa+0vi/NejRJm7aBNFPJ2vJntcMdJ
 q+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iqu941lzTAMX+oaALcJPphLtVNbm3omYD1fanuV+3bQ=;
 b=k21UYxwkCeMx5xKQ03AIjI360Yi4OuIbMjEJjJVg8VfQ39/TNKgRDiCXjjTnAxkg/Y
 EpUj1Vo2rKdYgRpKNa9/Pd1oZK9pVHi0YrZYqscw6OetsN2xck4QvCH5UtUunHY/qlB0
 CJXSA1eKq7fobXkQ+X1mSqS7Bd6Zzoh98nCUjC0YeDGkNZ3Wz0MMU6WPeg8ykYBWrVaX
 WqpYNy9oPV6mGoUeEteRnUJutySnSlLIRmZtQKa9qY1ZWqyTgB2GXsZG4v2MiOQq5PyP
 jVgqKz8itSBKZlsEU520hCvYXHh1pzAab/vGaBT31xx68LV8sxl+3MqI55RKHywNXXlF
 vmGw==
X-Gm-Message-State: AOAM532zO+Vrl3DUCQBGH+FFzHOZzucvlIUqMVwTyeAJtAX82DR7sTyv
 UwSqPVlARC11QcTK+Zz5p182QN1c9vwghEkC
X-Google-Smtp-Source: ABdhPJwoShGMRMlJYjLu9vRtMwQxGGavqGckxG4fAGiXtj7kpfhe/jvkIfvxjN9skw/is88lRlD7ng==
X-Received: by 2002:ad4:49ac:0:b0:46a:effd:fbd0 with SMTP id
 u12-20020ad449ac000000b0046aeffdfbd0mr8605728qvx.13.1654541018754; 
 Mon, 06 Jun 2022 11:43:38 -0700 (PDT)
Received: from dell5510.arch.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a05620a291000b006a6bb044740sm3584880qkp.66.2022.06.06.11.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jun 2022 11:43:38 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  6 Jun 2022 20:43:19 +0200
Message-Id: <20220606184320.8210-2-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606184320.8210-1-petr.vorel@gmail.com>
References: <20220606184320.8210-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] kvm: Fix compilation on x86
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

Buildroot supports i386 pentium toolchains (br-i386-pentium-mmx-musl,
br-i386-pentium4-full) which fail to compile because as is run without --32.

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/kvm/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index adab56952..8d5193d8e 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -17,11 +17,14 @@ FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
 ifeq ($(HOST_CPU),x86_64)
 	ifneq (,$(findstring m32,$(CFLAGS)))
 		HOST_CPU = x86
-		GUEST_CFLAGS += -m32
-		ASFLAGS += --32
 	endif
 endif
 
+ifeq ($(HOST_CPU),x86)
+	GUEST_CFLAGS += -m32
+	ASFLAGS += --32
+endif
+
 # Some distros enable -pie by default. That breaks KVM payload linking.
 ifdef LTP_CFLAGS_NOPIE
 	GUEST_CFLAGS += -fno-pie
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
