Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA77DC3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 13:53:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 369933D1CC2
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 15:53:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CC873CF2B6
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:52:55 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BE7931400060
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:52:54 +0200 (CEST)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc47abc040so5386965ad.0
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722001973; x=1722606773; darn=lists.linux.it;
 h=to:date:message-id:subject:mime-version:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hlzn4jLxXLMwuh2yh1LHIIdcIjv+b2ijdQgVNoLWnK8=;
 b=GZeKk2WyJm4JWKM/YsqGmWKlSQC5PsdoTRKMmOBApR6sTjT+qEsMEY6xy1M3QYXarC
 2e3JjolqqkHzJSn32hJnlobXXBVUdAeALuK2p1CevP8bvBksO4IKKPckzkRVL9IlDqRV
 t97iwNs8B59goACm8J6DEctRBmLcF3Mm81BgugfRqnNcqkHFYqOWvpZ8RZyvIr4lMPIl
 3F41iR81ajx1hH5ibbpksBisTyUgPQ2ZTiF1Gm6fKqTloths/ElzBPBJlol1JRlYAcVu
 kh6299RjfmLZznaUeYVdnp+TFUlpbtGAdBfoeuo0fFvMm0xghNGOysEEXcwLsbQ8AB6e
 e/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722001973; x=1722606773;
 h=to:date:message-id:subject:mime-version:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hlzn4jLxXLMwuh2yh1LHIIdcIjv+b2ijdQgVNoLWnK8=;
 b=kWBw9kswCzjT1GWoPe4VCBmoZ9yVHVx1G8Q8H6LacgTGgzJPRZ3cKrd1hsQFftW/2q
 jAh9ax1Tmo6RyvO6qqo63Yb4nHWsBmT7Zu/UGqPRpk1P9aPB1Fg8CgrnNGdgGh3acDh7
 krPGJVAXWZwrLxYd8XVL2ypTE55UsC+Hb2h/lQsTFHooGijGiEOrv9Io4934vT9mPS05
 J04taVC0bOYVl2ZT4vsmzfxYGIX+7kiuNkbLXpTduYQLNf5Op9N9Z+9RZoXRE2ETIuW1
 mxLGxVN32Qa41hUlbJvPodHGinXR52Ltegz4Hp7GyowRrH6RsNuR+O5bhMcGoTUUIbxB
 R6Lg==
X-Gm-Message-State: AOJu0YynRP/jwpinsiwbSKMXEQWYygdrtwZ0eso3akFaX4JfqvD4H3Qi
 cQAzcGGEofownrNVwMW488YXL4ipN+Z6d3xA2px1jH/rOTyd/I1UKG97cg==
X-Google-Smtp-Source: AGHT+IEBchgy5BBvX8Qg8t0Ef2+eesOCbA4LU5vYWdcmf4JoeI+NC/Bbnt9G2Gdufo+WEPnIcrmQ7g==
X-Received: by 2002:a17:902:d48a:b0:1fd:82ac:7c39 with SMTP id
 d9443c01a7336-1fed39df7b0mr63132015ad.41.1722001972966; 
 Fri, 26 Jul 2024 06:52:52 -0700 (PDT)
Received: from smtpclient.apple (c-24-20-24-37.hsd1.or.comcast.net.
 [24.20.24.37]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c7fdafsm32525105ad.52.2024.07.26.06.52.52
 for <ltp@lists.linux.it>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2024 06:52:52 -0700 (PDT)
From: Brent Yardley <brent.yardley@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Message-Id: <92C0327A-E1AB-46B6-A180-9D886977902D@gmail.com>
Date: Fri, 26 Jul 2024 06:52:41 -0700
To: ltp@lists.linux.it
X-Mailer: Apple Mail (2.3774.600.62)
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Re-enable access to LTP
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

I was removed from the LTP due to not having TFA enabled.  I have reenabled TFA on GitHub, can I please be added back to LTP?

Thanks,

Brent Yardley
brent.yardley@gmail.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
