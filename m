Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1161ECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 18:37:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 293503CA6E3
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 20:37:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CD783C1351
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 20:36:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D0B11000604
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 20:36:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59D011FADA;
 Tue, 30 Aug 2022 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661884604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35fBDWhQIzCOcdlAazXMnTcZfaOMT2EhjlYjYlRrs5o=;
 b=udh6JU4TJ6UlMF0tJPSgH8G4Ei1PntAvLc3VMEfFDgQqW+XhfGalgQfAh6QDzMfVbI8nve
 hLZfHvNcPkL16pL3mzEmAa6+bAtb9jlZRdpdipOEumcAXS/d2d0U2Pev4GJVR4SmE/xZGB
 WcAq1DpXzZbP13j6Pk/tU1gj2e6sA0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661884604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35fBDWhQIzCOcdlAazXMnTcZfaOMT2EhjlYjYlRrs5o=;
 b=Ko+uGuZ4lrgJDuN9LszZRvMVjNXh0Ay+7dnoV7JCzlKAFxoNIH00QU2morVzx+rpth5o5F
 SqL740M+PMmz37Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E97513ACF;
 Tue, 30 Aug 2022 18:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Zs0ZDrxYDmMuAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 30 Aug 2022 18:36:44 +0000
Date: Tue, 30 Aug 2022 20:38:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yw5ZM3y5VbHJ4lgQ@yuki>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-5-mdoucha@suse.cz> <Yw4p4Id3mouqao0+@yuki>
 <78c5ee4c-6100-94ea-e2de-38f16f0d2b0f@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <78c5ee4c-6100-94ea-e2de-38f16f0d2b0f@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/10] ioctl_sg01: Set unlimited max_runtime
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
> >> Test setup can take very long time depending on the amount of free RAM.
> >> Set unlimited max_runtime to avoid timeout issues.
> > 
> > I would rather go for large enough number e.g. 30 minutes than
> > unlimited as the unlimited runtime turns off the timeouts and such test
> > can run undefinitely.
> 
> Even setting max_runtime is an ugly hack here because the test itself is 
> nearly instant. The setup() function is what actually times out. But 
> there's currently no way to change the default 30 second timeout 
> allocated for setup() and cleanup(). It'd be much better if I could set 
> that setup() has unlimited timeout and the test itself is limited to 5 
> seconds.

I guess that we can add setup_max_runtime and cleanup_max_runtime
however I would still set the setup_max_runtime to a large but finite
value here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
