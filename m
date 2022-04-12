Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5570AC433F5
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 21:04:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740973CA5A1
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 23:04:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DFE03C02B1
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 23:04:03 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47C62600843
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 23:04:01 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 34B80CE20E5;
 Tue, 12 Apr 2022 21:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402FDC385A5;
 Tue, 12 Apr 2022 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1649797437;
 bh=RFYjpKU37uB6UyPKVFSgk9DDLgvf6NL/iC5f833Q9jo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=0mZDA2fwf8SsuU+dgEC41/ZqbU0uopfv3UmlUacSZJ/QIO04FrKFGpaBHTON8ogwT
 yAr+JsMnA584S0g8DLG4X6XNsivwjKnAZBNsPlA8izON4EhoMARt1TemjBNjGEQtE1
 Jqy7p+AyNzvxgboTQw1HbRDtUm2FmJlMGuQ070lg=
Date: Tue, 12 Apr 2022 14:03:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-Id: <20220412140356.c0b382fe097cbf4fd040afcc@linux-foundation.org>
In-Reply-To: <CA+G9fYusMPEsFXhDd4BEMa0jy-qZxgRTCpxZ8E4gjdrpHdQGOQ@mail.gmail.com>
References: <CA+G9fYusMPEsFXhDd4BEMa0jy-qZxgRTCpxZ8E4gjdrpHdQGOQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [next] next-20220412: BUG: Bad page map in process
 oom_reaper pte
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Mike Rapoport <rppt@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 12 Apr 2022 17:56:42 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Linux next-20220412 i386 LTP mm test case caused following kernel crash
> however, test runs to complete successfully.
> 
> ...
>
> [  951.985382] __swap_info_get: Bad swap file entry 6c0373b6
> [  951.986163] BUG: Bad page map in process oom_reaper  pte:06e76c3e
> pmd:0583f067
> [  951.987098] addr:77da7000 vm_flags:00100073 anon_vma:c4e22c40
> mapping:00000000 index:77da7
> [  951.988163] file:(null) fault:0x0 mmap:0x0 readpage:0x0
> [  951.988850] CPU: 2 PID: 36 Comm: oom_reaper Tainted: G        W
>     5.18.0-rc2-next-20220412 #1
> [  951.990034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  951.991101] Call Trace:
> [  951.991457]  dump_stack_lvl+0x44/0x57
> [  951.991942]  dump_stack+0xd/0x10
> [  951.992371]  print_bad_pte.cold+0x82/0xd9
> [  951.992901]  ? free_swap_and_cache+0x2e/0xe0
> [  951.993475]  unmap_page_range+0x6b5/0x790
> [  951.994005]  __oom_reap_task_mm+0xc0/0x140
> [  951.994539]  ? _raw_spin_lock_irqsave+0x28/0x70
> [  951.995128]  ? trace_preempt_on+0x8/0xe0
> [  951.995645]  oom_reaper+0x28c/0x3d0
> [  951.996103]  ? __kthread_parkme+0x37/0x80
> [  951.996626]  ? trace_preempt_on+0x29/0xe0
> [  951.997205]  ? __kthread_parkme+0x37/0x80
> [  951.997723]  ? nsec_high+0xa0/0xa0
> [  951.998174]  kthread+0xe0/0x110
> [  951.998588]  ? __oom_reap_task_mm+0x140/0x140
> [  951.999154]  ? kthread_complete_and_exit+0x20/0x20
> [  951.999771]  ret_from_fork+0x1c/0x28
> [  952.000258] Disabling lock debugging due to kernel taint
> [  952.000951] __swap_info_get: Bad swap file entry 6c0373b7
> [  952.001779] BUG: Bad page map in process oom_reaper  pte:06e76e3e
> pmd:0583f067
> [  952.002827] addr:77da8000 vm_flags:00100073 anon_vma:c4e22c40
> mapping:00000000 index:77da8
> [  952.004010] file:(null) fault:0x0 mmap:0x0 readpage:0x0
> [  952.004764] CPU: 2 PID: 36 Comm: oom_reaper Tainted: G    B   W
>     5.18.0-rc2-next-20220412 #1
> [  952.006060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  952.007248] Call Trace:
> [  952.007611]  dump_stack_lvl+0x44/0x57
> [  952.008142]  dump_stack+0xd/0x10
> [  952.008614]  print_bad_pte.cold+0x82/0xd9
> [  952.009225]  ? free_swap_and_cache+0x2e/0xe0
> [  952.009848]  unmap_page_range+0x6b5/0x790
> [  952.010432]  __oom_reap_task_mm+0xc0/0x140
> [  952.011219]  ? _raw_spin_lock_irqsave+0x28/0x70
> [  952.011863]  ? trace_preempt_on+0x8/0xe0
> [  952.012470]  oom_reaper+0x28c/0x3d0
> [  952.013048]  ? __kthread_parkme+0x37/0x80
> [  952.013628]  ? trace_preempt_on+0x29/0xe0
> [  952.014202]  ? __kthread_parkme+0x37/0x80
> [  952.014774]  ? nsec_high+0xa0/0xa0
> [  952.015265]  kthread+0xe0/0x110
> [  952.015716]  ? __oom_reap_task_mm+0x140/0x140
> [  952.016336]  ? kthread_complete_and_exit+0x20/0x20
> [  952.017035]  ret_from_fork+0x1c/0x28
> [  952.017547] __swap_info_get: Bad swap file entry 6c0373b8
> [  952.018368] BUG: Bad page map in process oom_reaper  pte:06e7703e
> pmd:0583f067
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I wonder if this could be 859a85ddf90e714092de again.  But the timing
seems wrong.

It seems repeatable.  Is it possible to run a bisection search please?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
