Return-Path: <SRS0=1KVt=O3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A5AC433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 11:54:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1226124A
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 11:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D1226124A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCB6C3C7AC5
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 13:54:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EAE93C1423
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 13:53:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 917171A005FF
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 13:53:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96D161FD78;
 Thu,  7 Oct 2021 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633607632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLL77BH3lPRb5yVbGWDmL84mbC0Kd0bv7qibbCdIUXw=;
 b=VFI91tvF1xuN9NSjdsYg4Xh0AB8lTbvS7pe+sgznnx75vPoOuy28P2z95nyr1d3XpyH9Qf
 HZOoPYlLrfVHtftPDR1LKG+v9A/TdmFGjWBpZBDBGkzDlnuT3FelK70yq0Y7+w7ey5U3D9
 3yOqaxphVNjjmEFao5oiqAyBgJYiST0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633607632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLL77BH3lPRb5yVbGWDmL84mbC0Kd0bv7qibbCdIUXw=;
 b=R5q1JMfAPHRfJN+Sk60Egnvcwf/gL2KYkjmah9ltthXeUmTNUG7qPW6ZbRi7/DcrVvULOB
 K5JUkfrpEI9+sRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DA5113B39;
 Thu,  7 Oct 2021 11:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AyIEHtDfXmFxfwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 07 Oct 2021 11:53:52 +0000
Date: Thu, 7 Oct 2021 13:54:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YV7f8yhhvy7L9YIX@yuki>
References: <20210929083249.22320-1-zhanglianjie@uniontech.com>
 <20210929083249.22320-2-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210929083249.22320-2-zhanglianjie@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/readdir21: Convert to new API
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

On Wed, Sep 29, 2021 at 04:32:49PM +0800, zhanglianjie wrote:
> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> 
> diff --git a/testcases/kernel/syscalls/readdir/readdir21.c b/testcases/kernel/syscalls/readdir/readdir21.c
> index 205e0715b..1bc3cc199 100644
> --- a/testcases/kernel/syscalls/readdir/readdir21.c
> +++ b/testcases/kernel/syscalls/readdir/readdir21.c
> @@ -1,20 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2014 Fujitsu Ltd.
>   * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
> -/*
> +
> +/*\
> + * [Description]
> + *
>   * Test Description:
>   *  Verify that,
>   *   1. Creat a directory and open it, then delete the directory, ENOENT would
> @@ -23,28 +15,16 @@
>   *   3. Invalid file descriptor fd, EBADF would return.
>   *   4. Argument points outside the calling process's address space, EFAULT
>   *	would return.

This should be reformatted so that it renders nicely in asccidoc as:


/*\
 * [Description]
 *
 * Verify that readdir will fail with:
 *
 * - ENOENT when passed a fd to a deleted directory
 * - ENOTDIR when passed fd that does not point to a directory
 * - EBADFD when passed an invalid fd
 * - EFAULT when passed invalid buffer pointer
 */

> - *
> - *  PS:
> - *   This file is for readdir(2) and the other files(readdir01.c and
> - *   readdir02.c) are for readdir(3).
>   */
> 
> -#define _GNU_SOURCE
> +//#define _GNU_SOURCE

Just remove it if it's not needed.

>  #include <stdio.h>
> -#include <sys/types.h>
>  #include <sys/stat.h>
> -#include <fcntl.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <sys/mman.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
>  #include "lapi/readdir.h"
> 
> -char *TCID = "readdir21";
> -
>  #define TEST_DIR	"test_dir"
>  #define TEST_DIR4	"test_dir4"
>  #define TEST_FILE	"test_file"
> @@ -55,96 +35,46 @@ static unsigned int del_dir_fd, file_fd;
>  static unsigned int invalid_fd = 999;
>  static unsigned int dir_fd;
>  static struct old_linux_dirent dirp;
> -static void setup(void);
> -static void cleanup(void);
> 
> -static struct test_case_t {
> +static struct tcase {
>  	unsigned int *fd;
>  	struct old_linux_dirent *dirp;
>  	unsigned int count;
>  	int exp_errno;
> -} test_cases[] = {
> +} tcases[] = {
>  	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT},
>  	{&file_fd, &dirp, sizeof(struct old_linux_dirent), ENOTDIR},
>  	{&invalid_fd, &dirp, sizeof(struct old_linux_dirent), EBADF},
> -#if !defined(UCLINUX)
>  	{&dir_fd, (struct old_linux_dirent *)-1,
>  	 sizeof(struct old_linux_dirent), EFAULT},
> -#endif
>  };

I guess that we also miss EINVAL error here with invalid count.

> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static void readdir_verify(const struct test_case_t *);
> -
> -int main(int argc, char **argv)
> -{
> -	int i, lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			readdir_verify(&test_cases[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	SAFE_MKDIR(TEST_DIR, DIR_MODE);
> +	del_dir_fd = SAFE_OPEN(TEST_DIR, O_RDONLY | O_DIRECTORY);
> +	SAFE_RMDIR(TEST_DIR);
> 
> -	tst_tmpdir();
> +	file_fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0777);
> 
> -	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
> -	del_dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_RDONLY | O_DIRECTORY);
> -	SAFE_RMDIR(cleanup, TEST_DIR);
> +	SAFE_MKDIR(TEST_DIR4, DIR_MODE);
> +	dir_fd = SAFE_OPEN(TEST_DIR4, O_RDONLY | O_DIRECTORY);
> 
> -	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0777);
> -
> -	SAFE_MKDIR(cleanup, TEST_DIR4, DIR_MODE);
> -	dir_fd = SAFE_OPEN(cleanup, TEST_DIR4, O_RDONLY | O_DIRECTORY);
> -
> -#if !defined(UCLINUX)
> -	test_cases[3].dirp = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> -				       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> -#endif
> +	tcases[3].dirp = tst_get_bad_addr(NULL);

We shouldn't rely on the tcases structure order. We usually solve this
with a for loop in the setup that looks for EFAULT errno as with:

	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
		if (tcases[i].exp_errno == EBADFD)
			tcases[i].dirp = tst_get_bad_addr(NULL);
	}

>  }
> 
> -static void readdir_verify(const struct test_case_t *test)
> +static void verify_readdir(unsigned int nr)
>  {
> -	TEST(ltp_syscall(__NR_readdir, *test->fd, test->dirp, test->count));
> -
> -	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "readdir() succeeded unexpectedly");
> -		return;
> -	}
> +	struct tcase *tc = &tcases[nr];
> 
> -	if (TEST_ERRNO == test->exp_errno) {
> -		tst_resm(TPASS | TTERRNO, "readdir() failed as expected");
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "readdir() failed unexpectedly; expected: %d - %s",
> -			 test->exp_errno, strerror(test->exp_errno));
> -	}
> +	TST_EXP_FAIL(tst_syscall(__NR_readdir, *tc->fd, tc->dirp, tc->count),
> +			tc->exp_errno, "readdir() failed unexpectedly, expected: %d - %s",
> +			tc->exp_errno, strerror(tc->exp_errno));

This produces a very confusing messages. The TST_EXP_*() macros should
print what is being tested, since the part that describes the result is
appended automatically.

So here we should probably add a short description to the tcases
structure and print it with the macro as:

...
} tcases[] = {
	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT, "directory deleted"},
...
}

...

	TST_EXP_FAIL(tst_syscall(__NR_readdir, *tc->fd, tc->dirp, tc->count),
	             tc->exp_errno, "readdir() with %s", tc->desc);

Which would produce:

	readdir21.c:70: TPASS: readdir() with directory deleted : ENOENT (2)

Instead of the confusing:

	readdir21.c:70: TPASS: readdir() failed unexpectedly, expected: 2 - No such file or directory : ENOENT (2)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
