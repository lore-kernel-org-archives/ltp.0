Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C299CE77180
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 19:41:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D8A13E9BC7
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 20:41:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AACF3E93AC
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:41:02 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 94C8D1BBFB27
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:41:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E0AA52117B;
 Wed, 11 Dec 2024 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733946061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
 b=At4m9Jgd3smaYWoA/Z8R/Mk5KEYb00xBNwgYyQtswjH6ZnFAT7IMIyy7d9Y51B0HXmM9gy
 GlSzcWFy3Z6C7foX65zzu2NcOo8jWxj6upjYzspAuSk61bHoDUQpNKathuNqJDBVauXJJR
 bHe7yfWBY6fnfF3zKqxdm4eym4Aij14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733946061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
 b=RQ7RHTzaZcAFSBc0ZGA0RJpr1mIxY6/nIZf+Pa7gxZmI0jowo9j4zcnpS5S/xDIkdL6xoO
 hEaD363w58TLqNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733946061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
 b=At4m9Jgd3smaYWoA/Z8R/Mk5KEYb00xBNwgYyQtswjH6ZnFAT7IMIyy7d9Y51B0HXmM9gy
 GlSzcWFy3Z6C7foX65zzu2NcOo8jWxj6upjYzspAuSk61bHoDUQpNKathuNqJDBVauXJJR
 bHe7yfWBY6fnfF3zKqxdm4eym4Aij14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733946061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35RoydE4cjeYGALHKsjeWsziBR0PBU5w3habli0kGtQ=;
 b=RQ7RHTzaZcAFSBc0ZGA0RJpr1mIxY6/nIZf+Pa7gxZmI0jowo9j4zcnpS5S/xDIkdL6xoO
 hEaD363w58TLqNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A95A1344A;
 Wed, 11 Dec 2024 19:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tNGaIc3qWWeDEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 19:41:01 +0000
Date: Wed, 11 Dec 2024 20:40:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241211194059.GD443680@pevik>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
 <20241209055309.54x5ngu3nikr3tce@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241209061416.GB180329@pevik> <Z1mA2wzjW0hpQxUH@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z1mA2wzjW0hpQxUH@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
Cc: ltp@lists.linux.it, Zorro Lang <zlang@kernel.org>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Well, "Testing only" in the help (-h) was added there to suggest it's for
> > testing/debugging LTP, not a production testing. But newer mind, I'll implement
> > Cyril's suggestion, real usage justify it. + I'll add LTP_FORCE_SINGLE_FS_TYPE.

> > We could allow more filesystems, e.g.  instead of running LTP few times with
> > different LTP_SINGLE_FS_TYPE value: e.g.

> > for fs in ext4 xfs btrfs; do LTP_SINGLE_FS_TYPE=fs ioctl_ficlone02; done

> > we could introduce support for particular filesystems
> > LTP_FILESYSTEMS="ext4,xfs,btrfs" ioctl_ficlone02

> That is stil not equivalent if you run it with a whole LTP. We would
> have to run each test that uses device for all LTP_FILESYSTEMS, since
> many of the testcases does use device but does not use .all_filesystems.

> So all in all I think that LTP_SINGLE_FS_TYPE is good enough solution.

> Or we can try to rething the whole thing, but it's getting quite
> complicated with all the options we have.

I guess LTP_SINGLE_FS_TYPE + LTP_FORCE_SINGLE_FS_TYPE LGTM.

What bothers me more how much time we spent with formatting loop device (done
for each test with .all_filesystems several times). Running all tests on single
filesystem, then reformat and run all of them on the other filesystem would be
faster. The only thing which is better on this is theoretical chance that
filesystem gets corrupted by some test, then other tests would be somehow
influenced.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
