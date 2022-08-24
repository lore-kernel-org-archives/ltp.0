Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A702C00140
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 13:44:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE5163CA3C0
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 15:44:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E55B3C0367
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 15:44:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88485600C51
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 15:44:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 449AD1F931;
 Wed, 24 Aug 2022 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661348666;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HbRT1Cq+Fe6w94is+bzVfAaYJN9t87cTx8kZ8JhQYXA=;
 b=SEPahWAti/1qsY3C0LmRHgRQx/OJmMEVFsctKc6dA9E914JUc+jDt3XjxodaGfCGVZt7Ka
 GfK9drG58go3qbxTzFcg6pj493um2MiDFcH+5To2J7RMtl2/RIygpTeO7HhdfkrND+Gza4
 DWoDY7UyGBfFZpQm3h+2Jm8MlglwW70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661348666;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HbRT1Cq+Fe6w94is+bzVfAaYJN9t87cTx8kZ8JhQYXA=;
 b=36qxFaWTLWlaHDKyzYCxEHmoPy2Mni1wp++aFpBYDU5p8zG9QXrnF4wuwrVnwsstA5wEYt
 svUOOUf4VxbSePCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0260113780;
 Wed, 24 Aug 2022 13:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id icX8OTkrBmOGcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 24 Aug 2022 13:44:25 +0000
Date: Wed, 24 Aug 2022 15:44:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YwYrOAPdTsr1lqgM@pevik>
References: <20220824123240.20092-1-pvorel@suse.cz>
 <CAASaF6x8M516FiOqoJF2AiSceMgFJWsDt-HCE19G9jW=dLiFkA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6x8M516FiOqoJF2AiSceMgFJWsDt-HCE19G9jW=dLiFkA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] github: Add issue template
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Aug 24, 2022 at 2:32 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > this effort is driven by reports like [1]
> > You can see the result on my special fork [2].

> > I considered to mention ML, but in the end I didn't.

> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/issues/created_by/anilbp
> > [2] https://github.com/pevik/_ltp_test_issue/issues/new

> >  .github/issue_template.md | 5 +++++
> >  1 file changed, 5 insertions(+)
> >  create mode 100644 .github/issue_template.md

> > diff --git a/.github/issue_template.md b/.github/issue_template.md
> > new file mode 100644
> > index 000000000..caf8907da
> > --- /dev/null
> > +++ b/.github/issue_template.md
> > @@ -0,0 +1,5 @@
> > +Issues are *not* support forum.
> > +
> > +Bugs in the tests should be reported to your Linux distribution.

> Did you mean here "bugs in distro/kernel"?
Good catch, thanks! Yes, the last sentence should have been:

Bugs in the distro/kernel should be reported to your Linux distribution.

Fixes also in the example on the github.

Kind regards,
Petr

> > +
> > +Issues are *only* for reporting bugs in tests.
> > --
> > 2.37.2



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
