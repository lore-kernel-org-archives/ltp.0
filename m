Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540AFC27C52
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717714806; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=w/VUTpaXLSE5Fg4xygzrkYNKiJRY78b2T+0geojZi+s=;
 b=p92bDNh3d7dvJq27hbycWonojRidZjwnp0cXQGHM8h/O6o6cMODqv7GsjTnAbq35ToMIV
 Z+OQYhCC6JNfj/V15fkRcYqPUCWQrkh/u19i7bB3EgZaKPUIsIxjWYHspFJ7GT0jHmLJYTb
 KVVSyFocdx2usb2xQzFX1rE7H0RwSf8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740253D0A78
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 01:00:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B24363C132A
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 00:59:43 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62B2C100204D
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 00:59:42 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e73441edf7so16039111fa.1
 for <ltp@lists.linux.it>; Thu, 06 Jun 2024 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717714781; x=1718319581; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=my2+voFpi6SWYsR2Ly3Ds0PRJR2B3iD+KAYe8Z/VjzQ=;
 b=Kdpke9qFMy+qTYDg0hkn1txuwGMPzCGfA+twM/iB7201o4a3QYiNcpfA/e6NPvHd2J
 b4NrQaYqEv+Z7ruM5N5NtchjuTyE81PP77CQT3+7O+9VidztEGTGnsQzpY6xFg7wJSPb
 z06OxCxP3nM8Fd5VI54d0BTnfNg9xHly688k4yM5jrvzYfvt40Dy1eMwAhiTeSk2+k9Q
 epXXFzJjus15NuAOTLnIhAj5P6V6DSwYIVmovH/0MhyJWcx+ReKMKhKLHUSeoi+RLCLC
 dh5lU/i+yL9d8D2udfPVMqGD9cFGOxaGanZPJd8doO+jli9/YYuei6Cn9I4ChkTt/vPx
 EC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717714781; x=1718319581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=my2+voFpi6SWYsR2Ly3Ds0PRJR2B3iD+KAYe8Z/VjzQ=;
 b=E/aJn5bx7eIq5H0oPqYUKq2E6Ns6iupr8eZRWlCQ1DBVBuSqaHIqDxY/RuuLtPkGMk
 RVoiHg9KiAuiGEDIVUN1BriBpXXuf+Hcr2q7teqq93tg0cd6lvMJJM6GcvRazPwcXo07
 FN0+AUOy4Ig2GoXkoENysXikBgL7NuXmmNXvGiu2SKRObbaA/9tKNTpNVstjWGutnI+u
 qNRT/oCBxYhIRnpL4CVUuxk0bheXyQWoiH+qO24bstBgYa9aPB8/minwP5fz9a8Fi/j7
 qFMR0QJZ4v3V8oKecIQCiEYa9Wq2/6VAcczlwICgzwtuHLJwPKaa7ogTl/2LVKh+97Cj
 P82g==
X-Gm-Message-State: AOJu0Ywa/GJdA+qjDzbFq5h1yDURqfLTTkXN3/FsCcsodIeFmZabJfIN
 tyRWFTbvcsuQsmlA8GG68ccEHB2nyuFZm6ufCs1LWkBJ0GeJN8Yn7ezqeFERiwArjh9QQK/n+yc
 =
X-Google-Smtp-Source: AGHT+IFXYH4sTqmGHWXZs4SSqJpBCYbHstoq/W4/Jzz7yOLmG7UdlGfU4Jpc0k4DfHieNbXC/nkddg==
X-Received: by 2002:a2e:88c6:0:b0:2ea:8291:c667 with SMTP id
 38308e7fff4ca-2eadce24b75mr5441281fa.13.1717714781469; 
 Thu, 06 Jun 2024 15:59:41 -0700 (PDT)
Received: from wegao.75.89.121 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7ec539sm20656495ad.238.2024.06.06.15.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 15:59:41 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:59:31 -0400
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZmI/U99dR9MC2HKF@wegao.75.89.121>
References: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
 <20240605-unlink09-v2-2-bfa0bbdc8753@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605-unlink09-v2-2-bfa0bbdc8753@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add unlink10 test
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jun 05, 2024 at 04:40:39PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> This test verifies that unlink(2) fails with EROFS when target file
> is on a read-only filesystem.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/unlink/.gitignore |  1 +
>  testcases/kernel/syscalls/unlink/unlink10.c | 33 +++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index cf06ee563..b59b64314 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1655,6 +1655,7 @@ unlink05 unlink05
>  unlink07 unlink07
>  unlink08 unlink08
>  unlink09 unlink09
> +unlink10 unlink10
>  
>  #unlinkat test cases
>  unlinkat01 unlinkat01
> diff --git a/testcases/kernel/syscalls/unlink/.gitignore b/testcases/kernel/syscalls/unlink/.gitignore
> index 6038cc29d..4fc24059a 100644
> --- a/testcases/kernel/syscalls/unlink/.gitignore
> +++ b/testcases/kernel/syscalls/unlink/.gitignore
> @@ -2,3 +2,4 @@
>  /unlink07
>  /unlink08
>  /unlink09
> +/unlink10
> diff --git a/testcases/kernel/syscalls/unlink/unlink10.c b/testcases/kernel/syscalls/unlink/unlink10.c
> new file mode 100644
> index 000000000..861f24a50
> --- /dev/null
> +++ b/testcases/kernel/syscalls/unlink/unlink10.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that unlink(2) fails with EROFS when target file is on a read-only
> + * filesystem.
> + */
> +
> +#include <sys/ioctl.h>
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +
> +#define MNTPOINT "erofs"
> +#define FILENAME MNTPOINT"/file"
> +
> +static void run(void)
> +{
> +	TST_EXP_FAIL(unlink(FILENAME), EROFS,
> +		"%s", "target file in read-only filesystem");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_rofs = 1,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +};
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
