Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513BDC55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:53:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6910C3E723E
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:53:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 791273E2D30
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:52:50 +0200 (CEST)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F46810007F6
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:52:48 +0200 (CEST)
Date: Thu, 30 Jul 2026 20:52:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785415967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AYKo/Rk3Bz0SgpnHKEtmtGKqJ7irOgHzjRmxhKHos5w=;
 b=tnN10Z45H7DPHfv1gkRdPSuWSa3dwY9gLrJGmfK/5O6sfTgJUWxq77gmwpn6DILqmklYvB
 4sO0m0bWhok9iyvc3P/I9kVCmgQJ/AVKkajyclfBpgsQc2xUKXg0pouFn3KSRpjMr70RQp
 UE/LCJaTBp/IRRPak/Qr5XrUeFB/uAc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <amtJFVYrok5gb5q2@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
References: <20260730074120.180101-1-li.wang@linux.dev>
 <6a6b3464.9099b29d.17a1f7.d2b1@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a6b3464.9099b29d.17a1f7.d2b1@mx.google.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Andrea Cervesato wrote:

> > +	if (TST_CG_VER_IS_V1(tst_cg, "memory")) {
> > +		SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", ori_mem_limit);
> > +
> > +		if (swap_accounting_enabled)
> > +			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", ori_swap_limit);
> > +	} else {
> > +		SAFE_CG_PRINT(tst_cg, "memory.max", "max");
> > +
> > +		if (swap_accounting_enabled)
> > +			SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
> > +	}

> >  static void setup(void)
> >  {
> > -	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
> > +	if (TST_CG_VER_IS_V1(tst_cg, "memory"))
> > +		SAFE_CG_SCANF(tst_cg, "memory.max", "%lld", &ori_mem_limit);
> > +
> > +	if (SAFE_CG_HAS(tst_cg, "memory.swap.max")) {
> >  		swap_accounting_enabled = 1;
> > -	else
> > +
> > +		if (TST_CG_VER_IS_V1(tst_cg, "memory"))
> > +			SAFE_CG_SCANF(tst_cg, "memory.swap.max", "%lld", &ori_swap_limit);
> > +	} else {
> >  		tst_res(TINFO, "Swap accounting is disabled");
> > +	}
> 
> 
> I see a pattern inside text function and setup(), maybe we can create
> a function that reset memory.max and memory.swap.max in one place.

Not exactly, the logic in setup (save) and test (restore) are
not identical, one reads the other writes. 

Or, did I miss anything there?

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
