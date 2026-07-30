Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FDDC531D0
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:29:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C46A3E532F
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:29:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 308F13E2BCE
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:29:04 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 67B111A00792
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:29:04 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-921382c469dso36547985a.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785400143; x=1786004943; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xn07CEidBdhAxiDIo3QveE0Q2VeOnMD9uAZ9ZSkn6vc=;
 b=pHqA0jJPT2ndfVqawixLIRbHQS0huunN87MD2ybH7bfgfGnZ/5fBXVTsI3FtA6bvJa
 iTeHKLGmt/ehFR3UXa5+UlbiqqkBnYgOTrnP9gU/Fr2Q7LMLuvIAhYXceHKQZ7ORhKox
 Db8XjdSzS7nPtu4i2QLADWVmozKUqAWVFk7yd7sjFwsRqzdJpdUmyN/gBcOmQKlAyft4
 DE38pE5VsbBZU4P3aDQZUCU+/OzWmkiaVosKEuyZbLBi0/3D8Rs3XDPTeOpwQDXZuyyA
 bvPj2S3wjjpkT5YnL3PcKRqzsZY3RgZhdvUaM/kx+W0krABXYZAzQj8COvaApjS+zL9/
 PDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785400143; x=1786004943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xn07CEidBdhAxiDIo3QveE0Q2VeOnMD9uAZ9ZSkn6vc=;
 b=XDjldNQNgTuEAB5UYXB+CmtLqI9W8llAorvpBkrE0tun4qf4LJiSKshc0Zq7hvlrJ+
 E5naJii60FPKESrcixEJsXka0rw8cfnviYRuHbfuRTSfudFSxM2fJ4jMUQqZSW4OkIhv
 Dfp13qD+o8L2mGziKeQExKdIV2d3s6W9E269Z2RPiO/lFwMWUtqfZiY+Q8g3Vf4dJh/T
 uwf+TNxksZczalHUR9wEnb3u80V3jKffL4Zh7rddvgezi0pP7SEBuBdx/Ky88TzM+BK7
 0Hd6dhi4hfX8Z3e0KodyBAdiDEBkV+KDl4bl5IUFmpiytsAVIi+tPr+VowJeGtcpG8ie
 0ePA==
X-Gm-Message-State: AOJu0YywGdcn/VZA+PiKRHatj+6X9/MCctGvnEmPH+YeSzkmW3twAwX/
 ScxvQSWgEwKSv8vTQr4VyUxmKjqGm9m0gaG/8/ye8qhw/qVJ7lXDa93z
X-Gm-Gg: AR+sD11NU1ffckvLZV/yjf1GxG4Uvku79HY+XYS8AmoFykhg7eZiLQyPI8ovWHqGIWO
 6EAffNwVhNGo1zrSCH4Pc1Wv2EwLi1VyRsuREc5eGmE0dl1deGQ3F5wKH4StrJB3O+vi1j+USzA
 Sba7R/QdPEEFWkwp2gb32e5iPPP0BBCIioDnnBF9issxgqArqiHFB2shFFF5TMuOBf3BZ384HSA
 ybQ5PNIhp97Nl8OQhTrEh1K0xLlt2YgvbjuLC/GhMG2HDLJoGUqRwl8GRfSGP8elTOUjxJmaeqn
 uZIj95S9eWQe07uemrMCyOisibE+d9t6kjHFoPw5pRqcWSk+eG01MhxUQSoGb4dY22NSGyQhcEq
 abO55EtzwR08kV11GNJxy09PvnVvhwcUPlfkiSTcDyAC9nZ6X9j6Kbd3oakZy3rfyAaAJXAGdzz
 hRmx30Ea7rDLjoI1OiC53eFw+kfifaksmc5Iqq5GN/Dsl/9KKueP5U7de82MUWr+HZSBPLvaAfg
 GfZpRGr+TDl+Rgk8G8KCnPfBD5XSuFg2XBmfT8xwPVnWvOLDELtH3Z3KYaWBsBkr/vop6BFdFY=
X-Received: by 2002:a05:620a:40c2:b0:930:c12d:b915 with SMTP id
 af79cd13be357-93485f99a97mr147830685a.18.1785400142790; 
 Thu, 30 Jul 2026 01:29:02 -0700 (PDT)
Received: from
 runnervm7i58z.f4gzbl3y3u1eff0aeziqr4glla.cx.internal.cloudapp.net
 ([20.57.77.194]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e7318323sm366060185a.23.2026.07.30.01.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:29:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu, 30 Jul 2026 08:29:01 +0000
Message-ID: <20260730082901.3960-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730074120.180101-1-li.wang@linux.dev>
References: <20260730074120.180101-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: restore cgroup v1 memory limits with numeric
 values
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

On Thu, 30 Jul 2026, Li Wang wrote:
> madvise09: restore cgroup v1 memory limits with numeric values

--- [PATCH 1/2] ---

> +	if (TST_CG_VER_IS_V1(tst_cg, "memory")) {
> +		SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", ori_mem_limit);
> +
> +		if (swap_accounting_enabled)
> +			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", ori_swap_limit);
> +	} else {

Doesn't this hit EINVAL again on v1, just with a different value?

On the retry path the cgroup still carries the limits written by the
previous child at the end of child():

	memory.max      = mem_limit  = 16 * PAGES * page_size  (8MB @4K)
	memory.swap.max = swap_limit = 2 * mem_limit           (16MB @4K)

On v1 these alias to memory.limit_in_bytes and
memory.memsw.limit_in_bytes, and the kernel enforces
memory.max <= memsw.max in mem_cgroup_resize_max()
(mm/memcontrol-v1.c):

	limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
				   max <= memcg->memsw.max;
	if (!limits_invariant) {
		mutex_unlock(&memcg_max_mutex);
		ret = -EINVAL;
		break;
	}

ori_mem_limit is the v1 default (PAGE_COUNTER_MAX, ~8EB), which is well
above the 16MB memsw limit still installed. So writing memory.max first
should fail with EINVAL and SAFE_CG_PRINTF aborts with TBROK.

When raising the limits the writes have to go memsw first:

	if (swap_accounting_enabled)
		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", ori_swap_limit);

	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", ori_mem_limit);

The lowering sequence further down stays as it is, since lowering
memory.max first keeps the invariant.

>  	/*
>  	 * Reset cgroup memory limits to default ("max") in case this is a retry run.

The comment above the hunk still says the limits are reset to "max",
which is now only true for the v2 branch. Could it be reworded to cover
both cases?

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

TST_CG_VER_IS_V1() expands to a tst_cg_ver() call and is evaluated three
times across setup() and child(). Would storing it once in a static
(e.g. "static int cg_v1;") be simpler, given child() needs it anyway?

Minor: LTP usually spells such saved values "orig_*", so orig_mem_limit
and orig_swap_limit would match the rest of the tree.

--- [PATCH 2/2] ---

> +Li Wang <li.wang@linux.dev> <liwang@hygon.cn>

Patch 1/2 is already signed off with liwang@hygon.cn, so would it make
sense to order this one first in the series?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
