Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E14C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 10:54:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 671F13C9E46
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:54:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFE273C9D93
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 11:54:38 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E04B1A00493
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 11:54:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42D342117A;
 Thu, 27 Mar 2025 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743072876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBBPVMBFSHq4Ck/TcOqX38PesFD5OMJm3cCamurFdRk=;
 b=GedMfcmDPsexLHT7l+EgjTD3Ni0dH/rjNAa6fSjs/kc4lb8eJt5vQfXze0PTTwRKfxgz9M
 XZtLEtJPVc6YIohrl/ypJsCq13Lcc9NLVZZRT/i9mJNGoidvBE4Q188rNnifZmUeTTUNkN
 BaleTdNcmg1d1XaXnDDLfrGfpVeWBZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743072876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBBPVMBFSHq4Ck/TcOqX38PesFD5OMJm3cCamurFdRk=;
 b=SFbXFQYYfRT1951OQgshXS8ljJyB8pqBSsELdWnS6k7p7Kt8eypYt1eFSu3zPSrPILb3ir
 Q2xb9OMfkZ+hg3AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GedMfcmD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SFbXFQYY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743072876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBBPVMBFSHq4Ck/TcOqX38PesFD5OMJm3cCamurFdRk=;
 b=GedMfcmDPsexLHT7l+EgjTD3Ni0dH/rjNAa6fSjs/kc4lb8eJt5vQfXze0PTTwRKfxgz9M
 XZtLEtJPVc6YIohrl/ypJsCq13Lcc9NLVZZRT/i9mJNGoidvBE4Q188rNnifZmUeTTUNkN
 BaleTdNcmg1d1XaXnDDLfrGfpVeWBZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743072876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GBBPVMBFSHq4Ck/TcOqX38PesFD5OMJm3cCamurFdRk=;
 b=SFbXFQYYfRT1951OQgshXS8ljJyB8pqBSsELdWnS6k7p7Kt8eypYt1eFSu3zPSrPILb3ir
 Q2xb9OMfkZ+hg3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 249901376E;
 Thu, 27 Mar 2025 10:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3TsECGwu5WeoHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Mar 2025 10:54:36 +0000
Date: Thu, 27 Mar 2025 11:54:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250327105434.GA72472@pevik>
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-3-amir73il@gmail.com>
 <xpozkmxhtqd3lamf7n2dk43z6eey5ettmdw3vayykmjrv5dqgt@zeewki7ibawg>
 <CAOQ4uxgW8rFNLOXMOQzXMrGXtsVvX6QHKMc8tPrnibra_cCAZA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgW8rFNLOXMOQzXMrGXtsVvX6QHKMc8tPrnibra_cCAZA@mail.gmail.com>
X-Rspamd-Queue-Id: 42D342117A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify24: print range info for pre-content
 events
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, Jan,

> > > @@ -386,6 +388,22 @@ static void test_fanotify(unsigned int n)
> > >                               (unsigned int)event->pid,
> > >                               (unsigned int)child_pid,
> > >                               event->fd);
> > > +             } else if (event->mask & LTP_PRE_CONTENT_EVENTS) {

> > You should probably check here that the event->len is sufficiently large to
> > contain the range info. Otherwise 'range' might point beyond the end of
> > event and result in odd behavior...


> Right. feel free to use the amended version below



> >                                                                 Honza

> > > +                     if (range->hdr.info_type != FAN_EVENT_INFO_TYPE_RANGE) {
> > > +                             tst_res(TFAIL,
> > > +                                     "got event: mask=%llx pid=%u fd=%d "
> > > +                                     "(expected range info)",
> > > +                                     (unsigned long long)event->mask,
> > > +                                     (unsigned int)event->pid,
> > > +                                     event->fd);

>                         if (event->event_len < sizeof(*event) +
> sizeof(*range) ||
>                             range->hdr.info_type != FAN_EVENT_INFO_TYPE_RANGE) {
>                                 tst_res(TFAIL,
>                                         "got event: mask=%llx pid=%u
> len=%d fd=%d "
>                                         "(expected range info)",
>                                         (unsigned long long)event->mask,
>                                         (unsigned int)event->pid,
>                                         (unsigned int)event->event_len,
>                                         event->fd);

Thanks! I dared instead of copy pasting to use fan_hsm branch from your fork.
Jan, thanks for the review!
Merged the rest of the pachset.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
