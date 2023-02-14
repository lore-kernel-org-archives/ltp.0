Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B7CC61DA4
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 09:48:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00F13CC5FB
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 10:47:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B792D3CB0B8
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 10:47:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C62DF60086A
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 10:47:46 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D08F21F45E;
 Tue, 14 Feb 2023 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676368064;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YL0HY56Uz3S8RPuIrNUIe2G+48xrKqM0NTtpY6xBcXs=;
 b=y7CIm1q3ZHQwyybFUzaOnel3V8u/TjYvgWcCt3gWFNBSEmtUI39XyrT3FRTeeen8FcstnE
 sje6WkzM27TMHZ5Uy972Czz6zF0jmP0DWi9burj7JwiXVqv6rsyW9R677hjo5wjQGocv8D
 68zYhKnVEnsxJPuoQZFL2awwI+bubz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676368064;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YL0HY56Uz3S8RPuIrNUIe2G+48xrKqM0NTtpY6xBcXs=;
 b=M3jxQavay1d14pAn+5wA+QI1ZLW/GHSXCqF1qNZaIzaRx0jiTlnGiYhWTMMZc9sWHGeEtc
 g5Xp5eaiI9W8XUDQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 997282C141;
 Tue, 14 Feb 2023 09:47:44 +0000 (UTC)
References: <20230208091120.9994-1-andrea.cervesato@suse.com>
 <Y+ZDlj7gSCgdWFC1@yuki> <5be1311a-6057-5362-93f6-ee623279e79e@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 14 Feb 2023 09:47:24 +0000
Organization: Linux Private Site
In-reply-to: <5be1311a-6057-5362-93f6-ee623279e79e@suse.com>
Message-ID: <87r0uso9xc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Merged, thanks!

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Hi,
>
> On 2/10/23 14:16, Cyril Hrubis wrote:
>> Hi!
>>> +static void run(void)
>>>   {
>>> -	int status;
>>> -	char buf[5];
>>> -	pid_t cpid;
>>> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
>>>   -	setup();
>>> +	remove_mqueue(mqd);
>>> +	received = 0;
>> I wonder if we really need to clear the flag here, as far as I can see
>> we only modify that variable in the child process and that shouldn't
>> propagate to parent, unless we pass CLONE_VM of course.
> Flag reset has been added to be 100% sure we are receiving the signal
> on -i > 1.
>>
>> Other than this it looks really good:
>>
>> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>>
> Andrea


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
