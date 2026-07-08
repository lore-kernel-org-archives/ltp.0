Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF36C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 14:02:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E2173E5CDE
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 16:02:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CA6F3E5CA8
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 16:02:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D36192009E9
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 16:02:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A33E1748F1;
 Wed,  8 Jul 2026 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783519323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0x/YYJOjpRHxX5BvjOTYHU1GfqrOTgnDfmsHfobPi88=;
 b=BSNdl9IJHqp28yeonXCuTbsVS0keP504tvmRk7ngqHNqP2LKojulq1GIXYptOBUl+QjG6m
 M3jqATwlgeWWp0qJFjS7YEuDb+mFvjigJkIJHjmS9FHmZkX5JUjpq7GcaLXv3x3+ZPAU8o
 aw9sl/PxbzWqcbsy4jEYIPC8XS6jWU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783519323;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0x/YYJOjpRHxX5BvjOTYHU1GfqrOTgnDfmsHfobPi88=;
 b=gZ5Fp6AXlWAagcmXmAFN1f/dsHTIfKGZQztfTO3ZBMpwAgGSzXbTLGFgWYqHPV47ElIqis
 pRE24SZQOnwKIdBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Rq5/lV2V";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1SVHQTQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783519319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0x/YYJOjpRHxX5BvjOTYHU1GfqrOTgnDfmsHfobPi88=;
 b=Rq5/lV2VpgKl2nd4v0use0bnQJgLPPVcGSsJNXbIu4OLKAY09PYcdlIcjW72YlAaybos5e
 4AcMbB07Xv7cT+6G6+GmClV25RBKLoo/1OBEQa8vYCtKupIjgWMSr+GdEvgmmJEJwUReIj
 OKd3VTPIyLEgMw0jFFJbG3LTLRCC1xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783519319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0x/YYJOjpRHxX5BvjOTYHU1GfqrOTgnDfmsHfobPi88=;
 b=1SVHQTQ9cttv0gD/nBFqrX4Zjxl6lXK5tBmTFB873fi2W8Q126wjD/rWjNX1ucVhJiRPyR
 wQefVwJHfdtE02Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B9B6779AE;
 Wed,  8 Jul 2026 14:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id glvhFlRYTmrRZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Jul 2026 14:01:56 +0000
Date: Wed, 8 Jul 2026 16:01:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260708140154.GC125128@pevik>
References: <20260704085703.618290-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260704085703.618290-1-avinesh.kumar@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A33E1748F1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test.sh: TCONF on xfrm algorithms rejected
 via netlink extack
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

Hi Avinesh,

> TST_RTNL_CHK maps a kernel's "not supported" reply to TCONF by matching
> the "RTNETLINK answers: ..." strings. Since v6.1 the kernel reports an
> unknown/removed xfrm algorithm with -ENOSYS plus a netlink extack
> message, which iproute2 prints as:

> Error: Requested AUTH algorithm not found.

> This matches none of the existing strings, so TST_RTNL_CHK() reports
> TBROK instead of skipping.

> tcp_ipsec 1 TBROK: ip xfrm state add src 10.0.0.2 dst 10.0.0.1 spi 0x1000 proto esp enc serpent 0x81ea7757e7c71dc8f95bee692c0e8b1a2ac6e006066e74ce0024a54ee0175b70 auth hmac(rmd160) 0xf46316501051af3e3b2abd0bdfed7cf21a76fe04 mode transport sel src 10.0.0.2 dst 10.0.0.1 failed: Error: Requested AUTH algorithm not found.

Thanks for finding it!

> This surfaced with kernel v7.1 commit
> 05d42dc8ab92 ("xfrm: Drop support for HMAC-RIPEMD-160")
> which removed hmac(rmd160) and broke the
> net_stress.ipsec_* "-a rmd160" variants. Match the extack form too.

+1 for documenting the change.

> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  testcases/lib/tst_test.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 2a83c17a5efb..8701bb390388 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -266,13 +266,18 @@ TST_RTNL_CHK()
>  	local msg1="RTNETLINK answers: Function not implemented"
>  	local msg2="RTNETLINK answers: Operation not supported"
>  	local msg3="RTNETLINK answers: Protocol not supported"
> +	# Since v6.1 the kernel reports an unknown/removed xfrm algorithm via
> +	# netlink extack (-ENOSYS + NL_SET_ERR_MSG), which iproute2 prints as
> +	# "Error: Requested AUTH algorithm not found."
> +	local msg4="Requested .* algorithm not found"
>  	local output="$($@ 2>&1 || echo 'LTP_ERR')"
nit: we have in $output also "LTP_ERR" in the end (on error)...

> -	local msg
> +	local msg match

>  	echo "$output" | grep -q "LTP_ERR" || return 0

> -	for msg in "$msg1" "$msg2" "$msg3"; do
> -		echo "$output" | grep -q "$msg" && tst_brk TCONF "'$@': $msg"
> +	for msg in "$msg1" "$msg2" "$msg3" "$msg4"; do
> +		match=$(echo "$output" | grep "$msg") && \
> +				tst_brk TCONF "'$@': $match"
... now we print error message also with "LTP_ERR" in the end.
I wonder if we should bother with removing it, e.g. with sed:

-		match=$(echo "$output" | grep "$msg") && \
+		match=$(echo "$output" | grep "$msg" | sed 's/LTP_ERR$//') && \

(untested)

Both w/a this change (can be done before merge).
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
