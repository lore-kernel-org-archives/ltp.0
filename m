Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED30CD4F3D
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779378983; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=S2FEHzFnGetHNSbY4rVNqVAuUKB2xHbskSVvWyvEhuc=;
 b=bQOtJyOQ83+MT2Mhe5cVEA03xHQ2P5PfMd7V0nTq/8AzOw9azVHOEsxi+5WXuxLcX7F0Y
 nW20gOJzFnAeh8cClD2Jj3cbPZpwKwEQ41m90mQcwP37/TpAmmbIVUFfwtczWfG3J6YOaYh
 QE6BWDQhBpfRk3qfjUpiPg9Ozpz/Mzo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25E633C5EE8
	for <ltp@archiver.kernel.org>; Thu, 21 May 2026 17:56:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEB343C5EE8
 for <ltp@lists.linux.it>; Thu, 21 May 2026 17:55:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2FCF200ACF
 for <ltp@lists.linux.it>; Thu, 21 May 2026 17:55:56 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C04CA44373;
 Thu, 21 May 2026 15:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32781F000E9;
 Thu, 21 May 2026 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779378953;
 bh=MhFLi3KY2zX8f39vBXoxDAx8zoa4537z/UcgyuKa1fw=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
 b=dz0xa4cnCmuoQ13H3QF3wd37NJfWb3FVnPKz3GwyjzX3DL4OOTcgdO2vk+ifZWWRM
 BeeCjXgZuysO7inN0BjitAH8cVh8YcuyrFNpfDsP6P+2Cykrcz2vHTTynuk2SMWKfq
 5JQGrFFK6LI8qtAyt6dlTI+Sj06dLgfBAwrh1LFMnagX5mznd7jOgi8lqFEB2PARpw
 cDX8xTFVoLYJYUS3KgKnxYo3gNyL3LcVsm3YZdUn2AlTvJzs7f+PQ1Jx1cjO65scoU
 HLTX8CdMfEjOccB6/AZXERB7c0YSgBGkbRjJgA6MbwY6/GKlPgN0OAs6STEs/35PlZ
 AnuvKT3aUFqTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 611ABCE0874; Thu, 21 May 2026 08:55:53 -0700 (PDT)
Date: Thu, 21 May 2026 08:55:53 -0700
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <e43a6e6a-da4b-4b69-add1-2bcb33cbb0d7@paulmck-laptop>
References: <202605211529.6ba1b4ff-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202605211529.6ba1b4ff-lkp@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [paulmckrcu:dev.2026.05.07a] [rcutorture] c2e6a63ac1:
 RIP:rcu_torture_irq[rcutorture]
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
From: "Paul E. McKenney via ltp" <ltp@lists.linux.it>
Reply-To: paulmck@kernel.org
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, ltp@lists.linux.it,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, May 21, 2026 at 03:54:05PM +0800, kernel test robot wrote:
> 
> hi, Paul,
> 
> below report is just FYI. if the issue is soloved on newer branched, please just
> ignore. thanks
> 
> 
> Hello,
> 
> 
> kernel test robot noticed "RIP:rcu_torture_irq[rcutorture]" on:
> 
> commit: c2e6a63ac168107454d5fe595c1213e5760d642f ("rcutorture: Test RCU readers from hardware interrupt handlers")
> https://github.com/paulmckrcu/linux dev.2026.05.07a
> 
> in testcase: ltp
> version: 
> with following parameters:
> 
> 	test: kernel_misc
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202605211529.6ba1b4ff-lkp@intel.com

This should be fixed in branch dev.2026.05.19a.  The problem was that
I forgot that smp_call_function_single() handlers can be invoked from
the idle loop instead of from an actual hardware interrupt handler.

The devil truly is in the details!  ;-)

							Thanx, Paul

> kern  :warn  : [  434.509085] [   T5907] ------------[ cut here ]------------
> kern  :warn  : [  434.509089] [   T5907] WARNING: kernel/rcu/rcutorture.c:2653 at rcu_torture_irq+0x119/0x170 [rcutorture], CPU#2: rcu_torture_rea/5907
> kern  :warn  : [  434.509137] [   T5907] Modules linked in: rcutorture(+) torture netconsole binfmt_misc snd_hda_codec_intelhdmi snd_hda_codec_hdmi btrfs libblake2b zstd_compress raid6_pq intel_rapl_msr intel_rapl_common xor snd_hda_codec_alc882 x86_pkg_temp_thermal snd_hda_codec_realtek_lib i915 snd_hda_codec_generic intel_powerclamp sd_mod coretemp snd_hda_intel intel_gtt drm_buddy sg snd_hda_codec ttm kvm_intel snd_soc_rt5640 drm_display_helper snd_soc_rl6231 snd_hda_core regmap_i2c kvm snd_intel_dspcfg cec snd_soc_core snd_intel_sdw_acpi drm_client_lib snd_hwdep snd_compress irqbypass drm_kms_helper rapl mxm_wmi ahci snd_pcm libahci alx video intel_cstate intel_uncore pcspkr mei_me i2c_i801 libata mdio snd_timer mei i2c_smbus lpc_ich snd wmi soundcore acpi_pad joydev drm fuse nfnetlink [last unloaded: ltp_uaccess(OE)]
> kern  :warn  : [  434.509249] [   T5907] CPU: 2 UID: 0 PID: 5907 Comm: rcu_torture_rea Tainted: G S      W  OE       7.1.0-rc1+ #1 PREEMPT(lazy)
> kern  :warn  : [  434.509265] [   T5907] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> kern  :warn  : [  434.509267] [   T5907] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H/Z97X-UD5H, BIOS F9 04/21/2015
> kern  :warn  : [  434.509270] [   T5907] RIP: 0010:rcu_torture_irq (rcu/rcutorture.c:2654 (discriminator 1)) rcutorture
> kern  :warn  : [  434.509287] [   T5907] Code: 93 20 01 00 00 48 83 c4 08 48 c7 c6 10 bb 19 c1 48 89 c7 5b e9 68 14 f7 c2 48 83 c4 08 5b c3 cc cc cc cc 0f 0b e9 0e ff ff ff <0f> 0b e9 fc fe ff ff e8 5b 00 da c0 e9 5a ff ff ff 48 89 04 24 e8
> All code
> ========
>    0:	93                   	xchg   %eax,%ebx
>    1:	20 01                	and    %al,(%rcx)
>    3:	00 00                	add    %al,(%rax)
>    5:	48 83 c4 08          	add    $0x8,%rsp
>    9:	48 c7 c6 10 bb 19 c1 	mov    $0xffffffffc119bb10,%rsi
>   10:	48 89 c7             	mov    %rax,%rdi
>   13:	5b                   	pop    %rbx
>   14:	e9 68 14 f7 c2       	jmp    0xffffffffc2f71481
>   19:	48 83 c4 08          	add    $0x8,%rsp
>   1d:	5b                   	pop    %rbx
>   1e:	c3                   	ret
>   1f:	cc                   	int3
>   20:	cc                   	int3
>   21:	cc                   	int3
>   22:	cc                   	int3
>   23:	0f 0b                	ud2
>   25:	e9 0e ff ff ff       	jmp    0xffffffffffffff38
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	e9 fc fe ff ff       	jmp    0xffffffffffffff2d
>   31:	e8 5b 00 da c0       	call   0xffffffffc0da0091
>   36:	e9 5a ff ff ff       	jmp    0xffffffffffffff95
>   3b:	48 89 04 24          	mov    %rax,(%rsp)
>   3f:	e8                   	.byte 0xe8
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	e9 fc fe ff ff       	jmp    0xffffffffffffff03
>    7:	e8 5b 00 da c0       	call   0xffffffffc0da0067
>    c:	e9 5a ff ff ff       	jmp    0xffffffffffffff6b
>   11:	48 89 04 24          	mov    %rax,(%rsp)
>   15:	e8                   	.byte 0xe8
> kern  :warn  : [  434.509290] [   T5907] RSP: 0018:ffffc9000261fc10 EFLAGS: 00010046
> kern  :warn  : [  434.509294] [   T5907] RAX: 0000000080000002 RBX: ffff888396343248 RCX: ffffffff81828b23
> kern  :warn  : [  434.509297] [   T5907] RDX: 0000000000000000 RSI: ffff888396343240 RDI: 0000000000000000
> kern  :warn  : [  434.509299] [   T5907] RBP: 0000000000000246 R08: 0000000000000000 R09: fffffbfff0c72894
> kern  :warn  : [  434.509301] [   T5907] R10: ffffffff863944a7 R11: 0000000000000000 R12: ffffffffc11a3f10
> kern  :warn  : [  434.509303] [   T5907] R13: 0000000000000000 R14: ffffffffc11a3f10 R15: 0000000000000000
> kern  :warn  : [  434.509316] [   T5907] FS:  0000000000000000(0000) GS:ffff88840ef63000(0000) knlGS:0000000000000000
> kern  :warn  : [  434.509318] [   T5907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kern  :warn  : [  434.509320] [   T5907] CR2: 000056053f590492 CR3: 000000041c870005 CR4: 00000000001726f0
> kern  :warn  : [  434.509323] [   T5907] Call Trace:
> kern  :warn  : [  434.509325] [   T5907]  <TASK>
> kern  :warn  : [  434.509327] [   T5907]  generic_exec_single (smp.c:136 smp.c:453)
> kern  :warn  : [  434.509332] [   T5907]  ? __pfx_rcu_torture_irq (rcu/rcutorture.c:2607) rcutorture
> kern  :warn  : [  434.509360] [   T5907]  smp_call_function_single (smp.c:699)
> kern  :warn  : [  434.509364] [   T5907]  ? __pfx_smp_call_function_single (smp.c:375 (discriminator 4))
> kern  :warn  : [  434.509367] [   T5907]  ? local_clock_noinstr (sched/clock.c:307)
> kern  :warn  : [  434.509371] [   T5907] rcu_torture_reader (rcu/rcutorture.c:2700) rcutorture
> kern  :warn  : [  434.509398] [   T5907]  ? __pfx_rcu_torture_reader (rcu/rcutorture.c:4041) rcutorture
> kern  :warn  : [  434.509412] [   T5907]  ? _raw_spin_lock_irqsave (linux/instrumented.h:55 linux/atomic/atomic-instrumented.h:1301 asm-generic/qspinlock.h:111 linux/spinlock.h:187 linux/spinlock_api_smp.h:133 locking/spinlock.c:166)
> kern  :warn  : [  434.509417] [   T5907]  ? __pfx_rcu_torture_timer (linux/slab.h:950) rcutorture
> kern  :warn  : [  434.509443] [   T5907]  ? __kthread_parkme (linux/instrumented.h:82 asm-generic/bitops/instrumented-non-atomic.h:141 kthread.c:272)
> kern  :warn  : [  434.509448] [   T5907]  ? __pfx_rcu_torture_reader (rcu/rcutorture.c:4041) rcutorture
> kern  :warn  : [  434.509465] [   T5907]  ? __pfx_rcu_torture_reader (rcu/rcutorture.c:4041) rcutorture
> kern  :warn  : [  434.509490] [   T5907]  kthread (kthread.c:436)
> kern  :warn  : [  434.509493] [   T5907]  ? recalc_sigpending (linux/instrumented.h:97 asm-generic/bitops/instrumented-atomic.h:41 linux/thread_info.h:109 signal.c:181)
> kern  :warn  : [  434.509495] [   T5907]  ? __pfx_kthread (linux/list.h:381 (discriminator 2))
> kern  :warn  : [  434.509498] [   T5907]  ret_from_fork (x86/kernel/process.c:158)
> kern  :warn  : [  434.509502] [   T5907]  ? __pfx_ret_from_fork (x86/include/asm/entry-common.h:54)
> kern  :warn  : [  434.509504] [   T5907]  ? switch_fpu (linux/instrumented.h:82 asm-generic/bitops/instrumented-non-atomic.h:141 linux/thread_info.h:133 linux/sched.h:2067 x86/include/asm/fpu/sched.h:34)
> kern  :warn  : [  434.509508] [   T5907]  ? __switch_to (x86/kernel/process_64.c:403 x86/kernel/process_64.c:663)
> kern  :warn  : [  434.509511] [   T5907]  ? __switch_to_asm (x86/entry/entry_64.S:206)
> kern  :warn  : [  434.509515] [   T5907]  ? __pfx_kthread (linux/list.h:381 (discriminator 2))
> kern  :warn  : [  434.509517] [   T5907]  ret_from_fork_asm (x86/entry/entry_64.S:245)
> kern  :warn  : [  434.509522] [   T5907]  </TASK>
> kern  :warn  : [  434.509523] [   T5907] ---[ end trace 0000000000000000 ]---
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260521/202605211529.6ba1b4ff-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
