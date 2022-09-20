Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD78C6FA82
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 18:29:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9CFF3CAD2C
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 20:29:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0C2E3CABD0
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 20:29:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 753691A00E38
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 20:29:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCAD21B3B;
 Tue, 20 Sep 2022 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663698567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niBysGbNDEynx1fFxPw6gGuQ1eNiBog3D/X6nLcAuzk=;
 b=heSAliKGd8UenzJS1oq7W6lwEzxwJvuRr+ee4WeDVPvXqtCeHsHmEJQ4qyuhjtlMClQ/NO
 aI775YYQ2ZiSOuuZLPZ4yyhNFdO3Daz79SKkHjgpN0yFp0wzuQYqWxokh4Qz9lNCdxWrAp
 TAXRxr2yewMRwsk8H9rNOIAWd+BNxkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663698567;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niBysGbNDEynx1fFxPw6gGuQ1eNiBog3D/X6nLcAuzk=;
 b=OpwkPAcIH25MmNUXpzn75lOMI45mmrweFjC6l0/5/Xi+YdNecoWC1vVyNdxuzMNPIJEeD3
 84475rTycdSoJTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 307FB1346B;
 Tue, 20 Sep 2022 18:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eCzeCIcGKmPyewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Sep 2022 18:29:27 +0000
Date: Tue, 20 Sep 2022 20:29:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YyoGhUMf4gCt9UB0@pevik>
References: <20220915031020.2633347-1-liwang@redhat.com>
 <YyMgBQu+phGCulxV@pevik> <YyM05nwf1+0eCd3w@yuki>
 <CAEemH2d_ckW9Zm77wRcoejiY0rCDB1Tpgs7c3LB=WNwYYLF7Hg@mail.gmail.com>
 <YyRER2kntqxXG7tl@yuki>
 <CAEemH2eDc0qfdkaOxrbEPsmOmZp7MA=exHRkjQPgxaJAh7HP2w@mail.gmail.com>
 <CAEemH2c1m7H581fn0VDq0nsjV6DN=+NwtmAegm0_WEqT0OmgiA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c1m7H581fn0VDq0nsjV6DN=+NwtmAegm0_WEqT0OmgiA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04: add EMFILE check
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

> On Mon, Sep 19, 2022 at 8:12 PM Li Wang <liwang@redhat.com> wrote:

> > Cyril Hrubis <chrubis@suse.cz> wrote:

> > Hi!
> >> > > I faintly remmeber a similar patch where we decided not to work around
> >> > > for a test harness leaking filedescriptors into testcases.


> >> > This also should be a solution, I searched the mailing list and got a
> >> > patch[1].
> >> > Do you mean adding that close-on-exec flag when opening fd in harness?

> >> Yes, that way you can be sure that no file descriptors are leaked to the
> >> tests.


> > Ok, should I send patch v2 like this below?

> > Note: the automation test open04 got passed but I'm not sure
> > if this has a side effect on logs. But from my observation, some
> > tests (with old-API) log can't be collected anymore.


> Seems we shouldn't fix by adding 'close-on-exec' flag simply,
> it brings more issues to some old-API tests, I'm still looking into
> the problems which look like caused by ltp-pan designed.

> So can we just merge the patch as the original?

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
