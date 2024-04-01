Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B6CC6FD1F
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712049760; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=z2+BhMRt5WQIgJeQS7V0Qoi6/yNNsJjyWzPq0XMBKlA=;
 b=U0jh0NhaUDNbkhWtc+fNN6itpymzUKflreIM6Qg1McOHKLq4o1Co5Zzsj/Xb9WQoSQFPv
 BO3V0od2kE9RiwbdPTjoZvwbavJXv1dEqdysV3h/16dyQVUFM/axqoUllpOwRF1wVuLBdWc
 WkkS6UWKTUMsv//F8GDjiGKjW8zOgPg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 129E43CD00A
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 11:22:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFCC03C81C0
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 21:22:55 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=wetzel-home.de (client-ip=5.252.227.236; helo=ns2.wdyn.eu;
 envelope-from=alexander@wetzel-home.de; receiver=lists.linux.it)
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id AA98F60064D
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 21:22:54 +0200 (CEST)
Message-ID: <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
 s=wetzel-home; t=1711999372;
 bh=LsTqeFuehhRozVPP6yl8wXv6EoSNKPUfp9Na0e3Fyj8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KrTcUhFevt+8dDt4GxN7BPi7eMvZQjV0UNGSkf/Vb6PcmOFvzqqi0nhbWPdWqCIwo
 BroNgPhdkRgx8HDFP55Z4y/Xw3FfBwH+oiyQgbiQ+oCR9Ovfkpt10f/aMUu3i/0/tu
 hR7Xsy2KDeSy5jJnbeBFnZLBvbqW1Gh7/zEdEZyA=
Date: Mon, 1 Apr 2024 21:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
 <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
Content-Language: en-US, de-DE
In-Reply-To: <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
From: Alexander Wetzel via ltp <ltp@lists.linux.it>
Reply-To: Alexander Wetzel <alexander@wetzel-home.de>
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 stable@vger.kernel.org, shuah@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 Bart Van Assche <bvanassche@acm.org>, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>,
 srw@sladewatkins.net, broonie@kernel.org, LTP List <ltp@lists.linux.it>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, rwarsow@gmx.de,
 pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> Following kernel warnings have been noticed on qemu-x86_64 while running LTP
> cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
> 6.8.3-rc1.
> 
> We have started bi-secting this issue.
> Always reproduced.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
> ------------[ cut here ]------------
> [   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
> sg_remove_sfp_usercontext+0x145/0x150
> [   36.609445] Modules linked in:
> [   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
> [   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> [   36.612872] Workqueue: events sg_remove_sfp_usercontext
> [   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150
> 
> <trim>
> 
> [   36.621539] Call Trace:
> [   36.621953]  <TASK>
> [   36.622444]  ? show_regs+0x69/0x80
> [   36.622819]  ? __warn+0x8d/0x150
> [   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
> [   36.623558]  ? report_bug+0x171/0x1a0
> [   36.623881]  ? handle_bug+0x42/0x80
> [   36.624070]  ? exc_invalid_op+0x1c/0x70
> [   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
> [   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
> [   36.625408]  process_one_work+0x141/0x300
> [   36.625769]  worker_thread+0x2f6/0x430
> [   36.626073]  ? __pfx_worker_thread+0x10/0x10
> [   36.626529]  kthread+0x105/0x140
> [   36.626778]  ? __pfx_kthread+0x10/0x10
> [   36.627059]  ret_from_fork+0x41/0x60
> [   36.627441]  ? __pfx_kthread+0x10/0x10
> [   36.627735]  ret_from_fork_asm+0x1b/0x30
> [   36.628293]  </TASK>
> [   36.628604] ---[ end trace 0000000000000000 ]---
> ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked
> 
> Suspecting commit:
> -----
> scsi: sg: Avoid sg device teardown race
> commit 27f58c04a8f438078583041468ec60597841284d upstream.
> 

Correct. The issue is already been worked on.

commit 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race") fixed a 
real issue. But also added an incorrect WARN_ON_ONCE(). Thus the scary - 
but otherwise harmless - error message.

Current patch fixing the broken commit is proposed here:
https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/

Sorry for the trouble,

Alexander


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
