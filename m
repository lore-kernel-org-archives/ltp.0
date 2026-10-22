Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF702606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=rvknBjZL;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xk3ck0Cl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cdk1XyHU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IDwEITbi
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77DDB3D24DD
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:57:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE1143D19DB
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:56:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3406E6012A4
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:56:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7AE122144;
 Thu, 22 Oct 2026 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792677417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvnpUZVKAcYkHG4hIG0dXrm2Iu2GqbtQ5u7VoxIqeH4=;
 b=rvknBjZL6iVVX+T9FrorB0ZUTigUcNxwktsJ40peBv//ycy6H2hBLRNRUokgYWTQztWyWs
 KUpBm9ejutJmH/2KRxhyQYUK8+tyLucMOgI6A8tRrhKOiKypB7gQKT/pK3m9OHWxT18eU2
 j5AifBOZ+C1h6h5Oxq8/gF410YYEAT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792677417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvnpUZVKAcYkHG4hIG0dXrm2Iu2GqbtQ5u7VoxIqeH4=;
 b=xk3ck0Clo2oBYPy086aRNM8FcW6LV1ka2r7Uabs4go49rwqqCdLaxJb2WmpVURYXBRG2Ol
 72O4fRxjQVTpiQCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792677416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvnpUZVKAcYkHG4hIG0dXrm2Iu2GqbtQ5u7VoxIqeH4=;
 b=cdk1XyHU958+2hTPmQf3bmaxUgdk7jIt/oLAqm905bj9/6FlOR6Pol0bRPt2sB3G35oevV
 Qtq03R7G0u6XNTgTjpQkBQeXk9GjHtm7g40Gai7v4PNuHcCucJCtYKEM/Fez3P7kPP1wBv
 Jw8rZFNNqbjmXCCjzUSLSI4Yqe9kkek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792677416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvnpUZVKAcYkHG4hIG0dXrm2Iu2GqbtQ5u7VoxIqeH4=;
 b=IDwEITbijluYHVBJpIvkGZ1ktyMbmCk5fVjDKxBESbYJdtrjo2XE7T4HN9vPsCchnkHcYx
 D14YXIHu9/d4OjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B35C8133F3;
 Thu, 22 Oct 2026 13:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eaA+ISgW2mrwCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Oct 2026 13:56:56 +0000
Date: Thu, 22 Oct 2026 15:57:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
Message-ID: <atoWPWKybppsE1_8@yuki.lan>
References: <20261021024758.13541-1-kuan-ying.lee@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021024758.13541-1-kuan-ying.lee@canonical.com>
X-Spamd-Result: default: False [-17.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -17.30
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] binfmt_misc02.sh: Fix interpreter with
 uutils/coreutils
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: po-hsu.lin@canonical.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The test registers the system 'cat' directly as a binfmt_misc
> interpreter and expects executing the data files to echo their content
> back.
> 
> This breaks on distributions shipping the Rust uutils/coreutils
> implementation (e.g. Ubuntu "Resolute"), where 'cat' is a hardlink to a
> single multi-call 'coreutils' binary:
> 
>   $ readlink -f /usr/bin/cat
>   /usr/lib/cargo/bin/coreutils/cat
>   $ cat --version
>   cat (uutils coreutils) 0.8.0

That does sound like a bug in rust coreutils to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
