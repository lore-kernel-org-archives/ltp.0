Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC347C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 09:30:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 305943C980F
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 11:30:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7853A3C9732
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:29:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AA171000414
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 11:29:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 647FE1F8C5;
 Tue, 16 Aug 2022 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660642190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D5z6FPMqBXFd4sVnLm+9kBNpLDvIqSFkMkqEwNzOzEA=;
 b=H2nIKegsrCbYN1VmtYnUdL6QXkQu3UCodMidOM8CD1dD9GO8+/zxpGDihuL3fiEB/M2DkC
 jlvKs5QiV34hSyZ8oGij3/LhDGOY5x9XsjHCF72tvxkt+p99pXY/2obMg3cy65DOUe0Wqn
 15pupc3Yb3wfAVyOhuveYgTvHaQqAtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660642190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D5z6FPMqBXFd4sVnLm+9kBNpLDvIqSFkMkqEwNzOzEA=;
 b=PIat6BxxY7WA/aB9EEMoZWsYM8I5HhpfoSkv5L+fjxAfJuQanoAYCqKEf/xQnvMzRCoUSb
 jJVP52jDI8hVwkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50D11139B7;
 Tue, 16 Aug 2022 09:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DEdHE45j+2LlegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 16 Aug 2022 09:29:50 +0000
Date: Tue, 16 Aug 2022 11:31:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YvtkAWs7KNbt9vME@yuki>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <20220811135731.2228-3-pvorel@suse.cz> <YvteNq9F1YuhsD8J@yuki>
 <Yvtg1gjOJaxNXgKi@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yvtg1gjOJaxNXgKi@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] mount03: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > -/*
> > > - * DESCRIPTION
> > > - *	Check for basic mount(2) system call flags.
> > > +/*\
> > > + * [Description]
> > >   *
> > > - *	Verify that mount(2) syscall passes for each flag setting and validate
> > > - *	the flags
> > > - *	1) MS_RDONLY - mount read-only.
> > > - *	2) MS_NODEV - disallow access to device special files.
> > > - *	3) MS_NOEXEC - disallow program execution.
> > > - *	4) MS_SYNCHRONOUS - writes are synced at once.
> > > - *	5) MS_REMOUNT - alter flags of a mounted FS.
> > > - *	6) MS_NOSUID - ignore suid and sgid bits.
> > > - *	7) MS_NOATIME - do not update access times.
> > > + * Verify mount(2) for various flags.
> > >   */
> 
> > Can we please be a bit more verbose here?
> Sure, that was my change. Do you want me to put the original description or
> would be this enough?
> 
> Verify mount(2) run with various flags (e.g. MS_RDONLY, MS_NOEXEC).
> 
> => i.e. what are you missing? I'm not a big fan of listing all features tested,
> but if you prefer I'll put the original description.

I do not think that listing flags that are tested is pointless, at least
this is supposed to be documentation for the test that is shown on a web
page, it should be a bit more verbose than the single sentence you wrote
there.

> > > +static void test_synchronous(void)
> > > +{
> > > +	strcpy(wbuf, TEST_STR);
> > > +	snprintf(file, PATH_MAX, "%s/synchronous", MNTPOINT);
> > > +	otfd = SAFE_OPEN(file, O_RDWR | O_CREAT, FILE_MODE);
> > > +	SAFE_WRITE(1, otfd, wbuf, strlen(wbuf));
> > > +	SAFE_LSEEK(otfd, 0, SEEK_SET);
> > > +	SAFE_READ(0, otfd, rbuf, sizeof(rbuf));
> > > +	TST_EXP_EQ_STR(rbuf, wbuf);
> > > +}
> 
> > This is completely bogus check, this has to work regardless of the
> > MS_SYNCHRONOUS. The only way how to check MS_SYNCHRONOUS would be
> > pulling out the device just after write before page cache had a chance
> > to write out data but not before the disk flushes its caches.
> 
> > I guess that it may be possible to check this if create a loop device,
> > mount it MS_SYNCHRONOUS, write to a file on the loop device and check
> > that the data has been written to the underlying file. But that would
> > be completely different and quite complex test.
> 
> OK, I suggest to remove this test and put your suggestion for new to issues.
> 
> Also looking to the man page we're missing test for MS_LAZYTIME (since 4.O) and
> MS_NOSYMFOLLOW (5.10).

I guess that MS_NOSYMFOLLOW should be easy enough, we just need to
create a symlink to a file and then attempt to open it. We shouldn't end
up with a fd to the symlinked file in that case.

MS_LAZYTIME would be again complicated since that is about deffering
timestamps in memory so it would be similar to MS_SYNCHRONOUS in the
terms of complexity.

> And I'll drop TST_EXP_EQ_STR() unless you think it's useful.

I would follow the usuall, don't add anything that is not used.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
