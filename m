Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD84C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 15:40:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11BDE3CF782
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 17:40:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD3333C095C
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 17:40:12 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 118521A00CB0
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 17:40:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 647CB350EB;
 Thu, 18 Apr 2024 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713454810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RFkv4TPORJMsS2tOCnIl0TvzqB89r2pzbGNYnu2htCY=;
 b=hPIw9lML978wuAjoe1EVUAB5F11K2/js4BIEmo1eP0Ph6QcDeqwFVfwfJklLpfAiwpBJL9
 zcGej/JdlbOKWxuXtXsZIxNpLPykyIdV8Ay2+bWphdq7GOCuMaTTNFm83iUvbxJIGWPcP8
 APDg5OQkxo7ZjYwQfUc0Zp+ZaJHms14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713454810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RFkv4TPORJMsS2tOCnIl0TvzqB89r2pzbGNYnu2htCY=;
 b=+ZVhDg69oDp4zXimPQlNjb0VH9IvqnNCggHniIEbpW0nWqyGPn2wv9JDU/BzPTe8NF6SWn
 nXFs6iEZjZeNXJCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713454810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RFkv4TPORJMsS2tOCnIl0TvzqB89r2pzbGNYnu2htCY=;
 b=hPIw9lML978wuAjoe1EVUAB5F11K2/js4BIEmo1eP0Ph6QcDeqwFVfwfJklLpfAiwpBJL9
 zcGej/JdlbOKWxuXtXsZIxNpLPykyIdV8Ay2+bWphdq7GOCuMaTTNFm83iUvbxJIGWPcP8
 APDg5OQkxo7ZjYwQfUc0Zp+ZaJHms14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713454810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RFkv4TPORJMsS2tOCnIl0TvzqB89r2pzbGNYnu2htCY=;
 b=+ZVhDg69oDp4zXimPQlNjb0VH9IvqnNCggHniIEbpW0nWqyGPn2wv9JDU/BzPTe8NF6SWn
 nXFs6iEZjZeNXJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 517F41384C;
 Thu, 18 Apr 2024 15:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QoKJE9o+IWZbPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Apr 2024 15:40:10 +0000
Date: Thu, 18 Apr 2024 17:39:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZiE-p4CS1RDUuYGm@yuki>
References: <20240418141312.99794-1-pvorel@suse.cz>
 <20240418141312.99794-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240418141312.99794-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] libswap: Add {SAFE_,
 }MAKE_MINIMAL_SWAPFILE() macros
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
> Maximum kernel page size is 256KiB (see kernel arch/Kconfig). Therefore
> this is the minimum blocks allowed to be used to avoid warning on any
> kernel page size setup:
> 
>     TWARN: Swapfile size is less than the system page size. Using page size
>     (65536 bytes) instead of block size (4096 bytes).
> 
> Therefore define this size and add helper macros.

I'm again, slightly againts the use of disk block size as a base measure
of size. In practice the block size will either be 4k or 64k but it's
quite confusing to justify the need for 256 blocks. With 256 blocks the
minimal size will be either 1MB or 16MB depending on the actual
filesystem. So rather than that can we just default to 1MB minimal swap
file, which makes the test a bit more predictable?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
