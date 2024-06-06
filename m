Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA650C27C52
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717711894; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=w/VUTpaXLSE5Fg4xygzrkYNKiJRY78b2T+0geojZi+s=;
 b=IfAxwt4mIvOChFN+3MGUoi9DLg1tNLBzOgNFq+IOSXivbS2uXXQfpLIZ6TS6fq65DtPfo
 sUDwyrr7yfcHUBUOATLalwW7mzvgoXNv9f1j3mtunBWqCYvD70TsRWHYrRuW5mW8xg8V1v/
 prrJXqmw3XPzRdcYePyK7E8dKLX+qoc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EBDA3D0A82
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 00:11:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575353CFB5A
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 00:11:10 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B1A131400DE5
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 00:11:09 +0200 (CEST)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso18459271fa.3
 for <ltp@lists.linux.it>; Thu, 06 Jun 2024 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717711869; x=1718316669; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=my2+voFpi6SWYsR2Ly3Ds0PRJR2B3iD+KAYe8Z/VjzQ=;
 b=bcEhihjNNwoO0tLf/XLl+H6y6p7K7zMh/kek+rNFkBjk/69TRPnpNGEhQrY+0D7p/N
 QkzXiD0A/klADmFS4hOdE7tGP0l7KNx553fywIbqdRio5Dki1FeYZ8AuNRoH4wKnUPjX
 8yUxWbZ2hSNtkjOT1741LqkTXl4to/4W+962g9ImtG7RZC3agR19rQR8Yr7o8/wyb6F4
 Oz2D/JQwOyqla4T/Aa+H+T7MC/VLAXFUz92JTgKC4kjcFiy+hujcqNlz5vjQ5soo5K1C
 61b6Dpmnk1S/bDcJInaIkpWb/xtF8R2xya/gTG0SFOsy5CavjCcjsV6PPMjA3+MoZXGR
 sZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717711869; x=1718316669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=my2+voFpi6SWYsR2Ly3Ds0PRJR2B3iD+KAYe8Z/VjzQ=;
 b=fu9osAFwCGrjrs+cIu+A3r2wpBLXkwmtWsg0ETeJPixvnDk19/wgQNOYd5xan7ETxU
 Z9IH5oBbx1amBeVaO/VbDUeERYAVqxS+UQJOH5I5IjZ7xaJJMZq6kysfxUa6eCNgdebE
 xeqXp1q0DTf6763xGoku7JaPL3x3Na1l6FsOP/GOwOn1tU2hXimEpatBJoG2czrP76DK
 i1HswPbpqhcU0A4/0wO28OA8VmJDVK9xsXFr0E7dMbXYaMlVr9vjXvFIlGqB0pbr9+VH
 NjbA9lLR0kEHV22j7KgGEefKeoQQeZelRvZu2B/LAfZ1fj0VP8PpfUp2RdnV0toRCLbu
 1KXg==
X-Gm-Message-State: AOJu0YxE2/egY5nMSNg+n0YoTHMNn72aFOfijUtT2oEVP51mw4RPWoj9
 eheojj1m5kA48d6ffqKM9+TR82eebAbfav9flFT10Snl9MAqFRrnYLnWZ2yRnw==
X-Google-Smtp-Source: AGHT+IHdsGVXzdwSK1SsXUy85cheSX4Css/i8dlUaKYEVoohYyzl34s/AUUymuMw9ypaVWcUL+RfIw==
X-Received: by 2002:a2e:8750:0:b0:2ea:7d8f:8d12 with SMTP id
 38308e7fff4ca-2eadce91435mr4918271fa.48.1717711868838; 
 Thu, 06 Jun 2024 15:11:08 -0700 (PDT)
Received: from wegao.165.26.231 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76b206sm20299965ad.65.2024.06.06.15.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 15:11:08 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:10:59 -0400
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZmIz80094UsKTbv2@wegao.165.26.231>
References: <20240605-unlink09-v2-0-bfa0bbdc8753@suse.com>
 <20240605-unlink09-v2-2-bfa0bbdc8753@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605-unlink09-v2-2-bfa0bbdc8753@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
