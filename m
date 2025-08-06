Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AC4C87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 08:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FF5F3C1AA7
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 10:19:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 574C63C133E
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 10:19:39 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5051E200AC1
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 10:19:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1754468376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVdy8Z7vxFzMcZIpJyuv2XRd6gG/b+uZsIufJIRyPeI=;
 b=QWJHUWIgKOkWwT5562fAfhJ9uJLrMtrpaQzMifCtJqLDgfMH1u0XdXvTrh/CIOCabQaqBQ
 cgVIVQfi+KbJuFCT91ih48QWuiIbiuqxQQmVYbL3MRkooSCRWlld82qxYukk0KBouUC5+s
 sPwO3i1DSbY3/HMlf8cjedZHjTcl/yRhtB5QQuBMhj230CXdpEdwdGa8YSrmsyzG/UgyQA
 1demA3314+qD7tnrtLuzDi6J/CxsthtD+prE43pUGT3U9AhOUyD3mk5ufQ0H9YTqW4LlPs
 mdwNnmjuYXMtUK623HiF/mOvnsFKhx2u2NXrL3mRP/ARU+mAj9214FAQMtPV0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1754468376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVdy8Z7vxFzMcZIpJyuv2XRd6gG/b+uZsIufJIRyPeI=;
 b=pgHLrFBriDWLVZhnxPV/QBPg3icmRlb1PYdcBqzrGiZnZXZRxauEBmaFZGqJidZmTuwGyC
 YjtRtX5quqfdPWBA==
To: Oliver Sang <oliver.sang@intel.com>
In-Reply-To: <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020> <87wm7ro3r7.ffs@tglx>
 <aIrJipeLsGUM92+R@xsang-OptiPlex-9020> <87cy9gilo8.ffs@tglx>
 <874iusihka.ffs@tglx> <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020>
Date: Wed, 06 Aug 2025 10:19:36 +0200
Message-ID: <87qzxoeuav.ffs@tglx>
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

Oliver!

On Wed, Aug 06 2025 at 16:01, Oliver Sang wrote:
> On Thu, Jul 31, 2025 at 04:03:01PM +0200, Thomas Gleixner wrote:
>> On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
>> > Either you make the timeout longer or try the following on the kernel
>> > command line instead of 'ftrace_dump_on_cpu':
>> 
>>   instead of 'ftrace_dump_ooops'
>
> sorry for late, I just took several-day off.

I hope you had a good time!

> attached dmesg FYI.

Thanks for doing this. Now the buffer is too short and as nothing stops
the tracer the interesting stuff goes out of sight.

Can you please apply the patch below and try again?

Thanks,

        tglx
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5850,6 +5850,8 @@ void preempt_count_sub(int val)
 	/*
 	 * Underflow?
 	 */
+	if (val > preempt_count())
+		tracing_off();
 	if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
 		return;
 	/*

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
