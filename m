Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2513FC001B0
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 08:03:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071093CD09B
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 10:03:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3832F3C98FC
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 10:03:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8665210011A3
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 10:03:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 683751F38D;
 Thu, 10 Aug 2023 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691654620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hx4B1LuzVZmO8OXJ4AjkD5FtFfD1Glr7prlScHEnStI=;
 b=MFKEJXRzl0EnqkM0QJb/aW8AqG4LaRkCFmiGguANaYXeDpxNiK/w/X/pDCjlhuwFZgEjfL
 7wiJVVHCXoVb1IYr0ESV+AyBHlDTB3A/FRKeWXKG0GymbrV6ZySM4Ibs/OZ5ZnSJLemUPb
 WYZBAAo2vYheJbk1i5FHxlABAH7m3DQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691654620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hx4B1LuzVZmO8OXJ4AjkD5FtFfD1Glr7prlScHEnStI=;
 b=Pm9a1wQumcLkqKB+EgLWL4qLMxcdlOdeef7tFd2jg4g2+n0JeVTULaAL+rBdZiBbnnb6l7
 dmnJOf+cUDTzhuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DCDB138E2;
 Thu, 10 Aug 2023 08:03:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DAGCEdyZ1GRjWAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Aug 2023 08:03:40 +0000
Date: Thu, 10 Aug 2023 10:04:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Xin Wang <Xin.Wang@windriver.com>
Message-ID: <ZNSaGP9_SRoAiHMX@yuki>
References: <20230808062025.2991984-1-Xin.Wang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230808062025.2991984-1-Xin.Wang@windriver.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs/fsx-linux/fsx-linux.c: Add measurement of
 execution time
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
> Signed-off-by: Xin.Wang@windriver.com
> ---
>  testcases/kernel/fs/fsx-linux/fsx-linux.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> index 64c27a0f5..71b719782 100644
> --- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
> +++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
> @@ -1115,7 +1115,8 @@ int main(int argc, char **argv)
>  	int i, style, ch;
>  	char *endp;
>  	int dirpath = 0;
> -
> +	struct timeval time_start, time_end, time_diff;
> +	
>  	goodfile[0] = 0;
>  	logfile[0] = 0;
>  
> @@ -1336,12 +1337,24 @@ int main(int argc, char **argv)
>  	} else
>  		check_trunc_hack();
>  
> +	gettimeofday(&time_start, NULL);

gettimeofday() is not a good way how to measure elapsed time, it may
jump up and down as it's adjusted by ntp-daemon.

If you want to measure time between two events you should use
clock_gettime() with CLOCK_MONOTONIC_RAW instead.

>  	while (numops == -1 || numops--)
>  		test();
>  
>  	close_test_files();
> +	gettimeofday(&time_end, NULL);
> +
>  	prt("All operations completed A-OK!\n");
>  
> +	time_diff.tv_sec = time_end.tv_sec - time_start.tv_sec;
> +	time_diff.tv_usec = time_end.tv_usec - time_start.tv_usec;
> +	if (time_diff.tv_usec < 0) {
> +		time_diff.tv_usec += 1000000;
> +		time_diff.tv_sec -= 1; 
> +	}
> +	prt("Elapsed Test Time %lu.%06lu\n",
> +        (unsigned long)time_diff.tv_sec, time_diff.tv_usec);
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
