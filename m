Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36371C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 15:34:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF2113C9ECB
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:34:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5822D3C98C8
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:34:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B389600F88
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 16:34:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8164E21121;
 Thu, 10 Feb 2022 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644507247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9fScu2n7UOZG5iT10Rjm2jMwzAUfyHU3s5jvwPL2HaA=;
 b=2ZsZoMjW+h6tOW48QQbyYU3XgYR4/VKPEbqkzwh7GKbsfb/0xIbnkxJ+zjKQSXSQGeI7Sz
 8ifuNck/Tu69JA7QMCiXLk58Gfmt8BB7xHZOjx4zHBd1OENSPUBN0mDETqnBHZS74XsOt7
 oXpJ3XtdszxqhcdXrFeFIjv45nkQ/B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644507247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9fScu2n7UOZG5iT10Rjm2jMwzAUfyHU3s5jvwPL2HaA=;
 b=2T5xAeVGWDw+EM4yWz3s+Su3VEsFxhppBThQ5yf/2BanLslGY7uNCkFjmWACreg09d142E
 vZ/v4WZfRIRX4fAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 688B513BD6;
 Thu, 10 Feb 2022 15:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jAfkF28wBWK/FQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Feb 2022 15:34:07 +0000
Date: Thu, 10 Feb 2022 16:36:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kushal Chand <kushalkataria5@gmail.com>
Message-ID: <YgUw7scGZwUcK22E@yuki>
References: <20220210105101.38337-1-kushalkataria5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220210105101.38337-1-kushalkataria5@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fstat_02: Increase test coverage by creating
 hard link to file and validate using fstat
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
The subject should be shorter and more to the point, something as:

"fstat02: Validate st_nlink as well"

> Implements: #517

The code looks good now, but it's not complete solution to #517, there
are still many fields of the structure that are not checked and a few
more patches would be required to complete it.

For instance the st_blocks should be more or less equal size/512

And we should check the atime/mtime/ctime as well, but maybe it would be
easier if we do that in a separate test.

> This patch creates a hard link for a file during setup and checks if number of hardlinks
> match with the expected number.

This is missing Signed-off-by: line see:

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> ---
>  testcases/kernel/syscalls/fstat/fstat02.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
> index c0229de44..2f9632edf 100644
> --- a/testcases/kernel/syscalls/fstat/fstat02.c
> +++ b/testcases/kernel/syscalls/fstat/fstat02.c
> @@ -17,8 +17,10 @@
>  #include "tst_safe_macros.h"
>  
>  #define TESTFILE        "test_file"
> +#define LINK_TESTFILE   "link_test_file"
>  #define FILE_SIZE       1024
>  #define FILE_MODE	0644
> +#define NLINK	        2
>  
>  static struct stat stat_buf;
>  static uid_t user_id;
> @@ -61,6 +63,12 @@ static void run(void)
>  		fail++;
>  	}
>  
> +	if (stat_buf.st_nlink != NLINK) {
> +		tst_res(TFAIL, "stat_buf.st_nlink = %li expected %i",
> +			(long)stat_buf.st_nlink, NLINK);
> +		fail++;
> +	}
> +
>  	if (fail)
>  		return;
>  
> @@ -78,6 +86,8 @@ static void setup(void)
>  
>  	if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
>  		tst_brk(TBROK, "Could not fill Testfile!");
> +
> +	SAFE_LINK(TESTFILE, LINK_TESTFILE);
>  }
>  
>  static void cleanup(void)
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
