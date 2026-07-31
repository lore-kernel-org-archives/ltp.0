Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA7DC5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785496849; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=l7CFkNiBFZmi73Yw4qGpq0nMtvqqIMG4IZtDZnqfQ8g=;
 b=mztrHngAUjxO2Wt+/2/jzZ4AsAXMaW0dteOZEtPG8iRo6HwubSKUgtyfWhN72uYudRfoI
 54OM/8CG6mpwxvVJ+0MrE1tV44x5dn8Y7fEJCgTsuVZMq5ONVLJtRLExYidgYSGVigXO9OP
 u8iy5bcnklSt0D76Ufl9zPnvUwjeFWg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16F4D3E71D8
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 13:20:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140ED3E2D15
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:20:27 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3C7E01A00CBE
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:20:27 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so608411f8f.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785496826; x=1786101626; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VO4XJ202wLRpAXMM0Y4t6O1nT3huoC7YxtsqHi8AKV4=;
 b=dd4xS29ubPesJWK5dU55PO4rrUuPUbQv0T7mgJPHfrjriBqNf5Xy55uhMIeBhdutaC
 2S49CwjjMF2yaKhu5T36Ou87b9O90sqk5H7141xsh3UkswRtTdnV3IB+AfArRdVT52qR
 bmNop+AvBySubyr+/ahHQbHolly9F0BhwvnFPKtul2mJzXAYZTg1XJ5ZgCzPvIpTrzUV
 6/aHQDA2WZv5akr8Kjb9HXPva3v30h2ozQ6ysXnDKrMLoxLbSotCiQR7dZKCbnA/0HyY
 /40UKdm1mQ1Yzgl6VlLZr23vHxzn9NSdsaZsNXsrwtBM4SEaC6DRnJxEAFm8MZVhwe9y
 JnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785496826; x=1786101626;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VO4XJ202wLRpAXMM0Y4t6O1nT3huoC7YxtsqHi8AKV4=;
 b=KoeP2FqiHNmuAz7+lvdVASaWDVJuBW6gf1USoGFGlqKzQyga3nW2fuuj0UcSHwO3Fx
 BMyY5RwHhx93wrUr9bWa0RnDTtEh1wlLJ0NJ3gFUY7aTRXfAmJnopVr8vkBDAlH0O9G3
 2YlFC+V3rquS/ClRXaJKk6cFeTxm41mt/PbP4+rsRG2ZTlcGbctx0wpahVcuFH2biK1j
 Y7p0a+c6BqlCmxj3ddz+wUaFlwYYFXm/cgzkq2NnWHJYEUjPlATraRFOAuRctgSwyuSo
 0JTtY28YdL5G/YgNEF4uPkyNkO+MhOjSQszPtXjyekFGbqp5CGMOs9C0aETdq0pJgmPY
 +oLg==
X-Gm-Message-State: AOJu0YzyVFVz+WBk6UMOa3bHtcjvx7+jp7WwtS3usrmCssq2SQkmO5YQ
 Pk5dEtkX0+D+koKUYSpJotVDxHRv/7uHA9HRXx7gT1ATflTNKeFZac+xEtqOpyaBcJaHax60Kjc
 zujvjMLMXYQ==
X-Gm-Gg: AR+sD11lLirB1eavZIkpImUwuEL/PsrkF0AZtgupxmQQzMGOuwA/Z5Nhao/MIeTK+6y
 GYzmiJWJCt62I9t02BD5pOImplU7F05Rc+tsx6KYCYOgUAi9aiDkyGe/xZmLocO8/m7mxAVrpX+
 ZeAChw9k0qxlrb95Qein/ElOFneh4Ef/yWcWvqBfk5BkHY5BWZY6wDDklH/dYhMcsBA0Sv2Ummo
 svgjZJ7E9xAw8upQIjQW1kS7WzjwBiPlMCiUKsDjDXNiR8AkyzCS+qiwrNKoGGiF8LMPTnbdpa0
 P7ybcUQUtCw8zGaCfIzI+mgi7K0WTCPgbk8sjU1HJwLdPRD8XC7jIM2Z+rKbKtArD0W+7bqKYw+
 nXvUX/b9Yj2RYzegNLfKaEJPt4saYBHYiBrov/61tGPwpjvxYOevHwOYMReIN7QJh55RZxVV+16
 +/liJIe8NnX4GjjzztYFE7N8dvY+mp7d5TJOhiZp0nKqvWneODqZ/iyzy0AwcCfVtfOyLLDoUXH
 MDXBKcKOIh6yoxVt+HXGHDZfOsBUK+wCvmVyaFCC8/2jwzR
X-Received: by 2002:a05:6000:4028:b0:46e:1815:6a83 with SMTP id
 ffacd0b85a97d-47fd2b32c71mr3663136f8f.29.1785496826472; 
 Fri, 31 Jul 2026 04:20:26 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458b73asm3173473f8f.29.2026.07.31.04.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:20:25 -0700 (PDT)
Message-ID: <6a6c84f9.159d33f9.a396c.bd72@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260731111619.GB192663@pevik>
Date: Fri, 31 Jul 2026 11:20:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2026-53362
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> FYI Andrea by accident added unrelated testcases/cve/cve-2026-43499.md and
> testcases/cve/refluxfs (binary file!) which obviously weren't part of Martin's
> patch [1]. I removed that in 2a002a2c7b [2].

I'm sorry for that...that was clearly a `git add .` mistake.
Will be more careful with this. Thanks for fixing it.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
