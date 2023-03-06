Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8504BC6FD1C
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 14:32:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A89193CDB4A
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 15:32:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECCD43CB896
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 15:32:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62FFF10005A1
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 15:32:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 49B191FDEB;
 Mon,  6 Mar 2023 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678113160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sq3wYdWDSLrceG4zIcBrOl2/82RUlihfUEWhJTmRxKQ=;
 b=GWv6BvGo+bEmXACoKxABUWk76twIoHXG3AhMP+9KzAWS8mAQs1RbEUZnnWRB7+X/Im+QRp
 BQXkX8VRsX0nTarMLaBaw4oHfvE4L01FSIvg8HGPc/MW3chiWu0wPIR+vXWvVWOfxP7WGh
 Rb9yFnhbBL4gNj2sydMqL19oqByG9BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678113160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sq3wYdWDSLrceG4zIcBrOl2/82RUlihfUEWhJTmRxKQ=;
 b=VULl1n9UYQZZFUdHyFQKKhzu4W0OWgvpRZJT9PPZ7gF0z4lsLxwXgen0FNHMHVfr6NYhOa
 DZw6HlgvqNr9u6DA==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 36D702C141;
 Mon,  6 Mar 2023 14:32:38 +0000 (UTC)
References: <1677573864-5319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <13c9ecd8-48d7-dccc-a3b7-ec934e2f1369@suse.com>
 <f80d0b90-f7c7-d979-9a97-22655f7ff1b2@fujitsu.com> <Y/3L6GjSfRHT7+ir@yuki>
 <1bd2cc76-8dea-2d5c-792f-bece869d551c@fujitsu.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Mon, 06 Mar 2023 14:10:15 +0000
Organization: Linux Private Site
In-reply-to: <1bd2cc76-8dea-2d5c-792f-bece869d551c@fujitsu.com>
Message-ID: <87bkl67xxa.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi Cyril
>
>> Hi!
>>>> Did you try this?
>>>>
>>>> TST_EXP_FAIL(tst_clone(&cargs), EPERM);
>>>
>>> I don't try this because I remembered TST_EXP_FAIL only thinks the
>>> correct return value is -1.
>>>
>>> tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
>>> utsname04.c:27: TINFO: Dropping root privileges
>>> utsname04.c:33: TFAIL: tst_clone(&cargs) invalid retval -2: EPERM (1)
>> 
>> It's actually the tst_clone() that returns -2 if fallback to __NR_clone
>> failed.
>> 
>> @Ritchie Is there actually a good reason why tst_clone() returns -2 on a
>>           fialure? Can we fix the code by:
>
> I guess it is used to distinguish clone3(-1) and clone failure(-2).
> @Ritchie  Is this right? Or you have other meaning.

Yes, this is how it is used in SAFE_CLONE to provide debug information
when tst_clone fails.

It's important to know which clone failed as obviously they do not
support all the same flags or features.

>
> Maybe we can use clone instead of tst_clone in this case?

I think just use the return value as it was intended and print which
version of clone failed.

>
> Best Regards
> Yang Xu
>   >
>> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
>> index ecc84408c..bacd269d9 100644
>> --- a/lib/tst_clone.c
>> +++ b/lib/tst_clone.c
>> @@ -39,8 +39,5 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>>          pid = syscall(__NR_clone, flags, NULL);
>>   #endif
>>   
>> -       if (pid == -1)
>> -               return -2;
>> -
>>          return pid;
>>   }
>> 
>> 


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
