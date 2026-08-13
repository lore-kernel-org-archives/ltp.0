Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7265EC5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786604229; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=FVC60TlqgTgCuBmoGzmrR0nggLJ03pMjkOANhnuTORKccF02zgIN9H8F8Fq/csGUKf/Ow
 PoDf8r+ZvclP+CJYfIVNYW2/A+RoGcxnBdS57fEy7tm542lWHV4elsIU1Ahz0fQha4E+wKM
 /PJfPUXzNl+7edR1zOieWTKaRaZRBF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A2C43E5A12
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:57:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16DEF3D8567
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:56:48 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8394910007AB
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:56:48 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so20824045e9.2
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786604208; x=1787209008; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aFdljvqhSyMcGxRuPHXJDo+x/W3K+DxSR3zWiF0HCknY55widDAJJjGVSFRAw1buMs
 GGSZl4FuTM4w94WCF7nflbj8G0On+hizycDpAdf2a6EJbckZrpXb0qXmWGxMn1spXZVQ
 3Art4V69n2xFLQL0SBGlIN59cV+fd1Rjm8BLNWu+BW0A20+vD58zQ2Jw7gsN6FeJR3JH
 /cm2oqER07N0VceZM1bEpbSbATUZi8sa1b6Nf6henDCJGXrH2nSaQM0Ik3eRsuEPtBrK
 o2JCuN4iSqZv9d0WrmhNPTizhvpOw40mayrX5k50v7h1j8apQtx1/Z1wMEUpJ8z7K70f
 p5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604208; x=1787209008;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=cHBTREQbYGad6yQUcM/lpGd5LeeNHyKt6wMMYzv7wN3fFDurXNjwNfr2+zTia1+Swu
 ArZMhEpQXsTG/wjcuhPGX5iyK8BZheWzW1kjVWeYS3sxA8LvtLrm7o0CAv7itbG8Yi4I
 kiSl/7HUAO24LBCD+/s09gNEZSkZF4fDy7nTahKJIdGxLHlU9fYLwA+XTUhpVTU8sbzv
 ToGRSdZnuYAt7umkccq46nDmrsfhzyQIzMv62e5Aiba9IctBpQmt4+b9JEB0XVB1WZv7
 Yl5lqpSvmKx1O+8ZpFqZri/Qh42zYY6/NHR6MixarqPDoT1qiRA9wWGR55dRcRYVcp3C
 pwyg==
X-Gm-Message-State: AOJu0YwK3VhpNvD6fQK2lzwdidudVH+zS2Dq/G6N1Fu+EsMICE7e6ugF
 5LKHUnEmWxJtl1mlnM9chcUkB3BHooxKHWDTHGShU/QZKbfC4TsLl5OE/JjRGLd28xC29MZHEKE
 3M2iseAA=
X-Gm-Gg: AR+sD10Lc45ElSoAppZ9lAN5DsctOugtMF92M2uVSE8aHtOR0OifJKsjiSO2k/CKu0A
 ACrsP/gWToc+8yJYPA+HLaBS9MfmTWl6DwAF71ZhUuIFeyjXLX441AKdijeat92QtCv7Bw/aLOG
 xAnj5kDnrDzfih9xCCySglRPSQ6mZVC4Nkzrg4639u7Qnp9oo33ARUch1Rw7vPs8eXLpSW8unyY
 c5wmTPdSL4eAB4AkCGjjJbNfpCZVXVj8sDniapi0CngzvvDv1d+808Xqj08ZeEGFCG5mvtsIr44
 sNP8nQBz0J/YbbvV6I2AT8f6AuWQJd1nlq2kIvMcJ6IHTSx7daPubhcst9hN4wYlYD7QMbPoiOi
 yMvR/1s92VB1y/hKS9r1EHF1C0IYE7oHKQfsa5M4sdJaHAEimyQ0z7STTfAIxZ4Z5HUohBDrhj9
 NbJ2g02+JQbrlhMcTL028vxpsaDS3b8qJMe4Ru9UuIc7nWX74QXCv6ATXN2qeSTeIhgCwLgbo=
X-Received: by 2002:a05:600c:1d0e:b0:499:51b8:d649 with SMTP id
 5b1f17b1804b1-499821c3232mr28800535e9.3.1786604207949; 
 Wed, 12 Aug 2026 23:56:47 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b6abbcsm44059465e9.15.2026.08.12.23.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:56:47 -0700 (PDT)
Message-ID: <6a7d6aaf.deaaa24b.60aac.80be@mx.google.com>
To: "Frank Ranner" <frank.ranner@intel.com>
In-Reply-To: <20260812112737.2222475-1-frank.ranner@intel.com>
Date: Thu, 13 Aug 2026 06:56:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp] testcases/kernel/crypto/crypto_user02.c: try
 non-generic hmac names first
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
Cc: Frank Ranner <frank.ranner@intel.com>, ltp@lists.linux.it, Eric
 Biggers <ebiggers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
