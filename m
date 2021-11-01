Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DC4C433EF
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 12:35:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D00A60F36
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 12:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D00A60F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5CEE3C70E0
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 13:35:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FCD53C7008
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 13:35:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E9F3601385
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 13:35:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AACA921974
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 12:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635770140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHF11xTEBM7t660+G5vpjlG5I8S0bisSEifRqVohhz8=;
 b=l5RZKYOr9+4lXgwzxACMFXXoZv084OuXfxrXrQickfrmg+t2UAA7qyxh0f3MYzFjeJxvIu
 jGTYxBLJM/SabhF8hGvWrJyBpYgb1yT52cL8t1+Y3zY0opceZRZ9R5qGi9PAsMvQ9Y5aoO
 IqyNUGR5ltlSA8a2K8LGrdKGiIezflA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635770140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHF11xTEBM7t660+G5vpjlG5I8S0bisSEifRqVohhz8=;
 b=9gs2lz4+bgRHinscukZU5Vr/1mmEVYkzu3wJLz4GuSjGjcmnomiZgM46sV4PdgJkGpjcTM
 6Jnf4X/G2M8xBhCA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 77683A3B81;
 Mon,  1 Nov 2021 12:35:40 +0000 (UTC)
References: <20211018154800.11013-1-chrubis@suse.cz>
 <87tuh2poue.fsf@suse.de> <YXlYwi7+VUIitM7H@yuki> <87pmrppj9u.fsf@suse.de>
 <YXu2q1Uj4xIJvO7G@yuki> <87h7cwp5x6.fsf@suse.de> <YX+6iWEzwaTqbYua@yuki>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 01 Nov 2021 12:20:44 +0000
In-reply-to: <YX+6iWEzwaTqbYua@yuki>
Message-ID: <87cznkoxyc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > Still working on a prototype based on tree-sitter would take a week or
>> > two worth of time and I would like to get the metadata fixed now, so
>> > that I can finally move on with runltp-ng. So I would slightly prefer
>> > merging the patches for the current solution first, then we can have a
>> > look on tree-sitter in the next LTP release cycle. What do you think?
>> 
>> I think there is a small risk
>> 
>> 1. It turns out that with tree-sitter it would make more sense to use a
>>    different meta-data format.
>
> What do you have in mind? I do not think that we should dramatically
> chante the json structure we do have now.

Whatever tree-sitter produces most naturally and requires the least
amount of massaging.

>
>> 2. Someone starts building on the current solution without realising it
>>    might change
>>
>> Of course this can be mitigated by saying that the implementation and
>> format are subject to change.
>
> My approach here is to build the runltp-ng as a set of reusable
> libraries, one of them would be a parser for the metadata that would
> provide interfaces for the common queries. That makes the metadata an
> intermediate format that could evolve over time. On the other hand I do
> not expect big changes in the metadata format.
>
>> Note that in general I think it's best (on bigger projects) to have an
>> alternative branch for big changes where one needs to "rush" to an
>> end-to-end solution. Most likely we need an alternate branch for
>> integrating runltp-ng and the executor.
>
> We can even do this in a separate github repository or whatever works,
> but still we have to agree on general direction.
>
> I still think that the best solution here is to apply this patchset and
> put the tree-sitter on TODO. Unlike tree-sitter this is neither big nor
> radical change and it would allow us to proceed with other stuff that
> has been blocked for several releases at least.

As discussed in IRC, I prefer the route of trying either Sparse or
Tree-sitter first to produce the metadata. However please go ahead and
make the decision. After all once we have better automation it will
reduce the burden on reviewers.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
