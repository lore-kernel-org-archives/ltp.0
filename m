Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2479C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 17:45:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46F263CF4B1
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 19:45:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06A913CCB19
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:45:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 345A2603EA1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 19:45:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E0901FDCD;
 Fri, 27 Oct 2023 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698428714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBXsvuS1hWe+J/U65scUBMEO0FgQFpZP4d3HuncQj+o=;
 b=uNbYVIHr5mpGP2wsU/1j+ZTI98KAxT8mRxDW05PH472bFuHcKaGiPnE/6Nr0HvPP+OEf+w
 We64OMf3FQBQtFrMVvumYpI3Suc7QzG7O8Clv1GcQVs7fm71ypFbX/gEM5RLYGAxMrpyob
 k9LyeeNAp/BuUoaJGE1jgd1IFG1HOA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698428714;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBXsvuS1hWe+J/U65scUBMEO0FgQFpZP4d3HuncQj+o=;
 b=lw3BLLLOZsqNx7oiDrLSap/AxvgrnfNcJ5UortVtP70dKrIOvIwRq1O39ri4T7Ni0di06I
 Sd3R80xyXxIymIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC9FB1358C;
 Fri, 27 Oct 2023 17:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kHSkNin3O2U9VgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 Oct 2023 17:45:13 +0000
Date: Fri, 27 Oct 2023 19:45:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231027174512.GA710840@pevik>
References: <20231027104951.32464-1-rpalethorpe@suse.com>
 <20231027110116.GA649751@pevik> <ZTvH_DptjIrZJx-A@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTvH_DptjIrZJx-A@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-8.19 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.89)[85.89%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset: Make mount failure TCONF
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > It appears that if the subsystem is available under V2 then mounting
> > > the V1 can fail. Probably when the V2 has processes assigned to a
> > > group it controls.

> > Sounds likely, but it would be good to check this in the kernel code or with
> > kernel cgroup developers.

> I'm pretty sure that controller can be used either in v1, or in v2 but
> not from both at the same time by choice. Some of the changes between v1
> and v2 are incompatible so this couldn't work either way.

> I think that once the controller name is written to
> /sys/fs/cgroup/unified/cgroup.subtree_controll mounting it to v1 should
> fail, so maybe we should just try to grep the fail instead and exit the
> test with TCONF if we found the controller bound to v2 already.

Sounds like a good idea.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
