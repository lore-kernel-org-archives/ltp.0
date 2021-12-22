Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CAEC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:36:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA9DC3C9267
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 10:36:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D2D03C0B90
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:36:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEF91600BFA
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 10:36:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 10AD11F37E;
 Wed, 22 Dec 2021 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640165774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrSP90quGi+aM3eJmxr9GhdOEOiG4p/AfdD2bh0lN6k=;
 b=E79EUEqNxnM5jPbmtDTHhkJGVTG11sbpCcioJ8PmV6sMzBDQh7v6Bx2E1Py9/HF/3Z6O0q
 FM63PUxdWoMrxGaGsRY+m0Xdb2sAy0DpMD47cglzkV6UGtEC1mYvVJptFdyUmhHDoYbPjJ
 ULLZzZ23smWPNGeuR+x8tWFhvq+Hfjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640165774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrSP90quGi+aM3eJmxr9GhdOEOiG4p/AfdD2bh0lN6k=;
 b=l7Cxg+lXD3regUnovpmeUeCaZ0WNtHqcMNkiOXzs5htLBqMVLs4IekLIG3VRCTjZu3d72j
 x1HriQCz1qFvUBCw==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BC625A3B81;
 Wed, 22 Dec 2021 09:36:13 +0000 (UTC)
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com> <YcIVPdcjt8javBGv@pevik>
 <CAASaF6zQK=w5+QzUGM8wfOLJNUHFKPJP5dE_XnQUaya5if3VMQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Dec 2021 08:44:43 +0000
In-reply-to: <CAASaF6zQK=w5+QzUGM8wfOLJNUHFKPJP5dE_XnQUaya5if3VMQ@mail.gmail.com>
Message-ID: <87wnjxdlrm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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

Jan Stancek <jstancek@redhat.com> writes:

> On Tue, Dec 21, 2021 at 6:56 PM Petr Vorel <pvorel@suse.cz> wrote:
>>
>> i all,
>>
>> [ Cc automated-testing and people who might be interested ]
>>
>> > Add an unstable kernel ABI flag and a runtest file for unstable
>> > tests. This means we can add tests which are likely to be broken by
>> > changes in the kernel ABI. Without disrupting LTP releases which are
>> > required to be stable.
>>
>> > Users who require stability can filter the tests with this flag
>> > or not schedule the unstable runtest file(s).
>>
>> I'm ok for this from a long term perspective, because agree Richie it can help
>> people to run tests on kernel from next tree or mainline rc kernel).
>>
>> It's not much work to maintain this.
>>
>> It'd also help people writing tests for  fanotify and IMA not having wait
>> several weeks.
>>
>> Yes, we could add it to fanotify22 [1], but not to ima_conditionals.sh [2],
>> which is shell. But adding support to shell is trivial.
>>
>> Acked-by: Petr Vorel <petr.vorel@gmail.com>
>>
>> ....
>> > +++ b/runtest/syscalls-unstable
>> How about having name syscalls-next? Although there can be tests which are from
>> some kernel maintainer tree (it does not have to be limited to next tree),
>> unstable can mean "tests which aren't fixed yet and thus buggy".
>
> staging?

Staging and unstable could equally mean the test itself is not fininshed
IMO. I didn't suggest next for exactly the reason mentioned, but it
might be the better choice.

>
> IMO separate runtest would be enough, any notes why and how test was developed
> could be in comments in code, where people can find it (less metadata
> to maintain),
> and those comments could stay there after feature is accepted to
> mainline, we just
> move test between runtest files.

Then the test has a useless or misleading comment saying it was
developed against a feature still in development. It's trivial to remove
such comments or meta-data. I expect test authors will do it themselves
and if they don't we can rethink accepting such tests.

Also the patch uses the meta-data to print a hint. That way we do not
need to look at the source code, runtest file and LTP version before
deciding on the severity of a problem. Doing extra work upstream saves a
lot of work downstream.

Finally note that the plan is to schedule tests without runtest files
for parallel execution. That requires meta-data.

>
>> > @@ -0,0 +1,3 @@
>> > +# Tests for kernel features which are not finalized
>> > +
>> > +fanotify22 fanotify22
>>
>> Kind regards,
>> Petr
>>
>> [1] https://patchwork.ozlabs.org/project/ltp/list/?series=272782
>> [2] https://patchwork.ozlabs.org/project/ltp/list/?series=265664
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
