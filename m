Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B582C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 12:07:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D193B3C898C
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 13:07:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98F3A3C0BB7
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 13:06:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 031D31000DDC
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 13:06:52 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 29BAD1F3BA;
 Mon, 13 Dec 2021 12:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639397212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW/pj+3gx314wVXrmcXSupVR9nQSudVd+3xThPaI4ZE=;
 b=B3yOjavSYoEhPmMc0bvLjGKA9yR+GVOdkoy/AnlUd7YfBdGHQa3/UgMYdBWFA5FdQ/nBkX
 TPdQXP1K+F/ZD8aSFxvf1GO8cWZ8PoAaVKwhUrRl4PR5y+jYqHrFPD2PM/EVG1UvPWuy7g
 fU58J6FKEk6kFanlkzHJa5nUgGs6e78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639397212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xW/pj+3gx314wVXrmcXSupVR9nQSudVd+3xThPaI4ZE=;
 b=r+UrdgWNbDahtSpf+H7HItVXcSFpEGbv6yfV75iTL9VOILJUEm126ueV7PBgbrkOM4uQVO
 9pueIjbP06k0TlAQ==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BE419A3B85;
 Mon, 13 Dec 2021 12:06:51 +0000 (UTC)
References: <20211210134556.26091-1-pvorel@suse.cz> <87tufcao8l.fsf@suse.de>
 <YbcM8xKx7G0KQxWU@yuki> <61B70DE2.4040402@fujitsu.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: pvorel@suze.cz
Date: Mon, 13 Dec 2021 11:17:50 +0000
In-reply-to: <61B70DE2.4040402@fujitsu.com>
Message-ID: <87lf0oaeui.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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

> Hi!
>> Hi!
>>>> +* Tests for new functionality in mainline kernel should be merged after final
>>>> +  release of kernel which contains that functionality (it's not enough when the
>>>> +  feature gets into rc1, because it can be reverted in later rc if
>>>> problematic).
>>>
>>> What is the concern? All I can see is that we merge a test which is for
>>> a feature that is never included
>>
>> Not only that, the interface may change subtly.

That can always happen as plenty of changes will break LTP test
expectations, but not real programs.

>>
>>> The issue is we may forget to merge patch sets for features which are
>>> included (a far worse result). It's more stuff waiting around in the
>>> queue. At the least we should have a procedure for tracking them (like
>>> tagging github issues for review at each mainline release).
>>>
>>> If a test requires a kernel config which doesn't exist in mainline we
>>> could also look for that automatically.
>>
>> The main issue is that if we happen to release LTP meanwhile with a test
>> for a syscall that didn't get included in the mainline in the end we
>> have released LTP that is supposed to be stable and the test will start
>> to fail when the syscall number is allocated for something else which
>> will happen sooner or later.
> I know a example that is quotactl_path syscall.
>>

If the real issue is LTP releases, then why not exclude tests for new
features from them? I assume it's only a small number of commits which
would need to be removed. Possibly we could tag them in git when merging
so it is not a lot more work for whoever does the release (namely
Cyril) to create a branch without them.

My main concern is this will throw up a barrier to motivated
contributors working on the cutting edge.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
