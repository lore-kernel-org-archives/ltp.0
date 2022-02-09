Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5487AC433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 11:23:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7393C3C9B90
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 12:23:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C096E3C0E63
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 12:23:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 25A4320039F
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 12:23:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4023921107;
 Wed,  9 Feb 2022 11:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644405794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EwWrfjbop8UXNq1yIbPL5q7JGw1iHW0WDeKXIzYbSUs=;
 b=A4nKeAUkQh+k7Q430rvCnuMbsCMXNf9k2w7Px2pUZ5Eejg9XNiFOIbpUUuP2vUjr0N2CdF
 24O7s9gTXMAOIuHrRplsUtd5wGunmqO8XehWIAaf8cntvMuOPmYEUJwtk71OKpC2kdFkeJ
 J3phnPiddrSt87/B/AuxmqTMZGw1ev8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644405794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EwWrfjbop8UXNq1yIbPL5q7JGw1iHW0WDeKXIzYbSUs=;
 b=Z+kbf/yWXOpfziycNfnilYrOk1aKCaCXjdgzy03yU2z152Yw2TaO6aZYCYUoRg2no8SL1z
 JAeXQkYO0q853JAw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 33740A3B81;
 Wed,  9 Feb 2022 11:23:14 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id E33B0A05C6; Wed,  9 Feb 2022 12:23:12 +0100 (CET)
Date: Wed, 9 Feb 2022 12:23:12 +0100
From: Jan Kara <jack@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <20220209112312.ngyhsludc6vavcyp@quack3.lan>
References: <20220209080510.167709-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220209080510.167709-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 09-02-22 16:05:10, Zhao Gongyi wrote:
> When we running the testcase with option of "-i 500", the test
> will fail:
> ...
> fanotify04.c:163: TPASS: No event as expected
> fanotify04.c:71: TPASS: fanotify_mark (3, FAN_MARK_ADD | 0, FAN_OPEN, AT_FDCWD, 'symlink_160172') succeeded
> fanotify04.c:127: TPASS: event generated properly for type 100000
> fanotify04.c:113: TBROK: read(3,0x55c783185280,0) failed, returned -1: EINVAL (22)
> ...
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v1->v2: Clear the compile warnings.
> 
>  .../kernel/syscalls/fanotify/fanotify04.c     | 21 ++++++-------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
> index b23d7a9a3..8c3c179b1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify04.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
> @@ -24,11 +24,8 @@
>  #ifdef HAVE_SYS_FANOTIFY_H
>  #include "fanotify.h"
> 
> -#define EVENT_MAX 1024
>  /* size of the event structure, not counting name */
>  #define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
> -/* reasonable guess as to size of 1024 events */
> -#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
> 
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
> 
>  static char *expect_str_fail(int expect)
>  {
> @@ -104,16 +99,12 @@ static void open_dir(char *file)
> 
>  static void verify_event(int mask)
>  {
> -	int ret;
>  	struct fanotify_event_metadata *event;
>  	struct stat st;
> 
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
> 
> -	ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
> +	ret = read(fd_notify, event_buf, EVENT_SIZE);
>  	if (ret != -1) {
>  		struct fanotify_event_metadata *event;
> 
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
> --
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
