Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CEFEB64DC
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 09:38:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A332B3CDACF
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 11:38:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C5063C9212
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:38:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9E9460070F
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:38:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30B361F8BD;
 Wed, 21 Jun 2023 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687340310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hbbvc1VMljp+ApSo/bhFdYDyqPUTcnGu7yPH9uGMwhk=;
 b=OCNHjkuD8tDtRmtdngVbGhf3fAtlCK3RBzykpZjDdgPr8c4lxiKzj1NaYA+ftdd2Rz10gu
 4JTKXCeMEj/3zxaLNTEvnQ2F3iX0Eq2IiBZ725onzopJdyox0HCMXnQUs/aC7PZ3zxn+/N
 xwu/oFR3vYgl1Om/2/+za5v+YKNlmQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687340310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hbbvc1VMljp+ApSo/bhFdYDyqPUTcnGu7yPH9uGMwhk=;
 b=iFMi5gUVE/aY8U+d6qhufoBzS7nVeMKtT7+3kYoieJ8DSTUdAu7cmEfwTpeI+x2L+u0Mz/
 +s+rDgrI7AXXOJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B1D7133E6;
 Wed, 21 Jun 2023 09:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4skPARbFkmQ0dQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 09:38:30 +0000
Date: Wed, 21 Jun 2023 11:38:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexander Aring <aahringo@redhat.com>
Message-ID: <20230621093828.GA386889@pevik>
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-3-aahringo@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230530203707.2965684-3-aahringo@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] fcntl41: test for owner values on OFD posix
 locks
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

Hi Alexander,

> diff --git a/testcases/kernel/syscalls/fcntl/fcntl41.c b/testcases/kernel/syscalls/fcntl/fcntl41.c
> new file mode 100644
> index 000000000..40d14ff02
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fcntl/fcntl41.c
...
> +#include <sys/wait.h>
> +
> +#include "tst_test.h"
> +
> +static int fd, fd2;
> +
> +void do_child1(void)
> +{
> +	const struct flock fl_0_0 = {
> +		.l_type = F_WRLCK,
> +		.l_whence = SEEK_SET,
> +		.l_start = 0L,
> +		.l_len = 1L,
> +	};
> +
> +	tst_res(TINFO, "thread1 waits for thread2 to lock 1-1");
> +	TST_CHECKPOINT_WAIT(1);
> +
> +	tst_res(TINFO, "thread1 lock region 0-0 - It should block");
> +	SAFE_FCNTL(fd2, F_OFD_SETLKW, &fl_0_0);
F_OFD_SETLKW is undefined on old Cent0S 7, we still support:
https://github.com/pevik/ltp/actions/runs/5331934790/jobs/9660442246

You need to use our fallback to avoid this.

#include "lapi/fcntl.h"

We also have fcntl_common.h, which is used for F_OFD_* (fcntl_compat(),
you may need to use it. It also includes lapi/fcntl.h.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
