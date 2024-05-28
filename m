Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F2DC25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 09:50:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCFA63CFE14
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 11:50:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7663CFE14
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:50:36 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 228B0600157
 for <ltp@lists.linux.it>; Tue, 28 May 2024 11:50:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4A4E22713;
 Tue, 28 May 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99FA713A5D;
 Tue, 28 May 2024 09:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i66NJeqoVWZtUgAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 28 May 2024 09:50:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 42189A07D0; Tue, 28 May 2024 11:50:30 +0200 (CEST)
Date: Tue, 28 May 2024 11:50:30 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240528095030.valplwc5t3m3betn@quack3>
References: <20240522124754.9599-1-wegao@suse.com>
 <20240527231636.GA375669@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240527231636.GA375669@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A4A4E22713
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] msync04: Check disk content if dirty bit check
 failed
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr!

On Tue 28-05-24 01:16:36, Petr Vorel wrote:
> > msync04 test is inherently racy and nothing guarantees that the page
> > is not written out before get_dirty_page() manages to read the page state.
> > Hence the test should be reworked to verify the page contents is on disk
> > when it finds dirty bit isn't set anymore...
> 
> @Jan some time ago [1] you asked to:
> 
> 	mmap file, write to mmap, msync, abort fs, mount fs again, check the data is
> 	there.
> 
> Could you please have a look if this is enough? Or is it aborting fs and mounting
> again necessary?

Well, it depends on what functionality exactly you want to test... See
below.

> > diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
> > index 72ddc27a4..c296c8b20 100644
> > --- a/testcases/kernel/syscalls/msync/msync04.c
> > +++ b/testcases/kernel/syscalls/msync/msync04.c
> > @@ -46,6 +46,7 @@ uint64_t get_dirty_bit(void *data)
> >  static void test_msync(void)
> >  {
> >  	uint64_t dirty;
> > +	char buffer[20];
> 
> >  	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
> >  		0644);
> > @@ -56,20 +57,27 @@ static void test_msync(void)
> >  	mmaped_area[8] = 'B';
> >  	dirty = get_dirty_bit(mmaped_area);
> >  	if (!dirty) {
> > -		tst_res(TFAIL, "Expected dirty bit to be set after writing to"
> > -				" mmap()-ed area");
> > -		goto clean;
> > -	}
> > -	if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
> > -		tst_res(TFAIL | TERRNO, "msync() failed");
> > -		goto clean;
> > +		tst_res(TINFO, "Not see dirty bit so we check content of file instead");
> > +		test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY);
> > +		SAFE_READ(0, test_fd, buffer, 9);
> > +		if (buffer[8] == 'B')
> > +			tst_res(TCONF, "write file ok but msync couldn't be tested"
> > +				" because the storage was written to too quickly");
> > +		else
> > +			tst_res(TFAIL, "write file failed");

So this will read the very same page in the page cache that mmap(2) has
been using for write. As such it isn't very interesting verification. I'd
at least use direct IO to verify the data is stored on disk now.

> > +	} else {
> > +		if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
> > +			tst_res(TFAIL | TERRNO, "msync() failed");
> > +			goto clean;
> > +		}
> > +		dirty = get_dirty_bit(mmaped_area);
> > +		if (dirty)
> > +			tst_res(TFAIL, "msync() failed to write dirty page despite"
> > +					" succeeding");
> > +		else
> > +			tst_res(TPASS, "msync() working correctly");
> > +
> >  	}
> > -	dirty = get_dirty_bit(mmaped_area);
> > -	if (dirty)
> > -		tst_res(TFAIL, "msync() failed to write dirty page despite"
> > -				" succeeding");
> > -	else
> > -		tst_res(TPASS, "msync() working correctly");

Overall this looks correct. But what this test really does is that it
verifies msync(2) is clearing dirty page bits. That is not very useful
verification from userspace point of view (as IMO it leans too much on
internal kernel implementation details). msync(2) is really a data
integrity operation so ideally its tests would verify data integrity
guarantees are met after a power failure - that is what userspace is
interested in. But probably these test are more within the realm of fstests
(where we do similar tests) as LTP lacks necessary infrastructure to do
this low-level filesystem manipulation so I guess what you have is fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
