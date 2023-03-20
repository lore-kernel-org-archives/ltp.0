Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EBBC6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 08:04:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B91D13CD366
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 09:04:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 333B33CA88C
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 09:04:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53A6F2001A0
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 09:04:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49B471F855;
 Mon, 20 Mar 2023 08:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679299457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VP9Q7dlWEhj34Nr/kgLAjllrLqgWbL27hFebS0LEpK0=;
 b=nx9FUU0vl0EmbPGqntF/qETpAA5+h303JdBGZjYZ8dLIQtTddJELHa8tRNdTCqm+PUHMpu
 1951GvawqmWSGs8GZD7ws81ZZgnbu9qXbtDtqTMsQlq0Nhj07JxbTw6soDAXaWD6339wDo
 PHiGWoWjiea09BG8OCbSCLmotY0drnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679299457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VP9Q7dlWEhj34Nr/kgLAjllrLqgWbL27hFebS0LEpK0=;
 b=wmv05A3VU0GCXA1Z2I4u6L1Fo7UgBd7rn2JHf4CBaVh18YsU/Ry+DvSzj6nlMFrbAT3heh
 GhMFu/XCcV5V44Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDE2E13A00;
 Mon, 20 Mar 2023 08:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZGaTMIATGGTkQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Mar 2023 08:04:16 +0000
Date: Mon, 20 Mar 2023 09:04:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Message-ID: <20230320080415.GA179863@pevik>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314175438.GB79562@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > +## Maintainers Checklist

> >  Patchset should be tested locally and ideally also in maintainer's fork in
> >  GitHub Actions on GitHub.
> I'd encourage people to enable GitHub Actions in their forks (I'm not sure how

> many maintainers do this; best would be automation [1] [2], but nobody bothers
> about CI and I'm sort of burn out driving it myself).

+ also add Tested: link-to-github-actions-run below --- in patch would help
(it's than obvious that maintainer does not have to bother with doing it or
not hope that it fails on CentOS 7 old compiler or very new Fedora compiler).

Maybe also encourage people to create account in the patchwork and maintain
status their patches would help (set "Superseded" if they sent new patch version,
other statuses like "Accepted" or "Changes requested" are also sometimes
forgotten by the maintainer who post comments or merge the patch).

Both of these are small helps, but they still help LTP maintainers to have more
time for the review or for writing own patches.

But I can post a follow-up patch with these after your patch is merged if you
don't want to formulate them.

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://github.com/linux-test-project/ltp/issues/599
> [2] https://github.com/linux-test-project/ltp/issues/600

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
