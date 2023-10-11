Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EF3CD6E41
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 08:47:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47BE13CD6DD
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 10:47:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1EA3C0313
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:47:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 31A9F201DDE
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:47:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C3C321116;
 Wed, 11 Oct 2023 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697014026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ijo1Z9f64cpCtzKnZUwBWjyIUsmwDPaQpsWdrtNTCk0=;
 b=bSiQxWhfphTEmTuZxDqTvjPxp9AtDNVrfihJ/fbnzH5PDLk9B09tftOGMbSH/47Z9oqQUT
 /vkeLR8Vp5g5iqTylRiqPUjNWbAdrgb5EWZmotNGp3Euj9Xy6ieNgJ2rUhqwPYkTCYNL9W
 oWJ0Z33jJWfVQSL4RiLRrNz2T7cXy48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697014026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ijo1Z9f64cpCtzKnZUwBWjyIUsmwDPaQpsWdrtNTCk0=;
 b=DYpKMV1lQtPdOp9wDqrfuhWb2tCZvLeinP1K5W6SYg5P5Y+lbftwxMIBv4z+L7eYvmMFqI
 JNRSoGCzW2JLxLBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BB00134F5;
 Wed, 11 Oct 2023 08:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /m3CEQphJmXHKgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 11 Oct 2023 08:47:06 +0000
Date: Wed, 11 Oct 2023 10:47:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Xin Wang <Xin.Wang@windriver.com>
Message-ID: <ZSZhNWqK-MvqWHHA@yuki>
References: <20231011025323.1558560-1-Xin.Wang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011025323.1558560-1-Xin.Wang@windriver.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] enable fsx-linux.c running on VxWorks user space
 and add measurement of execution time
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
> I come from Wind River. We and our customers used fsx-linux for file
> system testing on VxWorks user space and total execution time also
> received more attention in the testing.  So I upstream the change of
> VxWorks compatibility parts on this patch, wish to enlarge the test
> support of fsx-linux.  There is a point need to explain, because
> current VxWorks doesn't support CLOCK_MONOTONIC_RAW , CLOCK_MONOTONIC
> is still used by VxWorks when calling clock_gettime.  When
> CLOCK_MONOTONIC_RAW is support by VxWorks in the future, this part
> will be removed.

Actually Andrea started to clean up and rewrite the test so that it uses
LTP API and he will send a patch soon, can you please send a new patch
once that rewrite is finished?

A few comments below.

> Signed-off-by: Xin.Wang@windriver.com
> ---
>  testcases/kernel/fs/fsx-linux/fsx-linux.c | 44 ++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> index 64c27a0f5..2064fac16 100644
> --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> @@ -39,8 +39,10 @@
>  
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#if defined(_UWIN) || defined(__linux__)
> +#if defined(_UWIN) || defined(__linux__) || defined(__VXWORKS__)
> +#if !defined(__VXWORKS__)
>  #include <sys/param.h>
> +#endif
>  #include <limits.h>
>  #include <time.h>
>  #include <string.h>
> @@ -849,7 +851,12 @@ void domapwrite(unsigned offset, unsigned size)
>  		gettimeofday(&t, NULL);
>  		prt("       %lu.%06lu memcpy done\n", t.tv_sec, t.tv_usec);
>  	}
> -	if (msync(p, map_size, 0) != 0) {
> +#ifdef MS_SYNC
> +	if (msync(p, map_size, MS_SYNC) != 0)
> +#else
> +	if (msync(p, map_size, 0) != 0) 
> +#endif

It would be better to define MS_SYNC to 0 on VXWORKS instead.

> +	{
>  		prterr("domapwrite: msync");
>  		report_failure(203);
>  	}
> @@ -1115,11 +1122,16 @@ int main(int argc, char **argv)
>  	int i, style, ch;
>  	char *endp;
>  	int dirpath = 0;
> -
> +	struct timespec time_start, time_end, time_diff;
> +	
>  	goodfile[0] = 0;
>  	logfile[0] = 0;
>  
> +#if defined(__VXWORKS__)
> +	page_size = (int)sysconf(_SC_PAGESIZE);

We can just use sysconf() everywhere instead.

> +#else
>  	page_size = getpagesize();
> +#endif
>  	page_mask = page_size - 1;
>  
>  	setvbuf(stdout, NULL, _IOLBF, 0);	/* line buffered stdout */
> @@ -1267,9 +1279,12 @@ int main(int argc, char **argv)
>  	signal(SIGUSR1, cleanup);
>  	signal(SIGUSR2, cleanup);
>  
> +#if defined(__VXWORKS__)
> +	srand(seed);
> +#else
>  	initstate(seed, state, 256);
>  	setstate(state);
> -
> +#endif
>  	open_test_files(argv, argc);
>  
>  	strncat(goodfile, dirpath ? basename(fname) : fname, 256);
> @@ -1336,12 +1351,33 @@ int main(int argc, char **argv)
>  	} else
>  		check_trunc_hack();
>  
> +#if defined(__VXWORKS__)
> +	clock_gettime(CLOCK_MONOTONIC, &time_start);
> +#else
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &time_start);
> +#endif

And here it would be cleaner to define the clock to use instead of
ifdefing each clock_gettime call. I.e.:

#if defined(__VXWORKS__)
# define CLOCK_ID CLOCK_MONOTONIC
#else
# define CLOCK_ID CLOCK_MONOTONIC_RAW
#endif

>  	while (numops == -1 || numops--)
>  		test();
>  
>  	close_test_files();
> +#if defined(__VXWORKS__)
> +	clock_gettime(CLOCK_MONOTONIC, &time_end);
> +#else
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &time_end);
> +#endif
> +
>  	prt("All operations completed A-OK!\n");
>  
> +	if (time_end.tv_nsec < time_start.tv_nsec) {
> +		time_end.tv_nsec += 1000000000;
> +		time_end.tv_sec -= 1; 
> +	}
> +	time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
> +	time_diff.tv_nsec = time_end.tv_nsec - time_start.tv_nsec;

LTP has functions for operations with timespec, here you should use
tst_timespec_diff()

> +	prt("Elapsed Test Time %lu.%09lu\n",
> +        (unsigned long)time_diff.tv_sec, time_diff.tv_nsec);
> +	
>  	if (tf_buf)
>  		free(tf_buf);
>  
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
