Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932D3ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 19:04:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 755093CACB9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 21:04:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 295253CAC18
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 21:04:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3372910005BB
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 21:04:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0650233BF8;
 Fri, 16 Sep 2022 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663355078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDCuwY34+2cjc7Q8DrMuhwnndfhc8G8OwFV5/7Tubk0=;
 b=hIBB0gmJkIAjnbg01f3nL2NTY5r2vjL3Lu8xRJm2BZS6DZKvbpNCHn9y6id18KOAorfDop
 wzRTBoNDXnFIpQRAT4YESkk5TMb1PF0HKJ47WLQEg0B99o3iC/ALFDpZ/cH1PEpkvntc6O
 l75oJJ3o8TRTktHyKMhphtD+nqD7lvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663355078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDCuwY34+2cjc7Q8DrMuhwnndfhc8G8OwFV5/7Tubk0=;
 b=H21lHtUjguKHea8iQPWNA+AwoZKWLUuSWV2BPZTl9G5YnERFh2SSpDXB1Bb1QD5bl4hoDS
 buI4GnmUTz8fgRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00C561332E;
 Fri, 16 Sep 2022 19:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +IYaNcTIJGMhNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Sep 2022 19:04:36 +0000
Date: Fri, 16 Sep 2022 21:04:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyTIvPWfkkEoUflB@pevik>
References: <20220906054612.9790-1-pvorel@suse.cz>
 <YySDWP9I46TDIgEK@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YySDWP9I46TDIgEK@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Ignore warnings irrelevant in
 userspace
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > * EMBEDDED_FILENAME
> > fanotify.h:15: WARNING: It's generally not useful to have the filename in the file
> > on #include <sys/fanotify.h> in fanotify.h

> > * ENOSYS
> > fanotify.h:26: WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> > on if (errno == ENOSYS)

> > * NEW_TYPEDEFS
> > fanotify.h:180: WARNING: do not add new typedefs
> > on typedef struct {

> I'm not 100% sure about the NEW_TYPEDEFS check, that one is mostly
> right. The later two are fine.

FYI the error is from fanotify.h (kind of lapi file for fanotify:

#ifndef __kernel_fsid_t
typedef struct {
	int	val[2];
} lapi_fsid_t;
#define __kernel_fsid_t lapi_fsid_t
#endif /* __kernel_fsid_t */

which we added in b8aebc835 ("fanotify: Fix missing __kernel_fsid_t definition")
"Instead of including <asm/posix_types.h> where it's defined we just
define the missing bit." (fix for musl).

But if you prefer to keep this check, I'm ok to merge it without it.

The long term solution could be to add variable to Makefile to pass extra
parameters, e.g.:
check_fanotify.h: CHECKPATCH_IGNORE += NEW_TYPEDEFS

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
