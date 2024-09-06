Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E8CCE7AE8
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 08:36:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F08A3C24DC
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 10:36:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03FE43C03B0
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 10:36:39 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66430610215
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 10:36:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7761A21841;
 Fri,  6 Sep 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 488FD136A8;
 Fri,  6 Sep 2024 08:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yndSDxa/2mZdSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Sep 2024 08:36:38 +0000
Date: Fri, 6 Sep 2024 10:36:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240906083628.GA990068@pevik>
References: <20240905134502.33759-1-mdoucha@suse.cz>
 <20240906081754.GB985598@pevik>
 <ee93e6ab-6f7c-4241-bb29-7c834935fbd8@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee93e6ab-6f7c-4241-bb29-7c834935fbd8@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7761A21841
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] fallocate05: Check that deallocated file
 range is marked as a hole
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

> On 06. 09. 24 10:17, Petr Vorel wrote:
> > Hi Martin,

> > > The new lseek(SEEK_HOLE/SEEK_DATA) checks will be useful for diagnosing
> > > why the final write() check fails with ENOSPC. If the hole doesn't get
> > > created at all, the lseek() checks will fail.

> > Thank you!

> > ...
> > > +	/* Check that the deallocated file range is marked as a hole */
> > > +	TEST(lseek(fd, 0, SEEK_HOLE));
> > > +
> > > +	if (TST_RET == 0) {
> > > +		tst_res(TPASS, "Test file contains hole at offset 0");
> > > +	} else if (TST_RET == -1) {
> > > +		tst_res(TFAIL | TTERRNO, "lseek(SEEK_HOLE) failed");
> > > +	} else {
> > > +		tst_res(TFAIL | TTERRNO,
> > > +			"Unexpected lseek(SEEK_HOLE) return value %ld",
> > > +			TST_RET);
> > > +	}
> > nit: maybe just using SAFE_LSEEK()?

> Definitely no SAFE_LSEEK() here because I want to continue to the second
> lseek() even if the first one fails.

OK, fair enough.

> > > +
> > > +	TEST(lseek(fd, 0, SEEK_DATA));
> > > +
> > > +	if (TST_RET == holesize) {
> > > +		tst_res(TPASS, "Test file data start at offset %ld", TST_RET);
> > > +	} else if (TST_RET == -1) {
> > > +		tst_res(TFAIL | TTERRNO, "lseek(SEEK_DATA) failed");
> > > +	} else {
> > > +		tst_res(TFAIL | TTERRNO,
> > > +			"Unexpected lseek(SEEK_DATA) return value %ld",
> > > +			TST_RET);
> > > +	}

> > nit: and here just:

> > TEST(SAFE_LSEEK(fd, 0, SEEK_DATA));
> > if (TST_RET == holesize)
> > 	tst_res(TPASS, "Test file data start at offset %ld", TST_RET);

> We could use SAFE_LSEEK() here at least until someone decides to add another
> sanity check below it. But we still need the "else" branch to report wrong
> hole size. I'd say it's slightly better to keep it as is for the more
> descriptive error messages.

Fair enough, thx for info.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
