Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73828C6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 05:43:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D19D3CA69D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 06:42:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2406E3CA55F
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 06:42:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0CCF31400141
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 06:42:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A01834326;
 Thu, 23 Mar 2023 05:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679550168;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOBWylxsXVG9AhouyLHeQjl+W6jD1LOPZPrcwBkASMY=;
 b=cQCrXIBHLwrKL3bWDf1pgC+RyiOhibCdHrQ0b2B8TydL3JM6zhUo/TLJ/ZyJfYW0gszGnx
 hte1pJarJIw/PpbC2613sHxnMyjG/7ZID4SOv/lLp7bjVki5DWcckBhVDu+5K5gu7R2EHT
 RFhAv6GrCEWg497BVlJ6gFrCsVJEW6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679550168;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOBWylxsXVG9AhouyLHeQjl+W6jD1LOPZPrcwBkASMY=;
 b=PIIO19voOzdKQ4p1MiS+FXASryni8VzolAevu6W0+xxD9xZJD5HDUNMGpeI9OFhD8Mq/Lk
 WyYr9FQQ0Nls1WCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD631138FB;
 Thu, 23 Mar 2023 05:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pVhZMNfmG2S6VAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 05:42:47 +0000
Date: Thu, 23 Mar 2023 06:42:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230323054246.GB381848@pevik>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik> <20230320080415.GA179863@pevik>
 <20230320082336.GA182681@pevik>
 <CAEemH2dHeOweGRaeQAx9DuE936=DMycqJNt_ymJ9GqSZ2ES8PQ@mail.gmail.com>
 <ZBsxm5o82a5CZ4my@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBsxm5o82a5CZ4my@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > I'd make a clarification for that mknod01 patch review,
> > the reason why Cyril merge V1 manually is that V2
> > involves new change (I neglected) in mknod02, which
> > should be separated in another patch.

> > Cyril did the right thing there. But he didn't explain that.

> I did the right thing by accident though. I only realized there is v2
> later on...

I really didn't want to blame anybody. I just wanted to demonstrate occasional
problems due wrong patch setup in patchwork. Therefore I proposed to all active
developers including these who aren't LTP maintainers (we have quite a few from
SUSE) to maintain their *latest* version of the patchset in patchwork (just to
set the older version either "Superseded" or "Changes requested". That would
reduce these confusions.

I'm ok not to make it as a written rule (it might lead to confusion to encourage
all contributors to make a patchwork account, OTOH it's useful even for rare
kernel contributions, thus I have patchwork accounts in both
https://patchwork.ozlabs.org/ and https://patchwork.kernel.org/).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
