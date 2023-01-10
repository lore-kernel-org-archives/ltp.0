Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94BCC54EBC
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 16:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ED4E3CCB20
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 17:04:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC1CD3CB57B
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 17:04:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 62E2E1400455
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 17:04:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F54B6030A;
 Tue, 10 Jan 2023 16:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673366658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4a6uDH1mbFlKFWyTi31LgHzZ+UaAdWyYWX7GEX36GA=;
 b=QmZuDnqillVv5ek7mKEZ9BsekZ7g1ye2ZtJx00HatI0aY476wvZLoXgnXXvqI5E5rqTFX8
 8oAg9YeNl30eGZwC6EGwqYCw8NLFLN7JE5zQSACsc3QV++yVR38TFge9JNFXUDA0w0sOoI
 zCQC6MhJaAketF5uIdgelrO5j6mtEP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673366658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4a6uDH1mbFlKFWyTi31LgHzZ+UaAdWyYWX7GEX36GA=;
 b=Ptbt1ujnHbztp5pCWZsGNPu7sFGDN0BkkVwPLC7gx2UY0mKzxYb2ekgmltdLxiGRt2y9iw
 EGyrGLe0ksaXyGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA9D613338;
 Tue, 10 Jan 2023 16:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YWYAJoGMvWPkFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 Jan 2023 16:04:17 +0000
Date: Tue, 10 Jan 2023 17:04:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y72MfwHOkeag4NIw@pevik>
References: <20230104100730.20425-1-pvorel@suse.cz>
 <2226132.28uSQYClPH@localhost> <874jsyiufl.fsf@suse.de>
 <Y709W2qjGVFqvnvU@pevik> <87v8lehdpe.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v8lehdpe.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] github: Improve pull request template
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

Hi Richie, Avinesh,

> > thanks for your review.
> >> Hello,

> >> Please merge.
> > Before merge, are you ok with one more change?

> Yes, although


> > Kind regards,
> > Petr

> > +++ .github/pull_request_template.md
> > @@ -9,6 +9,11 @@ We also have a patchwork instance: https://patchwork.ozlabs.org/project/ltp/list
> >  * Commits should be signed: Signed-off-by: Your Name <me@example.org>, see
> >  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> > +* Commit message should be meaningful, following common style
> > +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes
> > +https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> > +https://chris.beams.io/posts/git-commit/

> This redirects to https://cbea.ms/git-commit/.

Thank you both for additional review, I merged with the redirected URL.
If not stable in the future, we can always deleted it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
