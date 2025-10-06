Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FCECAC5B8
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 11:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E64583CE1BC
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 13:21:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DBD93C0BD0
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 13:21:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 59FE31400267
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 13:21:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CABDE336CB;
 Mon,  6 Oct 2025 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759749699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
 b=zsPAJ7ysgftxFD33BPMJjUutYtNIRQWe1FiEB80FTLLpKApy9Kk4/lL0d027UbydOTkQu3
 826Q11gXkaiD/L7yka9ozoJdOP+o7gT/xijeJOycdtpXIc9JCCnGsBh8bBaDmkq4suQUo8
 6iq8iSRDp4Mn+CbkfF5jp3T7UXZ22d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759749699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
 b=s2opiChTsn53RkQRlWMHYj3ya3B6hNEOOtu6I2rP74lDdGVQNQNJp2ASPaaROdpK2JL4nt
 N5C2OpqE8kwnN/AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759749699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
 b=zsPAJ7ysgftxFD33BPMJjUutYtNIRQWe1FiEB80FTLLpKApy9Kk4/lL0d027UbydOTkQu3
 826Q11gXkaiD/L7yka9ozoJdOP+o7gT/xijeJOycdtpXIc9JCCnGsBh8bBaDmkq4suQUo8
 6iq8iSRDp4Mn+CbkfF5jp3T7UXZ22d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759749699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
 b=s2opiChTsn53RkQRlWMHYj3ya3B6hNEOOtu6I2rP74lDdGVQNQNJp2ASPaaROdpK2JL4nt
 N5C2OpqE8kwnN/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E216913700;
 Mon,  6 Oct 2025 11:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n00aKkKm42gJYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 Oct 2025 11:21:38 +0000
Date: Mon, 6 Oct 2025 13:21:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251006112136.GA82874@pevik>
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
 <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi!

> On Thu Oct 2, 2025 at 10:36 AM CEST, Petr Vorel wrote:
> > This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLICY=y
> > (disabled by default in mainline, therefore disabled for some distros,
> > e.g. openSUSE Tumbleweed), if SUT reboots.

> > The downside is creating user account 4x instead just once.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  runtest/ima                                   |  5 +-
> >  .../integrity/ima/tests/ima_conditionals.sh   | 67 ++++++++++++-------
> >  2 files changed, 47 insertions(+), 25 deletions(-)

> > diff --git a/runtest/ima b/runtest/ima
> > index 01942eefa3..c8d0c6801e 100644
> > --- a/runtest/ima
> > +++ b/runtest/ima
> > @@ -6,5 +6,8 @@ ima_violations ima_violations.sh
> >  ima_keys ima_keys.sh
> >  ima_kexec ima_kexec.sh
> >  ima_selinux ima_selinux.sh
> > -ima_conditionals ima_conditionals.sh
> > +ima_conditionals_uid ima_conditionals.sh -r uid
> > +ima_conditionals_fowner ima_conditionals.sh -r fowner
> > +ima_conditionals_gid ima_conditionals.sh -r gid
> > +ima_conditionals_fgroup ima_conditionals.sh -r fgroup

> Why not using multiple test cases inside the test?

That would not help. I hoped I explained the reason well in the commit message
but obviously I didn't.

verify_measurement() writes into /sys/kernel/security/ima/policy which on
kernels without CONFIG_IMA_WRITE_POLICY requires SUT reboot. Because LTP does
not support any reboot, this needs to be handled after test finishes. That's why
I separated the tests. This helps to cover more than the first test case out of
four.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
