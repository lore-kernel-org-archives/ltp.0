Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24548C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 08:25:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 972E93CB180
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 10:25:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 132D63CB0DB
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 10:25:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0113600C7D
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 10:25:42 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1B3141F38D;
 Thu, 20 Oct 2022 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666254342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcSa5SpEAfVWXkPx8rytEYWViSSTsD4VLprTKevxHD8=;
 b=kFXzLZYsmu5ShhO3VhgCB1hdADvExvQwCiGi9jRB2lKSXd6f6LtsXbAWg0Ph8hLKjYTOFB
 m7VkU5uvnmDOYM0Rv/t9RrPqTXvtgMqaCJBtiMmmC3r3dj7kdOiifre0UeZwC+Rya6lngI
 OJAUUZcZeM/hkK3VszYiNerjo84i8ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666254342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcSa5SpEAfVWXkPx8rytEYWViSSTsD4VLprTKevxHD8=;
 b=ATjOwonr1OnwsRxXZXIn3yXfe48M/1kGF480Dfi1JLbioDdKEnw5A44ddUK66qJ6B3/xrR
 T6RTv8+tXpUtPIAg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B098D2C141;
 Thu, 20 Oct 2022 08:25:41 +0000 (UTC)
References: <20221009065520.3236525-1-liwang@redhat.com>
 <20221009065520.3236525-2-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 09:17:00 +0100
In-reply-to: <20221009065520.3236525-2-liwang@redhat.com>
Message-ID: <875ygex5ob.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setitimer03: convert to new API
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

Li Wang <liwang@redhat.com> writes:

> Combine this EINVAL test into setitimer02 and add one additional
> ITIMER_VIRTUAL verification.

EINVAL is not mentioned in the test description.

>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/syscalls                              |   1 -
>  .../kernel/syscalls/setitimer/.gitignore      |   1 -
>  .../kernel/syscalls/setitimer/setitimer02.c   |  30 +++-
>  .../kernel/syscalls/setitimer/setitimer03.c   | 158 ------------------
>  4 files changed, 24 insertions(+), 166 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/setitimer/setitimer03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 61a7b7677..2d673836d 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1325,7 +1325,6 @@ sethostname03 sethostname03
>  
>  setitimer01 setitimer01
>  setitimer02 setitimer02
> -setitimer03 setitimer03
>  
>  setns01 setns01
>  setns02 setns02
> diff --git a/testcases/kernel/syscalls/setitimer/.gitignore b/testcases/kernel/syscalls/setitimer/.gitignore
> index 048db9b31..35779a32c 100644
> --- a/testcases/kernel/syscalls/setitimer/.gitignore
> +++ b/testcases/kernel/syscalls/setitimer/.gitignore
> @@ -1,3 +1,2 @@
>  /setitimer01
>  /setitimer02
> -/setitimer03
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
> index 9ac9ce1fa..ccba231c9 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer02.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
> @@ -18,17 +18,33 @@
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> -static struct itimerval *value;
> +static struct itimerval *value, *ovalue;
> +
> +static struct tcase {
> +       int which;
> +       struct itimerval **val;
> +       struct itimerval **oval;
> +       int exp_errno;

There is a whitespace error here (see checkpatch/make check)

> +} tcases[] = {
> +       {ITIMER_REAL,    &value, &ovalue, EFAULT},
> +       {ITIMER_VIRTUAL, &value, &ovalue, EFAULT},
> +       {-ITIMER_PROF,   &value, &ovalue, EINVAL},
> +};

Why do we need value and ovalue in the struct?

>  
>  static int sys_setitimer(int which, void *new_value, void *old_value)
>  {
>  	return tst_syscall(__NR_setitimer, which, new_value, old_value);
>  }
>  
> -static void verify_setitimer(void)
> +static void verify_setitimer(unsigned int i)
>  {
> -	TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (struct itimerval *)-1),
> -	             EFAULT);
> +        struct tcase *tc = &tcases[i];
> +
> +	if (tc->exp_errno == EFAULT)
> +		*(tc->oval) = (struct itimerval *)-1;

Or, why do we use an if statement here instead of defining it in the struct?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
