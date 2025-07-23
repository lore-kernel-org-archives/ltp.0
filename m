Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13DDC83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 17:23:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AC593CCD39
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 19:23:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76CEC3CAF64
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 19:22:48 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DFBF2100041E
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 19:22:47 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1753291364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HWMo6N7DknydD/H3u9J3QQxi5mYUqnkI0qT9deB89w8=;
 b=uTwfdT4gS3CIP1z3mkGpl4P8Gf92GQXuhhmIYlvD1xVncO7izDn+jAV4Apa0RGHBKEJKR4
 vhowu68fJPYIp78+Vl8EvbWe95N/5nHlgLx62Z20l5+2NyF+v0SLrMY5MWzNiKsvI7NZyI
 93GZKTT6hHfJWxZE7VeUDnSP6Dk6hCxJhLSzMWi3yqnL74T7qBAuZj8v6BLTeCKLEUIrAw
 YUvxUS+9IkzVfPI+qFCWKMSLDi22FmmBoVzvvjdF68hCXdxT0xWDqx3RzOfvXENFQknH0S
 oHkK0dkui1r/6esISb5CKAKDKdfR52DLcAnvjsfkBTL6j+gmCX5Q9bZS1+ebCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1753291364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HWMo6N7DknydD/H3u9J3QQxi5mYUqnkI0qT9deB89w8=;
 b=0zsDEKsnDDRc17JusZ6oZ+IxZboqKL/mREeqzblTxb3++XoS5iND//bsgxkB0oMKgADZDg
 YbYlqM7vHU9zaLBg==
To: kernel test robot <oliver.sang@intel.com>, Peter Zijlstra
 <peterz@infradead.org>
In-Reply-To: <202507231021.dcf24373-lkp@intel.com>
References: <202507231021.dcf24373-lkp@intel.com>
Date: Wed, 23 Jul 2025 19:22:43 +0200
Message-ID: <87a54usty4.ffs@tglx>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [tip:locking/futex] [futex] 56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
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
Cc: lkp@intel.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 23 2025 at 16:46, kernel test robot wrote:
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c" on:
>
> commit: 56180dd20c19e5b0fa34822997a9ac66b517e7b3 ("futex: Use RCU-based per-CPU reference counting instead of rcuref_t")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/futex
>
> the issue (1)(2) happen randomly upon 56180dd20c.

Hmm.

> a255b78d14324f8a 56180dd20c19e5b0fa34822997a
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :50          48%          24:50    dmesg.BUG:scheduling_while_atomic    <---- (2)
>            :50          48%          24:50    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c   <---- (1)
>          50:50           0%          50:50    dmesg.Mem-Info
>          50:50           0%          50:50    dmesg.invoked_oom-killer:gfp_mask=0x
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507231021.dcf24373-lkp@intel.com
>
>
> [  286.673775][   C97] BUG: sleeping function called from invalid context at kernel/nsproxy.c:233   <---- (1)
> [  286.673784][   C97] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6748, name: oom03
> [  286.673787][   C97] preempt_count: 7ffffffe, expected: 0

Ooops. That's a corrupted preempt counter, which has underflown twice.

Can you please enable CONFIG_DEBUG_PREEMPT, so we can see where this
happens?

Thanks,

        tglx

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
