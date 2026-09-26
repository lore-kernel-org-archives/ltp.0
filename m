Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C703C9832F
	for <ltp@archiver.kernel.org>; Sat, 26 Sep 2026 20:45:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D2E43E5EE7
	for <ltp@archiver.kernel.org>; Sat, 26 Sep 2026 22:45:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A67A3C5752
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 22:45:03 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C6BDF1000347
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 22:45:02 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so2239415e9.0
 for <ltp@lists.linux.it>; Sat, 26 Sep 2026 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790455502; x=1791060302; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VJ79Y1tqVJqBvUi1IInPSQhRljq2s6fiPlODF5ImaXs=;
 b=GPG0Uqg7iHwvlSu//x4/dX2NGaUoDTn7bFRL0KraWv5zo5YbRHodN62VBqE2QPeo97
 0MzDh544hF993iSKbhVStGSOYexFhC7yiXxfD0ANVZ4jGyOXAcjNsr6YrsfoQs6eUxN4
 nFdFJ6tWx1QgDdNsvA9+EfUstYj/Npprs//lV9G4YNKK48HCNycLWrtdyoCbsWajNU9V
 TRf3B0PduVlqaJzEPZTGVPZYOGAzjtRFPZbGldE0TZxZZUWyFCDn8X3jf0CTiJY/CMZo
 4WQLYCwcBClN4gKoQVe/mmPQNGoEQC3wWSlBxYtg5tMjJKi07fyPrHz6WwVAKQVkxCdL
 5oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790455502; x=1791060302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VJ79Y1tqVJqBvUi1IInPSQhRljq2s6fiPlODF5ImaXs=;
 b=SCovSRrqNYn6Efb4fp1buyr+tvkegVRQHHOSFMpMETSTj6TMNEPDzL8IYBFpQxVSvC
 s1mzFvbqW1++oVtLB3M4w/bSXcReVxu2nbAUP6SZ84CaJtHx4l5IGsclmCFkkzFRsj1b
 xBAm1RGWeU4pAwy0mIoncYKuVZ0Xv5TBjk9q9cFBWMoCHNtu2VUpJGjt68wY66O1qmFB
 rg2gBOmFpvN38EXHJBXfOL8ja5nB/Dko7PVMa9xNn+UoX28RWiSXINJV4jB+6BCH61Gf
 K0BS0a5jaaTcck0UG+BNiY3z5wVliTDmFeHSWdqYaOCMUkDJUDhrkD1f3CCWy8GYEAn9
 KUpw==
X-Gm-Message-State: AFuF++k8NhLuCHlHxMXWfdv1MvZRR+gkOploaGl4a+jmC5H93oQut0K9
 lAkZpUmlxFxM7MBwY2UBwyZCSSnIsD2PcPlQhSpqj6hXTUwingBHFXSzxvAAL4Bg
X-Gm-Gg: AYBFou1P952pc+Ah0OAfS1lK/MRHwpF6nBOWf2TfaVVKbsPYx1U3ePAKO1tTID0lDG4
 uRWAO3LvuMQtKat+nB0C44o9q0PAx4f40alCA4X7RNP2NeCDsuVLvpQTJMdEC/Y4cQQIx31USjQ
 tE9ucObX5B+4x++wosbu1mKf9NATP2rOtP9HQ88uz8199EBy953JhlZcSVYLM8GYlgQu/62MmFe
 0dLGBXyJzf7kgH5lheP+cu+CkMncUTUspOBiS16bpyAsDRjNvh5SV2RQVQUqMpojpbtJSPv8IY/
 5AZEjPN3wWRbF2eqCTMrLAH/sSOThbWBtzZC6hm08UjD5+uucfzTOCOxpbKZbFYvYmVo3Tf22dD
 Is6buu4DMrQ8ZL+K+BU9IkUfFml4IJr384SKOZgXQF/gqIPnuoESJUE8W8BBL/gg2LvVivv7BlR
 10LJzBc3lHul6rpx+7kYcHtp4z365Rrs/IOssiBqXvvA5q1hNWxl6QNEg3VFQaB+oODWXiaZ4Yr
 +qTC2hZnZgNYVhaAn1i395zdvyyNZoRiFomui3vs1MQAZxQByye12A=
X-Received: by 2002:a05:600c:314a:b0:49e:6778:c2bd with SMTP id
 5b1f17b1804b1-49fe66c86bcmr176022045e9.6.1790455502180; 
 Sat, 26 Sep 2026 13:45:02 -0700 (PDT)
Received: from localhost.suse.org ([37.109.167.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff13b3c59sm18554405e9.0.2026.09.26.13.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 13:45:01 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: ltp@lists.linux.it
Date: Sat, 26 Sep 2026 22:44:52 +0200
Message-ID: <20260926204459.20699-1-sebastianchlad@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] memcg/memcontrol0[34]: Align with the kselftest
 protection model
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Sebastian Chlad <sebastian.chlad@suse.com>

memcontrol03 (memory.min) and memcontrol04 (memory.low) were ported
from the kselftest test_memcontrol.c in 2022, but they still follow the
2018 version of it. The kselftest has since reworked this exact test
three times, and none of that reached LTP:

- f10b6e9a8e66 ("selftests: memcg: adjust expected reclaim values of
  protected cgroups") replaced the hand-picked A/B/C ~= 33M and
  A/B/D ~= 17M with values from a simulation of the kernel's protection
  distribution (memcg_protection.m): 29M and 21M.
- 6a35919005d4 ("selftests: memcg: remove protection from top level
  memcg") dropped memory.min/memory.low on A, which has no effect since
  A is the reclaim root.
- d2def68ae06a ("selftests: memcg: increase error tolerance of child
  memory.current check in test_memcg_protection()") widened the
  tolerances to 15% (C) and 20% (D) because of sporadic failures.

The first one is what matters here. Kernels behave as the model says,
so D ends up close to 21M and sits right at the edge of the old
17M +/- 20% range. On x86_64 D was at ~90% of the upper limit in every
run, and small variations in reclaim are enough to fail it. With the
model values both C and D sit in the middle of their ranges (~8M of
margin each, 50+ iterations per test). LTP's tolerance is
already 20% for both, so the third commit needs no change.

Patch 1 updates the expected values, patch 2 removes the top level
protection. Both apply to memcontrol03 and memcontrol04.

This does not make every failure go away. On ppc64le we also see runs
where the most protected group C is reclaimed down to a few MB while the
unprotected A/B/F keeps its pagecache. That is protection working the
wrong way round, not a tolerance problem, and the tests should keep
reporting it.

Sebastian Chlad (2):
  memcg/memcontrol0[34]: Use expected values from the protection model
  memcg/memcontrol0[34]: Remove protection from the top level group

 .../kernel/controllers/memcg/memcontrol03.c    | 18 +++++++++---------
 .../kernel/controllers/memcg/memcontrol04.c    | 18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
