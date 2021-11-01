Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53BC433FE
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 09:43:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2446260FC4
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 09:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2446260FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A9373C70BF
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 10:43:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB1AA3C68BB
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 10:43:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1FADE1001446
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 10:43:40 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2252C2191A
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 09:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635759820;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czKFBTG/g4KKhzSqt/VbcmfmhfRJpPj2XE8CP88DxLQ=;
 b=qDLmBRwAZ60ZPzVnexCtzlZcHqpCi4xeTT4TtW8FKFambhQoTE4OhmH+cSGdYMJ6z3H2+s
 eNhJfvqDPKLLpLt7zzd+MgTC5Y48BC76gbeRFZZbKuWwVWWcqSR6hxC77BolXApI47shPy
 1EMevhmLk7qkdlWRn9PFlK0Nh0d/yNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635759820;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czKFBTG/g4KKhzSqt/VbcmfmhfRJpPj2XE8CP88DxLQ=;
 b=eYe5giCw3L2llm6AYqM9vYSSkDaZFST8iI2HpMvlGhE7N3vWYabw2K8kAEetbEbNU6l90N
 Rb/0j/ACLzXUckBg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E4BBCA3B91;
 Mon,  1 Nov 2021 09:43:39 +0000 (UTC)
References: <20211018154800.11013-1-chrubis@suse.cz>
 <87tuh2poue.fsf@suse.de> <YXlYwi7+VUIitM7H@yuki> <87pmrppj9u.fsf@suse.de>
 <YXu2q1Uj4xIJvO7G@yuki>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 01 Nov 2021 09:04:43 +0000
In-reply-to: <YXu2q1Uj4xIJvO7G@yuki>
Message-ID: <87h7cwp5x6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/7] docparse improvements
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

Hello Cryil,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> It's incredibly fast, it has no trouble parsing the entire kernel.
>> 
>> Weggli uses tree-sitter
>> 
>> https://github.com/googleprojectzero/weggli
>> ________________________________________________________
>> Executed in   49.35 millis    fish           external
>>    usr time  110.88 millis    0.00 millis  110.88 millis
>>    sys time   87.44 millis    1.20 millis   86.24 millis
>
> This looks like it's about the speed of grep, that sounds incredible.
>
>> > Well I would say that this patchset is the last addition for the parser,
>> > if we ever need anything more complex we should really switch to
>> > something else. On the other hand I do not think that we will ever need
>> > more complexity in the parser than this, as long as we keep things
>> > sane.
>> 
>> This closes the door on a lot of options for no upside AFAICT. We have
>> two tools (Sparse and tree-sitter) that can be (or have been) vendored
>> and will parse a large subset of C. Sparse goes a step further allowing
>> control flow analysis. The usual reasons for reinventing the wheel are
>> not present.
>
> Still working on a prototype based on tree-sitter would take a week or
> two worth of time and I would like to get the metadata fixed now, so
> that I can finally move on with runltp-ng. So I would slightly prefer
> merging the patches for the current solution first, then we can have a
> look on tree-sitter in the next LTP release cycle. What do you think?

I think there is a small risk

1. It turns out that with tree-sitter it would make more sense to use a
   different meta-data format.
2. Someone starts building on the current solution without realising it
   might change

Of course this can be mitigated by saying that the implementation and
format are subject to change.

Note that in general I think it's best (on bigger projects) to have an
alternative branch for big changes where one needs to "rush" to an
end-to-end solution. Most likely we need an alternate branch for
integrating runltp-ng and the executor.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
