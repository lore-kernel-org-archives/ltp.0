Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719ABE77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 16:16:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9043C7B25
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 17:16:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCF743C7A7A
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 17:16:15 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 22CD91BDC7C7
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 17:16:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 942622116A;
 Tue, 14 Jan 2025 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736871373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGEIXkSD2ifQ6Pe81K/5/u0F7jukFfe92hHz0P0QyAI=;
 b=mVm9i+ezJ2YRhT4utCM55WUU4x/jdmaGdd9radOC+4Mz2nOVCvn3OfIC8YseHmW5BWGGml
 ONJHbbaFW/IvWN0bn/Kqpkz91bJ2T7C9SHBoCd6yxK/nKHr+K9FjWTxnCTAWjOfBuB0eHF
 gNmuzyN/eO7LT+4z5y0lvFiv0zSBfhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736871373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGEIXkSD2ifQ6Pe81K/5/u0F7jukFfe92hHz0P0QyAI=;
 b=AUCmmh6QJ7x+z6UntV1eNKTVV4rQw8g/jed52C9OmQ9KmAEXLSoSKID0DGBPUQB2SVXG11
 8KamXUZ3+7Dh83Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736871372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGEIXkSD2ifQ6Pe81K/5/u0F7jukFfe92hHz0P0QyAI=;
 b=QHVtp/7OpnO9dPgoL+6uqSusbJgBIhjzVAOrV+VNY9wdEQbiTdajLAHnB1aPwTs8MKcOdV
 dtVwtIPwXjCmnYbN7GcBGY+b/WkMPhytI9XdHtRhI1nVrfFJqf3twbcAgMxYXZL2tlUMxs
 QWw8MwSbJjvbioNx+WWBK9CZDAcWaDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736871372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGEIXkSD2ifQ6Pe81K/5/u0F7jukFfe92hHz0P0QyAI=;
 b=P9YoaUpdqcrpJ3pbFysa7Mx/ZymkFT38TJJBDBYER07vFL318p8piIxmDMgnxED5F8htq+
 bXHUsSgsD+seKyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6550D139CB;
 Tue, 14 Jan 2025 16:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n5UxF8yNhmf2AwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 16:16:12 +0000
Date: Tue, 14 Jan 2025 17:16:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250114161606.GA619334@pevik>
References: <20241217213245.29778-1-pvorel@suse.cz> <Z4aH4LDbjgWDyLrW@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4aH4LDbjgWDyLrW@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/1] tst_net.sh: Fix calling tst_brk with
 TFAIL
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
> > And yes, using shell runner to run netstress as a child would probably
> > help, but logs would need to be printed immediately to be visible before
> > calling tst_brk() from netstress.
> > NOTE: Despite macro name TST_BRK_SUPPORTS_ONLY_TCONF_TBROK() the
> > original concept in 0738e3753c allowed TFAIL as well.

> >     This patch adds simple build-check that allows only
> >     TFAIL, TBROK and TCONF as parameter for tst_brk().

> >     TFAIL is currently quite commonly used as a shortcut for
> >     TFAIL + exit() by many tests. I kept it for now, since
> >     it doesn't go against current doc description.

> > And indeed C API allows tst_brk(TFAIL). Should we allow this also in
> > shell API?

> I think that it does make sense to have a reporting function that
> reports a result and exits. The type of the result is really orthogonal
> to the fact that the function does not return and both tst_brk(TFAIL,
> ...) and even tst_brk(TPASS, ...) do make sense.

> The rules that we enforced on tst_brk() were mainly because of the
> limits of the implementation details that should have been fixed in the
> library instead.

> > Also Cyril suggested for C API different approach:

> > https://patchwork.ozlabs.org/project/ltp/patch/20241115164101.17983-1-chrubis@suse.cz/

> > Therefore we should probably agree what to do with C API and then unify shell API.

> I suppose so.

> >  testcases/lib/tst_net.sh | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)

> > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> > index ee0ae1cad7..d44115d758 100644
> > --- a/testcases/lib/tst_net.sh
> > +++ b/testcases/lib/tst_net.sh
> > @@ -713,9 +713,17 @@ tst_wait_ipv6_dad()

> >  tst_netload_brk()
> >  {
> > +	local res="$1"
> > +	local msg="$2"
> > +
> >  	tst_rhost_run -c "cat $TST_TMPDIR/netstress.log"
> >  	cat tst_netload.log
> > -	tst_brk_ $1 $2
> > +
> > +	if [ "$res" = TFAIL ]; then
> > +		tst_res_ "$res" "$msg"
> > +	else
> > +		tst_brk_ "$res" "$msg"
> > +	fi
> >  }

> >  # Run network load test, see 'netstress -h' for option description
> > @@ -825,28 +833,31 @@ tst_netload()
> >  		fi

> >  		if [ "$ret" -ne 0 ]; then
> > -			[ $((ret & 32)) -ne 0 ] && \
> > -				tst_netload_brk TCONF "not supported configuration"
> > +			[ $((ret & 32)) -ne 0 ] && tst_netload_brk TCONF "not supported configuration"

> > -			[ $((ret & 3)) -ne 0 -a $was_failure -gt 0 ] && \
> > +			if [ $((ret & 3)) -ne 0 -a $was_failure -gt 0 ]; then
> >  				tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
> > +				return
> > +			fi

> >  			tst_res_ TWARN "netstress failed, ret: $ret"
> >  			was_failure=1
> >  			continue
> >  		fi

> > -		[ ! -f $rfile ] && \
> > +		if [ ! -f $rfile ]; then
> >  			tst_netload_brk TFAIL "can't read $rfile"
> > +			return
> > +		fi

> >  		results="$results $(cat $rfile)"
> >  		passed=$((passed + 1))
> >  	done

> >  	if [ "$ret" -ne 0 ]; then
> > -		[ $((ret & 4)) -ne 0 ] && \
> > -			tst_res_ TWARN "netstress has warnings"
> > +		[ $((ret & 4)) -ne 0 ] && tst_res_ TWARN "netstress has warnings"
> >  		tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
> > +		return
> >  	fi

> >  	local median=$(tst_get_median $results)

> As for this patch, wouldn't it make more sense to allow tst_brk_ TFAIL
> instead, who knows how many places in shell stil use that...

Sure, I'm not against it. We would just simply revert
1878502f63 ("tst_test.sh/tst_brk(): Allow only TBROK and TCONF")

BTW we have a real problem in shell when calling tst_brk in code evaluated in
$(...) with cd on mounted device. I fixed one of these problems:
304d4178a7 ("IMA: Fix exit test on subprocess")
but it would be great to have better solution. This will not be fixed by shell
loader.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
