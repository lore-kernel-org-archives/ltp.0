Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A70FC433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 14:07:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 961C93CA96C
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 16:06:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422A73CA508
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:06:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12B8E1A0068F
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:06:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46D5C219D8;
 Tue, 10 May 2022 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652191602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2anrwzOlu/pDJDNp/mMVWk//tow+N3x486GqK0T3GQ=;
 b=dps+8eM0zbQNxRypTZ8ZTpjd2amBFO68g5z4cQoUPzLbaXORdK5tivYy/Mod0GXHv35HvM
 RWs80PEg1+bBvjIFVpvovE+kMslZaVMlvtEL4AxA7D7ZtYxyVnIt7sqtqSdjIhXswBU+h2
 QjNuwZ4BgGSHSrNXPgmufb7yDjv24N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652191602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2anrwzOlu/pDJDNp/mMVWk//tow+N3x486GqK0T3GQ=;
 b=B96NP7aHIBZ2+vPmWOxwN+3fw8mo3FWjLxBHRXIeEWm1tsXj6MQm92SRR3o9PNAnUvnDdD
 kRPp50THYzFP2mAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 327E513AA5;
 Tue, 10 May 2022 14:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eufoC3JxemJyPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 10 May 2022 14:06:42 +0000
Date: Tue, 10 May 2022 16:08:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ynpx9suOjKrwggmy@yuki>
References: <CAEemH2d-83ubH1LF3SotjvxwD_5C0BiLTTZ+yGtaYqv47n28AQ@mail.gmail.com>
 <20220508030524.2072035-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220508030524.2072035-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rtc02: loosen the compare precision with few
 seconds
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
Cc: Eirik Fuller <efuller@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  static int rtc_tm_cmp(struct rtc_time *set_tm, struct rtc_time *read_tm)
>  {
> -	return !((set_tm->tm_sec == read_tm->tm_sec)
> -		&& (set_tm->tm_min == read_tm->tm_min)
> -		&& (set_tm->tm_hour == read_tm->tm_hour)
> -		&& (set_tm->tm_mday == read_tm->tm_mday)
> +	long delta, seconds1, seconds2;
> +
> +	/*
> +	 * Convert hour/min/sec into seconds to handle the normal
> +	 * and special situations:
> +	 * 1#
> +	 *       set_tm:  2022-04-28 13:00:50
> +	 *       read_tm: 2022-04-28 13:00:50
> +	 * 2#
> +	 *       set_tm:  2022-04-28 13:00:50
> +	 *       read_tm: 2022-04-28 13:00:51
> +	 * 3#
> +	 *       set_tm:  2022-04-28 13:00:59
> +	 *       read_tm: 2022-04-28 13:01:00
> +	 * 4#
> +	 *       set_tm:  2022-04-28 13:59:59
> +	 *       read_tm: 2022-04-28 14:00:00
> +	 *
> +	 * Note: as we have avoided testing around the zero
> +	 * clock, so it's impossible to hit situation 5#
> +	 *       set_tm:  2022-04-28 23:59:59
> +	 *       read_tm: 2022-04-29 00:00:00
> +	 */
> +	if (!(set_tm->tm_sec == read_tm->tm_sec)
> +		|| !(set_tm->tm_min == read_tm->tm_min)
> +		|| !(set_tm->tm_hour == read_tm->tm_hour)) {
> +
> +		seconds1 = (set_tm->tm_hour  * 3600) + (set_tm->tm_min  * 60) + set_tm->tm_sec;
> +		seconds2 = (read_tm->tm_hour * 3600) + (read_tm->tm_min * 60) + read_tm->tm_sec;
> +
> +		delta = seconds2 - seconds1;
> +
> +		if (delta < 0 || delta > 3)
> +			return 1;
> +	}
> +
> +	return !((set_tm->tm_mday == read_tm->tm_mday)
>  		&& (set_tm->tm_mon == read_tm->tm_mon)
>  		&& (set_tm->tm_year == read_tm->tm_year));
>  }

I would have done this a bit differently, first chek for day, mon, year
then do the calculation as:

	if (set_tm->tm_year != read_tm->tm_year)
		return 1;

	if (set_tm->tm_mon != read_tm->tm_mon)
		return 1;

	if (set_tm->tm_mday != read_tm->tm_mday)
		return 1;

	seconds1 = ....
	seconds2 = ....
	delta = ...

	if (delta < 0 || delta > 3)
		return 1;

	return 0;


I find this a bit clearer to read.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
