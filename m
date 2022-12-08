Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547DEC3A5A7
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 09:37:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF11B3CC06E
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 10:37:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C28A3CA846
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 10:37:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8BCA11A00995
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 10:37:09 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 139F720807
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670492228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys8hjNd5pMNYQq77XupMfCnf+eKcFuzbtdPzREXMiUs=;
 b=J+QCLHLspXiDUW9aB/bxlvrWZIEB4/ugAbBLGY254P+ec4GphkIUgS2YvF7ezf2vo5W+d7
 oHnxJXVsxTrKJQmhiCkYEc1viGwCWdSg8cgA2l17AhbE7uRwUNttFKBAfO3HQqJEGzBMZK
 y5yiReyZlI8dkyMyEm3VW4GYYuq3moM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670492228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys8hjNd5pMNYQq77XupMfCnf+eKcFuzbtdPzREXMiUs=;
 b=X6ofh0QzgK6ujtqwF8m7dLkagaGejQypUWMvH2xTjhPHfXayCAgmMf6V8nqxOtxATfmHVY
 5yNyJKVQFBYgukBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DD5922C33F;
 Thu,  8 Dec 2022 09:37:05 +0000 (UTC)
References: <20221206115329.17760-1-rpalethorpe@suse.com>
 <20221206115329.17760-2-rpalethorpe@suse.com> <Y49EjvZHd1npsXS7@rei>
 <87edtctuos.fsf@suse.de> <Y49qssvWl2g+rvOu@yuki> <87a640trg1.fsf@suse.de>
 <Y4+Dx/K8sglGix0m@yuki>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 08 Dec 2022 08:57:55 +0000
Organization: Linux Private Site
In-reply-to: <Y4+Dx/K8sglGix0m@yuki>
Message-ID: <87o7seqlry.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fill_fs: Ensure written data is not easily
 compressed
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
>> What are we trying to do though, simply fill the device to test the
>> ENOSPC condition or some kind of poor man's fuzzing?
>
> The test is supposed to test what happens when filesystem is altmost
> full and being written to, which may trigger all kinds of corner cases.
> In that sense it makes sense to randomize the access patterns a bit so
> that we have higher chances of utilizing different code paths. But of
> course the question where should we stop in randomizing things and what
> makes sense and what does not.

I think there are multiple scenarious which are totally different.

For example, Redis uses an append only file (AOF) and IIRC you can
choose to batch writes for performance at the expense of data
integrity. It's common for the AOF to have it's own volume.

OTOH if we have a classic server with 1000s of daemons running, then we
can expect writes to happen in parallel and be random.

I'd be in favor of trying to test these things separately and to keep
each scenario as simple (and reproducible) as possible. I think mixing
together different access patterns is better handled by fuzzing.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
