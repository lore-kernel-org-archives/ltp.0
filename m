Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41810CA0ECA
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 07:56:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9B8E3CB839
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 09:56:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31B173CA45A
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 09:56:11 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B1A31400C47
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 09:56:11 +0200 (CEST)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-79414715edeso1547557241.0
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694505369; x=1695110169; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KHya+7F1DBe8l/ePdcCte4Kk0bJRNucDG9gM+2FXrkk=;
 b=CvVkusjZBVe2H4GnlB0j5mTU1XWHXgD2fuqwQ5Qiy2kDAOaN4+DqP9Uffg+RabxoUD
 4FGijWjIbdy1JUO2IAahKg4DijP4EWvqJjWMEpnUIYjLbyUFBv+4D5ki2oGxYRNEpjNi
 6gyTOnbs5SU7kIInl8YRHt0YOZ53dSkEgzm++G3oejPOH0RRThK0vOZu33dp9rsaaYVp
 TXXd0cUFRZ3Vjk2GxkR5twd29fmw8E1hhL9xC9iAJ0vLHABg5OvyRnkOfFIH0xjiz35i
 QOInoywwS7cjL/+YMWkR6dW/xMA92DyCrs4cJWKhS8F6aq4wQHhiinLB6P0G/ti0cRpZ
 hxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694505369; x=1695110169;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KHya+7F1DBe8l/ePdcCte4Kk0bJRNucDG9gM+2FXrkk=;
 b=L7Ho1A5voZuW85+uk+3lP6aH5Tm+qrXxM0piQARTl6ij2IC3BwvytKTGe9DeKHa8Hg
 i3TBuVm8+RAmHJ9U2KI4QmPGGx7UalSSerkgvyFq+poAvUQX1juU+YDnase8q23TiHnE
 s40Y0nSAynNnUN6WlBifnXtw4WJFt+TMvgkrNFHHhqrNTeuiqR+OVT5p4jo57Ay46xnB
 Ja7T7v4Bh3wukeJ/RKfi39mw0Y/WbKo/4ARpJ3P7LrM9hkmNSnYaB4hk3MYh0ONMHPS9
 9LbF7UkcIz77khq/VbScRZuGoVfE/aZUC3mCfXjKf6FByuGpsEgOc0gouXbGcVddE0Fa
 8VnQ==
X-Gm-Message-State: AOJu0Yzocjefsfqb32JYZZbMcaiaDKEGpcuppNfTXhFnUNYjH5rYlZOQ
 CX3o6HXtEhouu8+vgMrYY4aqtMThjhFJFnBRJEOmqA==
X-Google-Smtp-Source: AGHT+IEU7lzE/Dy3/8fiDPb3paZeKjpSwC6m9TQvo4Eme28XUib49W5/g7bAteipV+pRQMe7GryFitoR15vuGrj30Lg=
X-Received: by 2002:a1f:c487:0:b0:48d:1359:4dcd with SMTP id
 u129-20020a1fc487000000b0048d13594dcdmr6428193vkf.7.1694505369434; Tue, 12
 Sep 2023 00:56:09 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 12 Sep 2023 13:25:58 +0530
Message-ID: <CA+G9fYvHhiiGKhNd=L9+xYFVwv0Q8k6gUBeFQGWCWw1cWhb50Q@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 Linux PM <linux-pm@vger.kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Qemu-arm64: LTP: cfs_bandwidth01: Unable to handle kernel
 NULL pointer dereference at virtual address 0000000000000038
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
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following kernel crash noticed on Linux stable-rc 6.5.3-rc1 on qemu-arm64 while
running LTP sched tests cases.

This is not always reproducible.

Anyone have noticed LTP cfs_bandwidth01 causing a kernel crash on any of the
devices or qemu-* ?

I need to check similar crashes on other Linux trees and branches.

Boot log and test log:
---------------------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.5.3-rc1 (tuxmake@tuxmake) (Debian clang
version 18.0.0 (++20230910112057+710b5a12324e-1~exp1~20230910112229.889),
Debian LLD 18.0.0) #1 SMP PREEMPT @1694441978
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
...
running LTP sched tests
...
cfs_bandwidth01.c:129: TPASS: Workers exited
cfs_bandwidth01.c:117: TPASS: Scheduled bandwidth constrained workers
cfs_bandwidth01.c:54: TINFO: Set 'level2/cpu.max' = '5000 10000'
<1>[   74.455327] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000038
<1>[   74.456395] Mem abort info:
<1>[   74.456639]   ESR = 0x0000000097880004
<1>[   74.458273]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   74.458859]   SET = 0, FnV = 0
<1>[   74.459495]   EA = 0, S1PTW = 0
<1>[   74.460171]   FSC = 0x04: level 0 translation fault
<1>[   74.460799] Data abort info:
<1>[   74.461388]   Access size = 4 byte(s)
<1>[   74.462068]   SSE = 0, SRT = 8
<1>[   74.462713]   SF = 0, AR = 0
<1>[   74.463257]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   74.463996]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   74.465120] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001029d6000
<1>[   74.465818] [0000000000000038] pgd=0000000000000000, p4d=0000000000000000
<0>[   74.468416] Internal error: Oops: 0000000097880004 [#1] PREEMPT SMP
<4>[   74.469489] Modules linked in: fuse drm dm_mod ip_tables x_tables
<4>[   74.470964] CPU: 0 PID: 435 Comm: cfs_bandwidth01 Not tainted 6.5.3-rc1 #1
<4>[   74.471789] Hardware name: linux,dummy-virt (DT)
<4>[   74.473045] pstate: 634000c9 (nZCv daIF +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[   74.473785] pc : set_next_entity+0xc0/0x1f8
<4>[   74.475461] lr : pick_next_task_fair+0x204/0x3b8
<4>[   74.476989] sp : ffff8000807eb870
<4>[   74.477346] x29: ffff8000807eb870 x28: ffff0000c4e3b750 x27:
ffffcb93e8e19008
<4>[   74.478392] x26: ffff0000c4e3b0c0 x25: ffffcb93e8ab4828 x24:
ffff0000c0354a00
<4>[   74.479263] x23: ffff8000807eb900 x22: 0000000000000000 x21:
ffff0000ff5b1300
<4>[   74.480401] x20: ffff0000ff5b1300 x19: 0000000000000000 x18:
0000000000000000
<4>[   74.481417] x17: 000000000000ba7e x16: 0000000000000606 x15:
000000000117d17a
<4>[   74.482733] x14: 0000000000000000 x13: 0000000f0f4bc800 x12:
00000000000002b0
<4>[   74.484181] x11: 0000000f0f4bc800 x10: 0000000cf6ad6bd1 x9 :
ffffcb93e6af8e4c
<4>[   74.485229] x8 : 0000000000000000 x7 : ffffcb93e8a3ccac x6 :
0000000000000003
<4>[   74.486131] x5 : 000000008040002b x4 : 0000ffffbef0c000 x3 :
ffff0000ff5b1200
<4>[   74.487012] x2 : ffff0000c39efc00 x1 : 0000000000000000 x0 :
ffff0000ff5b1300
<4>[   74.488236] Call trace:
<4>[   74.488608]  set_next_entity+0xc0/0x1f8
<4>[   74.489280]  pick_next_task_fair+0x204/0x3b8
<4>[   74.489987]  __schedule+0x1e0/0x9c8
<4>[   74.490903]  schedule+0x134/0x1b8
<4>[   74.491632]  schedule_preempt_disabled+0x90/0x108
<4>[   74.492392]  rwsem_down_write_slowpath+0x288/0x6f0
<4>[   74.493056]  down_write+0x48/0xb0
<4>[   74.493606]  unlink_anon_vmas+0x148/0x1b0
<4>[   74.494222]  free_pgtables+0x10c/0x200
<4>[   74.494800]  exit_mmap+0x174/0x3c0
<4>[   74.495177]  __mmput+0x48/0x150
<4>[   74.495761]  mmput+0x34/0x70
<4>[   74.496058]  exit_mm+0xbc/0x148
<4>[   74.497651]  do_exit+0x22c/0x910
<4>[   74.498212]  do_group_exit+0xa4/0xb0
<4>[   74.498870]  __arm64_sys_exit_group+0x24/0x30
<4>[   74.499484]  invoke_syscall+0x4c/0x120
<4>[   74.499834]  el0_svc_common+0xd0/0x110
<4>[   74.500196]  do_el0_svc+0x3c/0xb8
<4>[   74.500475]  el0_svc+0x30/0x90
<4>[   74.500746]  el0t_64_sync_handler+0x84/0x100
<4>[   74.501309]  el0t_64_sync+0x190/0x198
<0>[   74.502156] Code: f900293f f9403908 b5ffff48 17ffffde (b9403a68)
<4>[   74.503735] ---[ end trace 0000000000000000 ]---
<6>[   74.504727] note: cfs_bandwidth01[435] exited with irqs disabled

Links:
-----
  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2VFpDOMEgzroNyiP9SSlxRxHsMH
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.2-740-g7bfd1316ceae/testrun/19901770/suite/log-parser-test/tests/
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2VFpB1ieNZSp5zh0joVGtoMn7RG/

Steps to reproduce:
----------------
# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.49.2
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
#

tuxrun --runtime podman --device qemu-arm64 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2VFpB1ieNZSp5zh0joVGtoMn7RG/Image.gz
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2VFpB1ieNZSp5zh0joVGtoMn7RG/modules.tar.xz
--rootfs https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --parameters SHARD_NUMBER=4
--parameters SHARD_INDEX=2 --image
docker.io/linaro/tuxrun-dispatcher:v0.49.2 --tests ltp-sched
--timeouts boot=30 ltp-sched=30 --overlay
https://storage.tuxboot.com/overlays/debian/bookworm/arm64/ltp/20230516/ltp.tar.xz


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
