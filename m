Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D91FFF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777361537; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=aJkIAZSgf7I/kXtRKpRe95SGfN/CVr8dnEW41WzMJzk=;
 b=e7hNk2/v5nGzQ9sJRigNb9wS6NGkdVIcpKGgDrMRa0Pz03sofOBI6HWZr+S20jrnCOT83
 /VpcaUEnSVn2OV3z8sCWgh4y1cf56LQDDnKSa+MGMU2waWftwuwXL38Qriq+aVuqkTWR2vU
 1Lu6sXIVuax4UOeFOaSbXrL+6WLIw0c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B5EB3E28A5
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:32:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77D703E211D
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:31:52 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5BD36002B5
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:31:51 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso94836175e9.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777361511; x=1777966311; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tejHl+znQg/DcsDJBenRJAwQVhFOC9e4cJ7WPiEhG84=;
 b=HYKZMDYNwEWUgTCIYDOM/Z4SO+v3D5YSZu6zqOkYujnAoHxGapaS2Br0BifcFKSUVA
 LLF08us2acQTMcBC349IIg1Od7CrHq0R4vuofDuUc5/DnH43IbZjhZQ1XesrHlWbEUed
 ksyIeXlGQ+OdWAEANPFh7M4n2S3XsX/aVTRguyzdZ438V3nLtKaCC08K5XUhyoos8YGz
 PTTqlpAc59mLB++JlPIJ1PGYWfXkexMT6cAORJ8eJPNzp+4fhaJU4iXQUeQf1Qti6yfc
 y2TSEHjv1z2AUXCtMm0wzl7oHXrWvD6P5ayN0u8E/VqkPKqn+/l2qqA4c8TmslR9V8AX
 f2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361511; x=1777966311;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tejHl+znQg/DcsDJBenRJAwQVhFOC9e4cJ7WPiEhG84=;
 b=nSw4tbsW9O77WEsJUxebyD9VzqVBGQiBH9vxyLR4mr4GOvbUoOVlFZVmh0LCwfSEJk
 rrnx3qa3D2N191xzzghTnr9alaWr7y0PE+REKWVFpO7S8Jk1SzWnJG/80wHk+Yh8xGjR
 BokRp3YdtKr++ZhRjS/7U04yhAUOgX9TQXN+8vk99qX6C0tBGSaTxPCFkDz7wd7PCQwF
 187dXUMcS4ntmvrHBz5JK+k9HbdOXLj9p/+5TrPQ0jJ1EbdQ+JiHi/W3m7Dxd3I+cWD1
 DD/HQe9u2hE5eBgG7jbgrnjYe2+dC9eB5UvHmzc0uMgM1Q72KwqtHFjlO9/fWHxMrG2F
 2g0g==
X-Gm-Message-State: AOJu0Yzbu3oYofhukt53We4rDaUdBSw8QfWfV8bJQxPZzIunR26M1isy
 SLUYwhd1Z10EBOZXU077KKrbLXbZgDoxqwjssfLjj5/xeNaHMDcrRwBObtgiuo99aWXRAw1sBV3
 8oZdPAL4=
X-Gm-Gg: AeBDiet9GgRLjbyIs0WFoujzCbx7fBfgjIVvR9VI4iHQJIBp1d5lew7IQ0t23nEPRdA
 tnA0TBwab2FPYF+5coK/yYTYfss+mKeGBlfeSmjvAwWQK3ajvM8Ws3mZJVDk4M1y5SXa4i5PD68
 151xk5zf79bGQ8bPWnn5ABEYPupY/CQBTGkVAIRhLMlYLDWvwNrq4l7BSY2KXN+ZRw5aupwznVo
 XPlbxNEdXCHFcx7677gH9JNC0JSrET6C07D0VJZs3en6b90TFEerfPgQTFnvgoqKeRiOPLUQAJd
 WZ9td4J5LiwNpeeDNrzxEFZYp07mdTtJpu2+w0SwtZTE4Msh6pnNzyakyDHuhH8+U+rUuHXSOKu
 /BnTvDtH4N1kyHH0heAO167QF69BCzVdUTpoRX/OfGmLzp1w7f9h0cS1nt8DoIWkeTua373uimN
 i35ax5olgQsww5wejScUg5yrQBsE9M2X2q/awxtCITEHzWnYR2+GrS
X-Received: by 2002:a05:600c:630a:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-48a77b19d7dmr35859985e9.22.1777361511137; 
 Tue, 28 Apr 2026 00:31:51 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773aeb6dsm45831855e9.5.2026.04.28.00.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:31:50 -0700 (PDT)
Message-ID: <69f06266.050a0220.162ac9.3bf0@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-8-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:31:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/8] syscalls: Add epoll_wait12
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> A test for EPOLLERR when we are waiting to write into a pipe and the
> read end is closed.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/syscalls                              |   1 +
>  .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait12.c | 112 ++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait12.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index c16cf3554..0787bbe72 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -200,6 +200,7 @@ epoll_wait08 epoll_wait08
>  epoll_wait09 epoll_wait09
>  epoll_wait10 epoll_wait10
>  epoll_wait11 epoll_wait11
> +epoll_wait12 epoll_wait12
>  
>  epoll_pwait01 epoll_pwait01
>  epoll_pwait02 epoll_pwait02
> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
> index 57bdf0806..ad890d077 100644
> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
> @@ -9,3 +9,4 @@ epoll_wait08
>  epoll_wait09
>  epoll_wait10
>  epoll_wait11
> +epoll_wait12
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait12.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait12.c
> new file mode 100644
> index 000000000..eed395fcf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait12.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Linux Test Project, 2026
> + */
> +
> +/*\
> + * Verify that epoll_wait reports EPOLLERR when the read end of a pipe is
> + * closed while a child process is blocked in epoll_wait on the write end.
> + *
> + * [Algorithm]
> + *
> + * - Create a pipe and fill it completely so the write end is not writable.
> + * - Register the write end with an epoll instance for EPOLLOUT.
> + * - Fork a child that closes its copy of the read end and blocks in
> + *   epoll_wait waiting for the pipe to become writable.
> + * - Parent waits for the child to enter sleep state, then closes the read
> + *   end.
> + * - The child's epoll_wait should return with EPOLLERR set.
> + */
> +
> +#include <sys/epoll.h>
> +#include <poll.h>
> +
> +#include "tst_test.h"
> +#include "tst_epoll.h"
> +
> +static int efd = -1, fds[2] = {-1, -1};
> +
> +static void fill_pipe(int fd)
> +{
> +	char buf[4096];
> +	struct pollfd pfd = {.fd = fd, .events = POLLOUT};
> +	int nfd;
> +
> +	memset(buf, 'a', sizeof(buf));
> +
> +	do {
> +		SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, sizeof(buf));
> +		nfd = poll(&pfd, 1, 0);

Why we don't have a SAFE_POLL() ? I just noticed how many times we are
following a manual errors handling pattern inside the tests.

> +		if (nfd == -1)
> +			tst_brk(TBROK | TERRNO, "poll()");
> +	} while (nfd > 0);
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid;
> +
> +	SAFE_PIPE(fds);
> +	fill_pipe(fds[1]);
> +
> +	efd = SAFE_EPOLL_CREATE1(0);
> +
> +	struct epoll_event ev = {
> +		.events = EPOLLOUT,
> +		.data.fd = fds[1],
> +	};
> +
> +	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, fds[1], &ev);
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		SAFE_CLOSE(fds[0]);
> +
> +		TEST(epoll_wait(efd, &ev, 1, 5000));

We have SAFE_EPOLL_WAIT(), is there a reason why not to use it?
Do we want to track the TST_RET ?

> +		if (TST_RET != 1) {
> +			tst_res(TFAIL | TTERRNO,
> +				"epoll_wait() returned %li, expected 1",
> +				TST_RET);
> +			exit(0);
> +		}
> +
> +		if (ev.data.fd != fds[1]) {
> +			tst_res(TFAIL, "epoll.data.fd %d, expected %d",
> +				ev.data.fd, fds[1]);
> +			exit(0);
> +		}
> +
> +		if (!(ev.events & EPOLLERR)) {
> +			tst_res(TFAIL, "events %x, EPOLLERR not set",
> +				ev.events);
> +			exit(0);
> +		}
> +
> +		tst_res(TPASS,
> +			"epoll_wait() reported EPOLLERR on broken pipe");
> +		exit(0);
> +	}
> +
> +	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
> +	SAFE_CLOSE(fds[0]);
> +	SAFE_CLOSE(fds[1]);
> +	SAFE_CLOSE(efd);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fds[1] != -1)
> +		SAFE_CLOSE(fds[1]);
> +
> +	if (fds[0] != -1)
> +		SAFE_CLOSE(fds[0]);
> +
> +	if (efd != -1)
> +		SAFE_CLOSE(efd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +};
> -- 
> 2.52.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
