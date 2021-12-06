Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30457C4707A
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 15:15:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25303C22F0
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 16:15:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26C843C1DF9
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 16:15:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC4FE200CEF
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 16:15:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F9E71FD2F;
 Mon,  6 Dec 2021 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638803732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCLzAvG4VocU2fLJ432R+beyvdXT2uQ+O+UTTCBFM4g=;
 b=NyF79Lwc0bf3kb75rTGwGJYCX6wl9FlhF8a48uXDDcW+2oNmJGTpGjmGfLvkzsZIA/LWAo
 GpVpLBLreaMb8UPs1ogQEc5BqiVJW+OmvHAuesgiLvmqheTtNdvDvKKxujKAeMcGBNiC0m
 /M+oOGln2mnZT6ZE0Ho+iWqDJSdgML0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638803732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCLzAvG4VocU2fLJ432R+beyvdXT2uQ+O+UTTCBFM4g=;
 b=kp3Fg+DDpN0t94GCeQh+k7mMkBgu/dLMxxAoy8ICTXK1QliHBLBuYp96kRza9N8e/mHbXY
 hpLE+symnaGlFbBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD7E113C52;
 Mon,  6 Dec 2021 15:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m73BMRMprmHFUAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Dec 2021 15:15:31 +0000
Date: Mon, 6 Dec 2021 16:16:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Ya4pX/aWsMbCyg9J@yuki>
References: <20211206101451.13415-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206101451.13415-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactoring aiodio_sparse.c test using LTP API
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
Mostly the same comments apply here as well.

> +static void read_sparse(const char *filename, int filesize)
> +{
> +	char buff[4096];
> +	int fd;
> +	int i;
> +	int r;
> +
> +	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
> +		usleep(100);
> +
> +	tst_res(TINFO, "child %i reading file", getpid());
> +
> +	SAFE_LSEEK(fd, SEEK_SET, 0);
> +	while (*run_child) {
> +		off_t offset = 0;
> +		char *bufoff;

The seek() should really be here.

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
> +			}
> +		}
> +	}
>  
> -#include "common_sparse.h"
> +	SAFE_CLOSE(fd);
> +}

And there is really no point in having more copies of this function.

> -/*
> - * do async DIO writes to a sparse file
> - */
> -int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
> +static void aiodio_sparse(char *filename, int writesize, int filesize, int num_aio)
>  {
> +	int fd;
>  	int i, w;
>  	struct iocb **iocbs;
>  	off_t offset;
> @@ -72,16 +82,15 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
>  	if ((num_aio * writesize) > filesize)
>  		num_aio = filesize / writesize;
>  
> +	fd = SAFE_OPEN(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> +	SAFE_FTRUNCATE(fd, filesize);
> +
>  	memset(&myctx, 0, sizeof(myctx));
>  	io_queue_init(num_aio, &myctx);
>  
> -	iocbs = malloc(sizeof(struct iocb *) * num_aio);
> -	for (i = 0; i < num_aio; i++) {
> -		if ((iocbs[i] = malloc(sizeof(struct iocb))) == 0) {
> -			tst_resm(TBROK | TERRNO, "malloc()");
> -			return 1;
> -		}
> -	}
> +	iocbs = SAFE_MALLOC(sizeof(struct iocb *) * num_aio);
> +	for (i = 0; i < num_aio; i++)
> +		iocbs[i] = SAFE_MALLOC(sizeof(struct iocb));

Can't we just allocate array of struct iocb and use that instead of the
indirection here?

	struct iocb *iocbs;


	iocbs = SAFE_MALLOC(sizeof(struct iocb) * num_aio);

Then all the difference in the code below is that iocbs[i]->foo becomes
iocbs[i].foo and iocbs[i] becomes &iocbs[i].


>  	/*
>  	 * allocate the iocbs array and iocbs with buffers
> @@ -90,11 +99,7 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
>  	for (i = 0; i < num_aio; i++) {
>  		void *bufptr;
>  
> -		TEST(posix_memalign(&bufptr, align, writesize));
> -		if (TEST_RETURN) {
> -			tst_resm(TBROK | TRERRNO, "cannot allocate aligned memory");
> -			return 1;
> -		}
> +		bufptr = SAFE_MEMALIGN(getpagesize(), writesize);
>  		memset(bufptr, 0, writesize);
>  		io_prep_pwrite(iocbs[i], fd, bufptr, writesize, offset);
>  		offset += writesize;
> @@ -103,13 +108,9 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
>  	/*
>  	 * start the 1st num_aio write requests
>  	 */
> -	if ((w = io_submit(myctx, num_aio, iocbs)) < 0) {
> -		tst_resm(TBROK, "io_submit() returned %i", w);
> -		return 1;
> -	}
> -
> -	if (debug)
> -		tst_resm(TINFO, "io_submit() returned %d", w);
> +	w = io_submit(myctx, num_aio, iocbs);
> +	if (w < 0)
> +		tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
>  
>  	/*
>  	 * As AIO requests finish, keep issuing more AIO until done.
> @@ -120,21 +121,9 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
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
>  
>  		aio_inflight--;
>  
> @@ -142,30 +131,18 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
>  		 * check if write succeeded.
>  		 */
>  		iocbp = (struct iocb *)event.obj;
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
> +		if (event.res2 != 0 || event.res != iocbp->u.c.nbytes)
> +			tst_brk(TBROK,
> +					"AIO write offset %lld expected %ld got %ld",
> +					iocbp->u.c.offset, iocbp->u.c.nbytes,
> +					event.res);

This is a bit strangely formatted, there is no point to start the string
on newline here.


>  		/* start next write */
>  		io_prep_pwrite(iocbp, fd, iocbp->u.c.buf, writesize, offset);
>  		offset += writesize;
> -		if ((w = io_submit(myctx, 1, &iocbp)) < 0) {
> -			tst_resm(TBROK, "io_submit failed at offset %ld",
> -				 offset);
> -			break;
> -		}
> -
> -		if (debug)
> -			tst_resm(TINFO, "io_submit() return %d", w);
> +		w = io_submit(myctx, 1, &iocbp);
> +		if (w < 0)
> +			tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
>  
>  		aio_inflight++;
>  	}
> @@ -177,161 +154,67 @@ int aiodio_sparse(int fd, int align, int writesize, int filesize, int num_aio)
>  		int n;
>  		struct iocb *iocbp;
>  
> -		if ((n = io_getevents(myctx, 1, 1, &event, 0)) != 1) {
> -			tst_resm(TBROK, "io_getevents failed");
> -			break;
> -		}
> +		n = io_getevents(myctx, 1, 1, &event, 0);
> +		if (n != 1)
> +			tst_brk(TBROK, "io_getevents failed");
> +
>  		aio_inflight--;
> +
>  		/*
>  		 * check if write succeeded.
>  		 */
>  		iocbp = (struct iocb *)event.obj;
> -		if (event.res2 != 0 || event.res != iocbp->u.c.nbytes) {
> -			tst_resm(TBROK,
> -				 "AIO write offset %lld expected %ld got %ld",
> -				 iocbp->u.c.offset, iocbp->u.c.nbytes,
> -				 event.res);
> -		}
> +		if (event.res2 != 0 || event.res != iocbp->u.c.nbytes)
> +			tst_brk(TBROK,
> +					"AIO write offset %lld expected %ld got %ld",
> +					iocbp->u.c.offset, iocbp->u.c.nbytes,
> +					event.res);

Here as well.

Also there is some code repetition, it would probably make the code
clearner if we added a check_result() function to check the event and
maybe submit_write() that would do the io_prep_write(), io_submit() and
adjust the offset.

>  	}
> +}
>  
> -	return 0;
> +static void setup(void)
> +{
> +	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }
>  
> -static void usage(void)
> +static void cleanup(void)
>  {
> -	fprintf(stderr, "usage: dio_sparse [-n children] [-s filesize]"
> -		" [-w writesize]\n");
> -	exit(1);
> +	SAFE_MUNMAP(run_child, sizeof(int));
>  }
>  
> -int main(int argc, char **argv)
> +static void run(void)
>  {
> -	char *filename = "aiodio_sparse";
> -	int pid[NUM_CHILDREN];
> -	int num_children = 1;
> +	int status;
>  	int i;
> -	long alignment = 512;
> -	int writesize = 65536;
> -	int filesize = 100 * 1024 * 1024;
> -	int num_aio = 16;
> -	int children_errors = 0;
> -	int c;
> -	int ret;
> -
> -	while ((c = getopt(argc, argv, "dw:n:a:s:i:")) != -1) {
> -		char *endp;
> -		switch (c) {
> -		case 'd':
> -			debug++;
> -			break;
> -		case 'i':
> -			num_aio = atoi(optarg);
> -			break;
> -		case 'a':
> -			alignment = strtol(optarg, &endp, 0);
> -			alignment = (int)scale_by_kmg((long long)alignment,
> -						      *endp);
> -			break;
> -		case 'w':
> -			writesize = strtol(optarg, &endp, 0);
> -			writesize =
> -			    (int)scale_by_kmg((long long)writesize, *endp);
> -			break;
> -		case 's':
> -			filesize = strtol(optarg, &endp, 0);
> -			filesize =
> -			    (int)scale_by_kmg((long long)filesize, *endp);
> -			break;
> -		case 'n':
> -			num_children = atoi(optarg);
> -			if (num_children > NUM_CHILDREN) {
> -				fprintf(stderr,
> -					"number of children limited to %d\n",
> -					NUM_CHILDREN);
> -				num_children = NUM_CHILDREN;
> -			}
> -			break;
> -		case '?':
> -			usage();
> -			break;
> -		}
> -	}

And here as well, these should be kept as command line test parameters.

> -	setup();
> -	tst_resm(TINFO, "Dirtying free blocks");
> -	dirty_freeblocks(filesize);

Where did this go? I guess that we should put it into the test setup.

> -	fd = SAFE_OPEN(cleanup, filename,
> -		O_DIRECT | O_WRONLY | O_CREAT | O_EXCL, 0600);
> -	SAFE_FTRUNCATE(cleanup, fd, filesize);
> -
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
> -
> -	ret = aiodio_sparse(fd, alignment, writesize, filesize, num_aio);
> -
> -	tst_resm(TINFO, "Killing childrens(s)");
> -
> -	for (i = 0; i < num_children; i++)
> -		kill(pid[i], SIGTERM);
> +	*run_child = 1;
>  
> -	for (i = 0; i < num_children; i++) {
> -		int status;
> -		pid_t p;
> -
> -		p = waitpid(pid[i], &status, 0);
> -		if (p < 0) {
> -			tst_resm(TBROK | TERRNO, "waitpid()");
> -		} else {
> -			if (WIFEXITED(status) && WEXITSTATUS(status) == 10)
> -				children_errors++;
> +	for (i = 0; i < NUM_CHILDREN; i++) {
> +		if (!SAFE_FORK()) {
> +			read_sparse(FILE_NAME, FILE_SIZE);
> +			return;
>  		}
>  	}
>  
> -	if (children_errors)
> -		tst_resm(TFAIL, "%i children(s) exited abnormally",
> -			 children_errors);
> +	tst_res(TINFO, "Parent create a sparse file");
>  
> -	if (!children_errors && !ret)
> -		tst_resm(TPASS, "Test passed");
> +	aiodio_sparse(FILE_NAME, WRITE_SIZE, FILE_SIZE, NUM_AIO);
>  
> -	cleanup();
> -	tst_exit();
> -}
> +	if (SAFE_WAITPID(-1, &status, WNOHANG))
> +		tst_res(TFAIL, "Non zero bytes read");
> +	else
> +		tst_res(TPASS, "All bytes read were zeroed");
>  
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	tst_tmpdir();
> -}
> -
> -static void cleanup(void)
> -{
> -	if (fd > 0 && close(fd))
> -		tst_resm(TWARN | TERRNO, "Failed to close file");
> -
> -	tst_rmdir();
> +	*run_child = 0;
>  }
>  
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};
>  #else
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
> -}
> +TST_TEST_TCONF("test requires libaio and its development packages");
>  #endif
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
