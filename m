Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B64C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 13:38:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77DEE3CFBA7
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 15:38:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7F2D3CFB89
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 15:37:53 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 305C320A6B4
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 15:37:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A074322CE4;
 Wed, 17 Apr 2024 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713361071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N2zMYihwW9hopeqodDxIMWNLBSxlMGz7e4YUfR/auQ=;
 b=dED2uJL5mdG3PG+Ws7sLhwSUHHmxXJvV5W3vV+BEj550kk9HpYLXwHJVne/52te7GActOc
 A09uZj1ESOyFR0b1L9pwjSWIFaGyOmFfhFUfnBiHDka4RpZrTxDP9r0MVMsas11qtQANYo
 hjgXSyKjpMDhTVSmMpW4YgyPJc3VTfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713361071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N2zMYihwW9hopeqodDxIMWNLBSxlMGz7e4YUfR/auQ=;
 b=ZYVZ+pQIqegPOmTWupp2xR69lLWIWVgIFAxXbxyzg6M10zrqv1ikE8afi++ZMFZWCBSZDR
 /kPlPJK+ZNvrD9Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713361071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N2zMYihwW9hopeqodDxIMWNLBSxlMGz7e4YUfR/auQ=;
 b=dED2uJL5mdG3PG+Ws7sLhwSUHHmxXJvV5W3vV+BEj550kk9HpYLXwHJVne/52te7GActOc
 A09uZj1ESOyFR0b1L9pwjSWIFaGyOmFfhFUfnBiHDka4RpZrTxDP9r0MVMsas11qtQANYo
 hjgXSyKjpMDhTVSmMpW4YgyPJc3VTfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713361071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N2zMYihwW9hopeqodDxIMWNLBSxlMGz7e4YUfR/auQ=;
 b=ZYVZ+pQIqegPOmTWupp2xR69lLWIWVgIFAxXbxyzg6M10zrqv1ikE8afi++ZMFZWCBSZDR
 /kPlPJK+ZNvrD9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F27C13957;
 Wed, 17 Apr 2024 13:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zOdLFK/QH2bSNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 13:37:51 +0000
Date: Wed, 17 Apr 2024 15:37:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>
Message-ID: <20240417133749.GA4484@pevik>
References: <20240417090222.707302-1-pvorel@suse.cz> <Zh-eIg51K9UtdQuj@yuki>
 <20240417100611.GA713385@pevik> <Zh-lGL4tU5Z2dSLi@yuki>
 <20240417122418.GB727397@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240417122418.GB727397@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libswap: Change TWARN message to TINFO
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
> > Looking at the patches we get the warning from the is_swap_supported()
> > because we create only 10 blocks worth of swapfile there, right?

> > So the easiest fix is to make sure we create big enough swapfile there
> > as well, what about?

> > diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> > index 313a15f24..36b5af483 100644
> > --- a/libs/libltpswap/libswap.c
> > +++ b/libs/libltpswap/libswap.c
> > @@ -192,7 +192,7 @@ int make_swapfile_(const char *file, const int lineno,
> >  bool is_swap_supported(const char *filename)
> >  {
> >         int i, sw_support = 0;
> > -       int ret = SAFE_MAKE_SWAPFILE_BLKS(filename, 10);
> > +       int ret = SAFE_MAKE_SWAPFILE_SIZE(filename, 1);
> Let me first check where it's needed, because SAFE_MAKE_SWAPFILE_BLKS() is
> called on more places.

Yes, not only it's directly used from the library, which affects all swapo{ff,n}
tests, but MAKE_SWAPFILE_BLKS() is also used directly by some of the tests.

Changing it to {SAFE_,}MAKE_SWAPFILE_SIZE() on all places would mean we don't need
{SAFE_,}MAKE_SWAPFILE_BLKS() at all. Therefore I think this check should be
suppressed to TINFO. Other option is to use high enough value (more blocks)
(not sure if using really small swap file makes sense anyway).

> Also, first is needed to move __FILE__, __LINE__ in macros (from function),
> sending patch...

https://lore.kernel.org/ltp/20240417123113.731780-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20240417123113.731780-1-pvorel@suse.cz/

Kind regards,
Petr

> Kind regards,
> Petr

> >         int fi_contiguous = file_is_contiguous(filename);
> >         long fs_type = tst_fs_type(filename);
> >         const char *fstype = tst_fs_type_name(fs_type);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
