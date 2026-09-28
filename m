Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8132CA5FAB
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 23:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F26903CFF65
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 01:50:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1223C089A
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 01:50:05 +0200 (CEST)
Received: from mail-qk2-x05.google.com (mail-qk2-x05.google.com
 [IPv6:2607:f8b0:4864:34::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A4A5200909
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 01:50:05 +0200 (CEST)
Received: by mail-qk2-x05.google.com with SMTP id
 d75a77b69052e-53347efec86so11955691cf.1
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790639404; x=1791244204; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H5SFM1uEQ9WxN6EV5Mq1j1Hb3oZa0OyjPTNtzrM6uyo=;
 b=mUFmzU2Vwn8EjWif6xFPXR2Yx3ggvTRWCkNsRuq/ixJOJ8PZJ4jYrMO0R2mdHDA5p/
 lJ0JwUAF5XN6NDsROT650y8Bg2dgIWAN7iAtic3jGB4DuUA5duew/O/ZH92Cs6iQFCqi
 g+R5FQrK7If5jTv8AKl6mfMIw+ICu9l6axOcfYZYJxP1DjetMKTIXD1QmqpeDVrkjih9
 qg+SAopkcInaSqiIoDaqEdrHwxn/5uQue+eFibYobjZv2bHLlP0Pnjk6aRV+sOcQzvJt
 9JsgPDUNzNnuUfiV51m1nJHMGw9SXFMe5xK4ZzuufbOPXhuayyKbFB44+mvvllhxCC0Y
 bD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790639404; x=1791244204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H5SFM1uEQ9WxN6EV5Mq1j1Hb3oZa0OyjPTNtzrM6uyo=;
 b=bhiJLwuPICJtMWkPo8W3WaPNVetgnuBTpi3EpSYyJIleDR7fQsSX+BP/mEve5iAFrL
 sbKvWbNPBzEddjXHPwTJlaylvKAY3Bgpr2KSZ2hXVY8zxIpkSLNzUYN57maL4dTKT4/s
 n5u8YapBZOOVxyT8/b+Ciihgw+U0A/ZIGVfXZx4jSmirJW7RxLTaGBvmjIvOCo/jtaTk
 RxBXe0Q17LBYyDkVI7AhfDlP4X1OrkAlN6UmOpulnGVlcLhY2buH3Avl6SKANiSQrzQG
 ZAS5NMdgqq4SM9cWswB7S6X243jpfBt6uniCSxolQKsIXOHAEy4rJ0nG5bW97CmaSBaX
 an2w==
X-Gm-Message-State: AFuF++k3/PhvQ7mfBWnkzt3KxFRRqmXaRgWeLc6znQ5S83hZMU/pVK+7
 fxX5LQv3b3+Bt4bRmGl9R43dbZZGI7MjxpqdVEOPVLFgbKCn21bJHWve
X-Gm-Gg: AYBFou0EB1OFN890c44n9b7kLYWQGRId4rrYR6+U9f9eH0JRVMaGMm4HY9NpxlOi4St
 JeO8g7Srwvh3LTQrUWG0tvl6QKotcrbGq1uwqjIja7dYOwFFBW0y22d8Z4ViPLv7oCSnsFP01j2
 5PGA+2PnCIkwQTZ/CggYjkqRwimx7lWn6/AXn3MMMaAVDOD9o+E0QANOQA3wDKHZZZjdsVSHFUp
 wFoSNQyplTR0XEG1mW9C4eQgsfGOQTlQh2yY/e/2BWecDc2PTo+BMIJQH2hlxaK3y2p18IahPN9
 QlTAY42W/6qkadVT04YUWDc3K8ChmVnIExn307xc2jsLzjPPXMbZ0NP7oOpGnLZ2Et2U/SLXV6+
 VVFE9yam8Vxyhc0cXc0Il/dMwjrHnDVqkOEMC9fVoH/acg/TkkNU4eU3Y5NuZ88p10ko1ygmA62
 1syiUKySCzy4jw+1hV6Z9xCkYovFx4LB5mapz75yayRhvITYJ+jK2DAvI3CRg26wZmSqmJiD02q
 w7YMuCyeqb7wAwtsN+yU01HT9d0xSR+BKXVXfE8pE9iEl9tjDn0VMVnNN6ah/zZS1IuQdMKBRfd
 uQQntaQTExKmGQ==
X-Received: by 2002:a05:620a:370d:b0:92e:5b92:98bb with SMTP id
 af79cd13be357-93c43cfc531mr2342576185a.14.1790639403647; 
 Mon, 28 Sep 2026 16:50:03 -0700 (PDT)
Received: from
 runnervmtr4k5.slwhiqrzxzoudiqurlfg2o0vlb.bx.internal.cloudapp.net
 ([172.174.133.133]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c8147c4desm262658785a.39.2026.09.28.16.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 16:50:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 28 Sep 2026 23:50:02 +0000
Message-ID: <20260928235002.8899-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928212733.2835408-1-anders.roxell@linaro.org>
References: <20260928212733.2835408-1-anders.roxell@linaro.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] accept02: Join the multicast group on lo
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

Hi Anders,

On Mon Sep 28 23:27:33 2026 +0200, Anders Roxell wrote:
> accept02: Join the multicast group on lo

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
