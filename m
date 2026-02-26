Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234C9FCE064
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 12:26:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49FB63CB8C5
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 13:26:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 450BE3C7BA1
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 13:26:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C7F910009A5
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 13:25:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B7651FA8E;
 Thu, 26 Feb 2026 12:25:58 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F5313EA62;
 Thu, 26 Feb 2026 12:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IEH9FdY7oGkGFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Feb 2026 12:25:58 +0000
Date: Thu, 26 Feb 2026 13:26:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aaA73pw1CCcaTev1@yuki.lan>
References: <20251125044057.20922-1-wegao@suse.com>
 <20260225015044.19233-1-wegao@suse.com> <aZ7V7XD6LIiZ4m0e@yuki.lan>
 <aZ-jDRXSWK78VmdE@autotest-wegao.qe.prg2.suse.org>
 <aaALdx9zYZDUzs2G@yuki.lan> <DGOSIY7VL1R3.1KTK35389TOL3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGOSIY7VL1R3.1KTK35389TOL3@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 7B7651FA8E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
> > > diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> > > index 9b024a74e..0c06a306c 100644
> > > --- a/lib/tst_tmpdir.c
> > > +++ b/lib/tst_tmpdir.c
> > > @@ -186,8 +186,10 @@ static int purge_dirat(int dir_fd, const char *path, char **errptr)
> > >                         continue;
> > >  
> > >                 /* Recursively remove the current entry */
> > > -               if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0)
> > > +               if (rmobjat(subdir_fd, dir_ent->d_name, errptr) != 0) {
> > > +                       close(subdir_fd);  <<<<<<<<<< first close
> > >                         ret_val = -1;
> > > +               }
> > >         }
> > >         
> > >         closedir(dir);  <<<<<<<<<<<<< second close
> >
> > Ah, right, we hand the fd to the fdopendir() and it's closed in the
> > closedir() call. I've missed that since the closedir() is not shown in
> > the diff since that part of the code wasn't modified and haven't shown
> > up in the diff.
> >
> > The patch looks good to me then.
> 
> Feel free to ack and merge :-)

Done, thanks Andrea and Wei.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
