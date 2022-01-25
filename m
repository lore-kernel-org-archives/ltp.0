Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F938C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 08:33:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04B993C925E
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 09:33:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 138543C90AA
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 09:33:10 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 543DE1400427
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 09:33:09 +0100 (CET)
Received: by mail-yb1-xb2e.google.com with SMTP id c6so59384028ybk.3
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=dm9enjdusY3A58QDHQgAeNFRYRFu+m9zKXkfR9/EpRs=;
 b=nSMoXtfNYLuW0tj4xK3VmeQumN3LjX90Qwub9MFmotXJGHExifDnvmw9xwBm0lEp+B
 V9/TdhX0FwRwmwS37FdwFFJRwt/xQUDyEYjOGh5gPkAP7bhRPXeziwNdmcib9y6NUMO2
 dnbS4M5tJqGDKRv7npjZuBYs8wqACrUdDkeAP+jJcAwvDUR4c5yHP+6LGPns5TbaSd5p
 iJFS93cNGhb2n8y6kllHV49hZ7O5e6YdcHBXDRVLJAnUEkOxUkBxfIbOGQ1EhSle+J8R
 eJ/OnfJmCeSke7pOy2CkoUMDeut5AB41hxDLsK/eI10MKf1LgRAeqCU6rVMYkunXH7Pw
 YX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=dm9enjdusY3A58QDHQgAeNFRYRFu+m9zKXkfR9/EpRs=;
 b=eLtksUyMo4kcRQmd7bdfGxzzVnQqrmXTEuJ+cQZKYat7e6kfc8WfRB09ppqQBJobs4
 WfsXkr0y4R7SLXLQsGwBTzu/0iS5hC0s/YDxZoR21DZgQBJ4c0lp9v8OnPspj1r3WkDU
 jP2/s8kH22tMJ/DLFQKQQfMd7yuLX77h1nSvjJWSywSnxXLSihuLVpG0rulyb49NjPAW
 tME7II03PccrQEXWf678u1vXcPPNORwx9HPk9JqTtgkh1YNprLI3RAr5mG4Nizhoq6n3
 FVKdwwPScv6+2K16Jm6IBgITSYgdpzlHyjeyBZ+foLA0JW0UDXPg5Pm3Z1dU40PN1250
 2ySQ==
X-Gm-Message-State: AOAM5304F+FnsE/6aEtWNOwY7DYF7wkfmlMVpKOFIEMSEjtKyrAzpovD
 W8RbG3+fslAszldJmSYKYAMs2GgeUbbRvRFqseE/6A==
X-Google-Smtp-Source: ABdhPJwvQMc9HJl8nsOUSH2i5xJkTl3raQES9oPi0hrO8s7OtbRkU6QxYjtQdRgzy4F3BMTEEojUzYMCtI8md0GoLUY=
X-Received: by 2002:a25:c04c:: with SMTP id c73mr27934623ybf.553.1643099587866; 
 Tue, 25 Jan 2022 00:33:07 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Jan 2022 14:02:56 +0530
Message-ID: <CA+G9fYvrk4V=DiS8kgyxKkRAo4s-FPKeh8pf4YrRJPhcgioPmQ@mail.gmail.com>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, 
 lkft-triage@lists.linaro.org, regressions@lists.linux.dev, 
 LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [next] WARNING: CPU: 0 PID: 0 at
 kernel/trace/trace_events.c:417 trace_event_raw_init
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
 Daniel Thompson <daniel.thompson@linaro.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Qian Cai <quic_qiancai@quicinc.com>,
 Marco Elver <elver@google.com>, Ingo Molnar <mingo@redhat.com>,
 Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

[Please ignore this report if it is already reported]

Following kernel WARNING: reported while boot linux next 20220125 tag
on qemu_arm64.
While testing LTP ftrace the following kernel WARNING: noticed.

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at
kernel/trace/trace_events.c:417 trace_event_raw_init+0x490/0x4ec
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.17.0-rc1-next-20220125 #1
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : trace_event_raw_init+0x490/0x4ec
[    0.000000] lr : trace_event_raw_init+0x250/0x4ec
[    0.000000] sp : ffffc91900963d30
[    0.000000] x29: ffffc91900963d30 x28: 0000000000000005 x27: 0000000000000000
[    0.000000] x26: 0000000000000003 x25: ffffc918ff56c8e8 x24: ffffc918ffc57bf8
[    0.000000] x23: 0000000000000001 x22: ffffc91900d4bf18 x21: 0000000000000000
[    0.000000] x20: ffffc91900d44fa8 x19: 0000000000000251 x18: 00000000ffffffff
[    0.000000] x17: 000000000000003f x16: 0000000000000009 x15: ffffffffffffffff
[    0.000000] x14: 0000000000000000 x13: ffffffffffffffff x12: 0000000000000028
[    0.000000] x11: 0101010101010101 x10: 0000000000000403 x9 : ffffc918fe3d2600
[    0.000000] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefefefefeff28
[    0.000000] x5 : 000000000000003e x4 : 0000000000000008 x3 : 0000000000000000
[    0.000000] x2 : 000000000000023f x1 : 0000000000000000 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  trace_event_raw_init+0x490/0x4ec
[    0.000000]  event_init+0x38/0xb0
[    0.000000]  trace_event_init+0x9c/0x2ac
[    0.000000]  trace_init+0x10/0x1c
[    0.000000]  start_kernel+0x474/0x710
[    0.000000]  __primary_switched+0xc0/0xc8
[    0.000000] ---[ end trace 0000000000000000 ]---

and
Running tests.......
[    6.791530] ------------[ ftrace bug ]------------
[    6.791941] ftrace faulted on modifying
[    6.791943] [<ffffc918fff403fc>] set_reset_devices+0x8/0x24
[    6.792681] Setting ftrace call site to call ftrace function
[    6.793111] ftrace record flags: 80000001
[    6.793384]  (1)
[    6.793384]  expected tramp: ffffc918fe22bd20
[    6.793868] ------------[ cut here ]------------
[    6.794212] WARNING: CPU: 1 PID: 468 at kernel/trace/ftrace.c:2068
ftrace_bug+0x280/0x2b0
[    6.794879] Modules linked in: rfkill crct10dif_ce fuse
[    6.795300] CPU: 1 PID: 468 Comm: ftrace_regressi Tainted: G
W         5.17.0-rc1-next-20220125 #1
[    6.796074] Hardware name: linux,dummy-virt (DT)
[    6.796453] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.797016] pc : ftrace_bug+0x280/0x2b0
[    6.797331] lr : ftrace_bug+0x280/0x2b0
[    6.797649] sp : ffff8000088a3af0
[    6.797921] x29: ffff8000088a3af0 x28: ffff0000c1b2a000 x27: 0000000000000000
[    6.798507] x26: 0000000000000000 x25: ffff8000088a3d40 x24: ffffc91900e24000
[    6.799090] x23: 00000000fffffff2 x22: ffffc918ffc46248 x21: ffffc9190096ecc8
[    6.799670] x20: ffff0000c0080030 x19: ffffc9190096e000 x18: ffffffffffffffff
[    6.800242] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000888a3817
[    6.800815] x14: 0000000000000000 x13: 3032646232326566 x12: 3831396366666666
[    6.801398] x11: 203a706d61727420 x10: ffffc91900991ba0 x9 : ffffc918fe31bbc4
[    6.801979] x8 : 00000000ffffefff x7 : ffffc919009e9ba0 x6 : 0000000000000001
[    6.802557] x5 : ffffc9190096f000 x4 : ffffc9190096f280 x3 : 0000000000000000
[    6.803138] x2 : 0000000000000000 x1 : ffff0000c1b2a000 x0 : 0000000000000022
[    6.803700] Call trace:
[    6.803899]  ftrace_bug+0x280/0x2b0
[    6.804185]  ftrace_replace_code+0x94/0xa0
[    6.804523]  ftrace_modify_all_code+0xe0/0x14c
[    6.804886]  arch_ftrace_update_code+0x14/0x20
[    6.805255]  ftrace_run_update_code+0x24/0x7c
[    6.805611]  ftrace_startup+0xf4/0x1b0
[    6.805919]  register_ftrace_function+0x38/0x90
[    6.806290]  stack_trace_sysctl+0xa0/0x190
[    6.806630]  proc_sys_call_handler+0x18c/0x250
[    6.806993]  proc_sys_write+0x20/0x30
[    6.807295]  new_sync_write+0xf0/0x18c
[    6.807607]  vfs_write+0x244/0x2b0
[    6.807889]  ksys_write+0x74/0x100
[    6.808168]  __arm64_sys_write+0x28/0x3c
[    6.808491]  invoke_syscall+0x50/0x120
[    6.808800]  el0_svc_common.constprop.0+0x104/0x124
[    6.809427]  do_el0_svc+0x34/0x9c
[    6.809703]  el0_svc+0x2c/0x90
[    6.809961]  el0t_64_sync_handler+0xa4/0x130
[    6.810318]  el0t_64_sync+0x1a0/0x1a4
[    6.810617] ---[ end trace 0000000000000000 ]---

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ref:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220125/testrun/7535055/suite/linux-log-parser/test/check-kernel-warning-4390834/log
  - https://lkft.validation.linaro.org/scheduler/job/4390834#L282

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git describe: next-20220125
  kernel-config: https://builds.tuxbuild.com/24B14LVWVfE8GOgox8KftnlXxPf/config


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
