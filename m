Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0E7C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:04:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C31EC3C4F96
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 14:04:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DBD53C092D
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:04:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F001D1A004ED
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:04:37 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 171541FDFE;
 Tue,  7 Dec 2021 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638882277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKErRPi/9bzM2kYzbm0zchXx8IMMlywU56YrvGURigQ=;
 b=asvYvluYmV7GCkw8Xo5Il1Xd4Rb8rOT8lqEkjU4dQ1M04iOn64pub7rAGZE9M2bwwWKxeU
 euJWo1cvZ8kdrA1thFjp66xPJwcVudo6oftRxkJrzPOKBcdJ8P9Dt1c+eKmDanfUl7E1LA
 /LMNu2Z8KwRJGMA5AzuuqURqyvMII/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638882277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKErRPi/9bzM2kYzbm0zchXx8IMMlywU56YrvGURigQ=;
 b=3qiQYloTIQV8offsJbbixen6BYN2UG728StiaQW9zzThwot6dro1mw94PhzmxZW6Z7J1sC
 gW6PDR2BZXPAHqDQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B9F81A3B81;
 Tue,  7 Dec 2021 13:04:36 +0000 (UTC)
References: <20211202203006.32259-1-pvorel@suse.cz>
 <CAASaF6we7wki=+4Rt_8NGg848735VdAUeaMSGNUMBcL-cOX5pg@mail.gmail.com>
 <Ya3lc9jWR5UZXB3T@pevik>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 07 Dec 2021 13:01:27 +0000
In-reply-to: <Ya3lc9jWR5UZXB3T@pevik>
Message-ID: <87wnkgbm70.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] configure.ac: Print summary
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

> Hi Jan,
>
>> On Thu, Dec 2, 2021 at 9:30 PM Petr Vorel <pvorel@suse.cz> wrote:
>
>> > Due many checks of structs, members etc are chosen testsuites,
>> > presence of used libraries and docparser config results quite hidden.
>> > Print them as summary in the end.
>
>> Color output would be nice too. But I find this output useful in plain
>> text as well:
>> Acked-by: Jan Stancek <jstancek@redhat.com>
>
> Thanks! I can have look on colors later on, but I'd prefer to do it as a
> separate approach.
>
> Kind regards,
> Petr

I wonder if colours can be added to all output with some autotools toggle?

Anyway, pushed!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
