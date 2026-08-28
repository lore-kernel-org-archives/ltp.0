Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7B8C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787903886; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=itleDxSZiA3Z7pds1y8qxnc0pOb0VRH44+SUz2MLzCA=;
 b=ITO93s+tKcDQBr5icJBHw5PDLk+zUkzIeNzgPz5C92ywyiWeDW0h4cCGUC44VhAPOLizy
 QwQFmWyaB/jp20bYcIf4noIEY04tb9v0/YyqqhclC1v1KcdNg9ccwgTn4JhZmUJoHRz5N9u
 uc/CqbTyqjvkmQXC/yMeOeUl1INYlvo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 672D13E2FC7
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:58:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0537A3CC02A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:57:46 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 86C076009D2
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:57:46 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-482db627cd8so437762f8f.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787903866; x=1788508666; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oYsZa8eLns8G66cMpaGq8eQUigbOMDa5E/ZlgZtoAFg=;
 b=cM979AIvHtuAeuu22qUPJeMSeZd/jlCRksoR68LyxFltcrfkuj9Zb6Zu+uhSs4DVdd
 8bV6Bd9f54hc2gswunYogs6Qtkb4pT99wKH9qsy59Cy+JTQ/PfMrt286whvS5yYEs/wO
 YB5/OF5Rkz89N6E0VvU7Fjy/QhLhi/2ReXwYoVCYELsTmK399NMzVMVWY4XH/cSHCL5L
 k+/5mlZ/OEG91EmpiLJcoEdTjOz4D8h/dIuMhDTEdaQ6GiBnDNKOv8mBHVwk5ueRlUfX
 25w3LRsU3VfBqhBhRtmHbrxfS/lvLh522O/yAkjEqEO+6+mvGOAPcM2D1aP2AMfKcOlg
 RahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787903866; x=1788508666;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oYsZa8eLns8G66cMpaGq8eQUigbOMDa5E/ZlgZtoAFg=;
 b=LXlYIsrZSZ1d73sdJxsIKgw6GnpQHdhhDsSJD10j2GBeqjO9wofF+7Zal5Nd8/dmBn
 Z0bRfGOsWXjYtdaXNdxWwR7YxwZgWP/3uuMnTiwu/G3GL0s7SKgBWZcEmPH9xMXKOipt
 12VV+M1P+92eha+JaX5/ZhBIEyNxB+L7jrFixejgnqJm9gUVokTaQkmOkLuETDiOc++X
 mV4UwRYI0Ol6/6u3ASskZ5/WU8zGCF7Ji5ZdhNkoVCSNkSYmyA5DlxWEOU759xMejDdo
 jhqOeN/REhBXh/2KH6EgCGfJnCfosEHC9uA3ZZhzSPFNIc52hI9q47JUvOhcBGrKI/rS
 Eu0w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov9zGPeKtJ5at4T+p+L5iFRxxOzja/p/OSJlSSVPAxd/X7mX16dJ2uVtKfm2QiyN6/Rwg=@lists.linux.it
X-Gm-Message-State: AFuF++mWGtX1yBd6Iv2TdSnBojip7u0LQOl/WOrcjOAOndu8Hf8YvKIv
 5QhTfecQTmCo1/x5F5sARRmGR5/6R/r9D92+rIUoP1XjbPhiNXwEuC6Trmwv+rRJqH8=
X-Gm-Gg: AR+sD12uD1JilkpFBMhaCFSJao/beZpuF0KLcPLpdPFLyoBJwEbfUUmQCNULyIx7tM8
 sV9/OyxCJrKXxSpRrxXa2wa58Y0TIrk6HJ1n+rl+t/Lk/iakv4NtK6eQEnFARDtgGSu74vZoDSA
 4CrUCrRRyloiJmiBiBUO1SZogmMCVvYk5x2lh9aJ59c/jkW0oIke896MpWZRADuBKz4g3GGc8bY
 +cwmEo4Gfg8QQDs1Xgry/lcp5kEN9OWbWPJ/f1SWI/7ERIlWExvP7SY0m9qcbV2wrPmv2tqyiUq
 31334QonG6qROd8b8fz7AFynN7j60/hTBKNmCtPElOsdofnDpL+YfwSzMD54sfF98x/0SbrfjIy
 Vl+oewNi2rlKR4jyQXf9mHQsrM6paoPKSLdelU1xNme9Hxhf4yRXOGk6Q1rqJqlGb8NoAyFYuhn
 sfst3BVR6jCuqAZiZZVvchhHnA20v5hHR0yD53nfmtFUmQRhjUV0PW/e787w/7MPFTTspLglJok
 qHlyl6eIhwm+sbhpbY2qoRZkq/o/7YxRdkn4uzauODtyT43TRh4bmOz6Ubu95S2KObaBNI=
X-Received: by 2002:a05:6000:2205:b0:481:98d:b24 with SMTP id
 ffacd0b85a97d-482f7a25ca8mr7370168f8f.19.1787903865881; 
 Fri, 28 Aug 2026 00:57:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb32d30sm2326659f8f.34.2026.08.28.00.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:57:45 -0700 (PDT)
Message-ID: <6a913f79.be490abf.345a53.fc24@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a620c6d.d5b2c389.2916d0.903b@mx.google.com>
Date: Fri, 28 Aug 2026 07:57:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 2/3] lib: New library function tst_get_free_uid
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

Hi Wei,

> > +/**
> > + * tst_get_free_gid() - Find a GID not assigned to any group.
> > + * @skip: GID value to skip (pass 0 to skip none).
> > + *
> > + * Scans the group database for the first unused GID starting from 1,
> > + * skipping @skip. The @skip argument can be used to ignore e.g. the main
> > + * group of a specific user in case it's not listed in the group file.
> > + * Calls tst_brk(TBROK) if no free GID is found or a lookup error occurs.
> > + *
> > + * Return: An unused gid_t value.
> > + */
> 
> This documentation is out of scope and should be sent from an another
> patch-set.

this is still valid. Can you please remove it from the patch, or
append a new patch just for this documentation? So we can split
the current implementation from the documentation part.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
