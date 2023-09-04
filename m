Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308BEC71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 15:04:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46F313CEBEE
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 17:04:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4C873CB846
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 17:04:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F038A60067A
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 17:04:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2B031F38C;
 Mon,  4 Sep 2023 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693839852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnQjgl36gD8uF4bZAqJxK6GVi5wPsKbPC82x/obOUMM=;
 b=F5qv0/0+6tL5kuRQtfld89W6kF0r6rHxeo8FE/1IKldoXIgQMbZh1mgxWX42hE516UGVfY
 HMHdpcihRGgo9PfiJ1ax9PLZnj/9M68xllXwp/x7LZND1TILjQJ8ARKGPfVAlc4rMqXQD1
 +riItuMUbIjeS++4lusSnmtIIJocQRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693839852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnQjgl36gD8uF4bZAqJxK6GVi5wPsKbPC82x/obOUMM=;
 b=2mnjKdzgUiBNOKotIibVnJ8hbDRabEkPDjOOd21ytJTaKNLVmdi3SYI/v2O8kUnK1cp4Jc
 N4uopFz3clYqHXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD52B13585;
 Mon,  4 Sep 2023 15:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RTd3LOzx9WShQQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 04 Sep 2023 15:04:12 +0000
Date: Mon, 4 Sep 2023 17:04:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZPXyE9O38JHxfiV0@yuki>
References: <20230904145035.22939-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230904145035.22939-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Use correct ioctl request for termios
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
>  testcases/kernel/syscalls/ioctl/ioctl01.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 1be38e79d..983208925 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -36,34 +36,35 @@ static struct termios termios;
>  
>  static struct tcase {
>  	int *fd;
> -	int request;
> +	int request_tio;
> +	int request_tios;
>  	struct termio *s_tio;
>  	struct termios *s_tios;
>  	int error;

I guess that it would be cleaner to keep the single request, but define
the s_tio as a void * here.

That way we can add test on a separate lines:

	{&bfd, TCGETA, &termio, EBADF},
	{&bfd, TCGETS, &termios, EBADF},
	...


And have single TST_EXP_FAIL() in the verify function.

>  } tcases[] = {
>  	/* file descriptor is invalid */
> -	{&bfd, TCGETA, &termio, &termios, EBADF},
> +	{&bfd, TCGETA, TCGETS, &termio, &termios, EBADF},
>  	/* termio address is invalid */
> -	{&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
> -	/* command is invalid */
> +	{&fd, TCGETA, TCGETS, (struct termio *)-1, (struct termios *)-1, EFAULT},
> +	// /* command is invalid */
>  	/* This errno value was changed from EINVAL to ENOTTY
>  	 * by kernel commit 07d106d0 and bbb63c51
>  	 */
> -	{&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
> +	{&fd, INVAL_IOCTL, INVAL_IOCTL, &termio, &termios, ENOTTY},
>  	/* file descriptor is for a regular file */
> -	{&fd_file, TCGETA, &termio, &termios, ENOTTY},
> +	{&fd_file, TCGETA, TCGETS, &termio, &termios, ENOTTY},
>  	/* termio is NULL */
> -	{&fd, TCGETA, NULL, NULL, EFAULT}
> +	{&fd, TCGETA, TCGETS, NULL, NULL, EFAULT}
>  };
>  
>  static char *device;
>  
>  static void verify_ioctl(unsigned int i)
>  {
> -	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
> +	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tio, tcases[i].s_tio),
>  		     tcases[i].error);
>  
> -	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios),
> +	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tios, tcases[i].s_tios),
>  		     tcases[i].error);
>  }
>  
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
