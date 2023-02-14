Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E514C61DA4
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 12:30:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360AE3CC659
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 13:30:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A08B3C1D84
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 13:30:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 450A11400757
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 13:30:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8947321BF6;
 Tue, 14 Feb 2023 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676377806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0cUDU98sMcl6tR6UnQX4kO2zscLtNU8RJ9lKtrn9ZV8=;
 b=05smTT55S3z+YKtwiCqJoKYEqjRJZJtWHBcE9by+PUJ7WHDxBboP/vjP1PMUaRYjsbceqg
 3bNul1DiAlWQ/q1TqGDwzvX95IR+ScaiIz88knTviOcV9r/JUZw44I8QuNa4d8vFmWVpJo
 R5vYEHK+1HBcbXDMWJ6CixypE3ywaQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676377806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0cUDU98sMcl6tR6UnQX4kO2zscLtNU8RJ9lKtrn9ZV8=;
 b=JzYdkIhSSe1eJYYg5v8VuxwMA+yzGvvBo1aShYU/Q38riZuDg0k2NVCRupX/h/YMgIyW06
 tZ224I42MDXbMiCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4BBA02C141;
 Tue, 14 Feb 2023 12:30:06 +0000 (UTC)
References: <20230208091120.9994-1-andrea.cervesato@suse.com>
 <Y+ZDlj7gSCgdWFC1@yuki> <5be1311a-6057-5362-93f6-ee623279e79e@suse.com>
 <Y+t5bm5dn/BzKnYj@yuki>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2023 12:27:50 +0000
Organization: Linux Private Site
In-reply-to: <Y+t5bm5dn/BzKnYj@yuki>
Message-ID: <87sff8mnua.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor pidns30 test using new LTP API
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >> +static void run(void)
>> >>   {
>> >> -	int status;
>> >> -	char buf[5];
>> >> -	pid_t cpid;
>> >> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
>> >>   
>> >> -	setup();
>> >> +	remove_mqueue(mqd);
>> >> +	received = 0;
>> > I wonder if we really need to clear the flag here, as far as I can see
>> > we only modify that variable in the child process and that shouldn't
>> > propagate to parent, unless we pass CLONE_VM of course.
>> Flag reset has been added to be 100% sure we are receiving the signal on 
>> -i > 1.
>
> My point was that the variable is only changed in the child process,
> that means that this change will never make it back to the parent since
> the whole VM is copy-on-write...

Indeed, I shouldn't have merged that.

>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
