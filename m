Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B77C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 09:32:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 002163C8977
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 10:32:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A27F3C1B7F
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:32:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A997F6008E9
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 10:32:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DED531F37C;
 Tue, 22 Mar 2022 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647941534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vP5sQZDpXJCW+xEnjnGH3JOdD+jzj3p++mqgFclSUKc=;
 b=a1d5fNKv5bipbuIOkd2WFJiVEeKA6iBRdzj0uAWjAv1IIe7fxoAwj1HBnu1xXujyp0ZSTj
 Bsj2xq6qQpifFqzYc1UvxU1sVeLwtXlocnPCtjA8mSPzC9jEQL0nejFaM9b8oJltwgKxpo
 BrMivZXtlhCnZ3DxWxnCMM55rMjG85w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647941534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vP5sQZDpXJCW+xEnjnGH3JOdD+jzj3p++mqgFclSUKc=;
 b=xZ2UWQiI8y627RYWWR/CgfVJjZZnhqWTWgqAHEgyCtdbkoki5BiGlDkq6ET7UQKr9pUxbS
 h00L0Zuj/PRXFdCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC59412FC5;
 Tue, 22 Mar 2022 09:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wqKeMJ6XOWIpDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Mar 2022 09:32:14 +0000
Date: Tue, 22 Mar 2022 10:34:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YjmYJ5yukrrgCNYW@yuki>
References: <20220311095101.10112-1-chrubis@suse.cz>
 <8378e9dd-31a5-b39e-36cc-f3d3a1d41345@suse.cz>
 <YisfIWsrgxVt8xc2@yuki> <875yo6cr1f.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875yo6cr1f.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Ah, right, looking closely at the fzsync, the thread B may be racing
> > against the restoration in the case that something caused premature exit
> > in the thread A.
> >
> > Will move the call back to the start of the cleanup().
> >
> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz
> 
> Why are we using /dev/tty8 instead of allocating a pty with /dev/ptmx?

I do not think that we can VT_ACTIVATE on pseudoterminals, as far as I
can tell we have to have real console for that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
