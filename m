Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71459C43334
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 12:04:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40E033C1CEB
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 14:03:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72DEC3C04C3
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 14:03:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 07E8A600C35
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 14:03:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C750237720;
 Tue, 26 Jul 2022 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658837026;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1z3KoMPC1TDxj7ZiVCYShMbQ7qoDGAic3vdx6OyPxuQ=;
 b=KkVwnGpJkE2Ctr8CNZCryRMJeXkg7AoOi5rxoBDjyaRRt3LJs9wuXcaI8WZRwM83jSca9/
 afWTl4LJsgh5ifOHxKc405IaeLnXPNzsSAtPlFkOWrLCzkawTsUmWHasA7sCAs9x3P4yn5
 FAaSGlS7guzX/Gb9OPelfLv0RHpuXC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658837026;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1z3KoMPC1TDxj7ZiVCYShMbQ7qoDGAic3vdx6OyPxuQ=;
 b=x8ax3McLt7AH/SuPjLPJ1SuA0mJEqjuhIzN/0cZw+aqeMYXsdLnPXpJP1ICLtTuzwceNxq
 uWeJWvn1hNKyUGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7C7713322;
 Tue, 26 Jul 2022 12:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KeYJJyLY32KkcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 12:03:46 +0000
Date: Tue, 26 Jul 2022 14:03:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Yt/YIR+anMcbsEp2@pevik>
References: <Yt+RA5chfBh54kvI@pevik>
 <20220726115234.25310-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220726115234.25310-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tools: Check headers with checkpatch.pl
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> checkpatch.pl doesn't load included headers so they must be passed to
> it specifically. This change automatically includes headers from the
> current directory. Manual intervention is still required if a test
> author changes a header located elsewhere. However you can now write
> 'make check-header.h', once in the correct directory.

> Note that our Sparse based tool (amongst others) loads headers and
> checks at least some of the content.

Thanks a lot for implementing this.

LGTM, just a small nit: target for headers contain .h extension.
Shouldn't we add .c for C sources for consistency?

It'=F0 strange, that make check in testcases/misc/math/float/ does not incl=
ude
tfloat.h, but make check-tfloat.h prints errors. But make check in lib/ wor=
ks as
expected (adds also *.h).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
