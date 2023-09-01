Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B746CA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 09:13:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CDE83CBF2E
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 11:13:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42063CBC7F
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:13:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D806160043A
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 11:13:00 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D40001F45F
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693559579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FbcF7zzMZCXVTS17lRt4UvMFCgLUzbNEVNxBY4Ob5BA=;
 b=tZLEHm6bvB7Cc4TnF2M9VtFe61++9OIt1B8QuZK7W6n2bJs8KnWqYGZg/bdKXBaZ9kXK/3
 SZ60vx4BfFojGS0AbtdKCB//LqzfSHAi4kvLzt3q237FRzdCVqzD/wM9jpKJhXRZzWg7PC
 fRCbKlQ9cpSUD6TLnVHl4C69WEoSefY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693559579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FbcF7zzMZCXVTS17lRt4UvMFCgLUzbNEVNxBY4Ob5BA=;
 b=VOOlf1WkkU2lxu7hWQL1U3PKUCZx0lUHtO1ASZMezM2hAaBgL5GsGTB2RtygLlvrzj1SdV
 pPbY+GuIYaN5YSAw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0B8752C142;
 Fri,  1 Sep 2023 09:12:58 +0000 (UTC)
References: <20230825063932.30875-1-akumar@suse.de>
 <20230825063932.30875-2-akumar@suse.de> <87fs3yguhw.fsf@suse.de>
 <ZPGpFfGjj5kxgFY_@yuki>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 01 Sep 2023 10:11:52 +0100
Organization: Linux Private Site
In-reply-to: <ZPGpFfGjj5kxgFY_@yuki>
Message-ID: <87bkemgstk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/mmap09: Rewrite the test using new
 LTP API
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
>> > +	addr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_FILE |
>> > MAP_SHARED, fd, 0);
>> 
>> Why don't we use SAFE_MMAP?
>
> I guess mainly because that would produce TBROK instead of TFAIL.
>
>> Can we use all file systems?
>> 
>> The test is mapping a file and performing an operation on it. So this is
>> basically a file system test.
>> 
>> BTW this test seems weak. I don't know what truncating the file without
>> then trying to access the newly OOB memory achieves. However it's what
>> the original test did, so it's up to you if you want to change anything.
>
> I would vote for adding additional checks like this. I suppose that you
> will get SIGBUS when accessing pages beyond new file size, so we should
> probably fork a child, let it touch the truncated part of the file, and
> check that it was killed by SIGBUS.

There is some overlap with mmap13 because that does check for
SIGBUS. Possibly these could be combined?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
