Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B41FCCD184
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 19:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E35273CEB43
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 21:50:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9204F3CE88E
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:49:53 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E6572200753
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:49:52 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b40f11a1027so638677166b.2
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760298592; x=1760903392; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P8c8wGYKxsXfNZ9ZjEWrPdDPIMZj9XcuoCAi1fQrhO0=;
 b=HBIVenoakZE/odd1VqB70f/4XxoUadKz32sQlStz4oSg/bXDhn3vIJus4r85LxjF7J
 P9hH8R8O+hT2cgPNPZlIuEPkU7rgZgzeRKOA0XReT42GvFteWd9le9CFUzwMw/l5XxYP
 a3o2Ovv/VAgtUAYk+D7+vflfOUBLzdf7TlAj/FQ7na0LXkzTgjy/fM/TU1aKobTsJoQ8
 W0j9JZ1ee66GRUdUdOgae3akb9YQlzOyJr8zKiC7aBLVaf7PCRQR0M46sfNi6MyBB1PP
 1eMiCSEcF7R1ZWkTEE3a3Af+5S0DYzLuHx2mMYNeL+Zhq9Z5gAWgIQ9gVjNTwA6rGjLI
 Td6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760298592; x=1760903392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P8c8wGYKxsXfNZ9ZjEWrPdDPIMZj9XcuoCAi1fQrhO0=;
 b=U54aTwJ8fznfJjQ2NjOXj3PoLCI1DoKDGStkN7+OCJQUi/yhYxpxAMO8wTvdX6biD+
 +f2Jxt70+YK/sk2ogSrCyqbAVAAXWh+joc5huy+1bM1E+gf1YmGcmMWPFiTtaIC1ChTT
 bc55RDM8h2zlOgBAuU57yqwP0CZ7A1D4Eqm1VmJW8tZk1YKcGhLug+/uosMXT2dBqLVK
 Xw+hFuD8ZJlnSrig+6rcWieqMCqNHvOGKy9r6gy5zUS7aw9EyXwMB71+t6mVnsjLRg2o
 KzbVPWcGXKmKQ4caGH5vyF57xhA2EiknkPi6MluTG7tghoX1251c1cnoxDbQje59cLoJ
 zNEA==
X-Gm-Message-State: AOJu0YxmQIafjSAspVzRlIVBTdzooL79UY2cgR2YJYMFeQHLTcgmOOnY
 rQO/fHzmC0gAm9/37Tpv844ioz6zXrvrVwei1wqvBrPHhr/CrRKzUMsrs326cace
X-Gm-Gg: ASbGnctR4RIZ8sG2JcTmdp3rDeForlWeO42LIYQ/94CLWUXTnq2MOqbUEzhPqT9V6b0
 SyEvoQ7cdNMUKbrTM01wda03mJGAdcT+Ekmk5wn2R5c84oUdEpstSs4V7Qpr21lpMlcJw1eWx6N
 /Ksm6SI483eK435tKNslaNDTNz8IiXYXZPMFBve3McPBBWC2JkhDagQq+Nzz8zi4BXU9JXzTn1Q
 HJAP+ImykqwsSX8oekuUoOozjnnMuK0QyGUpdTtjm9mJ1MU5B60/ArcM7c5ToABawVdfi+ERtnQ
 oCy09WleRqmRyhcbxbn0eM5fIXXjfFo6MI64DQurwyKVfgE8S8GEYyUOHS1Q1y3iifCIIbREpov
 uA65rwucC7kYR8vllr249VospEUPddDqM6ZnaVmX/WULNNU/6nbvcCHzDojo66dHPAQ==
X-Google-Smtp-Source: AGHT+IHDQPzRRfcnFPF9xWiqVSGmeBQMLisggwflNU+J5Fs2hBzbZ+BorJRDNMIfdOU3IBOORqXpAw==
X-Received: by 2002:a17:906:af09:b0:b3d:b251:cdec with SMTP id
 a640c23a62f3a-b50abfd5e91mr1576869466b.37.1760298592220; 
 Sun, 12 Oct 2025 12:49:52 -0700 (PDT)
Received: from x230 (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cad938sm767759466b.2.2025.10.12.12.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:49:51 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 12 Oct 2025 21:49:44 +0200
Message-ID: <20251012194946.370905-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] __builtin___clear_cache() => __clear_cache()
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I'm sorry for the noise. Changes v1->v2:
* Add missing #endif in the second commit.

Link to v1:
https://patchwork.ozlabs.org/project/ltp/list/?series=477318&state=*
https://lore.kernel.org/ltp/20251012194007.370008-1-petr.vorel@gmail.com/T/#t

Petr Vorel (2):
  m4: mprotect04: Replace __builtin___clear_cache with __clear_cache
  hugemmap15: Check for __clear_cache()

 configure.ac                                  |  2 +-
 m4/ltp-builtin_clear_cache.m4                 | 19 ------------------
 m4/ltp-clear_cache.m4                         | 20 +++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  |  4 ++++
 .../kernel/syscalls/mprotect/mprotect04.c     |  7 +++----
 5 files changed, 28 insertions(+), 24 deletions(-)
 delete mode 100644 m4/ltp-builtin_clear_cache.m4
 create mode 100644 m4/ltp-clear_cache.m4

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
