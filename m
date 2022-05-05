Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3917C433EF
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:08:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E07D3CA8C4
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 12:08:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6861F3CA836
 for <ltp@lists.linux.it>; Thu,  5 May 2022 12:08:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A773714004E6
 for <ltp@lists.linux.it>; Thu,  5 May 2022 12:08:01 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F404921979;
 Thu,  5 May 2022 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651745281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERrhj2pdCegp2WxVojvOcjrN9a/YypmntP9Ujtv6DhQ=;
 b=VAIef0yPQUl/PgSWcBtgVsNsDGvlxOHdIlPt9xnukLkWy1lkaXvY7LKkWx+dv7cO75K7rA
 /3NvEGOMjhqpAeq8v3SUFcsgpcmtFNlJt2a6aZQwOPyDMS98kb+i60gCRGl27C5Orl04ld
 ThtTxMBih/aLfhjyIaG0e7L5lfCOlV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651745281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERrhj2pdCegp2WxVojvOcjrN9a/YypmntP9Ujtv6DhQ=;
 b=QZ7YXf6sAaMYZghBS/AUwWOrROKcErNLdBuVBj6q0NopsanFLxEm5s+CuBAWa32QyCFKRS
 7dORxzofFGA0E5DQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B00DE2C141;
 Thu,  5 May 2022 10:08:00 +0000 (UTC)
References: <20220503174718.21205-1-chrubis@suse.cz>
 <875ymke631.fsf@suse.de> <YnOPBSPQ6UMYtC5g@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 05 May 2022 10:53:24 +0100
In-reply-to: <YnOPBSPQ6UMYtC5g@pevik>
Message-ID: <87k0b0cmx1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 00/30] Introduce runtime
 and conver tests
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi all,
>
>> > TODO:
>
>> > This patchset is reasonably complete in a sense that it removes the
>> > timeout API at the end. Still there are a few things to consider:
>
>> > - is reusing the -I parameter a good idea? Wouldn't adding new parameter
>> >   (-r) be better?
>
> But -r is using only when .max_iteration_runtime set, right?
> How should it behave on tests which don't set it?
> Should -I and -r be mutually exclusive?
> Maybe reusing -I would be simpler for users.
>
>> Perhaps we could deprecate -I, but convert it to use the new mechanism
>> while trying to keep the behaviour similar.
>
>> I'm not sure we need a global -r option, but unlike -i it's not much
>> effort to support. It would not surprise me if there are existing tests
>> which don't work with -i.
>                         ^^ Do you mean -I ?

Nope, I mean -i, my point is that global parameters add another failure
mode and -i is the best example of this. However -r has less
implications than -i.

>
> Kind regards,
> Petr
>
>> > - there are quite likely tests that run for more than a second or a two
>> >   and should be made runtime aware
>
>> > - anything else?


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
