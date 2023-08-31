Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46189C83F10
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 12:42:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D4623CBF3C
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 14:42:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B7193CBDAC
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 14:42:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63068200242
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 14:42:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 353E51F8B0;
 Thu, 31 Aug 2023 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693485739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKjsOlHh+RYez9afTPyXYMvGy0u6lQ4pF9/lef3REWQ=;
 b=jpokvwDVy49+m5Ri+/owvedhbBiG7ueRAT/3wHWaDl2og9j5KgOzlh7zO+9ubhRkNtVB9p
 r3o5lChlLnZTFh47dcQjIfmxoBNpNZIN1Ud+HJLy9DH+ZIZfrQO6F+8LurrkozIFe5UnwV
 Y+dhdBTDLrRZItsiEpI+VrI2PfhWYkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693485739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKjsOlHh+RYez9afTPyXYMvGy0u6lQ4pF9/lef3REWQ=;
 b=XElduW5ja6z6CzbTpK9XW0ldRqT+2qcZOcfX7bNHbgDOc49MtTF/+zDLj3Q8zOwHAaDf4G
 lbSqmYeCFg9qgRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 231F613587;
 Thu, 31 Aug 2023 12:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n16aB6uK8GT+BQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 31 Aug 2023 12:42:19 +0000
Date: Thu, 31 Aug 2023 14:42:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZPCKzdDjSKzFayv_@yuki>
References: <20230831112629.21510-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230831112629.21510-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap21: Add new test for mmap's ENOMEM
 case
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> To be more precise in this test and checking for ENOMEM on exact mapping
> when limit is crossed, I could only think of counting the existing
> mappings from /proc/$pid/maps and counting the remaining possible
> mappings. Is there any better approach if we want to test this for exact
> case?

If you want to check that we managed to create exactly the amount of
mappings in this limit, this would be a sensible way to do that.

However beware that this also depends on the overcommit settings. If
kernel is not set to overcommit and if the size of the memory needed to
cross the maximal number of mappings would exceed available memory you
would get ENOMEM before you manage to hit the limit. With overcommit
enabled you can create mappings as long as the kernel has enough memory
to hold the vma structures.

At my system the limit is set to 65530 which on 4k page size would
consume around 300MB, which does not seem to be much, but may still fail
on small embedded boards with disabled overcommit. So either we try to
set the limit to a lower value for the duration of the test, or allow
the mmap() to fail sooner if we find that available memory is close to
or smaller than number of mappings multiplied by page size.

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/mmap/mmap21.c | 70 +++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap21.c
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
> new file mode 100644
> index 000000000..76002edb3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap21.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that, mmap(2) fails with errno ENOMEM when process's
> + * maximum number of mappings would have been exceeded.
> + */
> +
> +#include <stdio.h>
             ^
I do not think that this is needed, or is ti?

> +#include "tst_test.h"
> +
> +#define TEMPFILE "mmapfile"
> +static int fd;
> +static size_t page_sz;
> +static int max_map;
> +
> +static void setup(void)
> +{
> +	page_sz = getpagesize();
> +
> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);

I guess that we can simplify the test by mapping anonymous memory and
get rid of the needs_tmpdir and file creation.

> +	SAFE_FILE_SCANF("/proc/sys/vm/max_map_count", "%d   ", &max_map);
> +	tst_res(TINFO, "max_map_count: %d", max_map);
> +}
> +
> +static void run(void)
> +{
> +	int i;
> +	char *addr[max_map];
> +
> +	for (i = 0; i < max_map; i++) {
> +		TESTPTR(mmap(0, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
                             ^
			     Again since this is an address, it is better to be NULL.

> +		if (TST_RET_PTR != MAP_FAILED) {
> +			addr[i] = TST_RET_PTR;
> +		} else {
> +			if (TST_ERR == ENOMEM) {
> +				tst_res(TINFO, "New successful mappings before exhausting the limit: %d", i);
> +				tst_res(TPASS, "mmap() failed with ENOMEM");
> +			} else {
> +				tst_res(TINFO, "New successful mappings before mmap() failed: %d", i);
> +				tst_res(TFAIL | TERRNO, "mmap() failed with unexpected errno");
> +			}
> +			break;
> +		}
> +	}
> +
> +	if (i == max_map)
> +		tst_res(TFAIL, "mmap() crossed max_map_count limit, no of new mmapings: %d", i);
> +
> +	while (--i >= 0)
> +		SAFE_MUNMAP(addr[i], page_sz);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1
> +};
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
