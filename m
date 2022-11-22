Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD34C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 12:55:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE29A3CCAEF
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 13:55:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 400F33C1B75
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 13:55:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B125C1494387
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 13:55:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68D641F86B;
 Tue, 22 Nov 2022 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669121700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95xguAUSDF94+Sz3vdic3O+mnKYSR5TOcIZPi0jbBtk=;
 b=1sYkyPlinblhXMaYtux/R+eNv1si7vPqp8+B9A7V0DMiUhloKBubwc7ZVHnV9C1SEVVBaw
 e3+H8hveTCNTYcyCEFw8VsAOPbGs/t91zCp/7keGmnnCtw68ze/crXDCydw3P/Jt6ces1A
 F1/Um2HLWkIN1F15T5+/IurfCiN4f34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669121700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95xguAUSDF94+Sz3vdic3O+mnKYSR5TOcIZPi0jbBtk=;
 b=OXtJiL2MQi9lzyO20iAgzyX5qqxJGvXBegdJOei9wxDoKWKqZ/r8ux1ZC/IEQrk6G9O0kC
 DED/0MXJoxikAMAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5772813B01;
 Tue, 22 Nov 2022 12:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rr8gFKTGfGP3OAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Nov 2022 12:55:00 +0000
Date: Tue, 22 Nov 2022 13:56:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y3zG93Qf28sxqqND@yuki>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3uTZVir3OBBTrJ7@yuki>
 <871qpvfa3c.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871qpvfa3c.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event
 files
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This is minor, but I would have named the macro FOREACH_PATH() and
> > added
> 
> This is actually not in line with the kernel style. At least IIRC
> foreach macros are lower case in the instances I have seen. This is also
> what we have in tst_cgroup.c for e.g.
> 
> > curly braces around the block. And the same for the rest of the
> > invocations.
> 
> At some point checkpatch stopped complaining about this, so it's now the
> authors discretion whether to use curly braces in these cases. Unless
> there is something wrong with our checkpatch.

I do not think that this was ever enforced by checkpatch.

> IMO there is no mistaking that it is a loop macro with one function call
> in the body.

I tend to put the curly braces everywhere where there is a multiline
macro/function call because I find that way easier on the eyes...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
