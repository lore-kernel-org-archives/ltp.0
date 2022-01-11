Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851D3C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 15:01:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AE2D3C93F8
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 16:01:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6203C585E
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 16:01:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9607860071A
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 16:01:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5069210F5;
 Tue, 11 Jan 2022 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641913288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fzNATlY9A+C3/kPQZvVVr056Uu3QG6nzJpM2mVAWf+U=;
 b=NSa+Vj8UIaS13XWXuSVHbHEAmtIEyNP3/80Ukxi7LdHtgTwFWVCYTSk1ij04HuTf9wHGwM
 whnR4QRmEpactPa3jWMuCPfVQr/jWv9GluTErmtjpw1mqQAj98jVZERsKV7fnNpGOMsIZk
 feGkcTBMHepJIMSs/HNUNxPjflQ6Igg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641913288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fzNATlY9A+C3/kPQZvVVr056Uu3QG6nzJpM2mVAWf+U=;
 b=Cm0X45DgWYuNwLXFo/u3apI3XoqCxK2jy2QJPiXghkyvdXhYcf/rAyQ1cm37LwYiUfz4iN
 Dp1ViLP1lpgMcUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90E8A13DDD;
 Tue, 11 Jan 2022 15:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Jzm9Isib3WESfAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 11 Jan 2022 15:01:28 +0000
Date: Tue, 11 Jan 2022 16:03:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yd2cJ1sd7YuBJh9S@yuki>
References: <20211215095831.20505-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211215095831.20505-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Create dio_read.c test
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
> --- /dev/null
> +++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *   Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Create a file using buffered writes while other processes are doing
> + * O_DIRECT reads and check if the buffer reads always see zero.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +#include "common.h"
> +
> +static char *str_numchildren;
> +static char *str_writesize;
> +static char *str_readsize;
> +static char *str_filesize;
> +
> +static int numchildren;
> +static long long readsize;
> +static long long writesize;
> +static long long filesize;
> +static long long alignment;

Can we please initialize these variables here instead of the setup?

Also there is no need to initialize alignment since it's initialized
unconditionally.

> +static char *iobuf;
> +
> +static void do_buffered_writes(int fd, char *bufptr, long long fsize, long long wsize, int pattern)
> +{
> +	long long offset;
> +	long long w;
> +
> +	memset(bufptr, pattern, wsize);
> +
> +	tst_res(TINFO, "child %i reading file", getpid());
> +	for (offset = 0; offset + wsize <= fsize; offset += wsize) {
> +		w = pwrite(fd, bufptr, wsize, offset);
> +		if (w < 0)
> +			tst_brk(TBROK, "pwrite: %s", tst_strerrno(-w));
> +		if (w != wsize)
> +			tst_brk(TBROK, "pwrite: wrote %lld bytes out of %lld", w, wsize);
> +
> +		fsync(fd);
> +	}
> +}

The biggest problem I do see here is that unlike the other test we have
rewritten the children are not synchronized with parent here.

It mostly works for the defaults because we set the write size to be
equal to the read size. But for instance if we set write size 10x
smaller than the read size the parent that reads the data would finish
much sooner than the children and the children would be writing while
nobody is reading. And the other way around, if the reads are small the
writes would finish early.

I guess that the best strategy would be to change the children to loop
until the parent is reading so that we do not waste any time writing
when noone is reading and the other way around.

> +static int do_direct_reads(char *filename, char *bufptr, long long fsize, long long rsize)
> +{
> +	int fd;
> +	long long offset;
> +	long long w;
> +	int fail = 0;
> +
> +	while ((fd = open(filename, O_RDONLY | O_DIRECT, 0666)) < 0)
> +		usleep(100);
> +
> +	for (offset = 0; offset + rsize < fsize; offset += rsize) {
> +		char *bufoff;
> +
> +		w = pread(fd, bufptr, rsize, offset);
> +		if (w < 0)
> +			tst_brk(TBROK, "pread: %s", tst_strerrno(-w));
> +		if (w != rsize)
> +			tst_brk(TBROK, "pread: read %lld bytes out of %lld", w, rsize);
> +
> +		bufoff = check_zero(bufptr, rsize);
> +		if (bufoff) {
> +			fail = 1;
> +			break;
> +		}
> +	}
> +
> +	SAFE_CLOSE(fd);
> +	return fail;
> +}
> +
> +static void setup(void)
> +{
> +	struct stat sb;
> +	long long buffsize;
> +
> +	numchildren = 100;
> +	readsize = 32 * 1024 * 1024;
> +	writesize = 32 * 1024 * 1024;
> +	filesize = 128 * 1024 * 1024;
> +	alignment = 512;
> +
> +	if (tst_parse_filesize(str_filesize, &filesize, 1, LLONG_MAX))
> +		tst_brk(TBROK, "Invalid file size '%s'", str_filesize);
> +
> +	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
> +
> +	if (tst_parse_filesize(str_writesize, &writesize, 1, filesize))
> +		tst_brk(TBROK, "Invalid write blocks size '%s'", str_writesize);
> +
> +	if (tst_parse_filesize(str_readsize, &readsize, 1, filesize))
> +		tst_brk(TBROK, "Invalid read blocks size '%s'", str_readsize);
> +
> +	SAFE_STAT(".", &sb);
> +	alignment = sb.st_blksize;
> +
> +	buffsize = readsize;
> +	if (writesize > readsize)
> +		buffsize = writesize;
> +
> +	iobuf = SAFE_MEMALIGN(alignment, buffsize);
> +}
> +
> +static void run(void)
> +{
> +	char *filename = "file.bin";
> +	int pid[numchildren];
> +	int fd;
> +	int i;
> +	int fail;
> +
> +	fd = SAFE_OPEN(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
> +	SAFE_FTRUNCATE(fd, filesize);
> +
> +	for (i = 0; i < numchildren; i++) {
> +		pid[i] = SAFE_FORK();
> +		if (!pid[i]) {
> +			do_buffered_writes(fd, iobuf, filesize, writesize, 0);
> +			return;
> +		}
> +	}
> +
> +	fail = do_direct_reads(filename, iobuf, filesize, readsize);
> +	for (i = 0; i < numchildren; i++)
> +		wait4(pid[i], NULL, WNOHANG, 0);

Just use SAFE_WAIT() and get rid of the pid[] array. As long as we know
how many children we want to wait for we don't have to store the pids...

> +	/* Fill the file with a known pattern so that the blocks
> +	 * on disk can be detected if they become exposed. */
> +	do_buffered_writes(fd, iobuf, filesize, writesize, 1);
> +	fsync(fd);
> +	SAFE_FTRUNCATE(fd, 0);
> +	fsync(fd);

Actually this part has to be done before the test, not after it. So this
should be just after SAFE_OPEN().

Also this should use SAFE_FSYNC().

> +	if (fail)
> +		tst_res(TFAIL, "Non zero bytes read");
> +	else
> +		tst_res(TPASS, "All bytes read were zeroed");

Also either we move the SAFE_OPEN() into the test setup() and add
SAFE_CLOSE() to a test cleanup() or we have to close the fd here.

Remmeber the run() may be called repeatedly with either of -i and -I and
without being closed this function will leak file descriptor and with
large enough number of iterations it will hit ulimit.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.options = (struct tst_option[]) {
> +		{"n:", &str_numchildren, "Number of threads (default 100)"},
> +		{"w:", &str_writesize, "Size of writing blocks (default 32M)"},
> +		{"r:", &str_readsize, "Size of reading blocks (default 32M)"},
> +		{"s:", &str_filesize, "File size (default 128M)"},
> +		{}
> +	},
> +};

...

> -	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
> -	assert("open", fd >= 0);
> -
> -	do {
> -
> -		assert("ftruncate", ftruncate(fd, BIGSIZE) == 0);
> -		fsync(fd);
> -
> -		pid = fork();
> -		assert("fork", pid >= 0);
> -
> -		if (!pid) {
> -			do_buffered_writes(fd, 0);
> -			exit(0);
> -		}
> -
> -		err = do_direct_reads(filename);
> -
> -		wait4(pid, NULL, WNOHANG, 0);
> -
> -		if (err)
> -			break;
> -
> -		/* Fill the file with a known pattern so that the blocks
> -		 * on disk can be detected if they become exposed. */
> -		do_buffered_writes(fd, 1);
> -		fsync(fd);
> -
> -		assert("ftruncate", ftruncate(fd, 0) == 0);
> -		fsync(fd);
> -	} while (pass++ < MAX_ITERATIONS);

Note that the old test did 250 iterations and took for about a minute or
two on my machine. Since we start 100 children writing single iteration
takes much longer but still we can do about 10 iterations and have
roughtly the same runtime. So when you are changing the runtest file can
you please add a few different variants where the number of children and
number of iterations would be combined so that they result in similar
runtime?

For me two different entries would look like:

dio_read -n 1 -i 250
dio_read -n 100 -i 10

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
