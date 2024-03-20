Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99088C6FD1F
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF0A33D0040
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:02:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79B5B3CD943
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:02:16 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2389414011AF
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:02:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5548434770;
 Wed, 20 Mar 2024 16:02:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 157E3136D6;
 Wed, 20 Mar 2024 16:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dwa8AoYI+2UNYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 16:02:14 +0000
Date: Wed, 20 Mar 2024 17:02:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240320160208.GA489473@pevik>
References: <20240130122540.13215-1-akumar@suse.de> <ZeiD-UfEigpEw0Yb@yuki>
 <2673972.lGaqSPkdTl@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2673972.lGaqSPkdTl@localhost>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5548434770
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/mmap01: Rewrite the test using new
 LTP API
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

Hi Avinesh,

> Hi Cyril, Petr,
> Thank you for the review.

...
> > > -	/* Creat a temporary file used for mapping */
> > > -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
> > > -		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
> > > -	}
> > > +	addr[file_sz] = 'X';
> > > +	addr[file_sz + 1] = 'Y';
> > > +	addr[file_sz + 2] = 'Z';

> > > -	/* Write some data into temporary file */
> > > -	if (write(fildes, write_buf, strlen(write_buf)) !=
> > > (long)strlen(write_buf)) { -		tst_brkm(TFAIL, cleanup, "writing to %s",
> > > TEMPFILE);
> > > -	}
> > > +	SAFE_MSYNC(addr, page_sz, MS_SYNC);

> > > -	/* Get the size of temporary file */
> > > -	if (stat(TEMPFILE, &stat_buf) < 0) {
> > > -		tst_brkm(TFAIL | TERRNO, cleanup, "stat of %s failed",
> > > -			 TEMPFILE);
> > > -	}
> > > -	file_sz = stat_buf.st_size;
> > > +	SAFE_FILE_SCANF(TEMPFILE, "%s", buf);

> > Hmm, why do we SAFE_LSEEK() the fd if we are not using it for reading?
> I guess I can remove the SAFE_LSEEK() in setup(), as we want to read the
> complete file contents without knowing it's size, hence SAFE_FILE_SCANF().

I'm not sure if any lseek() is needed.


> Please correct me if this is not the right approach.

I guess Cyril means by SAFE_READ() to read just that 3 bytes
changed or strlen(write_buf) (whole string).

> > This could be just simple SAFE_READ() instead.

> > > -	page_sz = getpagesize();
> > > +	if (strcmp(write_buf, buf))
> > > +		tst_res(TFAIL, "File data has changed");
> > > +	else
> > > +		tst_res(TPASS, "mmap() functionality successful");

> >                                    ^
> > 				   "Data after file end were not written out"

> > It's kind of pointless to print message that just means "success".

> > > -	/* Allocate and initialize dummy string of system page size bytes */
> > > -	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
> > > -		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
> > > -	}
> > > +	SAFE_LSEEK(fd, 0, SEEK_SET);
> > > +	memset(&addr[file_sz], 0, 3);

> > I was wondering why this is needed, seems like for tmpfs we will read
> > back the data after the end of the file on a subsequent runs of the
> > test, i.e. with -i 2.

> > I wonder if that is expected or not, it's a bit strange that we can
> > expand the file size that way.

> > And it seems to happen for FUSE as well, that actually does sound like a
> > bug.

> Thanks for pointing this out, I was overlooking this issue. I verified that we
> read back the data written past eof in further iteration of the test only in
> tmpfs and fuse.ntfs. How would you suggest to confirm if this is indeed a bug
> with these filesystems.

Interesting. Feel free to Cc LTP ML if you report to mainline developers (not
sure if mainline kernel or SUSE kernel is affected).

Kind regards,
Petr

> Regards,
> Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
