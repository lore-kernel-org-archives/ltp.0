Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A97C83F26
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 07:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD1CB3CA395
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 09:28:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A29C03C0565
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 09:27:59 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 032B1600A94
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 09:27:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1753774077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bBYSTZpcRwKvIkblTZvAnTSurmf8yAiPann+WMyjBQ=;
 b=eK4w4i7lYj7DJFTnZu+4u/xtfibAeUVwOCGmq28M6sv/FW7HGnKxpF0hv3K1NhBMU5JGO8
 yd6Bni0OIPp+rssxWbW6f8aEPOKLfQw9xomuwPvK+5fU3fItddhPKJQVMhOEdSMvtSWRfg
 V3VamnBKS9UxD7I2ejvhfuj5jXwmdsX2XnSnyz6j9WairOFbJM3BoAkCB/6WLXrUROM4aK
 QgtjFS8cQI3auT/EBLlOHx7iy45BKHBxxu0IwSEgrurubfawpexT1Sk3Lp20R6qvjs8OaV
 8LmVxZ5Azpl1uBJCELw0h0kjfkSvyNpWWitpc3UTx1/Qvgq/L/zIBAff6LL4BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1753774077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bBYSTZpcRwKvIkblTZvAnTSurmf8yAiPann+WMyjBQ=;
 b=8P2C9jOTMPv3/SiXxbOC2HqnDfEuJZYCBPU5j0I5WryKLddPUv4BpvbMwSrbtQDpDb6WG2
 mUr6nKY0LXmtDzBA==
To: Oliver Sang <oliver.sang@intel.com>
In-Reply-To: <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020>
Date: Tue, 29 Jul 2025 09:27:56 +0200
Message-ID: <87wm7ro3r7.ffs@tglx>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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

On Tue, Jul 29 2025 at 08:22, Oliver Sang wrote:
> On Fri, Jul 25, 2025 at 05:45:04PM +0200, Thomas Gleixner wrote:
>> Can you please enable CONFIG_PREEMPT_TRACER and add
>> 
>> 'trace_event=preemptirq:preempt_disable,preemptirq:preempt_enable ftrace_dump_on_oops'
>> 
>> to the kernel command line. The latter will dump the recorded
>> preempt_enable/disable events and we can pinpoint the function which is
>> responsible for that.
>
> the config with CONFIG_PREEMPT_TRACER enabled is attached as
> config-6.16.0-rc5-00002-g56180dd20c19
>
> by this config, we still see random
> WARNING:at_kernel/sched/core.c:#preempt_count_sub
...
> but bot seems not be able to capture other new dmesg stats.

Ah. The tracer does not dump on warnings by default. You need
'panic_on_warn' on the command line as well. Forgot about that earlier.

Thanks,

        tglx

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
