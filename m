Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B0EFF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777361727; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HbAdL1NJrvbVpqjlTe5p13dtn+D+lqnED7zav6udNeo=;
 b=jbEXtJctL8LJ1NX5Y1tvJIojg7uE2M+V4BGkUIoABABqWCW7+z8c5FKfA4tYFEfGIaFt1
 ZnbqC4sKSCpdl4X1uWhA8FAmhCt4iEg/18HbVkIv+MNKg1CyOFVIT762DOtm3tT6xSCxatQ
 uhscvIYpFJvV8FaycLQ4m+MTUEogGLQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D50F3E212A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:35:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 156CF3C66CA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:35:04 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 748E81000366
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:35:04 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so136605855e9.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777361704; x=1777966504; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qwSG9+ImqWtCze9L5Pr33TTv7UdfIErxiurwFLoUk84=;
 b=So5ayBTH+B/7Bv6BIZQqkN6BtFqWt77FQTdhLIA8e/aWUmcsYqS2ImwxANryX2alVR
 T6RIjSTdIN/HrNTwnyodz3UmYHBQcooi/KVZLZwrlvW4zfZKCm4JtZRDWtVE3ft5erxv
 irllPQNZ2GnI9xT/VVtmWdf7VBXlgdaTUAut3uewlm5ymiRyEQi7Sp8rB4xeHYtu/M8G
 lYlmuyVpUhkiWwQRTW3R5H/uTJMaqisX+9sAboGWsNTjEQ1UUrrJYZRBojmGdPs8LVOx
 N6xwbYPZzVLDbGpn6o7/lI3A/V9GFZqUbQ8ZsRN40my2/UL2M/pfoVoQr8t2InAaLT+7
 i+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361704; x=1777966504;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwSG9+ImqWtCze9L5Pr33TTv7UdfIErxiurwFLoUk84=;
 b=KtI/v8sntdqG7r0gCGVQdyq1875iHvtOheqE3FisF633JsikyirBbK2ZFz+DzWQev0
 njrvvr5ArBtCreLu2JBV3gd/mntgXaZedHDTRXcwHPwKDh+Ry88uAIayFSOo51hRAHym
 hS+GhUrmi2rdO1i9S4w1VeMTGEcSa8oIi7rVcR/stT7/S3LfQLq02cMYGLw1/Y5cHxM9
 GnIV05dRmZXKcKIxIjM7BEE1UxJyNAPIA3jYe4SPfeaM9mTLg61nIyujToQT+zkXDzCu
 Bj6/npix+6iZESQUH/nZDtRKK6AWPssfv3/sSF9T0qc2ChP8N+QU1D2BdbHCAXwm9ZOV
 q8Gw==
X-Gm-Message-State: AOJu0YyiAOE8T1EQbgN6xqLuvAsDXkYuy0GmtyJEyEPjV9M3A5k/kyzw
 LQa51IQsoJR2UD31nn9NF+QgFBCplopSnPcchedy9PWCGOsHKw5oiAiVrlCBmruEAHZ5PLa08NI
 OrxMlgGI=
X-Gm-Gg: AeBDieuS23fUjiIfxfNlee6mRt7HbWW+P7fFQOonXTIakpaFe9SiRVCGQVUvU1cXwsU
 OnVcTmnakC7IFp48Pdqjty4Do1OWHK9sfS3PeTtca6mA2wWC87XwtWsPleZVntLDdu+4HrbFvB0
 O3Hz712mg6PvvYNxD5MNRRvHDbKwDbHmQbvj6ciZ2fZ4xYmIK47gpKaU+AfoEHqGPOXzAB9wvoC
 ovxmDKI8PFLuQ2oJ0Da4LWhRVj7hf4J0tJea9h7vTAWwkpVwvOtIZMqQSd86+aeg+ekfvC3eJuq
 kFq9+4geQ7tagK/awejhmxfD1jaznExUS2HEkdGphqgiI649W8a8ErafY5DF7A6Z/qOJQrmviNq
 YE7/V2G/0VLGC74qZW9gq9fkCciEaEo6CX3mbR/DaOnrafLfy+S93C8kI8T2uiGuIeWdQCPPRiD
 L+bhqYGb+vN0zJgGm7/iJOjnWjUFyS2a9yx11MmlUVpUXlFKN4xRWO
X-Received: by 2002:a05:600c:46ca:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48a77b05c6amr33132205e9.15.1777361703674; 
 Tue, 28 Apr 2026 00:35:03 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77aeb202sm57557405e9.2.2026.04.28.00.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:35:03 -0700 (PDT)
Message-ID: <69f06327.050a0220.2201aa.058f@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-6-chrubis@suse.cz>
Date: Tue, 28 Apr 2026 07:34:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/8] syscalls: Add epoll_wait10
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

> Functional test for EPOLLPRI using /proc/mounts that produces POLLPRI
> when a filesystem is mounted/umounted.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/syscalls                              |   1 +
>  .../kernel/syscalls/epoll_wait/.gitignore     |   1 +
>  .../kernel/syscalls/epoll_wait/epoll_wait10.c | 107 ++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b302935d5..3fd61b814 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -198,6 +198,7 @@ epoll_wait06 epoll_wait06
>  epoll_wait07 epoll_wait07
>  epoll_wait08 epoll_wait08
>  epoll_wait09 epoll_wait09
> +epoll_wait10 epoll_wait10
>  
>  epoll_pwait01 epoll_pwait01
>  epoll_pwait02 epoll_pwait02
> diff --git a/testcases/kernel/syscalls/epoll_wait/.gitignore b/testcases/kernel/syscalls/epoll_wait/.gitignore
> index f32ec535b..30139375d 100644
> --- a/testcases/kernel/syscalls/epoll_wait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_wait/.gitignore
> @@ -7,3 +7,4 @@ epoll_wait06
>  epoll_wait07
>  epoll_wait08
>  epoll_wait09
> +epoll_wait10
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
> new file mode 100644
> index 000000000..82cd8b15e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait10.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * Verify that epoll_wait with EPOLLPRI detects changes to /proc/mounts.
> + *
> + * The kernel generates a poll notification (POLLPRI/EPOLLERR) on
> + * /proc/mounts whenever the mount namespace changes. This test verifies
> + * that epoll can observe these notifications.
> + *
> + * [Algorithm]
> + *
> + * - Open /proc/mounts and register it with an epoll instance for EPOLLPRI.
> + * - Fork a child that mounts and then unmounts a tmpfs filesystem, using
> + *   checkpoints to synchronize with the parent.
> + * - After each mount namespace change the parent calls epoll_wait and verifies
> + *   it returns an event.
> + *
> + * Needs root to call mount/umount.
> + */
> +
> +#include <sys/epoll.h>
> +
> +#include "tst_test.h"
> +#include "tst_epoll.h"
> +
> +#define MNTPOINT "mnt_epoll"
> +
> +static int efd = -1, mnt_fd = -1;
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(MNTPOINT, 0777);
> +
> +	mnt_fd = SAFE_OPEN("/proc/mounts", O_RDONLY);
> +
> +	efd = SAFE_EPOLL_CREATE1(0);
> +
> +	struct epoll_event ev = {
> +		.events = EPOLLPRI,
> +		.data.fd = mnt_fd,
> +	};
> +
> +	SAFE_EPOLL_CTL(efd, EPOLL_CTL_ADD, mnt_fd, &ev);
> +}
> +
> +static void check_epoll_event(const char *desc)
> +{
> +	struct epoll_event ret_ev;
> +	char buf[1024];
> +
> +	TEST(epoll_wait(efd, &ret_ev, 1, 1000));
> +	if (TST_RET < 1) {
> +		tst_res(TFAIL | TTERRNO,
> +			"epoll_wait() after %s returned %li", desc, TST_RET);

return; here.

> +	} else if (!(ret_ev.events & (EPOLLPRI | EPOLLERR))) {
> +		tst_res(TFAIL,
> +			"after %s: events %x, expected EPOLLPRI or EPOLLERR",
> +			desc, ret_ev.events);
> +	} else {
> +		tst_res(TPASS,
> +			"epoll_wait() reported event after %s", desc);
> +	}

And here I would use TST_EXP_* instead. But feel free to ignore.

> +
> +	/* Re-read /proc/self/mounts to clear the notification */
> +	SAFE_LSEEK(mnt_fd, 0, SEEK_SET);
> +	while (SAFE_READ(0, mnt_fd, buf, sizeof(buf)) > 0)
> +		;
> +}
> +
> +static void run(void)
> +{
> +	if (!SAFE_FORK()) {
> +		SAFE_MOUNT("none", MNTPOINT, "tmpfs", 0, NULL);
> +		TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +		SAFE_UMOUNT(MNTPOINT);
> +		TST_CHECKPOINT_WAKE(0);
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +	check_epoll_event("mount");
> +
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +	check_epoll_event("umount");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (efd != -1)
> +		SAFE_CLOSE(efd);
> +
> +	if (mnt_fd != -1)
> +		SAFE_CLOSE(mnt_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.52.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

Besides these observations:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
