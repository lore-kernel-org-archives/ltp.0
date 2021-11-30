Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3DC433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:01:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E268C3C6AC5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:01:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 828FD3C3171
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:01:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A418E601074
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:01:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD8151FD2F;
 Tue, 30 Nov 2021 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638266464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIha5vpDr8hO0qxkQyw0fLOrSGgf0w/Aa7qPLBXM67Y=;
 b=y4735SXvBRNuH/LbEnl3u/66FxHscPgYGdUS95JwEiDc23g3FaUolPUWXsKggq4VQKawom
 6LyPZ9V7WQignTB1Hrjmh3UJREj/1/xWXdFdaetKzBvfFd+2b0oj6cDZKWIIpLOoH4IPVN
 zEzDHdsE4hbwIDH3eAg6H63sd5vuP8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638266464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIha5vpDr8hO0qxkQyw0fLOrSGgf0w/Aa7qPLBXM67Y=;
 b=5PmGZF+x/RkSEQ41zIjH5xPgSDXPt2mZ1E8mtpsDRXLZbUtXAab6kzrSWqaKPPBSGJHE35
 f/ri8iPkryPdDdDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7727913C98;
 Tue, 30 Nov 2021 10:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BRgZG2D2pWG0KAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 30 Nov 2021 10:01:04 +0000
Date: Tue, 30 Nov 2021 11:01:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YaX2XgGp2U88Ck0h@pevik>
References: <YaS0F9/ZyPtZi5zE@pevik> <YaS/dbbn3cRobeIp@yuki>
 <87r1aykmfr.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r1aykmfr.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, Cyril,
> Hello,

> Cyril Hrubis <chrubis@suse.cz> writes:

> > Hi!
> >> checkbashisms does not detect all things: e.g. not catching {1..$FILE_COUNT}
> >> [1]. Maybe we should reconsider using *also* shellcheck as Joerg suggested
> >> (keep checkbashisms).

> >> I don't like shellcheck output, but it can detects errors checkbashisms cannot
> >> detect (checkbashisms is regexp based, but shellcheck IMHO evaluates the code).
> >> Also it's configurable, thus ve could disable check we don't like or enable only
> >> what we want to check. Or we can run just --severity=warning or
> >> --severity=error. If you're not against it, I can have look into this.

> > Sounds good, the more automated checks we have the less we will spend on
> > review...

> We can't vendor in a Haskell program, so it will have to be an optional
> check. Still it looks nice.
Yes, I didn't plan to vendor it. But fortunately it's being packaged some of
major distros [1] [2].

> Tree-sitter also supports "Bash", which might be useful for LTP specific
> checks. That ofcourse is much higher hanging fruit.
Interesting, it might be worth to investigate. But yes, the most important goal
is IMHO have valid portable POSIX syntax (to catch errors checkbashisms does not
detect).

I'd have to think about LTP specific checks (the only I would come up now is
LTP-003 - shell library API have TST_ prefix" but not sure how to test naming of
shell API as any shell global variables are local).

Kind regards,
Petr

[1] https://pkgs.org/download/ShellCheck
[2] https://pkgs.org/download/shellcheck


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
