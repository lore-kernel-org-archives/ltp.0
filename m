Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E673C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:44:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DCCC3C9AE6
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 15:44:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 992B73C0391
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:44:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F4B26009E2
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:44:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4482F1F37E;
 Mon,  7 Feb 2022 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644245088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hPMtNpohL1r/3BqDLe4wH6ZS/zbGn1unmUhuTX19jg=;
 b=2wp9S8iVX64HlPnBJKaOohp7wHCOmnsevm+eMZV8wLCaEyMKyze8TfjlbvS6ivHoJk7pYm
 cznODRaFDDj7FReEvTc3rEuFgXci+ExwvO8KbVfkCfjzmYkL0qQP4tooG++Ah2Ld8CLCjK
 kQJlXunE86S6ITtis5heUAiQyiXYMlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644245088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hPMtNpohL1r/3BqDLe4wH6ZS/zbGn1unmUhuTX19jg=;
 b=tFKD/H+zNdq61IQt4vBtgnmhBHzM4WupARDwi2dorokzULaVm8lNWV4bbRn8LhgwHlqo7G
 6t8dg6EXRe1zteCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A87813C28;
 Mon,  7 Feb 2022 14:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JRCjCWAwAWLyTAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Feb 2022 14:44:48 +0000
Date: Mon, 7 Feb 2022 15:46:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YgEw2/ev3gQ05B2Q@yuki>
References: <20220203061222.625948-1-amir73il@gmail.com>
 <YgDsIaf5z2rg5tCH@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgDsIaf5z2rg5tCH@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/inotify: New test for IN_DELETE
 regression
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
Cc: Ivan Delalande <colona@arista.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	/* Kill the child creating / deleting files and wait for it */
> > +	SAFE_KILL(pid, SIGKILL);
> > +	pid = 0;
> > +	SAFE_WAIT(NULL);
> Interesting. I didn't figure out why kill and wait cannot be done just in
> cleanup.

I guess that we want to stop the child in the case that we happened to
open the deleted file and did abort the testing.

Technically we send a signal to a zombie process in the case that the
bug was not reproduced (as the child exits the verify_inotify() with
return it will just do exit(0) once it reaches test library code). But
that should be harmless.

On the other hand I guess that it may make the code a bit more readable
if we moved the SAFE_KILL() just after opened = 1 in the inner loop.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
