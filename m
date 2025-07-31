Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C9EC87FCA
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 14:03:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65B893CBD9F
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 16:03:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD7A43CBD9F
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:03:05 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 05A84200AE0
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:03:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1753970582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y/jUB7+mqJ6vOu9bYPCfa2+TuZR2QobbeGi99NqhPw0=;
 b=XR/CQQqIxkjhty4gyYn0+QF9INSWICBtL2FypdYnrwc4hg2mR4T9S+zZ2RpJGGtJt7Ft+B
 sKLh8ShWlR3Jvf24Cps5Pq46OPAA/VHZlQfU7ggBUIrpGBRzVtl1Njq9NQ8rSgDTBt+OR7
 n4LQJCSzIfAEK1CiQ6mS8waHwJcuGsrOVw3YoeAGu51bDB8Gwv19kcFdAYliNmHpFUmPS9
 NYoeReZdwFq1Xicy1srlPhNUl7q9KIj07FjoRlvb+folf54IJ2ABloMhov//8jQ//kQ5yt
 mTCzCRgepYusHQRG4xj9FgVK2LX0hRHEPO3BkW/pmLwUfYoMzM8IAdVQCzeS2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1753970582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y/jUB7+mqJ6vOu9bYPCfa2+TuZR2QobbeGi99NqhPw0=;
 b=jWUiEbiOLeOjbqF1VT1CubB8dEPFjkaZ1Lx4rkLHzDxAoyhUrhkiOwsAdjM3hLCBAjM/8u
 k1YesinPBnEyc7CQ==
To: Oliver Sang <oliver.sang@intel.com>
In-Reply-To: <87cy9gilo8.ffs@tglx>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020> <87wm7ro3r7.ffs@tglx>
 <aIrJipeLsGUM92+R@xsang-OptiPlex-9020> <87cy9gilo8.ffs@tglx>
Date: Thu, 31 Jul 2025 16:03:01 +0200
Message-ID: <874iusihka.ffs@tglx>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
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
Cc: lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, oliver.sang@intel.com,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
> On Thu, Jul 31 2025 at 09:40, Oliver Sang wrote:
>> On Tue, Jul 29, 2025 at 09:27:56AM +0200, Thomas Gleixner wrote:
>>> > but bot seems not be able to capture other new dmesg stats.
>>> 
>>> Ah. The tracer does not dump on warnings by default. You need
>>> 'panic_on_warn' on the command line as well. Forgot about that earlier.
>>
>> attached one dmesg FYI.
>
> Hmm, that trace dump was cut off before it completed by a reset
> (probably your test timeout).
>
> Either you make the timeout longer or try the following on the kernel
> command line instead of 'ftrace_dump_on_cpu':

  instead of 'ftrace_dump_ooops'

obviously

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
