Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5F6CA0EDC
	for <ltp@archiver.kernel.org>; Thu, 21 Aug 2025 06:24:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D959F3CCD29
	for <ltp@archiver.kernel.org>; Thu, 21 Aug 2025 08:24:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C8E93CA75E
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 13:14:56 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5C0C71400E44
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 13:14:52 +0200 (CEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-323267bcee7so7451601a91.1
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755688491; x=1756293291; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=muBzYbQwxrYcHt2ZzYNW1McoBEsmE8ndMXrCYhBaxoI=;
 b=xbPmCu6PoZTeZ7xRCG0WR4D0UX8GbLCI8XnxcuEhFTlbpAOnpVbn8V44stsftLkrm2
 C8rD7uTG7c+wwqmNXKisH4ASOg1pYmKXOfOY6D+5o4IDWX02Apv8OIq73o8pTReDidh4
 tPMq8X8jPcsoYdgJjxjIfvm7xICNs1pEhadGTB2vVuGHN+tbcCFt3zlunEgs8tWDIRoA
 QnbVB7T95j3xfp9kAzz3+pXV4Vtr77yaXrJ/7RIgW1O0m0aX6nsq/obScNCuSArwRPXd
 VR2rZYRMiSNy59ik8FC+YA6tTd73QijhkuOdy5upWd7YbX2mTxSos4b8G8h/SFx+MdMd
 SSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755688491; x=1756293291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=muBzYbQwxrYcHt2ZzYNW1McoBEsmE8ndMXrCYhBaxoI=;
 b=iThYLZBabl2vVydSwS7axcfmYBjLdJaKhUOYEVLidipyyuD8oaXKbbwRHz4fPh+UnT
 MdeEZWr+ZTTPDYx4VCxcu0vLkfcUhCYCdRg6ZFdpAgxbHeuB+4QblPMozFCkQT2XPhkG
 fjzgtUxMgNOh9Svkb2/VwocnC9wNXBVbipNzBVTvuBUIFPnMAZFsOpmXdwruArx+MfYT
 VRwLfaz6UmErA0Mye6xT3j+RIE/4LeQcdQbD9GaWbEQO9BVcnhAc/FT4XLxXn/bXzuTM
 UcPvLNtSjyIFmCB4hlZFheQKac/3VQemDWvaKTv766m5/oo48+595j0Z+2NptSTkkCHe
 +NIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoWSPGDLlp9ftp/uk3b9r5zdAW+LirTlyg0E+trEEdtMDWrEw/R/cRWFr51lFI087cxcQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzXuPBk1Wmun1Uhsku0sPD9IJrkY6ERoqHE14fnenrb5JLRiB/V
 v9T9G1Tni5t+9zzKWZF6suzckA8mG8bdkgyIQ5cdeU6LsMzdeDj5P+ujplDkCBf4bLKch856+u3
 R7CGRfamQvPanv6dSkK+VENo2vhuZJN0QzCroIr/kog==
X-Gm-Gg: ASbGnctGArBiKSd7qIFx/b6Sw66nS1Clnkn0/w/HtiYeGo66MUk+FViGlm3EPF4sLXU
 AoL81qGN1vGHwlxV4fRtC5JILaVo+1NM2ODi0Y1vmlMhUEwH2p5jfY4pooAjS/5QIL7s0vG6hwu
 i7FlY4DFryUzU67mHnTwazeSa4PHXCLqRMedBT01CWEz455dm8B7TPoB0yx0XcpHJHo6QkNAVo0
 OG/uwCy1UGeWWEYgw+C6tTGHxCAWSRmFv5yPpCpaTa4TXJ+JmvcXBGikVB8vQ==
X-Google-Smtp-Source: AGHT+IG2rFRwhQibaBR6aAuao3jI7K3VUg5l8QmVj2/VN7gYQHbUXOtPenTQq/0/FJwW3Jci4oXLWJuLEGGEEC67RlQ=
X-Received: by 2002:a17:902:c40f:b0:245:f88a:704d with SMTP id
 d9443c01a7336-245f88a713emr4555415ad.34.1755688490626; Wed, 20 Aug 2025
 04:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250819122834.836683687@linuxfoundation.org>
In-Reply-To: <20250819122834.836683687@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 16:44:37 +0530
X-Gm-Features: Ac12FXwHvZKUbm7j9QcsajfSa1g8XXDxhc8LwavjUmCAPCSQWY0oLDxVXkRXAVM
Message-ID: <CA+G9fYvdck=4i9EkdxJH7O1nTJu8NzeHbu-Q6_pn3bg0cV12KA@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 21 Aug 2025 08:23:47 +0200
Subject: Re: [LTP] [PATCH 6.15 000/509] 6.15.11-rc2 review
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
Cc: Jan Kara <jack@suse.cz>, lkft-triage@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, patches@kernelci.org,
 linux-ext4 <linux-ext4@vger.kernel.org>, linux@roeck-us.net,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 srw@sladewatkins.net, broonie@kernel.org,
 Ben Copeland <benjamin.copeland@linaro.org>, LTP List <ltp@lists.linux.it>,
 Christian Brauner <brauner@kernel.org>, rwarsow@gmx.de, pavel@denx.de,
 patches@lists.linux.dev, conor@kernel.org, achill@achill.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 19 Aug 2025 at 18:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As we discussed from the last time LTP syscalls epoll_ctl04 is a known issue
on the Linus master and Linux next.

* ltp-syscalls
  - epoll_ctl04

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1)
The bisection results pointing to

First bad commit,
eventpoll: Fix semi-unbounded recursion
commit f2e467a48287c868818085aa35389a224d226732 upstream.

2)
A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
- https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/
- https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.9-987-gcf068471031d/ltp-syscalls/epoll_ctl04/

## Build
* kernel: 6.15.11-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: cf068471031d89c4d7ce04f477ba69a043736a58
* git describe: v6.15.9-987-gcf068471031d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.9-987-gcf068471031d

## Test Regressions (compared to v6.15.9-481-g2510f67e2e34)

* ltp-syscalls
  - epoll_ctl04

## Metric Regressions (compared to v6.15.9-481-g2510f67e2e34)

## Test Fixes (compared to v6.15.9-481-g2510f67e2e34)

## Metric Fixes (compared to v6.15.9-481-g2510f67e2e34)

## Test result summary
total: 335595, pass: 313546, fail: 6512, skip: 15537, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-rust
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
