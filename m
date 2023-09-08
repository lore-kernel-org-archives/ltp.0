Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27856EE57EB
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 09:54:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E4203CE95C
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:54:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1C5B3CB4F9
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:54:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D422F1A000A7
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:54:33 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 255401F8BE
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 09:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694166873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xF9XnpoWiuPwTvm0ss05pjZI2zrrRS+mYEuZkfCOZTs=;
 b=Yo2NzdccdMIelVW+wo9tZuSVkTfCmv201ptGDsvknyGAupeFMuOz8pD12TrbW88q934tGU
 qAQflY6Xavt1lk0wzKCEcJ4C6ZrvaHegcBnWikcHkDAF6fPBLJlBd8JyGiIZoIWUfBkHVW
 cV1qcxKwlFOm1rlUYl+XZF3bVj09D1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694166873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xF9XnpoWiuPwTvm0ss05pjZI2zrrRS+mYEuZkfCOZTs=;
 b=vh+/idaZTsRgANA+IsaCl0O8lb0QJiq1cNjGm60QbwueYjl6UEU6N5KH8L4cMbzv0DNm5m
 ax4Nbhi263QJljBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4DD432C143;
 Fri,  8 Sep 2023 09:54:32 +0000 (UTC)
References: <20230831112629.21510-1-akumar@suse.de> <ZPCKzdDjSKzFayv_@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 08 Sep 2023 10:45:20 +0100
Organization: Linux Private Site
In-reply-to: <ZPCKzdDjSKzFayv_@yuki>
Message-ID: <87v8clgfcb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap21: Add new test for mmap's ENOMEM
 case
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
>> To be more precise in this test and checking for ENOMEM on exact mapping
>> when limit is crossed, I could only think of counting the existing
>> mappings from /proc/$pid/maps and counting the remaining possible
>> mappings. Is there any better approach if we want to test this for exact
>> case?
>
> If you want to check that we managed to create exactly the amount of
> mappings in this limit, this would be a sensible way to do that.
>
> However beware that this also depends on the overcommit settings. If

yes, and perhaps this can be effected by CGroups and resource limit
settings as well. I would assume there are lots of limits that could
effect the test.

> kernel is not set to overcommit and if the size of the memory needed to
> cross the maximal number of mappings would exceed available memory you
> would get ENOMEM before you manage to hit the limit. With overcommit
> enabled you can create mappings as long as the kernel has enough memory
> to hold the vma structures.
>
> At my system the limit is set to 65530 which on 4k page size would
> consume around 300MB, which does not seem to be much, but may still fail
> on small embedded boards with disabled overcommit. So either we try to
> set the limit to a lower value for the duration of the test, or allow
> the mmap() to fail sooner if we find that available memory is close to
> or smaller than number of mappings multiplied by page size.

That seems like the safest option without enumerating all of the
possible limits.

Setting to changes requested.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
