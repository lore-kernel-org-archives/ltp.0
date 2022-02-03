Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F55EC433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 05:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDBAA3C98F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 06:43:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 883B63C9120
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 06:43:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 850741000AE4
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 06:43:02 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8702A1F398;
 Thu,  3 Feb 2022 05:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643866981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hp9tH5FDmj9sERJ7IJBzCOticX49/L83NEf2vt7Dn4o=;
 b=Xsx1D51bRdfjdZqXZlWVJdNDVnNM+hDDA2Hy9qLcENVm2U9bxYLWlLstViq8SFMtZcVaRV
 cJEJHLynRc7jIGkILFfq0p2TSmVaYnMB8K6ZVs9lPwUMQi6Jwio2ILupKSfEXKqCiFWEYb
 tEES+z5Evizjfo17s+36jeTMV/AxQQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643866981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hp9tH5FDmj9sERJ7IJBzCOticX49/L83NEf2vt7Dn4o=;
 b=G5LMRlaPBott3cCEoW+UzEl8M81PdD+SxbVYYP3lvnldefDklVYXr13NFl0KBPLzwq3mHI
 Y4omxGWBgLpQEmAw==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 210B6A3B8B;
 Thu,  3 Feb 2022 05:43:01 +0000 (UTC)
References: <20220201142230.20243-1-andrea.cervesato@suse.de>
 <Yfo5P7ZZI33xz+6K@pevik>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 03 Feb 2022 05:31:03 +0000
In-reply-to: <Yfo5P7ZZI33xz+6K@pevik>
Message-ID: <8735l0y07y.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Extract libclone from
 testcases/kernel/containers
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Andrea,
>
> [ Cc Richie, Li ]
> https://lore.kernel.org/ltp/20220201142230.20243-1-andrea.cervesato@suse.de/
>
>> libclone has been added to the libs folder and updated with the new
>> LTP API. This library will be used by containers tests, which will be
>> updated to the new LTP API as well.
> I suppose you want to use it for containers (still use legacy API), which
> already use it. I remember Richie not considering libclone.h as a good source
> and suggesting to use SAFE_CLONE() for simple cases.
>
> https://lore.kernel.org/ltp/878s7k59tk.fsf@suse.de/
>
> We probably need some wrapper for containers, but we should recheck, whether
> we want to take a different approach. Code in the functions is really a bit weird.
>

Yeah tst_clone.{c,h} is the new library which uses clone3 + a
compatability layer if clone3 is not available. This avoids reinventing
a cloning API to some extent because the clone3 interface is nice IMO.

Also IMO tests should be rewritten to use tst_clone, I just haven't had
chance to do that.

BTW we need to test cloning into a CGroup, so I'll probably add that
soon.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
