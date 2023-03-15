Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A08C7618A
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 12:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267D43CD4B5
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 13:31:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5FE93CACBE
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:31:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E9BFC10007B9
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:31:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09E871FD7E;
 Wed, 15 Mar 2023 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678883482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4ujx1Ky+Cwfy+0yJ+GFpAiFDveM+LeC6KfAoM3mED8=;
 b=q4t46GXctLMaA0n0C8a1lB7hI4/GmTVQTXZslnCM+xBz2mCDqXsAvW3ek5mVLdth3zNfl2
 rJGwBeUye9ODz1HudGhG3NsBHx63sqY2/vKrNDPFLXTMCddS1x/LVGgEOj3VNEoUJ6RqvF
 NcPc+JPcG84AZRCMTqDfUL/80SLYVkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678883482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4ujx1Ky+Cwfy+0yJ+GFpAiFDveM+LeC6KfAoM3mED8=;
 b=yDx6ZTJmOKtVZKykhBw4znwNZKxW7jOr7O/wS5moMmhfjo1BvPXhcDswf3lfIHVqKyaY+K
 bZW7ad02O+tAr0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F8F913A00;
 Wed, 15 Mar 2023 12:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3WigIZm6EWTfCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Mar 2023 12:31:21 +0000
Date: Wed, 15 Mar 2023 13:31:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230315123119.GA164307@pevik>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
 <20230302071555.18420-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230302071555.18420-2-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Move semaphore/ tests to semop/
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

Hi Wei,

> There is no point in having two different directories with semop()
> testcaes so it would make sense to move these two tests into the
> syscalls/ipc/semop/ directory as semop04 and semop05.
> So we move ipc/semaphore/ tests to syscalls/ipc/semop/.
> Also update runtest files accordingly.

As I already stated, I'm not really sure this is good to do, but maybe I'm
missing something.  I wonder what others thing about it.

...
>  rename testcases/kernel/{ipc/semaphore/sem01.c => syscalls/ipc/semop/semop04.c} (100%)
>  rename testcases/kernel/{ipc/semaphore/sem02.c => syscalls/ipc/semop/semop05.c} (100%)

> +++ b/runtest/syscalls
> @@ -1239,6 +1239,8 @@ semget06 semget06
>  semop01 semop01
>  semop02 semop02
>  semop03 semop03
> +semop04 semop04
> +semop05 semop05
You renamed files, you need to remove sem01 sem02 from runtest/ipc.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
