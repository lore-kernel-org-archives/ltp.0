Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ACFEE4993
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 13:23:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F4E53CC814
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 15:23:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 118383CB53B
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 15:23:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 313C3140076F
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 15:23:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D990122C37;
 Mon, 21 Aug 2023 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692624194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmizXjI+infr9n6Q/QTzyqfjN7cb98zipKBUpJJXOkc=;
 b=w0fmu2EW1pIJ/5BozukHyhYJuQhwptGVvQlgwIpUcYowWOQcW/nTVIDrhBKg5BA11kB/jC
 P9kTJJr+NJKsMTnLZEiBZllS/xioNT1f/F07yR5npdEUEaeXxAyxjo1TJIi9WgL4h8dwry
 0eTfPRtZxXInOMFaN2KirccVMSPKDv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692624194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmizXjI+infr9n6Q/QTzyqfjN7cb98zipKBUpJJXOkc=;
 b=SjriENCLb+4z/UQahSkCaeCIQmUU7rlpdaMtpusKBHAEbhJq87RrUt3i2j2Twi87y1WZ//
 tCOY+FREull00qDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B74C113421;
 Mon, 21 Aug 2023 13:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xgK+KkJl42TEWwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 21 Aug 2023 13:23:14 +0000
Date: Mon, 21 Aug 2023 15:24:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <ZONldbUOjaFGbr_L@yuki>
References: <20230815093048.1155501-1-vishalc@linux.ibm.com>
 <20230815093048.1155501-3-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230815093048.1155501-3-vishalc@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] ebizzy: prevent integer overflow in 64-bit
 systems
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
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, raj.khem@gmail.com,
 chris@mips.com, ltp@lists.linux.it, tdavies@darkphysics.net,
 gaowanlong@cn.fujitsu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  utils/benchmark/ebizzy-0.3/ebizzy.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
> index ae0981fbd..c3eac1133 100644
> --- a/utils/benchmark/ebizzy-0.3/ebizzy.c
> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
> @@ -456,7 +456,7 @@ static void start_threads(void)
>  	unsigned int i;
>  	struct rusage start_ru, end_ru;
>  	struct timeval usr_time, sys_time;
> -	uintptr_t records_read = 0;
> +	uintptr_t records_per_sec = 0;
>  	int err;
>  
>  	if (verbose)
> @@ -493,14 +493,13 @@ static void start_threads(void)
>  			fprintf(stderr, "Error joining thread %d\n", i);
>  			exit(1);
>  		}
> -		records_read += record_thread;
> +		records_per_sec += (record_thread / elapsed);

This actually introduces quite a bit rounding errors. Note that even
with 10 second runtime we effectively throw away the last digit for each
thread records and it's even worse for larger runtime. This kind of
naive summing can easily add up to quite large differencies.

E.g. for a machine with 256 CPUs and 10 seconds the value would be on
average smaller by:

	512 (number of threads) * 5 (average last digit) / 10 (runtime)

So on average the result printed would be smaller by 256 units.

Either we have to switch the records_per_sec to double and compute the
number in floating point, which should add up fine as long as the work
done by a threads is more or less the same.

Or use uint64_t as a fixed point and use one or two bits for a fraction,
which may be a bit safer than double and should work fine as long as
we round properly.

This should be easy to debug as well, just print the number computed by
the method that sum first and then divide and compare it with the number
that sums the already divided values. These two shouldn't differ much,
ideally the should be the same.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
