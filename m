Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED9C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739971653; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sjDyva2DNmjIad1DfznDzJRA55agosa6dvcamgxAKsY=;
 b=Ii7RqSy2OKVBfk/RlxgD8ZYuNQZ+HwGvX6vsAw53AMvOOvmldga3JWeikcB0jIuqmWffi
 vCJj+G9reqMwyqoCm3mhM/7zzzZSampg7TVMil3IfCtbHOuK7UZTKN9ePl/X/iWkbb5MBGW
 usEH+31uIuHA4TeC60ewpjAvygRtY4A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3F713C2F69
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 14:27:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4287A3C0503
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 14:27:10 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 41F0E1012BC1
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 14:27:10 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abbda4349e9so89872566b.0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 05:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739971630; x=1740576430; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wt+cW90UCf1klmvfTNw7WgQYfUFveJRExxsMwGX1kfI=;
 b=JNK3LHvkX1WquxGwFthwqLYZVwCOSVtMHLqUbiewEPZUqe21QR61PJPrtt2NXWu+J9
 dFzWTLAMZGqKTlCwXuR1h6JxL5GQSOjkgOfvfcPG4Cd2gi0NpmTw059Go74vbravugp1
 CCmx9y0BEvDiCE0/f+e2cUuusc2AKTQNaBHzBfuZ5hCJcpfnHxK2Wjah83DH/4RgzNYe
 eJhMIYngVnIxlzeWdEtOiP9lUvzx06HWcG8++VcBwlhspHGxLREOGU9jLjcW+tCjEzNH
 +zkPNIqEs8cLCVNBVfmNWENhlMR+/XlOCJbUxShmfvzeyNNs7+DV4OUPOaamVm5LYSwH
 9cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739971630; x=1740576430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wt+cW90UCf1klmvfTNw7WgQYfUFveJRExxsMwGX1kfI=;
 b=R1LsNRJoTyRrkKPVdxlapDgSiFRafHAt94NiywyU13dJWO5sPb6PWrLM5QbJ2BD7xi
 nkRLaf6v67abFAI7u/LD+NbboBnxhDVs5kfCno+UqD/qvH3Ji3GELjJCzmWVCk+FKhe1
 fbbEG5HTsXDV2zgcYa4agGRidf4SilPf6jFSqf5UMQ1MjLUt78TVuSpPqUBL8vWT71wh
 7+aA8HjMvcUr7zmbtoWYAEoeLOIcmscCGtBENTHFBAtTFXZJ4qMleH2N2Df7vqoDSFme
 yra5y8BXSFDD1lsPzPjuzW10CwIdD8qSB3KoX+FIxLymewIPniOyQz3XKrTpSklnqH9w
 5GNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwz5/14OBX4xl5PIRCUHeHh0HmKy2jHiKAYVi6KUWowpLUSG+UWs/gEbU2PGG99Zz3Prk=@lists.linux.it
X-Gm-Message-State: AOJu0YyQghHVp/TFDTBLEuDmMAMNz1qVTGGhNCpUo/03ee8t6fSL7pwV
 NpbReEbmyUPNqwzVTHAyh7u2lQ3qddbQnp8YZ9dFyhbe7RRfKFliioJmlVWr3SAzGBVFp4JUNdl
 R
X-Gm-Gg: ASbGncv+92x9IHBVCmVJRQhcyQl9bzg+enlFO1eY2T+qaoOhGOSKaipXsjyacCkNd9l
 2ok7CNpFOSUsOBrakFelv2SFuaCM/IJmTsTgPF4yy3+xOl/R+grn2JztLG6Kb1kXnLvzaj5WVxj
 /BtPqLlqBd5FXUN8uMKSqXuiWwLNe6McWs8ErQV6TBp9iOXBNx5M5oMyQ17lrWLVwC50pHOhWT5
 YaDBx0pL0wfVLmOIX/oaLMzUJ9XAVLXDYNDQwVcRXI1pvWjc9Sx5bb4i2KRQd3GQr3aklRFJj0u
 /YUMtWMvsFPsTmZ48v2WWIwbn/hYaRWahsT6td73BKkD+ZM2+pvJ0x2kzZu4zux78Ue22djOZP7
 pJ9aE0luAdhUBBYYlO2Ld03DGIAZOjMoxjIA2NGNvLqRGOQTJxfk=
X-Google-Smtp-Source: AGHT+IFfZeNtyVMoyN0pGrqirCz3stqEOcODyrTpTDI8vXJbsLrz2FObytazwvRDrgHcN2XGrcj3Qg==
X-Received: by 2002:a17:907:7842:b0:ab6:f06b:4a26 with SMTP id
 a640c23a62f3a-abb70bbf513mr1863325866b.34.1739971629637; 
 Wed, 19 Feb 2025 05:27:09 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba6f884f2sm483942566b.155.2025.02.19.05.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:27:09 -0800 (PST)
Message-ID: <db7c7437-32d9-4c41-b3a4-a153af2d68b5@suse.com>
Date: Wed, 19 Feb 2025 14:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20241225114215.2973-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20241225114215.2973-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount08.c: Restrict overmounting of ephemeral
 entities on /proc/<pid>/fd/<nr>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Some comments below. LGTM otherwise

On 12/25/24 12:42, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>

We miss a description here. Maybe something like:

Add a new test to verify that mount will raise ENOENT if we try to mount 
on magic links under /proc/<pid>/fd/<nr>.
Refer to the following kernel commit for more information:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172

> ---
>   runtest/syscalls                           |  1 +
>   testcases/kernel/syscalls/mount/.gitignore |  1 +
>   testcases/kernel/syscalls/mount/mount08.c  | 56 ++++++++++++++++++++++
>   3 files changed, 58 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/mount/mount08.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ded035ee8..d3abc8b85 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -852,6 +852,7 @@ mount04 mount04
>   mount05 mount05
>   mount06 mount06
>   mount07 mount07
> +mount08 mount08
>   
>   mount_setattr01 mount_setattr01
>   
> diff --git a/testcases/kernel/syscalls/mount/.gitignore b/testcases/kernel/syscalls/mount/.gitignore
> index 80885dbf0..3eee5863a 100644
> --- a/testcases/kernel/syscalls/mount/.gitignore
> +++ b/testcases/kernel/syscalls/mount/.gitignore
> @@ -6,3 +6,4 @@
>   /mount05
>   /mount06
>   /mount07
> +/mount08
> diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
> new file mode 100644
> index 000000000..9b54ea835
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount/mount08.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
This is not needed anymore.
> + *
> + * This test check restrict overmounting on /proc/<pid>/fd/<nr>.
> + * It is based on the following kernel commit:
> + * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d80b065bb172

"Verify that mount will raise ENOENT if we try to mount on magic links 
under /proc/<pid>/fd/<nr>."

Link is not needed if we already have .tags in the "struct tst_test". 
See below

> + */
> +
> +#include "tst_test.h"
> +#include <sys/mount.h>
> +#include "tst_safe_file_at.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FOO MNTPOINT "/foo"
> +#define BAR MNTPOINT "/bar"
> +
> +static void run(void)
> +{
> +	char path[PATH_MAX];
> +	int foo_fd, newfd, proc_fd;
> +
> +	foo_fd = SAFE_OPEN(FOO, O_RDONLY | O_NONBLOCK, 0640);
> +	newfd = SAFE_DUP(foo_fd);
> +	SAFE_CLOSE(foo_fd);
> +
> +	sprintf(path, "/proc/%d/fd/%d", getpid(), newfd);
> +
> +	proc_fd = SAFE_OPENAT(AT_FDCWD, path, O_PATH | O_NOFOLLOW);
> +
> +	sprintf(path, "/proc/%d/fd/%d", getpid(), proc_fd);
> +
> +	TST_EXP_FAIL(
> +		mount(BAR, path, "", MS_BIND, 0),
> +		ENOENT,
> +		"mount() on proc failed expectedly"
> +	);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_CREAT(FOO, 0777);
> +	SAFE_CREAT(BAR, 0777);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.min_kver = "6.12",
We miss .tags to the kernel commit in here:
> +};
Kind regards,
Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
