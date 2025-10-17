Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF5BCCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 09:21:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A0D33CEE60
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 11:21:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE7023C52D5
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:20:45 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E154E600625
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:20:44 +0200 (CEST)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so1579872b3a.0
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760692843; x=1761297643; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LhknjiEqyUugoHigEu5rPV98JBjQEuOdpnABFTzWfmA=;
 b=l2EDawqfuR0AVC0D+D/BDmc7MNiZHfAnts8nR5CGaeAhke8e3ZXV6lcfh8s+4Gr5U0
 I7eHOcAgIu0z1QD/PVh+UJJRLnk1D77T3xA6te1d5JrLasMHiemDT1kl0HRf++4dOqWI
 akNQJWqUHgfRqGSecNiWYkxrTBP/E0rryaP5Rm5k+G41FmG5tnxjn32jNpghOrNKfkFl
 UUhGBwwRG3kjGDWOCMg2KTz2quXJU8GqgjxIsxchZua8dj6EBIZhdKdrs4DY6xpc6FZ/
 8VSqM4qdSwLlL7axV/vl1iWz4xEmQ31YqOgIBXkBVuO8W/J+O4UUXaDjvpf4WxOSJssf
 pwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760692843; x=1761297643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhknjiEqyUugoHigEu5rPV98JBjQEuOdpnABFTzWfmA=;
 b=bWhi6UTdpESUmEbww9sFxy7dSefJaEEUTZAnWuTsWlEbsf8TG8R400M2lLE92srmWF
 a2YH0uf9dW4FPas9Q8CEs5ZbCKo4/gz/TjmW9ae1PcVPH0sf3akV83KWfBiLMb2Q/ORJ
 ocvy2Gth7DXcBbHzxxEHFgJ4pizk+vtWzdHiGokAisztzOnM376KvVu+YkJtQCp8jULv
 3gTJhpmgVtrrJqF3o+X/mSkCwGHFxGH82RtdgyJt2WXsbu59ToUEB4gKXuVh2E38////
 WKBGYOqotnRQ9HwtOYMwDSdgYGz/ybo4XcjE3Xvi5y+Qx4Ijr6TPIz+4xqCZejDZR7YA
 9b9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuncZudgZS3d1p5T0r6B42MwEMG/6Bc2nHGtPbKCgIDie958qI5lgr3NliciMxqAF1RT0=@lists.linux.it
X-Gm-Message-State: AOJu0YznuuiEGxAF2H8+OMx7qxKHzjxaIyQ6TgTWkAsCJ4PsGOMgxKom
 uxd/lx/rqs5YQ02aU9e29AeIdOR1Y9XvIdTmekS9Epr/nhkLA/zAlDCnGi7I+w/EzPf1UrAJayU
 p0kQND21uzixfX7C3dV7kN9TTn9Qm2tgwKl6nSO05sg==
X-Gm-Gg: ASbGncuaY1QXaau7IUzoNR1knaGNl5H0vrnsAzWHq9q0l21eOzo19TMQoy/HtUTANB0
 XWMfKfdlegfhg35XEVH8AU8RJ5nabecwf/tORMhGFn8YJ6jXvSDZoIDDsAfV22xndpuqmMEE8PI
 25FklJ/Ql8E+fid9OUapt5/1UZAI+rraT9rW9mgLjf0ayuOtYL86b2Dcp8GEzhcUaeBTEb6I4tD
 ZAi9CuXp1rRMah1FhQYx+83AKmFkwnFb08KW1ytyiXtUdgqSJKKZCPg2sEQXWIdOnmC370iKAnY
 UFISkAYLkf6x93Hmou1n4PyMbRSqKsY5JTYyUfjT99DSrWAzsw==
X-Google-Smtp-Source: AGHT+IH8McWMlP4j6h/In61PzhIcYXxJLdaulFUt4hQVbIPHKC+IElEF8O1paYDYvmL7uBRRfha5zKIJziU3JZlwoqY=
X-Received: by 2002:a17:903:b0e:b0:25c:d4b6:f111 with SMTP id
 d9443c01a7336-290cb65b633mr37181575ad.47.1760692843202; Fri, 17 Oct 2025
 02:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
In-Reply-To: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 Oct 2025 14:50:31 +0530
X-Gm-Features: AS18NWDlNGurivO1eFZTkxH5OkdGuvePuO7Z9_9bbaV5WCId2Ea8RDnwy82C9Ic
Message-ID: <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
 lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, 
 LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
 ioctl(pidfd, PIDFD_GET_INFO_SHORT,
 info_invalid) expected EINVAL: ENOTTY (25)
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 Andrey Albershteyn <aalbersh@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

+ LTP mailing list,

On Fri, 17 Oct 2025 at 14:21, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The LTP syscalls ioctl_pidfd05 test failed due to following error on
> the Linux mainline
> kernel v6.18-rc1-104-g7ea30958b305 on the arm64, arm and x86_64.
>
> The Test case is expecting to fail with EINVAL but found ENOTTY.

[Not a kernel regression]

From the recent LTP upgrade we have newly added test cases,
ioctl_pidfd()

The test case is meant to test,

Add ioctl_pidfd05 test
Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO
 is used.
 This happens when:
   - info parameter is NULL
   - info parameter is providing the wrong size

However, we need to investigate the reason for failure.

Test case: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c

>
> Please investigate this reported regression.
>
> First seen on v6.18-rc1-104-g7ea30958b305
> Good: 6.18.0-rc1
> Bad: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Test regressions: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
> ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL:
> ENOTTY (25)
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Test error log
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_test.c:2021: TINFO: LTP version: 20250930
> tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> @1760657272 aarch64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> which might slow the execution
> tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> info_invalid) expected EINVAL: ENOTTY (25)
> Summary:
> passed   1
> failed   1
>
> ## Source
> * Kernel version: 6.18.0-rc1
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> * Git describe: v6.18-rc1-104-g98ac9cc4b445
> * Git commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
> * Architectures: arm64, x86_64
> * Toolchains: gcc-13 clang
> * Kconfigs: defconfig+lkftconfig
>
> ## Build
> * Test log: https://lkft.validation.linaro.org/scheduler/job/8495154#L15590
> * Test details:
> https://regressions.linaro.org/lkft/linux-mainline-master/v6.18-rc1-104-g98ac9cc4b445/ltp-syscalls/ioctl_pidfd05/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/34AVGrBMrEy9qh7gqsguINdUFFt
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/config
>
> --
> Linaro LKFT

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
