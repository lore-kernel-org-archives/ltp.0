Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC38FA373E
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 14:51:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BB033C98BA
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 16:51:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C69D3C8F91
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:50:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D9AD81A00818
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:50:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CBCA51FD8F;
 Mon, 24 Oct 2022 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666623048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/a0tOC47edLlhtGyTE1G4Sz8yRjahcNLicqiTBWkZUU=;
 b=an29Nh5dYCpv45BmTD8FC4+BIftmls1ijEolo+gBFhsplc694s9yI/bvSG08xFUcYUBf6c
 Ec1LtZEEIxXLhAjkUU3q3BrPsuvcHSBf45gcQI4YLvtasEpL92VxycNRaX/m/ZS/T7hxTc
 HiksKo4yBzRiEzJg//1//7SA6x0UdZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666623048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/a0tOC47edLlhtGyTE1G4Sz8yRjahcNLicqiTBWkZUU=;
 b=NxgjtZoGDrpZRRbOYyysZNhcAsYXW2qV5wBw09C2TaNF2boR1muJbVACswp0uDFU+2uDL1
 EpMwxT5TPmTUUzCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 29B002C141;
 Mon, 24 Oct 2022 14:50:48 +0000 (UTC)
References: <1666091413-7732-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y1MZnwFidi1eZoct@pevik>
 <d4483cf3-d1f9-5314-5e87-3b1edf2820e0@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Mon, 24 Oct 2022 15:49:36 +0100
In-reply-to: <d4483cf3-d1f9-5314-5e87-3b1edf2820e0@fujitsu.com>
Message-ID: <87fsfdxol5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mount03: Add statfs f_flags member check
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

"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi Petr
>
>> Hi Xu,
>> 
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> 
>>>   static void run(unsigned int n)
>>>   {
>>>   	struct tcase *tc = &tcases[n];
>>> +	struct statfs stfs;
>> 
>>>   	tst_res(TINFO, "Testing flag %s", tc->desc);
>> 
>>> @@ -159,6 +160,11 @@ static void run(unsigned int n)
>>>   	if (tc->test)
>>>   		tc->test();
>> 
>>> +	SAFE_STATFS(MNTPOINT, &stfs);
>>> +	if (stfs.f_flags & (n == 3 ? MS_REMOUNT : tc->flag))
>> Wouldn't it be better to add another struct member for this check?
>
> Of course, it seems better.
>
> Best Regards
> Yang Xu

OK... Petr are you going to merge this with your changes?

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
