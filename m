Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306CC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 11:36:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95BA93CE464
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 12:36:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26B0E3C2674
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 12:36:07 +0100 (CET)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2C23A201193
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 12:36:06 +0100 (CET)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-466dfad4dc9so809612137.2
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 03:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704972964; x=1705577764; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fxG2zyuS/zI5IqZ/aNjYWpFinMenwquR93hfB+tGA0I=;
 b=DRGu6UoM0dkYjwfY1433zlcMw6J1g1I0X7EhJPnhsbf60k/u4XKUTVSHI5bNG+Hbgn
 buV3UjPQJoo/jjSz4VQAJYwVc/nDiwDIdt2Eo1CNnU9yBmX3lKMoJY9qQEo917SKOugC
 pz+jFiWiTLFTbxyubG5licS0h92xE9ff7VyhwcjHOEDeBarGteVoHCL1nHIWYui6SxXO
 /KaZ92sAsidFHeym+DSoLqz8Tqs0G2Z5VejQKLjSugACB3sTZ+uCU19gd6WElyw3Lu2I
 RLCBPFEj/eYgkV4jx4/pVEXqXcfOUpJth8JH/F9k1AFsKszjiX6au14UaPiyW8MPTWin
 sgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704972964; x=1705577764;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fxG2zyuS/zI5IqZ/aNjYWpFinMenwquR93hfB+tGA0I=;
 b=sOq384MLOEKY9dlPUPkgxXbQj/921Xmoubc6hE43JawSbHdIDv+m66dgE5LoUTvqSU
 jBPEZIzuWIwR0OqyUQJfSej387ndCv3DvqYfyIEENRv8LW4FAbLx7W+FNFhR5YeJp9aC
 vtuTQgtrtcyATF/eojk5JgDtWyyQoBPGp9qiiT1JxDIgyiUkvEvdxSBowH6QXUK5J280
 7PC7MFE/YZQwniaxhQnXYYtZbpjU8THyUImg4PWB9p+2duxQPFAoSp7LWQhQchsO6g3N
 bgWXEPwkYXw1WJpk8Iy1+HT4Ueo1xpK+5uh7tlxJGr3YMIH/urM9EgncXGFVij9nz0/B
 /JkQ==
X-Gm-Message-State: AOJu0YzPPDE03UpZjN8LJoDHGxzCenbd5cubByzzdi5p+Pn+U4VJJyx2
 dQBtDIdS6ozWTrljpNnzCGbD+liBa8HrSCefawMMhEEnr/O2Xp8be+apmyLAU0A=
X-Google-Smtp-Source: AGHT+IHfOWNfw9T44vA4RajDoMRRJY1SV0v9+gSZmqyLcA6Sm4gFT8aR8l/i4yH4Vb5zD3Ep2nH69ma2clR8V8hSXoI=
X-Received: by 2002:a05:6102:194b:b0:467:b649:8bef with SMTP id
 jl11-20020a056102194b00b00467b6498befmr237320vsb.13.1704972964650; Thu, 11
 Jan 2024 03:36:04 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Jan 2024 17:05:53 +0530
Message-ID: <CA+G9fYvd9X5QdKGPWH+8Pi9NX5J89QLGt=sPRg57jEa3MwKsuA@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8
 should not work
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
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP ioprio_set03 failed for a while on all the architectures.
Anyone have noticed this failure ?
Am I missing something in Kconfig / userspace tools ?

tst_test.c:1690: TINFO: LTP version: 20230929
tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:

 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240109/testrun/22021120/suite/ltp-syscalls/test/ioprio_set03/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240110/testrun/22034175/suite/ltp-syscalls/test/ioprio_set03/history/

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
