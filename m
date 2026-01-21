Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48506C44502
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 09:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768988917; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=t7CXmKDOcjAUt33wsvwoaJfFfqioKlKKkkSzAS4j2i4=;
 b=dRXQrPa86gJQHpuPFNuOzGrdWF6YajgJ7cINuBYjnTBnp+2DUaKfucJ57qhmhJYyFCR8L
 acvfegb9m984BTvwIhSrziKhX0re+LUuOu5KNQkyb0bMkyXS8Ce7qlZXo9ScvT9uSBCTXZS
 +AtID+zG1/MhPSkSKXLaHNtdxyWU73g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BFC63CB29C
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 10:48:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A32873CB263
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 10:48:14 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A8B110006D8
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 10:48:11 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so44355805e9.3
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768988891; x=1769593691; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TytgqMt1DeF/w1ppjj/szLaWZQhn6ZBJD6KPiXX4wpI=;
 b=eAD0dG4FUTig67RDz8zohw3rUnlhvP1XWPVjg4gyYsjM4aWcXhRxQ3JRAELm/vVV2I
 gJ/VhAwfETM5RhDvsUilPE6Yf4uxdw/EP16S+mwPAqpfjaNIzl80IeRhi19LM4ya35kp
 1SMwMFiE44ZyS2pYSM2qjdt7n3PzlVf9SAuqmGf7d0KtFchG5sPYio4pjOykUkYFZjNe
 VT/M9cD1RRcqmQrYxeDhi5FkL/boK16ObqrDox0RTBg3Gm2tW2+l61IaF0m3zGiz1yZw
 0P6QVDeEEMGt5f+ZDk/gBOhrWWuADuw0+tLefq7rCplc2s/s1H2GhO3iqXJMjeRWamVF
 YaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768988891; x=1769593691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TytgqMt1DeF/w1ppjj/szLaWZQhn6ZBJD6KPiXX4wpI=;
 b=WP3fPvi63GpgPvMBIHUEWLlqWXlguBob5VQ24bdRbO+Nkalnp1VF6ZisLom2hkX0dx
 dofGCgWrWNRLodHcIAmqOazah9+ZaS7OGKiaw+x84Rpzfm2YkrVGejqhiLCNWdaGFSA2
 nm8Ec8dsFUqsHTItqMMLO31vIVRmz60IfapxP7USmCHLS+sadtaLEHhaC7zx7vyrB7F5
 Tq1H25sd8cQ5QXbAaiVTka0DL5sCaytdKugqzOkYqzPZw3wY+PysB2OxsF3GZcVRVa1Q
 qQ8y+AFhlvrLi3Gv58orGbyefoziMViDYJgfqWXCi4LQVim2SLRgPpye8YT25qt0qnBB
 n7zQ==
X-Gm-Message-State: AOJu0Yza54BRsGljNMVLOY+JcWHswNaMvJYhDYalyZ1o8yMT9SJlmzeJ
 mO+sANPC7wyvYWcYr58QNWMsucMDP0BgjOYLTBCTPT2B5EGvxPNnsgRF1skmYhgXrfg0/lyuPR5
 LyAkgaA==
X-Gm-Gg: AZuq6aI3vvGEGxAPVgpJpov0hIfT+V+BPgX3E5aCze8PNeN8NA89Hhr7fYwKbgeZntM
 TtLmGeRrLGxlKHBAox+VGviTMjiOxLsIj+lypOF4dTPnY0PWy00SqjtHqXl2UH+eMPDyGAIlloo
 Cyyk+TdBhHGaH3HJiG+lqlBYnA3dnMlBFMXzWOmZK8duhrNmUy95vyvqir10kobKV81Ep5+qLab
 4X+G+FmpI6+K3xD87WstUEbvuLAhVZ8g4La55xWl70l9919lzGWWcoG+bYgon7GKYtHWHOK5kjp
 Of0e+t0BcGQ17CVhbywB6qv2NWmLaeSdbpwOSEJPSCK1VlJIXynMp6fmrGDrk+BSRe1KBzjDx+M
 k0L/C1dLojOmK7hBczT0LWWLz/lMReFoLCU8fLX7A5FCgZ4p4ypMQJEgPQNgUfJWMDTRsYeIbz0
 9kRVSH9YWzbXzC4HQtW5bSqrOxTFJXjOAsw3lb75E=
X-Received: by 2002:a05:600c:37cc:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-4801eac97b9mr244201515e9.15.1768988890827; 
 Wed, 21 Jan 2026 01:48:10 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dadbsm35141969f8f.21.2026.01.21.01.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 01:48:10 -0800 (PST)
Date: Wed, 21 Jan 2026 09:48:08 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aXCg2LgSTdz4OG5R@autotest-wegao.qe.prg2.suse.org>
References: <20260121090159.32686-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260121090159.32686-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls: remove the TLS support from i386
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 21, 2026 at 05:01:59PM +0800, Li Wang wrote:
> Using a LTP naked clone() to verify that CLONE_SETTLS is unreliable
> when running 32-bit on x86_64, since TLS requires two steps: writing
> the descriptor and switching the selector. But CLONE_SETTLS on i386
> only overrides the former:
> 
>  kernel_clone()
>     copy_process()
>        copy_thread()
>           set_new_tls()
>              do_set_thread_area()
> 
> In copy_thread(), the child's register frame is copied from the parent
> *childregs = *current_pt_regs(); and on the 32-bit side it also does
> savesegment(gs, p->thread.gs); saving the current %gs into thread_struct.
> 
> Together, this means that unless something explicitly overwrites it later,
> the child's initial %gs selector is inherited from the parent.
> 
>   https://elixir.bootlin.com/linux/v6.18/source/arch/x86/kernel/process.c#L243
> 
> Then, in do_set_thread_area(), the kernel updates the TLS descriptor
> set_tls_desc(p, idx, &info, 1); However, when (p != current), the x86_32 path
> does not update or refresh any segment selector. So it updates the descriptor
> but does not switch the child's %gs selector to the new modified_sel.
> 
>   https://elixir.bootlin.com/linux/v6.18/source/arch/x86/kernel/tls.c#L150
> 
> Therefore, on i386, relying on CLONE_SETTLS alone can leave the child
> executing with the parent's %gs selector, so TLS accesses still resolve
> to the old TLS base.
> 
> ===============
> 
> The behavior above explains why clone10 fails even if we update the TLS
> descriptor base (either hard-coding or via set_thread_area()).
> 
> Example (x86_64 kernel running a 32-bit ELF):
> 
>   # uname -rm
>   6.19.0-rc2.liwang x86_64
> 
>   # readelf -h clone10 |grep Class
>   Class:                             ELF32
> 
>   # ./clone10
>   ...
>   clone10.c:48: TINFO: Child (PID: 5262, TID: 5263): TLS value set to: 101
>   clone10.c:72: TFAIL: Parent (PID: 5262, TID: 5262): TLS value mismatch: got 101, expected 100
> 
> Reported-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/lapi/tls.h | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/include/lapi/tls.h b/include/lapi/tls.h
> index a067872e0..f7e2f483f 100644
> --- a/include/lapi/tls.h
> +++ b/include/lapi/tls.h
> @@ -17,10 +17,6 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  
> -#if defined(__i386__)
> -#include <asm/ldt.h>
> -#endif
> -
>  #include "tst_test.h"
>  
>  #define TLS_SIZE 4096
> @@ -37,7 +33,6 @@ typedef struct {
>  #endif
>  
>  extern void *tls_ptr;
> -extern struct user_desc *tls_desc;
>  
>  static inline void *allocate_tls_area(void)
>  {
> @@ -59,21 +54,6 @@ static inline void init_tls(void)
>  {
>  #if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
>  	tls_ptr = allocate_tls_area();
> -
> -#elif defined(__i386__)
> -	tls_ptr = allocate_tls_area();
> -	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
> -	memset(tls_desc, 0, sizeof(*tls_desc));
> -	tls_desc->entry_number = -1;
> -	tls_desc->base_addr = (unsigned long)tls_ptr;
> -	tls_desc->limit = TLS_SIZE;
> -	tls_desc->seg_32bit = 1;
> -	tls_desc->contents = 0;
> -	tls_desc->read_exec_only = 0;
> -	tls_desc->limit_in_pages = 0;
> -	tls_desc->seg_not_present = 0;
> -	tls_desc->useable = 1;
> -
>  #else
>  	tst_brk(TCONF, "Unsupported architecture for TLS");
>  #endif
> @@ -87,12 +67,6 @@ static inline void free_tls(void)
>  		free(tls_ptr);
>  		tls_ptr = NULL;
>  	}
> -#elif defined(__i386__)
> -	if (tls_desc) {
> -		free((void *)(uintptr_t)tls_desc->base_addr);
> -		free(tls_desc);
> -		tls_desc = NULL;
> -	}
>  #endif
>  }

Thanks for your patch.
Reviewed-by: Wei Gao <wegao@suse.com>
>  
> -- 
> 2.52.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
