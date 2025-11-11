Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BADCCCFA18
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 15:59:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B201C3CF685
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 16:59:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B543E3CE4B0
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 16:58:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36224600A1B
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 16:58:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91DA91F78F;
 Tue, 11 Nov 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BE0814A32;
 Tue, 11 Nov 2025 15:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QL2VETpdE2n0dgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Nov 2025 15:58:50 +0000
Date: Tue, 11 Nov 2025 16:58:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251111155848.GC61698@pevik>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-4-pvorel@suse.cz>
 <aRM09edcL-6OyfPk@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRM09edcL-6OyfPk@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 91DA91F78F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] swapon03: Try to swapon() as many files
 until it fails
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> >  	is_swap_supported(TEST_FILE);
> > +
> > +	swapfiles = SAFE_MMAP(NULL, sizeof(*swapfiles), PROT_READ | PROT_WRITE,
> > +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > +	*swapfiles = 0;
> > +
> >  	setup_swap();
> >  }

> >  static void cleanup(void)
> >  {
> > -	clean_swap();
> > +	if (swapfiles) {
> > +		clean_swap();
> > +		SAFE_MUNMAP(swapfiles, sizeof(*swapfiles));
> > +	}
> >  }

First, thank you for your review!

> This gets complicated for no good reason since we run the setup code in the
> child.

If swapfiles is not mapped for some reason (can happen or "*swapfiles = 0" is
not run (that should not happen), then using *swapfiles leads to segfault.

*swapfiles is being used not only in SAFE_MUNMAP() here in cleanup(), but
also in clean_swap().

Also, this saves trying to deactivate swap files if they weren't activated.

And, unless "swapon03: Remove grep dependency" (the last commit) is accepted,
there is a corner case I found during debugging:

# ./swapon03 # quit early with ctrl+C => some swap partitions are left not being swapped off
...
Sending SIGKILL to test process...
tst_test.c:1909: TINFO: Killed the leftover descendant processes
tst_test.c:1918: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1920: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  1...
tst_device.c:421: TINFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  2...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  3...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  4...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  5...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  6...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  7...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  8...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  9...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try 10...

Then following run tries to swapoff() partition left from previous run.

# ./swapon03
...
swapon03.c:80: TWARN: Failed to swapoff mntpoint/testswap

But the last commit fixes this problem.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
