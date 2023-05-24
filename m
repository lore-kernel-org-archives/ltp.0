Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B218C7EE23
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 10:49:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0FEA3CE7E3
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 12:49:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA1A33CB279
 for <ltp@lists.linux.it>; Wed, 24 May 2023 12:48:55 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA3261400C42
 for <ltp@lists.linux.it>; Wed, 24 May 2023 12:48:54 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7868d32ace2so604482241.3
 for <ltp@lists.linux.it>; Wed, 24 May 2023 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684925333; x=1687517333;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=izjtzCWSO3V30nPY/lKoLTSymypWksl9aXq+SMrSSR4=;
 b=eIrDBzI2+Y6c3ajP2t6EfqTU7yrqOLMZnBSNdLYLBo5Ge+Kpnmz3xI2NDLuXGJUx9B
 IJK1edBpN8tWETbLzwnxqmUm180YNQyONPhZfihmxtC/8lxgDIMPa3oTAjz9fytgiymC
 k0Ucea9q/KKmAxDL56o7Lw3RLYNjjlxrZ72qN5wi6cVqMnYrhV1qc4TJ9KT1e6SlGedB
 9JNlsczyLltriaG9hWfSIBJ9C85xhFt35DVOv78ovRPwRmqSZFz0X+dq6Jtg+G1brGsS
 WWc8Q6uG1FodpCiDTvXX14CfOX0Og6D7zhB8IDOPUXJogq5ek6sIrWs9xmYANFfq+vmA
 rbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684925333; x=1687517333;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=izjtzCWSO3V30nPY/lKoLTSymypWksl9aXq+SMrSSR4=;
 b=Ya6MUTvC9VMkRMfjoBBHQ2Y28gFFMKSBOsCbf/VTB/VOvvvvEytRIodQzxoH7OrE3g
 QFtGWc9y3LHEoX5Up6FobFYU+KYWA4NM7CQAmeV73JO/qmLqftvZRfrSdx04GxCiJ7CA
 TYETXkPnVQVs1EU2atCzyPXA0VLKQuGWnhnqJW5WXOgTN0Oqzvy7SYDA/AqZzVROnGbS
 DSI7yT4fV4kQfpgCVSsGeMiTtc/46C/L/304h7qp6hsc+Uz6LFN1dRt7bucqv1Qshf85
 slo9q3zaKWxagxdrLx8MpEl8/u++YeWxh9stsVcDbtWmqUS8b2l22dhB29TxH1BVk6vL
 Gwgw==
X-Gm-Message-State: AC+VfDyus2ncYjCzxReAPVPr9sfapQwH1qkPcPJlN86LFWtODK98XwJG
 8nHveIPOaBiPVtyJ7ILeCs2Twf5ZP+pnaYjwvA3uShzYH93IvfPXbGFovQ==
X-Google-Smtp-Source: ACHHUZ7dGXhAAYQ0ZVMH5xXIrESE7KpD6AKM288xP3S7MG24zrh10Wcemw5hhk9LGDL9KAGbU0DtksYgalPfF1DMPBQ=
X-Received: by 2002:a67:f148:0:b0:434:2f6a:6009 with SMTP id
 t8-20020a67f148000000b004342f6a6009mr5715027vsm.8.1684925333160; Wed, 24 May
 2023 03:48:53 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 May 2023 16:18:42 +0530
Message-ID: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP: syscalls: statx06.c:138: TFAIL: Modified time >
 after_time
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
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP syscalls statx06 fails on NFS mounted devices using external hard drives
for testing and running on Linux next 6.4.0-rc3-next-20230524.

Test case fails on x86_64, i386 and arm64 Juno-r2.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Linux version 6.4.0-rc3-next-20230524 (tuxmake@tuxmake)
(x86_64-linux-gnu-gcc (Debian 11.3.0-12) 11.3.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1684908723
...

[    1.396191] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    1.397234] sysctl table check failed: kernel/usermodehelper Not a file
[    1.398166] sysctl table check failed: kernel/usermodehelper No proc_handler
[    1.399165] sysctl table check failed: kernel/usermodehelper bogus .mode 0555
[    1.400166] sysctl table check failed: kernel/keys Not a file
[    1.401165] sysctl table check failed: kernel/keys No proc_handler
[    1.402165] sysctl table check failed: kernel/keys bogus .mode 0555
[    1.403166] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.4.0-rc3-next-20230524 #1
[    1.404165] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.5 11/26/2020
[    1.404165] Call Trace:
[    1.404165]  <TASK>
[    1.404165]  dump_stack_lvl+0x72/0x90
[    1.404165]  dump_stack+0x14/0x20
[    1.404165]  __register_sysctl_table+0x570/0x840
[    1.404165]  __register_sysctl_init+0x29/0x60
[    1.404165]  sysctl_init_bases+0x27/0x80
[    1.404165]  proc_sys_init+0x37/0x40
[    1.404165]  proc_root_init+0x7b/0x90
[    1.404165]  start_kernel+0x403/0x6a0
[    1.404165]  x86_64_start_reservations+0x1c/0x30
[    1.404165]  x86_64_start_kernel+0xcb/0xe0
[    1.404165]  secondary_startup_64_no_verify+0x179/0x17b
[    1.404165]  </TASK>
[    1.404165] failed when register_sysctl kern_table to kernel

....
./runltp -f syscalls -d /scratch

...

[ 1192.088987] loop0: detected capacity change from 0 to 614400
tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
[ 1192.337350] EXT4-fs (loop0): mounted filesystem
dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
mode: none.
tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s

statx06.c:140: TPASS: Birth time Passed
statx06.c:138: TFAIL: Modified time > after_time
statx06.c:140: TPASS: Access time Passed
statx06.c:140: TPASS: Change time Passed


links,
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/details/


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
