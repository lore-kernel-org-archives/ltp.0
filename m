Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F22C64EC7
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 10:36:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4448D3CBB82
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 11:36:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9632B3CAFC8
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 11:35:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E36D60070B
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 11:35:49 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8FFC21FDC2;
 Tue, 28 Feb 2023 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677580548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iIOV0UEw/bdJa+oTNdssMwGCgaYOAnbMq0ZODa5vjak=;
 b=bqF0OWNViecA8IrzPUiwYUcWzCv8EsmxERyP7DxNd/Z3tU/1szVCd7d7zC7lEHyYXpMQvK
 OWbar1hKho5cYrHhgbz2Xp4/h1dJlwvHMGZmreWXKBr7eGIJayw/6y9tkY3vu9uVPm/722
 NTjFOw6B3PBSZPJRD50JLv6g25mWdZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677580548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iIOV0UEw/bdJa+oTNdssMwGCgaYOAnbMq0ZODa5vjak=;
 b=d6NgeFcnVzp5ZnhExHFyU2VycOrS56vhJ44O90856AB/UYeYIIoedp5WBSIs1a5GHYu4NB
 UAfJIvCQLuz9m6AA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 64E852C141;
 Tue, 28 Feb 2023 10:35:48 +0000 (UTC)
References: <CA+O3cCQk5CEKTqdCkHnMmAwqWF8ePeGOOuHXKBMPqsqwvv7ihA@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Paulson Raja L <lpaulsonraja@gmail.com>
Date: Tue, 28 Feb 2023 10:20:40 +0000
Organization: Linux Private Site
In-reply-to: <CA+O3cCQk5CEKTqdCkHnMmAwqWF8ePeGOOuHXKBMPqsqwvv7ihA@mail.gmail.com>
Message-ID: <871qmaulfg.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] RFC:[PATCH v1] Added testcase to test mmap with
 MAP_SHARED_VALIDATE flag
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

In principal the test is good, you can remove the RFC.

Please see comments below (in addition to Cyril's).

Paulson Raja L <lpaulsonraja@gmail.com> writes:

> This patch adds a new test case for mmap syscall. It tests the
> MAP_SHARED_VALIDATE flag of mmap. The code checks of the
> MAP_SHARED_VALIDATE flag return EOPNOTSUPP when mapped with an invalid flag
> value. It does so by setting the unused bits of the flag argument.

Would it be possible to use two incompatible flags together instead?

Unused flags can become valid at a later date.

>
> Signed-off-by: Paulson Raja L. <lpaulsonraja@gmail.com>
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap20.c
> b/testcases/kernel/syscalls/mmap/mmap20.c
> new file mode 100644
> index 000000000..2f6dd5d4d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap20.c
> @@ -0,0 +1,61 @@
> +//SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Test mmap with MAP_SHARED_VALIDATE flag
> + *
> + * We are testing the MAP_SHARED_VALIDATE flag of mmap() syscall. To check
> + * if there is an invalid flag value, the MAP_SHARED_VALIDATE return
> + * EOPNOTSUPP. The unused bit in the MAP_SHARED_VALIDATE is found, and by
> + * setting the unused bits of the flag argument the flag value becomes
> + * invalid and the error EOPNOTSUPP is produced as expected.
> + */
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <linux/mman.h>
> +#include <errno.h>
> +#include "tst_test.h"
> +
> +#define TEST_FILE "file_to_mmap"
> +#define TEST_FILE_SIZE 1024
> +#define TEST_FILE_MODE 0600
> +
> +static int fd_file;
> +static void *mapped_address = NULL;
> +
> +static void setup(void)
> +{
> + fd_file = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, TEST_FILE_MODE);
> + if (tst_fill_file(TEST_FILE, 'a', TEST_FILE_SIZE, 1))
> + tst_brk(TBROK, "Could not fill the testfile.");
> +}
> +
> +static void cleanup(void)
> +{
> + if (fd_file > 0)

It's unlikely, but possible that fd_file is 0, so it should be
initialised to -1 and we check it is > -1.

> + SAFE_CLOSE(fd_file);
> + if (mapped_address != NULL && mapped_address != MAP_FAILED)
> + SAFE_MUNMAP(mapped_address, TEST_FILE_SIZE);
> +}
> +
> +static void test_mmap(void)
> +{
> + mapped_address = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
> +      (1 << 7) | (1 << 9) | MAP_SHARED_VALIDATE, fd_file, 0);

The TEST macro can be used here, which will set errno=0. Possibly errno
is already set to some previous error. (also note you need to then use
TTERRNO below)

> + if (mapped_address != MAP_FAILED)
> + tst_res(TFAIL | TERRNO, "mmap() is successful, but it should have
> failed.");
> + else if (errno == EOPNOTSUPP)
> + tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP.");
> + else
> + tst_res(TFAIL | TERRNO, "mmap() failed with unexpected error.");
> +}
> +
> +static struct tst_test test = {
> + .min_kver = "4.15",
> + .setup = setup,
> + .cleanup = cleanup,
> + .test_all = test_mmap,
> + .needs_tmpdir = 1,
> +};



-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
