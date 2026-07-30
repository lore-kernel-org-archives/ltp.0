Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C70DC54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 09:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C83A3E7229
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:44:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A63D3E29BF
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:44:00 +0200 (CEST)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31A72600867
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:43:58 +0200 (CEST)
Date: Thu, 30 Jul 2026 17:43:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785404638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bqT2KvyEp5YYHjD47gFW14mRqfoW2Zr8e7GvvDCiVOE=;
 b=b+rzmFh6VtWNQ584zg/0MuUzmh2BCfPuhbvqLSqk9V6t4u8rw864TL0l5vbVPxuuDZPD22
 X5uzroYeijTJm6SjX9TAb+g8Fcsbru6p8WPFZn7lBVXi7dc42Ku8IdL2AUptfwgcFKzzXj
 Phem86Mw/fufO4mp7hRqLCuCnlePLZg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: linuxtestproject.agent@gmail.com
Message-ID: <amscznCD4ZBNSU_T@linux.dev>
Mail-Followup-To: linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
 liwang@hygon.cn
References: <20260730074120.180101-1-li.wang@linux.dev>
 <20260730082901.3960-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730082901.3960-1-linuxtestproject.agent@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
Cc: ltp@lists.linux.it, liwang@hygon.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 30, 2026 at 08:29:01AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Li,
> 
> On Thu, 30 Jul 2026, Li Wang wrote:
> > madvise09: restore cgroup v1 memory limits with numeric values
> 
> --- [PATCH 1/2] ---
> 
> > +	if (TST_CG_VER_IS_V1(tst_cg, "memory")) {
> > +		SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", ori_mem_limit);
> > +
> > +		if (swap_accounting_enabled)
> > +			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", ori_swap_limit);
> > +	} else {
> 
> Doesn't this hit EINVAL again on v1, just with a different value?
> 
> On the retry path the cgroup still carries the limits written by the
> previous child at the end of child():
> 
> 	memory.max      = mem_limit  = 16 * PAGES * page_size  (8MB @4K)
> 	memory.swap.max = swap_limit = 2 * mem_limit           (16MB @4K)
> 
> On v1 these alias to memory.limit_in_bytes and
> memory.memsw.limit_in_bytes, and the kernel enforces
> memory.max <= memsw.max in mem_cgroup_resize_max()
> (mm/memcontrol-v1.c):
> 
> 	limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
> 				   max <= memcg->memsw.max;
> 	if (!limits_invariant) {
> 		mutex_unlock(&memcg_max_mutex);
> 		ret = -EINVAL;
> 		break;
> 	}
> 
> ori_mem_limit is the v1 default (PAGE_COUNTER_MAX, ~8EB), which is well
> above the 16MB memsw limit still installed. So writing memory.max first
> should fail with EINVAL and SAFE_CG_PRINTF aborts with TBROK.
> 
> When raising the limits the writes have to go memsw first:
> 
> 	if (swap_accounting_enabled)
> 		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lld", ori_swap_limit);
> 
> 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lld", ori_mem_limit);
> 
> The lowering sequence further down stays as it is, since lowering
> memory.max first keeps the invariant.

Yes, good point. On cgroup v1 the retry path is raising both limits back
to their original values, and raising memory.limit_in_bytes before
memory.memsw.limit_in_bytes can violate the v1 invariant
memory.limit_in_bytes <= memory.memsw.limit_in_bytes while the old memsw
limit is still installed.

I will fix this in V2.

> 
> >  	/*
> >  	 * Reset cgroup memory limits to default ("max") in case this is a retry run.
> 
> The comment above the hunk still says the limits are reset to "max",
> which is now only true for the v2 branch. Could it be reworded to cover
> both cases?

Sure, this can be rewriten.

> 
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
> 
> TST_CG_VER_IS_V1() expands to a tst_cg_ver() call and is evaluated three
> times across setup() and child(). Would storing it once in a static
> (e.g. "static int cg_v1;") be simpler, given child() needs it anyway?

Hmm, this is a little bit nitpicking.

> Minor: LTP usually spells such saved values "orig_*", so orig_mem_limit
> and orig_swap_limit would match the rest of the tree.

Sure, orig_* looks better.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
