Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC85C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 10:15:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FBCB3C9FDC
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 12:15:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41EBC3C9427
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 12:15:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0BC5C14010D0
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 12:15:10 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E7ECC1FAF4;
 Tue, 26 Jul 2022 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658830508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/52vnJwmCFqxgq8nIhqpjC8IyDNhc5gj8aJ8It+lgao=;
 b=0oDvtKj4l2EMEEeHpRoreytZ8mYhNO1W49jbU3R8X+52zdBsxxCJKi1s58Zx0wy/pZo4JM
 kBpgoop8qb3K5oOEA7VxknYGEct0JA2jEDdyMThmEiNDxTazSqUOEbIBQ/5t3xeDTdXr9I
 uiwYj1YEdsBPSMQZ/UXQXKa+8kcSSeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658830508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/52vnJwmCFqxgq8nIhqpjC8IyDNhc5gj8aJ8It+lgao=;
 b=vWnBI9EYHDH/pFKqtV65YheSQ19rIQiCxlgvShBLSAiO4BVZsbhiQ6h3rJv99AEc0QT2Jp
 ZJYCcot6yWrxBfBQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AB0282C15D;
 Tue, 26 Jul 2022 10:15:08 +0000 (UTC)
References: <1658732564-31728-1-git-send-email-liaohj.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Liao Huangjie <liaohj.jy@fujitsu.com>
Date: Tue, 26 Jul 2022 10:52:23 +0100
In-reply-to: <1658732564-31728-1-git-send-email-liaohj.jy@fujitsu.com>
Message-ID: <87czds41ub.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/read05: Test read with zero count
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Liao Huangjie <liaohj.jy@fujitsu.com> writes:

> From: Huangjie Liao <liaohj.jy@fujitsu.com>
>
> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
> ---
>  runtest/syscalls                          |  1 +
>  testcases/kernel/syscalls/read/.gitignore |  1 +
>  testcases/kernel/syscalls/read/read05.c   | 44 +++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/read/read05.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3847e8a..0bd47fc 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1094,6 +1094,7 @@ read01 read01
>  read02 read02
>  read03 read03
>  read04 read04
> +read05 read05
>  
>  readahead01 readahead01
>  readahead02 readahead02
> diff --git a/testcases/kernel/syscalls/read/.gitignore b/testcases/kernel/syscalls/read/.gitignore
> index e89c008..69d97b3 100644
> --- a/testcases/kernel/syscalls/read/.gitignore
> +++ b/testcases/kernel/syscalls/read/.gitignore
> @@ -2,3 +2,4 @@
>  /read02
>  /read03
>  /read04
> +/read05
> diff --git a/testcases/kernel/syscalls/read/read05.c b/testcases/kernel/syscalls/read/read05.c
> new file mode 100644
> index 0000000..83ac763
> --- /dev/null
> +++ b/testcases/kernel/syscalls/read/read05.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All Rights Reserved.
> + * Author: Huangjie Liao <liaohj.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * In the absence of any errors, a read() with a count of 0 returns
>  zero.

This test is quite similar to read04. You could modify that test to read
multiple times from 0 bytes to the total number of bytes available.

> + */
> +
> +#include <errno.h>
> +#include "tst_test.h"
> +
> +#define SIZE 512

This could be set to 2*getpagesize() at runtime. Then you can try
reading every length between 0 and 2*getpagesize().

Errors tend to be made on page boundaries and similar.

> +
> +static int fd;
> +static char buf[SIZE];
> +
> +static void verify_read(void)
> +{
> +	TST_EXP_VAL(read(fd, buf, 0), 0);
> +}
> +
> +static void setup(void)
> +{
> +	memset(buf, '*', SIZE);
> +	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
> +	SAFE_WRITE(1, fd, buf, SIZE);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_read,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,

It would increase test coverage greatly to run this on all filesystems
(i.e. set .all_filesystems = 1). For an example see rename10.

> +};
> -- 
> 1.8.3.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
