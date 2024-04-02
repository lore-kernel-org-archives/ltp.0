Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B337CD1284
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 12:00:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40A2D3CCDE9
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 14:00:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CA083CC624
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 12:37:55 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2AF3600731
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 12:37:54 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c583f5381so6583632a12.1
 for <ltp@lists.linux.it>; Tue, 02 Apr 2024 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712054274; x=1712659074; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jz9Y9PjigYVKEbCw1GNYP1RDI4ZuVwZ4udJg2a4ZlkM=;
 b=W/rOR8ZtKctU6b30FXI+fhqn4BN34TjOMSOw5dlVj06Ujl2651IkqOS1+JyrxHmXA3
 LbtNmkx5nV53XjQgmGBbNSDJzJSbKhVdpCVErx/wWX7B5/i4aDNnQskDO2MljWl/gyEx
 G++aw7m0HI0AtHhfAOhRzlPRDfKzVcbcHyO4O0/NBqE2ZQjtRMB9G3rMti8pXRSr/Dni
 xYiXzP2HnI3oHnpS8/8wXgxiq/K/+VHhWK1zcaaq2rADjd8Oh7kP21csb8EmA7Oe1jW1
 kK8ZxKCuPhIlDJFOu0EU1MbwUGaN32H3IejCJyjeG8CdrjPLdXR6bLfss5hLeFUEAAGu
 HNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712054274; x=1712659074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jz9Y9PjigYVKEbCw1GNYP1RDI4ZuVwZ4udJg2a4ZlkM=;
 b=RAck7Dv6Ztco/rAjdAkeV51bju2KR3YVSah/Qz9hXRvwofMvLpcCx2ciD7a6Zhpu/T
 zo+tQcGKzKgkDLgR0UfRnWR/AEv4ocsCeQlJj5xQNm1LpJzZUXpgVYcsNHlDThxqUdsj
 JGMBdeQtUZYil4/rSLpIywfTsC+8Nc1KeU2WnmvVSZWesCU1+HBmyT8g1tgVveucNqbT
 s90kehljj9qFOOR0x7JhX9dBWQuM9egVKBbuvSzd+IF4f3K+hZV2/k2BXUE4Yh9y8/OZ
 FbQBbS//q71ztG+azjfWL1hfyL9/RGbx+zsF2+ECXQTs6qFZKamB2bxUZRssHdVffU9J
 QpvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3n4y3XZc1mCv+Vygnfk0V7W2CQ2okdun+MOKeivGNKJvb6Dz1u/Wpzllxof02KXrJckqwW7dE+RXHiEHmktpD9c4=
X-Gm-Message-State: AOJu0YxlRKkZPplk6fbpPT5Zx8bw/FVauLeZrN5KVr9olewnXF12ysRF
 CzxNOA+07+gQTiTDu6BAOTNSHsmcO/JgQLfL4QMyJNJpbUcYIS7de2gEcNc+ZMM=
X-Google-Smtp-Source: AGHT+IFLXanUhL+rTkL5dhPieUFNxekE62yhWKGrRFO2Vdc9oBu4cKCdI7vD6zG/l7HO+KOWLoErNA==
X-Received: by 2002:a50:d5c8:0:b0:568:aced:e5a0 with SMTP id
 g8-20020a50d5c8000000b00568acede5a0mr13872744edj.14.1712054274194; 
 Tue, 02 Apr 2024 03:37:54 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 k7-20020aa7c047000000b0056c443ce781sm6591488edo.85.2024.04.02.03.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:37:53 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:37:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <1d1071f3-641a-4b7c-bd35-a629ba8d5a7b@moroto.mountain>
References: <20240401152547.867452742@linuxfoundation.org>
 <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
 <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Apr 2024 13:59:52 +0200
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
 stable@vger.kernel.org, shuah@kernel.org, f.fainelli@gmail.com,
 Bart Van Assche <bvanassche@acm.org>, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>,
 srw@sladewatkins.net, broonie@kernel.org, LTP List <ltp@lists.linux.it>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, rwarsow@gmx.de,
 pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
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

If you have Reboot on Oops turned on (apparently Android enables this)
then WARN() will reboot the system so it can be pretty annoying.

regards,
dan carpenter


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
