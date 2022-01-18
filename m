Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C072C433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 13:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD58A3C9662
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 14:00:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 325883C9683
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 14:00:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA7AC1400528
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 14:00:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC1251F3A1;
 Tue, 18 Jan 2022 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642510823;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ro0O3EiGBLkAHyLF5ZViq2rRa8i+FFiWPX0kR2/2u9g=;
 b=SYL1bNkf3uZxLc0CdzXRm6bhW/hRQrt8e3t2WCIicGaJa3fByw+UWE6BYVqS2UrKVF4Dc+
 zTBHeAMvjHe3Qz2KWM1bMG47WRVXlN/P5+K0VutXO5Tew6ClAlTqlAW+JkofzjBEcagVBh
 39bp2tdr70zNb9bKdGnF+rZGlVWNJV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642510823;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ro0O3EiGBLkAHyLF5ZViq2rRa8i+FFiWPX0kR2/2u9g=;
 b=tdh2awB+9OThZizJfz2yFtF+whWIfjnxOsnxSWYpL42TPlA/1nWWntVmaEWZn0ZPOAM2CL
 l00IwWppNBuBEYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7665D13A96;
 Tue, 18 Jan 2022 13:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eqcPG+e55mFWBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jan 2022 13:00:23 +0000
Date: Tue, 18 Jan 2022 14:00:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yea55fzU/RRqPPPa@pevik>
References: <20220114161612.206475-1-kushalkataria5@gmail.com>
 <26152227-acdf-50a4-e1bc-1a1850880040@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26152227-acdf-50a4-e1bc-1a1850880040@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fixes: #776,
 tst_taint prints human readable error messages instead of numerical
 codes
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
Cc: Kushal Chand <kushalkataria5@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, Kushal,

...
> > +const char *tst_strtaint(int err)
> > +{
> > +	static const struct pair taint_pairs[] = {
> > +		STRPAIR(TST_TAINT_A, "TAINT_A(ACPI table overridden)")
> > +		STRPAIR(TST_TAINT_B, "TAINT_B(Bad page reference)")
> > +		STRPAIR(TST_TAINT_C, "TAINT_C(Staging driver loaded)")
> > +		STRPAIR(TST_TAINT_D, "TAINT_D(OOPS/BUG)")
> > +		STRPAIR(TST_TAINT_E, "TAINT_E(Unsigned module loaded)")
> > +		STRPAIR(TST_TAINT_F, "TAINT_F(Module force loaded)")
> > +		STRPAIR(TST_TAINT_G, "TAINT_G(Propriety module loaded)")
> > +		STRPAIR(TST_TAINT_I, "TAINT_I(Workaround BIOS/FW bug)")
> > +		STRPAIR(TST_TAINT_K, "TAINT_K(Live patched)")
> > +		STRPAIR(TST_TAINT_L, "TAINT_L(Soft lock up occured)")
> > +		STRPAIR(TST_TAINT_M, "TAINT_M(Machine check exception)")
> > +		STRPAIR(TST_TAINT_O, "TAINT_O(Out of tree module loaded)")
> > +		STRPAIR(TST_TAINT_R, "TAINT_R(Module force unloaded)")
> > +		STRPAIR(TST_TAINT_S, "TAINT_S(Running on out of spec system)")
> > +		STRPAIR(TST_TAINT_T, "TAINT_T(Built with struct randomization)")
> > +		STRPAIR(TST_TAINT_U, "TAINT_U(User request)")
> > +		STRPAIR(TST_TAINT_W, "TAINT_W(Warning)")
> > +		STRPAIR(TST_TAINT_X, "TAINT_X(Auxilary)")
> > +	};
> > +
> > +	PAIR_LOOKUP(taint_pairs, err);

> This is not the correct approach. You've constructed an array with
> 131,073 items to store a total of 18 strings. And the value passed in
> the "err" parameter is a bitmask which can hold multiple taint flags.

> What you should do is this:

> const char *taint_strings[] = {
> 	"G (Propriety module loaded)",
> 	"F (Module force loaded)",
> 	"S (Running on out of spec system)",
> 	"R (Module force unloaded)",
> 	...
> 	"X (Auxilary)",
> 	"T (Built with struct randomization)"
> };

> Then loop from 0 to ARRAY_SIZE(taint_strings) and print taint_strings[i]
> if (err & (1 << i)) != 0

Martin thanks a lot for correcting me. Kushal, I'm sorry for wrong advice,
please follow Martin's suggestion in v3.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
