Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31019C021BB
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 15:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B11793C9C61
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:51:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B50D3C9AF4
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:50:59 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AACDD6215AA
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:50:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD4F92111F;
 Tue, 25 Feb 2025 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740498658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvSwhhscU8hCX5t6MJe9A5Z5zOuufQekeB+I+yAD+vI=;
 b=nE/c7j0K1ttVT+EXn3Z3ZJaUl1CKWlctK9+x/oxVGDLpPQUHHP8lUpGEpiSxe2aiT0WGpM
 DR3H6XWcVjiwX2F4tl0YWhKKu3lLCcDTpPru2gYqHOEWRgcWefAyF9nIkV0EOo9pNPBlC5
 XInnM4jKVhz5lVCqekoijPxSSH27y+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740498658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvSwhhscU8hCX5t6MJe9A5Z5zOuufQekeB+I+yAD+vI=;
 b=lvDP0nsrexQFnrFRq5//L9LNIBVKtdJ4z36auS32FvZdQ1WaIN3l/JxxeVHUd7nkuPgu35
 O+RAg7ykYUpOjWAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EKtGWY8z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qSQpqRaD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740498657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvSwhhscU8hCX5t6MJe9A5Z5zOuufQekeB+I+yAD+vI=;
 b=EKtGWY8z1rvKD5IRISbCbYJkb2GM2xvWFoU4tunXZ7iK6xfzHKrowTNms7GjnwNehHfSTK
 QS8ig6WiZyN6QLV21GSfsepwjs0XvaXS7pLeBav7rNn+s7eRbz5lBJSY3cAxIT7JjeMlZT
 xgaFKGn3dTCiQS4LZZIeaqQnygUFMH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740498657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvSwhhscU8hCX5t6MJe9A5Z5zOuufQekeB+I+yAD+vI=;
 b=qSQpqRaDe+UURIG5m58q4RrE3Fm8xLt8cBM/Lq/SrzmhjNKEA2mFINMwTJP8FNSeK6nGFc
 eKag5tm9NAG+b5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA51713332;
 Tue, 25 Feb 2025 15:50:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MKK/LOHmvWcnMgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 25 Feb 2025 15:50:57 +0000
Date: Tue, 25 Feb 2025 16:51:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z73m7SkqOjgIFxfz@yuki.lan>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
 <20250210-mmap_suite_refactoring-v2-8-6edea3a4363a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210-mmap_suite_refactoring-v2-8-6edea3a4363a@suse.com>
X-Rspamd-Queue-Id: CD4F92111F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] Refactor mmap001 test and move it to mmap21
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
Cc: rbm@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +mm01 mmap021 -m 10000

If we are renaming the test we may as well rename the tag.

And you have a typo there it's mmap21 not mmap021

>  # 40 Mb mmap() test.
>  # Creates a 10000 page mmap, touches all of the map, sync's it, and
>  # munmap()s it.
> -mm02 mmap001
> -# simple mmap() test.
> -#mm03 mmap001 -i 0 -I 1 -m 100
> -# repetitive mmapping test.
> -# Creates a one page map repetitively for one minute.
> +mm02 mmap21

Here as well. I would propose to change the tag to mmap21_02 here and to
mmap21_01 above.

>  mtest01 mtest01 -p80
>  mtest01w mtest01 -p80 -w
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 4ab8436d30ca5ffee52d9777729ec1ec09d0bf1d..6aaef356fd617bac5617a3a652c66016892b07eb 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -822,7 +822,7 @@ mlock201 mlock201
>  mlock202 mlock202
>  mlock203 mlock203
>  
> -qmm01 mmap001 -m 1
> +qmm01 mmap21 -m 1

Here as well.

>  mmap01 mmap01
>  mmap02 mmap02
>  mmap03 mmap03
> diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
> index 4591fdbb9b71d5edb534c3d99f1a66e0e42ce6b6..850284d86616e29674df89b8107a5939c25723da 100644
> --- a/testcases/kernel/syscalls/mmap/.gitignore
> +++ b/testcases/kernel/syscalls/mmap/.gitignore
> @@ -1,4 +1,3 @@
> -/mmap001
>  /mmap01
>  /mmap02
>  /mmap03
> @@ -18,3 +17,4 @@
>  /mmap18
>  /mmap19
>  /mmap20
> +/mmap21
> diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
> deleted file mode 100644
> index dabb7d1e4998b1097e179abe23555926f5841117..0000000000000000000000000000000000000000
> --- a/testcases/kernel/syscalls/mmap/mmap001.c
> +++ /dev/null
> @@ -1,183 +0,0 @@
> -/*
> - * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
> - *                    Aaron Laffin <alaffin@sgi.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> - *
> - * mmap001.c - Tests mmapping a big file and writing it once
> - */
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <sys/mman.h>
> -#include <stdlib.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <string.h>
> -
> -#include "test.h"
> -
> -char *TCID = "mmap001";
> -int TST_TOTAL = 5;
> -static char *filename = NULL;
> -static int m_opt = 0;
> -static char *m_copt;
> -
> -static void cleanup(void)
> -{
> -	free(filename);
> -
> -	tst_rmdir();
> -}
> -
> -static void setup(void)
> -{
> -	char buf[1024];
> -	/*
> -	 * setup a default signal hander and a
> -	 * temporary working directory.
> -	 */
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	snprintf(buf, 1024, "testfile.%d", getpid());
> -
> -	if ((filename = strdup(buf)) == NULL) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "strdup failed");
> -	}
> -
> -}
> -
> -static void help(void)
> -{
> -	printf("  -m x    size of mmap in pages (default 1000)\n");
> -}
> -
> -/*
> - * add the -m option whose parameter is the
> - * pages that should be mapped.
> - */
> -option_t options[] = {
> -	{"m:", &m_opt, &m_copt},
> -	{NULL, NULL, NULL}
> -};
> -
> -int main(int argc, char *argv[])
> -{
> -	char *array;
> -	int lc;
> -	unsigned int i;
> -	int fd;
> -	unsigned int pages, memsize;
> -
> -	tst_parse_opts(argc, argv, options, help);
> -
> -	if (m_opt) {
> -		memsize = pages = atoi(m_copt);
> -
> -		if (memsize < 1) {
> -			tst_brkm(TBROK, cleanup, "Invalid arg for -m: %s",
> -				 m_copt);
> -		}
> -
> -		memsize *= getpagesize();	/* N PAGES */
> -
> -	} else {
> -		/*
> -		 * default size 1000 pages;
> -		 */
> -		memsize = pages = 1000;
> -		memsize *= getpagesize();
> -	}
> -
> -	tst_resm(TINFO, "mmap()ing file of %u pages or %u bytes", pages,
> -		 memsize);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		fd = open(filename, O_RDWR | O_CREAT, 0666);
> -		if ((fd == -1))
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "opening %s failed", filename);
> -
> -		if (lseek(fd, memsize, SEEK_SET) != memsize) {
> -			TEST_ERRNO = errno;
> -			close(fd);
> -			tst_brkm(TBROK | TTERRNO, cleanup, "lseek failed");
> -		}
> -
> -		if (write(fd, "\0", 1) != 1) {
> -			TEST_ERRNO = errno;
> -			close(fd);
> -			tst_brkm(TBROK | TTERRNO, cleanup,
> -				 "writing to %s failed", filename);
> -		}
> -
> -		array = mmap(0, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
> -		if (array == MAP_FAILED) {
> -			TEST_ERRNO = errno;
> -			close(fd);
> -			tst_brkm(TBROK | TTERRNO, cleanup,
> -				 "mmapping %s failed", filename);
> -		} else {
> -			tst_resm(TPASS, "mmap() completed successfully.");
> -		}
> -
> -		tst_resm(TINFO, "touching mmaped memory");
> -
> -		for (i = 0; i < memsize; i++) {
> -			array[i] = (char)i;
> -		}
> -
> -		/*
> -		 * seems that if the map area was bad, we'd get SEGV,
> -		 * hence we can indicate a PASS.
> -		 */
> -		tst_resm(TPASS,
> -			 "we're still here, mmaped area must be good");
> -
> -		TEST(msync(array, memsize, MS_SYNC));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO,
> -				 "synchronizing mmapped page failed");
> -		} else {
> -			tst_resm(TPASS,
> -				 "synchronizing mmapped page passed");
> -		}
> -
> -		TEST(munmap(array, memsize));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO,
> -				 "munmapping %s failed", filename);
> -		} else {
> -			tst_resm(TPASS, "munmapping %s successful", filename);
> -		}
> -
> -		close(fd);
> -		unlink(filename);
> -
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..895f86d36afe32082205f0b391bfa19070170d87
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap21.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
> + *                    Aaron Laffin <alaffin@sgi.com>
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that we can use mmap() to map a large file, write to it via memory
> + * access, and read back the data from the file. This test also verifies that
> + * accessing memory won't end up killing the test with SIGSEGV.
> + */
> +
> +#include "tst_test.h"
> +
> +static char filename[1024];
> +static char *str_pages;
> +static long long pages = 1000;
> +static long long memory_size;
> +static char *memory_data;
> +
> +static void run(void)
> +{
> +	int fd;
> +	pid_t pid;
> +	int status;
> +	char *buff = NULL;
> +
> +	tst_res(TINFO, "mmap()ing file of %llu bytes", memory_size);
> +
> +	fd = SAFE_OPEN(filename, O_RDWR | O_CREAT, 0666);
> +	SAFE_LSEEK(fd, memory_size, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\0", 1);
> +
> +	memory_data = SAFE_MMAP(0, memory_size, PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		tst_res(TINFO, "Touching mapped memory");
> +
> +		for (int i = 0; i < memory_size; i++)
> +			memory_data[i] = (char)i;
> +
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TFAIL, "Touching memory caused SIGSEGV");
> +		goto exit;
> +	}

The child here is not going to crash unless there is a serious bug in
the kernel. And with such bug I would expect that the machine wouldn't
even boot.

So I wouldn't wait the child here and just let the test library collect
it.

> +	SAFE_MSYNC(memory_data, memory_size, MS_SYNC);
> +
> +	buff = SAFE_MALLOC(memory_size);

This buffer can be allocated once in the test setup and freed once in
the test cleanup.

> +	memset(buff, 0, memory_size);
> +
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	SAFE_READ(0, fd, buff, memory_size);
> +	SAFE_CLOSE(fd);
> +
> +	for (int i = 0; i < memory_size; i++) {
> +		if (buff[i] != (char)i) {
> +			tst_res(TFAIL, "Mapped file has not been updated at byte %d", i);
> +			goto exit;
> +		}
> +	}
> +
> +	tst_res(TPASS, "Mapped file has been updated");
> +
> +exit:
> +	if (buff)
> +		free(buff);
> +
> +	SAFE_MUNMAP(memory_data, memory_size);
> +	SAFE_UNLINK(filename);
> +}
> +
> +static void setup(void)
> +{
> +	if (tst_parse_filesize(str_pages, &pages, 1, LLONG_MAX))
> +		tst_brk(TBROK, "Invalid number of pages: %s", str_pages);
> +
> +	memory_size = pages * getpagesize();
> +
> +	snprintf(filename, 1024, "testfile.%d", getpid());

Appending $pid to the name is a leftover from days where the tests
didn't run in temporary directory. We do not need that anymore, we can
just hardcode any static name in the open() call above.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (memory_data)
> +		SAFE_MUNMAP(memory_data, memory_size);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.options = (struct tst_option[]) {
> +		{"m:", &str_pages, "Number of pages (default 1000)"},
> +		{}
> +	},
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
