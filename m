Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27490C6FD1F
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 09:22:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2E143CC868
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 11:22:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA04C3CABEA
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 21:01:42 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3C54600824
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 21:01:41 +0200 (CEST)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6e695470280so2558938a34.3
 for <ltp@lists.linux.it>; Mon, 01 Apr 2024 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711998100; x=1712602900; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8VfZljfocSfpqKfZ24APD96ZY0uNFOza/nVTuCvA10s=;
 b=Y5C+OiCmHaqiGhCfMKkuClQ8hWmkapBJ6uWfdZn5hsmaiSvk6z3yvjXTp85TtYRnyf
 0EPKAVtGVuCqkaUFTexz5NMclFPk18reeocbn2X+2zm7194wJssuJIYurPa/iGqiCb0A
 7Nq4q+oN/HKN/vzd5XuBSSS3Oe3BZXZoxYmSM8nnT3oWqZslGRsV3lUe4T91m3jo1UZn
 O1nDTAyQc8pWNTsbwKYf7GNAOiLqTaZlsohncwEyYIQsR++PbZD9Fk1t5kuVHLPT+m+g
 2+lV9zqbzjll9tNYZYGYBfPsgVS+zOHabqyzCuU1PmKDzOCjbRz+upPfnCScpSpvXT81
 Dg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711998100; x=1712602900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8VfZljfocSfpqKfZ24APD96ZY0uNFOza/nVTuCvA10s=;
 b=wh4RCWjJwE6C0A4dux5eLgcnFouDNCS72EvNYdWNTorxq/70Knda1P0tlhC3//R271
 1Ior0mEjtnw7cwS1jvDefI8f0nvNLpnBPti532YR/qjNnv0czmJ8k8OYQWKrYysCl3OX
 RIOoll9i/x8tMwaZkmMROrMqnyilEQ7GjXzy3fHDY+UZcUerE+h/6FaEtW+4Ak8a0FOv
 3vtHdvvPbmpcis4HVpqX4fThMXFz4kSrmD7WYhyp3ZrH3Zm43yLAAm5gsyQHISHAmlGJ
 Zx61b1eh+dGWhP+rYP2/cbauu7np6elKNunkZMmIf9fPiTPhsA1+Ax+YaTaSybRY/l2X
 +b4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ9AT+BYjxiXeLz4A4v6ZqMN3bGeUqG0w8jsaB7bmB6QjuTQVX9HgqANjdBxbN3p9+qyjSCjkzIZdGKVFtqP8fiDY=
X-Gm-Message-State: AOJu0YznS8KwMuv5LoMCDwZPDbKXsFcrxfzv7vF28eA3RaNjfuyh83Ly
 UHCTFj2QyChuU16+9jPAotAQKG/DVAo2W8EyWmC9FAfc+OUcFirC91c4BMIxeAc8kKOd4n2Vvi6
 oAkFAj/DsxE9AJI2fF3XxkLiDgXmPs4+W25TxhQ==
X-Google-Smtp-Source: AGHT+IFWsTgohUEdMBkXC10fXfKP3iS0KDnJgXeRSHA+MEC5uuUmhMYLgrrl4ce7h5CXapU9nMnWcn+nFmlIVMpAOM8=
X-Received: by 2002:a05:6808:190d:b0:3c3:d37d:594d with SMTP id
 bf13-20020a056808190d00b003c3d37d594dmr12830121oib.0.1711998100384; Mon, 01
 Apr 2024 12:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240401152547.867452742@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 00:31:28 +0530
Message-ID: <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Apr 2024 11:21:16 +0200
Subject: Re: [LTP] [PATCH 6.6 000/396] 6.6.24-rc1 review
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
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 Alexander Wetzel <Alexander@wetzel-home.de>, stable@vger.kernel.org,
 shuah@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 f.fainelli@gmail.com, Bart Van Assche <bvanassche@acm.org>,
 jonathanh@nvidia.com, patches@kernelci.org, linux@roeck-us.net,
 Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net, broonie@kernel.org,
 LTP List <ltp@lists.linux.it>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, rwarsow@gmx.de,
 pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 1 Apr 2024 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following kernel warnings have been noticed on qemu-x86_64 while running LTP
cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
6.8.3-rc1.

We have started bi-secting this issue.
Always reproduced.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
------------[ cut here ]------------
[   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
sg_remove_sfp_usercontext+0x145/0x150
[   36.609445] Modules linked in:
[   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
[   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   36.612872] Workqueue: events sg_remove_sfp_usercontext
[   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150

<trim>

[   36.621539] Call Trace:
[   36.621953]  <TASK>
[   36.622444]  ? show_regs+0x69/0x80
[   36.622819]  ? __warn+0x8d/0x150
[   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
[   36.623558]  ? report_bug+0x171/0x1a0
[   36.623881]  ? handle_bug+0x42/0x80
[   36.624070]  ? exc_invalid_op+0x1c/0x70
[   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
[   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
[   36.625408]  process_one_work+0x141/0x300
[   36.625769]  worker_thread+0x2f6/0x430
[   36.626073]  ? __pfx_worker_thread+0x10/0x10
[   36.626529]  kthread+0x105/0x140
[   36.626778]  ? __pfx_kthread+0x10/0x10
[   36.627059]  ret_from_fork+0x41/0x60
[   36.627441]  ? __pfx_kthread+0x10/0x10
[   36.627735]  ret_from_fork_asm+0x1b/0x30
[   36.628293]  </TASK>
[   36.628604] ---[ end trace 0000000000000000 ]---
ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked

Suspecting commit:
-----
scsi: sg: Avoid sg device teardown race
commit 27f58c04a8f438078583041468ec60597841284d upstream.

 + WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);

Steps to reproduce:
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2eVWFlAeOUepfeFVkrOXFYNNAqI/reproducer

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.23-397-g75a2533b74d0/testrun/23255318/suite/log-parser-test/tests/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2eVTitwVMagaiWhs5T2iKH390D5


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
