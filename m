Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA6CC6FD1D
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 16:47:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDF233CCB8A
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 18:47:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095573CA2C2
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 18:46:58 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1052D200B86
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 18:46:57 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 49A59B829A3;
 Thu, 30 Mar 2023 16:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F2C4339B;
 Thu, 30 Mar 2023 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680194815;
 bh=73at8LX0eY5/IoqC6e2icmouP88OUCRH9vwcTYUccVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lEh1tb9lbMtgH2gwXpat+5S/GfdrniYBudXZiQPrFUO5RxhTilvcJC2krt7yerF/s
 8Y1LwNpRdk8lYPVDr2gtiO/959oahPVIPfGxpvWcQsb2ww5Rfre1lAHr9IxNRLCdeP
 GS5klBUGFhmt4UCwMoM/LnqP0F87YZ5SghqmTAxVCIisd89Ek+jou/rkktwWB3hMdw
 p90JMyemCQh5q3LTRRfRKMHbcEiAU73HRppChRbEtUEMLjPr1MMwQZ4rlQrl/sfu8+
 dHYMbV/1MugZ1KjWyKlmaE29s9DLC1z2LqxJNIr1rvkfeYr8qDcwljUG5QM0AwKNja
 +/UTTXv7c1frA==
Date: Thu, 30 Mar 2023 09:46:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230330164653.GA881@sol.localdomain>
References: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680164569-12114-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680164569-12114-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/statx10: Add basic test for
 STATX_DIOALIGN
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

Hi Yang,

On Thu, Mar 30, 2023 at 04:22:48PM +0800, Yang Xu wrote:
> diff --git a/testcases/kernel/syscalls/statx/statx10.c b/testcases/kernel/syscalls/statx/statx10.c
> new file mode 100644
> index 000000000..7a2c92ad2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx10.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * It is a basic test for STATX_DIOALIGN mask.
> + *
> + * - STATX_DIOALIGN   Want stx_dio_mem_align and stx_dio_offset_align value
> + *
> + * Minimum Linux version required is v6.1.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +
> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE "testfile"
> +
> +static int fd = -1;
> +
> +static void verify_statx(void)
> +{
> +	struct statx buf;
> +
> +	memset(&buf, 0, sizeof(buf));
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
> +
> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
> +		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
> +		return;
> +	}
> +
> +	if (buf.stx_dio_mem_align != 0)
> +		tst_res(TPASS, "stx_dio_mem_align:%u", buf.stx_dio_mem_align);
> +	else
> +		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");
> +
> +	if (buf.stx_dio_offset_align != 0)
> +		tst_res(TPASS, "stx_dio_offset_align:%u", buf.stx_dio_offset_align);
> +	else
> +		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
> +}

Thanks for writing a test for STATX_DIOALIGN!

However, the above code isn't actually a valid test, since stx_dio_mem_align and
stx_dio_offset_align will be 0 if the file doesn't support DIO.  This is
documented in the statx(2) manual page.  Filesystems aren't guaranteed to
support DIO, if they do, they aren't guaranteed to support it on all files.

I think you might be assuming that STATX_DIOALIGN won't be set in stx_mask if
DIO is unsupported on the file.  That's not quite correct.  If STATX_DIOALIGN is
not set, that just means the filesystem doesn't support STATX_DIOALIGN.  In that
case, DIO might or might not be supported on the file.  The filesystem just
isn't making a statement one way or the other.

I gave some thoughts on possible tests for STATX_DIOALIGN here:
https://lore.kernel.org/fstests/Y7fU4pRA+LHhsMKj@sol.localdomain/
Can you take a look at that?

Thanks,

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
