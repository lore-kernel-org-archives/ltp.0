Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281A6C05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 11:05:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EF523CC0B3
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 12:05:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01B313C2730
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 12:05:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E07E1000D21
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 12:05:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03A843533D;
 Thu,  9 Feb 2023 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675940715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOxYtRPPKROoK0T7Rhi7hLh3lVNPV47D1nQVQUo3Gy4=;
 b=jhjUATke0jF1JKksrMHoV8Uxl2JA/wEcWjT4ViiQZmXd5p/YqPbzbkIacOZUJLcAz+ElXX
 TJ3HqOUbzfQ3yh8uSFwH1QgnM2hc5vGDlbp2q9rRixR+hbsRD4YeMBvd1sKe4POLiVstqU
 a6A9o+q+z4NNDaEG8vcSsppPXLAxCtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675940715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOxYtRPPKROoK0T7Rhi7hLh3lVNPV47D1nQVQUo3Gy4=;
 b=j4ycN0emXiCgbmOCV/zPPnZQ8GLGKN9GK7qAnokIb2QodNKbBUh22Yz3rFrHy1P+7JbVS+
 6wuTp7udwMf9J+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E230E1339E;
 Thu,  9 Feb 2023 11:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id seX5NWrT5GOlNAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Feb 2023 11:05:14 +0000
Date: Thu, 9 Feb 2023 12:06:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ping Fang <pifang@redhat.com>
Message-ID: <Y+TTxcCMpoa8umhj@yuki>
References: <20230209090307.491586-1-pifang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230209090307.491586-1-pifang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] aiocp: Filter out O_DIRECT before read
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
Cc: liwan@redhat.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> When aiocp executed with -f DIRECT will fail.
> 
> <<<test_start>>>
> tag=AD049 stime=1675520824
> cmdline="aiocp -b 8k -n 8 -f DIRECT"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1560: TINFO: Timeout per run is 0h 30m 30s
> aiocp.c:211: TINFO: Maximum AIO blocks: 65536
> tst_device.c:585: TINFO: Use uevent strategy
> aiocp.c:250: TINFO: Fill srcfile.bin with random data
> aiocp.c:279: TINFO: Copy srcfile.bin -> dstfile.bin
> aiocp.c:291: TINFO: Comparing srcfile.bin with dstfile.bin
> aiocp.c:306: TBROK: read(3,0x7ffcd743abe0,4096) failed, returned -1: EINVAL (22)
> ...
> 
> syscall read manual ERROR section said that:
> EINVAL fd  is  attached to an object which is unsuitable for reading;
> or the file was opened with the O_DIRECT flag, and either the address
> specified in buf, the value specified in  count, or the file offset is
> not suitably aligned.
> 
> We need filter out O_DIRECT flag before read.

This is not very good changelog, I had to look closely at the source to
figure out why we may need this.

Better description should say that the code which checks that the data
has been written correctly does not use aligned buffers, which may cause
a failure like the one above.

> Signed-off-by: Ping Fang <pifang@redhat.com>
> ---
>  testcases/kernel/io/ltp-aiodio/aiocp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
> index bc0e209b2..e4252d641 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
> @@ -297,8 +297,8 @@ static void run(void)
>  		return;
>  	}
>  
> -	srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
> -	dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
> +	srcfd = SAFE_OPEN(srcname, (srcflags & ~O_DIRECT) | O_RDONLY, 0666);
> +	dstfd = SAFE_OPEN(dstname, (srcflags & ~O_DIRECT) | O_RDONLY, 0666);

I guess that we can as well just remove the srcflags and keep just the
O_RDONLY since the srcflags are by definition either O_RDONLY or
O_DIRECT | O_RDONLY.

I suppose that using scrflags and dstflags for anything else than the
filedescriptors passed to the async_run() is actually a mistake.

>  	reads = howmany(filesize, buffsize);
>  
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
