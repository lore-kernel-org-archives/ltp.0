Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7640CC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 15:09:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3EE63CE946
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:09:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBCFE3CA488
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:09:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2510120023D
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 16:09:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3CAC02187A;
 Fri,  3 Nov 2023 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699024140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTAxE8fZsC0TIFFs4xrf+a7vfm4EFjGphD4oGhaCM/4=;
 b=d8N5qwqKwrp/lyX/EC6HlsTAWBq2FIOHwdw2QGkavy7EK80QJKG+s5R1fmc+19g4fge5mA
 VBM836rqWn9aUnTk2HWi1GIcqS30vlPw7OIJrC0dD0BB4cGXVtYrxob5JT6qurlqkunH+V
 ZHjmzBAC+loKrx4PwJrlJvHXH0MswoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699024140;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTAxE8fZsC0TIFFs4xrf+a7vfm4EFjGphD4oGhaCM/4=;
 b=NBoxV3RU1F+ONBj/9HzdhNxH7lcmdeXAj3Kfee+/O+E0ejS1RwAdlRWP4/x2MU9D3iFM30
 4LAYcxEHqQMiihAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13E7A1348C;
 Fri,  3 Nov 2023 15:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sVuJAwwNRWUkJgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 15:09:00 +0000
Date: Fri, 3 Nov 2023 16:08:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231103150858.GB1084358@pevik>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-5-pvorel@suse.cz> <87il6kse1z.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87il6kse1z.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] can_bcm01: Move vcan to .modprobe
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

Hi Richie,

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

...
> >  testcases/network/can/cve/can_bcm01.c | 19 ++++++++++---------
> >  	addr.can_ifindex = NETDEV_INDEX_BY_NAME(LTP_DEVICE);
> > @@ -143,10 +135,19 @@ static struct tst_test test = {
> >  	.skip_in_compat = 1,
> >  	.max_runtime = 30,
> >  	.needs_drivers = (const char *const[]) {
> > -		"vcan",
> >  		"can-bcm",
> >  		NULL
> >  	},
> > +	/*
> > +	 * Older kernels require explicit modprobe of vcan. Newer kernels
> > +	 * will load the modules automatically and support CAN in network
> > +	 * namespace which would eliminate the need for running the test
> > +	 * with root privileges.
> > +	 */

> This comment is wrong and can be removed. It also (or only?) depends on
> kernel config whether modules are loaded automatically. It is a security
> feature to remove automatic modprobe. IDK if older kernels lacked auto
> module loading.

Yes, "blacklist foo" in /etc/modprobe.d/*.conf. Actually loading kernel modules
with modprobe will detect problems which checking with .needs_drivers or
.needs_kconfigs does not detect. e.g. the problems with missing modules on
openSUSE JeOS.

But as I wrote elsewhere [1], with explicit loading we don't test module
auto-loading. The approach we have now, that load modules only when needed is
IMHO better. But maybe I'm wrong.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20231103121201.GA1005170@pevik/

> > +	.modprobe = (const char *const[]) {
> > +		"vcan",
> > +		NULL
> > +	},
> >  	.tags = (const struct tst_tag[]) {
> >  		{"linux-git", "d5f9023fa61e"},
> >  		{"CVE", "2021-3609"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
