Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E88F4368D
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:35:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F333E4ADB
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 13:35:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5326D3CCB72
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 13:35:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF19F1400206
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 13:35:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C3616A9AE;
 Fri, 17 Apr 2026 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776425700;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MzDnSvdXETvWIVW+93a6GYOLyGx9oiQYl5w9oe3i1g=;
 b=nQGzFsGdIt2zq+czqxqtyn2JdsLgCYHmv3DGivTxo21b2/kxyFNMnTQB1CpgK8FaVsDmG1
 NHFZx4yQlHjjtI/jRsHkDzjVmMwf8CWuAPvUbdio2uNnlrb3qnPoE5mL1L3stRCsL+i30P
 W7QNhJCZmfVEQZaRPN29Ak9NiEJqsxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776425700;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MzDnSvdXETvWIVW+93a6GYOLyGx9oiQYl5w9oe3i1g=;
 b=l2G6SPUT73yq+qSjEMZtW/91mMmMwIFRwr9Hyjia9LkWCdFy/QKK346HTf3d0WErB+RCS8
 LCtFFsM+afLML8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776425700;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MzDnSvdXETvWIVW+93a6GYOLyGx9oiQYl5w9oe3i1g=;
 b=nQGzFsGdIt2zq+czqxqtyn2JdsLgCYHmv3DGivTxo21b2/kxyFNMnTQB1CpgK8FaVsDmG1
 NHFZx4yQlHjjtI/jRsHkDzjVmMwf8CWuAPvUbdio2uNnlrb3qnPoE5mL1L3stRCsL+i30P
 W7QNhJCZmfVEQZaRPN29Ak9NiEJqsxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776425700;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MzDnSvdXETvWIVW+93a6GYOLyGx9oiQYl5w9oe3i1g=;
 b=l2G6SPUT73yq+qSjEMZtW/91mMmMwIFRwr9Hyjia9LkWCdFy/QKK346HTf3d0WErB+RCS8
 LCtFFsM+afLML8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B540593AE;
 Fri, 17 Apr 2026 11:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bnLxAOQa4mljeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 11:35:00 +0000
Date: Fri, 17 Apr 2026 13:34:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <20260417113453.GA409289@pevik>
References: <20260410175031.16921-1-always.starving0@gmail.com>
 <20260413212007.GA164377@pevik>
 <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
 <20260416180559.GA303991@pevik>
 <CANgNiRxx3MyMGsEXszhV1TcBc8XP9jSrYL_pnbwsUa4bb0-XiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANgNiRxx3MyMGsEXszhV1TcBc8XP9jSrYL_pnbwsUa4bb0-XiQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz];
 REPLYTO_EQ_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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

> Petr Vorel <pvorel@suse.cz> wrote:

> > > > +INSTALL_DIR            := $(includedir)/lapi

> > > I'm doubting should we install the include/lapi/ local header files to
> > > the /opt/ltp/include?

> > Do you question *whether* install lapi/*.h or *where* to install them?
> > We install include/*.h files. What is a difference with include/lapi/?

> The former, I guess we don't need to install any.

+1

> > I'd say either install both or none. I would prefer to not install any,
> > LTP library is not separated anyway (there is an old Andrea's effort, but that
> > uses meson anyway). Installation was added in 2008 and I doubt anybody is using
> > it.

> Yes, that was exactly my point, we'd better remove the INSTALL_* part
> from the Makefile you posted.

> -INSTALL_DIR            := $(includedir)/lapi
> -
> -INSTALL_MODE           := 00644
> -
> -INSTALL_TARGETS                := *.h

+1, let's drop it. Ideally as a separate patch in include/Makefile, so that
include/lapi/Makefile can be based on it. Maybe we could even have a template in
include/mk/ instead of copypasting (when now we will not have INSTALL_*, but I
don't require it (it's just 2x Makefile, they can be copy pasted).


> > > > --- include/lapi/syscalls/Makefile
> > > > +++ /dev/null

> > > Does the `make check` still work (inside include/lapi/syscalls/)
> > > without this Makefile?

> > Sure not. Do we really want to check generate_arch.sh and generate_syscalls.sh
> > in arch? If yes, sure it needs to be added, but that was not my intention when
> > creating #1262. I really wanted to check C (and shell) library and tests code.

> I'm ok with both, so without that Makefile we could do `make check` in
> /include/lapi/.

+1.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
