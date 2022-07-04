Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15D8CCA479
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 10:22:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728683CA045
	for <ltp@archiver.kernel.org>; Mon,  4 Jul 2022 12:22:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A11C3C1BD5
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 12:21:57 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 68CA560080C
 for <ltp@lists.linux.it>; Mon,  4 Jul 2022 12:21:57 +0200 (CEST)
Received: by mail-io1-xd36.google.com with SMTP id l24so8192727ion.13
 for <ltp@lists.linux.it>; Mon, 04 Jul 2022 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=MHtsF8BuM0s8sZdzZdBF2dNP7G8scNA896vfo1rkN6A=;
 b=MvOVTIbuHVF8RUyQSed7BrWw7zTkUuJMey/HH+HaiIewtWiqBftpb3cM/fuxKVDbbb
 Wt0SLLcc38/gzO7UpT7i5UXwVCvFS1FEJZppvU5OvTbFckajEP2xXBa8lNrcIGYYZ2ph
 BbcS8FPZa2LLimFQkEvvDzxhYnOXQ8o0hEFTU6AsxxmeBrWIf7Lv+3nOw4lIvq7Wamu/
 cXQLlt/ILpvvKaHXnmsJIW6Y+Kz/tlyXM5flsncOGyKpKiM3e3W3YtQXxFXtz+lylhY1
 DErtA7pIXS6HQLJoTecglPvy1givmGtQsCglBNoyteCM0RD63wbdzDExwceqNlIW6/JE
 zx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=MHtsF8BuM0s8sZdzZdBF2dNP7G8scNA896vfo1rkN6A=;
 b=nLkLb6LPHFusJTU5V6/ptIKz83ZWPsri3wmFCvF/FSjTN37n5QAE4Xw1by9LjT2Aie
 EH7DQiXuRyfzmMcNaLQ0IIJb9AmS6mKY+L3fST3gN3keOZ2yyVkwy+KIOC/Cr4JVHbQN
 Ad4RNLYHbWKGtPfKMtXijw8m8U6LYewawTJGw6rCzQm4akvvCFByt6aZvyCVOksR8w4/
 7iSwEmFxpoBO7YW0/fVSkVOTYlAlGgsil71k6wuA+Y8pniW9CnXGORS0gZ9druZ9pjTh
 Ahm2vTmg5U14FYAj0bUxR2gMYRlUKwEoJHDlsUVI/vmd3/hEyLLHoKys2JFoLTtHlXLq
 GJCg==
X-Gm-Message-State: AJIora+dig6jLlkSaggW4oG6BneNgc4pSz4T+eG6q2BmmYzEq1hVTm+H
 MYbaUyyxMIdPq0xOD7u35IAI5gBRqCCN4xvRBKryr4dLbXbcFQ==
X-Google-Smtp-Source: AGRyM1twJSnXUeK56KDrtuQvf3/Xbvfy61F/5TOiJt+rgJDaLehSSBxzBGJSypmwdI8AXp2HmlJQgocLjhAaDUD9pb8=
X-Received: by 2002:a5d:8f96:0:b0:675:573e:6eb5 with SMTP id
 l22-20020a5d8f96000000b00675573e6eb5mr15588227iol.144.1656930115976; Mon, 04
 Jul 2022 03:21:55 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Jul 2022 15:51:44 +0530
Message-ID: <CA+G9fYvB5KmpJmwu+gkM4UiWFTwFVuRFZvAj7Kojw0o-raCezA@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 regressions@lists.linux.dev, lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] 5.19.0-rc5: qemu-i386: traps: PANIC: double fault,
 error_code: 0x0
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
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following kernel crash noticed on qemu-i386 while running LTP cve tests

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 88084a3df1672e131ddc1b4e39eeacfd39864acf
  git_describe: v5.19-rc5
  kernel_version: 5.19.0-rc5
  kernel-config: https://builds.tuxbuild.com/2BSF0Azg4qZOVFsPdPsWOT0KBzM/config
  artifact-location: https://builds.tuxbuild.com/2BSF0Azg4qZOVFsPdPsWOT0KBzM/
  System.map: https://builds.tuxbuild.com/2BSF0Azg4qZOVFsPdPsWOT0KBzM/System.map
  vmlinux.xz: https://builds.tuxbuild.com/2BSF0Azg4qZOVFsPdPsWOT0KBzM/vmlinux.xz

steps to reproduce:
cd /opt/ltp
./runltp -p -q -f cve

cve-2014-0196.c:125: TPASS: Nothing bad happened, probably.

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
gethostbyname_r01    1  TPASS  :  not vulnerable
tst_test.c:1433: TINFO: Timeout per run is 0h 15m 00s
<47>[  916.714682] systemd-journald[195]: Sent WATCHDOG=1 notification.
<47>[  916.915653] systemd-journald[195]: Successfully sent stream
file descriptor to service manager.
<0>[  920.086226] traps: PANIC: double fault, error_code: 0x0
<4>[  920.087343] double fault: 0000 [#1] PREEMPT SMP
<4>[  920.087914] CPU: 1 PID: 15074 Comm: keyctl02 Not tainted 5.19.0-rc5 #1
<4>[  920.088131] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.14.0-2 04/01/2014
<4>[  920.088484] EIP: atomic64_add_return_cx8+0x21/0x2c
<4>[  920.088700] Code: 90 f0 0f c7 0e 75 fa c3 90 55 53 56 57 89 c6
89 d7 89 cd 89 d8 89 ca f0 0f c7 09 89 c3 89 d1 01 f3 11 f9 f0 0f c7
4d 00 75 f1 <89> d8 89 ca 5f 5e 5b 5d c3 90 90 55 53 56 57 89 c6 89 d7
89 cd 89
<4>[  920.088700] EAX: 00000011 EBX: 00000010 ECX: 00000000 EDX: 00000000
<4>[  920.088700] ESI: ffffffff EDI: ffffffff EBP: c1df3bb0 ESP: c3479eb0
<4>[  920.088700] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: ffffffff
<4>[  920.088700] CR0: 80050033 CR2: 01f17320 CR3: 0a126000 CR4: 000006d0
<4>[  920.088700] Call Trace:
<4>[  920.088700]  ? pids_release+0x32/0x50
<4>[  920.088700]  ? cgroup_release+0x41/0xe0
<4>[  920.088700]  ? release_task+0x61/0x640
<4>[  920.088700]  ? trace_preempt_on+0x28/0x30
<4>[  920.088700]  ? _raw_write_unlock_irq+0x1b/0x30
<4>[  920.088700]  ? preempt_count_sub+0x7a/0xe0
<4>[  920.088700]  ? do_exit+0x50a/0x910
<4>[  920.088700]  ? syscall_enter_from_user_mode_work+0x135/0x150
<4>[  920.088700]  ? __ia32_sys_exit+0x15/0x20
<4>[  920.088700]  ? __do_fast_syscall_32+0x86/0xd0
<4>[  920.088700]  ? __this_cpu_preempt_check+0xf/0x11
<4>[  920.088700]  ? fpregs_restore_userregs+0x71/0xf0
<4>[  920.088700]  ? syscall_exit_to_user_mode+0x3c/0x60
<4>[  920.088700]  ? ret_from_fork+0x10/0x28
<4>[  920.088700]  ? do_fast_syscall_32+0x29/0x60
<4>[  920.088700]  ? do_SYSENTER_32+0x12/0x20
<4>[  920.088700]  ? entry_SYSENTER_32+0x98/0xf1
<4>[  920.088700] Modules linked in:
<4>[  920.088700] ---[ end trace 0000000000000000 ]---
<4>[  920.088700] EIP: atomic64_add_return_cx8+0x21/0x2c
<4>[  920.088700] Code: 90 f0 0f c7 0e 75 fa c3 90 55 53 56 57 89 c6
89 d7 89 cd 89 d8 89 ca f0 0f c7 09 89 c3 89 d1 01 f3 11 f9 f0 0f c7
4d 00 75 f1 <89> d8 89 ca 5f 5e 5b 5d c3 90 90 55 53 56 57 89 c6 89 d7
89 cd 89
<4>[  920.088700] EAX: 00000011 EBX: 00000010 ECX: 00000000 EDX: 00000000
<4>[  920.088700] ESI: ffffffff EDI: ffffffff EBP: c1df3bb0 ESP: c3479eb0
<4>[  920.088700] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: ffffffff
<4>[  920.088700] CR0: 80050033 CR2: 01f17320 CR3: 0a126000 CR4: 000006d0
<0>[  920.088700] Kernel panic - not syncing: Fatal exception in interrupt
<0>[  920.088700] Kernel Offset: disabled

links,
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.19-rc5/testrun/10489457/suite/log-parser-test/tests/


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
