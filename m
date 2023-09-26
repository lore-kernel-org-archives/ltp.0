Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF32CE7E63C
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 14:23:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87E943CDC8D
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 16:23:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CB923C9981
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 16:23:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6AB701A010D6
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 16:23:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A27F41F889;
 Tue, 26 Sep 2023 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695738188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFZBCTjeTbxClbz2y9ZWIDdbvQG2DMcoQ/Z0NBMEyUU=;
 b=xyP6FbY8kNO3JHVE4JPU6/4xqVZu+MSjZfDWsdKDIuuY7GSNdo5NNr0JBXIYpQS1Y6DbKT
 SeyIw7SvHfBsJRpLL2iOMHwC/bUNJvOm8wtW0MLD9gwpspMUJLguh52hAq206nlyGQXcGL
 nd5RhRvMyL8lCyF/iISEwDA+qlug6/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695738188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFZBCTjeTbxClbz2y9ZWIDdbvQG2DMcoQ/Z0NBMEyUU=;
 b=vBgO1QZBw8c5FAhe+Eq7nSGkrlumdZ8RoRzS2LNMAAie/5Mj4sPFmZ/z7PmsiqX4DZMbRE
 rW6wcS3n0xalJhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9007D1390B;
 Tue, 26 Sep 2023 14:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4nDVIUzpEmWzVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Sep 2023 14:23:08 +0000
Date: Tue, 26 Sep 2023 16:23:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZRLpdxsuOwPabRTG@yuki>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz> <ZRLLL_h8V8rk-H3T@yuki>
 <20230926135456.GD159673@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230926135456.GD159673@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] doc: Update release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > >  * lwn at lwn.net
> > >  * akpm at linux-foundation.org
> > > -* torvalds at linux-foundation.org.
> Are these mails complete? I would at least add automated-testing@lists.yoctoproject.org.

These are actually emails that we inherited from times 10 years ago,
nobody who gets these emails haven't complained yet, so it stays that
way.

I guess that a proper solution may be having a ltp-release mailing list
so that people can subscribe themselves, on the other way this may be
overkill.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
