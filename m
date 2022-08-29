Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E03ECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 14:24:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12D1E3CA564
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 16:23:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED66B3C81E1
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 16:23:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0792B1A009AA
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 16:23:45 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0407021BF8;
 Mon, 29 Aug 2022 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661783025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgJczp41ms3dPbfsITW1UdVs7YaOR45KS/PuAAQQ82g=;
 b=fKo9Jv7HSG4f0CWkfQHKXZJNw+WG3tQ4paL0HfITlOZwKjud+K0aaPb0Aiwwm+kalVf7tn
 4+kHXAAaErlqZcMOj+ImGoLUMocNAqe3y481ukoSlbmXjRZv8Fr1ljNlWXIkcM/XyTxsUi
 14/+6cxnK+2GNxMS/mJ47RjQyHtPiTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661783025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgJczp41ms3dPbfsITW1UdVs7YaOR45KS/PuAAQQ82g=;
 b=TVtV45DCl2H7JDSDZN3We9JTS1Z8vkCd4pN5SaQVqhMA+g1Sd3KDmGjulRtsWNbiEC25Oo
 UodBfhMObTGAsbAg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5F83B2C141;
 Mon, 29 Aug 2022 14:23:44 +0000 (UTC)
References: <20220825105204.953388-1-dylan@andestech.com>
 <87k06v1pwp.fsf@suse.de> <Ywh5G6RQi+zitagg@atcsi01>
 <877d2v1kot.fsf@suse.de> <YwyhcokJoLLXTvvr@atcsi01>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Dylan Jhong <dylan@andestech.com>
Date: Mon, 29 Aug 2022 15:22:40 +0100
In-reply-to: <YwyhcokJoLLXTvvr@atcsi01>
Message-ID: <8735dfku1c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/semctl03: Solve kernel panic in semctl03
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
Cc: "Randolph Sheng-Kai Lin\(\(\(\(\(\(\(\(\(\(\)" <randolph@andestech.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>, "Alan
 Quey-Liang Kao\(\(\(\(\(\(\(\(\(\(\)" <alankao@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Dylan Jhong <dylan@andestech.com> writes:

> On Fri, Aug 26, 2022 at 03:53:22PM +0800, Richard Palethorpe wrote:
>> Hello,
>> 
>> Dylan Jhong <dylan@andestech.com> writes:
>> 
>> > Hi Richard,
>> >
>> > Thanks for your reply.
>> > My opinion is the same as yours, libc should do more checking and
>> > protection for incoming parameters
>> 
>> This is not my opinion.
>> 
>> Are you saying that libc segfaults? This is an acceptable outcome for
>> the LTP. To stop the test failing we can fork the test and check if the
>> child segfaults. However it seems the EFAULT test is already skipped if
>> we use libc, which is also acceptable.
>> 
>> However the patch title says that this resulted in a kernel panic due to
>> a null pointer dereference? This is a serious kernel bug that may be
>> exploitable.
>> 
>
>>>>>> Are you saying that libc segfaults? This is an acceptable
>>> outcome for the LTP. To stop the test failing we can fork the test
>>> and check if the child segfaults. However it seems the EFAULT test
>>> is already skipped if we use libc, which is also acceptable.
>
> It's segmentation fault from glibc. Sorry for the confusion.
> If there is a V2 version, I will modify the title.
>
> The failure case comes from the code below,
> which expect EINVAL as the return value.
>
> tests[] = {
> 	{&sem_id, -1, &semds_ptr, EINVAL, "invalid IPC command"},
> 	{&bad_id, IPC_STAT, &semds_ptr, EINVAL, "invalid sem id"},  <-- Segfault occurs on this testcase
> 	{&sem_id, GETALL, &bad_ptr, EFAULT, "invalid union arg"},
> 	{&sem_id, IPC_SET, &bad_ptr, EFAULT, "invalid union arg"}
> };
>
> This is correct in some architechures. But on other architectures where 
> __IPC_TIME64 is defined, this segmentation fault will occur in glibc.
>
> When those architectures that define __IPC_TIME64 call semctl(), glibc will 
> additionally enter a conversion function named semun64_to_ksemun64()[*1].
> Then the 4th parameter, "semun64.buf" from semctl() will be passed to the 
> next function[*2]. Finally a segmentation fault occurs in the 
> semid64_to_ksemid64() function[*3].
>
> The purpose of this test case should be to detect if glibc returns EINVAL 
> when we pass bad_id to semctl(), but not every architecture can get this
> result. The segmentation fault caused by semun64.buf is NULL is obviously 
> not the expected result of this testcase, so I think it should be the
> correct way to modify the 4th argument pass to semctl().

Thanks, this clears up the confusion, I'll modify the description and merge.

>
> [*1] https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L172
> [*2] https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L107
> [*3] https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L68
>
> Best regards,
> Dylan Jhong
>
>> >
>> > In semctl03.c, the two tv->semctl() implementation functions, which are libc_semctl() and sys_semctl(),
>> > do not pass the 4th argument ".buf" to the next level system call.
>> > At present, the 4th argument of semctl() implemented in semctl03.c is hard-coded,
>> > I think passing parameters instead of hardcoding should be more better for this testcase.
>> > Should we pass all parameters to the next level semctl() system call?
>> 
>> A 4th arg is never passed, if you remove the vararg the test compiles
>> and runs fine. So the vararg should be removed, but this is relatively
>> minor compared to a kernel null pointer dereference.
>> 
>> -- 
>> Thank you,
>> Richard.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
