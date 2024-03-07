Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC40C54798
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 02:50:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A329E3D186E
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 03:50:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35AC43CB8D1
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 03:49:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98BF31000D27
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 03:49:53 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4A2E4DF31;
 Thu,  7 Mar 2024 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709852906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXJAUF+82/Ak6fT6bYHbFilebLIFYG2d8JRacpZnGqA=;
 b=le6lp15ndSul2Uh9Kz9IDKuDFXhtT6fkEl8B/sOjeziYsun2Wl1DiiX8r4NRPF8+WFqwZd
 /jan+BIpx37ShI+7iIHMvoHilGyrkfFNm1cpOiQR49gSX/+hQbnsESlix6MSd4dhaiRXiB
 YzWrYsLT+fP2spBfWmwSIMiK+1rwr+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709852906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXJAUF+82/Ak6fT6bYHbFilebLIFYG2d8JRacpZnGqA=;
 b=7Bg2EgJmVYwvH0+UmR+D14E4O25j/c5ipq9Sv4ReZ+pigYJtK3GmO+moJUifcEBKVVbmnj
 XNmqGb+XyRHxAwCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709852905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXJAUF+82/Ak6fT6bYHbFilebLIFYG2d8JRacpZnGqA=;
 b=pwpBTAd06KL9pkOefHUCiRT9rRJT341SVsuU4NwtNGmP44tDtyOm8Dt5YVVfxbtjFX69BU
 ueVQbM2yeoYVu4MAf6JFbG2bAMr2KJ0z+pIQd99g9gN6zwu/JUPIoGCvXAQQytR45SgFXr
 BcuSxHgxH0F+jBaf4dTOFKaRCtgsZZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709852905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXJAUF+82/Ak6fT6bYHbFilebLIFYG2d8JRacpZnGqA=;
 b=498GR23qGlu+DB2tzZ1Sv+5gna7qhWfUd63beyFDHn7fdRALIlNczy+yimxTV7V9d0EUve
 ndUZhuFrBu5a4ZDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B18413997;
 Thu,  7 Mar 2024 23:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id B8tTIOlI6mXIRgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Mar 2024 23:08:25 +0000
Date: Fri, 8 Mar 2024 00:08:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, Wei Gao <wegao@suse.com>,
 ltp@lists.linux.it, Li Wang <liwang@redhat.com>
Message-ID: <20240307230820.GA225601@pevik>
References: <20240306104609.17141-1-wegao@suse.com>
 <6285aaad-79ca-4d7c-8be0-6d846d165df2@suse.cz>
 <20240307213335.GA211890@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240307213335.GA211890@pevik>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pwpBTAd0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=498GR23q
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[42.72%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: B4A2E4DF31
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] chdir01.c: set umask to 0 within setup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Martin, all,

> > Hi,
> > you're trying to fix a vfat mount quirk. We should fix that in the LTP
> > library instead, e.g. by setting umask(0) and then restoring the original
> > value inside safe_mount().

> This makes sense. FYI Wei first tried to adjust umask globally for all tests in
> the do_setup() [1], which I worried it would influence tests.

Also, it would be good to update:

https://github.com/linux-test-project/ltp/wiki/C-Test-API#21-umask

Kind regards,
Petr

> Later Li fixed problem in cgroup tests [2]. This is obviously more general
> solution, Wei please send a patch for it and to the commit message
> Suggested-by: Martin Doucha <mdoucha@suse.cz>

> While we are fixing issues caused by too restrictive umask (Wei fixed e.g.
> statx07 [3]), just to let you know that some failures are kernel failures (at
> least creat09 which uses all_filesystems, had bug on XFS [4], which got fixed
> in the kernel).

> Kind regards,
> Petr

> [1] https://lore.kernel.org/ltp/20240219134845.22171-1-wegao@suse.com/
> [2] https://github.com/linux-test-project/ltp/commit/50626b4a1d01caacd418156ec997853bd4a9fc39
> [3] https://github.com/linux-test-project/ltp/commit/d95f453ac624dc159d3acddb62eadeb9a8215f0e
> [4] https://lore.kernel.org/ltp/62343BF2.1020006@fujitsu.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
