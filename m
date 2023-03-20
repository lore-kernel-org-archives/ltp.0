Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F04C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 14:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76A443CD363
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 15:48:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DFF23C25BE
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:48:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03DB61000472
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:48:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA47F21A06;
 Mon, 20 Mar 2023 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679323698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SglcTSdLc+qiApYhd/QtaDKrtzdabws/oMpzjyyUki0=;
 b=dNSwOnUQ+cXSoh0pJ1VeD6yMWyrnNd15NSPJ4CISjVVpIFMNCMSBf02q/JrGq2ZgwhrUHl
 XPrz5l8v9k8Wev6tRIdLZWGZWh3uzO+lGgYnFHyond2ogj8SiYtNKtZQs6Ff+7jCVJ+lI9
 wUziYx2sQ9CWOMNSJviIXBMJjxcAUa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679323698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SglcTSdLc+qiApYhd/QtaDKrtzdabws/oMpzjyyUki0=;
 b=1VPLyysA8GAIK7SRTeMpzoYLlcEw9p+qptfCl2WJamwXcMyGety9riXxXnxzfLW7X1odsb
 sWz6irXa+V2s6rAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEC2E13A00;
 Mon, 20 Mar 2023 14:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D3XEKzJyGGQJLwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Mar 2023 14:48:18 +0000
Date: Mon, 20 Mar 2023 15:48:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230320144817.GB215496@pevik>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik> <20230320080415.GA179863@pevik>
 <20230320082336.GA182681@pevik> <871qlj4vhj.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871qlj4vhj.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add goals of patch review and tips
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

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi all,

> >> + also add Tested: link-to-github-actions-run below --- in patch would help
> >> (it's than obvious that maintainer does not have to bother with doing it or
> >> not hope that it fails on CentOS 7 old compiler or very new Fedora compiler).

> >> Maybe also encourage people to create account in the patchwork and maintain
> >> status their patches would help (set "Superseded" if they sent new patch version,
> >> other statuses like "Accepted" or "Changes requested" are also sometimes
> >> forgotten by the maintainer who post comments or merge the patch).
> > Example why helping to maintain the patches by submitter would help:
> > mknod01: Rewrite the test using new LTP API [1] followed by [v2,1/1] mknod01:
> > Rewrite the test using new LTP API [2].

> > Li reviewed v2, but later Cyril pushed v1 (manually updating patch) without
> > update patchwork. (Li review was ignored, I tried to apply v2 to merge it
> > because status was not updated.)

> Yes, I think patchwork is important.

> Probably where we disagree is how agressive to be when removing stuff
> from the default view. IMO a shared list can not be allowed to grow; you
> can't leave TODO items on there unless they are next on your priority
> list.

This is slightly different topic (I wrote about forgetting to update status),
but it's even more important.

> So I would say remove items (so they don't show up with the default
> filter) aggressively and put them on a private list if you intend to do
> them ever.

If it's obvious, that patch needs serious change I'm ok to set the status.
But because I mainly watch patchses in patchwork (and I'm not sure if I'm alone),
if the patch was posted recently, I wait few hours / one day to update the status
of the patch so that others can see it. But sure I'll stop doing it, if we all are
ok. (I should force to look into ML queue more often, there are also bug reports
and other discussions which aren't in patchwork.)

Kind regards,
Petr

> > Kind regards,
> > Petr

> > [1] https://patchwork.ozlabs.org/project/ltp/patch/20230222034501.11800-1-akumar@suse.de/
> > [2] https://patchwork.ozlabs.org/project/ltp/patch/20230228154203.2783-1-akumar@suse.de/

> >> Both of these are small helps, but they still help LTP maintainers to have more
> >> time for the review or for writing own patches.

> >> But I can post a follow-up patch with these after your patch is merged if you
> >> don't want to formulate them.

> >> Kind regards,
> >> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
