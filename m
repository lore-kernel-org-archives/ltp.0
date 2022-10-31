Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DC3ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90C3A3CABBF
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:31:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50C9E3CA2E4
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:31:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A71972002C9
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:31:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E05D93373A;
 Mon, 31 Oct 2022 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667223079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcYa7yK+rvxhdaaKPneECmthrLL7cZl29i3KhD82Pm0=;
 b=tJ2k4LpybD9ytpzr65f0mgyKU8QCcaGxzqPl0LwFMAGzBP4pJH7Z1b1MJMD9lH+4DwovZc
 1WxXGtKD19OUFPhD8szTiZtbBTL0RZnivISRLf47t/G6Jd1ZJ7lKHeeskRrEW9JkjtxMyk
 QsMka6MjD7uJo6Vz6bB+hXQCYpU3Rm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667223079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcYa7yK+rvxhdaaKPneECmthrLL7cZl29i3KhD82Pm0=;
 b=hRXCg3XGfvpfJwbGzXvqdPMzaS+dLBWjiHeYGgXuWP8eioIDdoV6EuZKcBhzdkUVUlmVMW
 90xwHC4l0jWDjxCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD7D713AAD;
 Mon, 31 Oct 2022 13:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EnYDMifOX2OiXgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 31 Oct 2022 13:31:19 +0000
Date: Mon, 31 Oct 2022 14:32:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <Y1/Oh4VCUiUSFIvK@yuki>
References: <20221027163654.414017-1-teo.coupriediaz@arm.com>
 <20221027163654.414017-2-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221027163654.414017-2-teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] regen.sh: Use intptr_t for tst_syscall
 return
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
> Some syscalls directly return pointers, like brk or mmap. int is currently
> used for the return value in tst_syscall but is not large enough
> to guarantee that such a returned value will fit.
> Instead, use intptr_t which is guaranted to be castable to (void *)
> without loss of data.

Sounds reasonable, glibc syscall returns long but I guess that's because
there was no intptr_t when that was introduced.

> Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
> ---
>  include/lapi/syscalls/regen.sh |   2 +-
>  runtest/check_tst_syscall      | 190 +++++++++++++++++++++++++++++++++
>  2 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 runtest/check_tst_syscall
> 
> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
> index 3bf38fd03..97027e2f3 100755
> --- a/include/lapi/syscalls/regen.sh
> +++ b/include/lapi/syscalls/regen.sh
> @@ -48,7 +48,7 @@ cat << EOF > "${output_pid}"
>  #endif
>  
>  #define tst_syscall(NR, ...) ({ \\
> -	int tst_ret; \\
> +	intptr_t tst_ret; \\
>  	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
>  		errno = ENOSYS; \\
>  		tst_ret = -1; \\
> diff --git a/runtest/check_tst_syscall b/runtest/check_tst_syscall
> new file mode 100644
> index 000000000..7a6003593
> --- /dev/null
> +++ b/runtest/check_tst_syscall

I do not think that we shoud add this file, at least not in this commit
and without any good description.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
