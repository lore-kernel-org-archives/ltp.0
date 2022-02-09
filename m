Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B91BC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 08:20:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8FDD3C9B5A
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 09:19:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BD293C6912
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:19:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 708E71A006E8
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 09:19:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7027121106;
 Wed,  9 Feb 2022 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644394785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGVGJuWEo8gTN24ew3XCdVqkgFAFCmGfFrqgEejRvd4=;
 b=fWRF1aLGskapUoegbAZpFmMuIuTRNcrw6KoV5XcQ1rBFPctmW5Kjx3cLeRzTrUQa8zatnP
 G1r8+lnXjLoDNp7naX7dmXHv0c2YAF6vJ1G+VNOESezpOr49larXrwy5IikKpR56IlK4Xq
 Shw9DZiqTM2ZH5mEy6ALk9tKEbIz+1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644394785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGVGJuWEo8gTN24ew3XCdVqkgFAFCmGfFrqgEejRvd4=;
 b=tFhY9Kn4QBkfjVsnaZUcLWOQBqiL/mRPFBUOTBnKIpl0bYONFwcZRgPgOJC45gPN7dIfrE
 8OEOH9j8snahy6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 337F2139D1;
 Wed,  9 Feb 2022 08:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ugZRCiF5A2KjIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 09 Feb 2022 08:19:45 +0000
Date: Wed, 9 Feb 2022 09:19:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YgN5HyxYj/YMJgzY@pevik>
References: <20220209080510.167709-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220209080510.167709-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fanotify/fanotify04: Bugfix for running with
 option of "-i 500"
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Matthew Bobrowski <mbobrowski@mbobrowski.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao,

> When we running the testcase with option of "-i 500", the test
> will fail:
> ...
> fanotify04.c:163: TPASS: No event as expected
> fanotify04.c:71: TPASS: fanotify_mark (3, FAN_MARK_ADD | 0, FAN_OPEN, AT_FDCWD, 'symlink_160172') succeeded
> fanotify04.c:127: TPASS: event generated properly for type 100000
> fanotify04.c:113: TBROK: read(3,0x55c783185280,0) failed, returned -1: EINVAL (22)
> ...

[ Cc: kernel also Amir and Matthew ]
https://lore.kernel.org/ltp/20220209080510.167709-1-zhaogongyi@huawei.com/T/#u

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, works as expected, I don't see any performance impact.
Also don't think buffer containing all events was important for testing and can
be replaced with buffer for just single event. But please correct me if I'm
wrong.

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
> v1->v2: Clear the compile warnings.
Thanks! I was going to send a diff, not only because the warnings, but also
patch didn't apply.

Kind regards,
Petr

>  .../kernel/syscalls/fanotify/fanotify04.c     | 21 ++++++-------------
>  1 file changed, 6 insertions(+), 15 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
> index b23d7a9a3..8c3c179b1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify04.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
> @@ -24,11 +24,8 @@
>  #ifdef HAVE_SYS_FANOTIFY_H
>  #include "fanotify.h"

> -#define EVENT_MAX 1024
>  /* size of the event structure, not counting name */
>  #define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
> -/* reasonable guess as to size of 1024 events */
> -#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)

>  #define BUF_SIZE 256
>  #define TST_TOTAL 9
> @@ -37,9 +34,7 @@ static char fname[BUF_SIZE];
>  static char sname[BUF_SIZE];
>  static char dir[BUF_SIZE];
>  static int fd_notify;
> -
> -static int len;
> -static char event_buf[EVENT_BUF_LEN];
> +static char event_buf[EVENT_SIZE];

>  static char *expect_str_fail(int expect)
>  {
> @@ -104,16 +99,12 @@ static void open_dir(char *file)

>  static void verify_event(int mask)
>  {
> -	int ret;
>  	struct fanotify_event_metadata *event;
>  	struct stat st;

>  	/* Read the event */
> -	ret = SAFE_READ(0, fd_notify, event_buf + len,
> -			EVENT_BUF_LEN - len);
> -	event = (struct fanotify_event_metadata *)&event_buf[len];
> -	len += ret;
> -
> +	SAFE_READ(0, fd_notify, event_buf, EVENT_SIZE);
> +	event = (struct fanotify_event_metadata *)&event_buf;
>  	if (event->mask != FAN_OPEN) {
>  		tst_res(TFAIL, "got unexpected event %llx",
>  			(unsigned long long)event->mask);
> @@ -146,11 +137,11 @@ static void verify_no_event(void)
>  {
>  	int ret;

> -	ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
> +	ret = read(fd_notify, event_buf, EVENT_SIZE);
>  	if (ret != -1) {
>  		struct fanotify_event_metadata *event;

> -		event = (struct fanotify_event_metadata *)&event_buf[len];
> +		event = (struct fanotify_event_metadata *)&event_buf;
>  		tst_res(TFAIL, "seen unexpected event (mask %llx)",
>  			(unsigned long long)event->mask);
>  		/* Cleanup fd from the event */
> @@ -158,7 +149,7 @@ static void verify_no_event(void)
>  			SAFE_CLOSE(event->fd);
>  	} else if (errno != EAGAIN) {
>  		tst_res(TFAIL | TERRNO, "read(%d, buf, %zu) failed", fd_notify,
> -			EVENT_BUF_LEN);
> +			EVENT_SIZE);
>  	} else {
>  		tst_res(TPASS, "No event as expected");
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
