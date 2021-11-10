Return-Path: <SRS0=1g5g=P5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB9C433EF
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 11:15:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB2D61055
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 11:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEB2D61055
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02AD73C1B7B
	for <ltp@archiver.kernel.org>; Wed, 10 Nov 2021 12:15:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B57F3C074D
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 12:15:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7517E100118A
 for <ltp@lists.linux.it>; Wed, 10 Nov 2021 12:15:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4BD81FD6B;
 Wed, 10 Nov 2021 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636542927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2m99KWGX+WmbIFHtNHMWkWC9M7EF4+ZxUjmI/SiMz74=;
 b=Rz5ek2BfALzHC29wMhfWgANVqs81gUBnMOND/vEayrirCsKJo+rEyzGsLkS7ojzFY2M/i5
 RGH7Q/C+pCS2YDNvMWOls9SHgn+krel45BDItDn0Yxmw6Na50NpSrZF9ltifbQNmH8HOjf
 eBqEPZ/Su9a5uBkghxZBVS/d6z6taug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636542927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2m99KWGX+WmbIFHtNHMWkWC9M7EF4+ZxUjmI/SiMz74=;
 b=4UMIqH+c8ZmVh6TRMY/g/E5hb3MnqCHpvdrZG1TW7bUVnPlqr3nvAO46KvhMLIEn3ejDD+
 g/lBitNWW4ugESDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7168C13BAC;
 Wed, 10 Nov 2021 11:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SlVoGc+pi2EtUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 10 Nov 2021 11:15:27 +0000
Date: Wed, 10 Nov 2021 12:15:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YYupzZpiGXDNwrus@pevik>
References: <1545987769-32388-1-git-send-email-lijinyue@huawei.com>
 <20190313115844.GB2606@dell5510> <87czn8qpkd.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87czn8qpkd.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, Li,

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Li,

> >> While mounting cpuset cgroup, the subsystem directory entries
> >> differ in different OS release.
> >> eg, cpuset.cpus file on Ubuntu and cpus on some other release.
> > Which ones, please? I'm not aware of anyone.

> Unfortunately it is possible. cpuset can be mounted without a prefix
> using a legacy compatability option. OTOH this is really ancient.

Thanks for info.


> >> So we add cpuset files checker to make sure the test work well
> >> on all OS release.

> > ...
> >> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> > ...
> >> +cpus_file=
> >> +cpu_exclusive_file=
> >> +mems_file=
> >> +memory_pressure_file=
> >> +memory_pressure_enabled_file=
> >> +mem_exclusive_file=
> >> +mem_hardwall_file=
> >> +memory_migrate_file=
> >> +memory_spread_page_file=
> >> +memory_spread_slab_file=
> >> +sched_load_balance_file=
> >> +sched_relax_domain_level_file=
> > Maybe move the ones in $CPUSET/cpuset.cpus clause here as the default ones
> > and move those from else clause into setup.

> > ...
> >> +# check cpuset cgroup files for different OS
> >> +cpuset_files_check()
> >> +{
> >> +	setup
> > I guess this should be vice versa, i.e. cpuset_files_check() be part of setup()
> > And then not needed to be added into all functions using cpuset_funcs.sh

> Probably we could just do

> if [ -f $CPUSET/cpuset.cpus" ]; then
>    cpuset_prefix="cpuset."
> else
>    cpuset_prefix=
> fi

> then replace cpuset. with $cpuset_prefix

+1, just maybe tiny improvement to remove else part:

cpuset_prefix=
if [ -f $CPUSET/cpuset.cpus" ]; then
	cpuset_prefix="cpuset."
fi

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
