Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E13D38FED
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 16:46:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FC8A3CA012
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 17:46:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7189B3C9EA7
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 17:46:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06EBC600A53
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 17:46:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52ADC34776;
 Wed, 14 Jan 2026 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768409179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
 b=NU6PJ0RQmBAvRrTVG3MIFV5LW6LawLFlOJqUNrmuWbcJUkO8jhE3Gz2fdWj+nxJnOCLl7e
 oir1JnY2mSXh8AXD/C0enkGdfDHqy39Lksnkn/XVbqIJ3ZzPODN4OuJxgNELCiDxPZpBPn
 mu11LT3XvsgP5hsytTv8abXIJMw4uds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768409179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
 b=RfXCqNsCMV59mCV8nmnUpry7sTk29T6DmyrF2WxV2X2028md/PcHQhq5KNfbLfXbK5QZuJ
 eTJ2NxGbkrTqZCCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768409179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
 b=NU6PJ0RQmBAvRrTVG3MIFV5LW6LawLFlOJqUNrmuWbcJUkO8jhE3Gz2fdWj+nxJnOCLl7e
 oir1JnY2mSXh8AXD/C0enkGdfDHqy39Lksnkn/XVbqIJ3ZzPODN4OuJxgNELCiDxPZpBPn
 mu11LT3XvsgP5hsytTv8abXIJMw4uds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768409179;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4hayO0Og4ICjAYyQZZOg5Q0xwwWpPhddrykOhPmIlc=;
 b=RfXCqNsCMV59mCV8nmnUpry7sTk29T6DmyrF2WxV2X2028md/PcHQhq5KNfbLfXbK5QZuJ
 eTJ2NxGbkrTqZCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 363ED3EA63;
 Wed, 14 Jan 2026 16:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Nx46DFvIZ2lqWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 16:46:19 +0000
Date: Wed, 14 Jan 2026 17:46:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20260114164617.GB426021@pevik>
References: <20260107155737.791588-1-pvorel@suse.cz>
 <20260107155737.791588-2-pvorel@suse.cz>
 <41d432e3b9c16d712080295235ca000a6cb6e07c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41d432e3b9c16d712080295235ca000a6cb6e07c.camel@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ima_kexec.sh: Document kernel config
 dependencies
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi, all,

> On Wed, 2026-01-07 at 16:57 +0100, Petr Vorel wrote:
> > CONFIG_HAVE_IMA_KEXEC=3Dy is enough for test, ie. test is working with:

> >     # CONFIG_IMA_KEXEC is not set
> >     CONFIG_HAVE_IMA_KEXEC=3Dy

> > Probably obvious as CONFIG_HAVE_IMA_KEXEC is arch specific and
> > CONFIG_IMA_KEXEC is "TPM PCRs are only reset on a hard reboot."
> > and ima_kexec.c requires CONFIG_HAVE_IMA_KEXEC (only parts are skipped
> > when CONFIG_IMA_KEXEC not set) but better to clarify for users.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/kernel/security/integrity/ima/tests/ima_kexec.sh | 3 +++
> >  1 file changed, 3 insertions(+)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh=
 b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> > index 7688690af2..de595fcdd7 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> > @@ -6,8 +6,11 @@

> >  # Verify that kexec cmdline is measured correctly.
> >  # Test attempts to kexec the existing running kernel image.
> > +#
> >  # To kexec a different kernel image export IMA_KEXEC_IMAGE=3D<pathname=
>.
> >  # Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=
=3D1.
> > +#
> > +# Test requires CONFIG_HAVE_IMA_KEXEC=3Dy (CONFIG_IMA_KEXEC is not man=
datory).

> Correct.=A0 The test verifies that the kernel image is measured.  It does=
 not
> execute the kexec, so there is no need for carrying the IMA measurement l=
ist
> across kexec (CONFIG_IMA_KEXEC).

Thanks for having a look! I merged with your RBT (as we dicussed).

Kind regards,
Petr

> >  TST_NEEDS_CMDS=3D"grep kexec sed"
> >  TST_CNT=3D3

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
