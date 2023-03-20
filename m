Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB225C7618A
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 08:33:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C137C3CCC97
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 09:33:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00DCA3C2FCE
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 09:33:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 775406005D7
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 09:33:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5BD781F88C;
 Mon, 20 Mar 2023 08:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679301188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAgt2O6n7ksO+L9+d2VSvEiGwmPPH84tNq+OL3IW4eU=;
 b=2EVBWKtXvGaDGy6vPa4fb/emXAZpsnU+mM+FumXGIM4R+jBEGMFJmtJbjEkC3Mn9C58w3n
 hCOTMZS/rzcVdyW9IL4KTjy/32c0mQzQY1RFe71Ld2GJ+DVxtp6MnQBXcxq9YMyTVyxQPA
 wV4+bPuy08Go1HJ8D96bAzLKtRjfH2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679301188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAgt2O6n7ksO+L9+d2VSvEiGwmPPH84tNq+OL3IW4eU=;
 b=rDn/rBtsL2falntaQlJ5to9CXcPmT84xopAAkENakG+E+j241lEpDGTNOTJlUw0Iy+y/pO
 InikVUfMMLX+h3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D74BE13416;
 Mon, 20 Mar 2023 08:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yznvMkMaGGSYUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Mar 2023 08:33:07 +0000
Date: Mon, 20 Mar 2023 09:33:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 Avinesh Kumar <akumar@suse.de>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230320083305.GB182681@pevik>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik> <20230320080415.GA179863@pevik>
 <20230320082336.GA182681@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230320082336.GA182681@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

> > + also add Tested: link-to-github-actions-run below --- in patch would help
> > (it's than obvious that maintainer does not have to bother with doing it or
> > not hope that it fails on CentOS 7 old compiler or very new Fedora compiler).

> > Maybe also encourage people to create account in the patchwork and maintain
> > status their patches would help (set "Superseded" if they sent new patch version,
> > other statuses like "Accepted" or "Changes requested" are also sometimes
> > forgotten by the maintainer who post comments or merge the patch).
> Example why helping to maintain the patches by submitter would help:
> mknod01: Rewrite the test using new LTP API [1] followed by [v2,1/1] mknod01:
> Rewrite the test using new LTP API [2].

> Li reviewed v2, but later Cyril pushed v1 (manually updating patch) without
> update patchwork. (Li review was ignored, I tried to apply v2 to merge it
> because status was not updated.)

And should go to the section "How to get patches merged".

But we also have "Developers corner" [3], maybe it should go there. Because I'm
not sure if contributors will read wiki page for maintainers.

BTW content of [3] is also in wiki homepage [4], but that's kind of duplicate
document, IMHO it'd be good to move this to single wiki page.

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://patchwork.ozlabs.org/project/ltp/patch/20230222034501.11800-1-akumar@suse.de/
> [2] https://patchwork.ozlabs.org/project/ltp/patch/20230228154203.2783-1-akumar@suse.de/
[3] https://github.com/linux-test-project/ltp#developers-corner
[4] https://github.com/linux-test-project/ltp/wiki#developers-corner

> > Both of these are small helps, but they still help LTP maintainers to have more
> > time for the review or for writing own patches.

> > But I can post a follow-up patch with these after your patch is merged if you
> > don't want to formulate them.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
