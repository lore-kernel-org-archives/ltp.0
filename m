Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E771EC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 19:04:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B0933CE953
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 20:04:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB4ED3CC7E0
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 20:03:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D91C1A02397
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 20:03:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 359951F388;
 Fri,  3 Nov 2023 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699038236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xh+sS5XvtK+IM7179j3PrzqS7jd0qPdoEZJ7wYZ1N5Q=;
 b=DTbugZtygC6B+NY7yM33qRGe9lJq/XT6B43S+vAarwrcO4a5IGaJwyjnOdJDAEdtqjXrBv
 rg/tSyPHuCUlM62nzEnUkDII25h5ijpwmKknVgwBqaz8ypeG4T5zZINN3M3arWhxp1vy93
 hyJKyFp5M/JQok55GXbASuMSpXw8dyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699038236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xh+sS5XvtK+IM7179j3PrzqS7jd0qPdoEZJ7wYZ1N5Q=;
 b=v9l7xbXosfKWLJ0Fbtlz+5YCk5l5xi9LlCEggCYjn97p55xOKMMnDPrcXEsZf5hl4C5yq3
 DC468mA4LBONrIDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D384D13907;
 Fri,  3 Nov 2023 19:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id euvGLRtERWW4CwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 19:03:55 +0000
Date: Fri, 3 Nov 2023 20:03:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20231103190353.GA1118339@pevik>
References: <20231103172335.23787-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231103172335.23787-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] keyctl02: Add delay between main loop iterations
 for RT kernels
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

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
> @@ -29,13 +29,17 @@

>  #include "tst_safe_pthread.h"
>  #include "tst_test.h"
> +#include "tst_kconfig.h"
>  #include "lapi/keyctl.h"

>  #define LOOPS	20000
>  #define MAX_WAIT_FOR_GC_MS 5000
>  #define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"

> +#define KCONFIG_INIT(confname) { .id = confname, .id_len = strlen(confname) }
BTW this could be added (as separate effort) somewhere in the library
(include/tst_common.h) and reused in other tests (well, there are only 3 tests).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
