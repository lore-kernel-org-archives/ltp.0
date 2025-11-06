Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5063CCFA03
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 13:31:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 986A73C3264
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 14:31:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC50D3C3264
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 14:31:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2FA781A00A2C
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 14:31:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 111961F6E6;
 Thu,  6 Nov 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 013FC139A9;
 Thu,  6 Nov 2025 13:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KbVeOzSjDGkDDAAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 06 Nov 2025 13:31:32 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 06 Nov 2025 14:31:32 +0100
Message-ID: <3388220.aeNJFYEL58@thinkpad>
In-Reply-To: <20251106120357.GA1013980@pevik>
References: <20251105154716.995786-1-pvorel@suse.cz>
 <2396783.ElGaqSPkdT@thinkpad> <20251106120357.GA1013980@pevik>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 111961F6E6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon03: Try to swapon() as many files until
 it fails
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > > +
> > > +	if (expected_swapfiles < 0) {
> > do we want to proceed when expected_swapfiles is 0 here?
> 
> Yes, because NUM_SWAP_FILES is 15, which is safe for the changes.
> I.e. on my Tumbleweed VM it can be 23 swaps. One is used as filesystem
> partition, therefore it would work on even 22.
Understood, thanks!


> > > -			/* turn on the swap file */
> > > -			TST_EXP_PASS_SILENT(swapon(filename, 0));
> > > +			/* Quit on a first swap file over max */
> > > +			if (swapon(filename, 0) == -1)
> > so now first swapon() fail is here and then we check for errno==EPERM by
> > making another swapon() call in verify_swapon function.
> > Is it possible to combine setup_swap() and verify_swapon() and check for
> > EPERM on first swapon() fail itself?
> 
> I was thinking about it as well. To support -i, we still need to have setup run
> only once. Moving code from setup to test function would require to run "setup"
> part only once (guard with static variable).
> 
> Other option would be to keep setup, but test errno also here (i.e. test it twice).
> I'm not sure which one is less awkward.
ok, I forgot about more iterations scenario.

Reviewed-by: Avinesh Kumar <akumar@suse.de>
(for all patches in the series)

Regards,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
