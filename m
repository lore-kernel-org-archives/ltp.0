Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64E3CDB47E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 08:05:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E48743CD427
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 10:05:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B2ED3C888B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:05:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D984E1009BD4
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 10:05:36 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0B7EF1F88E
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 08:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697097935;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHUfSeUU629yuy0hkosa8GCKWJPkRXzlFtW6XtWfUXk=;
 b=LWldYViQXvjaKBiVCWHIdsrA3pXJFVz4/EbvGgKgtPgiKEueVxYi7VOHPXH0Kz+zO0ygqS
 XSlC6gilcddkfr8u8zJdH392WsoWcVH4ea1Rqe1ctVZTdm7+dZiQf4V4dA9CISTmPxG0Nz
 MTPz+tIhGs9wnjP1sxPXJdEZC9E26ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697097935;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHUfSeUU629yuy0hkosa8GCKWJPkRXzlFtW6XtWfUXk=;
 b=+9U5mFHDZ23p/Ka9p4vq1Uco9BoGRB9jf6p2liMq9CN5rlnU32GuQc8szSTeOd0kIdCxM7
 nF2OLy/oUCFrSsCQ==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B19C72C910;
 Thu, 12 Oct 2023 08:05:34 +0000 (UTC)
References: <20231011121448.23134-1-chrubis@suse.cz> <ZSaZLSL4J_rNl7Vm@yuki>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2023 09:05:23 +0100
Organization: Linux Private Site
In-reply-to: <ZSaZLSL4J_rNl7Vm@yuki>
Message-ID: <877cnsz2nn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] runtest/syscalls: Add missing entry for splice06
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

Pushed, thanks!

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Fixes: 895edeed2ebe ("splice06.c: Add splice check on proc files")
>> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> ---
>>  runtest/syscalls | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 149c93820..53e519639 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1513,6 +1513,7 @@ splice02 splice02
>>  splice03 splice03
>>  splice04 splice04
>>  splice05 splice05
>> +splice06 splice06
>
> And it needs .gitignore as well.
>
> Ritchie can you please add that to the patch and push it?
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
