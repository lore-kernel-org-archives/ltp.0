Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39139C6FA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 09:02:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E30FE3CC01E
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 11:02:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B2283C6D29
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 11:02:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 755CC6001EA
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 11:02:23 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 76DD51F45F;
 Wed, 30 Aug 2023 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693386142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6wNMyUhaWbF0v+7gUK2F7TDwyj0VzH+UXCjuWmkQVI=;
 b=jRaDLWci9JsI7YBAgPj2fG2CEF9+Cx+Dq6QDB3c9t0t2zk4KtbrdD3QBHw2HArnckwPw9E
 5TKQuPOqJiniDt46FJBzhHH9B4jkIqfI98oXDq3m5k0BMQXF1jSoEcD1/uPY57sp5f0bB4
 b9w7MPOaQZ+VX2OL+/aUa+a0+Podvs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693386142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6wNMyUhaWbF0v+7gUK2F7TDwyj0VzH+UXCjuWmkQVI=;
 b=N2ha5K1Rsdsobr9Qj7cN7Gwku/mB7ER0SixY3S2jZgW/axbsDihCZCVkTi+lJremQc7hlJ
 J5ePhrEQ3g/+ImCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C9EA72C142;
 Wed, 30 Aug 2023 09:02:21 +0000 (UTC)
References: <20230814232643.17673-1-wegao@suse.com>
 <20230815070518.21641-1-wegao@suse.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Wed, 30 Aug 2023 09:59:00 +0100
Organization: Linux Private Site
In-reply-to: <20230815070518.21641-1-wegao@suse.com>
Message-ID: <87a5u8j42t.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Regression check for unlink fail issue after
 successful mknod
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Write a regression test once making unix_bind() undo mknod on failure patchset is merged.
>
> Kernel patch detail:
> git describe --contains c0c3b8d380a8f54c75786d41f6f9efbe761dac6c
> v5.14-rc1119^286
> git log -p c0c3b8d380a8f54c75786d41f6f9efbe761dac6c
> commit c0c3b8d380a8f54c75786d41f6f9efbe761dac6c
> Author: Al Viro viro@zeniv.linux.org.uk
> Date: Sat Jun 19 03:50:32 2021 +0000
> unix_bind_bsd(): unlink if we fail after successful mknod
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/bind/bind03.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
> index 37a040b29..8c95cd799 100644
> --- a/testcases/kernel/syscalls/bind/bind03.c
> +++ b/testcases/kernel/syscalls/bind/bind03.c
> @@ -43,8 +43,12 @@ static void run(void)
>  	 * locks the socket and does all the checks and the node is not removed
>  	 * in the error path. For now we will unlink the node here so that the
>  	 * test works fine when the run() function is executed in a loop.
> +	 * From v5.14-rc1 the kernel has fix above issue.

Usually we don't work around kernel bugs, so really the workaround
should be removed for all versions. However because the workaround was
already accepted, it's a less serious bug and you are removing it on a
subset of kernels, I will just merge it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
