Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAC8C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 13:36:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5514E3CE2D9
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 14:36:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F1143CC8BF
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 14:36:38 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23F121400E56
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 14:36:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 237E11FD15;
 Fri, 19 Jan 2024 13:36:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCECF1388C;
 Fri, 19 Jan 2024 13:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id okQzNON6qmXuIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Jan 2024 13:36:35 +0000
Date: Fri, 19 Jan 2024 14:36:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240119133634.GA27666@pevik>
References: <20231011162428.583911-1-pvorel@suse.cz>
 <20231011162428.583911-3-pvorel@suse.cz> <ZapkKSTNkXsnulC3@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZapkKSTNkXsnulC3@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 237E11FD15
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] swapon01: Simplify code, add copyright
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

Hi Cyril,

> Hi!
> >  /*\
> > @@ -21,18 +22,11 @@

> >  static void verify_swapon(void)
> >  {
> > -	TEST(tst_syscall(__NR_swapon, SWAP_FILE, 0));
> > +	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));

> > -	if (TST_RET == -1) {
> > -		tst_res(TFAIL | TTERRNO, "Failed to turn on swapfile");
> > -	} else {
> > -		tst_res(TPASS, "Succeeded to turn on swapfile");
> > -		/*we need to turn this swap file off for -i option */
> > -		if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
> > -			tst_brk(TBROK | TERRNO, "Failed to turn off swapfile,"
> > -				" system reboot after execution of LTP "
> > -				"test suite is recommended.");
> > -		}
> > +	if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {

> Maybe if (TST_PASS && tst_syscall(__NR_swapoff, ...) != 0) {

Rebased, add this change and merged. Thanks!

Kind regards,
Petr


> Otherwise it looks good, with that change:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> > +		tst_brk(TBROK | TERRNO,
> > +				"Failed to turn off swapfile, system reboot recommended");
> >  	}
> >  }

> > -- 
> > 2.42.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
