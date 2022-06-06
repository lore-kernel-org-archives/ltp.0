Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF8C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 18:44:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B78EB3C8DD6
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 20:44:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 487743C8CC5
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:43:40 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53114200042
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 20:43:37 +0200 (CEST)
Received: by mail-qt1-x830.google.com with SMTP id hf10so11009524qtb.7
 for <ltp@lists.linux.it>; Mon, 06 Jun 2022 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Cz3rBqmJs1ICCKIMUfdA2HzsX3NZL5o7DD2DoCI9XE=;
 b=hVKt8ndPnkS1DVyPV+1ZpwWRdl51z2MAE0/FIi3cMR9dmLlDNrsnucZiGqQ5M3DqhD
 TqMrY2cCI6qcXXP1d8XNGIvFArHVn0yqFomGvEOqqf39zA49YqyQto9c+1F0DOFC/x8r
 7zWaYJRwVLixqGYeuvtgXBkoIMWT10LAprX3SUK2iz+TyiVZNRYiFFgN1R1e0N0013ue
 aBuBEaCffIUbNY5USnNK9ogXScdMT7NzPKX46YKGTf+mgPJRn3Ak+evlhwV9dGbzOl4s
 y7MqO4GGyaAq7qA6c45bswMcIq8InXoT+pt3aOyDPbKvGLi8n71mEhidgdtQv/qnGW4M
 hCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Cz3rBqmJs1ICCKIMUfdA2HzsX3NZL5o7DD2DoCI9XE=;
 b=yHojrFMP80reNsUs/7EWYS/jp/vnb/flzlanZ5k7puzZv2codYgVf/F0AMvz9Se8c0
 +990mCetZQ/Z/tML6ca05uAwusijXIH18uNwsafxADAxDahWrbcZLoougnzbVniWJw1z
 LJ9N68YXtGmdnHVN+5lTlvuX33z0euga7PJnMfeIehmg87Kl5p1Ff1HC8whLBk52N3WG
 mDjW4ocEii8vVEufzTU88jjCzTfxQDUufRvi+7KJSgzdckrd2I350GpjVDAVj9x2UXBt
 1jASEWRbrPmWv5k0Q3aOYlnu60wuvGxKTFp0pJkZn59W11jg43b0SGw5bdFR6cI+UN94
 p//A==
X-Gm-Message-State: AOAM5326i1Ol0nT6bkDG5ytc5MuZF/xLho2VOTdLYdmLW0zD6VUtKp0T
 lyNzsianfdgXqCEmhRvBpyOKMPe4Da1rUYHg
X-Google-Smtp-Source: ABdhPJwg0BuQ6/ACAhxT4P99URfrqIgrZmmjkl9nBQp+xSJW0CGJN0ZhCmqPYRRyTwWj/8ykBK4/bg==
X-Received: by 2002:ac8:5956:0:b0:304:d85d:f16 with SMTP id
 22-20020ac85956000000b00304d85d0f16mr16929733qtz.606.1654541015982; 
 Mon, 06 Jun 2022 11:43:35 -0700 (PDT)
Received: from dell5510.arch.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a05620a291000b006a6bb044740sm3584880qkp.66.2022.06.06.11.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jun 2022 11:43:35 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  6 Jun 2022 20:43:18 +0200
Message-Id: <20220606184320.8210-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] LTP compilation fixes for buildroot toolchains
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

Hi all,

this fixes 2 compilation failures of KVM tests reported some time ago [1].

Kind regards,
Petr

[1] https://lore.kernel.org/buildroot/YofzKdQAUOnR2gSW@pevik/

Petr Vorel (2):
  kvm: Fix compilation on x86
  kvm: Fix undefined reference to __stack_chk_fail()

 testcases/kernel/kvm/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
