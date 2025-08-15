Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D04CA0EE0
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 05:22:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF1893CBE1F
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 07:22:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B9283C8564
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 07:22:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E6A151400771
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 07:22:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 694981F835;
 Fri, 15 Aug 2025 05:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755235357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFgtI/x40ylrWzLwXNw1E+cwBJnR7ZWRk1UT/w1OfGE=;
 b=NOtkr5dBqVfDUPgkKN7VrHloFHgtn6tkHY0CqpFyUsHc2FOHxXSPGweLbvoPZW/Sta21OH
 bDzEpRjy1TcsLo5COEl1jSz1DrWNChFCx9v8hRnmx5jMMVj3ukliz6QdrB43QgiaYCE1F8
 1tlpS/khEVphm35T162xFqcFWjjDjgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755235357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFgtI/x40ylrWzLwXNw1E+cwBJnR7ZWRk1UT/w1OfGE=;
 b=3HUxOB7zeQOm2hTBXFodse3AXVNXC/6vUUvMa4ImYeLwTg95luP9JtGz5VGTf7ARaS1DHH
 L8dJEiTsAGT1TjBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NOtkr5dB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3HUxOB7z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755235357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFgtI/x40ylrWzLwXNw1E+cwBJnR7ZWRk1UT/w1OfGE=;
 b=NOtkr5dBqVfDUPgkKN7VrHloFHgtn6tkHY0CqpFyUsHc2FOHxXSPGweLbvoPZW/Sta21OH
 bDzEpRjy1TcsLo5COEl1jSz1DrWNChFCx9v8hRnmx5jMMVj3ukliz6QdrB43QgiaYCE1F8
 1tlpS/khEVphm35T162xFqcFWjjDjgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755235357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFgtI/x40ylrWzLwXNw1E+cwBJnR7ZWRk1UT/w1OfGE=;
 b=3HUxOB7zeQOm2hTBXFodse3AXVNXC/6vUUvMa4ImYeLwTg95luP9JtGz5VGTf7ARaS1DHH
 L8dJEiTsAGT1TjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D161368C;
 Fri, 15 Aug 2025 05:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cKXRDh3EnmidaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Aug 2025 05:22:37 +0000
Date: Fri, 15 Aug 2025 07:22:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250815052231.GA32490@pevik>
References: <20250812141709.33540-1-liwang@redhat.com>
 <20250814130629.GA575710@pevik>
 <CAEemH2fgnJH201_fvDvPRbAFrfdEz4v_cEg-LXudWje-+w68VA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fgnJH201_fvDvPRbAFrfdEz4v_cEg-LXudWje-+w68VA@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 694981F835
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_mkfs: print short hint when mkfs fails in
 device busy
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
Cc: rafael.tinoco@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Petr Vorel <pvorel@suse.cz> wrote:

> > > diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> > > index 736324f04..dfec06a21 100644
> > > --- a/lib/tst_mkfs.c
> > > +++ b/lib/tst_mkfs.c
> > > @@ -107,6 +107,10 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
> > >                       "%s not found in $PATH", mkfs);
> > >       break;
> > >       default:
> > > +             tst_resm_(file, lineno, TWARN,
> > > +                     "Check if mkfs failed with the (loop) device busy. "
> > > +                     "Background probing (e.g., udisks2) can cause this. \n"
> > When 2 lines are needed, could it be without trailing space?
> >                         "Background probing (e.g., udisks2) can cause this.\n"

> > nit: I don't like LTP messages are split on more lines, but this is indeed too
> > long.

> +1

> > > +                     "Consider temporarily stopping udisks2 during the test.");

> > We already have suggestion about some process running in tst_umount()
> > in lib/tst_device.c:

> >                         tst_resm(TINFO, "Likely gvfsd-trash is probing newly "
> >                                  "mounted fs, kill it to speed up tests.");

> This is a good example, thanks!!

> (The debugging work exhausted my energy this week, and I felt like my
> brain was stuck there, unable to write a simple printed message.)

Understand :).

> So what about:

>  tst_resm_(file, lineno, TWARN,
>     "mkfs may have failed because the device is busy (e.g., udisks2 probing). "
>     "Consider disabling background probing services.");

+1

> > Would you agree to have a library function which would parse
> > /proc/*/comm to check if particular process is running?
> > (I would do it as a separate effort).

> Yes, that would be helpful to confirm some special damon is running,
> if something you were mean:

> if (tst_proc_comm_running("udisksd", NULL) ||
>     tst_proc_comm_running("gvfsd-trash", NULL)) {
>     tst_resm_(file, lineno, TINFO,
>               "Likely udisksd/gvfsd-trash is probing newly mounted fs
> in backgroud... ");
> }

Yes, something like this. It can be done as a separate effort to not block this
simple patch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
