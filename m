Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FB3CCA476
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 21:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39B7A3CE67C
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 23:37:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 053F53C9B2B
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 23:37:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F323600920
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 23:37:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF611F38F;
 Tue,  7 Oct 2025 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759873035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UAzgmCFeSfKPG5/OvmivSSWaPh9YQuKK6hAD5zRG/k4=;
 b=gXKw8d3LUz0SfdU8pDqoBnYV+fyX0D9ZmEzO+XLrDwUxt/rWZdO2TIXbZynd41IuF7ZpGE
 hCxrIStmCa9oqI98nER1ZbEnKouGwKmOKoLQRIPhV2NrZbnNKwUb70l02owtu0kcYw4k1u
 8/Tp4zk1lMdhl85aEbWMb5my9mUOfZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759873035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UAzgmCFeSfKPG5/OvmivSSWaPh9YQuKK6hAD5zRG/k4=;
 b=4wrppn46pkA8wsffkZxUe/SUjvKtE+rzxsNncwLRQ77WgbnMYt1BnjW2ldl8FMI+kTgw+d
 NXNj3FkFHh6VZUDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759873035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UAzgmCFeSfKPG5/OvmivSSWaPh9YQuKK6hAD5zRG/k4=;
 b=gXKw8d3LUz0SfdU8pDqoBnYV+fyX0D9ZmEzO+XLrDwUxt/rWZdO2TIXbZynd41IuF7ZpGE
 hCxrIStmCa9oqI98nER1ZbEnKouGwKmOKoLQRIPhV2NrZbnNKwUb70l02owtu0kcYw4k1u
 8/Tp4zk1lMdhl85aEbWMb5my9mUOfZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759873035;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UAzgmCFeSfKPG5/OvmivSSWaPh9YQuKK6hAD5zRG/k4=;
 b=4wrppn46pkA8wsffkZxUe/SUjvKtE+rzxsNncwLRQ77WgbnMYt1BnjW2ldl8FMI+kTgw+d
 NXNj3FkFHh6VZUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AE0D13693;
 Tue,  7 Oct 2025 21:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z//eCAuI5WjuOAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 Oct 2025 21:37:15 +0000
Date: Tue, 7 Oct 2025 23:37:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20251007213713.GB160168@pevik>
References: <aOODn-CZ7F1A777o@yuki.lan> <20251007143207.27848-1-akumar@suse.de>
 <6213145.lOV4Wx5bFT@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6213145.lOV4Wx5bFT@thinkpad>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: update invalid clock id to
 accomodate new auxiliary clock ids
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

> On Tuesday, October 7, 2025 4:32:06 PM CEST Avinesh Kumar wrote:
> > Starting kernel v6.17, there are 8 more auxiliary clock ids reserved on
> > systems with CONFIG_POSIX_AUX_CLOCK=y [1] and moreover posix systems can
> > define and support any number of clocks beyond the mandatory ones.

> > [1] https://lore.kernel.org/lkml/20250519083025.905800695@linutronix.de/

> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >  .../conformance/interfaces/clock_getres/6-2.c                | 5 ++---
> >  .../conformance/interfaces/clock_gettime/8-2.c               | 4 ++--
> >  .../conformance/interfaces/clock_settime/17-2.c              | 4 ++--
> >  3 files changed, 6 insertions(+), 7 deletions(-)

> > diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
> > index c44809012..af45e27c9 100644
> > --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
> > +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
> > @@ -17,8 +17,7 @@
> >   *   unassigned value = -1073743192 (ex. of what gcc will set to)
> >   *   unassigned value = 1073743192 (ex. of what gcc will set to)
> >   *   -1
> > - *   17 (currently not = to any clock)
> > - *
> > + *   50 (hopefully big enough value not to be a valid clock id)
> >   */
> >  #include <stdio.h>
> >  #include <time.h>
> > @@ -33,7 +32,7 @@ int main(void)
> >  	struct timespec res;
> >  	int invalid_tests[NUMINVALIDTESTS] = {
> >  		INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
> > -		1073743192, -1, 17
> > +		1073743192, -1, 50
> >  	};
> >  	int i;
> >  	int failure = 0;
> > diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
> > index ed4cd4078..92263ce87 100644
> > --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
> > +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
> > @@ -15,7 +15,7 @@
> >   *   unassigned value = -1073743192 (ex. of what gcc will set to)
> >   *   unassigned value = 1073743192 (ex. of what gcc will set to)
> >   *   -1
> > - *   17 (currently not = to any clock)
> > +  *   50 (hopefully big enough value not to be a valid clock id)
> I see I added extra space in this one, please fix while merging if patch is fine.

Sure, np.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Thanks,
> Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
