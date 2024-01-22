Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA749C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 06:23:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A79493CE228
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:23:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 485043C98F9
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:22:50 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A3FA20077F
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:22:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5B51FB6D;
 Mon, 22 Jan 2024 06:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705904568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESgi6ZLEp5NF7lqA2OV/9OdxLROCLvjCep3kRSYUlfE=;
 b=qbGO+F58QsMJCXdoyIQD7JhQtNiNP+3z1udb+WeLAv3NfSODUJPBkGrhZPy7lIQCpm3JqO
 rq9OklixdywzjeGbn0FfCPSdJxJoUTPQVP9jxT+hJMRp3X6ADOdgNfzq36u5dOIpzjA8QW
 j+y/hahjgU5i1W4HqqLSTevw85lBYFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705904568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESgi6ZLEp5NF7lqA2OV/9OdxLROCLvjCep3kRSYUlfE=;
 b=6tPfZS7Mgbr6QBj6LDR3dqGXfxX3o7OqiYd6ub0/6b1Qah3kafofZ0/f+pv3okY6dWdU2e
 a3TrlRNXCy9xTsAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705904568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESgi6ZLEp5NF7lqA2OV/9OdxLROCLvjCep3kRSYUlfE=;
 b=qbGO+F58QsMJCXdoyIQD7JhQtNiNP+3z1udb+WeLAv3NfSODUJPBkGrhZPy7lIQCpm3JqO
 rq9OklixdywzjeGbn0FfCPSdJxJoUTPQVP9jxT+hJMRp3X6ADOdgNfzq36u5dOIpzjA8QW
 j+y/hahjgU5i1W4HqqLSTevw85lBYFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705904568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESgi6ZLEp5NF7lqA2OV/9OdxLROCLvjCep3kRSYUlfE=;
 b=6tPfZS7Mgbr6QBj6LDR3dqGXfxX3o7OqiYd6ub0/6b1Qah3kafofZ0/f+pv3okY6dWdU2e
 a3TrlRNXCy9xTsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23329139A2;
 Mon, 22 Jan 2024 06:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lTiPB7gJrmU3OwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 06:22:48 +0000
Date: Mon, 22 Jan 2024 07:22:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240122062239.GA58756@pevik>
References: <20240119144322.41928-1-pvorel@suse.cz>
 <ZaqP2_ZeyRM1YY0w@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZaqP2_ZeyRM1YY0w@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.08 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.58)[92.28%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] swapon01: Test on all filesystems
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

> Hi!
> >  testcases/kernel/syscalls/swapon/swapon01.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)

> > diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
> > index e59fb20a1..ef4ebfdcf 100644
> > --- a/testcases/kernel/syscalls/swapon/swapon01.c
> > +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> > @@ -8,6 +8,7 @@
> >   * [Description]
> >   *
> >   * Checks that swapon() succeds with swapfile.
> > + * Testing on all filesystems which support swap file.
> >   */

> >  #include <unistd.h>
> > @@ -17,13 +18,14 @@
> >  #include "lapi/syscalls.h"
> >  #include "libswap.h"

> > -#define SWAP_FILE "swapfile01"
> > +#define MNTPOINT	"mntpoint"
> > +#define SWAP_FILE	MNTPOINT"/swapfile01"

> >  static void verify_swapon(void)
> >  {
> >  	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));

> > -	if (TST_PASS && tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
> > +	if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {

> I do not think that this should be removed, if the swapon() call fails
> we still do not want TBROK here.

+1, I did it by accident when rebasing the original patch.

> >  		tst_brk(TBROK | TERRNO,
> >  				"Failed to turn off swapfile, system reboot recommended");
> >  	}
> > @@ -31,13 +33,20 @@ static void verify_swapon(void)

> >  static void setup(void)
> >  {
> > -	is_swap_supported(SWAP_FILE);
> >  	make_swapfile(SWAP_FILE, 0);
> >  }

> >  static struct tst_test test = {
> > -	.needs_root = 1,
> > -	.needs_tmpdir = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.mount_device = 1,
> > +	.needs_root = 1, /* for swapon() */

> Can we please avoid comments like this?

Sure (again part for the original effort).

> I'ts pretty clear that if you are working with devices and setting up
> swapfiles it's priviledged operation...

> > +	.all_filesystems = 1,
> >  	.test_all = verify_swapon,
> > -	.setup = setup
> > +	.setup = setup,
> > +	.skip_filesystems = (const char *[]) {
> > +		"bcachefs",
> > +		"btrfs",
> > +		"tmpfs",

> So the rest of the filesystems work fine? If so this change looks fine
> to me.

Yes.

Going to send v2.

Kind regards,
Petr

> > +		NULL
> > +	},
> >  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
