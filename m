Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA555CDB474
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 12:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D55B3CEDF4
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 14:40:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD78F3CD0F6
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 14:40:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B55886003BD
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 14:40:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8E191FF19;
 Tue, 17 Oct 2023 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697546425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9tCjbuAdUlkjicI804CwXBTbx0I02EHMFmrTzYtqdo=;
 b=M47kbmELlkDhVsWYyJEDFcp1qwoZtrsEMv+knwf+YTr915dt20/CBDhaxTl+2Mf4YRGCEj
 upOXLF++gKG9bMLtRJKF+jSY73oKfIqFBnQzuinhBCMBHP4tBqd7AAq4A33VbMIOwbnSDh
 naoshN80pnULl0a5EKUEzjKdQABU6SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697546425;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9tCjbuAdUlkjicI804CwXBTbx0I02EHMFmrTzYtqdo=;
 b=qZ2puarsgPhsKYJwU8g58utl685E1iE4pbTVJjHjXosZOSkaeILOjNv9okjByKfpOogzNb
 mYX+T7Y8DMrNuoDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5B6B13597;
 Tue, 17 Oct 2023 12:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fwoEKLmALmVWWgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 17 Oct 2023 12:40:25 +0000
Date: Tue, 17 Oct 2023 14:41:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZS6A3Ug9qkTKPah9@yuki>
References: <20230908141414.28359-1-andrea.cervesato@suse.de>
 <20230908141414.28359-3-andrea.cervesato@suse.de>
 <20231017113509.GA931108@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231017113509.GA931108@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.62 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[53.63%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Refactor getegid02 using new LTP API
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This code is based on Cyril's suggestion in v1 [1]
> 	if (GID_SIZE_CHECK(st_egid))
> 		TST_EXP_EQ_LI(gid, st_egid);
> 	else
> 		tst_res(TPASS, "getegid() passed");
> 
> I wonder which system returns 16 bit gid?
> 
> man getgid(2) says that originally there was only 16 bit, than kernel 2.4 added
> support for 32 bit and the glibc getegid() wrapper transparently deal with this.
> 
> Because even I compile as 32 bit:
> 
> $ file getegid01_16
> getegid01_16: ELF 32-bit LSB pie executable, Intel 80386
> 
> I get comparison, thus 32 bit:
> $ ./getegid01_16
> ...
> getegid01.c:25: TPASS: gid == st_egid (1000)
> 
> What am I missing?

This obviously works since 1000 < 32767. As long as the GID fits 16bit
integer everything works fine with 16bit syscalls. The check returns if
the egid does fit and returns true if so.

When the GID does not fit, kernel returns overflow GID, i.e. for all
values bigger than 16 bit you get the same GID value that does not
correspond to the actual GID value at all.

So to make the check false, you have to set up the test user so that it
has GID > 16bit integer maximum value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
