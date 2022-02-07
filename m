Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3584C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 22:02:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0349A3C9B00
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 23:02:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D32593C06B2
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 23:02:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81E7D1A009BC
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 23:02:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30E3E1F37F;
 Mon,  7 Feb 2022 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644271353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDZDTV+W0p8OCnRDU+QZ3GhuWwKY9yxEaOzNKogDyFI=;
 b=2s4ncft0nK6IuHd9B03Ra/j0ijLe86claV+NPhjIYfoWVEFRXmBpMZSlY94vtqucYVpvBj
 j2SpLGVbodJn4KNSIWSq3BxTDW1AUebI8qYuuSYZOWWgIX9/xu/8RkCPHf7+XPt08MS7KS
 zF84dFLN80HWcqQM0Lyy3HBqVfruT7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644271353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qDZDTV+W0p8OCnRDU+QZ3GhuWwKY9yxEaOzNKogDyFI=;
 b=dNpVt7yHKmGjV1zH6eTBJ8J+Rdmpjm+R6arK1HSCzMDzT8joNaOvK0AOjr+SlNQX9//CpI
 Os2XYtBOZnBfR/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00E4413B55;
 Mon,  7 Feb 2022 22:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ympOOviWAWLSAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Feb 2022 22:02:32 +0000
Date: Mon, 7 Feb 2022 23:02:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgGW9/nyG6ed/qzK@pevik>
References: <20220203123522.28604-1-andrea.cervesato@suse.de>
 <20220203123522.28604-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220203123522.28604-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/5] Rewrite mountns01 test using new LTP API
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

Hi Andrea,

> Removed libclone from Makefile and used LTP API to replace it.
> mountns01 has been adapted to use the new LTP API.

Thanks for this effort!

> +++ b/testcases/kernel/containers/mountns/Makefile
...
>  include $(top_srcdir)/include/mk/testcases.mk
> -include $(abs_srcdir)/../Makefile.inc
> -
> -LDLIBS                  := -lclone $(LDLIBS)
> -

Removing this makes this commit (and I guess all but the last commits) uncompilable.
IMHO this is no-go as it breaks bisecting.

But even keeping it for all not yet rewritten tests:

include $(abs_srcdir)/../Makefile.inc
mountns02 mountns03 mountns04 mountns05: LDLIBS                  := -lclone $(LDLIBS)

breaks the compilation:

$ make mountns02
make -C ../libclone -f "testcases/kernel/containers/mountns/../libclone/Makefile" all
make[1]: Entering directory 'testcases/kernel/containers/libclone'
../../../../include/mk/sparse.mk:6: warning: overriding recipe for target 'tools/sparse/sparse-ltp'
../../../../include/mk/sparse.mk:6: warning: ignoring old recipe for target 'tools/sparse/sparse-ltp'
../../../../include/mk/sparse.mk:9: warning: overriding recipe for target 'tools/sparse'
../../../../include/mk/sparse.mk:9: warning: ignoring old recipe for target 'tools/sparse'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory 'testcases/kernel/containers/libclone'
/usr/bin/ld: testcases/kernel/containers/mountns/../libclone/libclone.a(libclone.o): in function `do_unshare_tests':
testcases/kernel/containers/libclone/libclone.c:59: undefined reference to `tst_brk'
collect2: error: ld returned 1 exit status
make: *** [../../../../include/mk/rules.mk:37: mountns02] Error 1


>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/containers/mountns/common.h b/testcases/kernel/containers/mountns/common.h
> new file mode 100644
> index 000000000..971f2381a
> --- /dev/null
> +++ b/testcases/kernel/containers/mountns/common.h
nit: maybe mountns.h would be a better name.

...
> +static void check_newns(void)
> +{
> +	int pid, status;
> +
> +	if (tst_kvercmp(2, 4, 19) < 0)
> +		tst_brk(TCONF, "CLONE_NEWNS not supported");
We can safely remove check for kernel 2.4 :).
> +
> +	pid = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, dummy_child, NULL);
> +	if (pid < 0)
> +		tst_brk(TCONF, "CLONE_NEWNS not supported");

Yes, I'd also be for keeping ltp_clone_quick() from quite obscure cloner.[hc].
SAFE_CLONE() / tst_clone() use nice clone3() interface, but that's was added
quite recently (kernel 5.3). It'd be nice one day rewrite/cleanup also also
cloner.[hc].


> diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
...
>  #define _GNU_SOURCE
IMHO _GNU_SOURCE is not needed. Or at least it compiles without it
> +
>  #include <sys/wait.h>
>  #include <sys/mount.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include "mountns_helper.h"
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID	= "mountns01";
> -int TST_TOTAL	= 2;
> +#include "common.h"
> +#include "tst_test.h"

>  #if defined(MS_SHARED) && defined(MS_PRIVATE) && defined(MS_REC)
These were added in glibc in 2010 (glibc 2.12), we can safely remove this check.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
