Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A21C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 14:10:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B083F3C92A8
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 15:10:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F9A53C0CF0
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 15:10:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 86C27140017A
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 15:10:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D4C6D1F388;
 Tue, 21 Dec 2021 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640095840;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AC15MEyZXQmNJovu/yFkYwOCfsauiW4tZp3ZyxIbHag=;
 b=Y22N1apK/CzroS+R0dhYPUyLGs0fwo8cmHo7ItQgvSL9g4mScGVonLc6JRh2iKGnqycJRV
 dGxyNKhqGOe9J7NhDdLwTDNJWS26Gw2oSUFXrOVjyFr0X2AEU4THnFM+f3ZFswFeTjTTNb
 t7tumL194jwSlKQ9cWVwqL8YHqBB1x0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640095840;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AC15MEyZXQmNJovu/yFkYwOCfsauiW4tZp3ZyxIbHag=;
 b=7Vp9O5vMp4F6VTVeFp7AXsVzV41JizJlwWZMvKjiUVWCevtnKSx4PONqS3FhSy3MzfkIQ3
 jDmNKgMe0zfheDAA==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9AD1FA3B83;
 Tue, 21 Dec 2021 14:10:40 +0000 (UTC)
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com>
 <CAEemH2eFg5HVK32hLGrB_OvqN4Ef+QfkdkGebKgEkz--tYYoKA@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 21 Dec 2021 13:56:12 +0000
In-reply-to: <CAEemH2eFg5HVK32hLGrB_OvqN4Ef+QfkdkGebKgEkz--tYYoKA@mail.gmail.com>
Message-ID: <875yrif3qd.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> On Tue, Dec 21, 2021 at 7:31 PM Richard Palethorpe via ltp
> <ltp@lists.linux.it> wrote:
>>
>> Add an unstable kernel ABI flag and a runtest file for unstable
>> tests. This means we can add tests which are likely to be broken by
>> changes in the kernel ABI. Without disrupting LTP releases which are
>> required to be stable.
>>
>> Users who require stability can filter the tests with this flag
>> or not schedule the unstable runtest file(s).
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>
>> How about adding this to the fanotify22 patch?
>>
>>  include/tst_test.h        | 12 ++++++++++++
>>  lib/tst_test.c            |  6 ++++++
>>  runtest/syscalls-unstable |  3 +++
>>  3 files changed, 21 insertions(+)
>>  create mode 100644 runtest/syscalls-unstable
>>
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index 450ddf086..ff31e972e 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -174,6 +174,18 @@ struct tst_test {
>>         int skip_in_lockdown:1;
>>         int skip_in_compat:1;
>>
>> +       /*
>> +        * Test is for a feature that has not been added to the stable
>> +        * kernel ABI. That is, it's for a feature only available in
>> +        * linux-next, an RC or some other development branch.
>> +        *
>> +        * This string should be set to some text describing the
>> +        * kernel branch and version the test was developed
>> +        * against. e.g. "5.16 RC2", "linux-next-20211220",
>> +        * "net-next".
>> +        */
>> +       const char *const unstable_abi_version;
>
> I'm not sure if this will bring convenience or trouble to LTP.
>
> If a new syscall is in development (or merged in linux-next) but
> drop/change in mainline-kernel. We have to adjust the test case
> accordingly.

If someone is motivated enough to contribute tests for an unreleased
feature. There is a high chance they will make the changes. In the worst
case we just delete the test.

>
> And after the feature is go into the mainline kernel finally, should
> we move that from 'syscalls-unstable' to 'syscalls' and remove the
> tst_test->unstable_abi_version field at the same time?

Yes.

>
> Btw, why not we just keep the unstable-syscall test case stay
> in the review phase until it gets merged in mailline-kernel?
> I guess that wouldn't block anything or make anyone unhappy.

It's a lot of work to merge patches into your own branch for testing RCs
and linux-next. It makes collaboration a lot harder. It's easy for
people just to enable the unstable tests. Then new features will get
tested on a much wider range of setups.

It increases the chances of finding bugs before release.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
