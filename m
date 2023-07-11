Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1697AEB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 11:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36D83CB948
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 13:09:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02CB73C99FC
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:09:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 364EF10007C1
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:09:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C54D51FD70;
 Tue, 11 Jul 2023 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689073773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qP8iJoEwrM9nE3xg2GFqORLU+GRDpdupi033QOUfm6A=;
 b=bLGZlk6gyYoBr1cjmsnjBW/s2M1icDS9mYcFQ/GQ1TF5f8uU7vD6ufO7WbWoWCu9Y8z498
 tzxoV2gllZOPyzDoKrbgIr2hVJsUSAFXZWBqAg1daolUF7lmNht77UUL5vn9nEu7xyL0Db
 1VGXf7VC6rRi2sTng6Bc3jGTJQThfN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689073773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qP8iJoEwrM9nE3xg2GFqORLU+GRDpdupi033QOUfm6A=;
 b=gyWEDkGPcs9CVAJQ31frl2m/0Cx0lnjlemGY1BLbLNRYtvGgZOZXXF7ZYo7WObzZiGCvLA
 PpM0MpLqP1NvpJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E8C61390F;
 Tue, 11 Jul 2023 11:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5yd0JW04rWRrEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Jul 2023 11:09:33 +0000
Date: Tue, 11 Jul 2023 13:09:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230711110927.GA722516@pevik>
References: <20230510124206.19627-1-andrea.cervesato@suse.de>
 <20230510124206.19627-4-andrea.cervesato@suse.de>
 <ZGt_GrwbwPJChf6P@yuki>
 <ead18659-fb0a-cef1-2514-b344e12d8b40@suse.com>
 <ZKvpXS_nPNsco63i@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKvpXS_nPNsco63i@rei>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/6] Refactor mqns_03 using new LTP API
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

> Hi!
> > > I do not think that we need atomicity here, the cleanup code does not
> > > run concurently at all as the cleanup in the parent is triggered after
> > > the child did exit. I suppose that instead we need to set the mq_freed
> > > to be volatile because it's shared memory which may change at any
> > > change, so we need to tell that to the compiler.
> > That's fine, but I followed suggestions in the reviews. I think that 
> > having 3 people reviewing the same patch doesn't help the development 
> > process. Now I'm not sure who I should follow :-)

> It's actually the other way around, the more people look at the code the
> better, at least that way we have potential to catch more problems
> earlier. And if the reviewers disagree, let them fight for the right
> answer.

+1

Kind regards,
Petr

> I think that in this case this all can be actually simplified and we can
> get rid of the mq_freed flag as I tried to outline below.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
