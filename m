Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC388C0015E
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 14:32:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A47883CE908
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 16:32:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 118C73C8524
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 16:31:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 60B081A02389
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 16:31:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EB70218B0;
 Fri, 21 Jul 2023 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689949914;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rqP9n3VS3RsCzIZjPvnUt4F474+MJcnuHvY6er+8gE=;
 b=KihW/0rI80E/mjwV2huLo7a2fMu9pUZeFq0RVdBQfwUqQQDkWAActT5/RyeWwC5C4soZI1
 M9LpF0bmYTHovLic+Kl9XVNn3FSLk8yPOcArkB6vWMTb9Jzc8b4TzRikiCVzn6BQPMidnX
 04kinyk8+jXpbPcPgdJk4LtozDEsINE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689949914;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0rqP9n3VS3RsCzIZjPvnUt4F474+MJcnuHvY6er+8gE=;
 b=bdb9lI1ClZB56tnNLTx50HUjZ5npFxSrvXhf4hMyGtgzl9ur2LHFlXf+GO1Q0wWnYFBCpy
 enJZmJyFx5mWgwDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57A8F134BA;
 Fri, 21 Jul 2023 14:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ati7EdqWumR9DwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 14:31:54 +0000
Date: Fri, 21 Jul 2023 16:31:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20230721143152.GA1428451@pevik>
References: <20230721100330.1366932-1-pvorel@suse.cz>
 <4864592.31r3eYUQgx@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4864592.31r3eYUQgx@localhost>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] write05: Simplify test using TST_ macros
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

> Hi Petr,

> On Friday, July 21, 2023 3:33:30 PM IST Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/kernel/syscalls/write/write05.c | 20 +++-----------------
> >  1 file changed, 3 insertions(+), 17 deletions(-)

> > diff --git a/testcases/kernel/syscalls/write/write05.c
> > b/testcases/kernel/syscalls/write/write05.c index c1e48f1df..1e85cce6d
> > 100644
> > --- a/testcases/kernel/syscalls/write/write05.c
> > +++ b/testcases/kernel/syscalls/write/write05.c
> > @@ -59,26 +59,12 @@ static void verify_write(unsigned int i)

> >  	sigpipe_cnt = 0;

> > -	TEST(write(*tc->fd, *tc->buf, tc->size));
> > -
> > -	if (TST_RET != -1) {
> > -		tst_res(TFAIL, "write() succeeded unexpectedly");
> > -		return;
> > -	}
> > -
> > -	if (TST_ERR != tc->exp_errno) {
> > -		tst_res(TFAIL | TTERRNO,
> > -			"write() failed unexpectedly, expected %s",
> > -			tst_strerrno(tc->exp_errno));
> > +	TST_EXP_FAIL(write(*tc->fd, *tc->buf, tc->size), tc->exp_errno);
> Should we use TST_EXP_FAIL2 instead?

Good catch, write() requires TST_EXP_FAIL2(). Thanks!
Merged with this fix.

> Maybe we can also do the ascii doc changes and headers cleanup, but I'm fine if 
> we do that in a separate patch.

I dared to merge this before without a review as it's simple (bad habit).
Generally, the best approach (which I not always follow) is to separate changes.
That's why I usually add docparse change as a separate commit. But I usually
update copyright with other changes (that's really minor change).

> Reviewed-by: Avinesh Kumar <akumar@suse.de>


Kind regards,
Petr


> Regards,
> Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
