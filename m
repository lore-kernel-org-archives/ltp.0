Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E7C64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 06:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4477A3CB70D
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 07:58:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7FE33CB077
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 07:58:46 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 27D4A601AAB
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 07:58:44 +0100 (CET)
Received: by mail-pj1-x1032.google.com with SMTP id
 fr5-20020a17090ae2c500b0023af8a036d2so8033342pjb.5
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 22:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1678431522;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKMSgrHmZWge5zozjl32mKkoBGKk/vb1YNuGvwP9dNY=;
 b=hp3eokfsup0rThD0jcaD35vsCazCfwaLDQSlwhv8h1dOV7Hd8VANCvhlzmve2rt0MG
 gBgF5iblhqr6vUdq1YR/N+AScpu1DZeAamydmI68UIxludiPXj9K/cRKyE6ag9jiBSS8
 AeSj4aFTO9Kj113HVsr0N/IMWhiJ6+5b+tgSXEix97sp8VIAo4iP0nv/0bSzTw7nxTWJ
 WyzTq1VoXErwXvnN7uCVP2t0Wde2ewI+76El/OSE6d92oY2Cn49b9Qoszx98fC8G98DL
 B8H5FkiqmSiJA2yboWtIqJX+CoTxeM7bc0C6qSoxf/fb1g908PXALO6nH6iE1Yq88zdg
 47AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678431522;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vKMSgrHmZWge5zozjl32mKkoBGKk/vb1YNuGvwP9dNY=;
 b=LjAbEw4QnZyhJf6amccnv/NtjRBlG6qf8MOzc0gcotn7MsCpm+yqzos8XwRRzV6YnU
 H0Yh3vpE8ujnWY0Qm7FOOg3SZtsKibD1t+7IW8MJUEm/civA3WwlWNp7a9AbXVZ99qTr
 MgIyIqDye7t/rf05WX0bK0NXqyNvIn6kqukFvfhq0Gz831xGcliT6A9DQRbzRZP9WWD8
 PDY3iSzl/vh1i/WYkbSkZa2+wD7owFHv4snq11CClIlU2qGbdEQswl53++GdvNTiOu65
 dN9+lvdlae0Ojr8GeCw2hkVVyy0PiWegVJYVris6Udb7pO//SXGtIg+ut8DQYnxM6OPv
 qRIw==
X-Gm-Message-State: AO0yUKXdWbPKGpAkg+VTttAlPoXNcg85vP9itTtWVwsHQ1RvYsdGKa5t
 lJQPJkvm38q7JsvyMi9gAwc6YA==
X-Google-Smtp-Source: AK7set9ZCmx9yFAatbXnD1rKJ+pM2tREqidy4qEG11sVPt99O+PgM6CTuAzkZHkyG0QW5StS2+l2hw==
X-Received: by 2002:a05:6a20:8e19:b0:cd:fc47:dd74 with SMTP id
 y25-20020a056a208e1900b000cdfc47dd74mr1946696pzj.4.1678431522471; 
 Thu, 09 Mar 2023 22:58:42 -0800 (PST)
Received: from [192.168.11.4] (165.141.30.125.dy.iij4u.or.jp. [125.30.141.165])
 by smtp.gmail.com with ESMTPSA id
 km14-20020a17090327ce00b0019a75ea08e5sm715491plb.33.2023.03.09.22.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Mar 2023 22:58:41 -0800 (PST)
Message-ID: <ba91dc79-cbbe-52d0-8bcb-d0fda74dad34@miraclelinux.com>
Date: Fri, 10 Mar 2023 15:58:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20230215144820.17876-1-wegao@suse.com>
 <20230221020853.7650-1-wegao@suse.com>
From: Souta Kawahara <souta.kawahara@miraclelinux.com>
In-Reply-To: <20230221020853.7650-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mq_notify03.c: New test CVE-2021-38604
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

I tried this test on several environments and got the expected results. 
and no problems were encountered.
env1) Test PASSED on glibc2.23-21.fc34 after vulnerability fix.
env2) Test PASSED on glibc2.23-5.fc34 before the regression.
env3) Test FAILED as expected on glibc2.23-16.fc34 after the regression, 
before vulnerability fix.

It looks good from my site.
If there is anything else I should check, please let me know.

Thank you!

On 2023/02/21 11:08, Wei Gao via ltp wrote:
> This test is come from glibc test mq_notify.c.
> Implements following logic:
> 1) Create POSIX message queue.
>     Register a notification with mq_notify (using NULL attributes).
>     Then immediately unregister the notification with mq_notify.
>     Helper thread in a vulnerable version of glibc
>     should cause NULL pointer dereference after these steps.
> 2) Once again, register the same notification.
>     Try to send a dummy message.
>     Test is considered successfulif the dummy message
>     is successfully received by the callback function.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   runtest/cve                                   |  1 +
>   runtest/syscalls                              |  1 +
>   .../kernel/syscalls/mq_notify/.gitignore      |  1 +
>   .../kernel/syscalls/mq_notify/mq_notify03.c   | 99 +++++++++++++++++++
>   4 files changed, 102 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/mq_notify/mq_notify03.c
> 
> diff --git a/runtest/cve b/runtest/cve
> index 1ba63c2a7..07bcac0b0 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -74,6 +74,7 @@ cve-2021-26708 vsock01
>   cve-2021-22600 setsockopt09
>   cve-2022-0847 dirtypipe
>   cve-2022-2590 dirtyc0w_shmem
> +cve-2021-38604 mq_notify03
>   # Tests below may cause kernel memory leak
>   cve-2020-25704 perf_event_open03
>   cve-2022-4378 cve-2022-4378
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 81c30402b..536140a3e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -832,6 +832,7 @@ pkey01 pkey01
>   
>   mq_notify01 mq_notify01
>   mq_notify02 mq_notify02
> +mq_notify03 mq_notify03
>   mq_open01 mq_open01
>   mq_timedreceive01 mq_timedreceive01
>   mq_timedsend01 mq_timedsend01
> diff --git a/testcases/kernel/syscalls/mq_notify/.gitignore b/testcases/kernel/syscalls/mq_notify/.gitignore
> index cca05a7fa..3f9403c05 100644
> --- a/testcases/kernel/syscalls/mq_notify/.gitignore
> +++ b/testcases/kernel/syscalls/mq_notify/.gitignore
> @@ -1,2 +1,3 @@
>   /mq_notify01
>   /mq_notify02
> +/mq_notify03
> diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify03.c b/testcases/kernel/syscalls/mq_notify/mq_notify03.c
> new file mode 100644
> index 000000000..5c322ef0e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mq_notify/mq_notify03.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) The GNU Toolchain Authors.
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + *
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test for NULL pointer dereference in mq_notify(CVE-2021-38604)
> + *
> + * References links:
> + * - https://sourceware.org/bugzilla/show_bug.cgi?id=28213
> + */
> +
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <mqueue.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "tst_test.h"
> +#include "tst_safe_posix_ipc.h"
> +
> +static mqd_t m = -1;
> +static const char msg[] = "hello";
> +
> +static void try_null_dereference_cb(union sigval sv)
> +{
> +	char buf[sizeof(msg)];
> +
> +	(void)sv;
> +
> +	TST_EXP_VAL((size_t) mq_receive(m, buf, sizeof(buf), NULL)
> +				, sizeof(buf));
> +	TST_EXP_PASS(memcmp(buf, msg, sizeof(buf)));
> +
> +	exit(0);
> +}
> +
> +static void try_null_dereference(void)
> +{
> +	struct sigevent sev;
> +
> +	memset(&sev, '\0', sizeof(sev));
> +	sev.sigev_notify = SIGEV_THREAD;
> +	sev.sigev_notify_function = try_null_dereference_cb;
> +
> +	/* Step 1: Register & unregister notifier.
> +	 * Helper thread should receive NOTIFY_REMOVED notification.
> +	 * In a vulnerable version of glibc, NULL pointer dereference follows.
> +	 */
> +	TST_EXP_PASS(mq_notify(m, &sev));
> +	TST_EXP_PASS(mq_notify(m, NULL));
> +
> +	/* Step 2: Once again, register notification.
> +	 * Try to send one message.
> +	 * Test is considered successful, if the callback does exit (0).
> +	 */
> +	TST_EXP_PASS(mq_notify(m, &sev));
> +	TST_EXP_PASS(mq_send(m, msg, sizeof(msg), 1));
> +
> +	/* Wait... */
> +	pause();
> +}
> +
> +static void do_test(void)
> +{
> +	static const char m_name[] = "/ltp_mq_notify03";
> +	struct mq_attr m_attr;
> +
> +	memset(&m_attr, '\0', sizeof(m_attr));
> +	m_attr.mq_maxmsg = 1;
> +	m_attr.mq_msgsize = sizeof(msg);
> +
> +	m = SAFE_MQ_OPEN(m_name,
> +			O_RDWR | O_CREAT | O_EXCL,
> +			0600,
> +			&m_attr);
> +
> +	TST_EXP_PASS(mq_unlink(m_name));
> +
> +	try_null_dereference();
> +}
> +
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.tags = (const struct tst_tag[]) {
> +		{"glibc-git", "b805aebd42"},
> +		{"CVE", "2021-38604"},
> +		{}
> +	},
> +	.needs_root = 1,
> +};

--
Souta Kawahara <souta.kawahara@miraclelinux.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
