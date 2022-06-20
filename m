Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F24C43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 14:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99DA83C92A5
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 16:36:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0D133C9203
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 16:36:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 47EAA600202
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 16:36:00 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 49AA61F74D;
 Mon, 20 Jun 2022 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655735760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VsWTpQY2hYENsnNS+FP4iAII1k7Eaig+msev0SDeTxU=;
 b=orz2Y0vGRMfvyIQlS4yXEMNn6CSktemXvthIMwXhMvptkX/ejTsobu3lSRGXsK8P602EnI
 w4Zq96L8+cDuGcqEfWHq2SL8kyTIdqgmpyDd7f9atiPrLCjet3SX4dWh3KHtcMoOV+3ABP
 w4mi9Q2k6CAX4a4ZByBIQ4GtIwC9hmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655735760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VsWTpQY2hYENsnNS+FP4iAII1k7Eaig+msev0SDeTxU=;
 b=hTn69lB91VHM2Ju3QI1vxya/AF5o/707pbWTHJHQYlSw0l+jGuGqeYHCTlyv80rAhIUBu0
 yx/9pL/DFDpTPzBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2AB032C142;
 Mon, 20 Jun 2022 14:36:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id C1D44A0636; Mon, 20 Jun 2022 16:35:59 +0200 (CEST)
Date: Mon, 20 Jun 2022 16:35:59 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220620143559.otn4s24lnzfkvxvk@quack3.lan>
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220620132737.2015073-2-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] syscalls/fanotify09: Cleanup open event fds
 on error
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

On Mon 20-06-22 16:27:34, Amir Goldstein wrote:
> Avoid breaking out of test, without closing all fds of events in buffer
> to avoid failure to unmount fs on cleanup.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify09.c     | 45 ++++++++++---------
>  1 file changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index fea374689..60ffcb81b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -238,6 +238,15 @@ static void verify_event(int group, struct fanotify_event_metadata *event,
>  		SAFE_CLOSE(event->fd);
>  }
>  
> +static void close_event_fds(struct fanotify_event_metadata *event, int buflen)
> +{
> +	/* Close all file descriptors of read events */
> +	for (; FAN_EVENT_OK(event, buflen); FAN_EVENT_NEXT(event, buflen)) {
> +		if (event->fd != FAN_NOFD)
> +			SAFE_CLOSE(event->fd);
> +	}
> +}
> +
>  static void test_fanotify(unsigned int n)
>  {
>  	int ret, dirfd;
> @@ -262,8 +271,7 @@ static void test_fanotify(unsigned int n)
>  	 * generate FAN_CLOSE_NOWRITE event on a child, subdir or "."
>  	 */
>  	dirfd = SAFE_OPEN(tc->close_nowrite, O_RDONLY);
> -	if (dirfd >= 0)
> -		SAFE_CLOSE(dirfd);
> +	SAFE_CLOSE(dirfd);
>  
>  	/*
>  	 * First verify the first group got the file MODIFY event and got just
> @@ -278,15 +286,17 @@ static void test_fanotify(unsigned int n)
>  				"reading fanotify events failed");
>  		}
>  	}
> +	event = (struct fanotify_event_metadata *)event_buf;
>  	if (ret < tc->nevents * (int)FAN_EVENT_METADATA_LEN) {
> -		tst_brk(TBROK,
> +		tst_res(TFAIL,
>  			"short read when reading fanotify events (%d < %d)",
>  			ret, tc->nevents * (int)FAN_EVENT_METADATA_LEN);
>  	}
> -	event = (struct fanotify_event_metadata *)event_buf;
> -	verify_event(0, event, FAN_MODIFY, tc->report_name ? fname : "");
> -	event = FAN_EVENT_NEXT(event, ret);
> -	if (tc->nevents > 1) {
> +	if (FAN_EVENT_OK(event, ret)) {
> +		verify_event(0, event, FAN_MODIFY, tc->report_name ? fname : "");
> +		event = FAN_EVENT_NEXT(event, ret);
> +	}
> +	if (tc->nevents > 1 && FAN_EVENT_OK(event, ret)) {
>  		verify_event(0, event, FAN_CLOSE_NOWRITE,
>  			     tc->report_name ? (tc->ondir ? "." : tc->close_nowrite) : "");
>  		event = FAN_EVENT_NEXT(event, ret);
> @@ -296,11 +306,7 @@ static void test_fanotify(unsigned int n)
>  			"first group got more than %d events (%d bytes)",
>  			tc->nevents, ret);
>  	}
> -	/* Close all file descriptors of read events */
> -	for (; FAN_EVENT_OK(event, ret); FAN_EVENT_NEXT(event, ret)) {
> -		if (event->fd != FAN_NOFD)
> -			SAFE_CLOSE(event->fd);
> -	}
> +	close_event_fds(event, ret);
>  
>  	/*
>  	 * Then verify the rest of the groups did not get the MODIFY event and
> @@ -318,15 +324,14 @@ static void test_fanotify(unsigned int n)
>  			verify_event(i, event, expect, "");
>  			event = FAN_EVENT_NEXT(event, ret);
>  
> -			for (; FAN_EVENT_OK(event, ret); FAN_EVENT_NEXT(event, ret)) {
> -				if (event->fd != FAN_NOFD)
> -					SAFE_CLOSE(event->fd);
> -			}
> +			close_event_fds(event, ret);
>  			continue;
>  		}
>  
> -		if (ret == 0)
> -			tst_brk(TBROK, "zero length read from fanotify fd");
> +		if (ret == 0) {
> +			tst_res(TFAIL, "group %d zero length read from fanotify fd", i);
> +			continue;
> +		}
>  
>  		if (errno != EAGAIN) {
>  			tst_brk(TBROK | TERRNO,
> @@ -360,8 +365,8 @@ static void cleanup(void)
>  
>  	SAFE_CHDIR("../");
>  
> -	if (mount_created && tst_umount(MOUNT_NAME) < 0)
> -		tst_brk(TBROK | TERRNO, "umount failed");
> +	if (mount_created)
> +		SAFE_UMOUNT(MOUNT_NAME);
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
