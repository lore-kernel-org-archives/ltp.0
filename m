Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4986C35FFF
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742552878; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=i5TGU845Ku99XtKDKNazK9usoS8IEatkc9pHfK6FQwE=;
 b=aefF26DdF5r0y5qhqIkNa3ds6PSUih2VnjYbdAfDvi/h0FhOyZ/bljrLziMOsic9KgtQc
 /K28+qXAUY1TCi2wLoHb/YwyjprYVp5iOSYKi8BhkcvkHHe6HzSAyosQt3+qScpZXT99m4x
 hjwD1/xLDctPMzS5ZSPOfXrHc0o4ucQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 440203CAEF9
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 11:27:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 0E5DB3CAE81
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 11:27:36 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with UTF8SMTPS id 103211A008BB
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 11:27:36 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1507988f8f.3
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 03:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742552855; x=1743157655;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WyCfrHPUc3V08SLwCKuPi2WkEyFdHf3GxKeN5GKyBJo=;
 b=tCJ6XlElp+qGblWDipDizN2C0Yq4Qp40I+xEeVgIKmEiXCczsOWk4I7Ifan0BetW8X
 asilvvT9BEG97qv9NeP/oca6ReeeZXh5TEFI7HFHy4nvm+3l/vudT6jd1zbHyj1d8CoJ
 DLGEYLH0Pz5FaKo1JfzUqrJ2Krzh1Ogd7/TDQhI+9WKcayZ7vXwstTWwvTaJDhcD+i31
 1YicfoQRF/99S29AcMPNPQ4vIUGZPUC7gz9QZhsCfNZkN+SxT9MsQLoWhjQCpILSrkYi
 nXfXFPUjYqaG1NdvkLokgtYZgYTytQmUzDM0Ca0r3kRJEHRY8KZXLeSprK81asWdBO34
 JQwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZtxfuAyN4jlaZ5+HWCzlAxkAWr3S+JFrf6q02aXqPnxJHsF22KhH0i3SLVeLzFUu2PTI=@lists.linux.it
X-Gm-Message-State: AOJu0YzUzHQp4CxNGM/4hmzb2AxS3zGbuH8k4k6h+XXkPo/azuId39JG
 QmLaeqYqXz2kW5D6VRrcB1EXSVwcgJwsi8J9GiLSDIhqdZqGKuZhDw7akN/FdzM=
X-Gm-Gg: ASbGncuh1aPgjZJRAIJppYEhHcZDUBrNFw7SIyq+F+2T8CAfqpzTjjBRPCic+Sch//m
 YGdt+aWwTCeJI3+GTzjnczp8IPyRVMBNAN9yWTMNEv6O5F3B1u4qg/VdJHt7mHki0XYbRw7cz8K
 o7VWyYEvx3aqzr7Ucf8CopkDOP+zJEWYnN9zNcymIvMZepa4y/q2ii8iH8sIN/0iAG8IQNYB4st
 PCa0NDZDKeeek4TAB7qv6HnKmJwUGEm9P+tbKSKH8dvuVXnnN+jq1i889wlS0M806FlQnwTAKny
 4L+RBPqspaAE/10y+haancrn5drDKIzyNw==
X-Google-Smtp-Source: AGHT+IEArPWjVKT+8IYZaAEEEBpBE6cOIELfG3myXhJ8L/5dx5nrZwDkJN2ovQaNgsfEOzwRfvpyBQ==
X-Received: by 2002:a05:6000:188e:b0:391:31c8:ba59 with SMTP id
 ffacd0b85a97d-3997f8f26b5mr2124481f8f.4.1742552855275; 
 Fri, 21 Mar 2025 03:27:35 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da668sm12941615ad.188.2025.03.21.03.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 03:27:34 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 21 Mar 2025 07:27:30 -0300
Message-Id: <D8LVFKC4QOWX.2OMOXDM6U0MQH@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250319044750.19434-1-wegao@suse.com>
 <20250321034248.3501-1-wegao@suse.com>
In-Reply-To: <20250321034248.3501-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mount08.c: Restrict overmounting of ephemeral
 entities
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri Mar 21, 2025 at 12:42 AM -03, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

This is still wrong. :(

>
> Add a new test to verify that mount will raise ENOENT if we try to mount
> on magic links under /proc/<pid>/fd/<nr>.
> Refer to the following kernel commit for more information:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  runtest/syscalls                           |  1 +
>  testcases/kernel/syscalls/mount/.gitignore |  1 +
>  testcases/kernel/syscalls/mount/mount08.c  | 57 ++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mount/mount08.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ded035ee8..d3abc8b85 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -852,6 +852,7 @@ mount04 mount04
>  mount05 mount05
>  mount06 mount06
>  mount07 mount07
> +mount08 mount08
>  
>  mount_setattr01 mount_setattr01
>  
> diff --git a/testcases/kernel/syscalls/mount/.gitignore b/testcases/kernel/syscalls/mount/.gitignore
> index 80885dbf0..3eee5863a 100644
> --- a/testcases/kernel/syscalls/mount/.gitignore
> +++ b/testcases/kernel/syscalls/mount/.gitignore
> @@ -6,3 +6,4 @@
>  /mount05
>  /mount06
>  /mount07
> +/mount08
> diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
> new file mode 100644
> index 000000000..1938c5519
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount/mount08.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Verify that mount will raise ENOENT if we try to mount on magic links
> + * under /proc/<pid>/fd/<nr>.
> + */
> +
> +#include "tst_test.h"
> +#include <sys/mount.h>
> +#include "tst_safe_file_at.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FOO MNTPOINT "/foo"
> +#define BAR MNTPOINT "/bar"
> +
> +static void run(void)
> +{
> +	char path[PATH_MAX];
> +	int foo_fd, newfd, proc_fd;
> +
> +	foo_fd = SAFE_OPEN(FOO, O_RDONLY | O_NONBLOCK, 0640);
> +	newfd = SAFE_DUP(foo_fd);
> +	SAFE_CLOSE(foo_fd);
> +
> +	sprintf(path, "/proc/%d/fd/%d", getpid(), newfd);
> +
> +	proc_fd = SAFE_OPENAT(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> +
> +	sprintf(path, "/proc/%d/fd/%d", getpid(), proc_fd);
> +
> +	TST_EXP_FAIL(
> +		mount(BAR, path, "", MS_BIND, 0),
> +		ENOENT,
> +		"mount() on proc failed expectedly"
> +	);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_CREAT(FOO, 0777);
> +	SAFE_CREAT(BAR, 0777);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.min_kver = "6.12",
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "d80b065bb172"},
> +		{}
> +	}
> +};


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
