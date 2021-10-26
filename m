Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2107C433FE
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 08:03:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3777460F22
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 08:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3777460F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA98B3C67ED
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 10:03:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 855B33C2C95
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 10:03:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9F596011E5
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 10:03:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42A98218B0;
 Tue, 26 Oct 2021 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635235415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pL7x4Ejoz5tGzEGD4+IuefPR5IATiZgPNq+WM4o0IYg=;
 b=aMm+FbP0bG+5lm5b87fQsrt/M9oRPjSnbedKdy9ETfxMxUTTvJgZw/irEm3xOhDWnwkzYA
 ieRy1yszHYoiXjsydk6gRkonQuZkd9BmffLZ5Myu2YQb8FgFkkuWghJOql90wFXR+H6zly
 gxa11xDQWWL6/fAgzSk0JM/1qFv1U1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635235415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pL7x4Ejoz5tGzEGD4+IuefPR5IATiZgPNq+WM4o0IYg=;
 b=uVPnQpQEU847l7NKrK2tKvR9uMxIXIFuHFcTZ3YMzw9ZCxpwKKnUPZKRcR5biOZMbI19Lz
 hhRvZSbqEHpcQoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 268CC13E04;
 Tue, 26 Oct 2021 08:03:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QyDdBVe2d2H0SwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 08:03:35 +0000
Date: Tue, 26 Oct 2021 10:04:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YXe2h9oEAR0GzMXz@yuki>
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY
 testcase
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
> commit 032146cda855 ("vfs: check fd has read access in
> kernel_read_file_from_fd()") changed errno back to EBADF,
> which is correct value according to man page, so tweak
> the test to expect it for kernels >= 5.15.

Shouldn't we drop the check completely and rather than working around
the bug add this commit to the test metadata?

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/finit_module/finit_module02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
> index 0d2bf917ea64..9b5d3563b74e 100644
> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
> @@ -52,7 +52,7 @@ static void bad_fd_setup(struct tcase *tc)
>  
>  static void wo_file_setup(struct tcase *tc)
>  {
> -	if (tst_kvercmp(4, 6, 0) < 0)
> +	if (tst_kvercmp(4, 6, 0) < 0 || tst_kvercmp(5, 15, 0) >= 0)
>  		tc->exp_errno = EBADF;
>  	else
>  		tc->exp_errno = ETXTBSY;
> -- 
> 2.27.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
