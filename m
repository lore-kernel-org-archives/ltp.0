Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270F9C43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 14:38:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 574E53C93FD
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 16:38:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DC63C8CAB
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 16:37:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED8152000B9
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 16:37:55 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3AF8121B31;
 Mon, 20 Jun 2022 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655735875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hkLgkvta1mGG74VZfQ6Rpuj3FWLwaFH3GvvTalgSCk=;
 b=3X6lZhCmm4JfDkyfEJksoh2nngDe5T2m6xtc8vYHz+pXZ2phneF93z8kzSCvcAU03pv+sU
 sFjyp//gU/yCKrnX3HTqWBRO21Vh2odvLfhmSnHL9DozzBd7Yg8amjILewdbVbIKWuwzIf
 DIb8R/ka0sdRiG/T6UJpUPkDrhioJ5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655735875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6hkLgkvta1mGG74VZfQ6Rpuj3FWLwaFH3GvvTalgSCk=;
 b=qpM5QRkgXlE1hvTi0sTKCTn5+O3GCyOecZ1ic3SKvIhHtV+qDlRs7yn8aXAJ8/2GJBaoo5
 +iFu1Zt+fcLy64BQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2C8802C142;
 Mon, 20 Jun 2022 14:37:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id D66CCA0636; Mon, 20 Jun 2022 16:37:54 +0200 (CEST)
Date: Mon, 20 Jun 2022 16:37:54 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220620143754.bplnp6bmasb36sj3@quack3.lan>
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220620132737.2015073-3-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] syscalls/fanotify09: Verify if no events are
 expected
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 20-06-22 16:27:35, Amir Goldstein wrote:
> Some test cases expect no events for non-first groups and some expect
> one event on non-dir child for non-first groups, but it is not verified
> that non-first groups get the desired amount of events, so add this
> information to the test case definition.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify09.c     | 25 +++++++++----------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index 60ffcb81b..a8d56c10b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -76,6 +76,7 @@ static struct tcase {
>  	unsigned int report_name;
>  	const char *close_nowrite;
>  	int nevents;
> +	unsigned int nonfirst_event;
>  } tcases[] = {
>  	{
>  		"Events on non-dir child with both parent and mount marks",
> @@ -83,7 +84,7 @@ static struct tcase {
>  		0,
>  		0,
>  		DIR_NAME,
> -		1,
> +		1, 0,
>  	},
>  	{
>  		"Events on non-dir child and subdir with both parent and mount marks",
> @@ -91,7 +92,7 @@ static struct tcase {
>  		FAN_ONDIR,
>  		0,
>  		DIR_NAME,
> -		2,
> +		2, 0,
>  	},
>  	{
>  		"Events on non-dir child and parent with both parent and mount marks",
> @@ -99,7 +100,7 @@ static struct tcase {
>  		FAN_ONDIR,
>  		0,
>  		".",
> -		2,
> +		2, 0
>  	},
>  	{
>  		"Events on non-dir child and subdir with both parent and subdir marks",
> @@ -107,7 +108,7 @@ static struct tcase {
>  		FAN_ONDIR,
>  		0,
>  		DIR_NAME,
> -		2,
> +		2, 0,
>  	},
>  	{
>  		"Events on non-dir children with both parent and mount marks",
> @@ -115,7 +116,7 @@ static struct tcase {
>  		0,
>  		0,
>  		FILE2_NAME,
> -		2,
> +		2, FAN_CLOSE_NOWRITE,
>  	},
>  	{
>  		"Events on non-dir child with both parent and mount marks and filename info",
> @@ -123,7 +124,7 @@ static struct tcase {
>  		0,
>  		FAN_REPORT_DFID_NAME,
>  		FILE2_NAME,
> -		2,
> +		2, FAN_CLOSE_NOWRITE,
>  	},
>  };
>  
> @@ -315,13 +316,8 @@ static void test_fanotify(unsigned int n)
>  	for (i = 1; i < NUM_GROUPS; i++) {
>  		ret = read(fd_notify[i], event_buf, EVENT_BUF_LEN);
>  		if (ret > 0) {
> -			uint32_t expect = 0;
> -
> -			if (tc->nevents > 1 && !tc->ondir)
> -				expect = FAN_CLOSE_NOWRITE;
> -
>  			event = (struct fanotify_event_metadata *)event_buf;
> -			verify_event(i, event, expect, "");
> +			verify_event(i, event, tc->nonfirst_event, "");
>  			event = FAN_EVENT_NEXT(event, ret);
>  
>  			close_event_fds(event, ret);
> @@ -338,7 +334,10 @@ static void test_fanotify(unsigned int n)
>  				"reading fanotify events failed");
>  		}
>  
> -		tst_res(TPASS, "group %d got no event", i);
> +		if (tc->nonfirst_event)
> +			tst_res(TFAIL, "group %d expected and got no event", i);
> +		else
> +			tst_res(TPASS, "group %d got no event as expected", i);
>  	}
>  	cleanup_fanotify_groups();
>  }
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
