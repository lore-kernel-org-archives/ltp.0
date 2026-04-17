Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06223F8E498
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 00:11:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 947C13E7536
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 02:11:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53BFC3CDE4A
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:11:27 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E06D060062D
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:11:26 +0200 (CEST)
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8cfc2d1fdbfso6864785a.3
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 17:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776384685; cv=none;
 d=google.com; s=arc-20240605;
 b=hl3OTI8N33NcYjTGkff/0IGFqlIroMdnnaUvI8cHiv1oIIrkN4Pf1Mom0HY7et3iwt
 ogZni9B7vqhYP2o2vxruFuewX4ApkUTLSuvXDXtggPcQ0Ear9fJcsbkqbUlk3zrxVc7R
 vRlv3Wl/jv4xGJSj9lIIhev4BD+pdeTc0qZl24mRK5PCZtuX9xDkAIokb5ROgyHh6/bY
 Ov41IJz2BrvSKJalQn6tKpzfD4Ny5Kgk6RMGALMdpppSozL8vfXqdVWtdAhac4KSK7rR
 ircOH09HuV7/j6YejhczcO87kIdW1N0opb15kqxpOzeSBa8Ps5WoqwcG/cCNZN65YCGe
 Xu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fSHhzdFeVOBFzd4EIyNYpSrliLSLI4BIZJmcoIo1d/k=;
 fh=IP67bniYMf6IiZ3LBcBXDCWOsyWHGt3cusa49k668w8=;
 b=lYTYOUsSfFC/JHxTJf2NJ+pDPHAqrUOSAelWY/aLOWZkLh0WqyBQBsQW5HTV4VQkEI
 HRyVjHCDcT0roHoKwFJzdhjjW00BVBTnsrAa/z+7+Rg4X0pjRFzL+cW7jRSVDpzp1aQm
 MT/DWKyPz1/BEYBA6KfT4BqhhZOmhBaEZjegPvgAiPB9/CE88NH8sLz+bHY/kEHMOIvT
 p3M7YGGCKbguxphIXdqjzqZahWM2XjYeJDW+z+pLUN2EkqkRIJ5CAFnee+S0YkQ3AIOG
 EIy1FvQmofiqryJRD4uCqMcKmlfds9aHbR3lwANFnzgnbALYRRYIzphxsgreqypEyvzQ
 y3Dg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776384685; x=1776989485; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fSHhzdFeVOBFzd4EIyNYpSrliLSLI4BIZJmcoIo1d/k=;
 b=qUFmqqZ5ON7J6zlufLkjU2oKm5Wfrj2b4+I7/2uq6XGJGKEDU/GW3X7tupkIw1D/wk
 JfhmIeMK40sZwTXrCfL7qha5QxN9sBvVecbIr60k/PJP2W6j1lSRziX80aCwjJaXyGOC
 +PxdfW74zb5CwhYCKT4K+qGK6Jj2RfIMffBbhxE/lMqlIw2ziXtLfXv7hlBr6EydbcZY
 +ZBR2JGLT9UJ436NX1+R9zjP50GnQZXmwzLvZiWhjbiCusBP8Gp0vT9/2ZFhG3TGJM8+
 odC/Ki1ZoNxXvxpxvrbKQ0bXL4kzsf6GnRaCfJpyaYuUym99JZ6MtZVlhU3U7oYC5zU/
 D96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776384685; x=1776989485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSHhzdFeVOBFzd4EIyNYpSrliLSLI4BIZJmcoIo1d/k=;
 b=A9ZxhBiJSpIHoB4Qzxx9YWMDCBj5T6VG1OFlVXAeEWHAfMGzCaRcevBUo20CHDzWHo
 eqlmijbWTZRV9mlUYxXGqUI6ikBSAMvZDk5ahSOLsBvBmVUtR615uhKB/bXF184e0GKp
 0k3Ffw+KzugVyOcC3UEnxg/1YgwL8fbIopQ9cTULBv4g8ElpxsOd55VgS0WVU3ORhpoY
 zoUGTXQfz+rc9yxX8qPzogUI19hWAqD7jGWpCDNMcyHuPN0/yuRigxhwp1eP5d1Ow5ex
 es7JzvySLHeY4rJC753wX1B1tHCxKa8QCrZAtvPOHovovXps9nZXRMe48om7zIG/EZKc
 k7yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hVZLyT4XrJvYNDbYYuImZ9NzVEHv0Wey5r9b6v9MUuyqkOnu4gHKvNg4TN+Dk/QlmpaA=@lists.linux.it
X-Gm-Message-State: AOJu0YxshDZprdYb8NiU6ibywZMZrXG54h8ehtKDHZKP/3SpSEsMaw81
 Uo/2NrMqER07I7ZounMCjMs37bpnsxXYFNiFkqIF1u/EHEJI7tvcRhZ+mN4IlORSK+j1nzdIQU3
 L3skLtiUgV2/TNtO+B5bO1BzoQMj7ZQ==
X-Gm-Gg: AeBDiesociP/F62M9KYdtkBraV5hnGognH4Fvyjs3M89P3R422fcDMV4r6dr0YR1v4t
 TkmrucbkEKJ7yzohMB3LPhiPwnD962k29SagPEglBXwWHrD2VHJztAGreUd3dXRL+7lWR3+gb3n
 MHcSoIldSR02aYCEOmzpiHBockRYrk4mXMbVrqUWPOuq6kHC3yiO77XdBuU3V4JLr3rKu/WIDSE
 6G5Fdi3BlOR4PcMAtEFsE+x74uKXvaIsIJlRIFCjfd2TdyNN+BHGV5Y1m90nBxY5Yb2Hqb6qWhh
 hY6gw/mQG2mh8JhJ
X-Received: by 2002:a05:6214:c67:b0:89c:5289:4be7 with SMTP id
 6a1803df08f44-8b0280ecbeemr11707366d6.26.1776384685502; Thu, 16 Apr 2026
 17:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260410175031.16921-1-always.starving0@gmail.com>
 <20260413212007.GA164377@pevik>
 <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
 <20260416180559.GA303991@pevik>
 <CANgNiRxx3MyMGsEXszhV1TcBc8XP9jSrYL_pnbwsUa4bb0-XiQ@mail.gmail.com>
In-Reply-To: <CANgNiRxx3MyMGsEXszhV1TcBc8XP9jSrYL_pnbwsUa4bb0-XiQ@mail.gmail.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Fri, 17 Apr 2026 08:11:14 +0800
X-Gm-Features: AQROBzC3nY5uWX1m_M04VVg4Y4umez1jnwAKHtSREgeMnjsDzQNM4_KSfSgDk4s
Message-ID: <CANgNiRzSi2OgV-vu0amVvqNW_jUK_bBpjntubERaEd-5dqUVXg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Yes, that was exactly my point, we'd better remove the INSTALL_* part
> from the Makefile you posted.
>
> -INSTALL_DIR            := $(includedir)/lapi
> -
> -INSTALL_MODE           := 00644
> -
> -INSTALL_TARGETS                := *.h

And we even don't need the additional clean targets, for the make-check
which just simply:

--- a/include/Makefile
+++ b/include/Makefile
@@ -24,4 +24,4 @@ ac-maintainer-clean:: ac-clean

 vpath %.h $(abs_srcdir)

-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/include/lapi/Makefile b/include/lapi/Makefile
new file mode 100644
index 0000000..83ef85c
--- /dev/null
+++ b/include/lapi/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+
+top_srcdir              ?= ../../
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
