Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6271BC4332F
	for <ltp@archiver.kernel.org>; Thu, 22 Dec 2022 09:59:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C416F3C63BC
	for <ltp@archiver.kernel.org>; Thu, 22 Dec 2022 10:59:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96BFC3C327F
 for <ltp@lists.linux.it>; Thu, 22 Dec 2022 10:59:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC987600920
 for <ltp@lists.linux.it>; Thu, 22 Dec 2022 10:59:09 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DB0EB77476
 for <ltp@lists.linux.it>; Thu, 22 Dec 2022 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671703148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyepmK5DKHU+I/4K4nS1qLufZJgxV+2yxcpNM8Bnr74=;
 b=UJwJp+b6O33ktC+vY2Pn6mr4uBERQgXv1gsDyJXmsnNRwXJPtduqUYlOB93RyB42jkQSB5
 26RdWqC3Ft13Qc+inpNJjCY2JYJ5b5a6ual9UG9CrFB2b9pfBVz6ZHxVAXAYdZpmh2NvKF
 b6ozRWPa8QFXT23KvT9EtoNNYsxNT8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671703148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyepmK5DKHU+I/4K4nS1qLufZJgxV+2yxcpNM8Bnr74=;
 b=8fzrDcTX/lfwoi1lf0gjBV7aku9JiOv/3W6FzCqWtnF08T5Sx5SxcyASIHiyMMVvRxERQr
 0mpipDXRa9DGm8BA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A84E42C141;
 Thu, 22 Dec 2022 09:59:08 +0000 (UTC)
References: <Y5xF6PU5Yvh+oku5@pevik> <20221220075714.28762-1-akumar@suse.de>
 <87a63ith0b.fsf@suse.de> <Y6QoLAfvY/W175WH@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Dec 2022 09:53:35 +0000
Organization: Linux Private Site
In-reply-to: <Y6QoLAfvY/W175WH@pevik>
Message-ID: <87a63fsqs3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] statvfs01: Convert to new LTP API
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Avinesh, Richie,
>
> Generally LGTM, thanks for fixing exfat and vfat.
>
>> > +	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
> However, length could be smaller:
> Instead using buf.f_namemax + 1 (1531) also for exfat and vfat,
> invalid length is already buf.f_namemax / NLS_MAX_CHARSET_SIZE + 1
> (256).
>
>> > +	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
>> > +		valid_fname = SAFE_MALLOC(buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
>> > +	else
>> > +		valid_fname = SAFE_MALLOC(buf.f_namemax - 1);

There is also a memory leak when running with -I. You could just use an
4Kb (PATH_MAX) static buffer as the name. If we find an FS that allows
longer names then we can increase it.

We could also use a guarded buffer (specified in tst_test).

>
>> > -		if (TEST_RETURN == -1) {
>> > -			tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...) failed",
>> > -				 TEST_PATH);
>> > -		} else {
>> > -			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
>> > -		}
>> > +	memset(toolong_fname, 'b', buf.f_namemax + 1);
>> > +	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
>> > +		memset(valid_fname, 'a', buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
>> > +	else
>> > +		memset(valid_fname, 'a', buf.f_namemax - 1);
> Also valid length is for buf.f_namemax, not buf.f_namemax - 1. I guess -1 is for
> \0 (NULL terminator), but tests work even with just buf.f_namemax.
>
> Also adding variable to hold the length makes source more readable.
> How about this?
>
> 	struct statvfs buf;
> 	char *valid_fname, *toolong_fname;
> 	long fs_type;
> 	long valid_len;
>
> 	fs_type = tst_fs_type(TEST_PATH);
>
> 	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
>
> 	valid_len = buf.f_namemax;
> 	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> 		valid_len = buf.f_namemax / NLS_MAX_CHARSET_SIZE;
>
> 	valid_fname = SAFE_MALLOC(valid_len);
> 	memset(valid_fname, 'a', valid_len);
>
> 	toolong_fname = SAFE_MALLOC(valid_len + 1);
> 	memset(toolong_fname, 'b', valid_len + 1);
>
> Final diff is below.
>
> Kind regards,
> Petr
>
> diff --git testcases/kernel/syscalls/statvfs/statvfs01.c testcases/kernel/syscalls/statvfs/statvfs01.c
> index 034835da7d..f357855eb1 100644
> --- testcases/kernel/syscalls/statvfs/statvfs01.c
> +++ testcases/kernel/syscalls/statvfs/statvfs01.c
> @@ -25,22 +25,21 @@ static void run(void)
>  	struct statvfs buf;
>  	char *valid_fname, *toolong_fname;
>  	long fs_type;
> +	long valid_len;
>  
>  	fs_type = tst_fs_type(TEST_PATH);
>  
>  	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
>  
> -	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
> +	valid_len = buf.f_namemax;
>  	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> -		valid_fname = SAFE_MALLOC(buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> -	else
> -		valid_fname = SAFE_MALLOC(buf.f_namemax - 1);
> +		valid_len = buf.f_namemax / NLS_MAX_CHARSET_SIZE;
>  
> -	memset(toolong_fname, 'b', buf.f_namemax + 1);
> -	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> -		memset(valid_fname, 'a', buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> -	else
> -		memset(valid_fname, 'a', buf.f_namemax - 1);
> +	valid_fname = SAFE_MALLOC(valid_len);
> +	memset(valid_fname, 'a', valid_len);
> +
> +	toolong_fname = SAFE_MALLOC(valid_len + 1);
> +	memset(toolong_fname, 'b', valid_len + 1);
>  
>  	TST_EXP_FD(creat(valid_fname, 0444));
>  	SAFE_CLOSE(TST_RET);


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
