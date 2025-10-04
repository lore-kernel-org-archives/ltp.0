Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46742CCA472
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 11:33:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAE453CE3F1
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 13:33:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 370CC3CE54F
 for <ltp@lists.linux.it>; Sat,  4 Oct 2025 14:05:57 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 478E860065C
 for <ltp@lists.linux.it>; Sat,  4 Oct 2025 14:05:57 +0200 (CEST)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b550eff972eso2201078a12.3
 for <ltp@lists.linux.it>; Sat, 04 Oct 2025 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759579555; x=1760184355; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RvMiexLJvP6E79APrj0rLj11cSNtbanirw2a0dqWnQY=;
 b=rlCRnLYBcpuNCQukoYIN108JH5sshWX0AMXoPc2GHVahL95mW2VpXq55KwhNzJHmU8
 u4h9TTDFbXmeGCJpW5UbTaWq55ar5DCfAK98aKLKV8gPHpPxMfVMeRUwISFbsAYI1xWh
 ozoLzP38Y899VIyU605+dycdpupO7qKNna0aJlQ6h8/J/I4T7RakBn56hx5tdEKKWzu+
 7lOoFmNdhUPh0Qtaq9BrVqdl7qLGCZEzs0PMCnoaimEr99jp2qp85QIEzzr4y+Exe5LP
 QWPAvHX+hivLnIN0PVKrtcQHQlRHAgOLZZf+Uo+AS7Hn18JKaO0jsU5gizfpRsHyGkcK
 Azow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759579555; x=1760184355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RvMiexLJvP6E79APrj0rLj11cSNtbanirw2a0dqWnQY=;
 b=XN+TYIQq9PVT5g9Gcen0sXQcini0kBa9+G9kKBy6tg6gXG8tvHLAYU38ko8YhuaxmW
 +Kf6nQGBwMxwreoETUN8vNbJxsQkErOvhmx2PaN4oKwwq12L5BcNwJydbxsFoOOlyYaN
 3ldJ7ZNEqMjoqxrP/B1jmRBlEA2PrQhMTR7o2js3AWda1oZWKFwCfd3Pu5nx6H+LCWZR
 0SkMIMekxQF22GS+P92iUYHQu/lAQCtQ7MumCxuxrmfQDzKwlhWgDcE6iSatf4RWNXIL
 40Rc0fhnkTpLzene0kgb7VxeL/SLUaphOc+h7v9uSIbrWEe2OcPBqJAjU3vne22mgeLS
 wSTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKNUaEjssSsHY9PUPymS4y/UBwkLMRc4N9eG4fqxL5WYhz2kNxrAqwhHFvrhe4Eos0IXo=@lists.linux.it
X-Gm-Message-State: AOJu0YwH4FdZ7mknLJ1uDjHv+gAG9xgjJkqLeZM9q96LDqjzg0w1z3Gi
 4edZI8G5ThnW0KT4Ia2i+1kyblY7MKNGhCg+45sSzgo9tMUuureF/AaxSlPRHqyCW/nlhlpFflU
 0BMCVTemTcUDiFbugJTmIp4DWqvNslePdWM5ho8NamQ==
X-Gm-Gg: ASbGnctwywFfVMUL91VItFNH4XgNB3aVshMBjE1OKniRWp5booZcZlhWtSgHtHsPOsY
 otiX8/tRa0Y0byajqj7GTpxJy8O+kQ60pqFjI0sxSaNoWCMAYYwULhbdn2/2flflNwV9Apu4mln
 gopjaavy1njUqf2im30T9GwjPGG9XvczG/NKjFSnfzOW8uXpaiZxmxJ8TIZcZtAyVG6MBlvvkfx
 o0Wr7yeq7IoK9ChZ6UWo0CA0bIA6dRBJawOBHyT/QQ8FEanXXmwyqUUuic63NLcFyT9StUysRGK
 37ZhE19KPdqGuzFR0abJH6bN
X-Google-Smtp-Source: AGHT+IHUcUiJvywAA3BHIQxICROug7QzGkP3JuEDSXUGBs+FalO/ecqWea7HGT/2uJb78TWgsqTWeIQtZungiwh66Xk=
X-Received: by 2002:a17:902:e78b:b0:26d:353c:75cd with SMTP id
 d9443c01a7336-28e9a567016mr83165785ad.21.1759579555517; Sat, 04 Oct 2025
 05:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251003160359.831046052@linuxfoundation.org>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 4 Oct 2025 17:35:44 +0530
X-Gm-Features: AS18NWAObnZ1L7fWSoS2-NJL7inBt0GzGopLp_3E_Hq02ONyESgBFKR13d7cVUw
Message-ID: <CA+G9fYuW6+KiuVd+ONpyo-vWCvF=dSNJzc0cdarBXjNY_XGaAg@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 07 Oct 2025 13:33:40 +0200
Subject: Re: [LTP] [PATCH 6.17 00/15] 6.17.1-rc1 review
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, lkft-triage@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kalesh Singh <kaleshsingh@google.com>, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, Joanne Koong <joannelkoong@gmail.com>,
 patches@kernelci.org, linux@roeck-us.net, Miklos Szeredi <mszeredi@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, broonie@kernel.org,
 Ben Copeland <benjamin.copeland@linaro.org>, LTP List <ltp@lists.linux.it>,
 Juan Yescas <jyescas@google.com>, rwarsow@gmx.de, pavel@denx.de,
 patches@lists.linux.dev, conor@kernel.org, achill@achill.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 3 Oct 2025 at 21:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


LTP syscalls swapon01, swapon02, swapon03, swapoff01 and swapoff02 test failing
on 16K and 64K page arm64 devices and passed with default 4K page size.

These failures are noticed on Linux next and mainline master (v6.17).

This test failed on 16K page size builds and 64K page size builds.
 * CONFIG_ARM64_64K_PAGES=y
 * CONFIG_ARM64_16K_PAGES=y

Test regression: LTP swapon/off 16K and 64K page size LTP
libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders, bisected this on the Linux next and found the,
# first bad commit:
  [bd24d2108e9c8459d2c9f3d6d910b0053887df57]
  fuse: fix fuseblk i_blkbits for iomap partial writes

## Test logs
### swapon01

libswap.c:230: TFAIL: swapon() on fuse failed: EINVAL (22)
swapon01.c:39: TINFO: create a swapfile size of 128 megabytes (MB)
swapon01.c:25: TFAIL: tst_syscall(__NR_swapon, SWAP_FILE, 0) failed: EINVAL (22)

Lore link,
- https://lore.kernel.org/all/CA+G9fYtnXeG6oVrq+5v70sE2W7Wws_zcc63VaXZjy1b1O1S-FQ@mail.gmail.com/

## Build
* kernel: 6.17.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: e7da5b86b53db5f0fb8e2a4e0936eab2e6491ec7
* git describe: v6.17-16-ge7da5b86b53d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17-16-ge7da5b86b53d

## Test Regressions (compared to v6.17-16-ge7da5b86b53d)
* qemu-arm64, ltp-syscalls
  - swapoff01
  - swapoff02
  - swapon01
  - swapon02
  - swapon03

## Metric Regressions (compared to v6.17-16-ge7da5b86b53d)

## Test Fixes (compared to v6.17-16-ge7da5b86b53d)

## Metric Fixes (compared to v6.17-16-ge7da5b86b53d)

## Test result summary
total: 162823, pass: 136895, fail: 4815, skip: 21113, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 138 passed, 1 failed
* arm64: 57 total, 51 passed, 6 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 46 passed, 3 failed

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
