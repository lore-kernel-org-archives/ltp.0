Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C0AC531CB
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784800214; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=8VOJ+DG3D0x4QLxvQ569gpWAg3aJfn9v75HXQ/IYst4=;
 b=l6h5Ps4wkxvBrQrnf4w8Zaf7vFBU8vR/gqX+XHY2kgW/UbfHo8jfTRGReD1JyhNH8NP1q
 mAkYbT7vIpCCPzFM3ZpCyb8zluq5jxXLUX9L2Ns7u8oy5brIct1ZKxTkRxc7AAP8ru6+TFd
 qvI1kHN22UaojFaVnv/myxbSE/XpHH4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE5EB3E23BD
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 11:50:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ABA53C7757
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:49:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0AB510006DB
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:49:53 +0200 (CEST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 083B73F672
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784800193;
 bh=gKpfhHA7fIx6qj24SenebmO+VYa/GH9kx8pfrantCvg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=Z4XsBjGbSKbnPZzCXZbgUBFeTbMkWssyCmfbn/cae1JrSDjUxsJ978jB34hSEG3A4
 JSFZPmDWzyWoH1J+Fwmf18nUa4E+gu66/LytAXefZ2mTNakCHefaQgQJIZHMtUGEqH
 oehE1SqvPddZTZELskc+I+6Rned8ZDz7vLwui4EQW0CweUBAP5EJGn4Ra+pQTK42ib
 Nbs+2ye45plyEPflLZnugUcAOOD+egDSPwwjWA4Avic0d+s3iGpAGtHoBHmGD6W0ER
 1C2dLGqCmMjr4O2tiw9YCNeA7tePb1iXIkfJ9PoO2q5s1onEtQrbrZPq/ayBmsj2Ok
 btqQYcjq1USnPFgYc2lxqtIwq8FRBaJP6xQ1PZYJbhNz2i2xmrBo4w1BJ77VgwM2bZ
 WV3zg8o9Ldbp7CEQOZ+vGrml/PDMy2QOKGbvr7exoRB7ZB+CmuIJbYok2uv84R4fZ4
 O7BZs7k3zugefSZ0b5o/vls2Sj8s76DeilFZugFIcywje1j+FcH1O6NIXpPStDnBVn
 kgaRoJV1lBcY1+8/JvlTUUZER+cRvt+EEcezimndczpgNGUYb0fWzZNd6BU5GazIwX
 efsa2ZcgqyDc5IWMzl53P1amfvmzlcImbdzzCLQXCBUaMAhH3KENaNdhVzQO2Q9jAj
 fw8ClrYme0bgtwM9tVbEXcYQ=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495517d39fbso2316775e9.2
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 02:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784800192; x=1785404992;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gKpfhHA7fIx6qj24SenebmO+VYa/GH9kx8pfrantCvg=;
 b=Pmg+U070GHPQQq4ndnLVleX1fPHuxUrX4Z9jEh9eBQ3CNOlibbG+lza8ylczHcMun7
 5G4JSZH9GGq0y6Fi4qF8waNtY2gsR+51YpD0h++tlP+ErEcRXd9XJ9dnTPTGPYeQGkIz
 vH3kanBqGhi6tpKXfvL7COUY9Cocqi8q0C6MRywZ5naxypkRw5MbjujKg5cpY09/hz7e
 L651YGR49PahdRQBeot+IxE5kF5O6eIq3wNx+PTDJAP40XYydXoTy0NEhmkGIuUgWuaQ
 Zu5yEBv6T7YxOx+fuqgPCsz/vOF5JCtX3L4rKD1tNJEcdSSeeQiQfIO5he3Da5mGiIpy
 GQ3A==
X-Gm-Message-State: AOJu0Yz7r4RRxvog8wtzU3fsA8s7lFhiwgLifrjdMFVOChLExPqwdg4p
 +38MdwQp9lHagCYFzkvA9VH1Bl7e8HY19dgKfEFZkBgs7BpVX29bptbLWwM6l9wTj37AtbX4W66
 Wv9yS2g1EjUxbYttBxcDwAHX0GnYb4F8cxdcOnwxerox04S1qxa80NZWSDnf49wmu6xDUO7K1Uk
 iU
X-Gm-Gg: AR+sD12HWGuuprIMxkby8os22AsWmIwhvp9/vE3ZmGQ62nYuTRnEi/+znMPVYyFJzFP
 94UekqeI84n6VOytTbXC4u9L6dNJtZeinxFugjhPzoeLAcnKsbgN2mxjFDSsdUSN0rKN2y5RUi5
 +JFTyrSa+2oi00L48QDk6vT1CIQcSsJsBs0MAtW7mIWe/brz6EGqpOGDnJQ0p3Pbak6B5kOr/Uv
 vbTOl5IhSYXtbTb7IF13LM9CUclE1pHRdIxoZNrkiBtU9goOZ/lTc8NnUeFnxxWgRERrX5eBy7p
 juRznvN76O51pNdyeRVHB4l1ej3BgXcKeaYgXKfHBJCEYEJE10qIg4g5hk5hh0wUkkYPWuentZE
 4BYo5u0OlqlLsLBSNd1sEipxqpefO3BDEXqTU1kHgHICKQWyhU2SUZqDbwTc7
X-Received: by 2002:a7b:ca51:0:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-49573cbf916mr16833345e9.5.1784800192520; 
 Thu, 23 Jul 2026 02:49:52 -0700 (PDT)
X-Received: by 2002:a7b:ca51:0:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-49573cbf916mr16833195e9.5.1784800192084; 
 Thu, 23 Jul 2026 02:49:52 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-183-213-56.toya.net.pl.
 [31.183.213.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm196600555e9.8.2026.07.23.02.49.51
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:49:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 23 Jul 2026 11:49:45 +0200
Message-ID: <20260723094947.2639934-1-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] rtc02: handle RTCs that do not allow setting
 the time
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
From: Kuba Pawlak via ltp <ltp@lists.linux.it>
Reply-To: Kuba Pawlak <kuba.pawlak@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This series makes LTP's rtc02 cope with RTC hardware that does not allow
setting the time (e.g. Qualcomm PMIC RTCs, rtc-pm8xxx, which return -ENODEV
from RTC_SET_TIME when configured without allow-set-time or an nvmem/UEFI
offset). On such devices rtc02 currently fails a valid, working system.

Patch 1 fixes a pre-existing fd leak in tst_rtc_ioctl() that the new probe
in patch 2 would otherwise hit on every run (the RTC chardev is
exclusive-open, so the leak causes a follow-up EBUSY). Patch 2 probes
set-time support in setup and skips with TCONF when RTC_SET_TIME returns
ENODEV.

Tested on arm64:
  - QCS8300 (read-only RTC): rtc02 now TCONF (skipped), was TFAIL.
  - X1E80100 (writable RTC): rtc02 still TPASS.

Changes since v2:
  - patch 1: drop the errno save/restore around SAFE_CLOSE(); a successful
    close() does not clobber errno, and if SAFE_CLOSE() fails the test
    breaks anyway (Andrea Cervesato).
  - patch 2: drop the long explanatory comment and let the commit message
    and code speak for themselves; add a blank line between the RTC_RD_TIME
    and RTC_SET_TIME probes (Andrea Cervesato).

Link to v2:
  https://lists.linux.it/pipermail/ltp/2026-July/049974.html

Kuba Pawlak (2):
  lib: tst_rtctime: close RTC fd on the ioctl() error path
  rtc02: skip (TCONF) on read-only RTCs that reject RTC_SET_TIME

 lib/tst_rtctime.c                           |  7 ++++---
 testcases/kernel/device-drivers/rtc/rtc02.c | 11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
