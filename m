Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A099BC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 12:03:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDAE33C8CC7
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 13:03:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA1143C7FE1
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 13:03:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B2B9560064D
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 13:03:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D450210F3;
 Tue, 22 Mar 2022 12:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647950588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0CvNmhv1fMBMfM3ulC780zC2rgtN4ApRTX4SOI4NbDA=;
 b=IlCH4dNszl3KJ7b+YSR5+B6gmRjLgl8BfHAR+b/3H4Mw8v//+lb0mNyF1cjNdhDSkQcQq1
 HsfhUSF8QE86LZH6xgdWNJbdww1g6Xi1e5H7D5a5HITSWm7Dtmz9mV5LnF41or1ihyT87O
 2DWlrtwS4gLHyVDYcwPl8Lb6rLboT0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647950588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0CvNmhv1fMBMfM3ulC780zC2rgtN4ApRTX4SOI4NbDA=;
 b=r5mvOrP34eMTW8Ie3BCCF45QmY15WW6nZcfaA15rtlml+jgn8YXVoTzoClSX5jZmUQDOp3
 /zz/REQAgsOe3wCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A0FC12FC5;
 Tue, 22 Mar 2022 12:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WmVsHPy6OWLjWQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Mar 2022 12:03:08 +0000
Date: Tue, 22 Mar 2022 13:05:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Yjm7hbXdZWv627ps@yuki>
References: <20220311095101.10112-1-chrubis@suse.cz>
 <8378e9dd-31a5-b39e-36cc-f3d3a1d41345@suse.cz>
 <YisfIWsrgxVt8xc2@yuki> <875yo6cr1f.fsf@suse.de>
 <YjmYJ5yukrrgCNYW@yuki> <871qyucixk.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871qyucixk.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty/pty07: Restore active console after the
 testrun
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Applied with the change requested by Martin.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
