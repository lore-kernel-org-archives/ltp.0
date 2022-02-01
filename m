Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E0DC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 16:20:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84E153C989B
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 17:20:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6003D3C9826
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 17:20:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C47B110005CD
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 17:20:29 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 114C61F37E
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643732429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPytwFzmGDv11fIqWBZdMjvQU+C5SJzQ4L41mIZdpts=;
 b=wUxpQajwtPl2yLRtd3Z7NKrBbfaMKZ/5GAqs/92054kDu1ltChqvfsRyomKV387nnoYj2j
 uRq514sH6AsT1T4kQ4FMzKMGuSoKDTbhDiKqJrZv9CG7WP3L0Ud5r4ENEeHaGotCcY565d
 +pIsD0yQkIE6q1IkavZ8FMM/dBpGJ0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643732429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPytwFzmGDv11fIqWBZdMjvQU+C5SJzQ4L41mIZdpts=;
 b=c/DABvq/sdHlfxp7Nvppe4Xz6uJxp3sjBZaN5FXfo0+e2THhaX9lb6Y+Og7UIUI90yTJBb
 z2X3UxONIvFI1TBA==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CB499A3B84;
 Tue,  1 Feb 2022 16:20:28 +0000 (UTC)
References: <20220126164703.7177-1-pvorel@suse.cz> <YfkgZ8Ab6Jl8udbv@yuki>
 <YflRs6o15kRQ7aiI@pevik>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 01 Feb 2022 16:06:07 +0000
In-reply-to: <YflRs6o15kRQ7aiI@pevik>
Message-ID: <877daey2wp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Fix tst_mkfs_ doc
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

> Hi Cyril,
>
>> >   * @fs_opts: NULL or NULL terminated array of mkfs options
>> > - * @extra_opt: extra mkfs option which is passed after the device name
>> > + * @extra_opts: NULL or NULL terminated array of extra mkfs options which is
>>                                                                              ^
>> 									     are
> I wasn't sure about the grammar, I thought the NULL *is* passed or
> the NULL terminated array *is* passed. But not really sure.
>
> Kind regards,
> Petr

*are* sounds more natural to me. Probably due to the order of specifying
the array (singular) then its contents (plural). If you wrote something
like "The extra mkfs options NULL terminated array is ...", then it
would be more natural to use *is*.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
