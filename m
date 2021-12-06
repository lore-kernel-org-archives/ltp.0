Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB56C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 14:55:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52F353C2183
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 15:55:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7983C1CBE
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 15:55:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5C5360076D
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 15:55:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E03B3212C1;
 Mon,  6 Dec 2021 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638802529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Su01SKsQX3eek1HUU8rxGlOebyPSpFKiUque2g3ok1M=;
 b=Kyf0bFfpbD5dW921YA6UlAoYSmmWqC11TKDgQnggdEKNAFzc2HktH/XnkWP0G/zlV1M8Nl
 jKo2HgUjqSiT00XrsGKudl6ZHTBqYkJjGMYRzHb51Bc6a06zhRtbZdAUk+C7jWpV8oEMPF
 u8185Xt7xXz+W7j4w6UwrY/2D9FSE/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638802529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Su01SKsQX3eek1HUU8rxGlOebyPSpFKiUque2g3ok1M=;
 b=pp+tQZbujUjzR/E+edaAkl+IvA8sB7Bwx2lPQOPXQRoYYzhVkJyMzos0esGdkxj2t6I+SM
 q9lko0e8xJvG6tAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C78F113BBC;
 Mon,  6 Dec 2021 14:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f0zWLWEkrmH5RwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Dec 2021 14:55:29 +0000
Date: Mon, 6 Dec 2021 15:56:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Ya4krWQ5h7jTbHn+@yuki>
References: <20211206095652.6181-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206095652.6181-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactoring aiodio_append.c test using LTP API
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
> +#define FILE_NAME "aiodio_append"
>  #define NUM_CHILDREN 8
> +#define NUM_AIO 16
> +#define AIO_SIZE (64 * 1024)
> +#define FILE_SIZE (64 * 1024)

I guess that we should make these as defaults and allow the number of
children, etc. to be changed via command line parameters later on in an
subsequent patches...

> +static int *run_child;
>  
> -int read_eof(char *filename)
> +static void read_eof(const char *filename, size_t bs)
>  {
>  	int fd;
> -	int i;
>  	int r;
> -	char buf[4096];
> +	char *bufptr;
>  
> -	while ((fd = open(filename, O_RDONLY)) < 0) {
> -		sleep(1);	/* wait for file to be created */
> -	}
> +	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
> +		usleep(100);
>  
> -	for (i = 0; i < 1000000; i++) {
> +	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
> +
> +	tst_res(TINFO, "child %i reading file", getpid());
> +	while (*run_child) {
>  		off_t offset;
>  		char *bufoff;
>  
> -		offset = lseek(fd, SEEK_END, 0);
> -		r = read(fd, buf, 4096);
> -		if (r > 0) {
> -			if ((bufoff = check_zero(buf, r))) {
> -				fprintf(stderr, "non-zero read at offset %p\n",
> -					offset + bufoff);
> -				exit(1);
> +		offset = SAFE_LSEEK(fd, 0, SEEK_END);
> +		do {
> +			r = SAFE_READ(0, fd, bufptr, bs);
> +			if (r > 0) {
> +				bufoff = check_zero(bufptr, r);
> +				if (bufoff) {
> +					tst_res(TINFO, "non-zero read at offset %zu",
> +						offset + (bufoff - bufptr));
> +					free(bufptr);
> +					SAFE_CLOSE(fd);
> +					return;
> +				}
> +				offset += r;
>  			}
> -		}
> +		} while (r > 0);
>  	}
> -	return 0;
> -}
>  
> -#define NUM_AIO 16
> -#define AIO_SIZE 64*1024
> +	free(bufptr);
> +	SAFE_CLOSE(fd);
> +}

My comment for v1 still applies here, there should be only one instance
of this loop in the source tree.

The rest of the changes does look OK.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
