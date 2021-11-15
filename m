Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB83C433EF
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 17:26:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1322A63255
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 17:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1322A63255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C05673C875F
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 18:25:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6651B3C8254
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 18:25:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7AD0F1001143
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 18:25:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94F021FD6F;
 Mon, 15 Nov 2021 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636997146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87SEdTZlhqhGSYNMyYuf09VQeE8bsj6FhZLu0USGwwI=;
 b=tpRlh6Gf6BcK/YynXj+V12lxkXHXDGAiKzJWGqp0Z5T4/lnrdxvA2A3g/P+XSDdrp6JQri
 tRlWvlTNcE24CuOzVGpHluAPm2nB1qxpkXLnhYZZi2IY+Nm/yAdkPb4r1mvdhgvdqYh75i
 q7J7OMxltDfgYmJ88HTYSZ66/XIVoZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636997146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87SEdTZlhqhGSYNMyYuf09VQeE8bsj6FhZLu0USGwwI=;
 b=spM0YyalwQBfW6ZKwYyreGCHib69QG9U2GRJRYXlvO06ha/Izqx15bk7D+Q428Mqw9y1/2
 E146KRXnpjTMQaCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CB8013A66;
 Mon, 15 Nov 2021 17:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vYefHRqYkmHwKQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Nov 2021 17:25:46 +0000
Date: Mon, 15 Nov 2021 18:26:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <acervesato@suse.de>
Message-ID: <YZKYWtT/Shn8N4+z@yuki>
References: <20211115134131.27939-1-acervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211115134131.27939-1-acervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] dio_truncate.c test refactory with LTP API
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
> +	int fd = 0;
> +	size_t i = 0;
> +	char *buf = NULL;

It's pointless to initalize variables that are not read back before they
are set.

> -int dio_read(char *filename)
> -{
> -	int fd;
> -	int r;
> -	void *bufptr = NULL;
> +	fd = SAFE_OPEN(path, O_CREAT|O_WRONLY|O_DIRECT, 0666);
> -	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
> +	buf = (char *)SAFE_MEMALIGN(getpagesize(), bs);
                ^
		Useless cast

> +	if (buf == 0) {

The most common way to check for NULL pointers in LKML C is just:

	if (!buf) {
		...
	}

> +		SAFE_CLOSE(fd);
>  		return -1;
>  	}
>  
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
> -				}
> -				offset += r;
> -			}
> -		} while (r > 0);
> +	for (i = 0; i < bs; i++)
> +		buf[i] = pattern;

Why not just memset(buf, pattern, bs) ?

> +	for (i = 0; i < bcount; i++) {
> +		if (write(fd, buf, bs) != (ssize_t)bs) {
> +			free(buf);

			SAFE_CLOSE(fd) here?

> +			return -1;
> +		}
>  	}
> +
> +	SAFE_CLOSE(fd);
> +
>  	return 0;
>  }
>  
> -void dio_append(char *filename, int fill)
> +int dio_get_zeros(const char *path, size_t bs)

Should be static.

>  {
> -	int fd;
> +	int i = 0;
> +	int fd = 0;
> +	int zeros = 0;
>  	void *bufptr = NULL;
> -	int i;
> -	int w;
>  
> -	fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);
> +	fd = SAFE_OPEN(path, O_RDONLY|O_DIRECT, 0666);
                                    ^
				    We usually prefer spaces between bit
				    or as it's easier to read

> -	if (fd < 0) {
> -		perror("cannot create file");
> -		return;
> -	}
> +	bufptr = SAFE_MALLOC(bs * sizeof(void));
                                  ^
				  Is sizeof(void) even defined?!

I guess that in this case it was supposed to be byte array so
sizeof(char) but sizeof(char) is 1 by definition.

> +	SAFE_READ(0, fd, bufptr, bs);

If you pass 0 as the first argument of the SAFE_READ() it can return
less than the requested amount of data.

> -	TEST(posix_memalign(&bufptr, 4096, 64 * 1024));
> -	if (TEST_RETURN) {
> -		tst_resm(TBROK | TRERRNO, "cannot malloc aligned memory");
> -		close(fd);
> -		return;
> +	for (i = 0; i < (int)bs; i++) {
> +		if (*(char *)bufptr == 0)

Can we just define the bufptr as char * instead and use bufptr[i] here?

> +			zeros++;
> +		bufptr++;
>  	}
>  
> -	memset(bufptr, fill, 64 * 1024);
> +	SAFE_CLOSE(fd);
>  
> -	for (i = 0; i < 1000; i++) {
> -		if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
> -			fprintf(stderr, "write %d returned %d\n", i, w);
> -		}
> -	}
> -	close(fd);
> +	return zeros;
>  }
>  
> -int main(void)
> +off_t getsize(const char *filename)

Here as well should be static.

>  {
> -	char filename[PATH_MAX];
> -	int pid[NUM_CHILDREN];
> -	int num_children = 1;
> -	int i;
> -
> -	snprintf(filename, sizeof(filename), "%s/aiodio/file",
> -		 getenv("TMP") ? getenv("TMP") : "/tmp");
> -
> -	for (i = 0; i < num_children; i++) {
> -		if ((pid[i] = fork()) == 0) {
> -			/* child */
> -			return dio_read(filename);
> -		} else if (pid[i] < 0) {
> -			/* error */
> -			perror("fork error");
> -			break;
> -		} else {
> -			/* Parent */
> -			continue;
> -		}
> -	}
> +	struct stat st;
>  
> -	/*
> -	 * Parent creates a zero file using DIO.
> -	 * Truncates it to zero
> -	 * Create another file with '0xaa'
> -	 */
> -	for (i = 0; i < 100; i++) {
> -		dio_append(filename, 0);
> -		truncate(filename, 0);
> -		dio_append("junkfile", 0xaa);
> -		truncate("junkfile", 0);
> -	}
> +	if (SAFE_STAT(filename, &st) == 0)

SAFE_MACROS() exit the test on failure, that is the whole purpose of
them.

> +		return st.st_size;
> +
> +	return -1;
> +}
> +
> +static void run(void)
> +{
> +	int charnum = 0;
> +	long empty_ch = FILESIZE - STARTING_CHARS;
> +
> +	tst_res(TINFO, "Create %s filled with %d chars", FILENAME, STARTING_CHARS);
> +	dio_append(FILENAME, 'a', STARTING_CHARS, 1);
>  
> -	for (i = 0; i < num_children; i++) {
> -		kill(pid[i], SIGTERM);
> +	/* Truncate to a bigger file and check if it's filled with empty chars */
> +	tst_res(TINFO, "Truncate to %ld", FILESIZE);
> +	TST_EXP_POSITIVE(truncate(FILENAME, FILESIZE), "truncate(%s, %lu)", FILENAME, FILESIZE);

SAFE_TRUNCATE() here?

> +	if (!TST_PASS)
> +		return;
> +
> +	TEST(getsize(FILENAME));

The TEST() macro is supposed to be used in cases where we need to store
errno in order to make sure that it's not rewritten in subsequent system
calls. It's pointeles to use it here.

> +	if (TST_RET == FILESIZE) {
> +		tst_res(TPASS, "Truncated file has %ld length", TST_RET);
> +
> +		charnum = dio_get_zeros(FILENAME, FILESIZE);
> +
> +		if (charnum == empty_ch)
> +			tst_res(TPASS, "Truncated file provides %ld empty chars at the end", empty_ch);
> +		else
> +			tst_res(TFAIL, "Truncated file isn't filled with %i chars", charnum);
> +	} else {
> +		tst_res(TFAIL, "Truncated file doesn't have %ld length but %ld", FILESIZE, TST_RET);
>  	}
>  
> -	return 0;
> +	/* Truncate to zero: file must be empty */
> +	tst_res(TINFO, "Truncate to zero");
> +	TST_EXP_POSITIVE(truncate(FILENAME, 0), "truncate(%s, 0)", FILENAME);
> +	if (!TST_PASS)
> +		return;
> +
> +	TEST(getsize(FILENAME));
> +	if (TST_RET == 0)
> +		tst_res(TPASS, "Truncated file has zero length");
> +	else
> +		tst_res(TFAIL, "Truncated file doesn't have zero length");


Where are the children that do dio_read(FILENAME) on background while
the parent does this?

Also why don't we do N iterations of the test as we did before?

Also where is the part where we write to an unrelated file?

The point of this test is to check that the child processes read zeroes
using direct I/O when the parent does:

	in a loop:

	1. writes zeroes to the file being read
	2. truncates the file being read
	3. writes non-zero in an unrelated file
	4. truncates unrelated file

So the pass/success should be determined by the children and not the
parent here.

There are couple of solution there, but I guess that ideally:

* The child process will exit with 1 once it has found anything that is
  not zero

* The parent will check with waitpid() and WNOHANG if there is a child
  that has exitted in each loop iteration, if so kill children and fail the test

* If the parent is out of loops, kill the children and pass the test

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
