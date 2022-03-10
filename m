Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D880FC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:19:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8526F3C1BCA
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 13:19:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8BA23C0214
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 13:18:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBE2A601AED
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 13:18:50 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E7C201F381;
 Thu, 10 Mar 2022 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646914729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJBc4DuRYrWRFbsoEkV56wWyONQ3cGZGWcwL/RItJSo=;
 b=BiOxDryGxQoB3vYBG3ux35f6f+ddxgOB4goAavKtyGWUTTl46L8I6TQOoZTOsrkQbpbo/H
 9bO8iYraYmBOx6exgCvjTZb26s+znbLgNLqNywOC6TP4Ba//n76rWhzCuSez8AJu/ukEel
 6vZCB+sQXjHsVmDxDRxMpdGb5AvuTfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646914729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJBc4DuRYrWRFbsoEkV56wWyONQ3cGZGWcwL/RItJSo=;
 b=OXK1ztmet9MhnEDeGDCHJ5tD250pKC/iIKrxmOGVdEB9lOxA8vKgMs+Aw/kGcjo4FtlRsX
 Lv+ggzU/yY83PiCQ==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A15C4A3B96;
 Thu, 10 Mar 2022 12:18:49 +0000 (UTC)
References: <20220310082251.13173-1-liwang@redhat.com>
 <6229B934.9040606@fujitsu.com> <6229BFAD.1060504@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Thu, 10 Mar 2022 12:09:08 +0000
In-reply-to: <6229BFAD.1060504@fujitsu.com>
Message-ID: <87tuc6knks.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
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

> Hi Richard
>> Hi Li
>>> --- a/lib/newlib_tests/test19.c
>>> +++ b/lib/newlib_tests/test19.c
>>> @@ -23,7 +23,7 @@ static struct tst_test test = {
>>>    	.needs_root = 1,
>>>    	.test_all = run,
>>>    	.setup = setup,
>>> -	.save_restore = (const struct tst_path_val const[]) {
>>> +	.save_restore = (const struct tst_path_val[]) {
>>>    		{"?/proc/nonexistent", NULL},
>>>    		{"!/proc/sys/kernel/numa_balancing", NULL},
>>>    		{"/proc/sys/kernel/core_pattern", NULL},
>>
>> Since tst_path_val is a struct array, we should use {NULL, NULL} or {}
>> terminated instead of NULL terminated , otherwise it will report missing
>> braces warning.
> Since we have the following rule
> LTP-005 Array must terminate with a sentinel value (i.e. NULL or '{}')
>
> Can we check struct array whether use {} terminated instead of NULL?

I think so, however naively enabling the check causes a segfault in
ptr_list_empty. Probably because there is no list, it's just NULL.

It already reports the missing braces, but I suppose this is not very
helpful.

>
> Best Regards
> Yang Xu
>>
>> Best Regards
>> Yang Xu
>>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
