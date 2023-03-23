Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788A8C6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 08:24:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B39523CD244
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 09:24:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DAF13C0162
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:24:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B693B1000A45
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:24:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B817B339C9;
 Thu, 23 Mar 2023 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679559866;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jk1C6gRgITIH4QPjeWZLVmlZJTepekE4QWOe5agPNzA=;
 b=TibEQoiUI32rWXTFvMjijwHoyDofCqrrRiMX+lePH47XqW/X7Ouh1I3TWkPU1zxYr7YMaW
 Pr50hilHQkRTy4h7PrCqKtEMfJ++9/6u7YndIVS8GoAt/M/Nxnep9PGQ9XA/zZbd9dux1+
 Qrq7ErSLt7U9mEiaX26L6XZlh7ovvYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679559866;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jk1C6gRgITIH4QPjeWZLVmlZJTepekE4QWOe5agPNzA=;
 b=aTSejf1ebuDin7m+pKKPeo4E+2gEzQquJvukGJ2ZldF+/MF1vYxh6uVdUPP5dqIWa62JcQ
 GR5d/yyxPaA2M8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8319D132C2;
 Thu, 23 Mar 2023 08:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Vz+FHboMHGTAIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 08:24:26 +0000
Date: Thu, 23 Mar 2023 09:24:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230323082420.GB405493@pevik>
References: <20230320235108.2058967-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230320235108.2058967-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] tst_device.c: Handle Android path for
 backing device
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
Cc: kernel-team@android.com,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> e1b1ae66b240 ("tst_find_backing_dev: Get dev name from
> /sys/dev/block/*/uevent") added a hardcoded path to check for the
> backing device in /dev.  On Android, it needs to check /dev/block.

Cc the original autor.

I guess both problems were unnoticed because they are kind of corner cases
(minimal Linux and Android). But sure we're happily accept patches to fix them.

Kind regards,
Petr

> The set_dev_path function was renamed to set_dev_loop_path and its
> return value was changed from 1 on success to 0 on success to be more
> consistent with other functions.  A check was added to
> tst_find_free_loopdev in the event that the loop device is not ready
> yet, which appears to happen occasionally on Android.

> v1->v2:
> Changed the function signature of tst_find_backing_dev to add the length
> of the path string.  Updated all references for this function to include
> the added parameter.

> Edward Liaw (3):
>   tst_device.c: Use PATH_MAX more consistently
>   set_dev_loop_path: Refactor set_dev_path and check return value
>   tst_find_backing_dev: Also check /dev/block/ for backing device

>  doc/c-test-api.txt                            |  2 +-
>  include/tst_device.h                          |  3 +-
>  lib/newlib_tests/tst_device.c                 |  2 +-
>  lib/tst_device.c                              | 59 ++++++++++++-------
>  .../kernel/syscalls/ioctl/ioctl_loop05.c      |  2 +-
>  5 files changed, 42 insertions(+), 26 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
