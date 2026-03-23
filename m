Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66291EC01D4
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 12:06:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEB2E3E3037
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 13:06:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4FC53CE62C
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:06:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C24A1A00A49
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:06:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1398F5BDCD;
 Mon, 23 Mar 2026 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774267592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uv/FqFJET2KMu9C+j1ldlaU2H/Ug7uWq8Wn5A5Wlo38=;
 b=0SZK9lv6C8tw38WpAaBiz5EfevZoau5N1WzKHEU3yfoX0uzPVzHJPw3TAcsfw93KZJMlOP
 e0Een6uzfVIXm7lNy9T1I6NrPII8pc8mNO5iCzfualarq+XCpJJ6nt53iEZ7aUz3pKLMVQ
 malhwJqLvCAgxVKzoUMur+9JYtd2xcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774267592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uv/FqFJET2KMu9C+j1ldlaU2H/Ug7uWq8Wn5A5Wlo38=;
 b=j0RTP4qDk/pgaL9HZC8gR3/cmgawJEz4Uz6cD4mIjwXizPD42L24/W3tVbPYZWbI4/FMw3
 pgZNT4kF+kjXlDAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774267592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uv/FqFJET2KMu9C+j1ldlaU2H/Ug7uWq8Wn5A5Wlo38=;
 b=0SZK9lv6C8tw38WpAaBiz5EfevZoau5N1WzKHEU3yfoX0uzPVzHJPw3TAcsfw93KZJMlOP
 e0Een6uzfVIXm7lNy9T1I6NrPII8pc8mNO5iCzfualarq+XCpJJ6nt53iEZ7aUz3pKLMVQ
 malhwJqLvCAgxVKzoUMur+9JYtd2xcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774267592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uv/FqFJET2KMu9C+j1ldlaU2H/Ug7uWq8Wn5A5Wlo38=;
 b=j0RTP4qDk/pgaL9HZC8gR3/cmgawJEz4Uz6cD4mIjwXizPD42L24/W3tVbPYZWbI4/FMw3
 pgZNT4kF+kjXlDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAA4A4387A;
 Mon, 23 Mar 2026 12:06:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BsUiOMcswWnJBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 12:06:31 +0000
Date: Mon, 23 Mar 2026 13:06:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260323120626.GA315436@pevik>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-3-pvorel@suse.cz>
 <abq1-BcXR1nfLGcU@yuki.lan> <20260318150252.GA31214@pevik>
 <ab1zwXCUui24rmmC@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab1zwXCUui24rmmC@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,tst_test.sh:url,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] tst_env.sh: Backport common functions from
 tst_test.sh
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > SAFE instead so that the name is closer to the SAFE_XXX macros in C.

> > Makes sense. I was even thinking on SAFE_CMD, but we use tst_rod.c, not
> > tst_cmd.c. OTOH it was obvious that ROD uses tst_rod.c, should it be also
> > renamed? What ROD means anyway? run or dye?

> Run or die (we are not coloring anything).

> And yes it would make sense to rename tst_rod.c to tst_safe_cmd.c or
> similar.

+1, I'll do in next version.

> > > > +_tst_expect_pass()
> > > > +{
> > > > +	local fnc="$1"
> > > > +	shift
> > > > +
> > > > +	tst_rod "$@"

> > > If I remmeber correctly the whole reason why we introduced tst_rod.c was
> > > that passing the $@ like this causes the $@ to be evaluated twice and
> > > produces unexpected results.

> > FYI code is copy pasted from tst_test.sh. What do you want me to change?

> I've spend a couple of minutes figuring out why we originaly implemented
> ROD_BASE() in C.

> The problem is that single quotes gets removed as soon as we pass the
> parameter.

> E.g.: ROD awk '{ print $1 }'

> Once we pass that to a shell function the '' disappear, they managed to
> keep the { print $1 } to be a single parameter in the list but they are
> not there anymore.

Yeah, I've found this shell limitation in the past as well.

> And since we were manipulating the parameter list we got, we failed to
> reconstruct it correctly in shell since in the next step the { print $1 }
> breaks into four separate strings.

> As long as we pass the $@ as a whole (even after shift), it does work
> since the boundaries of parameters in $@ stay exactly as they were.

> TL;DR; The code you copy&pasted is correct, I only misremembered what
> was the problem back then.

Good, I was worried it was something else needed to be fixed. Thanks for double
checking!

> > > I'm not sure that adding the PASS_BRK and FAIL_BRK is a good idea. I
> > > would stick to simple EXPECT_PASS and EXPECT_FAIL. And maybe we can
> > > export TST_PASS variable as we do in C to match the API. I think that
> > > the closer the C and shell API are the better.

> > C API usually returns on if (!TST_PASS). I don't like it either, but it cannot
> > be shortened much as we don't use functions but macros.

> > But changing the code in the shell API does not look to me an improvement:

> > -EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null
> > +EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null
> > +[ "$TST_PASS" = 1 ] || tst_brk "Quit due the above error"

> Let's keep it then.

+1. We can revisit it later. Anyway, I'll add only what's currently needed,
maybe these network tests will be changed or rewritten into C.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
