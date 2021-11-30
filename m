Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEB2C433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 09:44:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B93703C4E59
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:44:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97DA03C2353
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:44:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AE99F20021B
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:44:10 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 80DD12177B
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638265449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEadDSZSh9fwW45TesMAkwaxp8wzWNTkR+Vmuf4ADxY=;
 b=MCGKMjIlZB8zunLcH+Z+/3KSHiBGQOzNiCNr6jmXxzjnMtnOBWS7GkC4hp1bD9Fdv/iy+t
 lNuvZDeODvmy2gty4X3VOS4LQqEhwAUYcwcfEYdKkYPT53LPHk8M4mu1FrbxotnXjvQqNo
 z3Yy3Q8DjzjH3+IH6ex5nAYiyolC4e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638265449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEadDSZSh9fwW45TesMAkwaxp8wzWNTkR+Vmuf4ADxY=;
 b=pfiPJkJ593kSrUY3Xivir+OTSRcHnn+3zAbCGJ31j0quuxzEGvvOAp3RZ8Vy/x/kPeFvPT
 mrkLQoZc26//DZAA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3FF9CA3B83;
 Tue, 30 Nov 2021 09:44:09 +0000 (UTC)
References: <YaS0F9/ZyPtZi5zE@pevik> <YaS/dbbn3cRobeIp@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Nov 2021 09:29:49 +0000
In-reply-to: <YaS/dbbn3cRobeIp@yuki>
Message-ID: <87r1aykmfr.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Using shellcheck for shell make check
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
>> checkbashisms does not detect all things: e.g. not catching {1..$FILE_COUNT}
>> [1]. Maybe we should reconsider using *also* shellcheck as Joerg suggested
>> (keep checkbashisms).
>> 
>> I don't like shellcheck output, but it can detects errors checkbashisms cannot
>> detect (checkbashisms is regexp based, but shellcheck IMHO evaluates the code).
>> Also it's configurable, thus ve could disable check we don't like or enable only
>> what we want to check. Or we can run just --severity=warning or
>> --severity=error. If you're not against it, I can have look into this.
>
> Sounds good, the more automated checks we have the less we will spend on
> review...

We can't vendor in a Haskell program, so it will have to be an optional
check. Still it looks nice.

Tree-sitter also supports "Bash", which might be useful for LTP specific
checks. That ofcourse is much higher hanging fruit.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
