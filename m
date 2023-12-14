Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E25C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 12:27:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 577FE3CEE1C
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 13:27:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE4AF3CB491
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 13:26:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 59AFF600FA8
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 13:26:56 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 197CF220DD;
 Thu, 14 Dec 2023 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702556816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGiKL5KuyVPjfxF31pV6aOvEZvIWfs73/qovK5M5Xp0=;
 b=p20apbVdeoXCixmLPZsa1EFvDQ4mxepWGR+HkdjC30xFAL2nlK0Cdr16SaHzIR0vbt429A
 CYJv+qVWmoX3yWLJcvRqSl5Esoko5bDxSB8cVbGQp4qlAzrZTHElX3/oxvjMmpxrIg9LYq
 +4ZxMlegQxuBP9SArZcSRyYiXzA8ViI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702556816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGiKL5KuyVPjfxF31pV6aOvEZvIWfs73/qovK5M5Xp0=;
 b=H5FdBCCV0zZoP3Eq6O375aLpFvryHz/p+1yaWy5QGy/gFYAGGgIyq+kqSfDYDTyOiBkjEZ
 mtE5ayLo8rta7bAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702556816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGiKL5KuyVPjfxF31pV6aOvEZvIWfs73/qovK5M5Xp0=;
 b=p20apbVdeoXCixmLPZsa1EFvDQ4mxepWGR+HkdjC30xFAL2nlK0Cdr16SaHzIR0vbt429A
 CYJv+qVWmoX3yWLJcvRqSl5Esoko5bDxSB8cVbGQp4qlAzrZTHElX3/oxvjMmpxrIg9LYq
 +4ZxMlegQxuBP9SArZcSRyYiXzA8ViI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702556816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGiKL5KuyVPjfxF31pV6aOvEZvIWfs73/qovK5M5Xp0=;
 b=H5FdBCCV0zZoP3Eq6O375aLpFvryHz/p+1yaWy5QGy/gFYAGGgIyq+kqSfDYDTyOiBkjEZ
 mtE5ayLo8rta7bAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 69506134B0;
 Thu, 14 Dec 2023 12:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id WDlTFo/0emX6cgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 12:26:55 +0000
Date: Thu, 14 Dec 2023 13:26:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 Jan Stancek <jstancek@redhat.com>, Xiao Yang <yangx.jy@fujitsu.com>,
 Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231214122649.GB800332@pevik>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-2-pvorel@suse.cz> <ZXoAKxPxfXxU8bxw@rei>
 <20231213234044.GA774490@pevik> <ZXrGTkJIh4YluH3T@rei>
 <20231214121935.GA800332@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231214121935.GA800332@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[51.07%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib/tests: Add test for testing tst_res()
 flags
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi!
> > > > Maybe it would make sense the loop over the flags here instead, so that
> > > > we don't have to produce second TPASS message.

> > > I'm not sure if I follow you. I wanted to use the flag in tst_res(),
> > > but for these two there would be tst_brk(TBROK) due missing result.

> > I mean that if we put TBROK last in the array we can do:

> > 	for (i = 0; i < ARRAY_SIZE(...); i++)
FYI TBROK can stay, because we test tst_res().

I add also add similar test in shell API (IMHO there still can be bugs in shell
API implementation).

Kind regards,
Petr

> > 		tst_res(....);

> Yeah, I realized that later (it was too late already when I wrote the question).
> My motivation was that extra TPASS also test functionality, we test, that TINFO
> and TDEBUG are not results. But this is probably not important, thus I'll just
> loop over array. And sure, I'll put TBROK to the end.

> Kind regards,
> Petr

> > I.e. loop over all the flags in a single call of the function, which
> > would mean that we do not have to add artificial TPASS at the end.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
