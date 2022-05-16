Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506BBC433EF
	for <ltp@archiver.kernel.org>; Mon, 16 May 2022 07:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76CE63CA483
	for <ltp@archiver.kernel.org>; Mon, 16 May 2022 09:55:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 405733C4ED0
 for <ltp@lists.linux.it>; Mon, 16 May 2022 09:55:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF15A20021B
 for <ltp@lists.linux.it>; Mon, 16 May 2022 09:55:36 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 454E121BEA;
 Mon, 16 May 2022 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652687735;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sb52be8UVBRCeIGbCPL9OgsIDrJF0OvGToDQsREGO3I=;
 b=QPZs8CaYD2G9B55Qq4zC8jORyD2EN6yCIHkhqaAmA0VeyO4Sq5Jrm884rKjcHKM+1q5rVU
 ZWO+2599cSJiRYMN+gCDop7ySfIWdeUfCGeWlfgYEG5fOxp8wk5sEkl8zxwJF3T9u65NGs
 H9HNA8ialEK/3VbGQmWG2Omc0jzKVTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652687735;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sb52be8UVBRCeIGbCPL9OgsIDrJF0OvGToDQsREGO3I=;
 b=HjcNfYqjjqZ1Ejj+mJMTX2yZ5cFHJF/v/ekGiBSujX1f0XhsAx4YI0kWRnkxbcPSuxyX4l
 +drzSXJOghCrzeCg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D1D6A2C141;
 Mon, 16 May 2022 07:55:34 +0000 (UTC)
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 May 2022 08:52:26 +0100
In-reply-to: <Yn5prUjpZEUjoxbL@yuki>
Message-ID: <875ym5di8f.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > > I hit a new problem while testing new pty03, that seems here
>> > > will fall into an infinite loop and test timed out finally. The printf
>> > > shows rem_p will be overflow I haven't figured out why.
>> > >
>> > > But with comparing with 0.9, it always gets passed on to the same system.
>> >
>> > That is strange, since we do:
>> >
>> >         rem_p = 1 - tst_remaining_runtime()/pair->time_exec_start;
>> >
>> 
>> I guess the root cause is that 'pair->time_exec_start' has a possibility
>> to reach zero. in pty03 it has ".tcnt = 9" which made the
>> tst_fzsync_pair_reset()
>> to be re-run many times, but in that function 'pair->time_exec_start' will
>> be set only based on the original .max_runtime, with time elapsed the
>> remaining time tends to be zero.
>
> I guess that that the interaction of tcnt and runtime is not optimal
> here. You are right that as long as we call tst_fzsync_pair_reset() on
> each invocation of the run() function we may eventually get to state
> where the runtime is exhausted, especially on slower hardware we end up
> with division by zero and overflow.
>
> The cleanest solution would be to rewrite the test to use .test_variants = 9
> and setting the .max_runtime to a smaller value. That way we would have
> precisely defined runtime for each iteration. What do you think?

Or each test case (defined by tcnt) could be given an equal share of the
runtime?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
