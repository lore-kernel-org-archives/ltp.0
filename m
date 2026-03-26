Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937FA10A3D8C
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:33:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDE193CB2AA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:33:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13A9D3C1B73
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:33:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A645600067
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:33:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52D5B4D331;
 Thu, 26 Mar 2026 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774528385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtBex/pef7msMEIvuKBa/XJ/3V9W65OhyV1r42d0+o0=;
 b=PFGkOb/YGSbH0ptPddXIvdgt59eNVro/uCKN7SzVJGY3R95aBeSWpJxQJI3FNkVj2ShzM0
 53MyJWuGsB1u4ei3pqS41hfd+rTgMIooIveBeP6ToSeg1R/GNWM5EYLAP7fGjweZtLTPmW
 U9F2pQOf4SK9Q052HiZMT68XVcMYVTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774528385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtBex/pef7msMEIvuKBa/XJ/3V9W65OhyV1r42d0+o0=;
 b=SuFqLBuCaZDQ+k+gV0VJLYlqAGR/QMqTUPcJkhrdBrp79VItEqAFxYCMzDu72lPqUwhtzv
 /sLWmw2O6PIEV+DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="PFGkOb/Y";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SuFqLBuC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774528385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtBex/pef7msMEIvuKBa/XJ/3V9W65OhyV1r42d0+o0=;
 b=PFGkOb/YGSbH0ptPddXIvdgt59eNVro/uCKN7SzVJGY3R95aBeSWpJxQJI3FNkVj2ShzM0
 53MyJWuGsB1u4ei3pqS41hfd+rTgMIooIveBeP6ToSeg1R/GNWM5EYLAP7fGjweZtLTPmW
 U9F2pQOf4SK9Q052HiZMT68XVcMYVTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774528385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtBex/pef7msMEIvuKBa/XJ/3V9W65OhyV1r42d0+o0=;
 b=SuFqLBuCaZDQ+k+gV0VJLYlqAGR/QMqTUPcJkhrdBrp79VItEqAFxYCMzDu72lPqUwhtzv
 /sLWmw2O6PIEV+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B9D04A0A3;
 Thu, 26 Mar 2026 12:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jC9PHoAnxWntLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 12:33:04 +0000
Date: Thu, 26 Mar 2026 13:32:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <20260326123255.GB152048@pevik>
References: <69c4f09a.df0a0220.10eb49.07d8@mx.google.com>
 <33458536-f2e1-4ab8-a7b7-5882481dfa9b@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33458536-f2e1-4ab8-a7b7-5882481dfa9b@suse.de>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 52D5B4D331
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Minor fixes
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> On 3/26/26 9:38 AM, Andrea Cervesato wrote:
> > Hi ricardo,

> > > +	if (page) {
> > > +		SAFE_MUNMAP(page, page_size);
> > > +		SAFE_MUNMAP(copy_page, page_size);
> > > +		page =3D NULL;
> > > +	}
> > This is gonna TBROK when copy_page is NULL. The same apply to all other
> > tests which are affected by the same bug.

> Fixed in v3.

> BTW, we have a minor difference in tests:

> $ diff userfaultfd03.c userfaultfd06.c

> <=A0 =A0 =A0 =A0 =A0tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVE=
NT %d",
> msg.event);
> ---
> >=A0 =A0 =A0 =A0 =A0tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", m=
sg.event);

> I think we should have TFAIL, WDYT?

Yes, IMHO TFAIL.

Regards other cleanup: I again double checked if some test could be merged =
with
others but haven't found any.

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
