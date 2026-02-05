Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A35EC1E80
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 09:45:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7DBE3CE20E
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 10:45:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EF733CE20E
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 10:45:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 107D66001EF
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 10:45:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E3085BCEA;
 Thu,  5 Feb 2026 09:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770284704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkMoZPFeFPpi1cFPr5bPgE9VUcwKrf6iU2rbOyyxw6Y=;
 b=smgSwM3/SRDKbfFc4yjTDhKdEOKtEqAJRsH3XPruTnMoSHUU9F/efkioVnLZAY453bdGlY
 /uDIRs5x5ubrNXM1Kqt79ThEPj1lIY3FMmRQHqMUsPjyUKON2hR76wTZXk6+Zk0NiqNhjp
 KzF+hOqzi6aHcOGldjHl3PPteeeEhu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770284704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkMoZPFeFPpi1cFPr5bPgE9VUcwKrf6iU2rbOyyxw6Y=;
 b=6OTSxazeKO68kS7zhW0nz7OWSE44893bAOtn5T0BCu9zFBcJ8M/tZn0OVIGyCPmzIaLVaq
 xwmWBtBkhQzwLqBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770284704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkMoZPFeFPpi1cFPr5bPgE9VUcwKrf6iU2rbOyyxw6Y=;
 b=smgSwM3/SRDKbfFc4yjTDhKdEOKtEqAJRsH3XPruTnMoSHUU9F/efkioVnLZAY453bdGlY
 /uDIRs5x5ubrNXM1Kqt79ThEPj1lIY3FMmRQHqMUsPjyUKON2hR76wTZXk6+Zk0NiqNhjp
 KzF+hOqzi6aHcOGldjHl3PPteeeEhu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770284704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkMoZPFeFPpi1cFPr5bPgE9VUcwKrf6iU2rbOyyxw6Y=;
 b=6OTSxazeKO68kS7zhW0nz7OWSE44893bAOtn5T0BCu9zFBcJ8M/tZn0OVIGyCPmzIaLVaq
 xwmWBtBkhQzwLqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 413B43EA63;
 Thu,  5 Feb 2026 09:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S/fbDaBmhGlkCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Feb 2026 09:45:04 +0000
Date: Thu, 5 Feb 2026 10:44:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260205094458.GA294817@pevik>
References: <20260204124323.244578-1-pvorel@suse.cz>
 <aYQz6gN7WvJbSg1k@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYQz6gN7WvJbSg1k@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openat2: Move includes to lapi, remove _GNU_SOURCE
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

> On Wed, Feb 04, 2026 at 01:43:23PM +0100, Petr Vorel wrote:
> > Improve 767b3e519e. struct open_how is also used in lapi/openat2.h,
> > which is used by all openat2*.c tests.  Therefore move <fcntl.h> to the
> > lapi header (and use lapi/fcntl.h instead).

> > Also remove _GNU_SOURCE which should not be needed.

> > While at it, move include "config.h" to the top.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Li,

> > my points from the original patchset why not use _GNU_SOURCE:

> > glibc test tst-openat2.c [1] which includes <fcntl.h>, uses struct

> Interesting, I haven't figure out why it can be built within glibc itself.

I also checked Makefile, but haven't found that. Never mind, I was wrong, it's
obviously needed.

> > open_how and test openat2() does not define it. Neither openat2() nor
> > struct open_how [2] are guarded by #ifdef __USE_GNU.

> > O_DIRECTORY is guarded by #ifdef __USE_XOPEN2K8 but this should be safe as we
> > compile with -std=gnu99.

> In glibc-2.43, things have changed, only define __USE_GNU can contain the
> <bits/openat2.h> header file, that's why after applying this patch still
> fails to complie on Fedora-Rawhide.

> <fcntl.h> -> <bits/fcntl.h> -> <bits/fcntl-linux.h> -> <bits/openat2.h>

Yeah, I saw this...

>  # cat bits/fcntl-linux.h

>  396 #ifdef __USE_GNU
...but did not check that whole section is guarded by __USE_GNU (=> _GNU_SOURCE).

Kind regards,
Petr

>      ...
>  473 #include <bits/openat2.h>

>  489 #endif	/* use GNU */

> See: https://github.com/bminor/glibc/commit/0f0a5cd338998f4b603f52f3ce2163df0db7b814#diff-a4fc1e1b56b60a2598e320a232e6f631d08e0dafcfe3dd9607dde4bc8ee31eb8R473

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
