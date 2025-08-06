Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFF3C87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 10:39:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6702A3C8013
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 12:39:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7251D3C71A4
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 12:39:13 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A76A16008AF
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 12:39:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1754476749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhKBjBL0r+ZMyH7ZvDnPT8IRUyvC+7V+Yvg1xfVi4zk=;
 b=1y8ifgKsKOhwxKOFaOdd4FhBFUCxw9urKa04WdCdOnVhl2hNkpbnUv96e7kQf4W8Pduid0
 +GT0IBKfm/dWo0GW+3netUezCF1T4zQNjw2vAN8BggMyEj+xu7qmpy5EaVHcvuHI/lsUxz
 KaOS8Tb4dt4do3t/xeyOJQUjFWMc+D8LYw8G6erCR4Yd4XraR/3bAqClxrGba8PTJRr5xJ
 Nn/O5De/zMGIvXLQKZJ1sbAVQIE01rjHAumEkWwqcBN/ArIemkidhb1REzvuvZ9bm/TTsh
 0XApwyQIR9Ht5iJv2FjKDwuxqf1kWJrEgOIeDnc111kJYW8dogBg/iHWBku4JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1754476749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FhKBjBL0r+ZMyH7ZvDnPT8IRUyvC+7V+Yvg1xfVi4zk=;
 b=toS1IjGNfZoqRXGyiwSsAeCZYwQrk6b//DsCVNMJeLwyycx0mPt6dil7hFiSEtMNY+6HU4
 ONdyXmizynHcl7BA==
To: Oliver Sang <oliver.sang@intel.com>
In-Reply-To: <aJMT5DsFlOL6V+Nv@xsang-OptiPlex-9020>
References: <87a54usty4.ffs@tglx> <aINKAQt3qcj2s38N@xsang-OptiPlex-9020>
 <87seikp94v.ffs@tglx> <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020>
 <87wm7ro3r7.ffs@tglx> <aIrJipeLsGUM92+R@xsang-OptiPlex-9020>
 <87cy9gilo8.ffs@tglx> <874iusihka.ffs@tglx>
 <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020> <87qzxoeuav.ffs@tglx>
 <aJMT5DsFlOL6V+Nv@xsang-OptiPlex-9020>
Date: Wed, 06 Aug 2025 12:39:09 +0200
Message-ID: <87bjosenua.ffs@tglx>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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

On Wed, Aug 06 2025 at 16:35, Oliver Sang wrote:

> On Wed, Aug 06, 2025 at 10:19:36AM +0200, Thomas Gleixner wrote:
>> Oliver!
>> 
>> On Wed, Aug 06 2025 at 16:01, Oliver Sang wrote:
>> > On Thu, Jul 31, 2025 at 04:03:01PM +0200, Thomas Gleixner wrote:
>> >> On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
>> >> > Either you make the timeout longer or try the following on the kernel
>> >> > command line instead of 'ftrace_dump_on_cpu':
>> >> 
>> >>   instead of 'ftrace_dump_ooops'
>> >
>> > sorry for late, I just took several-day off.
>> 
>> I hope you had a good time!
>> 
>> > attached dmesg FYI.
>> 
>> Thanks for doing this. Now the buffer is too short and as nothing stops
>> the tracer the interesting stuff goes out of sight.
>> 
>> Can you please apply the patch below and try again?
>
> got it!
>
> just want to confirm, still use below params or need some modification?
>
> trace_event=preemptirq:preempt_disable,preemptirq:preempt_enable ftrace_dump_on_oops=orig_cpu trace_buf_size=100K panic_on_warn=1

Those should be good. Let's see.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
