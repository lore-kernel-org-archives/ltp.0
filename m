Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2069CA5FA1
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 21:27:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E78F53CD737
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 23:27:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8C913CE45A
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 23:27:25 +0200 (CEST)
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 05DD71A00A21
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 23:27:24 +0200 (CEST)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac8774c8b4so241966a12.1
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790630844; x=1791235644; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iB4bNkX3i6edu4QfMqqzg0DJ5U4IA/v2RlxcApNuvdk=;
 b=mq2ZbJVskFYQbHbN8g1ixV8hmIx6zESxToGyeIPkR9yHTyPoRQUyKV8TPa8R5LWAuv
 s+SqOi50eTHXwBtcG6WJCfv3St5sG/jf/FfoO76HbCt9vyU9IVYr6gvL27Fyi9kgfLw4
 BSJjmxbE8MKsZfck47pGJTmMDL4U3As8tFyU13pWW+7lHxHHwZeFCxz9cnQyGESAj9e9
 3E0kEVZg5uCVA/BaJaKxMdnT8rwc8z5l1RA43y1fn7pjfPrY8FSgwd6d0MPJQVtclA1H
 r3KUTl8cqr1vv/dfKQhA5NoX7KQ2My3Ln2xHeVaNL+2/ernmwS7xKkO019dfO6IWAM9z
 QxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630844; x=1791235644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iB4bNkX3i6edu4QfMqqzg0DJ5U4IA/v2RlxcApNuvdk=;
 b=PlYPKFSt+EcBjc77Ukl4aAhoQ+sFhCnJhs2jHGpJSaYysRtJBBi8lqCI7LJcynvg2h
 B94+7QAKrbTl2cFUOepz2+jCLSIW9Z6Jpy/SmeQ8bIcET5ahEkY9RhHYfXIXT3memuoR
 aiozUfvB+luXTIsz1dT6pdX2qBQ2yAShVqYUYMZShVFyZuqpvh1W8y8UFrTLDT3VIWDe
 KPdDF4eSjKZ5OzUa3CG4IPeoqe4gPqLMumP/zfBPAsSWAvKwcBeKDoeA9RapfORuIe7K
 On0EFm6XOyJSx3A2QKVZAEk/1TVv4xGzbrqkjF57OSdpzhmZMPyvZG3t4LtRTBQaYu2c
 ZylA==
X-Gm-Message-State: AFq9FYLFBT+e+8cr4EH9HY2C7Ok7vhtQHJiF8HfMwkOWrkPn+KoVVjUg
 9dUzr3RuidMgLYedCzzrg7lep2zBvg6Z8iDebGnjh3OspXWDsLD5MBFqiJOoo1A0+XdAEfROTAK
 l9bQ1
X-Gm-Gg: AYBFou10GZ2E7iE2BT/QZI7mG5ovTWfe0SjxkV1OqARnz/p/rkrex6V4zXlZh2Z1Hz+
 C0xurOPDgqdh6GiDeYvU7S7GkNx0st3P9sOL3C8Z/YwWSUyU+5jNh18ZlSk/2y9hXClpXMVpGEb
 YHfTU0ZUZav6Zwm7/VPFjI13V5uVSmUt9J4KyRawCbh9Z0h2SJuXTusoboIyHpL+9Ou1hLtvDYa
 QS9Ztm0EAA9CmJDIdgFUDy5uw2PwUvpNesy/LxLNUv07dP9vl7vRiUnJzwVxnnMH/99Hrgc7i/i
 uNIlN9Yq1hs0zaofYcbMmE+o65FH2GDIeWVnxZMnNSSdlSL2z0/YoHe2fDvHIhWlLwPVVewAGFV
 3VhchyD9ddSZd1KlXX0sHwcnEoC1X21CgKK0yWRvpQIdjJB8WYHqSVB56V5wuzm5nMSuxBPdtse
 k27bKLzPJ9mUnzt/qUR1NevhxsCEmsC0MmOJKxMlmzIeN8BGxEJI98/Z2pUIPJnFVs22bAFecQn
 c2PSCuX9AENeHhNe3LmtPvO4PMjR8mUcA==
X-Received: by 2002:a05:6402:13ca:b0:6aa:490e:5518 with SMTP id
 4fb4d7f45d1cf-6aae1fcf708mr10171416a12.2.1790630844299; 
 Mon, 28 Sep 2026 14:27:24 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aae5cb98dfsm4557803a12.6.2026.09.28.14.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:27:24 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it
Date: Mon, 28 Sep 2026 23:27:21 +0200
Message-ID: <20260928212721.2834101-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: lib: Use the configured compiler
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

The lib Makefile does not include env.mk, so it does not get CC from
config.mk. When we cross compile, libcommon.a gets built with the host
compiler. Then the linker skips it and most tests fail to build.

Include env.mk, like the other Makefiles do.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/open_posix_testsuite/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/open_posix_testsuite/lib/Makefile b/testcases/open_posix_testsuite/lib/Makefile
index ad6a9d7e6a1b..e63ee42647ac 100644
--- a/testcases/open_posix_testsuite/lib/Makefile
+++ b/testcases/open_posix_testsuite/lib/Makefile
@@ -1,6 +1,8 @@
 top_srcdir?=		..
 subdir=			lib
 
+include $(top_srcdir)/include/mk/env.mk
+
 AR?=			ar
 RANLIB?=		ranlib
 CFLAGS+=		-I$(top_srcdir)/include
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
