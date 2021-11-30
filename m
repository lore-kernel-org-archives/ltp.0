Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6580C433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 08:28:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A26C13C75D2
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 09:28:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0BF3C4E29
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 09:27:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 58F4E200DEB
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 09:27:51 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6CA702177B;
 Tue, 30 Nov 2021 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638260870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51vkx4uORYmzt3kI2xFmEkvrdHHB6fmWhGU5uWZesHg=;
 b=Ih7nUkxS2/jtu+5FHlntryE9uPcgYdR+sbKZbk+ZzYTvUy8Mg07H6DLxj8RxENAdWZuVOk
 AdybQX8mEx6voSpZpcgU7hwCsGArQxKXKsSUbjjQqrMNcil/WT9zwXxzMBcleul9bWn6MB
 v7iUsy+zzsEMcgQbIf6K5ischFYN5xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638260870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51vkx4uORYmzt3kI2xFmEkvrdHHB6fmWhGU5uWZesHg=;
 b=Vto3g5k/H4rBntrCuxSr4Sqrs33YMP26x04vW1KsmIYSWPhMJgYSGJRuyX7YQIr+Y6DEqo
 N5xe2SZrAWEj8JBw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 30A7CA3B83;
 Tue, 30 Nov 2021 08:27:50 +0000 (UTC)
References: <20211123124348.31073-1-rpalethorpe@suse.com>
 <20211123124348.31073-2-rpalethorpe@suse.com> <YZ3l+QtJA+/RCp6v@pevik>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Nov 2021 08:24:52 +0000
In-reply-to: <YZ3l+QtJA+/RCp6v@pevik>
Message-ID: <87v90akpyy.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tools/sparse: Add static check
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
Cc: chrubis@suze.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Petr and Cyril,

Thanks! pushed. Please pull and try it out.

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> This was adapted from Sparse's inbuilt check_duplicates (-Wdecl). The
>> original check appears to print a warning whenever a symbol is
>> non-static, but has no prototype. It appears to work because library
>> symbols are usually declared first in a header file and then again
>> with their definition in a source file.
>
>> The LTP version also checks for the various library prefixes, but
>> should otherwise be the same.
> LGTM, thanks!

I took the liberty (;-)) of interpreting this as Acked-by.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
