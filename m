Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30958ECAAA3
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 06:26:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C4033CA487
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:26:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7588B3CA3C0
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 08:26:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49570600660
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 08:26:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 51C091FA84;
 Fri, 26 Aug 2022 06:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661495191;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8FyaCeu1p394DDeH1MtqYFAwPHBz1rJ6XEWtZlik4Y=;
 b=oX4o+8XW7819SqJcU3cr/EOgro0KDpT8axeFN1UM9pdVLsFkkvaSS0SJtLtei3HOZCWJxi
 p0ptXQAqKpOoBCU3GVlX9tcG1Dx+ZE2Sndygcni4rjGu47sFuH8nvJZWiNQ+tnmGeOG6Cf
 0bkcAZ+dBMkUEsZK+3Lo3Y+LWZf/b9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661495191;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8FyaCeu1p394DDeH1MtqYFAwPHBz1rJ6XEWtZlik4Y=;
 b=WBoUH/3zYtIwjDlaoTGijVZrL6i0V77FeB4PuLWGS8fEIQqUEivU80535EuuqAjLNES8w0
 d5N0jWUv7V1Y3QCw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B79022C141;
 Fri, 26 Aug 2022 06:26:30 +0000 (UTC)
References: <20220825105204.953388-1-dylan@andestech.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Dylan Jhong <dylan@andestech.com>
Date: Fri, 26 Aug 2022 07:12:19 +0100
In-reply-to: <20220825105204.953388-1-dylan@andestech.com>
Message-ID: <87k06v1pwp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/semctl03: Solve kernel panic in semctl03
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
Cc: randolph@andestech.com, ltp@lists.linux.it, x5710999x@gmail.com,
 alankao@andestech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Dylan Jhong <dylan@andestech.com> writes:

> When using semctl() through glibc and __IPC_TIME64 is defined, glibc will
> call a converted semun64_to_ksemun64() function[*1]. If the parameter of
> this function is NULL, it will cause a NULL pointer dereference kernel
> panic.

This is a kernel bug. Generally speaking, we shouldn't be able to create
kernel panics from user land. The kernel should return EFAULT if we pass
an invalid pointer.

If this test causes a kernel panic then it should be kept as-is. If it
is not testing what it was originally intended to, then another test can
be created to do that.

>
> In semctl03.c, we need to ensure the element "struct semid_ds *buf" in 4th
> parameter "union semun" in semctl() is not NULL. But the 4th parameters of
> libc_semctl() and sys_semctl() are hard-coded[*2] and the element
> "struct semid_ds *buf" is not given an initial value. Using va_list to pass
> the correct parameters can solve the problem.
>
> ref:
>   [*1]: https://github.com/bminor/glibc/blob/f94f6d8a3572840d3ba42ab9ace3ea522c99c0c2/sysdeps/unix/sysv/linux/semctl.c#L172
>   [*2]: https://github.com/linux-test-project/ltp/blob/58caa8cca507133ea92bd0ea277b91add96e72af/testcases/kernel/syscalls/ipc/semctl/semctl03.c#L45
>
> Co-developed-by: Randolph <randolph@andestech.com>
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>  testcases/kernel/syscalls/ipc/semctl/semctl03.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> index a1a4c81ce..bb25053e2 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> @@ -28,11 +28,21 @@ static union semun arg = {0};
>  
>  static int libc_semctl(int semid, int semnum, int cmd, ...)
>  {
> +	va_list ap;
> +
> +	va_start(ap, cmd);
> +	arg = va_arg(ap, union semun);
> +	va_end(ap);
>  	return semctl(semid, semnum, cmd, arg);
>  }
>  
>  static int sys_semctl(int semid, int semnum, int cmd, ...)
>  {
> +	va_list ap;
> +
> +	va_start(ap, cmd);
> +	arg = va_arg(ap, union semun);
> +	va_end(ap);
>  	return tst_syscall(__NR_semctl, semid, semnum, cmd, arg);
>  }
>  
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
