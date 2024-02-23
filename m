Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EBC5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:48:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0D033CF95C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:48:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DE8A3CCD37
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:47:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9451600858
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:47:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D66CD1FBB5;
 Fri, 23 Feb 2024 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708692468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BwOPeI1BXcqkYa9j+HvroHA9kfIqrSUh2mIo2UGLGg=;
 b=ZVvefiOIEmI9sNiZIbTFyvh4vrDgcKyGJH1ZysUnrlSz3B9/Ek/gVMaPEVqMTyaAr7Vuje
 gHOCrM2C2Uew4XyUFf+CqIY2G17e90RlSnmuHN390Xj2xCbK3mvi+8c6bsBUwOQLEEOZlg
 dFMjW6yiMnga8CuS99PsBJ5BAp1jOiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708692468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BwOPeI1BXcqkYa9j+HvroHA9kfIqrSUh2mIo2UGLGg=;
 b=VygQoozffFblHe14RH1Bp/t62WWeD65ZjBj80OjPzes/km0RIVqMcpgTmGcsrsmkrwv/2q
 JeXjboIQrTHDsFAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708692467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BwOPeI1BXcqkYa9j+HvroHA9kfIqrSUh2mIo2UGLGg=;
 b=zPRGCOX701S41hrCnFajTH3F15Y0cBXFmnvQn2s5Anxgv3oVWskRcXhLnauaNzJ5ZWTLJN
 +3ycvHNpE+6KW1dwSE7pqTJxRkzp+x5CLycCeIPNhp0aD6495guiBD5dqd6hLC1lyZsD6/
 TxgTTxgN0A+kTAfn2P/98cLHCiDf6/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708692467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BwOPeI1BXcqkYa9j+HvroHA9kfIqrSUh2mIo2UGLGg=;
 b=Ibg9RYmb5FdWtaHeYB64mxRg+xp9EDZ71DSV2SY8mNQ9ANZyJsNAQ5iBFDR+wMqzOWQkSy
 eFFJSsXAmtMwGqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC0F8133DC;
 Fri, 23 Feb 2024 12:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0ee0LPOT2GXxeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 Feb 2024 12:47:47 +0000
Date: Fri, 23 Feb 2024 13:46:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZdiTsXWqH-LkoxSQ@yuki>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104204614.1426027-4-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.91 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.it:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.11)[88.33%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/9] metadata: parse.sh: Pass -v to metaparse on
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
> +[ "$VERBOSE" ] && v="-v"

The build system uses just V=1 for a verbose mode so we should probably
be consistent...

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

>  for test in $tests; do
> -	a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
> +	a=$($top_builddir/metadata/metaparse $v -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
>  	if [ -n "$a" ]; then
>  		if [ -z "$first" ]; then
>  			echo ','
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
