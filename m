Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BD1C9833E
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 06:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790576881; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rbAORC5gU0swzJFt0wTBdKJh1DR08Exa+bJTp3naRPE=;
 b=FZb118qYXIVyZqr5hsdi01fwsqAqXZmgJ3+Q//Zxz+0YO96xjOrP2q+edf2KQkIbI9Z/Y
 RW0I76WBjm78TpboHe7FqC8A2wFE5FJJ1FyUJJxifny8KMSxGPnFENP4BDiJO36A+xh61+K
 Phj5qYfL8EHTOX5MsAdBwWGzlkIUqnI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0EFA3E6BE9
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 08:28:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127AB3E59BB
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 08:27:40 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 728E71A005E9
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 08:27:39 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so14229745e9.2
 for <ltp@lists.linux.it>; Sun, 27 Sep 2026 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790576859; x=1791181659; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rp7ovj04lEupeu/einP1BfvafIK7tt++v09BxvjAUt8=;
 b=YtNzM9DAX5+CjphiVXkZe8GatYz784lkIjcJdwhYjoXSD3VGjjZv4FtY8RoDbU8NWD
 2V/+ThLN+GaByHmoxqSbXosU0b+1ig9yLByHvkbzEvjW1hVQXHaOwFm5UjrXvyC5fdlc
 64GgfqJT/DLracN+UamGnr6k5okelKXbvKMdi1sDEhoQMNmQl0J4iMPRmAakIfs3e+JI
 MyuKorPdU82toL9GJknmCISW47Hlk3vSYajlVu+gDc3N05USfd+m/2iGLKnPKl7iwYYJ
 +f1Ppc3aMaNePpSKv5ADPGHCsgC17HxV20YCA+ndflA72sfDs2Nq7l3nVBcHGCIM0cJ0
 BlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790576859; x=1791181659;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rp7ovj04lEupeu/einP1BfvafIK7tt++v09BxvjAUt8=;
 b=shr4v9KxmmEUYwRMJBq/NbP9yWN2OKeKi03hfr2I+03c79PAl+9ZYGBqvEXXc34tpL
 3zKgGNK3Gzb1x6vuW8aRF68n0MTUR6rYm08RwbPzLq/vUm+wujk7zULWEEyyAFOPdrrY
 9feBftyAEQctBg87zsLafZC+Ade4EuxGBINrYcixgy7y1h3EXd6y7967OzI/StKDGkRA
 TxxdlDRKHytdpZoleKek42AtzcH6KEyodNNlviSDIjB34Ke0/YtssvtfSz5xpMOKvMSU
 31lQlLAfAEp8yTDQWmziPGr6av3NYXcV1KFjgyhug+d8zXnl78SJV+bhzscEZ7xzMYqk
 G4jg==
X-Gm-Message-State: AFuF++mcidSF6lzge4occpjZ9aUzez5Ht1erweRnZcz/oxSePhhx5xEd
 e6LyiwmVvugyg1LT2R1cvQvm4MzGlMFaaq4OtAnJZxj2kJsqUFyHeKIAgEJXCrkXCQ==
X-Gm-Gg: AYBFou3PNAviEty0R3JAC5TmAfUR/otmuvOtQ5KMwa1GUNRigaiYoGycq4FzmxdOcs8
 /K2QP/3DFSoOVktZMBfBCVC7tJ0OMcHZ45TgDtb9HImQu8WUQxnHpM0ZMQZvdKgvOKQs0RZubm4
 nVGfi12M4I3ewdeG0zJThEzwPmYJtsUeIuHFSJQX9/EJMDi2mPbrbHsPZEwn1IwTvq0kOobcTkF
 ysKl2RxQ84i5xoeqUlmqi416og8kle+q8i7M7vy57snsfjOvQntFHZLApEcDcVo2qlvennApj7a
 MG67uxFA2ALk95ZAzgDbO6ay1q76arbl0nuTd3mVldaWC5cwVAFVqyOaTCQ1vc9CjOiJ14+gAGg
 EFrC3nY8Aap+jB/aUyZFeqHwpJjCf2FxWhz/1KSr3qH7WJSVXeTwt2vk3dINUJPojU2WY1+Y44g
 6X7RSyTQ9nOCl+C0HInMwwP/FDAdHI9tmQ8N/eHeirjThAjGIXIRaoMfkIbo2AyZcVD4TSs/Hbn
 RFu2Kr9kNHWsLMCSB5XURWCGlWi75yZ5/0MixyDoIyj9J9vFYTWM0GGROrImtMG3xfUZ+cYiIVP
 xZfYFzw=
X-Received: by 2002:a05:600c:198a:b0:4a0:17a:8844 with SMTP id
 5b1f17b1804b1-4a0017a8a37mr46443305e9.1.1790576858713; 
 Sun, 27 Sep 2026 23:27:38 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a007fd1847sm25434555e9.1.2026.09.27.23.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:27:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 06:27:36 +0000
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <aroI2PWiv_NYXYVj@autotest-wegao.qe.prg2.suse.org>
References: <20260926204459.20699-1-sebastianchlad@gmail.com>
 <20260926204459.20699-2-sebastianchlad@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260926204459.20699-2-sebastianchlad@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Sep 26, 2026 at 10:44:53PM +0200, Sebastian Chlad wrote:
> From: Sebastian Chlad <sebastian.chlad@suse.com>
> 
> memcontrol03 (memory.min) and memcontrol04 (memory.low) still expect
> A/B/C ~= 33M and A/B/D ~= 17M after reclaim, which are the values from
> the original kselftest. These were never derived from how the kernel
> distributes protection among siblings, and the kselftest replaced them
> with simulated values for both tests in kernel commit f10b6e9a8e66
> ("selftests: memcg: adjust expected reclaim values of protected
> cgroups"):
> 
>   A/B/C  memory.current ~= 29M
>   A/B/D  memory.current ~= 21M
> 
> (see tools/testing/selftests/cgroup/memcg_protection.m for the model).
> 
> Real kernels match the model, so the old D target leaves very little
> room below the upper bound of the 20% tolerance. On 6.12 x86_64, 105
> iterations of memcontrol03 across ext2, ext3, ext4, xfs and btrfs gave:
> 
>   A/B/C  27.5M - 27.9M  (old range 22.0M - 49.5M)
>   A/B/D  22.7M - 23.0M  (old range 11.3M - 25.5M)
> 
> so A/B/D is already at ~90% of the old limit and small variations in
> reclaim push it over. Passing runs on 6.4 ppc64le show the same
> picture for both tests (C 22.6M - 32.0M, D 17.6M - 24.2M).
> 
> Switch to the model values. Keep the 20% tolerance, which is already
> at least as wide as the kselftest's; kernel commit d2def68ae06a
> ("selftests: memcg: increase error tolerance of child memory.current
> check in test_memcg_protection()") raised the kselftest tolerances to
> 15% (C) and 20% (D) for the same kind of sporadic failures.
> 
> This doesn't change the outcome where C is reclaimed far below D while
> the unprotected A/B/F keeps its pagecache (seen e.g. on ppc64le with
> C ~= 6M and F ~= 13M). That is a protection failure the tests should
> keep reporting.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  testcases/kernel/controllers/memcg/memcontrol03.c | 13 +++++++------
>  testcases/kernel/controllers/memcg/memcontrol04.c | 13 +++++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
> index 96224c4ee..aa94f4999 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol03.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol03.c
> @@ -18,9 +18,10 @@
>   * memory pressure in it.
>   *
>   * A/B    memory.current ~= 50M
> - * A/B/C  memory.current ~= 33M
> - * A/B/D  memory.current ~= 17M
> + * A/B/C  memory.current ~= 29M
> + * A/B/D  memory.current ~= 21M
>   * A/B/E  memory.current ~= 0
> + * (for origin of the numbers, see model in memcg_protection.m.)
>   *
>   * After that it tries to allocate more than there is unprotected
>   * memory in A available, and checks that memory.min protects
> @@ -217,10 +218,10 @@ static void test_memcg_min(void)
>  	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
>  		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
>  
> -	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
> -		     "(A/B/C memory.current=%ld) ~= %d", c[0], MB(33));
> -	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
> -		     "(A/B/D memory.current=%ld) ~= %d", c[1], MB(17));
> +	TST_EXP_EXPR(values_close(c[0], MB(29), 20),
> +		     "(A/B/C memory.current=%ld) ~= %d", c[0], MB(29));
> +	TST_EXP_EXPR(values_close(c[1], MB(21), 20),
> +		     "(A/B/D memory.current=%ld) ~= %d", c[1], MB(21));
>  	TST_EXP_EXPR(values_close(c[2], 0, 1),
>  		     "(A/B/E memory.current=%ld) ~= 0", c[2]);
>  
> diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
> index 22ca1df8c..92ab53a51 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol04.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol04.c
> @@ -17,9 +17,10 @@
>   * memory pressure in it.
>   *
>   * A/B    memory.current ~= 50M
> - * A/B/C  memory.current ~= 33M
> - * A/B/D  memory.current ~= 17M
> + * A/B/C  memory.current ~= 29M
> + * A/B/D  memory.current ~= 21M
>   * A/B/E  memory.current ~= 0
> + * (for origin of the numbers, see model in memcg_protection.m.)
>   *
>   * After that it tries to allocate more than there is unprotected
>   * memory in A available, and checks that memory.low protects
> @@ -182,10 +183,10 @@ static void test_memcg_low(void)
>  	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
>  		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
>  
> -	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
> -		     "(A/B/C memory.current=%ld) ~= %d", c[C], MB(33));
> -	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
> -		     "(A/B/D memory.current=%ld) ~= %d", c[D], MB(17));
> +	TST_EXP_EXPR(values_close(c[0], MB(29), 20),
> +		     "(A/B/C memory.current=%ld) ~= %d", c[C], MB(29));
> +	TST_EXP_EXPR(values_close(c[1], MB(21), 20),
> +		     "(A/B/D memory.current=%ld) ~= %d", c[D], MB(21));
>  	TST_EXP_EXPR(values_close(c[2], 0, 1),
>  		     "(A/B/E memory.current=%ld) ~= 0", c[E]);
>  	tst_res(TINFO, "A/B/F memory.current=%ld", c[F]);
> -- 
> 2.51.0
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
