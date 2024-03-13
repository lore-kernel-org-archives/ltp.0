Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01EAC54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 16:48:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 023B93CB808
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 17:48:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3A723C06A6
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 17:47:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 25F82600843
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 17:47:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D40361F7A1;
 Wed, 13 Mar 2024 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710348464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrBbwe4KLcAOAeATVhqnpThWiIIU+d8ElKJ4PsQH6PA=;
 b=SaePemOhRHpsd8+Z4NIuS0t8G2BaCOKMLSDWWvD7zucgzhl2hElawjda54XXS5lz8k1Pnk
 hHvrMhjEbFMvOsYP0rhiPe97xCZ5Cd96FCl4h3qVEHUojSa/Xc+V5pw4TQO1Sq0Fl7KOM6
 vWSktWERZggjb7lMrx6rzBptCuwiFJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710348464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrBbwe4KLcAOAeATVhqnpThWiIIU+d8ElKJ4PsQH6PA=;
 b=LkRUtrZDWCXXyZmmVgzqGuOTxF9Xajq0EMs+/5lEoLVXCKHJkKtw8aRG743t6RytAPbahy
 IAbj1A6r9ePpBQBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710348463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrBbwe4KLcAOAeATVhqnpThWiIIU+d8ElKJ4PsQH6PA=;
 b=poX0TUSAstMME3DRQXw32yXqz4dHFS6+kQwgUdg4ZCTzzj2F2mh4Ow9SJO0wMFPdBnaEnZ
 SfZlJZcBG4SyRezVk7hm86fLla0M+mxr3y68MfDsUhZWWqC4NWLFbIv8QJzuMDqpFPDziy
 xGk2iWevuDGiZclOvgdgZufp+a9upj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710348463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrBbwe4KLcAOAeATVhqnpThWiIIU+d8ElKJ4PsQH6PA=;
 b=O4o76tR5lBMlRzj7aShxZDe73F0FsuwPzCwPS4t2SRoFUZrOz6usum1g23A6FeRk0fkGvy
 kMe6HE5cUSzkbMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6DF013977;
 Wed, 13 Mar 2024 16:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q6pHMK/Y8WXGEgAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 13 Mar 2024 16:47:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 6D093A07D9; Wed, 13 Mar 2024 17:47:39 +0100 (CET)
Date: Wed, 13 Mar 2024 17:47:39 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240313164739.w5r3m5qyuzyp5ynz@quack3>
References: <20240312120829.178305-1-meted@linux.ibm.com>
 <20240312120829.178305-2-meted@linux.ibm.com>
 <CAOQ4uxgPK=t25OvBcevkQseFEr9S6p7PtU35p8T+snzqzN+ndg@mail.gmail.com>
 <20240313072623.GA519991@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240313072623.GA519991@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=poX0TUSA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O4o76tR5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,lists.linux.it,suse.cz];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: D40361F7A1
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 13-03-24 08:26:23, Petr Vorel wrote:
> Hi all,
> ...
> 
> > >  static void do_test(unsigned int number)
> > >  {
> > >         struct test_case_t *tc = &test_cases[number];
> > > @@ -275,17 +290,28 @@ static void do_test(unsigned int number)
> > >         /* Set mark on non-dir only when expecting error ENOTDIR */
> > >         const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
> > >         int dirfd = AT_FDCWD;
> > > +       int se_enforcing = 0;
> 
> > >         if (tc->pfd) {
> > >                 dirfd = tc->pfd[0];
> > >                 path = NULL;
> > > +               se_enforcing = is_selinux_enforcing();
> nit: this check should be in the setup function to be done only once.
> (by default it's done twice, because we have 2 testcases with pfd, we support
> -iN parameter, thus it's actually 2*N.). I'll fix it before merge.
> > >         }
> 
> > >         tst_res(TINFO, "Testing %s with %s",
> > >                 tc->mark.desc, tc->mask.desc);
> > > -       TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > > -                                        tc->mask.flags, dirfd, path),
> > > -                                        tc->expected_errno);
> > > +
> > > +       if (tc->pfd && se_enforcing) {
> > > +               const int exp_errs[] = {tc->expected_errno, EACCES};
> > > +
> > > +               TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > > +                                tc->mask.flags, dirfd, path),
> > > +                                exp_errs);
> > > +       } else {
> > > +               TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > > +                                                tc->mask.flags, dirfd, path),
> > > +                                                tc->expected_errno);
> > > +       }
> 
> 
> > This looks fine to me, but on second thought I am not sure how important
> > it is to special case se_enforcing.
> > We could probably always check for either error value.
> 
> I don't mind explicitly testing EACCES with SELinux. @Jan WDYT?
> 
> With a diff below (I can change it before merge + I would do the following work
> to integrate this into the LTP C API):
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Yes, looks fine to me as well. I don't feel strongly whether we should
accept EACCESS unconditionally or only with SELinux. I suspect eventually
we might need to accept it unconditionally as there may be other security
modules that would block addition of the mark. But let's see what the
future brings. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
