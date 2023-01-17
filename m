Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F564C6379F
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 16:59:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BE213CD9EF
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 17:59:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E85C63C7197
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 17:59:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52660600819
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 17:59:19 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3EA5621F69;
 Tue, 17 Jan 2023 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673974758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rp/tbTZJPO1j85edWsIAoiFfak+DCsEQczf4zAWvpzw=;
 b=lyaB5Ds5uNbF7ypCvVvDbZCg2cO7KDGO6xhI8q7MTBH2h9duYt9wmmPJ/g3/rtVCMrCxw1
 ZVkXZzCfzPb9xH3Xv2luJ65LMeXkmA67aR82pgWr+G4e5H5gFs5S51BB+reMBsLHRRXNdS
 yDnae5/x1084fHqqjafXqJ7lqPvtDLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673974758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rp/tbTZJPO1j85edWsIAoiFfak+DCsEQczf4zAWvpzw=;
 b=eBpP8ddfE6bOd2muza8z4c3M5D/x2QcJOJbrpdiox+WW0+pdPBi4Y2tsZgRzz25HqUlCjj
 0RJKgdwgr98n0vCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0BC3E2C141;
 Tue, 17 Jan 2023 16:59:18 +0000 (UTC)
References: <20230116074101.1264-1-wegao@suse.com> <87fscawlku.fsf@suse.de>
 <20230117021631.GA20825@aa> <877cxlwk66.fsf@suse.de>
 <Y8bN4Bxkook8BZvs@yuki>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jan 2023 16:50:49 +0000
Organization: Linux Private Site
In-reply-to: <Y8bN4Bxkook8BZvs@yuki>
Message-ID: <87tu0pumfu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] readahead02.c: Use fsync instead of sync
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
>> > The motivation of this change is base on the https://github.com/linux-test-project/ltp/issues/972
>> > which give following suggestion:
>> > "As we run the test inside a loop device I guess that we can also 
>> > sync and drop caches just for the device, which should be faster 
>> > than syncing and dropping the whole system. Possibly we just need 
>> > to umount it and mount it again."
>> 
>> I see. Well unless Cyril can show that the test is actually failing
>> somewhere (or there is a strong logical argument this will cause a
>> failure). Then this task is still valid, but low priority IMO.
>
> We do sync more than needed here, since we are looking at the per device
> counters we have to sync just the device we mount for the test, so this
> is optimization for the case that the system has many dirty cases and
> will need seconds or a minute to write them to the pernament storage.
>
>> > But currently i can not find any API to sync and drop caches just 
>> > ONLY for device, so base my view just replace sync whole 
>> > system to single file also can make a small help.
>> 
>> If we don't have one or more concrete failures to focus on then we
>> really have to research whether fsync (or syncfs FYI) or unmounting the
>> device are the correct thing to do. They will all have subtly different
>> effects.
>
> Looking at the code closely I'm starting to think that the sync is not
> required at all. What we do in the test is that we create file and sync
> it to the external storage. Then we read it a few times and mesure
> differences in cache. As far as I can tell we just need to drop the page
> cache after we have read the file. What do you think?
>
> In any case I would avoid changing the test before the release, but it's
> certainly something we can look at after that.

I still think same as before. It may be valid to drop sync or whatever,
but it's just not important compared to actively failing tests.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
