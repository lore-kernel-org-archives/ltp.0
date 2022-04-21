Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E06C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 12:43:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A0503CA6F1
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 14:43:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AB403C5649
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:43:07 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCE20100048B
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:43:06 +0200 (CEST)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-2ebf3746f87so50642777b3.6
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=mIeaFctSEsoLR3nyyuA41iSSvZNBM5Q8wFrycCuIYd0=;
 b=KXYF894QW3BVp1KxCI27PWhMQYj4M4ylYYwG7Yf04NN9QxFYtaz2+8p7cG7Ji/55oc
 adAynaaeQi29SGnJQgiIPYmgYdUxtsXWgoBt9UchRFhL98aDuVkwMpc3sgIRRLr/NVG/
 a4vF+JUL24/l3aA5LFq3NkMY3wRZ95/TuQhYxHi1SH7WFMc+vShS/cqEL68p2290Jclr
 cezFVzxw3ESfictsSZs3mzFnxuv0xX8Ehyzq0lDF99IUtqHB5iNNxk09vhJ6jIpBVqgi
 LcE1s/BV4XSHrA8mJJxR/ZK7oc7oJ1YpToPiXlryVX9g0NVeipsi/5sZHt7ZaEYR1omr
 RE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=mIeaFctSEsoLR3nyyuA41iSSvZNBM5Q8wFrycCuIYd0=;
 b=SJqrftmiGWNDbRaD5mFFcJhDBKzcrof7Wjr+9m9H40SiqzDqI4ryWB6lLA6KxgEuJL
 eKKPsPPXwH0sLX/mhoLeX4UTsnnkwA04jEL24Fj99OKpsJfN7DpPQb59s0pb5YKs7BKe
 mqPup/aVz486qunbqYMBa2R+kh7u0PFRzJ1P1kojnyMaSNmUlh/Qb+53JEzd51opdezo
 7rR95CKKLcpy8ORIm/qW10wwQ6pBuTTG374+03x60v3GmNAhxN1ssN65BumHZFkd0jXA
 teS4lu06o9rUBsr0DNMug9OnOaoW4f85ULQ4NAWzpN3s9nvCzTv8qfQUlvAhYN0yaHml
 OFOw==
X-Gm-Message-State: AOAM530ZoahaxVB4oK9inm2s23bgtrYEdQ2BY2o4HQA5VxCHNHfN7gMF
 7MmMttqZLNGvQcNfD52V22VvfdKBFMmskiXXmOWzZD2V7wvAAB0O
X-Google-Smtp-Source: ABdhPJyEfDDMcm+W2/EznDqS4w3LFcFNuK1bvTNWZkaZ4X2f6GD98Cqgg53dYwlqWQw5Zie9b1Lj+QH8A31CKOrXqoc=
X-Received: by 2002:a81:478b:0:b0:2ea:da8c:5c21 with SMTP id
 u133-20020a81478b000000b002eada8c5c21mr26608137ywa.189.1650544984778; Thu, 21
 Apr 2022 05:43:04 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Apr 2022 18:12:54 +0530
Message-ID: <CA+G9fYvO5OERA0k-r=Q8gbGdUKm0VppL2KPJ9e-R0NreBESo_g@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, 
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [next] LTP: netns_breakns: Command \"add\" is unknown,
 try \"ip link help\".
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "vadimp@nvidia.com" <vadimp@nvidia.com>, idosch@nvidia.com,
 Raju.Lakkaraju@microchip.com, jiri@nvidia.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Regressions found on all devices LTP containers test cases failed on
Linux next-20220420. [1]

  - ltp-containers-tests/netns_comm_ns_exec_ipv6_ioctl
  - ltp-containers-tests/netns_breakns_ns_exec_ipv6_netlink
  - ltp-containers-tests/netns_breakns_ip_ipv6_netlink
  - ltp-containers-tests/netns_breakns_ns_exec_ipv4_ioctl
  - ltp-containers-tests/netns_breakns_ip_ipv4_netlink
  - ltp-containers-tests/netns_comm_ip_ipv6_ioctl
  - ltp-containers-tests/netns_comm_ip_ipv4_netlink
  - ltp-containers-tests/netns_comm_ns_exec_ipv4_netlink
  - ltp-containers-tests/netns_breakns_ns_exec_ipv6_ioctl
  - ltp-containers-tests/netns_comm_ip_ipv6_netlink
  - ltp-containers-tests/netns_comm_ns_exec_ipv4_ioctl
  - ltp-containers-tests/netns_breakns_ns_exec_ipv4_netlink
  - ltp-containers-tests/netns_breakns_ip_ipv4_ioctl
  - ltp-containers-tests/netns_comm_ip_ipv4_ioctl
  - ltp-containers-tests/netns_breakns_ip_ipv6_ioctl
  - ltp-containers-tests/netns_comm_ns_exec_ipv6_netlink


Test log:
---------
netns_breakns 1 TINFO: timeout per run is 0h 15m 0s
Command \"add\" is unknown, try \"ip link help\".
netns_breakns 1 TBROK: unable to create veth pair devices
Command \"delete\" is unknown, try \"ip link help\".


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: f1244c81da13009dbf61cb807f45881501c44789
  git_describe: next-20220420
  kernel_version: 5.18.0-rc3
  kernel-config: https://builds.tuxbuild.com/283Ot2o4P4hh7rNSH56BnbPbNba/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/520334286
  artifact-location: https://builds.tuxbuild.com/283Ot2o4P4hh7rNSH56BnbPbNba

I will bisect these failures.

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4925635#L1272

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
