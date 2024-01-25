Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A0CC48285
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 09:53:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D13163CE1D1
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 10:53:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94BAE3C8B4B
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 10:53:33 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22F3A256FEE
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 10:53:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 218FA21ED1;
 Thu, 25 Jan 2024 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706176410;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceDYl0nxU85aDl2gZ2PZzDE/+UadL8wYdgdOuZo9iOc=;
 b=q6Oy8ouEpMbCE7IAZ+NwvkA5Ks2QCwgvYzbr3VuqywTc/iEd2kTLSky8AZFULQfauUUsvQ
 AWA6PYD2z5MctIkyyjHdpLwUswGwimD0syQqnZUd6jwX60FKDl2WbOTXbo8RIZe3/g0ViD
 6Gn85CqAGankqT6Vgku2q9aWYQQEmvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706176410;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceDYl0nxU85aDl2gZ2PZzDE/+UadL8wYdgdOuZo9iOc=;
 b=IRyhRnR83KqCz3HDHXXWRO7TN95uSKbJMpY0PQ9V7Nm/vIBMzLpvcLiyUfXWjDMhE4n6Fr
 6KsPdAm5pF4uh2Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706176410;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceDYl0nxU85aDl2gZ2PZzDE/+UadL8wYdgdOuZo9iOc=;
 b=q6Oy8ouEpMbCE7IAZ+NwvkA5Ks2QCwgvYzbr3VuqywTc/iEd2kTLSky8AZFULQfauUUsvQ
 AWA6PYD2z5MctIkyyjHdpLwUswGwimD0syQqnZUd6jwX60FKDl2WbOTXbo8RIZe3/g0ViD
 6Gn85CqAGankqT6Vgku2q9aWYQQEmvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706176410;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceDYl0nxU85aDl2gZ2PZzDE/+UadL8wYdgdOuZo9iOc=;
 b=IRyhRnR83KqCz3HDHXXWRO7TN95uSKbJMpY0PQ9V7Nm/vIBMzLpvcLiyUfXWjDMhE4n6Fr
 6KsPdAm5pF4uh2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEA8E13649;
 Thu, 25 Jan 2024 09:53:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NBYLOJkvsmVrWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 09:53:29 +0000
Date: Thu, 25 Jan 2024 10:53:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240125095324.GA385509@pevik>
References: <20240125004732.9549-1-wegao@suse.com>
 <20240125093554.GA383352@pevik>
 <44e16062-1336-45fb-be72-6cbba0ba5e3c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44e16062-1336-45fb-be72-6cbba0ba5e3c@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.52 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.02)[53.14%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fs_fill: Increase test loop device size to 1GB
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

> On 25. 01. 24 10:35, Petr Vorel wrote:
> > Hi Wei,

> > > On PPC64 the page size is 64K and this causes trouble on btrfs
> > nit: s/PPC64/ppc64le/ (the other one is 32 bit)

> The other one is 64bit but big-endian. And yes, the big-endian mode will
> have the same issue, so "PPC64" is good enough catch-all term.

Wei, I'm sorry, of course Martin, you're right.

> > nit: s/64K/4K/

> No.

Also here.

Martin, thanks for correcting me.

Kind regards,
Petr

> > > filesystems of small size(LTP currently use 300M), the threads
> > > could compete for a very small number of pages/blocks to actually
> > > write the data. So Increase minimal device size to 1G avoid the
> > > corner case.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > I wonder if would work with less (512 MB), but probably better to be safe with
> > 1024 MB.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
