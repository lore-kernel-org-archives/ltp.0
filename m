Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EE9C7EE23
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 12:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CC4C3CD8E4
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 14:56:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 238E63CB84B
 for <ltp@lists.linux.it>; Wed,  3 May 2023 14:56:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AA83C100055E
 for <ltp@lists.linux.it>; Wed,  3 May 2023 14:56:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0C9F2036D;
 Wed,  3 May 2023 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683118589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2St8AdzqCH/Y80Vez832bHvpB7qN7nJvUafy5BevCI=;
 b=pHBXicSASuaSwDq9ZnIpwAszcd9955iHOp4wJLhz9YVo+RI7GhWTiAfladE7tXz4ntx4P7
 zm+zCBcpjKYcrN9U7j7/YcVpBOeLrvu5FG+UTBuK3vIl7mPWqeBrYJaApnPY9l+cmvTDFR
 RXCEK2HfTNKw2yGlelxe6NpCd0xFDr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683118589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2St8AdzqCH/Y80Vez832bHvpB7qN7nJvUafy5BevCI=;
 b=riH7glAnGbKZ0sx8hQRvmJwRPQBlYD42zQn+sHXeKmd9X4ZxxUt4BSsL4nF/PRRtBhoxu4
 091/pAs3FakEaUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CB3913584;
 Wed,  3 May 2023 12:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bQP2HP1ZUmTwDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 May 2023 12:56:29 +0000
Date: Wed, 3 May 2023 14:56:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230503125643.GA3734788@pevik>
References: <ZEjsKC6ESB1+mM0H@rei> <20230502143711.GA3665733@pevik>
 <ZFIp4Sulcy20GWkc@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFIp4Sulcy20GWkc@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

Hi Cyril, all,

> Hi!
> > * IMHO Martin's KVM patchset should be merged
> > https://patchwork.ozlabs.org/project/ltp/list/?series=351921&state=*

> Feel free to merge with my ack as long as it passes basic testsing.

I merged the first four patches, but the final patch (the test itself) has
warnings. I hope they are trivial enough to be fixed so that we can merge it.

https://lore.kernel.org/ltp/20230503124240.GA3738345@pevik/

> > * nfslock01.sh: Don't test on NFS v3 on TCP
> > https://patchwork.ozlabs.org/project/ltp/patch/20230502075921.3614794-1-pvorel@suse.cz/
> > => IMHO should go in to increase NFS tests stability

> The discussion around it sounds like this is a kernel problem after all.

Yes (kernel and rpcbind). I'd be for merging it, at least until the fix is
released and we can give hints for update. Will you please post your ack to the
patch?

> > * NFS: test on all filesystems
> > https://patchwork.ozlabs.org/project/ltp/list/?series=352840&state=*

> This is rather big change, is this important enough to get it in just
> before the git freeze?

Neil Brown asked me to cover more underlaying filesystems in NFS testing.
I'm about to send new version, which increases timeouts a bit.
I did test it quite a lot (and will do some more tests today) and believe I'd be
able to fix potential problems before release. I started to work on
TST_ALL_FILESYSTEMS for shell API a year ago, it got merged in September.
That's quite long time for quite simple change, that's why I'm a bit impatient
to postpone it yet for another release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
