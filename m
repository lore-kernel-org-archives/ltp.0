Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43843C433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 14:23:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986CB61C32
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 14:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 986CB61C32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 977213C885B
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 15:23:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C45273C292B
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 15:23:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 306E8601CE8
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 15:23:04 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 51E6A2171F;
 Wed, 17 Nov 2021 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637158984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qh7B1uzEXosmOzOyvf2MskNv0uzDtnNl3uZ2ZS7syoY=;
 b=X+dM9IajtxzE1BKunqk4WVpdBZvdVJBtPomBuW7dDUOCXfb9wQyy0ti3DEhw46KxqG86Ud
 m229lepY3U5dfwez5S8npAozqQSC5t44mcGFNAw8TpksFGrg3IxoW3k6OjlTWr9rD1Mp4m
 xZwHwUKaAN8g/Afe/3bIey+yTIPeAOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637158984;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qh7B1uzEXosmOzOyvf2MskNv0uzDtnNl3uZ2ZS7syoY=;
 b=oL3vQkfb4ORNwmzbY8Eohj9vaRPC57GiGnYk5eeGiXOA6PQvmJ6IrM1QnGpRZsoevclBJn
 WYSLbdXocLFrr9Dg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 23929A3B8B;
 Wed, 17 Nov 2021 14:23:04 +0000 (UTC)
References: <20211117070708.2174932-1-liwang@redhat.com>
 <87zgq39j2b.fsf@suse.de>
 <CAEemH2cYn6XmsL+5m20aiadUrqWDwoE_+KQ5pm5rT5p34-Omug@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Wed, 17 Nov 2021 14:01:48 +0000
In-reply-to: <CAEemH2cYn6XmsL+5m20aiadUrqWDwoE_+KQ5pm5rT5p34-Omug@mail.gmail.com>
Message-ID: <87mtm2amkd.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>  
>  > +const struct tst_arch tst_arch = {
>  > +#if defined(__x86_64__)
>  > +        .name = "x86_64",
>
>  Writing out these string constants multiple times is error
>  prone. Perhaps arch_type_list can be indexed with enum tst_arch_type and
>  then name can be ".name = arch_type_list[TST_X86]"?
>
> Right, that will more flexible but you know, all arches we have are just
> those, and we write them only once in the LTP test library.
>
> I slightly wanted to keep string constants to make it more
> simple/readable.

It's a minor thing, but IMO the extra complication is worth it to
eliminate typos.

Although the preprocessor could still hide errors on some arch until
someone tries to compile it.

>  
>  > +static const char *const arch_type_list[] = {
>  > +     "i386",
>  > +     "i586",
>  > +     "i686",
>
>  These are not valid arch names AFAICT. There is no mapping from these to
>  x86 in the tst_arch table above.
>
>  Perhaps we could replace them all with x86?
>
> Yes, that is also the unsure part I was concerned about in patch v4. 
> Because x86 is also an invalid arch (it is just a conventional name),
> if we use it in the arch_type_list we have to recognize it as a valid arch
> name in test case as well. I'm not sure that will be accepted by other
> people.

The folder in the kernel tree is arch/x86.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
