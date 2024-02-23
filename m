Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE64CC54E41
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:54:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31D2A3D0074
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:54:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A5B13CCD37
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:54:12 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F37F1A0197A
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:54:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2253F1FBB5;
 Fri, 23 Feb 2024 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708692851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CtZIs0Se+bP1ghOCbU4fmgWQyOg7PhBPpj8jovGoDws=;
 b=mzyzWMLvMZGvfa/1cj+iU/LkICNkV+IaJsxVgCuo5PvGlxWZXgj6dLbNhDPrKhtXy5xFvk
 l6inO1Gak40MdgrPwNc1m7+Ax0X0Vvk1IwONHwxr3tGbn86r8dKdC0KGAjsuV9a2ICRc9k
 ihgDOqf4AHTtO6kEzII8oySjs3b9c74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708692851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CtZIs0Se+bP1ghOCbU4fmgWQyOg7PhBPpj8jovGoDws=;
 b=lPCAQuHKE17RikYJPegEF0QrUsLeSeMmhtatBqx6EUv2UlroDrnRpJRxT4TVj1ahlQDrWe
 VycDJdhD4Z2drMAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708692850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CtZIs0Se+bP1ghOCbU4fmgWQyOg7PhBPpj8jovGoDws=;
 b=a4lRmv6pac0y0P5pRGd6zjCgLubJaU8iwxxn2YOkhsFU2tJ6EVxO2pc79KFE1NHfeZ+4M7
 jkbQb9eLIZg7AFr9muubhtyERlI5MmLqLN8v81DYiPTjBRu67o18bXSFtSrII04NzAWCfm
 XjjtGfuOHFkN74yCtR4NmloT9xsoB2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708692850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CtZIs0Se+bP1ghOCbU4fmgWQyOg7PhBPpj8jovGoDws=;
 b=ah8h0MB0wYi/qUc4SH853A/CWhXY+w87TJ3h1aBXfBh2OSCxLqTfUeCbkqXcWrCMvUngiI
 oHMKHzcKmyF41fCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12EB6133DC;
 Fri, 23 Feb 2024 12:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ApFoA3KV2GVxegAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 Feb 2024 12:54:10 +0000
Date: Fri, 23 Feb 2024 13:53:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZdiVL4Gf8pkqsIW-@yuki>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104204614.1426027-5-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a4lRmv6p;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ah8h0MB0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.36 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,linux.it:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.35)[76.56%]
X-Rspamd-Queue-Id: 2253F1FBB5
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/9] metadata: test.sh: Print more info on
 VERBOSE=1
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
> diff --git a/metadata/tests/test.sh b/metadata/tests/test.sh
> index 475d721df..a00e32bb4 100755
> --- a/metadata/tests/test.sh
> +++ b/metadata/tests/test.sh
> @@ -3,6 +3,7 @@
>  fail=0
>  
>  for i in *.c; do
> +	[ "$VERBOSE" ] && echo "$0: testing $i"

Here as well, just use $V instead, and maybe it does not make sense to
print the $0. Possibly just "parsing $i".

>  	../metaparse $i > tmp.json
>  	if ! diff tmp.json $i.json >/dev/null 2>&1; then
>  		echo "***"
> @@ -15,4 +16,5 @@ done
>  
>  rm -f tmp.json
>  
> +[ "$VERBOSE" ] && echo "$fail"

Maybe it would make more sense to print pass/fail for each file, i.e.

Parsing array_size01.c Pass
Parsing array_size02.c Pass
Parsing array_size03.c Fail
...

>  exit $fail
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
