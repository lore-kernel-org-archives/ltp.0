Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D19CD1284
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 09:22:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3E3E3CD09F
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 11:22:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 455173C8658
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 09:51:17 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A61741400C48
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 09:51:16 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5D65360ED4;
 Tue,  2 Apr 2024 07:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6CEC433C7;
 Tue,  2 Apr 2024 07:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1712044274;
 bh=dhWigLLIcz+WQD+U4cGPhrHKZup43HIU9h/Q0qIlO4M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ryIaugh69IdHZn2ILN3LOgMpV1zNUdpwoqMIpewtUwU+l+O5H4uZRgjA/2VUc126j
 uEZdcxlWK+OSuN7xkGFXc6ON6TV7CdVioYNodJ8A7rr7DtawJeJ4IprWizLCBnTm1Q
 /wBo1LvihwptoT+tBqsi3lVig0KPe3Phu+wncZzo=
Date: Tue, 2 Apr 2024 09:51:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <2024040257-slackness-composer-9696@gregkh>
References: <20240401152547.867452742@linuxfoundation.org>
 <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
 <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
 stable@vger.kernel.org, shuah@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 Bart Van Assche <bvanassche@acm.org>, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>,
 srw@sladewatkins.net, broonie@kernel.org, LTP List <ltp@lists.linux.it>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, rwarsow@gmx.de,
 pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Apr 01, 2024 at 09:22:52PM +0200, Alexander Wetzel wrote:
> 
> > Following kernel warnings have been noticed on qemu-x86_64 while running LTP
> > cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
> > 6.8.3-rc1.
> > 
> > We have started bi-secting this issue.
> > Always reproduced.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
> > ------------[ cut here ]------------
> > [   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
> > sg_remove_sfp_usercontext+0x145/0x150
> > [   36.609445] Modules linked in:
> > [   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
> > [   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > [   36.612872] Workqueue: events sg_remove_sfp_usercontext
> > [   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150
> > 
> > <trim>
> > 
> > [   36.621539] Call Trace:
> > [   36.621953]  <TASK>
> > [   36.622444]  ? show_regs+0x69/0x80
> > [   36.622819]  ? __warn+0x8d/0x150
> > [   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
> > [   36.623558]  ? report_bug+0x171/0x1a0
> > [   36.623881]  ? handle_bug+0x42/0x80
> > [   36.624070]  ? exc_invalid_op+0x1c/0x70
> > [   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
> > [   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
> > [   36.625408]  process_one_work+0x141/0x300
> > [   36.625769]  worker_thread+0x2f6/0x430
> > [   36.626073]  ? __pfx_worker_thread+0x10/0x10
> > [   36.626529]  kthread+0x105/0x140
> > [   36.626778]  ? __pfx_kthread+0x10/0x10
> > [   36.627059]  ret_from_fork+0x41/0x60
> > [   36.627441]  ? __pfx_kthread+0x10/0x10
> > [   36.627735]  ret_from_fork_asm+0x1b/0x30
> > [   36.628293]  </TASK>
> > [   36.628604] ---[ end trace 0000000000000000 ]---
> > ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked
> > 
> > Suspecting commit:
> > -----
> > scsi: sg: Avoid sg device teardown race
> > commit 27f58c04a8f438078583041468ec60597841284d upstream.
> > 
> 
> Correct. The issue is already been worked on.
> 
> commit 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race") fixed a real
> issue. But also added an incorrect WARN_ON_ONCE(). Thus the scary - but
> otherwise harmless - error message.
> 
> Current patch fixing the broken commit is proposed here:
> https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/

I will drop the offending commit from all queues now, thanks.

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
