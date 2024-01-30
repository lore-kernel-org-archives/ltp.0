Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33134C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B12363CF97A
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:31:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 641A93CB948
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:31:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A73A86029F1
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:31:28 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2CE922195;
 Tue, 30 Jan 2024 12:31:27 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C998713212;
 Tue, 30 Jan 2024 12:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id To5dLx/suGVrHQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 12:31:27 +0000
Date: Tue, 30 Jan 2024 13:31:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240130123126.GA778733@pevik>
References: <20240117173006.31521-1-mdoucha@suse.cz>
 <20240117173006.31521-2-mdoucha@suse.cz>
 <20240130112953.GB753541@pevik>
 <d05e5314-05c1-448a-9cbf-9e8a98a4dc55@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d05e5314-05c1-448a-9cbf-9e8a98a4dc55@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: F2CE922195
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for ASLRn't bug
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

> On 30. 01. 24 12:29, Petr Vorel wrote:
> > Hi Martin,

> > Very nice work.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > ...
> > > +++ b/runtest/kernel_misc
> > > @@ -15,3 +15,4 @@ zram01 zram01.sh
> > >   zram02 zram02.sh
> > >   zram03 zram03
> > >   umip_basic_test umip_basic_test
> > > +aslr01 aslr01

> > I wonder, don't we want to run also with strict mode?
> > Do you want to avoid failure:
> > aslr01.c:241: TFAIL: Large lib base address has less than 28 random bits

> The distro developers' decision so far seems to be to mitigate the issue by
> increasing ASLR random bit count to maximum instead of fixing the bug.
> That's enough to make the test pass in normal mode but strict mode will keep
> failing, possibly forever.

Thanks for info!

I'll wait little longer before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
