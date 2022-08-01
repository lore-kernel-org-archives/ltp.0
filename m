Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F91C19F2C
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 07:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 708243C920D
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 09:41:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 259143C8CCF
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 09:41:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 842841A004B1
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 09:41:26 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D47224D521;
 Mon,  1 Aug 2022 07:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659339683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLCyw8+AInqfXpD2GZ+buZOnzHUQ6XZx9fI5SBI0SNA=;
 b=X9InGUw7ZT6RXvtyOEzW9D2sZegIbQAfeOiTkoPnICYJleAO0qn3g6Nqke5FDamW52LEfe
 XA6jgQJwFfO5qm2pg9J5RMlvzarZFUBKoRwftgV9By2sJIhXJ7cIUazmbNaJCleLJmtX6r
 Pfg5Zxm5bfjZiGa/bJeyW1hHpwzO7VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659339683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLCyw8+AInqfXpD2GZ+buZOnzHUQ6XZx9fI5SBI0SNA=;
 b=jsEO145x97Ws3kJZkPxSgyO+du7nRTJ1583nWzobrJlYFS3unL4QYMeIx9Voom5EeN76mw
 yKIjL4loYrl7TVDw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 714532C141;
 Mon,  1 Aug 2022 07:41:23 +0000 (UTC)
References: <20220727053307.3009235-1-lkml@jv-coder.de>
 <20220727053307.3009235-4-lkml@jv-coder.de> <YuQXnCgSjBT1mGFH@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 01 Aug 2022 08:16:10 +0100
In-reply-to: <YuQXnCgSjBT1mGFH@pevik>
Message-ID: <87pmhkfm1p.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] configure: Integrate open posix testsuite
 configure
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>,
 automated-testing@lists.yoctoproject.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Joerg,
>
> [ Cc automated-testing@lists.yoctoproject.org ]
>
>> From: Joerg Vehlow <joerg.vehlow@aox.de>
>
>> This changes the default installation location
>> of the open posix testsuite from
>> $prefix
>> to
>> $prefix/testcases/open_posix_testsuite
> I need to have a deeper look on this patchset next week.
> But it looks to me strange, that running LTP top level configure causes
> installation into /opt/ltp/testcases/open_posix_testsuite/, but after running
> ./configure in testcases/open_posix_testsuite make install goes by default to
> /opt/openposix_testsuite.
>
> Also openposix does not use LTP API, when we're touching it, wouldn't it make
> more sense to put it into separate git repository? IMHO that would cause work
> for other people (clone separate git, need to fix CI and tools which are using
> it), but openposix embedded in LTP always looked strange to me.

I wouldn't be against this based on my anecdotal experience.

I don't recall a specific time these tests found a kernel bug. They
sometimes find issues with glibc, but there is usually a debate as to
how to interpret the spec instead of a clear error on glibc's part. Most
often the test is broken.

So I'd say these tests are almost useless for kernel testing. I also
think they often misinterpret the POSIX spec or have some basic logic
error.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
