Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABACC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 11:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F4053C8C01
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 12:42:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFB613C5601
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 12:42:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 031341A00CA7
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 12:42:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 05337210F7
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647949358;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2zPFTTs0aHpiBe8H3DJdESdoF6+1BMMsO3HjOvUrHvU=;
 b=dyKbVC/IV4lSBVV1AVN26MRyMuiit75MUj8uuiLGHtWA8WkL96moquePdFcn0HlsZxjeX3
 dfH9hAxP60BtsScXcSo4g5y4Bj/FH7xLKdodzPUZuPLJVgAW0qXlWb2RBHWvtXvStUethq
 p5RbaKWdVVOzXpepapRCYvTeMZdnbWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647949358;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2zPFTTs0aHpiBe8H3DJdESdoF6+1BMMsO3HjOvUrHvU=;
 b=/A4eQK+4hIwLn/+YoZEdRJYqx5n53itTh4E9UrLQalCdzNPXn75PWO+GrKfBrbFgoHzjv4
 6NVqQ9WJUK/i0QDA==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B7C68A3B89;
 Tue, 22 Mar 2022 11:42:37 +0000 (UTC)
References: <20220311095101.10112-1-chrubis@suse.cz>
 <8378e9dd-31a5-b39e-36cc-f3d3a1d41345@suse.cz> <YisfIWsrgxVt8xc2@yuki>
 <875yo6cr1f.fsf@suse.de> <YjmYJ5yukrrgCNYW@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2022 11:41:27 +0000
In-reply-to: <YjmYJ5yukrrgCNYW@yuki>
Message-ID: <871qyucixk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty/pty07: Restore active console after the
 testrun
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


Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > Ah, right, looking closely at the fzsync, the thread B may be racing
>> > against the restoration in the case that something caused premature exit
>> > in the thread A.
>> >
>> > Will move the call back to the start of the cleanup().
>> >
>> > -- 
>> > Cyril Hrubis
>> > chrubis@suse.cz
>> 
>> Why are we using /dev/tty8 instead of allocating a pty with /dev/ptmx?
>
> I do not think that we can VT_ACTIVATE on pseudoterminals, as far as I
> can tell we have to have real console for that.

OK, this looks good then.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
