Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A96C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 05:15:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE07C3C90E8
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 06:15:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D55613C9046
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 06:15:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 05FBA1A003FD
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 06:15:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0755E1F37B
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 05:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641359741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwg27nUu69mJuVnyS7QKwTGWUrXz4AXE9fSFViOYMzg=;
 b=q06ArM/OMeWmsHUCT24+K7TujwxfYi4LaoPlmXM2PJZTaowOS2n3FJqelbIkBIfdN1PgIl
 zp59TMNp5o0/yBEF35LTRwA3wvxfQQFNiVl8DavKYsdFnq9oiEFE9bK0N2ds72DbJ7NfYN
 eJyq6VKal+V0KsiMPP7h1xW10sSvwP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641359741;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwg27nUu69mJuVnyS7QKwTGWUrXz4AXE9fSFViOYMzg=;
 b=Luj1P+7oSYx8qPm+x+bk1jcgdyav0Wq840mXexbck5nfx5mxrS7kz7J1hK57NRntrKz8w6
 /63KjFetppVxuODw==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C677AA3B84;
 Wed,  5 Jan 2022 05:15:40 +0000 (UTC)
References: <20220104122010.23069-1-rpalethorpe@suse.com>
 <20220104122010.23069-5-rpalethorpe@suse.com> <YdRhmxXqDNAV2sva@yuki>
 <871r1no5kd.fsf@suse.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 05 Jan 2022 05:12:52 +0000
In-reply-to: <871r1no5kd.fsf@suse.de>
Message-ID: <87wnjen4p5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] cgroup: Add memcontrol02
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

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Cyril Hrubis <chrubis@suse.cz> writes:
>
>>> + *
>>> + * [Description]
>>> + *
>>> + * Conversion of second kself test in cgroup/test_memcontrol.c.
>>> + *
>>> + * Original description:
>>> + * "This test creates a memory cgroup, allocates some anonymous memory
>>> + * and some pagecache and check memory.current and some memory.stat
>>> + * values."
>>> + *
>>> + * Note that the V1 rss and cache counters were renamed to anon and
>>> + * file in V2. Besides error reporting, this test differs from the
>>> + * kselftest in the following ways:
>>> + *
>>> + * . It supports V1.
>>> + * . It writes instead of reads to fill the page cache. Because no
>>> + *   pages were allocated on tmpfs.
>>
>> Shouldn't we actually run the test both for read/write and skip the read
>> part of tmpfs?
>>
>> Well I guess that the pages are put into the page cache the same way
>> regardless if they came from userspace write or as a request for data to
>> be read from the disk, so probably not I guess.
>
> I reckon there are a lot of ways to fill the page cache from
> userland. mmap and madvise also come to mind. I don't know how many ways
> there are to get/allocate a page from the page cache internally. I guess
> it's possible to circumvent the accountancy.
>
> I think for now just writing is good enough. This doesn't appear to be
> the only test which measures the page cache. So I think we should look
> at what the other tests do first. 
>
>>
>>> + * . It runs on most filesystems available
>>> + * . On EXFAT and extN we change the margine of error between all and file
>>                                            ^
>> 					   margin
>>> + *   memory to 50%. Because these allocate non-page-cache memory during writes.
>>> + */
>>> +#define _GNU_SOURCE
>>> +
>>> +#include <stdlib.h>
>>> +#include <stdio.h>
>>
>> Do we really need stdio here?
>
> Sorry, nope.
>

Actually it is needed otherwise BUFSIZ is undefined...

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
