Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68641C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 14:44:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A1213C875F
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:44:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C42183C7E58
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:44:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C44F9140099D
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:44:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFB201F38F;
 Mon, 24 Jan 2022 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643035445;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5hWZd1n8BDf6D7MnPHpqS14Bg9OWiOhXnibK/kkkKA=;
 b=oTJ7HTZOlv6ZxSPMigQjZAUqGP7lechKFk/K6eADvXjYM9UjrDRfPhjGFK5MlealvI+jNC
 VXE4ATp9hp2Dn5Aj+21klbWSp7fiUB25tGWPFZL03pSDBauNw9fvggHqEXGbIn5opb+3+L
 7ziuD0DFvfVmXdVxtmcSJhgVuhaIaxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643035445;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5hWZd1n8BDf6D7MnPHpqS14Bg9OWiOhXnibK/kkkKA=;
 b=5YFVSdaTmIw+0lqHq2JLCx1WnItUukhzz04aO2lQtKCTkAkrylwa2INEnyejfm1zGBJfQE
 OyBlD88x/tY0wZCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B637213BA5;
 Mon, 24 Jan 2022 14:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Px0vKzW77mHBAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 14:44:05 +0000
Date: Mon, 24 Jan 2022 15:44:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>, ltp@lists.linux.it
Message-ID: <Ye67NAYQaz0NS6v/@pevik>
References: <1545987769-32388-1-git-send-email-lijinyue@huawei.com>
 <20190313115844.GB2606@dell5510> <87czn8qpkd.fsf@suse.de>
 <YYupzZpiGXDNwrus@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYupzZpiGXDNwrus@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset: add cpuset files check for
 different OS
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Richie, Li,

> > Hello,

> > Petr Vorel <pvorel@suse.cz> writes:

> > > Hi Li,

> > >> While mounting cpuset cgroup, the subsystem directory entries
> > >> differ in different OS release.
> > >> eg, cpuset.cpus file on Ubuntu and cpus on some other release.
> > > Which ones, please? I'm not aware of anyone.

> > Unfortunately it is possible. cpuset can be mounted without a prefix
> > using a legacy compatability option. OTOH this is really ancient.

> Thanks for info.


> > >> So we add cpuset files checker to make sure the test work well
> > >> on all OS release.

> > > ...
> > >> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> > > ...
> > >> +cpus_file=
> > >> +cpu_exclusive_file=
> > >> +mems_file=
> > >> +memory_pressure_file=
> > >> +memory_pressure_enabled_file=
> > >> +mem_exclusive_file=
> > >> +mem_hardwall_file=
> > >> +memory_migrate_file=
> > >> +memory_spread_page_file=
> > >> +memory_spread_slab_file=
> > >> +sched_load_balance_file=
> > >> +sched_relax_domain_level_file=
> > > Maybe move the ones in $CPUSET/cpuset.cpus clause here as the default ones
> > > and move those from else clause into setup.

> > > ...
> > >> +# check cpuset cgroup files for different OS
> > >> +cpuset_files_check()
> > >> +{
> > >> +	setup
> > > I guess this should be vice versa, i.e. cpuset_files_check() be part of setup()
> > > And then not needed to be added into all functions using cpuset_funcs.sh

> > Probably we could just do

> > if [ -f $CPUSET/cpuset.cpus" ]; then
> >    cpuset_prefix="cpuset."
> > else
> >    cpuset_prefix=
> > fi

> > then replace cpuset. with $cpuset_prefix

> +1, just maybe tiny improvement to remove else part:

> cpuset_prefix=
> if [ -f $CPUSET/cpuset.cpus" ]; then
> 	cpuset_prefix="cpuset."
> fi

Would you mind to send v2 with code suggested by Richie?

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
