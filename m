Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A9C433EF
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 10:50:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F2E61B5F
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 10:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19F2E61B5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47B813C8862
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 11:50:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6E013C053E
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 11:50:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD523200FE0
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 11:50:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F10CA1FD35;
 Thu, 18 Nov 2021 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637232633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XudkjYPIOQi+TgB4fHJ+3lQ/v3UcBIfBIZl3GvBEAOM=;
 b=d1weRefxfPkOpw5pJC2847rjdA3w7CVfbAo1u0Q8X96EC4+beTktFrnELAXnFzIU+WZYYO
 dSaNGkZ2jXUfTdZt2Rzk2bHLMVE6P6Q7L1sSFx6NvMPg9FwayelJ9ziCFxIg8lU6+Uxm4N
 Il2xw5pg0jxIJds3yejFWsPVOKPide8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637232633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XudkjYPIOQi+TgB4fHJ+3lQ/v3UcBIfBIZl3GvBEAOM=;
 b=TVWhvDY3Wwfq8jNGNzNQCaHZ3A+pPULjoDi9O375/0eY1KU39J1hTTk4ynz1NKq8uiZl7J
 dTVEYzfppAcBO9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCA7A13C74;
 Thu, 18 Nov 2021 10:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IJB2NPkvlmECGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 18 Nov 2021 10:50:33 +0000
Date: Thu, 18 Nov 2021 11:51:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <acervesato@suse.de>
Message-ID: <YZYwO3aOT1A4wHh2@yuki>
References: <20211117164729.29586-1-acervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211117164729.29586-1-acervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] dio_truncate.c test refactory with LTP API
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
This version is much better, there are still a few things to fix though.

Also something I haven't caught in previous reviews, the pach is missing
signed-off-by: line. See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

In short you should configure git with user name and email and then
commit with -s.

>  #define _GNU_SOURCE
>  
>  #include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/stat.h>
>  #include <sys/types.h>
> -#include <signal.h>
> -#include <errno.h>
>  #include <fcntl.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <memory.h>
> -#include <string.h>
> -#include <limits.h>
> -
> -#include "test.h"
> +#include "tst_test.h"
>  
> -#define NUM_CHILDREN 8
> +#define NUM_CHILDREN 10
> +#define FILE_SIZE (64 * 1024)
>  
> -char *check_zero(unsigned char *buf, int size)
> -{
> -	unsigned char *p;
> -
> -	p = buf;
> -
> -	while (size > 0) {
> -		if (*buf != 0) {
> -			fprintf(stderr,
> -				"non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
> -				buf - p, (unsigned int)buf[0],
> -				size > 1 ? (unsigned int)buf[1] : 0,
> -				size > 2 ? (unsigned int)buf[2] : 0,
> -				size > 3 ? (unsigned int)buf[3] : 0);
> -			fprintf(stderr, "buf %p, p %p\n", buf, p);
> -			return buf;
> -		}
> -		buf++;
> -		size--;
> -	}
> -	return 0;		/* all zeros */
> -}
> -
> -int dio_read(char *filename)
> +static void dio_read(const char *filename, size_t bs, size_t bcount)
>  {
>  	int fd;
> -	int r;
> -	void *bufptr = NULL;
> -
> -	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
> -		return -1;
> -	}
> -
> -	while ((fd = open(filename, O_DIRECT | O_RDONLY)) < 0) {
> -	}
> -	fprintf(stderr, "dio_truncate: child reading file\n");
> -	while (1) {
> -		off_t offset;
> -		char *bufoff;
> -
> -		/* read the file, checking for zeros */
> -		offset = lseek(fd, SEEK_SET, 0);
> -		do {
> -			r = read(fd, bufptr, 64 * 1024);
> -			if (r > 0) {
> -				if ((bufoff = check_zero(bufptr, r))) {
> -					fprintf(stderr,
> -						"non-zero read at offset %p\n",
> -						offset + bufoff);
> -					exit(1);
> +	size_t i;
> +	char *bufptr;
> +	size_t iter = 0;
> +
> +	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
> +
> +	while ((fd = open(filename, O_RDONLY | O_DIRECT, 0666)) < 0)
> +		;

We usually put short usleep() here to give the other threads chance to
run before we retry. Something as usleep(100); will do.

> +	tst_res(TINFO, "child reading file");
> +	while (iter < bcount) {
> +		SAFE_LSEEK(fd, SEEK_SET, 0);
> +
> +		if (read(fd, bufptr, bs) > 0) {
> +			for (i = 0; i < bs; i++) {
> +				if (*bufptr != 0) {
> +					tst_res(TFAIL, "non zero buffer at %lu", i);
> +					SAFE_CLOSE(fd);
> +					return;
>  				}
> -				offset += r;
> +				bufptr++;
>  			}
> -		} while (r > 0);
> +		}

You cannot really blindly trust read that it has returned as much as you
have asked for, especially when the file is being written to/truncated
by the other thread, it may return much less.

And the child processes should really continue to read until they are
told to stop. Since as it is they stop before the main thread finishes
writing to the file, which is kind of useless. I think that the optimal
way how to structure the test is to:

- the child exits the loop at the first non-zero byte

- the parent process that writes to the files checks if there is a child
  that did exit with SAFE_WAIPID(-1, &status, WNOHANG); and if there is
  one exits the whole test

- when the parent process has finished it signals the children to exit

  There are various ways how to do that:

    - the child sets up a signal handler that would set global variable
      should_run to 0
    - the child then has a while (should_run) { } in the main loop
    - parent signals all the children and they would exit


    - parent kills the children with SIGKILL and then waits them in a
      loop until there are none left


    - parent sets up a piece of shared memory with int *should_run = mmap(...);
    - the children do while (*should_run) { } in the main loop
    - parent does *should_run = 0 to stop them


Also I think that it was better structured when the non-zero check was
in a separate function and printed the actuall bytes and offset.

> +		iter++;
> +		usleep(150);
>  	}
> -	return 0;
> +
> +	SAFE_CLOSE(fd);
> +
> +	tst_res(TPASS, "zero buffer only after truncate");
>  }
>  
> -void dio_append(char *filename, int fill)
> +static void dio_append(const char *path, char pattern, size_t bs, size_t bcount)
>  {
>  	int fd;
> -	void *bufptr = NULL;
> -	int i;
> -	int w;
> +	size_t i;
> +	char *bufptr;
>  
> -	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> +	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
> +	memset(bufptr, pattern, bs);
>  
> -	if (fd < 0) {
> -		perror("cannot create file");
> -		return;
> -	}
> -
> -	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
> -		close(fd);
> -		return;
> -	}
> +	fd = SAFE_OPEN(path, O_CREAT | O_WRONLY | O_DIRECT, 0666);
>  
> -	memset(bufptr, fill, 64 * 1024);
> +	for (i = 0; i < bcount; i++)
> +		SAFE_WRITE(1, fd, bufptr, bs);
>  
> -	for (i = 0; i < 1000; i++) {
> -		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
> -			fprintf(stderr, "write %d returned %d\n", i, w);
> -		}
> -	}
> -	close(fd);
> +	SAFE_CLOSE(fd);
>  }
>  
> -int main(void)
> +static void run(void)
>  {
> -	char filename[PATH_MAX];
> +	char *filename = "file";
> +	int filesize = FILE_SIZE;
> +	int num_children = NUM_CHILDREN;
>  	int pid[NUM_CHILDREN];
> -	int num_children = 1;
>  	int i;
>  
> -	snprintf(filename, sizeof(filename), "%s/aiodio/file",
> -		 getenv("TMP") ? getenv("TMP") : "/tmp");
> -
>  	for (i = 0; i < num_children; i++) {
> -		if ((pid[i] = fork()) == 0) {
> +		pid[i] = fork();
> +		if (pid[i] == 0) {
>  			/* child */
> -			return dio_read(filename);
> +			dio_read(filename, filesize, 1000);
> +			return;
>  		} else if (pid[i] < 0) {
>  			/* error */
> -			perror("fork error");
> +			tst_brk(TBROK, "fork error");
>  			break;
> -		} else {
> -			/* Parent */
> -			continue;
>  		}
>  	}

Please use SAFE_FORK() instead.

> @@ -161,17 +93,20 @@ int main(void)
>  	 * Parent creates a zero file using DIO.
>  	 * Truncates it to zero
>  	 * Create another file with '0xaa'
> +	 * Truncates it to zero
>  	 */

This description should be moved to a top level special documentation
comment and formatted in asciidoc so that it's picked up by the
documentation parser.

The comment looks like:

/*\
 * [Description]
 *
 * This is an ascii doc formatted test description.
 *
 * - list item #1
 * - list item #2
 */

And when you have asciidoc installed the LTP builds a
docparse/metadata.html file which contains the documentation for all
tests that have it included.

I guess that we should write some documentation for the format as
well.

>  	for (i = 0; i < 100; i++) {
> -		dio_append(filename, 0);
> -		truncate(filename, 0);
> -		dio_append("junkfile", 0xaa);
> -		truncate("junkfile", 0);
> +		dio_append(filename, 0, filesize, 200);
> +		SAFE_TRUNCATE(filename, 0);
> +		dio_append("junkfile", 0xaa, filesize, 200);
> +		SAFE_TRUNCATE("junkfile", 0);
>  	}
>  
> -	for (i = 0; i < num_children; i++) {
> -		kill(pid[i], SIGTERM);
> -	}
> -
> -	return 0;
> +	for (i = 0; i < num_children; i++)
> +		SAFE_KILL(pid[i], SIGTERM);
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test_all = run,
> +};
> -- 
> 2.33.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
