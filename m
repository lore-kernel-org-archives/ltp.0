Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFBBEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 09:01:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32ED13CE0FE
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 11:01:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A268C3CA861
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:01:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C40E60075C
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:01:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC25A21898;
 Tue, 20 Jun 2023 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687251691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xDt/xafRlgB79ZI0k28Z9+wb0XN4qnj7tzzcfjH+9fQ=;
 b=2R/NYg48xirweXeiqymhKx7Oy5FYslNycL3swNLjVOgMxS4EyNxBRxKEO30pPBENlYWiqn
 T1/rthr+m0zfJmS52rQ6KWKul4MlclWYaI2FvxpHc1sUMrPrGI79a1YETFIjUltee33c+E
 n9vnK1QfBcdNhig7ufm1ddRT1HkLOfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687251691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xDt/xafRlgB79ZI0k28Z9+wb0XN4qnj7tzzcfjH+9fQ=;
 b=LPra32xDtISeiNAAP2u9Z3eGF21JNJMGdO2LxtsmuaL40sMrBkUATramtC2j0tWA7Z3o6v
 Yrs8XX3+T7KmFeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A084F133A9;
 Tue, 20 Jun 2023 09:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QBUtJetqkWQMLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 09:01:31 +0000
Date: Tue, 20 Jun 2023 11:01:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230620090130.GA275381@pevik>
References: <20230607144517.24972-1-mdoucha@suse.cz>
 <20230620082442.GA270877@pevik>
 <666f5cd5-5f03-95b3-0b33-6e104fd58744@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <666f5cd5-5f03-95b3-0b33-6e104fd58744@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/madvise11: Ignore unpoison failure under
 kernel lockdown
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

> On 20. 06. 23 10:24, Petr Vorel wrote:
> > Hi Martin,

> > ...
> > > -	return SAFE_OPEN(debugfs_fp, O_WRONLY);
> > > +	TEST(open(debugfs_fp, O_WRONLY));
> > > +
> > > +	if (TST_RET == -1 && TST_ERR == EPERM && tst_lockdown_enabled()) {
> > > +		tst_res(TINFO,
> > > +			"Cannot restore soft-offlined memory due to lockdown");
> > > +		return TST_RET;
> > > +	}
> > > +
> > > +	if (TST_RET == -1)
> > > +		tst_brk(TBROK | TTERRNO, "open(%s) failed", debugfs_fp);
> > > +	else if (TST_RET < 0)
> > > +		tst_brk(TBROK | TTERRNO, "Invalid open() return value");
> > nit: I'd print the return value as we do in safe_open():
> > 		tst_brk(TBROK | TTERRNO, "Invalid open() return value %d", TST_RET);

> Good point. Though TST_RET is long int so it should be %ld. Should I send a
> v2?

Yes, please.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
