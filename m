Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70468C02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:56:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3BC03C7C1E
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:56:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D021F3C0294
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:55:50 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 481F225798D
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:55:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D056F2117A;
 Fri, 17 Jan 2025 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737111348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8FdHiwYcXMKUiVLeSXRC1dV3oE8Dbx0RiPOTpYtykXo=;
 b=2GaOUOypIu6FMgoyRsrAqgADPk46l86TFevdY4MMSmmZMuUPVanHejvUemg+Eo0/pgd60y
 NLmn4GKsq4aVEY0B/WZ927y+zZd3ZUWMatOSnu6M2DuoJGUBb/8vbWQpaBvcnuMH0YoJEF
 0aED5NLUDGRjYl3kRw/jMvwtlJDNdt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737111348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8FdHiwYcXMKUiVLeSXRC1dV3oE8Dbx0RiPOTpYtykXo=;
 b=Oxkzvl8kIeOzvVatzPAm7Bf+BtiuiigS/ghx2AddkZkcvQy91mfHC1wCG+fk+mWf4Rci2l
 miJyaVPB8rlqWiDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737111348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8FdHiwYcXMKUiVLeSXRC1dV3oE8Dbx0RiPOTpYtykXo=;
 b=2GaOUOypIu6FMgoyRsrAqgADPk46l86TFevdY4MMSmmZMuUPVanHejvUemg+Eo0/pgd60y
 NLmn4GKsq4aVEY0B/WZ927y+zZd3ZUWMatOSnu6M2DuoJGUBb/8vbWQpaBvcnuMH0YoJEF
 0aED5NLUDGRjYl3kRw/jMvwtlJDNdt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737111348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8FdHiwYcXMKUiVLeSXRC1dV3oE8Dbx0RiPOTpYtykXo=;
 b=Oxkzvl8kIeOzvVatzPAm7Bf+BtiuiigS/ghx2AddkZkcvQy91mfHC1wCG+fk+mWf4Rci2l
 miJyaVPB8rlqWiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 884BC13332;
 Fri, 17 Jan 2025 10:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KCAxIDQ3imdTNgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 10:55:48 +0000
Date: Fri, 17 Jan 2025 11:55:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250117105542.GB754426@pevik>
References: <20250117084118.740225-1-pvorel@suse.cz>
 <Z4oln8S422XIUExH@yuki.lan> <20250117095742.GA749338@pevik>
 <Z4otgs7iVe3sZ63C@yuki.lan> <20250117102825.GA750951@pevik>
 <Z4oxlVP5VCVpO0mc@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4oxlVP5VCVpO0mc@yuki.lan>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.com,redhat.com,suse.de,suse.cz];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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

> Hi!
> > > diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
> > > index 6a8e39339..989bb8910 100644
> > > --- a/testcases/lib/tst_ns_exec.c
> > > +++ b/testcases/lib/tst_ns_exec.c
> > > @@ -100,7 +100,12 @@ int main(int argc, char *argv[])
> > >         for (i = 0; i < ns_fds; i++)
> > >                 SAFE_SETNS(ns_fd[i], 0);

> > > -       pid = SAFE_CLONE(&args);
> > > +       pid = tst_clone(&args);
> > > +       if (pid < 0) {
> > > +               printf("clone() failed");
> > > +               return 1;
> > > +       }
> > > +
> > >         if (!pid)
> > >                 SAFE_EXECVP(argv[3], argv+3);

> > Thanks, it works! Could you please merge it? Maybe update the comment?

> > -       .forks_child = 1, /* Needed by SAFE_CLONE */
> > +       .forks_child = 1, /* Needed by safe_clone() */

> I guess that we do not need that one anymore. Does the helper work if
> we remove it?

Also, please modify tst_ns_create.c as well.

Kind regards,
Petr

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Fixes: 893ca0abe7 ("lib: multiply the timeout if detect slow kconfigs")

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
