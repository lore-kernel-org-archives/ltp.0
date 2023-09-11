Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9546BEE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 15:14:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B7C73CE844
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 17:14:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B14B83CC0F0
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 17:14:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 17C6E201DB8
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 17:14:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 493E81F38D;
 Mon, 11 Sep 2023 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694445249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQhuz0FQg9TKAlwmQueQSZmn3KLuhk0lKH2K3pcBo60=;
 b=gBN54uRE4FuhhnnElievES0ahLz5FznyhAbXaesRvpY10FMXsh6NkMXOf/KphwqgXBdGiA
 9cW+5vi/H3FWTkw4gq1s6S7zvs1JIeCoEYXpYiT31YozkDOOIkGe7AI2ZW8Rgvj+SEQECX
 djgwSV1V08qhm+U3N60iR+fOZlWJaT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694445249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQhuz0FQg9TKAlwmQueQSZmn3KLuhk0lKH2K3pcBo60=;
 b=GIxrKm1cdSdsheEHbPpCHLcg5ZzWE2lGVxG8S0aDr4CNZJ9JHS2aka9qZwSTOV1q7/s3NB
 PqVIHt6Hbh3mm4AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3218B13780;
 Mon, 11 Sep 2023 15:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sRH4CsEu/2TpYgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 11 Sep 2023 15:14:09 +0000
Date: Mon, 11 Sep 2023 17:14:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZP8u7Zf0GZpi5TpF@yuki>
References: <20230911120408.31921-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230911120408.31921-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Avoid messing with system tty in ioctl01.c
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
> * Use `openpty()` to create a new tty
> * Remove `-D` option
> * Remove requirement to run as root
> 
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>  runtest/syscalls                           |  2 +-
>  testcases/kernel/syscalls/ioctl/ioctl01.c  | 25 ++++++++++------------
>  testcases/kernel/syscalls/ioctl/test_ioctl | 23 --------------------
>  3 files changed, 12 insertions(+), 38 deletions(-)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b1125dd75..f999bd74f 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -557,10 +557,10 @@ init_module01 init_module01
>  init_module02 init_module02
>  
>  #Needs tty device.
> -#ioctl01 ioctl01 -D /dev/tty0
>  #ioctl02 ioctl02 -D /dev/tty0
>  
>  # Introducing ioctl tests for all /dev/tty* devices
> +ioctl01      ioctl01
>  ioctl01_02   test_ioctl

This should be renamed to ioctl02 now I suppose.

>  ioctl03      ioctl03
>  ioctl04      ioctl04
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 3ca8a9a3b..fe6a5591d 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -23,11 +23,13 @@
>  #include <fcntl.h>
>  #include <stdio.h>
>  #include <termios.h>
> +#include <pty.h>
>  #include "tst_test.h"
>  #include "lapi/ioctl.h"
>  
>  #define	INVAL_IOCTL	9999999
>  
> +static int amaster, aslave;
>  static int fd, fd_file;
>  static int bfd = -1;
>  
> @@ -59,8 +61,6 @@ static struct tcase {
>  	{&fd, TCGETS, NULL, EFAULT}
>  };
>  
> -static char *device;
> -
>  static void verify_ioctl(unsigned int i)
>  {
>  	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
> @@ -69,31 +69,28 @@ static void verify_ioctl(unsigned int i)
>  
>  static void setup(void)
>  {
> -	if (!device)
> -		tst_brk(TBROK, "You must specify a tty device with -D option");
> +	if (openpty(&amaster, &aslave, NULL, &termios, NULL) < 0) {
> +		tst_brk(TBROK | TERRNO, "unable to open pty");
> +	}

It's better just to pass NULL instead of the zero filled &termios here.

The rest looks good to me, if you agree I can merge the patch with the
changes I've proposed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
