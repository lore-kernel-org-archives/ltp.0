Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57215D78780
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:19:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E707F3D0542
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 15:19:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C38143C5624
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:18:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C1A51400E5A
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:18:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEA81336DB;
 Fri, 19 Dec 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F0213EA63;
 Fri, 19 Dec 2025 14:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c5icJcVeRWlqOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 14:18:45 +0000
Date: Fri, 19 Dec 2025 15:18:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251219141829.GB247368@pevik>
References: <20251219094219.151887-1-pvorel@suse.cz>
 <CAEemH2eac_1G6jQCbOMPgCQtcTiDiYm92KBCgbf5m=84WqFZsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eac_1G6jQCbOMPgCQtcTiDiYm92KBCgbf5m=84WqFZsQ@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BEA81336DB
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > -       /*create and turn on remaining swapfiles */
> > -       for (j = 0; j < swapfiles; j++) {
> > +       min_swapfiles = MIN_SWAP_FILES - used_swapfiles;


> I can assume a potential issue here is: if a test system already
> contains swapfiles more than MIN_SWAP_FILES, here min_swapfile
> will be a negative value.

> It sounds weird to mount a negative number of file for test.

> What about:

> min_swapfiles = MIN_SWAP_FILES > used_swapfiles ? \
>               (MIN_SWAP_FILES - used_swapfiles) : 0;

min_swapfiles is used only in comparison

if (errno == EPERM && swapfiles > min_swapfiles)

Therefore it's ok:

Due current limitation of requiring at least single swap, this later call will
always contain 1:

tst_res(TINFO, "Successfully created %d swap files", swapfiles);

I'll try to remove this limitation, therefore I'll print this only if
meaningful:

if (swapfiles > 0)
	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
else
	tst_res(TINFO, "No swap file created");

> > +       while (true) {


> There is another issue in the infinite loop, if a kernel bug makes more
> swapfile does not return EPERM but any others, here not report failure
> and only keep looping forever.

Or it can endup like:
swapon03.c:58: TFAIL: swapon(mntpoint/testswap116, 0): EPERM (1)
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:51: TCONF: Insufficient disk space to create swap file
swapon03.c:79: TWARN: Failed to swapoff mntpoint/testswap01
swapon03.c:79: TWARN: Failed to swapoff mntpoint/testswap02
swapon03.c:79: TWARN: Failed to swapoff mntpoint/testswap03
swapon03.c:79: TWARN: Failed to swapoff mntpoint/testswap04
swapon03.c:79: TWARN: Failed to swapoff mntpoint/testswap05

(again bugs in cleanup).

Good point. I was thinking that Cyril's suggestion does not have break and
intend to add tst_brk(), but in the end I forget on it.

> Maybe we should set a uplimit (e.g MAX_TRIES) to avoid that happening.

tst_brk() is simpler than MAX_TRIES therefore I'd prefer it. But it skips
testing for following filesystems.


>                 /* Create the swapfile */
> > -               snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE,
> > j + 2);
> > -               SAFE_MAKE_SMALL_SWAPFILE(filename);
> > +               snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE,
> > swapfiles);
> > +               MAKE_SMALL_SWAPFILE(filename);
> > +
> > +               /* Quit on a first swap file over max, check for EPERM */
> > +               if (swapon(filename, 0) == -1) {
> > +                       if (errno == EPERM && swapfiles > min_swapfiles)
> > +                               break;

...
> >  static int check_and_swapoff(const char *filename)
> >  {
> > -       char cmd_buffer[256];
> > +       char cmd_buffer[FILENAME_MAX+28];
> >         int rc = -1;


> Here we'd better initialize 'rc = 0' though the return value is not used
> anywhere.

I'd prefer to postpone cleanup like this to later. Otherwise we did not manage
to get this to LTP release :(.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
