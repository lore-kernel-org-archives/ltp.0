Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3AEC67871
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 15:22:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 895A83CC917
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 16:22:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 934393CB4F3
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 16:22:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E8A17778502
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 16:22:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CAC2E34B18;
 Mon, 16 Jan 2023 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673882563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NolmwWi0yrY51Uwg80mwz98PCC/hjCSRru1+NeoXdiw=;
 b=MgU8KiuCqVUecEza46xErs06qmpTDtg+CkoDdrK9gNkyk+9CWIc+P7euSjtBmHvwi+FWec
 VSsEwakF7UW+xJlmyQtWPjsEDib+xuieMEQKV7ePn45t3UsGSNYf7ILs026Jre89lPVyoi
 S3Q3D/UgeRTMqHWkpYn1JOC7NSONKpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673882563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NolmwWi0yrY51Uwg80mwz98PCC/hjCSRru1+NeoXdiw=;
 b=+As9KaWOLOwocsjBk2hEpIGcSWZ02RAtb1hN82He/bl2Smb5jNubWD29jEHDkKbjVo7WEu
 TT7CQBlJSs2chXAw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A59572C19A;
 Mon, 16 Jan 2023 15:22:43 +0000 (UTC)
References: <20230116074101.1264-1-wegao@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Mon, 16 Jan 2023 15:08:44 +0000
Organization: Linux Private Site
In-reply-to: <20230116074101.1264-1-wegao@suse.com>
Message-ID: <87fscawlku.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] readahead02.c: Use fsync instead of sync
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Use fsync on test file instead of sync should faster than syncing
> whole system.

The test completes in less than a second in OpenQA. We don't want to
risk introducing a regression or spend time reviewing changes unless the
performance improvement solves a timeout.

I suggest you convert dup06 to the new API (for example) or investigate
a test failure.

>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../kernel/syscalls/readahead/readahead02.c     | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index 7acf4bb18..e04046bc3 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -99,6 +99,17 @@ static void drop_caches(void)
>  	SAFE_FILE_PRINTF(DROP_CACHES_FNAME, "1");
>  }
>  
> +static void sync_drop_caches(void)
> +{
> +	int fd;
> +
> +	fd  = SAFE_OPEN(testfile, O_RDONLY);
> +	if (fsync(fd) == -1)
> +		tst_brk(TBROK | TERRNO, "fsync()");
> +	SAFE_CLOSE(fd);
> +	drop_caches();
> +}
> +
>  static unsigned long get_bytes_read(void)
>  {
>  	unsigned long ret;
> @@ -233,8 +244,7 @@ static void test_readahead(unsigned int n)
>  	read_testfile(tc, 0, testfile, testfile_size, &read_bytes, &usec,
>  		      &cached);
>  	cached_high = get_cached_size();
> -	sync();
> -	drop_caches();
> +	sync_drop_caches();
>  	cached_low = get_cached_size();
>  	cached_max = MAX(cached_max, cached_high - cached_low);
>  
> @@ -246,8 +256,7 @@ static void test_readahead(unsigned int n)
>  	else
>  		cached = 0;
>  
> -	sync();
> -	drop_caches();
> +	sync_drop_caches();
>  	cached_low = get_cached_size();
>  	tst_res(TINFO, "read_testfile(1)");
>  	ret = read_testfile(tc, 1, testfile, testfile_size, &read_bytes_ra,
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
