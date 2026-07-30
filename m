Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F9AC55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785410683; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Rnt+ADG8tC9roiQk8aLzPEjbgTb6hLYh3wYw6i2dqmc=;
 b=QGnl+zY9OILjBBuIlIVl1opJA6fj6ZIQ6eZ631VXr+uzk6AF04VjrXdPw06QSQCYyiyxq
 IOjHay7B0utm6GfFokizQvCnGc1nFrareQh2nF08q/3J+3nYP8x0ZojpYOja9BIxCKYfkxu
 ArnUuYEEBiViR1WUlHyu1US/CrKD8yE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7F6B3E56E7
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:24:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA6183E2037
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:24:22 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1482A140098B
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:24:22 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so1250388f8f.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785410661; x=1786015461; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YUnxrOIeb5EU7FkNUTzn5AReAhZNG2yIVPpuJokP6FY=;
 b=A24z+FTIIckSTwKfULzZ5LT3l1tcy67NTzMC/b54zD446IXkNxAiwcxyuN8P4Umehl
 I6T76yZ8LuH+H1v1/XJu5+vBwSfyeiiIb458B6e1BHGZzr24sBKYzaePk0J5V6DLQMIc
 EGddzA2J8G0yGGT92elZD3ge1NHyTa1L626Ih1NWYQGAyy+nksFIi65sRNmr5+FCwvV9
 jlTHL4FhBwq/j3yoBYPVN5b3SFrZRSnBn0Bz9ZvhSx+NP7OxuZ+o/BLEideqx0DtNulz
 BvC8T739UmRrvKE81imYn5h2ameC/WAYgv83aEfOML+7G3IRkEp36AZQCMuv4cJR9M3J
 YVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785410661; x=1786015461;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YUnxrOIeb5EU7FkNUTzn5AReAhZNG2yIVPpuJokP6FY=;
 b=seREB1OWmzAPzFk0ExdJcqwNU+Y2koUXvGCrHrAOl+NfDOngOkzGWp6St11NOgneou
 rfoTUzcEWM+KLtLWmXFm9nygsDKuvI3xk2w/Ep4KpmFOS0SuQfANwK2VWHxcP5udI0wq
 IECcSLV8zbN9LGr68KhqP3T1Uvi/5YO6sCl3pMHePt5tf9zKfbEblu2qfyTTxP4P0uJA
 MsCtF92Gb7cqlw8+lohxFJf2fPLgsqg0ub8PX8Xp371BcqASOeF0Jcv3rCSsLC/OpIHx
 2T7IkuatscH848XPxyImesBMl0vJvN8fqfhaqyNcJDHspSxAEz5U8bJ4lWwpcf3Bnw/a
 C9Jw==
X-Gm-Message-State: AOJu0YxZnZGq084cm424D/iH2qGEsMj/rTyROtHdd3oEAmhkY/zy0Chv
 ZyyW0KWBIWi9nyO8k19dzTffUc7HOOeE4zw+Y+dIVQeNNF78VZwMxUaKWgfdR7LXUGA=
X-Gm-Gg: AR+sD122SRwKGKg+M65kjk1x4kGdiiBigjekeaYIkIkdLDgWJPMHlp9va+HSArc6Eak
 0MiKsLYN23/Qkc2f0+jvNiZtJ6YLU61JFswuGnW6MYqpr/B1xmPPlbX9rmiSrEYBc8WeEjEh7iJ
 K1INvXrm8fudCmdCT7y4gErSrgP16EbwlB3mAoiVUOUZ0Eb8sTasonDcrqKyKkk3W4XRhiMobkf
 MPg4/jfwTbLTfIy0D9vYO/Y4IYLLSrfSHUE74hPH736j5OpQAfZASoO3b13pHabxJ2vXL/uwii9
 WfgxmSV16dRkunaaXsBssEmDIaXtpNGI3NeBHahoOW2zuNG99Zj5pZ+uDE9NeKb1DgrIvbDNQwq
 cixsrH0aittezOS9wYZov/FSypIMCn+Wks4x1yzYmnZE8A+0yexHKlro/osdV/K+Yfk9wa2GSK8
 7nMbazESv7ayKNSwgE4mEIkD8jZ4WBXOnnffxHgH4jvNN2ixWNEX2FeDFgtjeU3d0ZRDKbQ6i3m
 zoH6khYhQzVvez35jhcY5U5mwrn9vWy92MlWwE=
X-Received: by 2002:a05:6000:240d:b0:47f:7b75:9dfe with SMTP id
 ffacd0b85a97d-47fc80c78e2mr2958111f8f.8.1785410661294; 
 Thu, 30 Jul 2026 04:24:21 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc892cdeasm5622460f8f.22.2026.07.30.04.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:24:20 -0700 (PDT)
Message-ID: <6a6b3464.9099b29d.17a1f7.d2b1@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <20260730074120.180101-1-li.wang@linux.dev>
Date: Thu, 30 Jul 2026 11:24:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] madvise09: restore cgroup v1 memory limits
 with numeric values
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

>  static void memory_pressure_child(void)
>  {
> @@ -151,9 +151,17 @@ static void child(void)
>  	 * Otherwise, the retried child inherits the strict MEM_LIMIT from the previous
>  	 * run, causing MADV_FREE pages to be dropped immediately before we touch them.
>  	 */
> -	SAFE_CG_PRINT(tst_cg, "memory.max", "max");
> -	if (swap_accounting_enabled)
> -		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
> +	if (TST_CG_VER_IS_V1(tst_cg, "memory")) {
> +		SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", ori_mem_limit);
> +
> +		if (swap_accounting_enabled)
> +			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", ori_swap_limit);
> +	} else {
> +		SAFE_CG_PRINT(tst_cg, "memory.max", "max");
> +
> +		if (swap_accounting_enabled)
> +			SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
> +	}
>  
>  	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
>  			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> @@ -278,10 +286,17 @@ retry:
>  
>  static void setup(void)
>  {
> -	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
> +	if (TST_CG_VER_IS_V1(tst_cg, "memory"))
> +		SAFE_CG_SCANF(tst_cg, "memory.max", "%lld", &ori_mem_limit);
> +
> +	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
>  		swap_accounting_enabled = 1;
> -	else
> +
> +		if (TST_CG_VER_IS_V1(tst_cg, "memory"))
> +			SAFE_CG_SCANF(tst_cg, "memory.swap.max", "%lld", &ori_swap_limit);
> +	} else {
>  		tst_res(TINFO, "Swap accounting is disabled");
> +	}


I see a pattern inside text function and setup(), maybe we can create
a function that reset memory.max and memory.swap.max in one place.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
