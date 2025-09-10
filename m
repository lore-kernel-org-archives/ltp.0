Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8E3CA0FED
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757496518; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IxTOLLHMDZvNiEpHfeEa3fb57CG3rDtk3f9cRY7d5Q0=;
 b=FCxkB9LVL63vwaUpV6/wPwzFgx5R3GUOWApO/sJgWgByaWB+LSpwlw2nS74F+UbMw0vaY
 pAzhlodPV9Qd/9lfXYpaDantKnFH+Dl8UciRXezV3R5GGV3hdPRjIsXYu/Vu83SeRMwyogk
 h/vrpXYTQP2iEvHx2HIzN2l0D3XmoAA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB42F3CD788
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 11:28:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB3A03C2472
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 11:28:17 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E63956000FA
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 11:28:16 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-62105d21297so9996105a12.0
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757496496; x=1758101296; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cAYqNyb7KfKIaAMOHMzDD50W8BBTNCIAwHbYVnz5TXU=;
 b=QJZdG7HI8lOZsZhg7igIZNLYtjlTYiVU/sUYXkbf5c3mcHG0wI8NuUrLhc5yBuRah3
 JipE74i19GlUBneXY95X6DhhEuudND8Qr07j7zu3HdRnc2u0ykr49vXGf2oUiI5NYrEq
 tg7HunYlNlutIROifKqmjLksoYumgGlQeSP75nHBKnqWoI/sypEQq6raI2yuE8Ya3XE3
 52my588RoLvuRxpgaya2FBB0YAePJ+CuD/Sk5VRMZsxofdIryNiYsrurM1GM3kwtF2mO
 0xmJxda+pny+1X1DpXR5nuvCizOo56VJdfEeIK12TyOTUE9LuLpjqhyAQfmrL3TDR7Xh
 bBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757496496; x=1758101296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAYqNyb7KfKIaAMOHMzDD50W8BBTNCIAwHbYVnz5TXU=;
 b=uYnuLPPesdrV8aJb4cV53nkUCQjCU6eraSGQ2yCMwagb2pGYizVt71i3sLpT7hX/w3
 Inwip/t55YcR1JVyIUJKpzsEVMYx98lbN5wFLt9ihqTJgYxtuuIIuMRJrJ02KwCN6qor
 99b4QhIDAF2wQgHvjBc3mVGrcJzzFGYVmMMPQDGh+Q73oCe/nAQZVYF+keFalSVgEW57
 ELxYGqUhXWlT/4G5SCwrgFHB+ZIe1LzOWawq6EM7qM2PHMFaZkgKFxDYWOXRKjKmx4Rg
 1LsUzrCk68GvIoCPbJSTBWq8n4f4DcKCIAzoM7rc+hjxMiuk8dMt/CNRFqN/lJ8Tzkrw
 V/0A==
X-Gm-Message-State: AOJu0YxNfO4q3tuJl3cIdxmJHA/4e+jBa/8vmYLf1uCiP3XW9YlVSR9o
 S7imSlJEYAoVWkhDNERrR0LCt/CrrIPriZ6btv+V6L+YEntivsDQdUdz/Lk4clHLU8u7gBMVv1X
 CQvE=
X-Gm-Gg: ASbGncuq++3Gq1+e6sGOlPckhoGvt6rhPMhTXi4qo9rbsXIVMs1Jpl+wfxOOrBO8gGN
 WhLHs2dHJTPtHcSyEdy9XoofKEC0Q1AE9yCjXJcFT1gq2IDrTzj/MWzXSVIBiOlHsWgxtRsUY5u
 qWg6dIAEO2nhAlm1qkgBjrHn3rffLGPfg1AxBKaU/s1s//bdkZxKUGQS5At/89MeHP+WQC7lw3v
 UKZUEeba1VajGvef+kP/2BUxyIzzEWe0ZSMKWp7flajS1ZA/6PSTS0nIwDN3KoxdFBZmnBLjkhJ
 VP4YqB9LCjD1+zEf3j+ReYVF1/t/p+uERgYI0LKRYkx/EHqgTQkQCjfmBwWDRScp25Zkm8TW9uX
 4pbojGpYFJkuOLq9mWMoZpcYyiaHDdj7saynNnNNngKU=
X-Google-Smtp-Source: AGHT+IG1RqSg3SQDjjtbuLJbrSC1tnIgbXLLDuT7laF6AIY751qeDEE3ZqdiI8dRS/EtdrPioe+gMA==
X-Received: by 2002:a17:907:3c83:b0:b04:2252:7cb1 with SMTP id
 a640c23a62f3a-b04b13fe9d2mr1475592566b.12.1757496496150; 
 Wed, 10 Sep 2025 02:28:16 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07833ffa54sm133061266b.90.2025.09.10.02.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 02:28:15 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:28:14 +0000
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aMFErlYQPS-iH20n@localhost>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
 <20240812-process_mrelease-v2-3-e61249986a0a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240812-process_mrelease-v2-3-e61249986a0a@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add process_mrelease02 test
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Aug 12, 2024 at 01:46:30PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> This test verifies that process_mrelease() syscall correctly raises
> the errors.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                   |  1 +
>  .../kernel/syscalls/process_mrelease/.gitignore    |  1 +
>  .../syscalls/process_mrelease/process_mrelease02.c | 84 ++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index de90e9ba3..f3cb7d465 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1074,6 +1074,7 @@ preadv203_64 preadv203_64
>  profil01 profil01
>  
>  process_mrelease01 process_mrelease01
> +process_mrelease02 process_mrelease02
>  
>  process_vm_readv01 process_vm01 -r
>  process_vm_readv02 process_vm_readv02
> diff --git a/testcases/kernel/syscalls/process_mrelease/.gitignore b/testcases/kernel/syscalls/process_mrelease/.gitignore
> index 673983858..f1e7a8fea 100644
> --- a/testcases/kernel/syscalls/process_mrelease/.gitignore
> +++ b/testcases/kernel/syscalls/process_mrelease/.gitignore
> @@ -1 +1,2 @@
>  /process_mrelease01
> +/process_mrelease02
> diff --git a/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
> new file mode 100644
> index 000000000..ced556243
> --- /dev/null
> +++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that process_mrelease() syscall is raising errors:
> + * * EBADF when a bad file descriptor is given
> + * * EINVAL when flags is not zero
> + * * EINVAL when memory of a task cannot be released because it's still running
> + * * ESRCH when child has been closed
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +static int badfd = -1;
> +static int pidfd;
> +
> +enum {
> +	NO_CHILD,
> +	EXIT_CHILD,
> +	WAIT_CHILD,
> +};
> +
> +static struct tcase {
> +	int child_type;
> +	int *fd;
> +	int flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{NO_CHILD, &badfd, 0, EBADF, "bad file descriptor"},
> +	{WAIT_CHILD, &pidfd, -1, EINVAL, "flags is not 0"},
> +	{WAIT_CHILD, &pidfd, 0, EINVAL, "task memory cannot be released"},
> +	{EXIT_CHILD, &pidfd, 0, ESRCH, "child is not running"},
> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int status;
> +
> +	if (tc->child_type != NO_CHILD) {
> +		pid_t pid;
> +
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			if (tc->child_type == WAIT_CHILD)
> +				TST_CHECKPOINT_WAIT(0);
> +
> +			exit(0);
> +		}
> +
> +		tst_res(TINFO, "Spawned waiting child with pid=%d", pid);
> +
> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
> +
> +		if (tc->child_type == EXIT_CHILD)
> +			SAFE_WAITPID(pid, &status, 0);
> +	}
> +
> +	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
> +		tc->exp_errno,
> +		"%s", tc->msg);
> +
> +	if (tc->child_type != NO_CHILD) {
> +		if (tc->child_type == WAIT_CHILD)
> +			TST_CHECKPOINT_WAKE(0);
> +
> +		SAFE_CLOSE(pidfd);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.min_kver = "5.15",

I suggest also using syscall check process_mrelease support or not like
kernel selftest. Such as:
        if (!syscall(__NR_process_mrelease, -1, 0) || errno != EBADF) {
                if (errno == ENOSYS) {
                        ksft_test_result_skip("process_mrelease not implemented\n");
                        ksft_finished();

> +	.needs_checkpoints = 1,
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
