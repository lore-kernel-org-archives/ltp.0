Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC41C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 09:44:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2DE33C9AEC
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 10:44:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15ECC3C074D
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:44:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 84592600691
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:44:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B64EF1F37E;
 Mon,  7 Feb 2022 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644227069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1W7OzTNzWrNEQo3zvFXEUOB6ADZqt9AETzbUldKvaI=;
 b=Pe5HDDgZEZFCbF/H89Y4azPxAPpIp53d0e8n4qIQWRnnPBgL1GHw3yZ87n2luv0+EXvZhg
 x9KSca256nFN1PY7YnNKUdWDyMAi9j+kr14JiuWtYojHrfc6oFZKz4GP7SsfMKUkoUJccT
 /8kzEwM21yZuY1/ySd6IaBmQasNOjBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644227069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1W7OzTNzWrNEQo3zvFXEUOB6ADZqt9AETzbUldKvaI=;
 b=9Ps9RnRqstChnVJa6CBBEeydqT4pE1o+xqt1gnrhGHceHv/PrLAC/SWmlxYiUSTqAYutGp
 IdxZIT3jpkkcXfCw==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7A353A3B83;
 Mon,  7 Feb 2022 09:44:29 +0000 (UTC)
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-6-rpalethorpe@suse.com>
 <CAEemH2f6PYXGEDrARM7JKCr08K-GEfRa9xJKPLChSG6bnvVpoA@mail.gmail.com>
 <Yfz5lF4SR0s7bv/N@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Feb 2022 08:44:33 +0000
In-reply-to: <Yfz5lF4SR0s7bv/N@yuki>
Message-ID: <87y22nvwn7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] API/cgroup: Make tst_cgroup_group_mk
 sprintf like
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

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Seems this is too strict for some compiling.  e.g.
>> 
>> cfs_bandwidth01.c: In function ???mk_cpu_cgroup???:
>> cfs_bandwidth01.c:64:9: error: format not a string literal and no format
>> arguments [-Werror=format-security]
>>    64 |         *cg = tst_cgroup_group_mk(cg_parent, cg_child_name);
>>       |         ^
>> cc1: some warnings being treated as errors
>> make: *** [../../../../include/mk/rules.mk:37: cfs_bandwidth01] Error 1
>> 
>> gcc version 11.2.1 20211203 (Red Hat 11.2.1-7) (GCC)

Sorry I should have done a full rebuild.

>
> Ah, right, that's the __attribute__ format printf. I guess that we would
> have to live with changing all the calls to
> tst_cgroup_group_mk(foo, "%s", child_name)

Actually it's just calls where the compiler can't tell if child_name is
a string literal. Looking at vsnprintf in stdio.h it seems like we
should be able to add `__attribute__((format(printf,3,0)))` to
mk_cpu_cgroup and then cg_child_name should be guaranteed to be a string
literal. Alas it doesn't work, niether does the format_arg attribute in
this case.

I guess if I made a va arg version of tst_cgroup_group_mk then it would
work, but this is starting to get silly. So I'll just do "%s".

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
