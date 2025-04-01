Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5462C36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 19:36:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89BFD3CB062
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 21:36:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EACA73C9A52
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 21:35:44 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 18E4560094E
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 21:35:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AE6E1F38E;
 Tue,  1 Apr 2025 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743536143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYH3PGztWl9SZg+vcZZGEBqqSBDEQl3hLckmmZid76k=;
 b=WGSIgh9FDTq12XtKFPNvVBrn0nTs2gtOD3sWdUuUUBnp+ha+3KeaRgSuEqEixQxwDXN4NP
 tYVTFKwnz41tpTXFmz0Nn1/1SJJbomGV/r+5M2sDjyUJsvij+OhEK09UpYn6wSZKl3733E
 jdkvKGXeTtWzZPMdpBlhjaxITi9YJdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743536143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYH3PGztWl9SZg+vcZZGEBqqSBDEQl3hLckmmZid76k=;
 b=NiDDB5ZQjU1/ad4BPTPfLsmzZ9AWCMV7QUaC7nEx4wRuCRuBoYUQMHzRIlVsuynIz+AlJE
 qBSHzWCoL+nrJ/CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743536143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYH3PGztWl9SZg+vcZZGEBqqSBDEQl3hLckmmZid76k=;
 b=WGSIgh9FDTq12XtKFPNvVBrn0nTs2gtOD3sWdUuUUBnp+ha+3KeaRgSuEqEixQxwDXN4NP
 tYVTFKwnz41tpTXFmz0Nn1/1SJJbomGV/r+5M2sDjyUJsvij+OhEK09UpYn6wSZKl3733E
 jdkvKGXeTtWzZPMdpBlhjaxITi9YJdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743536143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aYH3PGztWl9SZg+vcZZGEBqqSBDEQl3hLckmmZid76k=;
 b=NiDDB5ZQjU1/ad4BPTPfLsmzZ9AWCMV7QUaC7nEx4wRuCRuBoYUQMHzRIlVsuynIz+AlJE
 qBSHzWCoL+nrJ/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A921F13691;
 Tue,  1 Apr 2025 19:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ttGNIA5A7GejQwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 19:35:42 +0000
Date: Tue, 1 Apr 2025 21:35:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250401193539.GA362719@pevik>
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
 <20250327-fix_make_clean-v1-3-8b9ed2a8d96a@suse.com>
 <20250401074726.GE299271@pevik>
 <D8VDRQTQRJJ7.2GET721U22NIL@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D8VDRQTQRJJ7.2GET721U22NIL@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] include/Makefile: Fix cleaning targets
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue Apr 1, 2025 at 4:47 AM -03, Petr Vorel wrote:
> > Hi Ricardo,

> >> Add ac-clean target as dependency of ac-maintainer-clean and add missing
> >> files to the removal list. This way the project top level Makefile cleaning
> >> targets can make use of it.

> >> Cc: Andrea Cervesato <andrea.cervesato@suse.com>
> >> Fixes: 817d8095fbfe ("Rename linux_syscall_numbers.h to lapi/syscalls.h")

> > I did not get how this commit broke the functionality.

> It did not break anything, but either that commit or the one that added
> the older "linux_syscall_numbers.h" file should have also marked it for
> removal. Should I drop the Fixes: tag?

I guess it's ok to keep.

Kind regards,
Petr


> > Change LGTM.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Thanks,
> -	Ricardo.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
