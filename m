Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1801CC5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 13:21:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 977F83C9249
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 15:21:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E56623C655D
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:20:52 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 900201A01456
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:20:50 +0200 (CEST)
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4fd05947340so1300102e0c.3
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724678449; x=1725283249; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eD175XUZ/ITy7ZdWAydNT67+uOxIgoWBm9/vtDXzUTA=;
 b=mQnDHylPOwIap6Nq9J/oLLDFRlkkhTamI0LZg9NxKVHuvmY9cR4iydQal2Q4UzlWq1
 C9w4FgBXCVVlQJw+65r0h3CB0+PUFMcyAN9zRhyKUYPadhSx9GBL1tcD/7c2wkf6t4pk
 CfFPV4W2o2t/aqzWNl+7LJZ7JfPNrnQQqpL9+g8Whqjg9T1H4DNjnTnYcCWVr7v5ciqP
 2MvElFvZvBhGmQ77EqIpO600i4r6sOOqKHiB/Efu/jHeo4wA/y9Ohlf/Rx4PPIwdWtQr
 ogp+96p4Nh8terLUtvqFUBVpeQKrallenGpJCkgLfXGOoRRP9hkqTlJEsfVT3KM8TxAa
 BqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724678449; x=1725283249;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eD175XUZ/ITy7ZdWAydNT67+uOxIgoWBm9/vtDXzUTA=;
 b=kPx2ZK1nh2kdTBvtGwHSW2f//o6JpYBer0c1dtGDb7m78MysNYpQNZCDavPnOHmnVc
 AvqxmSiPbZJXMCZO8mWSo/nWgydkMMyCntaCFkHsP685TzCZEKVLCIJ74VwGTaJm/PBM
 49mKLM9uZ0djx0X41Di42Z4IP2YQJm7vH0g1fIdFOQf/2Y9rz+0LFQu+kHvnpBA51a0I
 q6qHUifbttfrp/fRDFUM92Vir6ZoXt1mrA48amORwHx1uiwsUwFIlITQIVdEj4MX73uH
 Mh0i6sKaWUq+AYgtnq1yH61ELWb2kvyKd0P94Xt/U1t+bOGN9kO/QVaapq1WvdkpwQqO
 K2Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMawjh+cIgq3nDSOCKgznc07bSsepuuPu2ov6V+55hSGzAGDrv6y+foA6KC+kNNyfMR9Q=@lists.linux.it
X-Gm-Message-State: AOJu0YxKzj2WtMZT4aI4MSvPNGZdrei/w61le8p4vKX85F4vMiyr7PCN
 ybCla28SxpxuLCphiHIFD8GYB6p5Z1W8+Cw9tJfpKCUMLEC99QBQVrR+yBCPDMfhiz9h+/HshMs
 Pv/cx/WC4MgivoxJ1kvT7zhp1hI8EVOvlkX5kTQ==
X-Google-Smtp-Source: AGHT+IHfLYQXJQalFGVZVOgOn/tn6bOUOwnoI9D+YmaRkON0wOcbu81fZMRkrl/+m2cVQflgktyC19x+8RBVqWzPqMk=
X-Received: by 2002:a05:6122:3d08:b0:4f5:28e3:5a5a with SMTP id
 71dfb90a1353d-4fd1a522b94mr12978602e0c.4.1724678449179; Mon, 26 Aug 2024
 06:20:49 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 Aug 2024 18:50:37 +0530
Message-ID: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, 
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 lkft-triage@lists.linaro.org, 
 Linux Regressions <regressions@lists.linux.dev>, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] selftests: core: unshare_test: WARNING: at mm/util.c:671
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
 Matt Mackall <mpm@selenic.com>, Shuah Khan <shuah@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following kernel warning is noticed on all arch and all devices while
running selftests: core: unshare_test on Linux next-20240823 and next-20240826.

First seen on next-20240823.
  Good: next-20240822
  BAD:  next-20240823 and next-20240826

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Crash log:
--------
# selftests: core: unshare_test
<4>[   61.084149] ------------[ cut here ]------------
<4>[ 61.085175] WARNING: CPU: 0 PID: 477 at mm/util.c:671
__kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
<4>[   61.088958] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 drm fuse backlight dm_mod ip_tables x_tables
<4>[   61.093141] CPU: 0 UID: 0 PID: 477 Comm: unshare_test Not
tainted 6.11.0-rc5-next-20240826 #1
<4>[   61.094558] Hardware name: linux,dummy-virt (DT)
<4>[   61.096763] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 61.097841] pc : __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
<4>[ 61.099701] lr : __kvmalloc_node_noprof (mm/util.c:661)
<4>[   61.100448] sp : ffff800080abbce0
<4>[   61.100819] x29: ffff800080abbcf0 x28: fff0000004549280 x27:
0000000000000000
<4>[   61.101744] x26: 0000000000000000 x25: 0000000000000000 x24:
fff0000003615e40
<4>[   61.102512] x23: fff0000003615ec0 x22: bfafa45863b285c8 x21:
0000000200002000
<4>[   61.103232] x20: 00000000ffffffff x19: 0000000000400cc0 x18:
0000000000000000
<4>[   61.104053] x17: 0000000000000000 x16: 0000000000000000 x15:
0000000000000000
<4>[   61.104927] x14: 0000000000000000 x13: 0000000000000000 x12:
0000000000000000
<4>[   61.105752] x11: 0000000000000000 x10: 0000000000000000 x9 :
0000000000000000
<4>[   61.106606] x8 : 0000000000000001 x7 : 0000000000000001 x6 :
0000000000000005
<4>[   61.107377] x5 : 0000000000000000 x4 : fff0000004549280 x3 :
0000000000000000
<4>[   61.108207] x2 : 0000000000000000 x1 : 000000007fffffff x0 :
0000000000000000
<4>[   61.109262] Call trace:
<4>[ 61.109619] __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
<4>[ 61.110248] alloc_fdtable (fs/file.c:133)
<4>[ 61.110751] expand_files
(include/linux/atomic/atomic-arch-fallback.h:457
include/linux/atomic/atomic-instrumented.h:33 fs/file.c:177
fs/file.c:238)
<4>[ 61.111171] ksys_dup3 (fs/file.c:1337)
<4>[ 61.111596] __arm64_sys_dup3 (fs/file.c:1355)
<4>[ 61.112006] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
<4>[ 61.112480] el0_svc_common.constprop.0
(include/linux/thread_info.h:127 (discriminator 2)
arch/arm64/kernel/syscall.c:140 (discriminator 2))
<4>[ 61.112955] do_el0_svc (arch/arm64/kernel/syscall.c:152)
<4>[ 61.113384] el0_svc (arch/arm64/include/asm/irqflags.h:55
arch/arm64/include/asm/irqflags.h:76
arch/arm64/kernel/entry-common.c:165
arch/arm64/kernel/entry-common.c:178
arch/arm64/kernel/entry-common.c:713)
<4>[ 61.113742] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
<4>[ 61.115181] el0t_64_sync (arch/arm64/kernel/entry.S:598)
<4>[   61.115709] ---[ end trace 0000000000000000 ]---


Crash Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/log

Crash failed comparison:
----------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/history/

metadata:
----
  git describe: next-20240823 and next-20240826
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: c79c85875f1af04040fe4492ed94ce37ad729c4d
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/config
  artifact location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/
  toolchain: clang-18 and gcc-13

Steps to reproduce:
---------
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l2paZVYTloIDBYnua1s12DeIic/reproducer
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l2paZVYTloIDBYnua1s12DeIic/tux_plan

Please let me know if you need more information.

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
