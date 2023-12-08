Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5201C4167B
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 07:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 617E73CBA5F
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 08:43:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37C383CB9F5
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 08:43:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 65225616651
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 08:43:09 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4866220C4;
 Fri,  8 Dec 2023 07:43:08 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A37C13A6B;
 Fri,  8 Dec 2023 07:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id JfXJJAzJcmUaIAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 08 Dec 2023 07:43:08 +0000
Date: Fri, 8 Dec 2023 08:43:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20231208074306.GA314880@pevik>
References: <20231207212739.302374-1-pvorel@suse.cz>
 <20231207212739.302374-3-pvorel@suse.cz>
 <CAASaF6yheXD4w07K1xUVXrqoS6jdX6PUjG64UXQbE_hQR9cW7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yheXD4w07K1xUVXrqoS6jdX6PUjG64UXQbE_hQR9cW7w@mail.gmail.com>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.19 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; ARC_NA(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all]; DMARC_NA(1.20)[suse.cz];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[33.51%]
X-Rspamd-Queue-Id: C4866220C4
X-Spam: Yes
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Add support for TDBUG tst_res() flag
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

Hi Jan, all,

> > diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
> > index dab811564..479179263 100644
> > --- a/doc/C-Test-API.asciidoc
> > +++ b/doc/C-Test-API.asciidoc
> > @@ -227,6 +227,7 @@ Printf-like function to report test result, it's mostly used with ttype:
> >  | 'TPASS' | Test has passed.
> >  | 'TFAIL' | Test has failed.
> >  | 'TINFO' | General message.
> > +| 'TDBUG' | Debug message (C API only, printed with '-v').

> My first impression was it's some kind of new BUG type :-)
> I'd suggest making it TDEBUG or TDBG.

Agree it looks strange. We wanted to keep 5 letters.
Therefore maybe TVERB (in discussion from v1).

If we agree to use more, TDEBUG or TVERBOSE would be better.

Kind regards,
Petr

> >  | 'TWARN' | Something went wrong but we decided to continue. Mostly used in cleanup functions.
> >  |==============================

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
