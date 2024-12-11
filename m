Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC419E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 05:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D318B3E13EC
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 06:40:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46C4F3E13D9
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 06:40:00 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 48CA61421C34
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 06:39:59 +0100 (CET)
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-517aea3ee2aso1403525e0c.2
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 21:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733895598; x=1734500398; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L2JyqkiU/6R1xmttvdUUGuANembyWIMM8crCm1+D1nE=;
 b=liEFAi5Yk2c7nDbzTZ8oGk9MIy4W3wPdw41U5zO9TQfbUkWfrp8M2VN24rMi0/A+kP
 vh8ou+k+P/1rkqfCnAo3nhQTwbYBQC14g/c6Wv9JV53dB9Sufh9pqFrMFPtr1RJlnuOt
 MVU6KhjpJ+8Ntf0t4F/imZJpjgiw5lSntiDUD4F1NhXV2VfW6d6PkjKGwxfBvwlDK5j9
 eDnJ4Y3GOelXXaAhV0+/SiucFkafDs34nJCNpKCO6FGPyQGQCeR+HX3tSoYyRW/cAq3w
 KjhBMfB73cGIaXqCQSaYVjqwAmQ1Ka7FNDGZo857HuM/UHi2r7B7yzEqZoBbAITRiXD7
 8DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733895598; x=1734500398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2JyqkiU/6R1xmttvdUUGuANembyWIMM8crCm1+D1nE=;
 b=GlRa5scXxHtNNdHS3CoKy8Ity2wafjRYRbv+LY9XeTsWVpEgmhkSXJL3vAaf0+BYB2
 j+jnywQa3bus86ZwVcAhCYxa1B1PQ8yhZ83kTEO3VTwsVsq6K3hjifEu2io8SSAc8zJI
 jFCTh/8qTpQuTDYaKYtxd0KXFnzF6EJrSfgmU+T8NNp8I8EnC6lWfIxMA4pTNC9sqNGG
 C0mtrEiMtJbFY/9DUWfmHw2qPGcakwHnJ8JKdYSlSCXRXpylazGcCOPtPomH/t2epYDq
 KLf0glI5O5zlYjF6hdlrbTsDZQ13n91sER9bXOuujnk8WejEFYBqddKDtoR5yrYMdm5c
 ejfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlrm+Dqy+G4Qo2i2DQ4flGqpdCHXBLFeXmk1SPHASIZNYVc9jdQqXxUopWtnrpjYxoJKg=@lists.linux.it
X-Gm-Message-State: AOJu0YwQdgbCxnTEZiULuaLzmU1reT50hxh9gruffrEq/BquAIitrdb8
 IUKQjnu7fv1kik9WhneBvWGyJrYKdjTTAHaYwLuuaGgeCE0sdvWrRU8rayj1W1tRvO4bAGejeFy
 qqGV5IaumdnoQfSbqGgs6O83sTw93MUCnAJxBQQ==
X-Gm-Gg: ASbGncumvYHR6E8KqQ/rSdaLfXRXiKh7MgCvCVxplX27p35c9XF9DbG6M2ea1chUnvq
 LC2Hakze8JFt4axbG6RkzG3Y7BqbpyDQ+6g==
X-Google-Smtp-Source: AGHT+IGaVQqa3Q+BI6ngTSIj2GVkueSl4Jrs/cm3+CtAoLXynlarl8woucxcn3CryRSjN8OBkzE56/rteEslmfJ/Svc=
X-Received: by 2002:a05:6122:8292:b0:515:e4c4:3664 with SMTP id
 71dfb90a1353d-518a3cc3352mr1602173e0c.9.1733895597732; Tue, 10 Dec 2024
 21:39:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
In-Reply-To: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Dec 2024 11:09:46 +0530
Message-ID: <CA+G9fYuHGTKM5P+nEifZwfALPfO9uw7sraCrGo-c3YzR=JjwJg@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, 
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 lkft-triage@lists.linaro.org, 
 Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] selftests: core: unshare_test: WARNING: at mm/util.c:671
 __kvmalloc_node_noprof
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
Cc: Barry Song <baohua@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Al Viro <viro@zeniv.linux.org.uk>, David Gow <davidgow@google.com>,
 Shuah Khan <shuah@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

[Gentle Reminder]

On Mon, 26 Aug 2024 at 18:50, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following kernel warning is noticed on all arch and all devices while
> running selftests: core: unshare_test on Linux next-20240823 and next-20240826.
>
> First seen on next-20240823.
>   Good: next-20240822
>   BAD:  next-20240823 and next-20240826

This is an open issue from August.
The reported kernel warning is still seen on linux next and mainline
while running selftests: core: unshare_test.

Linux version: 6.13.0-rc2-next-20241210

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Crash log:
> --------
> # selftests: core: unshare_test
> <4>[   61.084149] ------------[ cut here ]------------
> <4>[ 61.085175] WARNING: CPU: 0 PID: 477 at mm/util.c:671
> __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[   61.088958] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> sha512_ce sha512_arm64 drm fuse backlight dm_mod ip_tables x_tables
> <4>[   61.093141] CPU: 0 UID: 0 PID: 477 Comm: unshare_test Not
> tainted 6.11.0-rc5-next-20240826 #1
> <4>[   61.094558] Hardware name: linux,dummy-virt (DT)
> <4>[   61.096763] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT
> -SSBS BTYPE=--)
> <4>[ 61.097841] pc : __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[ 61.099701] lr : __kvmalloc_node_noprof (mm/util.c:661)
> <4>[   61.100448] sp : ffff800080abbce0
> <4>[   61.100819] x29: ffff800080abbcf0 x28: fff0000004549280 x27:
> 0000000000000000
> <4>[   61.101744] x26: 0000000000000000 x25: 0000000000000000 x24:
> fff0000003615e40
> <4>[   61.102512] x23: fff0000003615ec0 x22: bfafa45863b285c8 x21:
> 0000000200002000
> <4>[   61.103232] x20: 00000000ffffffff x19: 0000000000400cc0 x18:
> 0000000000000000
> <4>[   61.104053] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000000
> <4>[   61.104927] x14: 0000000000000000 x13: 0000000000000000 x12:
> 0000000000000000
> <4>[   61.105752] x11: 0000000000000000 x10: 0000000000000000 x9 :
> 0000000000000000
> <4>[   61.106606] x8 : 0000000000000001 x7 : 0000000000000001 x6 :
> 0000000000000005
> <4>[   61.107377] x5 : 0000000000000000 x4 : fff0000004549280 x3 :
> 0000000000000000
> <4>[   61.108207] x2 : 0000000000000000 x1 : 000000007fffffff x0 :
> 0000000000000000
> <4>[   61.109262] Call trace:
> <4>[ 61.109619] __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[ 61.110248] alloc_fdtable (fs/file.c:133)
> <4>[ 61.110751] expand_files
> (include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/atomic/atomic-instrumented.h:33 fs/file.c:177
> fs/file.c:238)
> <4>[ 61.111171] ksys_dup3 (fs/file.c:1337)
> <4>[ 61.111596] __arm64_sys_dup3 (fs/file.c:1355)
> <4>[ 61.112006] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:54)
> <4>[ 61.112480] el0_svc_common.constprop.0
> (include/linux/thread_info.h:127 (discriminator 2)
> arch/arm64/kernel/syscall.c:140 (discriminator 2))
> <4>[ 61.112955] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> <4>[ 61.113384] el0_svc (arch/arm64/include/asm/irqflags.h:55
> arch/arm64/include/asm/irqflags.h:76
> arch/arm64/kernel/entry-common.c:165
> arch/arm64/kernel/entry-common.c:178
> arch/arm64/kernel/entry-common.c:713)
> <4>[ 61.113742] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
> <4>[ 61.115181] el0t_64_sync (arch/arm64/kernel/entry.S:598)
> <4>[   61.115709] ---[ end trace 0000000000000000 ]---
>
>
> Crash Log links,
> --------
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/log
>
> Crash failed comparison:
> ----------
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/history/
>
> metadata:
> ----
>   git describe: next-20240823 and next-20240826
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git sha: c79c85875f1af04040fe4492ed94ce37ad729c4d
>
> Please let me know if you need more information.
>

Kernel warning log:
-----------------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241210/testrun/26261199/suite/kselftest-core/test/core_unshare_test/log

> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
