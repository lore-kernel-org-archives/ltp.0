Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7D6FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777381472; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=D0VGBk4ycUxEy4w9v+eKmsk1Cj33zpJQpLZflUmqfjM=;
 b=lZhVIlnIs0aw4YakYGclPy31F8yFwgKWAxUriZmPSRUzVJL1AYZXkT9JSLI6kzyF7vH4k
 sLyn0q+r2QAxM8nQwFNR8OU/kQuWei+GaEpZ1E3fUuARWCODexWm3S0ayDRhouueXOUGnYC
 wW5Ko+jJd85YIIHnXJ2nHIYbT6/Afl4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5186A3E49F3
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 15:04:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A6DA3C7A5F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 15:04:09 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3402A1A008B0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 15:04:08 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso7968148f8f.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777381447; x=1777986247; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=A1zkX8Wvq+5P68J4H+CzIqATAD3vK95BzdJBeREdKv0=;
 b=AFPxg1J85qRAObne4igzb0KHo3wsyWZEXykITkRg7jdearIx6ACjjFXjjLgiMszteF
 auc607qC3wYrkrbEeL7yOZD7Qw4udUryxJ7mE+nZXEzEzfyMTW6ZEU0mgG3iI0ugsip8
 uHOUIl8nSRAGLcPwWf0/i1Wo/Hqo/2lsdR9jfcl8PwBWo0EtXL69Z/RQlPUJzuE7yZjl
 8q2QYz9Yueb036m8EIKLw44zJHBqBaE/7cv0ONNcy+Qfs2nOdBAzRQKOtJIgwprwhzkj
 S4D2j+PCWq15PfNZhrvdKC/nNGs6/IE975ZA8egQoaDH4iwbKUEjPTvz74vb73PnyJzh
 Ea7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777381447; x=1777986247;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1zkX8Wvq+5P68J4H+CzIqATAD3vK95BzdJBeREdKv0=;
 b=La9WjZs2m3oozuTW6b+qy9oDHEbXGQvryY1oivHjNvwCzznpjRlfr5KyTbtWtxpWyg
 dbJiBBP0VapOnvg2akq+JTkY5XLy8FkUdSdYZH0C1NzSkiI+UgT94SPUxo+JiVHDAm4n
 lO45lmABCjCpeqvci2jGHFiFFN3bYOKdYGY6jKAuYuHncaTDLlYIkoqS65TCq7ceAAI1
 6ytCARL/vwv/PLgDLyStZ48jt1iuLauAOsOdctrOu75J1SskoMynCHfV7i7MaPAStF00
 9M9Jl1meEHwy8+FIEDBDS2eWdW58B3tAIUEZ1dEWdWx9vgPd8v/3xtJbaXXpNnzKuFY+
 V55g==
X-Gm-Message-State: AOJu0Yx8H/kGWVArDosqc9sEpsLSNHAoHMLoREY8q9jubGITuJWuy2XN
 6jFNPqTm6DisOreWPr883uXhczc4e1yeg9Labopm0e2VxM2iXdR1qgdbc5yUggbi5NM=
X-Gm-Gg: AeBDieuFe5ip24bzSSww+xWXMCbCmTPydXwKuzwWe3DxXabVkCpnYhJ4zhNwuiZI/eU
 8GCKz/0x3lx5wT1FEEIzrcTyVKg/AkDr4SXyh6xeB4Db3l/HvhH6CWgyAeiQ3vangYVvMtk1b+k
 +N6QWtB176J2dCwzkTaeu9TUMF8ETf8CJtlQXciLMuT2ddFlGH0espm5L7Qigf/PomUNdjRH2BH
 kCdHGzG0juVHUDOoxlwy4iIzRbiNuEAPPmomjbWqUawRsS6FPMnPB8Imj2M7ka0MFoeKj0lb5is
 KhaAkHYwGRtvRJTc631BATLIlR996n2rSqA/pA0Sh3/JPkg5AbZXkT5i9uqQZtCw1NQMcEQjex2
 IVM/yI0amWdDQy/I4sy1YUIOkSDP5ZBiPLywQn97Gh4Xu1K23XaL9vB6dGjtpSF653yBCMOys1X
 qZ0f30iur0blpt7nTBHQQD0W+MjVKmBQsIlEtw37HmtMoDVdrUeRbNRHDO6tVzFsXlm1SHlUcaU
 u3zQQu6635KSrF4dEnpZ9NePOp10t/poTF2yWCeO6BV2Q==
X-Received: by 2002:a05:6000:616:b0:43f:e43a:d85d with SMTP id
 ffacd0b85a97d-44648f28d2amr5503408f8f.3.1777381447119; 
 Tue, 28 Apr 2026 06:04:07 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7031132f8f.16.2026.04.28.06.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:04:06 -0700 (PDT)
Message-ID: <69f0b046.df0a0220.3765a8.f8e4@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <dd3502b7-670b-473c-b607-672695c06f4c@linux.ibm.com>
Date: Tue, 28 Apr 2026 13:04:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] doc: generate CVE catalog documentation
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

> Okay. Do we need year in the column since the CVE name also has year.

No we dont need the year as Petr mentioned.

King regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
