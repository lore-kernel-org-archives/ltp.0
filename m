Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697A9C433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 14:52:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C4243CAA04
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 16:51:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C54DE3C1014
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 16:51:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C4782009A8
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 16:51:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3D9F21954;
 Fri, 30 Sep 2022 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664549509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYIL/Fvm62UcDvrwPoalIyaFQxPnF28wNy6in27uYuU=;
 b=MOtuOaDzRjjmPJ2nA+c6Fi7LMfNgFKDMgyYooRLx5//ksQ6bHEdPPqqGl9jj4lddCPLvMO
 guK8o2OeHqnDfhNe7/0cyNJ0cz4FnnZqmCzHNUvrbcNUNGcBNwB2CjWTqxv7cckRPPVn8y
 9Up/SyhnzAaP03yqqH1bY0iVjt9LCq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664549509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rYIL/Fvm62UcDvrwPoalIyaFQxPnF28wNy6in27uYuU=;
 b=UsXCKuwCDU6qNh7u39wEy+SQ0hYKlxcNLsa5e2DxmeyNbFbU9W4KcQUz0kg2G6qViBGLho
 PfYz5kVvFmDkmIDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A99F13677;
 Fri, 30 Sep 2022 14:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h7UEIIQCN2M0YwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 14:51:48 +0000
Date: Fri, 30 Sep 2022 16:51:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YzcCgVovivI+lAPy@pevik>
References: <20220930112434.13038-1-pvorel@suse.cz> <YzbV5JFPNNoVmqth@yuki>
 <YzbbgS6O0vBPUXbp@pevik> <Yzb87NdckmwzQiWN@pevik>
 <Yzb/WiPvCDvv8A36@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yzb/WiPvCDvv8A36@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Fix missing cleanup run from
 setup
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
> > > I rerun whole LTP tests on 3 SLES versions, most of the shell tests on
> > > Tumbleweed, I'll also try some shell tests on some Debian version.
> > > Also CI passed (which runs make test-shell), + I run make test-shell manually
> > > (covers more than CI), but that's not that relevant as we don't cover much.

> > Tests results looks ok, looked into the output (not just the exit code),
> > thus I merged this. This should be the last commit, we can tag the release and
> > the rest of the release process.

> Sounds good to me. Feel free to tag the git, you signed for generating
> and uploading the tarballs anyway. I'm preparing release notes and send
> them once tarballs are uploaded on github.

Hi Cyril,

Right, LTP version updated and tagged, both with my GPG sign.
https://github.com/linux-test-project/ltp/commit/b763f81998f19f783982d3937d1fd05bcf649c16

I generated LTP 20220930 release:
https://github.com/linux-test-project/ltp/releases/tag/20220930

Please send release notes, I'll add them to the releases page in github.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
