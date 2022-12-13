Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA751C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:39:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40C533CBDA4
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 11:39:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A016B3C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:39:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CD4251A006F0
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:39:28 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BB6DE1FE4C;
 Tue, 13 Dec 2022 10:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670927967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFcV13OAEjoi1RiCN/UtNvrLZQhCbm0jcaB3Dcdpw28=;
 b=l36dvOBIa/MfATofclzghT764DQpPeSl2O4a1HVYZ7pxtf4ZfSB7srT3BHZRdoFNZzamni
 GZKab9WBr7QgzY+DTMdwc0LBnNNOWhgJRjvkN1jXUHYjgX7mHnzzY+iOpud25icpSN34NU
 t9sYwQyouK4L80DFUC7ZT0qcLJI2UOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670927967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFcV13OAEjoi1RiCN/UtNvrLZQhCbm0jcaB3Dcdpw28=;
 b=c8djfpCmJzi9tc4d/93Yn0TUmX2vUGBVnaGhUp4WDki79LsGTo92uGP6cEVoWZr0Sw7ASw
 3sMwUe81hkYXRXBQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7C85D2C16F;
 Tue, 13 Dec 2022 10:39:27 +0000 (UTC)
References: <20221213094427.32743-1-rpalethorpe@suse.com>
 <Y5hLfAN7NCvsKmNk@pevik>
 <e0488665-e68e-455d-6ee6-8709b5f57599@fujitsu.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Tue, 13 Dec 2022 10:36:00 +0000
Organization: Linux Private Site
In-reply-to: <e0488665-e68e-455d-6ee6-8709b5f57599@fujitsu.com>
Message-ID: <877cyvsi3l.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcpu01: Reinstate node_id test
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

>> 
>> FYI Richie is touching the same code, one of you will need to rebase.
>> IMHO it's better to remove this in dedicated patchset (i.e. in Xu).
>
> Even I will limit the kernel version check to 3.0 in my patchset because 
> we don't reach the same target to 3.10, so let me rebase.
>
> ps: If we reach the same target to 3.10, then we can remove remain old 
> version check in the future.

I'm not sure what you mean. It's not the important thing for this patch
though. I'll just remove it before merge.

>
> Best Regards
> Yang Xu
>> 
>> Kind regards,
>> Petr
>> 
>>> -static void setup(void)
>>> -{
>>> -	if (tst_kvercmp(2, 6, 20) < 0)
>>> -		tst_brk(TCONF, "kernel >= 2.6.20 required");
>>> -}
>>> -
>>>   static struct tst_test test = {
>>>   	.test_all = run,
>>> -	.setup = setup,
>>>   };


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
