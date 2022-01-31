Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB76C433F5
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 15:21:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F09E53C97B1
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 16:21:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BB9E3C9776
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 16:21:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 699D7600551
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 16:21:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 490FE1F380;
 Mon, 31 Jan 2022 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643642475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RMdzu4wEDEQQMERtPpxZjjL4+zz2ZSpPsJjcemhp40=;
 b=DiJj5bevIieUR73TbyrZhWiEBJdi0oRUNmEWL1DnpNAx/WSTCshJHyxZzhdHAUTAtjZRh7
 exYEXkLYJhgmYvqK32680JFN8wi3NjNauy6uKwuuhSDk0x86zki2CiF8N77foA4WM95Nxs
 niFWQ+1+7DOJQR/Ej7dYMs+yBPjwcjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643642475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RMdzu4wEDEQQMERtPpxZjjL4+zz2ZSpPsJjcemhp40=;
 b=+72YFcuiEWDAoWTlBxDVCsmrdd+oE4o/pkv/bX1AierH+8PDmqmcdhMnuLC5GBwhWYZUQm
 lP6N+DiRWEFzd0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3090113C52;
 Mon, 31 Jan 2022 15:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y3CCCmv+92HsVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 31 Jan 2022 15:21:15 +0000
Date: Mon, 31 Jan 2022 16:23:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yff+3WJfwRnO+WDB@yuki>
References: <20211220110626.23192-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211220110626.23192-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Refactoring aiodio_sparse.c using LTP API
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
> diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> index 4767f49d2..f7cb8e2a2 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
>   *               2004 Open Source Development Lab
> @@ -5,63 +6,55 @@
>   * Copyright (c) 2004 Marty Ridgeway <mridge@us.ibm.com>
>   *
>   * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
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
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Create a sparse file using libaio while other processes are doing
                           ^
			   and write zeroes to it using libaio ...

Technically all that needs to be done to create the sparse file is the
ftruncate() call.

> + * buffered reads and check if the buffer reads always see zero.
>   */
>  
>  #define _GNU_SOURCE
>  
> -#include <stdlib.h>
> -#include <sys/types.h>
> -#include <errno.h>
> -#include <signal.h>
> -#include <fcntl.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <sys/mman.h>
> -#include <sys/wait.h>
> -#include <limits.h>
> -#include <getopt.h>
> -
> -
> -#include "config.h"
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "aiodio_sparse";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
>  
>  #ifdef HAVE_LIBAIO
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
>  #include <libaio.h>
> +#include "common.h"
>  
> -#define NUM_CHILDREN 1000
> +static int *run_child;
>  
> -int debug;
> -int fd;
> +static char *str_numchildren;
> +static char *str_writesize;
> +static char *str_filesize;
> +static char *str_numaio;
>  
> -static void setup(void);
> -static void cleanup(void);
> -static void usage(void);
> +static int numchildren;
> +static long long writesize;
> +static long long filesize;
> +static long long alignment;
> +static int numaio;

Can we please move the defaults here as we did for the other tests?

> -#include "common_sparse.h"
> +static void check_event(struct io_event event)
> +{
> +	struct iocb *iocbp;
> +
> +	iocbp = (struct iocb *)event.obj;
> +	if (event.res2 != 0 || event.res != iocbp->u.c.nbytes)
> +		tst_brk(TBROK,
> +			"AIO write offset %lld expected %ld got %ld",
> +			iocbp->u.c.offset, iocbp->u.c.nbytes,
> +			event.res);

The LKML coding style prefers curly braces over multiline blocks even if
they are single statement.

> +}
>  
> -/*
> - * do async DIO writes to a sparse file
> - */
> -int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
> +static void aiodio_sparse(char *filename, long long align, long long ws, long long fs, int naio)
>  {
> +	int fd;
>  	int i, w;
>  	struct iocb **iocbs;
>  	off_t offset;
> @@ -69,103 +62,64 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
>  	struct io_event event;
>  	int aio_inflight;
>  
> -	if ((num_aio * writesize) > filesize)
> -		num_aio = filesize / writesize;
> +	if ((naio * ws) > fs)
> +		naio = fs / ws;

I wonder if this check should be in setup() and if we should print a
TINFO message that the number of blocks was reduced.

> +	fd = SAFE_OPEN(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> +	SAFE_FTRUNCATE(fd, fs);
>  
>  	memset(&myctx, 0, sizeof(myctx));
> -	io_queue_init(num_aio, &myctx);
> +	io_queue_init(naio, &myctx);
>  
> -	iocbs = malloc(sizeof(struct iocb *) * num_aio);
> -	for (i = 0; i < num_aio; i++) {
> -		if ((iocbs[i] = malloc(sizeof(struct iocb))) == 0) {
> -			tst_resm(TBROK | TERRNO, "malloc()");
> -			return 1;
> -		}
> -	}
> +	iocbs = SAFE_MALLOC(sizeof(struct iocb *) * naio);
> +	for (i = 0; i < naio; i++)
> +		iocbs[i] = SAFE_MALLOC(sizeof(struct iocb));

We can actually allocate the memory once and just set the pointers as:

	iocbs_ptr = SAFE_MALLOC(sizeof(struct iocb *) * naio);
	iocs = SAFE_MALLOC(sizeof(struct iocb) * naio);

	for (i = 0; i < naio; i++)
		iocbs_ptr = iocbs + i;

>  	/*
>  	 * allocate the iocbs array and iocbs with buffers
>  	 */
>  	offset = 0;
> -	for (i = 0; i < num_aio; i++) {
> +	for (i = 0; i < naio; i++) {
>  		void *bufptr;
>  
> -		TEST(posix_memalign(&bufptr, align, writesize));
> -		if (TEST_RETURN) {
> -			tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
> -			return 1;
> -		}
> -		memset(bufptr, 0, writesize);
> -		io_prep_pwrite(iocbs[i], fd, bufptr, writesize, offset);
> -		offset += writesize;
> +		bufptr = SAFE_MEMALIGN(align, ws);
> +		memset(bufptr, 0, ws);
> +		io_prep_pwrite(iocbs[i], fd, bufptr, ws, offset);
> +		offset += ws;
>  	}
>  
>  	/*
> -	 * start the 1st num_aio write requests
> +	 * start the 1st naio write requests
>  	 */
> -	if ((w = io_submit(myctx, num_aio, iocbs)) < 0) {
> -		tst_resm(TBROK, "io_submit() returned %i", w);
> -		return 1;
> -	}
> -
> -	if (debug)
> -		tst_resm(TINFO, "io_submit() returned %d", w);
> +	w = io_submit(myctx, naio, iocbs);
> +	if (w < 0)
> +		tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
>  
>  	/*
>  	 * As AIO requests finish, keep issuing more AIO until done.
>  	 */
> -	aio_inflight = num_aio;
> +	aio_inflight = naio;
>  
> -	while (offset < filesize) {
> +	while (offset < fs) {
>  		int n;
>  		struct iocb *iocbp;
>  
> -		if (debug)
> -			tst_resm(TINFO,
> -				 "aiodio_sparse: offset %p filesize %d inflight %d",
> -				 &offset, filesize, aio_inflight);
> -
> -		if ((n = io_getevents(myctx, 1, 1, &event, 0)) != 1) {
> -			if (-n != EINTR)
> -				tst_resm(TBROK, "io_getevents() returned %d",
> -					 n);
> -			break;
> -		}
> -
> -		if (debug)
> -			tst_resm(TINFO,
> -				 "aiodio_sparse: io_getevent() returned %d", n);
> +		n = io_getevents(myctx, 1, 1, &event, 0);
> +		if (n != 1 && -n != EINTR)
> +			tst_brk(TBROK, "io_getevents: %s", tst_strerrno(-n));

I guess that in the case of EINTR we should just continue; the loop
because the event was not filled in with a new data.

So I guess it should be:

		if (-n == EINTR)
			continue;

		if (n != 1)
			tst_brk(TBRO, ...);

>  		aio_inflight--;
>  
> -		/*
> -		 * check if write succeeded.
> -		 */
> -		iocbp = (struct iocb *)event.obj;
> -		if (event.res2 != 0 || event.res != iocbp->u.c.nbytes) {
> -			tst_resm(TBROK,
> -				 "AIO write offset %lld expected %ld got %ld",
> -				 iocbp->u.c.offset, iocbp->u.c.nbytes,
> -				 event.res);
> -			break;
> -		}
> -
> -		if (debug)
> -			tst_resm(TINFO,
> -				 "aiodio_sparse: io_getevent() res %ld res2 %ld",
> -				 event.res, event.res2);
> +		check_event(event);
>  
>  		/* start next write */
> -		io_prep_pwrite(iocbp, fd, iocbp->u.c.buf, writesize, offset);
> -		offset += writesize;
> -		if ((w = io_submit(myctx, 1, &iocbp)) < 0) {
> -			tst_resm(TBROK, "io_submit failed at offset %ld",
> -				 offset);
> -			break;
> -		}
> +		iocbp = (struct iocb *)event.obj;
>  
> -		if (debug)
> -			tst_resm(TINFO, "io_submit() return %d", w);
> +		io_prep_pwrite(iocbp, fd, iocbp->u.c.buf, ws, offset);
> +		offset += ws;
> +		w = io_submit(myctx, 1, &iocbp);
> +		if (w < 0)
> +			tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
>  
>  		aio_inflight++;
>  	}
> @@ -175,163 +129,95 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
>  	 */
>  	while (aio_inflight > 0) {
>  		int n;
> -		struct iocb *iocbp;
>  
> -		if ((n = io_getevents(myctx, 1, 1, &event, 0)) != 1) {
> -			tst_resm(TBROK, "io_getevents failed");
> -			break;
> -		}
> -		aio_inflight--;
> -		/*
> -		 * check if write succeeded.
> -		 */
> -		iocbp = (struct iocb *)event.obj;
> -		if (event.res2 != 0 || event.res != iocbp->u.c.nbytes) {
> -			tst_resm(TBROK,
> -				 "AIO write offset %lld expected %ld got %ld",
> -				 iocbp->u.c.offset, iocbp->u.c.nbytes,
> -				 event.res);
> -		}
> -	}
> +		n = io_getevents(myctx, 1, 1, &event, 0);
> +		if (n != 1)
> +			tst_brk(TBROK, "io_getevents failed");

And here we do not handle the EINTR case.

> -	return 0;
> -}
> +		aio_inflight--;
>  
> -static void usage(void)
> -{
> -	fprintf(stderr, "usage: dio_sparse [-n children] [-s filesize]"
> -		" [-w writesize]\n");
> -	exit(1);
> +		check_event(event);
> +	}

And we should free the buffers here, otherwise the test will keep
allocating, rather large, buffers in each iteration.

>  }
>  

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
