Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C34CC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 09:24:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B7633CB183
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 11:23:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C8AB3C9179
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:23:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57584600207
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:23:47 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CD7D21F37C;
 Thu, 20 Oct 2022 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666257826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV8/KXXehl0iOgiV8FcTI7+riT5KhhKoh6/Oa/ZcjDs=;
 b=NwhPzrzFLXDT5w/1C62RFUxSOglnnza8qEqhA6VkiTkgKagGdN8pcwGNBbXOuLj/aE26Hg
 h/IxACB771H+WU3nXIHn8ODm/OhDzvdxMwyyvtr64Fm4SsHdQ3zll9+SR3VZNfr9us4lVU
 K7VMJNhiWlzKpeWnlZ8xQ9y4d4nde7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666257826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV8/KXXehl0iOgiV8FcTI7+riT5KhhKoh6/Oa/ZcjDs=;
 b=MoI5FQvCN9c1BFhGf83XnLDvadIRH9Cvc5xs9/t4CxpA0EVh25/VP2qk3zmqm75VB/LqZI
 KC+3E5GkBha9UqAg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5C2BA2C25E;
 Thu, 20 Oct 2022 09:23:46 +0000 (UTC)
References: <1663208146-5239-1-git-send-email-liaohj.jy@fujitsu.com>
 <87czaqob6v.fsf@suse.de> <Y0+tAYbSdXod1tfY@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 10:23:07 +0100
In-reply-to: <Y0+tAYbSdXod1tfY@pevik>
Message-ID: <87o7u6vof3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork02: Remove it
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

> Hi Liao, Richie,
>
>> > ---
>> >  testcases/kernel/syscalls/fork/fork02.c | 99 -------------------------
>> >  1 file changed, 99 deletions(-)
>> >  delete mode 100644 testcases/kernel/syscalls/fork/fork02.c
>
> fork02 entry was left in runtest/syscalls and
> testcases/kernel/syscalls/fork/.gitignore.
>
> Not a big deal, I fixed it in 747cd665d. FYI you can use this checklist
> (not just reviewers, but also patch authors):
> https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist

Sorry, my mistake, thanks for fixing it.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
