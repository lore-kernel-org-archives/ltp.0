Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E5DC433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 15:23:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FC1C3CA32C
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 16:22:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 640FE3C248B
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 16:22:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CCF082009D8
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 16:22:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF9F11F382;
 Thu,  3 Mar 2022 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646320967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wwo1+XFkhlkQjXBJJ5olf3BGKQaH6gDQWfB3ZVxWpLY=;
 b=0TuGXeldqGtFdQM/RLSbvpmRty9hxvJCveWVHf7VpEvkKcQYi3ZVWDaNktYT0xedIFg4g6
 POxP583jgtpnpz++cSve7tiPfR0xh0PdDu0E9KmS6s34NuH6d5nGgJo4x1P6hwenuNVF0n
 kPpsEu9g2NuSI/rsC/lnbJd1E3M23mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646320967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wwo1+XFkhlkQjXBJJ5olf3BGKQaH6gDQWfB3ZVxWpLY=;
 b=uzb00S6ojzuT03A/pUbhLV7yJZOeprUdiTt383dVOsF1QkSNQ3PMTYHyv0g5E8FytNVL2K
 nPcT2Bz2v8Xy1jAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCE6C13C23;
 Thu,  3 Mar 2022 15:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rL2hK0fdIGLvEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 15:22:47 +0000
Date: Thu, 3 Mar 2022 16:22:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <YiDdRhIdh12/23HM@pevik>
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
 <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
 <Yhxu8elhUJakYJHH@pevik> <YiAqwHabM9qCUjAU@xzhouw.hosts>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiAqwHabM9qCUjAU@xzhouw.hosts>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/fs/fsnotify-stress: fsnotify stress test
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This is a stress tests that exercises fanotify and inotify interfaces
> while IO going on. It ignores some failures of syscalls to let the
> stress go on. If the kernel does not panic or hang after a certain
> period of time of testing, test pass.

> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
> v2:
> 	Merge all into one C programme.
> 	Changed dirname of the testcase.
> 	Run fs_racer.sh from this.
Also tests in testcases/kernel/fs/racer/ are very old scripts with questionable
code quality. I would not use them with new tests.  Not sure whether these tests
are useful at all, but if yes they please take the idea and implement it in new
C API, so that they can be called by forked thread.

Why C? Running shell test from C is probably not acceptable. We have enough
problems with shell tests which use C binaries. Doing it vice versa can bring
even more problems.

fs_racer.sh runs many times fs_racer_file_create.sh, which mainly does:
dd if=/dev/zero of=$DIR/$file bs=1k count=$SIZE

=> nothing hard to implement in C.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
