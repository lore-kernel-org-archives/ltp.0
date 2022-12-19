Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E7C4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 14:37:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCDF43CBAF8
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 15:37:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 667E93C7983
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 15:36:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D9A4140052E
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 15:36:52 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8280037E1C
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671460612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDz8rnGm6zJHGaqMDAj+caFFwMsbwJ3+HjMcKn59zXI=;
 b=TlmPp5GuitjExws/njZd2eHFU9KjWuS34fJMNjxHdN2L4JzX3SkB05ghc1j5oYln8m8tI1
 1iDURxDUk0+Wx7CvjqyGWJ+xZSD/vF5V2SRcIUN7SiVD8SW6KC4xePwWm498jLumq1+Nkd
 uvv6Uhp98/1SCimb7vKc4p21mK6iVZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671460612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDz8rnGm6zJHGaqMDAj+caFFwMsbwJ3+HjMcKn59zXI=;
 b=1OGRH7krRq9h/slyfLfXbJG5rFlS5HMevZsIQE2YyMbS1VimQOs6t8KRgvZGqhwlpZ5O7z
 ehhMs2O6leFXVuAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4C5762C141;
 Mon, 19 Dec 2022 14:36:52 +0000 (UTC)
References: <20221216170922.21752-1-mdoucha@suse.cz>
 <98573ca81db1625d7b2f639aabeae1d9@suse.de>
 <53c35db794540b736389a7c18275cd79@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: pvorel <pvorel@suse.de>
Date: Mon, 19 Dec 2022 14:31:27 +0000
Organization: Linux Private Site
In-reply-to: <53c35db794540b736389a7c18275cd79@suse.de>
Message-ID: <87mt7jtq7y.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2022-4378
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

pvorel <pvorel@suse.de> writes:

> On 2022-12-19 11:07, pvorel wrote:
>> Hi Martin,
>> 
>>> diff --git a/testcases/cve/cve-2022-4378.c
>>> b/testcases/cve/cve-2022-4378.c
>>> new file mode 100644
>>> index 000000000..e1c5df325
>>> --- /dev/null
>>> +++ b/testcases/cve/cve-2022-4378.c
>>> @@ -0,0 +1,108 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2022 SUSE LLC <mdoucha@suse.cz>
>>> + */
>>> +
>>> +/*\
>> nit: you used /*\ docparse start comment, but without any [...] mark,
>> thus nothing shows in generated docs.
>> There should have been either normal C comment /* or docparse [...]
>> mark.
>
> I'm sorry, I was wrong, the text *appear* in generated docs, just
> without any header.

Perhaps make-check could validate the docparse string?

> Just the text contains too much details (given we have link to git
> commit in the table below):
>
> ... fixed in:
>
> commit bce9332220bd677d83b19d21502776ad555a0e73 Author: Linus Torvalds
> <torvalds@linux-foundation.org> Date: Mon Dec 5 12:09:06 2022 -0800

I think it is fine to even copy and paste the whole commit message. If
we list the wrong Git commit this may make it easier to see as well.

>
> Kind regards,
> Petr
>
>> Kind regards,
>> Petr
>> 
>>> + * CVE 2022-4378
>>> + *
>>> + * Check that writing several pages worth of whitespace into
>>> /proc/sys files
>>> + * does not cause kernel stack overflow. Kernel bug fixed in:
>>> + *
>>> + * commit bce9332220bd677d83b19d21502776ad555a0e73
>>> + * Author: Linus Torvalds <torvalds@linux-foundation.org>
>>> + * Date:   Mon Dec 5 12:09:06 2022 -0800
>>> + *
>>> + * proc: proc_skip_spaces() shouldn't think it is working on C
>>> strings
>>> + */
>> ...


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
