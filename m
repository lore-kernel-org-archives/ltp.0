Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F66BC9832F
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 06:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790577132; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mh2Tkz19EwziCNTbiyNNItKmBdgFUR/8FTT7kAwviWQ=;
 b=XT1wg4V+RZHyZffTquDNRymSOVtWoAcxz3eRfmTe3GoyKFyShn8m8BJlQ3W7TWq1+kN2f
 rE/C9GdcNR5dhyoHv15moUMN+Zooike/NsHwFQZRZTAY7ThksMjANWOMHDN60+EsE/h3Qgs
 rriJi5lmfIN7kQnfDYnUnYAp2ezm67M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A895E3E5A3D
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 08:32:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCF4A3E59BB
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 08:31:52 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1662E1400152
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 08:31:52 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so10845485e9.0
 for <ltp@lists.linux.it>; Sun, 27 Sep 2026 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790577111; x=1791181911; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9baK0cI7RkbTEmqXM+iEw/O5FrStrsfnXQ7WMjsxnAs=;
 b=Z4TNjjklpldkWDBpfbC2U1IBpcbiGJmdAkcE7ogXp8LpA7I4iAQM+fx3P+C+f9Ftyj
 pVsnp8RnkAHAOrUQMIGqMjHJiafJVbd9jK95Hgt0XZPH8N4wC0I+3jR61V0v/NlQRY0k
 mMO6rNzM+RM6trXME0W93GPuUoSMaO/910kq5dJW3DRn0pym1hNVRXczeLioCGqO9p6c
 2OPMZT+73ukTsajPtjjzcZqpqW9bde4nXVes3k141icwNKWsToiIVlDLy3tyXZzDCvGF
 hoASdIvMf4K/8VTkpCp2+DGTaGRn3rCx63QvUX0i3vy+PBa+QiNkVOLuIzbBE4Os3p0+
 M/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790577111; x=1791181911;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9baK0cI7RkbTEmqXM+iEw/O5FrStrsfnXQ7WMjsxnAs=;
 b=g/Fwf9eTvPRC9LxxTczIsUQLPvZOIQtmbvZCorOYUPC5zKrCCMz57YWxFCMxkFOuhO
 xKS43b0WUMRGh/keLl0heLXCD73ZFxdf1JGOBK3lSPzDLBFjOO1tfELhCWIGtXCigJ3T
 9sznQuD+e+V53D50D5hUARfE+YvcZHQwXHrgZPoMl4G/1uSEoyb336N87ovHt+fxyU0m
 KoVB8mu/Ql2FhC2czI9AavAy1lUvPW1bLp5b9PhdyzUMTpgSlb8qIT01Nbl4xhiMMhdn
 xRJtOIavVs2a1GwYCQiiPnBGlcDdKNzrVpNYczV4gYbF8H8wedPvu7zHkptDD9w6Tfge
 Noww==
X-Gm-Message-State: AFuF++noXkuqFEpbRU4sViC91Ugply6j8Go8hKa4S+4FixQLu4eadmvy
 BoYQUaNm0nEOi9JiuieInfkvMMCj1bUKa9M3IB03Yp/Dj9otC1TXkYx8HWRR4hIrmg==
X-Gm-Gg: AYBFou22WlxHu9idfmDHkWYz/3BPElu2KxukGNnrGOYlZFtmVDFWe/eGqJGdeuoHlTA
 J4Jyj7HYDftfMtVNScpqWu9/B016PgRdY4WmwNZXj2CL9rFvtd1aS8W/lO/z/Fbbsoo4IdTTG1i
 fZc7cVeef8SutEFa6fODTzC1GXdWliFnkDjABAPZRvyXoivRbXogT/Jm2z7rIwekzV1ynIL+n6f
 SIT9+NEgtjiCuoEHz//1w8r5X4qJNPJNg57x/5hphv+c86Ilqn0ryybxB/zXrOFhy3b+O9VFLBw
 YGfT5QDsMIn6DuMS4IxTUL7iXhW5Khp7ACsBz1cQFHbFj50L+K/f/YdxBmZaXDnkpGU9je3qjbr
 g87PVaQakXYHX44ToQOyO88cVG3hiAYNU+bQ8FGlyqpyZKTt4DY41V6jaGnJlaYhSrysmnRgIb8
 O7RWJ+7KYy1OENP7lG9YcmbSrtEN8imUhwpM/9U/3qzcibdnf8PTUJ51e3exy+CPw2N0MqmyJ2r
 UTE9ygvv94rgXnXOTy2ZhmqVedzUEXDp5i5u7LazofUQ8JoHfBlRJo1wKuNIumkmKZ8eSxc
X-Received: by 2002:a05:600c:154c:b0:4a0:37b:5c05 with SMTP id
 5b1f17b1804b1-4a0037b5cdamr41278125e9.0.1790577111490; 
 Sun, 27 Sep 2026 23:31:51 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a008f7f1c2sm5344745e9.1.2026.09.27.23.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:31:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 06:31:49 +0000
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <aroJ1RwPUHpekR9o@autotest-wegao.qe.prg2.suse.org>
References: <20260926204459.20699-1-sebastianchlad@gmail.com>
 <20260926204459.20699-3-sebastianchlad@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260926204459.20699-3-sebastianchlad@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Sep 26, 2026 at 10:44:54PM +0200, Sebastian Chlad wrote:
> From: Sebastian Chlad <sebastian.chlad@suse.com>
> 
> The memory pressure in both tests comes from A/G hitting the
> memory.max of A, so A is the reclaim root. Protection of the reclaim
> root is ignored by the kernel and the direct children of the root
> (A/B and A/G) use their own memory.min/memory.low as is, see
> page_counter_calculate_protection(). The 50M of memory.min
> (memcontrol03) and memory.low (memcontrol04) set on A thus has no
> effect on what the tests check; it would only protect the whole
> hierarchy against reclaim from outside, which the tests don't need.
> 
> The kselftest the tests are ported from dropped it for the same reason
> in kernel commit 6a35919005d4 ("selftests: memcg: remove protection
> from top level memcg"). Do the same and correct the descriptions, as
> the pressure is created in A, not in A/G.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  testcases/kernel/controllers/memcg/memcontrol03.c | 5 ++---
>  testcases/kernel/controllers/memcg/memcontrol04.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
> index aa94f4999..25b84c24e 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol03.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol03.c
> @@ -5,7 +5,7 @@
>   *
>   * Original description:
>   * "First, this test creates the following hierarchy:
> - * A       memory.min = 50M,  memory.max = 200M
> + * A       memory.min = 0,    memory.max = 200M
>   * A/B     memory.min = 50M,  memory.current = 50M
>   * A/B/C   memory.min = 75M,  memory.current = 50M
>   * A/B/D   memory.min = 25M,  memory.current = 50M
> @@ -15,7 +15,7 @@
>   * Usages are pagecache, but the test keeps a running
>   * process in every leaf cgroup.
>   * Then it creates A/G and creates a significant
> - * memory pressure in it.
> + * memory pressure in A.
>   *
>   * A/B    memory.current ~= 50M
>   * A/B/C  memory.current ~= 29M
> @@ -194,7 +194,6 @@ static void test_memcg_min(void)
>  		alloc_pagecache_in_child(leaf_cg[i], MB(50));
>  	}
>  
> -	SAFE_CG_PRINT(trunk_cg[A], "memory.min", "50M");
>  	SAFE_CG_PRINT(trunk_cg[B], "memory.min", "50M");
>  	SAFE_CG_PRINT(leaf_cg[C], "memory.min", "75M");
>  	SAFE_CG_PRINT(leaf_cg[D], "memory.min", "25M");
> diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
> index 92ab53a51..f1e136df4 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol04.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol04.c
> @@ -5,7 +5,7 @@
>   *
>   * Original description:
>   * "First, this test creates the following hierarchy:
> - * A       memory.low = 50M,  memory.max = 200M
> + * A       memory.low = 0,    memory.max = 200M
>   * A/B     memory.low = 50M,  memory.current = 50M
>   * A/B/C   memory.low = 75M,  memory.current = 50M
>   * A/B/D   memory.low = 25M,  memory.current = 50M
> @@ -14,7 +14,7 @@
>   *
>   * Usages are pagecache
>   * Then it creates A/G and creates a significant
> - * memory pressure in it.
> + * memory pressure in A.
>   *
>   * A/B    memory.current ~= 50M
>   * A/B/C  memory.current ~= 29M
> @@ -167,7 +167,6 @@ static void test_memcg_low(void)
>  		alloc_pagecache_in_child(leaf_cg[i], MB(50));
>  	}
>  
> -	SAFE_CG_PRINT(trunk_cg[A], "memory.low", "50M");
>  	SAFE_CG_PRINT(trunk_cg[B], "memory.low", "50M");
>  	SAFE_CG_PRINT(leaf_cg[C], "memory.low", "75M");
>  	SAFE_CG_PRINT(leaf_cg[D], "memory.low", "25M");
> -- 
> 2.51.0
Reviewed-by: Wei Gao <wegao@suse.com>

> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
