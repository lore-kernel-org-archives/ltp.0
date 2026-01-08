Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D27D185EF
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 13:01:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39D633C649C
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 14:01:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A99293C59A7
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:01:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28B1D200961
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:01:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3EAEF5C5CF;
 Thu,  8 Jan 2026 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767877285;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GuP1kOiIO9Di6STcR/b5se2+PJjakpXxy1s+qlz2nk=;
 b=My1SoA9sWZoIEdqFekd87WvdBPNHiCXSHHeh+e/gxTBD1JDJ878rnADNBff+/XUSYyHDGl
 8gVKxWOJN+0hY4qUx2L+xMoc8H2O6anrmhcZzn0EmIRpIOnPjfHPiMb5AOgO8VaErLLmLK
 Vaxw3OPqIqtBpeD3z8GfulHm/UXd9nI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767877285;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GuP1kOiIO9Di6STcR/b5se2+PJjakpXxy1s+qlz2nk=;
 b=+V7uzZjoxpEsaRRCRqJAhMIXP8zZC5OBCJG2jSLMfSGjyOZsQ1KNVm2w0C0S2Hu+xdTFr4
 tJ8ozMdr6aa8NtCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767877280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GuP1kOiIO9Di6STcR/b5se2+PJjakpXxy1s+qlz2nk=;
 b=FpCWkeZgt3DDqKJu3hgR7shp1oRvPfMPsTHUiSWcNBEiuGYCv8dgylrnCh8vX4AwJTGmY+
 4Wks0pPWIR3ONIRrxFUd1exH2AmPiFp1nDCklsvWzRDpe3SDdyp/mO9eTDvUG5VXjVWr6W
 ypfNeocYmUgqvqAlnCnwvaCw/niEQf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767877280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GuP1kOiIO9Di6STcR/b5se2+PJjakpXxy1s+qlz2nk=;
 b=R/PK+zO05s08lzATFhEcjMCF125RMxUOEzjt7FWOKI6GpTgzez7/eytpQDEd/tD+mYxRUo
 3cAuQDWcBHHHKDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E22453EA63;
 Thu,  8 Jan 2026 13:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iqWaMZ+qX2m/bAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Jan 2026 13:01:19 +0000
Date: Thu, 8 Jan 2026 14:01:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260108130114.GA17507@pevik>
References: <20251010113014.309433-1-pvorel@suse.cz>
 <CAEemH2dU6XP+Er75eERgo+p7TyMgEjMJY7tjAGA15NOKFrZM+A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dU6XP+Er75eERgo+p7TyMgEjMJY7tjAGA15NOKFrZM+A@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_cmd.h: Convert the rest of comments to
 kerneldoc
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

Hi all,

...
>  Reviewed-by: Li Wang <liwang@redhat.com>

@Li FYI if you put space before RBT it's not taken.

I created a ticket for it:
https://github.com/getpatchwork/patchwork/issues/645

...
> >  #ifdef TST_TEST_H__
> > +/**
> > + * tst_cmd_fds() - :man2:`vfork` + :man2:`execvp` specified program.

execvp is man3, I fixed it before merge.

Thanks for your review, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
