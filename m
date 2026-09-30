Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D397CA5FC7
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790780668; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5f9bHGx8OOcm3R0Klx90acIiHrabG9pJ7Nt2Ry5yT38=;
 b=ZSaEq4P4fA2h96L/bXgP5aKpUrkU88+EaTSnxs8RRZbnMl0cgSC4GocByT5WSLabM1VH/
 gJhiJWu3r0KV0PFRG2OrsOG7/mVVS0QycCC+LUtORISX4D7+K2kkLCdEkRfd1XxK/yTiyAw
 CS2JXwvzNKLHxkSFHGIJI8bnn1wai8k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21133E5E11
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 17:04:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B19F3C2EC2
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:04:08 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 27D2820005A
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:04:08 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so42548215e9.3
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790780647; x=1791385447; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oC8MxY+YgWMMCp9ETTG4QJzFxvYoC74MlZJ/zWw8peA=;
 b=b3NrOJ9KWUFjq5PpQ8JQXCgC5TcvaeFcxhR3u/O3WYHUlyPL/nq6UTiAecefb6+qcR
 PZyW7MUmLdqvGxoYb0YnBtfu7F2bYmcb/001vPEzRRdxJGOA6BWKegp8Fo0TFnDXmFbE
 tsMsk9jACiS5K4wo3wnOCIxfcwxHBn7CutA8hn6TyP6erTT8FxNP11kTvwBY93PkUNcn
 RzuozlEcJDmTMHlHvduSBNeE1WOfKpw+Wp2rcyjNk02eAaTbYj6WCQRmD8YvC/0S/owx
 UeeKzsTv65+mn6dGVqUKi98CIE+wL9BxQKjh6XGaT0EOdVXCjmYl4ILpRXtR2qIeV87Z
 B68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780647; x=1791385447;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oC8MxY+YgWMMCp9ETTG4QJzFxvYoC74MlZJ/zWw8peA=;
 b=DG3r6PGJmJwkO5RT0+krjPngu3nMZegdfFxnWXWRZ44QPoLwGlrn/BrOo2fjdf82iB
 Gk0Zhw6w7n+HSMw19M2owrOlGFa+b7Iws5IuPtd1/Zd2zjwDavPgigIix1Bv6n/lfEbr
 aw5f0kbYWLWXbO4qhGKS0KqP4tUcGyrMIqcWzkouGAz/3FhhBlN9QkzVlhM/jeqn++q/
 be5jQvdOIXrwYNZ9UEntSAWRF50jEBh9UyLPAsdA0C6Z7pywZDlzduISdlucHWOpEiqr
 a+SNQmv4FAlBglsJEGq3AS5LdYo69/S3sX1B+/ysOsrEE9XFHz6IiuTU009eZ+V/WBzd
 NCMQ==
X-Gm-Message-State: AFuF++kpc1yxNxIPlypZidL9yt+iGkou9NHZ2ozUW8OhbF4C2kuyvMMM
 ahXVo2TSoYEKtb0vkiyri/HK3R3e95+tklw8Ub9UArh8VNoK8qqH/z9QU4LPIpq/xHE=
X-Gm-Gg: AYBFou3WEI7Nf/mX/ZZgRgPDFxYvwgLrTKMAlEYuqf6wEIG+V6LsFnuFz7dV1+YgV1S
 27dSu/yTh7Cexflk+ZS+GDOxzjpTYfLeRB0l7koxHrsjCeU4Np6QiEnHIoggqwK383vom7fclqf
 BwYv+ebL3wwJCer63Pjj5stxwM+/bRuoqQBTHiDsGE3zOCZe9q/Fdz6bWhr3S2vcl7PMvChQDPm
 kg+2plT02EISFM2Zh3lFW289tVLl3AWKiPQW8yIpXUTYmNflQGp7F6Q20N2mnG9JrdO1GYFETka
 Mr6DZ4/6HLBo3iJHJjk8ss8zadQINdmdQpl7CNck8HvCYsOpZcHw0drMPebgGe89nOSfoD0EMCW
 rPuLUheEgzUW45WphOLVp88NIuxL5920/ey7xQp9CrsLWNxxem6VEq3zXKEDIN7EdP4MkTkxPcc
 iyMHNmjFnbcP8xBvwBdrubxIyKzqon3BGlf1xWmdc7U5m3ACAaYdVkGJbbI3btFFhUyrD0o5Oy6
 w==
X-Received: by 2002:a05:600d:6409:10b0:4a0:1c10:12b9 with SMTP id
 5b1f17b1804b1-4a01c1027c6mr18911965e9.32.1790780647455; 
 Wed, 30 Sep 2026 08:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e64dabfsm6953955e9.6.2026.09.30.08.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:04:07 -0700 (PDT)
Date: Wed, 30 Sep 2026 17:04:05 +0200
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <ar0k4cOIGinJHU6o@localhost.localdomain>
References: <20260926204459.20699-1-sebastianchlad@gmail.com>
 <20260926204459.20699-2-sebastianchlad@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260926204459.20699-2-sebastianchlad@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] memcg/memcontrol0[34]: Use expected values
 from the protection model
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello. =


On Sat, Sep 26, 2026 at 10:44:53PM +0200, Sebastian Chlad <sebastianchlad@g=
mail.com> wrote:
> From: Sebastian Chlad <sebastian.chlad@suse.com>
> =

> memcontrol03 (memory.min) and memcontrol04 (memory.low) still expect
> A/B/C ~=3D 33M and A/B/D ~=3D 17M after reclaim, which are the values from
> the original kselftest. These were never derived from how the kernel
> distributes protection among siblings, and the kselftest replaced them
> with simulated values for both tests in kernel commit f10b6e9a8e66
> ("selftests: memcg: adjust expected reclaim values of protected
> cgroups"):
> =

>   A/B/C  memory.current ~=3D 29M
>   A/B/D  memory.current ~=3D 21M
> =

> (see tools/testing/selftests/cgroup/memcg_protection.m for the model).
> =

> Real kernels match the model,

Note: this was true at the time of the model introduction but the
contemporary kernels may diverge slightly from it. (Not conceptually
AFAIR, although some rounding / effective values caching could possibly
affect the final values.)

> so the old D target leaves very little
> room below the upper bound of the 20% tolerance. On 6.12 x86_64, 105
> iterations of memcontrol03 across ext2, ext3, ext4, xfs and btrfs gave:
> =

>   A/B/C  27.5M - 27.9M  (old range 22.0M - 49.5M)
>   A/B/D  22.7M - 23.0M  (old range 11.3M - 25.5M)
> =

> so A/B/D is already at ~90% of the old limit and small variations in
> reclaim push it over. Passing runs on 6.4 ppc64le show the same
> picture for both tests (C 22.6M - 32.0M, D 17.6M - 24.2M).
> =

> Switch to the model values. Keep the 20% tolerance, which is already
> at least as wide as the kselftest's; kernel commit d2def68ae06a
> ("selftests: memcg: increase error tolerance of child memory.current
> check in test_memcg_protection()") raised the kselftest tolerances to
> 15% (C) and 20% (D) for the same kind of sporadic failures.

Makes sense to sync this with the kernel variant.
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

> This doesn't change the outcome where C is reclaimed far below D while
> the unprotected A/B/F keeps its pagecache (seen e.g. on ppc64le with
> C ~=3D 6M and F ~=3D 13M). That is a protection failure the tests should
> keep reporting.

I presume you refer the same reclaim mode "collapse" that was tackled in
7e19705f7 ("memcg/memcontrol04: Fix judgment for recursive_protection")
(there it was only for unexpected events but that could be connected
with the unexpected final F.memory.current). It is nothing new, correct?

Thanks,
Michal

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
