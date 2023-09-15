Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1441EE6459
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F0CD3CE6C3
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 13:51:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3BD43CBF28
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:50:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 34D0F2379BB
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:50:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8AE4B1F854;
 Fri, 15 Sep 2023 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694778652;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QwweKUjEtn6inzBUJIRlrAbPkbbheQxWOiEMqJAGS6Q=;
 b=0cnyDQBRNVAIt63Ia37HZAd8uxc4Zx2Zj2VCE5hNmeDvTCT8zzneM+hqNImnZ/xkyMCFJL
 tH1FASi+ku7MwBt4LtPRIyVB3o4nORs/Vxzo9gFv/t3R1fEWu6HQlUUaC26rLufjtwlvTQ
 3ArvkdMiWA2JuM8/LRL76jEfvdTnALU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694778652;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QwweKUjEtn6inzBUJIRlrAbPkbbheQxWOiEMqJAGS6Q=;
 b=SyBvOi8ODEwyUzuE9UB6/4C2c21a3Nr7wr/rh1VsPgUndXsCVZCg70M3zX8fBCkHnYr2yj
 pMt0lXpZlHgzM3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C0FB13251;
 Fri, 15 Sep 2023 11:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /kZhAxxFBGWELQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 11:50:52 +0000
Date: Fri, 15 Sep 2023 13:50:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20230915115050.GA18941@pevik>
References: <20230915091547.26270-1-andrea.cervesato@suse.de>
 <ZQQ4ax1A2ZkFNwIH@yuki> <20230915111924.GB46324@pevik>
 <cbfb41c4-9ec5-494d-9b86-1e67d7e16703@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cbfb41c4-9ec5-494d-9b86-1e67d7e16703@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Replace runltp-ng with kirk framework
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

> Hi,

> On 9/15/23 13:19, Petr Vorel wrote:
> > Hi Cyril, Andrea,

> > > Hi!
> > > > Kirk application is a fork of runltp-ng and it aims to merge multiple
> > > > Linux testing frameworks in one tool, providing support for remote
> > > > testing via Qemu, SSH, LTX, parallel execution and much more.
> > > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > > ---
> > > >   .gitmodules     | 6 +++---
> > > >   tools/kirk      | 1 +
> > > >   tools/runltp-ng | 1 -
> > > Do we also want symlink from runltp-ng to kirk?
> > +1

> > BTW I suggested Andrea in the beginning of kirk to have runltp-ng symlink,
> > which would behave like 'kirk --framework ltp'. I.e. this:

> > ./kirk --framework ltp --run-suite syscalls

> > would be equivalent of

> > ./runltp-ng --run-suite syscalls

> > Instead of having to run:
> > ./runltp-ng --framework ltp --run-suite syscalls

> > In that case kirk would be a drop in replacement.
> > Andrea, would it be possible to implement this functionality?
> > (the default framework could be detected by symlink name, the same approach
> > busybox uses, more symlinks could be added).

> > Kind regards,
> > Petr

> The default kirk behavior is to use '--framework ltp' by default, so there's
> no difference between

> ./kirk --framework ltp --run-suite syscalls

> and

> ./kirk --run-suite syscalls

Great, then OK from my side. With adding the symlink:
Reviewed-by: Petr Vorel <pvorel@suse.cz>
(please send v2).

I'm for replacing runltp-ng with kirk before the release.
I guess Cyril will highlight it in the changelog and then we should replace all
files in the runltp-ng repo with simple README.md, which points to kirk git
repo.

I'd still recommend to implement the default framework functionality (kselftest
and liburing would benefit from it), but that can be added later.

Kind regards,
Petr

> Regards,
> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
