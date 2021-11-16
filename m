Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AB1C433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 01:07:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CD961350
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 01:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3CD961350
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A69473C876B
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:07:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB4413C06B2
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 02:07:13 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A78C5600802
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 02:07:12 +0100 (CET)
Received: by mail-pl1-x62c.google.com with SMTP id b13so15999487plg.2
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 17:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3INwO2iFv9D9Z9XyrhUKx0By5ub1oM4I9TrUO42iIGc=;
 b=pdSs2Ggyql7baqrX1k16NSXrCyQ0LTvuNZ/UPq40FZGwsn41SmqeZ7Iuimi6aqq7tL
 hFaxBKBZbtLnBx28vKd7P4QjKYfSmZ/VWbYbvPCSq0jbixY34It0j2YS+Y8S/Ixz0mLa
 HOXsHiikuMo2XySZB6mtgvv2sYaJHK+Wm+GS198n8ZOKj9ze9vu4GFsEtqXnd1TVBlsL
 QkpxEuapuu17k48O5o3ZfrcD5CeQe15/R6NDLMAJCSFi7oKj6h6scVngAzBgwMbSx3Wb
 1RMRQU6OksPPlPGBw3eZIioBY2k9tagaMayk8hiSZlr3yBFa6yDHMODI9w6zaZ2wdHTn
 dRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3INwO2iFv9D9Z9XyrhUKx0By5ub1oM4I9TrUO42iIGc=;
 b=1IGGl9kSmksOLYxUac8T9lEF6UsEVtdhbYelpYSYEAqyXhjfHA5grIafJyBFYg7ZdD
 UoL60kT8VU6r5Ccp6Swr9csn8PY1jQS2z+G+9cGUd/rOCmdXFrPjo+zQomGglky7RtcG
 yoILY5jigWCTimI+6/tRuE2XwdvZJ9OK+fATI44P8ystqW3N0GT6aXSb3FVyx7GCvvAa
 u7bOnkjnGI0y72a7aDcvdz/kVuSxvo7JF6SR8RwHKAD5K8l0Be0nMHz4fPVH2mnYHIoG
 /JOpMX5r4ahWuwMMWWXRXVCPau+XLWyg4EGuDQDwULJ26+BCGRlA8u8zMnKE+KkvC7S2
 QLKQ==
X-Gm-Message-State: AOAM5312LpIeFaEdjmC7YeaNTYmIDQz4ZM/3nnAGeoogc4mTYjuDXEqe
 goKqKR+EyttalpDPdIblKTDYbA==
X-Google-Smtp-Source: ABdhPJzGZf9B4Ig6JvRuyvY28DlpHLS4PiaVYw9t3CF/4v11ESw2z8/Jsh8efPb/7SE0BfchAULPgg==
X-Received: by 2002:a17:90a:fe1:: with SMTP id
 88mr70529537pjz.24.1637024830498; 
 Mon, 15 Nov 2021 17:07:10 -0800 (PST)
Received: from google.com ([2401:fa00:9:211:7fb3:c226:2a5b:6353])
 by smtp.gmail.com with ESMTPSA id s207sm52490pgs.78.2021.11.15.17.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 17:07:09 -0800 (PST)
Date: Tue, 16 Nov 2021 12:06:59 +1100
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YZMEMwvdpA/IXz+P@google.com>
References: <cover.1636451496.git.repnop@google.com>
 <0671d89befb5b24fc3bac510c69811668c39cdf5.1636451496.git.repnop@google.com>
 <CAOQ4uxiFsnvA-8y1mJ7uHccd4bqZUYJkK5Y2R1+KtgDK_OH4Sw@mail.gmail.com>
 <YZLPEjJkII1evtEc@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZLPEjJkII1evtEc@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] syscalls/fanotify: Add a helper macro
 which checks for the presence of specific fanotify initialization flag(s)
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 15, 2021 at 10:20:18PM +0100, Petr Vorel wrote:
> Hi Matthew, Amir,
> 
> Tested on two distro kernels with support (Tumbleweed and Debian unstable)
> + on various old kernels without support.
> 
> Merged with very minor fixes, see diff below.

Noted the changes, they're fine by me. Thanks for the merge!

> NOTE: we now support basic static analysis + checkpatch formatting check - run
> make check in fanotify directory or make check-fanotify20.

Oh, that's great, I had no idea. Quickly running it, looks like
there's a bunch of clean up required for some of the older tests. Will
have to get around to doing that at some point.

> diff --git runtest/syscalls runtest/syscalls
> index 1e6d46744..d57c73e39 100644
> --- runtest/syscalls
> +++ runtest/syscalls
> @@ -605,6 +605,8 @@ fanotify16 fanotify16
>  fanotify17 fanotify17
>  fanotify18 fanotify18
>  fanotify19 fanotify19
> +fanotify20 fanotify20
> +fanotify21 fanotify21
>  
>  ioperm01 ioperm01
>  ioperm02 ioperm02
> diff --git testcases/kernel/syscalls/fanotify/fanotify20.c testcases/kernel/syscalls/fanotify/fanotify20.c
> index 9960d85eb..de0fdb782 100644
> --- testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -12,6 +12,9 @@
>   * returns an expected error code when provided an invalid initialization flag
>   * alongside FAN_REPORT_PIDFD. Additionally, it checks that the operability with
>   * existing FAN_REPORT_* flags is maintained and functioning as intended.
> + *
> + * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in af579beb666a
> + * ("fanotify: add pidfd support to the fanotify API").
>   */
>  
>  #define _GNU_SOURCE
> @@ -39,7 +42,7 @@ static struct test_case_t {
>  	},
>  	{
>  		"pass on FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME",
> -		FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME ,
> +		FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME,
>  		0,
>  		0,
>  	},
> diff --git testcases/kernel/syscalls/fanotify/fanotify21.c testcases/kernel/syscalls/fanotify/fanotify21.c
> index e842dad17..6ae70c57e 100644
> --- testcases/kernel/syscalls/fanotify/fanotify21.c
> +++ testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -11,6 +11,9 @@
>   * A test which verifies whether the returned struct
>   * fanotify_event_info_pidfd in FAN_REPORT_PIDFD mode contains the
>   * expected set of information.
> + *
> + * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in af579beb666a
> + * ("fanotify: add pidfd support to the fanotify API").
>   */
>  
>  #define _GNU_SOURCE
> @@ -56,7 +59,7 @@ struct test_case_t {
>  
>  static int fanotify_fd;
>  static char event_buf[BUF_SZ];
> -static struct pidfd_fdinfo_t *self_pidfd_fdinfo = NULL;
> +static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
>  
>  static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
>  {
> @@ -158,7 +161,7 @@ static void do_test(unsigned int num)
>  	 * buffer.
>  	 */
>  	len = SAFE_READ(0, fanotify_fd, event_buf, sizeof(event_buf));
> -	while(i < len) {
> +	while (i < len) {
>  		struct fanotify_event_metadata *event;
>  		struct fanotify_event_info_pidfd *info;
>  		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
> @@ -197,7 +200,7 @@ static void do_test(unsigned int num)
>  			tst_res(TFAIL,
>  				"pidfd creation failed for pid: %u with pidfd error value "
>  				"set to: %d",
> -				(unsigned)event->pid,
> +				(unsigned int)event->pid,
>  				info->pidfd);
>  			goto next_event;
>  		} else if (tc->want_pidfd_err &&
> @@ -205,14 +208,14 @@ static void do_test(unsigned int num)
>  			tst_res(TFAIL,
>  				"pidfd set to an unexpected error: %d for pid: %u",
>  				info->pidfd,
> -				(unsigned)event->pid);
> +				(unsigned int)event->pid);
>  			goto next_event;
>  		} else if (tc->want_pidfd_err &&
>  			   info->pidfd == tc->want_pidfd_err) {
>  			tst_res(TPASS,
>  				"pid: %u terminated before pidfd was created, "
>  				"pidfd set to the value of: %d, as expected",
> -				(unsigned)event->pid,
> +				(unsigned int)event->pid,
>  				FAN_NOPIDFD);
>  			goto next_event;
>  		}
> @@ -227,15 +230,15 @@ static void do_test(unsigned int num)
>  				"reading fdinfo for pidfd: %d "
>  				"describing pid: %u failed",
>  				info->pidfd,
> -				(unsigned)event->pid);
> +				(unsigned int)event->pid);
>  			goto next_event;
>  		} else if (event_pidfd_fdinfo->pid != event->pid) {
>  			tst_res(TFAIL,
>  				"pidfd provided for incorrect pid "
>  				"(expected pidfd for pid: %u, got pidfd for "
>  				"pid: %u)",
> -				(unsigned)event->pid,
> -				(unsigned)event_pidfd_fdinfo->pid);
> +				(unsigned int)event->pid,
> +				(unsigned int)event_pidfd_fdinfo->pid);
>  			goto next_event;
>  		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
>  				  sizeof(struct pidfd_fdinfo_t))) {
> @@ -261,7 +264,7 @@ static void do_test(unsigned int num)
>  				"mask: %lld, pid: %u, fd: %d, "
>  				"pidfd: %d, info_type: %d, info_len: %d",
>  				(unsigned long long)event->mask,
> -				(unsigned)event->pid,
> +				(unsigned int)event->pid,
>  				event->fd,
>  				info->pidfd,
>  				info->hdr.info_type,

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
