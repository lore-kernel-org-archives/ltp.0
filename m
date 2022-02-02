Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89118C433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 16:06:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62FFE3C98CE
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 17:06:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39B033C67FA
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 17:06:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7AB3A200AF0
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 17:06:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8A4421108;
 Wed,  2 Feb 2022 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643817961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LK5OzTyc82UNTRa8rf8jIoZ83St36JRrv5zfsNiXVAw=;
 b=mSfGd3xJJRbgKO7w1w9SWQFYzLUpzk7cta8oTgRRhhI1vlMQxqu0w47eALDejc+I1drv7T
 je4Zsjcm33kA8HGI8RNWy3twMcHP/uJYeqmBL/3cFOJhZM4bcSY8X5efUdrKIES9TvMgsN
 ZuT8p1FyPFdBO4Prhnzj+RE9Z5jWMqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643817961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LK5OzTyc82UNTRa8rf8jIoZ83St36JRrv5zfsNiXVAw=;
 b=7ZblyjPK9c777e9K1eQUb2CxH7UWn214jAO5Wd+QvepdSCoufiG93nZ35W2jPgbcQx8zg3
 jS818zr6lX+IZFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BACF13E6F;
 Wed,  2 Feb 2022 16:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P1FcIOmr+mH8JgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Feb 2022 16:06:01 +0000
Date: Wed, 2 Feb 2022 17:07:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YfqsXZFKZjlf3BWh@yuki>
References: <20211122080138.55815-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211122080138.55815-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib/tst_tmpdir: Add tst_default_rmdir() for
 old testcases
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In some old testcases, cleanup() will not run since it exit
> form tst_brk. For example, because of the calling of ltp_syscall
> have no real cleanup when syscall not support, testcase ssetmask01
> will leave tmp file.

Actually you can pass cleanup to ltp_syscall(), all you need to do is
ti define CLEANUP before including LTP headers as:

#define CLEANUP cleanup

#include "test.h"
...
...

See the include/old/cleanup.c for details.

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
> v1->v2: add tst_default_rmdir() in tst_tmpdir.c
> 
>  lib/tst_tmpdir.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 6e38ae977..0045c7bb6 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -342,6 +342,8 @@ void tst_rmdir(void)
>  		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
>  			 __func__, TESTDIR, errmsg);
>  	}
> +
> +	TESTDIR == NULL;

This is useless statement, it does literaly nothing.

>  }
> 
>  void tst_purge_dir(const char *path)
> @@ -351,3 +353,8 @@ void tst_purge_dir(const char *path)
>  	if (purge_dir(path, &err))
>  		tst_brkm(TBROK, NULL, "%s: %s", __func__, err);
>  }
> +
> +void __attribute__((destructor)) tst_default_rmdir(void)
> +{
> +	tst_rmdir();
> +}

I do not think that we should run the tst_rmdir() for all tests like
this.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
