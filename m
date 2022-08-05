Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349FCC00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 07:38:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94A53C94FB
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 09:38:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AD783C1BBD
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 09:38:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03A0B100119D
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 09:38:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30993371D9;
 Fri,  5 Aug 2022 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659685105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5GR4xESoIplWygqz0FGqMqm2IDtR6zIXTqqqKHI9ao=;
 b=bvm36pqFRqxdPUnd09fEP4zJtQpR/XvMInJY4dVKeClihQiHtiNUNZ4p0cot5D47nyT9r9
 1nCOv13kYZLpbqvJPwJhFNfyMZHU4N6hCXoGxQWJ7peRzpSyJ8qSIC74a3o71QUQy+T4yk
 OS4jFLrnDBFel1thgPPVyPBnWZ7Rrb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659685105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5GR4xESoIplWygqz0FGqMqm2IDtR6zIXTqqqKHI9ao=;
 b=hniUUlDvfXhuF25UZGkCjHwKNB2njFBw3Tz/8T1HdUXP9H+VpcHIRnCXpw8Fn2pPBoDdln
 0feUdk+DpRIWygAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C235133B5;
 Fri,  5 Aug 2022 07:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B+jeBfHI7GIULQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Aug 2022 07:38:25 +0000
Date: Fri, 5 Aug 2022 09:38:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YuzI7w3MnBgdiaza@pevik>
References: <20220805063401.1647479-1-liwang@redhat.com>
 <20220805063401.1647479-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220805063401.1647479-3-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lapi/fsmount: resolve conflict in different
 header files
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

Hi Li,

> The latest glibc added new wrappers (e.g. mount_setattr, fsopen) support in
> sys/mount.h, which partly conflicts with linux/mount.h at the same time.

> We need to make adjustments to header files to fix compiling error on
> different platforms.
thanks for fixing this!

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM, with suggestion.

> +#include <sys/mount.h>
>  #include "tst_test.h"
>  #include "lapi/fsmount.h"
How about instead adding it to the tests to add it to lapi/fsmount.h ?

#include <sys/mount.h>
#ifndef HAVE_FSOPEN
# ifdef HAVE_LINUX_MOUNT_H
#  include <linux/mount.h>
# endif

Works on rawhide
https://github.com/pevik/ltp/actions/runs/2802006779
and on the rest
https://github.com/pevik/ltp/actions/runs/2801968366

and my branch li/fix-compiling-errors.fixes

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
