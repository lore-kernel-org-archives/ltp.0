Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA2DC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 06:45:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 557483C9EE1
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:45:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 099BC3C5446
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:45:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 32492100047A
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 07:45:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B31C21138;
 Fri, 11 Feb 2022 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644561905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dyae/gFO3JOi8mUdpDQDLLPmsjCimb77YeR6lvlNIMg=;
 b=rbs8yLb+YS6RgNJI5IdBVq6a2bm4e8RYHQsMb2WYR1hgsODdpkBMamScCkaPf3oqqJu1di
 i002TS6kLSqbdaZ90E0JC0mQQozY7ZfHim9bkEsUAKT7C7Jo/5D+R2ZauymfNFjAtqeuUb
 r6mScZPkQX8zTvqNbF52bru1XNTKXr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644561905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dyae/gFO3JOi8mUdpDQDLLPmsjCimb77YeR6lvlNIMg=;
 b=+BJYvHcbpNCes8su+YRqGQ1dW/8SzrNbOM8Rx2ilLZq8U5s9Be76D2B0bj+TaOgaguR42o
 /0Sj0OBNozoJYlAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D11D413345;
 Fri, 11 Feb 2022 06:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mvq0MfAFBmL2UQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Feb 2022 06:45:04 +0000
Date: Fri, 11 Feb 2022 07:44:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YgYF6AHb6XLMX3+2@pevik>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-6-pvorel@suse.cz>
 <6205F185.5080603@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6205F185.5080603@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/6] shell: Add test for TST_FORMAT_DEVICE=1
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> >   lib/newlib_tests/shell/tst_format_device.sh | 24 +++++++++++++++++++++
...
> > +TST_FORMAT_DEVICE=1
> > +TST_TESTFUNC=test
> > +TST_CNT=2
> > +TST_DEV_FS_OPTS="-b 1024 -O quota"
> > +TST_DEV_EXTRA_OPTS="5m"
> > +TST_NEEDS_CMDS="df lsblk"
This is left over from previous versions => should be deleted.
> > +. tst_test.sh
> > +
> > +test1()
> > +{
> > +	tst_res TPASS "device formatted"
> > +}
> > +
> > +test2()
> > +{
> > +	tst_check_cmds df || return
> We have checked df command in TST_NEEDS_CMDS, why still check it again
> in here?
Correct, TST_NEEDS_CMDS should be removed so that at least creating the device
(test1) is supported even SUT is missing df.

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
