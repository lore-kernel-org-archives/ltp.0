Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09783ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 09:46:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62E2D3C98C8
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 11:46:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 297AD3C0475
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 11:46:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 353B2680E42
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 11:46:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0781FD10;
 Mon, 24 Oct 2022 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666604773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+6FO462wmepJ2syPTeFTxLQbdjavLbH9dQ+pMDZAis=;
 b=y8Yus2vNoM3Bx8bgJFI5BoRErnXi65kqn9ZUN+zgHlO+ZOTt3gmLcnMaGWvKQDdv0i2Cf+
 ZwzWsgu26PiB+wvcJEu9EAAcUXXuY+BY4LnX8OSyOpJDV4bIWGuuIYjYgUONlrbQciL2e/
 tXIfCmyVX5MOCRHlMdG2pz1P2wxiLJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666604773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+6FO462wmepJ2syPTeFTxLQbdjavLbH9dQ+pMDZAis=;
 b=zKKZDXpLQDCAaaKyqr02nBsTmzu3D0AfW16D9WhRO4J1ehGFiP39ZLRI3vMHs2zmKL2q7e
 GYPKbmTzBdwH3yCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08C1513A79;
 Mon, 24 Oct 2022 09:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PHliAOVeVmNsegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Oct 2022 09:46:13 +0000
Date: Mon, 24 Oct 2022 11:46:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <Y1Ze470vch74uGNg@pevik>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
 <Y1GWOPpb+Z8hwhQd@pevik> <Y1I6u1a7RAS1wmZL@pevik>
 <34c0ff56-bed3-ade3-4936-6c96ecb8501d@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34c0ff56-bed3-ade3-4936-6c96ecb8501d@daynix.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] ftp/ftp01: Use tst_net.sh
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Akihiko,

> Hi Petr,

> On 2022/10/21 15:22, Petr Vorel wrote:
> > Hi Akihiko,

> > I'm sorry I overlooked your message at v1
> > https://lore.kernel.org/ltp/9894db50-6319-a818-c995-3ba9ab102c4b@daynix.com/

> > I guess script expects $PASSWD to be set.
> > Also trying to follow the instruction, none of them (allowing root in
> > /etc/ftpusers or filling /root/.netrc with machine localhost) work for me:
> > https://github.com/linux-test-project/ltp/tree/master/testcases/network#ftp-and-telnet-setup

> > I suppose any ftpd implementation must be run on the remote server (localhost,
> > if tst_net.sh uses netns - the default or on remote host, if ssh is used).
> > Otherwise ftp command "user $RUSER $PASSWD" cannot work, right?

> > Although it should behave the same regardless netns or ssh is used,
> > how do you test v3, with ssh or with netns (the default)? Or both?

> Thanks for sharing your fork. I tried it with SSH, and I had to make the
> following modifications to run it correctly:
> - I had to restore commented out "cd $TST_NET_DATAROOT".
Ack, this is correct.
> - I had to change the arguments of test_get and test_put back to "binary"
> and "ascii".
>   It is used to set the transfer mode (search for "echo $1").
Ah, I'm sorry I overlooked this. This could be solved with passing it as a first
parameter and shift, but I'll stop to be picky on an implementation detail.

> > It'd be nice if there was connection detection in the setup and tst_brk TCONF if
> > login does not work. The best would be to have configuration in the setup() +
> > cleanup in the cleanup()).

> > There are tests, which do vsftpd configuration: ftp-download-stress.sh,
> > ftp-upload-stress.sh.

> > BTW in the past we seriously considered to delete these highlevel smoke tests.
> > LTP is concentrated to test kernel API and internals, thus we didn't see much
> > value with smoke tests like this (that's why they haven't been rewritten to use
> > new API), specially if they require complex setup and get false positives when
> > SUT not configured properly. That's why it'd be nice to at least TCONF (if not
> > doing whole setup).

> I just modified this test because it is annoying to set up rsh just to fix
> this test so I would rather not put more effort for further improvement.
Understand, ack. Thanks for your work!

> Personally I don't object to remove this test either.
The fastest solution is to merge your fixed version.
But there should be even more modifications:
RHOST is obsolete, instead $(tst_ipaddr rhost) should be used.

Therefore we should decide if this smoke test (and other FTP tests in LTP) is
worth effort. If yes, I should force myself to create ftp_lib.sh and migrate
everything to work similar way as ftp-upload-stress.sh.

Kind regards,
Petr

> Regards,
> Akihiko Odaki


> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
