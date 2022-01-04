Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB633C433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 12:22:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F13D73C90F0
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 13:22:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B54D3C1D3C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 13:22:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 68CFA6008B0
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 13:22:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D8C31F386;
 Tue,  4 Jan 2022 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641298959;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAURPbsEvxIQL6aYDyNNwoN2cJvLawirzuI92aRI1T4=;
 b=sHNunkWut0sg5C8xQ1uxR2DGZErzlnfdT4paiDd5cqbuxa5l7oYrIJFzXD/ZVLkUJqIab2
 e0MxobbnJX2TlHkM3j7/hxMrAtbAp4jfRcAuM9jvexzXvel3F3AsnORB3h3WVTU2c7AMh+
 iV60dXbTa1Gxi9BNPTmhJCBnWpmtW7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641298959;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAURPbsEvxIQL6aYDyNNwoN2cJvLawirzuI92aRI1T4=;
 b=4aVNfPr286/2yDkYnql+o5FVDsiEkmhpQalmhuZFwMAm7ncq922ovIREHO5W7/4jXdEjck
 ljI+G2uQ+9d1ITDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68BF113B08;
 Tue,  4 Jan 2022 12:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qO4LFw881GH9UgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jan 2022 12:22:39 +0000
Date: Tue, 4 Jan 2022 13:22:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YdQ8C32kJun/AnUK@pevik>
References: <20220104073754.721-1-andrea.cervesato@suse.com>
 <20220104073754.721-2-andrea.cervesato@suse.com>
 <YdQGplLdFnsmhlSO@pevik> <87a6gbogos.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6gbogos.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Refactoring aio-stress.c using LTP API
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

Hi Richie,

> Hello Petr,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Andrea,

> > ...
> >>  			for (i = 0; i < io->io_oper->reclen; i++) {
> >>  				if (io->buf[i] != verify_buf[i]) {
> >> -					fprintf(stderr, "%d:%c:%c ", i,
> >> -						io->buf[i], verify_buf[i]);
> >> +					ret = asprintf(&msg, "%d:%c:%c ", i, io->buf[i], verify_buf[i]);
> >> +					if (ret < 0)
> >> +						tst_brk(TBROK, "asprintf memory allocation error");
> >> +					ptr += sprintf(ptr, msg);
> > Actually, this is problematic for -Werror=format-security which we use in CI.
> > Simple "%s" fixes that. It can be done before merge.

> > ptr += sprintf(ptr, "%s", msg); 

> > @Richie: I wonder if make check could also actually compile the code with
> > extra CFLAGS from build.sh.

> Compiling during make-check may confuse things; we don't want make-check
> to produce build artifacts. Although I guess you could skip the later
> compilation steps. Also then we could add -fanalyzer on gcc which I have
> done in a test project[1]. Possibly Clang has something similar,
> hhmmmm...

FYI the point is for me to avoid manually pushing changes to github repository,
to speedup review by catching early (and without additional effort from reviewer
side) mostly trivial error detection.

But OTOH we cannot expect users to have it running, thus I should probably force
myself to implement pachwork REST API
https://github.com/linux-test-project/ltp/issues/599

i.e. either we ask patch authors to watch the build status on patchwork or to
run make check (or even both).

Kind regards,
Petr

> Probably this would require different flags on GCC and Clang. We could
> also run both GCC and Clang if they are present. It's probably worth
> experimenting with.

> [1]: https://richiejp.com/zc-data#meson

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
