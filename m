Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E371CCA5FC5
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790780687; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0063nf5XPKyPMsb6gLyvdKHlPmnmAGj5SkbCk5mmWV4=;
 b=hoNSRxXvSTiXnK6YmImHFuuXphKg9K/fGXDCKbHetgikEQVi90tjPXSe3G/uEb+3Lb8XZ
 YbjA1p8sVKlTX1Q51Xpg0MK6oXfnlei/OaqD6PU9JmfiSKDolljYPCz1b4Jh9hyZdTmR3mG
 pl/W7y9TGJtH4lUCV/BWRkbT+QDyG1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326F53E56A5
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 17:04:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E52A83E5EDB
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:04:17 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93DA020097D
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:04:17 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso34471665e9.2
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790780657; x=1791385457; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a66v4EOAU/hJVZmhU4C+MMNfR1l8+jW5ZDF78r+Yaiw=;
 b=U+jHMTNKn/VIt6vkCYf35S0vyPkoAMjG2hMWwfWCB/ggfdOy1yYh9JysLl2Fa13qkn
 vu8H/Yik32MW9mwmLG5Tp/97cIZwd3x8UnCY4zcU0MUYHLPkumCW/LNb8ZNB7TCopMtl
 20byWT2h8UA+esinBDcCv9abSe76L0aY34QHpXYmDoSjKth52PwofpuHYDU0Ws0LPu4Z
 L+XJ+LT9uorf6opLDdSbDDcN/5aLtgFcehPMhsvsCBNHxRcerRhuezXczY+c8meUb0tR
 4GH5ic8KIJ59H2NBtvBIIOfXBAR+YGeZ5Afnikfmopnhsx/6Lzn1cA8lU8dB2yrug+vg
 sETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780657; x=1791385457;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a66v4EOAU/hJVZmhU4C+MMNfR1l8+jW5ZDF78r+Yaiw=;
 b=WBGEIb3K6WWlB160BJLimn6MRmiAj09XVOIOoNmEtwFJ4+TTwgw+dw95PaiLWlKGvK
 0qEwmQPsEkRIS3iF0SxetPLmyrL85C9zPcbMUZTbNgM85niIYqVW9CdGOxPCW4ltiY3e
 ftWnDt6bmzA4ImjVcTlDQ/RB0BoNUihRzzuHHuPCU2SY67xHEv5hOnlMkwrNCYEHWyLH
 jdZsUi/5OVIJ23we1/1qJi/QMBW5nN3Z5FfkGm53yPh2aB4naoxyqeMr7t7pffLiXTgm
 8dlGWVK569edaRBN2BV9ix5B+pIt4fuZiuXSkGTfBX3xHMZsXIBJQ0tqPKxnYNJZ7hp1
 ncRg==
X-Gm-Message-State: AFuF++ljF6uKFVqqgNC4mXUqLJqvICZQGzBMSbvUr73qC8Ez+UY+mNjx
 a5QVVXuR2AqVbafs76HeWGQcLff+VO+NdV5o71SvNBAjLFEsCCwUJML2S5aVt4ydCrE=
X-Gm-Gg: AYBFou34Jlj1IWPtwjPiHTSkAhOIbL+BWPmQCA1eqtWBUtd2YiarVkfhGwzYwwgWlSb
 1yXf8kUiFlFntNbJZ0dPc/mzzMcJkJLt+5fnmq5J1/9kn72GwsUJaWjKC7X5L/3/dXz9dzX/LPM
 RG1I6yndoRyW3hdkX7cZpBpyiFd8TjrFhExtpxYP6i1gZjPKLT+oGCfqnAo3fP/t1z/BFpwlLYr
 ZfoDluAy83Ura9RM4sBWvL/Jwa8eXDZcSt3aeytvRmfFl7LrYTWisnv3K4oapVM78dWtxJLbePR
 yY2cpnvQBxoJ0kUo9XivfUoIvrGraTqU+NVsAKhmncSd/QO+h7FLG4Sb5L0gPUYHIbjKAxBU/3e
 Gy+UWvjFAzuOi7/XTZvntGV6lS2JosnnUS363jCRDzLhJwX9UnLoipxmCZooT8egMalhQNjGzXl
 AAHYtXtYfrqaEfGmV4G8E75A57Y3EBPjDhJOq82hFNEVjKSouDpMZ3Ae2bh57DrMhkT4tTdhYam
 jPKVqS9iFol
X-Received: by 2002:a05:600c:45d3:b0:4a0:e45:e8d6 with SMTP id
 5b1f17b1804b1-4a01aff0bb5mr24136495e9.13.1790780657055; 
 Wed, 30 Sep 2026 08:04:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e66b10esm5233235e9.14.2026.09.30.08.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:04:16 -0700 (PDT)
Date: Wed, 30 Sep 2026 17:04:15 +0200
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <ar0k7LgZQmrtajlZ@localhost.localdomain>
References: <20260926204459.20699-1-sebastianchlad@gmail.com>
 <20260926204459.20699-3-sebastianchlad@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260926204459.20699-3-sebastianchlad@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] memcg/memcontrol0[34]: Remove protection from
 the top level group
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

On Sat, Sep 26, 2026 at 10:44:54PM +0200, Sebastian Chlad <sebastianchlad@g=
mail.com> wrote:
> From: Sebastian Chlad <sebastian.chlad@suse.com>
> =

> The memory pressure in both tests comes from A/G hitting the
> memory.max of A, so A is the reclaim root. Protection of the reclaim
> root is ignored by the kernel and the direct children of the root
> (A/B and A/G) use their own memory.min/memory.low as is, see
> page_counter_calculate_protection(). The 50M of memory.min
> (memcontrol03) and memory.low (memcontrol04) set on A thus has no
> effect on what the tests check; it would only protect the whole
> hierarchy against reclaim from outside, which the tests don't need.
> =

> The kselftest the tests are ported from dropped it for the same reason
> in kernel commit 6a35919005d4 ("selftests: memcg: remove protection
> from top level memcg"). Do the same and correct the descriptions, as
> the pressure is created in A, not in A/G.
> =

> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  testcases/kernel/controllers/memcg/memcontrol03.c | 5 ++---
>  testcases/kernel/controllers/memcg/memcontrol04.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)

Yes, this patch is easily tranferred.

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
