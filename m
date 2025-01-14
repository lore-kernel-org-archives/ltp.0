Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F88E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:51:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA18E3C7AEB
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 16:51:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91C83C7AD6
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 16:51:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AC51102A4E4
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 16:51:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 11DCB1F37C;
 Tue, 14 Jan 2025 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736869870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjeqS26VpGF2iKB5igtxjOInWtoC/bkiQ3gpPzkjvlw=;
 b=RdgsIi2DHw/+ogBq5hFDzIKIe7RegrQn45Sx+RZb13pXEsYdGYndEIVJGKQymTp1J50SEe
 lNkDEjvtkOFGXWLtVyWuxVYlDg/44oKq1Cst020ip+d3+vwyvyBZ9lRetlpuDRUDqPfMfL
 Nwi8tJRhpYWul+VlBpw2eftMyHXpV7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736869870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjeqS26VpGF2iKB5igtxjOInWtoC/bkiQ3gpPzkjvlw=;
 b=yApCljMBJcXNddC262Vzn1sPaEMxrVuu3gDJzAHoP+83QEQokrgq85GyWTON2kUybRwk40
 iqJU5rUtu8qxJqAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RdgsIi2D;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yApCljMB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736869870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjeqS26VpGF2iKB5igtxjOInWtoC/bkiQ3gpPzkjvlw=;
 b=RdgsIi2DHw/+ogBq5hFDzIKIe7RegrQn45Sx+RZb13pXEsYdGYndEIVJGKQymTp1J50SEe
 lNkDEjvtkOFGXWLtVyWuxVYlDg/44oKq1Cst020ip+d3+vwyvyBZ9lRetlpuDRUDqPfMfL
 Nwi8tJRhpYWul+VlBpw2eftMyHXpV7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736869870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjeqS26VpGF2iKB5igtxjOInWtoC/bkiQ3gpPzkjvlw=;
 b=yApCljMBJcXNddC262Vzn1sPaEMxrVuu3gDJzAHoP+83QEQokrgq85GyWTON2kUybRwk40
 iqJU5rUtu8qxJqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03740139CB;
 Tue, 14 Jan 2025 15:51:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8wZfO+2HhmfcegAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 14 Jan 2025 15:51:09 +0000
Date: Tue, 14 Jan 2025 16:50:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4aH4LDbjgWDyLrW@yuki.lan>
References: <20241217213245.29778-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241217213245.29778-1-pvorel@suse.cz>
X-Rspamd-Queue-Id: 11DCB1F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> And yes, using shell runner to run netstress as a child would probably
> help, but logs would need to be printed immediately to be visible before
> calling tst_brk() from netstress.
> NOTE: Despite macro name TST_BRK_SUPPORTS_ONLY_TCONF_TBROK() the
> original concept in 0738e3753c allowed TFAIL as well.
> 
>     This patch adds simple build-check that allows only
>     TFAIL, TBROK and TCONF as parameter for tst_brk().
> 
>     TFAIL is currently quite commonly used as a shortcut for
>     TFAIL + exit() by many tests. I kept it for now, since
>     it doesn't go against current doc description.
> 
> And indeed C API allows tst_brk(TFAIL). Should we allow this also in
> shell API?

I think that it does make sense to have a reporting function that
reports a result and exits. The type of the result is really orthogonal
to the fact that the function does not return and both tst_brk(TFAIL,
...) and even tst_brk(TPASS, ...) do make sense.

The rules that we enforced on tst_brk() were mainly because of the
limits of the implementation details that should have been fixed in the
library instead.

> Also Cyril suggested for C API different approach:
> 
> https://patchwork.ozlabs.org/project/ltp/patch/20241115164101.17983-1-chrubis@suse.cz/
> 
> Therefore we should probably agree what to do with C API and then unify shell API.

I suppose so.

>  testcases/lib/tst_net.sh | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index ee0ae1cad7..d44115d758 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -713,9 +713,17 @@ tst_wait_ipv6_dad()
>  
>  tst_netload_brk()
>  {
> +	local res="$1"
> +	local msg="$2"
> +
>  	tst_rhost_run -c "cat $TST_TMPDIR/netstress.log"
>  	cat tst_netload.log
> -	tst_brk_ $1 $2
> +
> +	if [ "$res" = TFAIL ]; then
> +		tst_res_ "$res" "$msg"
> +	else
> +		tst_brk_ "$res" "$msg"
> +	fi
>  }
>  
>  # Run network load test, see 'netstress -h' for option description
> @@ -825,28 +833,31 @@ tst_netload()
>  		fi
>  
>  		if [ "$ret" -ne 0 ]; then
> -			[ $((ret & 32)) -ne 0 ] && \
> -				tst_netload_brk TCONF "not supported configuration"
> +			[ $((ret & 32)) -ne 0 ] && tst_netload_brk TCONF "not supported configuration"
>  
> -			[ $((ret & 3)) -ne 0 -a $was_failure -gt 0 ] && \
> +			if [ $((ret & 3)) -ne 0 -a $was_failure -gt 0 ]; then
>  				tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
> +				return
> +			fi
>  
>  			tst_res_ TWARN "netstress failed, ret: $ret"
>  			was_failure=1
>  			continue
>  		fi
>  
> -		[ ! -f $rfile ] && \
> +		if [ ! -f $rfile ]; then
>  			tst_netload_brk TFAIL "can't read $rfile"
> +			return
> +		fi
>  
>  		results="$results $(cat $rfile)"
>  		passed=$((passed + 1))
>  	done
>  
>  	if [ "$ret" -ne 0 ]; then
> -		[ $((ret & 4)) -ne 0 ] && \
> -			tst_res_ TWARN "netstress has warnings"
> +		[ $((ret & 4)) -ne 0 ] && tst_res_ TWARN "netstress has warnings"
>  		tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
> +		return
>  	fi
>  
>  	local median=$(tst_get_median $results)

As for this patch, wouldn't it make more sense to allow tst_brk_ TFAIL
instead, who knows how many places in shell stil use that...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
