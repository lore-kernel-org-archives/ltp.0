Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28033C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 14:06:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4BAF3C264E
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 15:06:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A105F3C02F7
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 15:06:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BCCBD600795
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 15:06:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CE5B1FD59;
 Mon,  6 Dec 2021 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638799570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEf+/+mv3a313H/VOiK4fDF/FvbvFFa1+rDyV138oJk=;
 b=fsBOrYybjGvPGO5vFz+YzzDYmTTt3VWD9imOg39GZpnefvgjYVGVnS9IhGI310wwUxXFfP
 G6dCLnh9KGknGNKu6wa+21oIXUc2ZuurXu09o+Nrz51nTba+DNlcccgaAu6CteBwsx3LOj
 fKzv2tYOmvnmzs4sEQGMNoMZ9TrV5XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638799570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEf+/+mv3a313H/VOiK4fDF/FvbvFFa1+rDyV138oJk=;
 b=/kJzdbZgFwdAjSYPrh666kZIOOFdoiST3GMYPgBJ31AQ4ockcHfABuHbF3kkZkj/tTIGVW
 hXKoen026AKCsvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0A5513C4C;
 Mon,  6 Dec 2021 14:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Nf7+NdEYrmHGMAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Dec 2021 14:06:09 +0000
Date: Mon, 6 Dec 2021 15:07:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Ya4ZHdAsCz+/421w@yuki>
References: <20211201134846.14352-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211201134846.14352-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactoring dio_sparse.c using LTP API
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
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/io/ltp-aiodio/common.h     |  32 +++
>  testcases/kernel/io/ltp-aiodio/dio_sparse.c | 248 +++++++-------------
>  2 files changed, 119 insertions(+), 161 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
> index fefeed2cf..0d050b626 100644
> --- a/testcases/kernel/io/ltp-aiodio/common.h
> +++ b/testcases/kernel/io/ltp-aiodio/common.h
> @@ -7,6 +7,9 @@
>  #define AIODIO_COMMON_H__
>  
>  #include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/mman.h>
>  #include "tst_test.h"
>  
>  static inline char *check_zero(char *buf, int size)
> @@ -51,4 +54,33 @@ static inline void io_append(const char *path, char pattern, int flags, size_t b
>  	SAFE_CLOSE(fd);
>  }
>  
> +/*
> + * This code tries to create dirty free blocks on
> + * the HDD so there is a chance that blocks to be allocated
> + * for a file are filled with something else than zeroes.
> + *
> + * The usefulness of this is IMHO questionable.
> + */
> +static inline void dirty_freeblocks(int size)
> +{
> +	char *filename = "dirty_file";
> +	int fd;
> +	void *p;
> +	int pg;
> +
> +	pg = getpagesize();
> +	size = ((size + pg - 1) / pg) * pg;

We can replace this with LTP_ALIGN() macro now that we are moving the
code...

> +	fd = SAFE_OPEN(filename, O_CREAT | O_RDWR, 0600);
> +	SAFE_FTRUNCATE(fd, size);
> +
> +	p = SAFE_MMAP(NULL, size, PROT_WRITE | PROT_READ, MAP_SHARED | MAP_FILE, fd, 0);
> +	memset(p, 0xaa, size);
> +	msync(p, size, MS_SYNC);
> +	munmap(p, size);
> +
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(filename);
> +}
> +
>  #endif /* AIODIO_COMMON_H__ */
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> index 3f44e92ea..cb1b25d1b 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *   Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
>   *                 2004 Open Source Development Lab
> @@ -6,206 +7,131 @@
>   *
>   *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + *   Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Create a sparse file using O_DIRECT while other processes are doing
> + * buffered reads and check if the buffer reads always see zero.
>   */
>  
>  #define _GNU_SOURCE
>  
>  #include <stdlib.h>
> -#include <sys/types.h>
> -#include <signal.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <stdio.h>
>  #include <unistd.h>
> -#include <memory.h>
> -#include <sys/mman.h>
> +#include <string.h>
>  #include <sys/wait.h>
> -#include <limits.h>
> -#include <getopt.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
> +#include "common.h"
>  
>  #define NUM_CHILDREN 1000
> +#define FILE_SIZE (100 * 1024 * 1024)
> +#define WRITE_SIZE 1024
>  
> -static void setup(void);
> -static void cleanup(void);
> -static void usage(void);
> -static int debug = 0;
> -static int fd;
> -
> -char *TCID = "dio_sparse";
> -int TST_TOTAL = 1;
> +static int *run_child;
>  
> -#include "common_sparse.h"
> -
> -/*
> - * Write zeroes using O_DIRECT into sparse file.
> - */
> -int dio_sparse(int fd, int align, int writesize, int filesize, int offset)
> +static void dio_sparse(int fd, int filesize, int writesize)
>  {
>  	void *bufptr = NULL;
> -	int i, w;
> +	int i;
> +	int w;
>  
> -	TEST(posix_memalign(&bufptr, align, writesize));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
> -		return 1;
> -	}
> +	bufptr = SAFE_MEMALIGN(getpagesize(), writesize);
>  
>  	memset(bufptr, 0, writesize);
> -	lseek(fd, offset, SEEK_SET);
> -	for (i = offset; i < filesize;) {
> -		if ((w = write(fd, bufptr, writesize)) != writesize) {
> -			tst_resm(TBROK | TERRNO, "write() returned %d", w);
> -			return 1;
> -		}
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
>  
> +	for (i = 0; i < filesize;) {
> +		w = SAFE_WRITE(0, fd, bufptr, writesize);
>  		i += w;
>  	}
> -
> -	return 0;
> -}
> -
> -void usage(void)
> -{
> -	fprintf(stderr, "usage: dio_sparse [-d] [-n children] [-s filesize]"
> -		" [-w writesize] [-o offset]]\n");
> -	exit(1);
>  }
>  
> -int main(int argc, char **argv)
> +static void read_sparse(const char *filename, int filesize)
>  {
> -	char *filename = "dio_sparse";
> -	int pid[NUM_CHILDREN];
> -	int num_children = 1;
> +	char buff[4096];
> +	int fd;
>  	int i;
> -	long alignment = 512;
> -	int writesize = 65536;
> -	int filesize = 100 * 1024 * 1024;
> -	int offset = 0;
> -	int c;
> -	int children_errors = 0;
> -	int ret;
> -
> -	while ((c = getopt(argc, argv, "dw:n:a:s:o:")) != -1) {
> -		char *endp;
> -		switch (c) {
> -		case 'd':
> -			debug++;
> -			break;
> -		case 'a':
> -			alignment = strtol(optarg, &endp, 0);
> -			alignment = scale_by_kmg(alignment, *endp);
> -			break;
> -		case 'w':
> -			writesize = strtol(optarg, &endp, 0);
> -			writesize = scale_by_kmg(writesize, *endp);
> -			break;
> -		case 's':
> -			filesize = strtol(optarg, &endp, 0);
> -			filesize = scale_by_kmg(filesize, *endp);
> -			break;
> -		case 'o':
> -			offset = strtol(optarg, &endp, 0);
> -			offset = scale_by_kmg(offset, *endp);
> -			break;
> -		case 'n':
> -			num_children = atoi(optarg);
> -			if (num_children > NUM_CHILDREN) {
> -				fprintf(stderr,
> -					"number of children limited to %d\n",
> -					NUM_CHILDREN);
> -				num_children = NUM_CHILDREN;

First of all these parameters should be defined in the tst_option
structure and exposed in the tst_test structure.

See: https://github.com/linux-test-project/ltp/wiki/C-Test-API#15-test-specific-command-line-options

> +	int r;
> +
> +	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
> +		usleep(100);
> +
> +	tst_res(TINFO, "child %i reading file", getpid());
> +
> +	SAFE_LSEEK(fd, SEEK_SET, 0);

There is no need to seek newly opened file to the start.

> +	while (*run_child) {
> +		off_t offset = 0;
> +		char *bufoff;

And the seek should be here, right?

> +		for (i = 0; i < filesize + 1; i += sizeof(buff)) {
> +			r = SAFE_READ(0, fd, buff, sizeof(buff));
> +			if (r > 0) {
> +				bufoff = check_zero(buff, r);
> +				if (bufoff) {
> +					tst_res(TINFO, "non-zero read at offset %zu",
> +						offset + (bufoff - buff));
> +					break;
> +				}
> +				offset += r;
>  			}
> -			break;
> -		case '?':
> -			usage();
> -			break;
>  		}
>  	}
>  
> -	setup();
> -	tst_resm(TINFO, "Dirtying free blocks");
> -	dirty_freeblocks(filesize);
> +	SAFE_CLOSE(fd);
> +}

Also this function should go to the common header so that we can reuse
it later on...

> +static void setup(void)
> +{
> +	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
>  
> -	fd = SAFE_OPEN(cleanup, filename,
> -		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
> -	SAFE_FTRUNCATE(cleanup, fd, filesize);
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(run_child, sizeof(int));
> +}
>  
> -	tst_resm(TINFO, "Starting I/O tests");
> -	signal(SIGTERM, SIG_DFL);
> -	for (i = 0; i < num_children; i++) {
> -		switch (pid[i] = fork()) {
> -		case 0:
> -			SAFE_CLOSE(NULL, fd);
> -			read_sparse(filename, filesize);
> -			break;
> -		case -1:
> -			while (i-- > 0)
> -				kill(pid[i], SIGTERM);
> -
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork()");
> -		default:
> -			continue;
> -		}
> -	}
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +static void run(void)
> +{
> +	char *filename = "sparse_file";
> +	int filesize = FILE_SIZE;
> +	int num_children = NUM_CHILDREN;
> +	int writesize = WRITE_SIZE;
> +	int status;
> +	int fd;
> +	int i;
>  
> -	ret = dio_sparse(fd, alignment, writesize, filesize, offset);
> +	tst_res(TINFO, "Dirtying free blocks");
> +	dirty_freeblocks(filesize);

Maybe the dirty_freeblocks() should go to the test setup, so that we do
it once in case we requested multiple test iterations with -i

> -	tst_resm(TINFO, "Killing childrens(s)");
> +	fd = SAFE_OPEN(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> +	SAFE_FTRUNCATE(fd, filesize);
>  
> -	for (i = 0; i < num_children; i++)
> -		kill(pid[i], SIGTERM);
> +	*run_child = 1;
>  
>  	for (i = 0; i < num_children; i++) {
> -		int status;
> -		pid_t p;
> -
> -		p = waitpid(pid[i], &status, 0);
> -		if (p < 0) {
> -			tst_resm(TBROK | TERRNO, "waitpid()");
> -		} else {
> -			if (WIFEXITED(status) && WEXITSTATUS(status) == 10)
> -				children_errors++;
> +		if (!SAFE_FORK()) {
> +			read_sparse(filename, filesize);
> +			return;
>  		}
>  	}
>  
> -	if (children_errors)
> -		tst_resm(TFAIL, "%i children(s) exited abnormally",
> -			 children_errors);
> +	dio_sparse(fd, filesize, writesize);
>  
> -	if (!children_errors && !ret)
> -		tst_resm(TPASS, "Test passed");
> +	if (SAFE_WAITPID(-1, &status, WNOHANG))
> +		tst_res(TFAIL, "Non zero bytes read");
> +	else
> +		tst_res(TPASS, "All bytes read were zeroed");
>  
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	tst_tmpdir();
> +	*run_child = 0;
>  }
>  
> -static void cleanup(void)
> -{
> -	if (fd > 0 && close(fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close file");
> -
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};
> -- 
> 2.34.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
