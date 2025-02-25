Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6584BC021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 08:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B685A3C9ACB
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 09:02:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1DF93C9A6B
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 09:02:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D0B841BD9414
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 09:02:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3270421189;
 Tue, 25 Feb 2025 08:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740470536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XT1Vw9mOgcUwgFMNLk9AZTt5QQFhOklvMdIT8Bvks0=;
 b=fFiuBXCXEdrY+rLng7kdUt6KIfVaayD/Hl2t661DvCpbliD07PLPfQt6EpTcIrso1f/oHH
 G2lTriwzRo1C3Zk3hcMoykb+6ECVCZlAw1FrUOMU7XugWNVAgcVQe2osbbgq53cBKWKfD+
 qI3i0Y5i2Blb1nuZXp2GX+GoAZsrp1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740470536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XT1Vw9mOgcUwgFMNLk9AZTt5QQFhOklvMdIT8Bvks0=;
 b=qscBknoiU6/oHfVvNQLhqqh4iiNcTE2UdA1p2ODXDLVvWMv6k+tlZ8nKGrYVBVIB2qoZ7M
 VnJxhlSRim7iSmAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740470536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XT1Vw9mOgcUwgFMNLk9AZTt5QQFhOklvMdIT8Bvks0=;
 b=fFiuBXCXEdrY+rLng7kdUt6KIfVaayD/Hl2t661DvCpbliD07PLPfQt6EpTcIrso1f/oHH
 G2lTriwzRo1C3Zk3hcMoykb+6ECVCZlAw1FrUOMU7XugWNVAgcVQe2osbbgq53cBKWKfD+
 qI3i0Y5i2Blb1nuZXp2GX+GoAZsrp1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740470536;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XT1Vw9mOgcUwgFMNLk9AZTt5QQFhOklvMdIT8Bvks0=;
 b=qscBknoiU6/oHfVvNQLhqqh4iiNcTE2UdA1p2ODXDLVvWMv6k+tlZ8nKGrYVBVIB2qoZ7M
 VnJxhlSRim7iSmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1335F13A61;
 Tue, 25 Feb 2025 08:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hgyMAwh5vWeLdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Feb 2025 08:02:16 +0000
Date: Tue, 25 Feb 2025 09:02:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250225080214.GB2901073@pevik>
References: <20250224100016.2857704-1-pvorel@suse.cz>
 <Z7yNVQAnQ5NPTtaz@yuki.lan> <20250224180057.GA2897036@pevik>
 <Z7y-jJplSsx0TXDs@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z7y-jJplSsx0TXDs@yuki.lan>
X-Spamd-Result: default: False [-6.25 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUBJECT_HAS_CURRENCY(1.00)[];
 NEURAL_HAM_LONG(-0.75)[-0.754]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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
> > > > -	if (tst_test->test_variants)
> > > > +	if (tst_test->test_variants) {
> > > >  		test_variants = tst_test->test_variants;
> > > > +		only_variant = getenv("LTP_SINGLE_VARIANT");
> > > > +		if (only_variant && only_variant[0] != '\0') {
> > > > +			tst_variant = MIN(SAFE_STRTOL((char *)only_variant, 0, INT_MAX),
> > > > +							  test_variants - 1);
> > > > +			tst_res(TINFO, "WARNING: testing only variant %d of %d",
> > > > +					tst_variant, test_variants - 1);
> > > > +			test_variants = tst_variant + 1;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	for (; tst_variant < test_variants; tst_variant++) {

> > > > -	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
> > > >  		if (tst_test->all_filesystems || count_fs_descs() > 1)
> > > >  			ret |= run_tcases_per_fs();
> > > >  		else

> > > Can we instead add a function that would set two integer variables,
> > > first_variant and last variant as:

> > > static void setup_variants(unsigned int *first_variant, unsigned int *last_variant)
> > > {
> > > 	//setup the defaults and parse the variables here
> > > }

> > Sure, I'll send v2 if you see the patch useful (Li was not sure if this is
> > useful).

> I do not have a strong opinion here, it may be mildly useful for test
> development, in some rare circumstances.

Yeah, that's why I put "Testing only" in the help.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
