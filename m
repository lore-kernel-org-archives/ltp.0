Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCE4C48BEB
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708530455; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=N37UAppTHq/vXWiTyVPdp3NlN4yjb+UfYbvZO/x6Cs8=;
 b=qnfSeGNTnf6fx+GhBcQVa6McVzaO0SU3wXyRsP4yRimlxOru5IFQFvQlJUbZhQsrIGaVw
 UrClYpmofa61YiRkIACl34uGucYMF2iGuky6bJDS/eiDxZ2ecTRi/6WKk8RQAybqgmqLWAr
 Z0YrJWJ0w5nzOC/81nqYRhmRvwy4Bsc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D3883D0883
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 16:47:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 163703D0353
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:47:13 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C89BB60B05E
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 16:47:12 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3f3d0d2787so114023066b.3
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708530431; x=1709135231; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=myFLBQaugo1POv6o9n6uKoNiFUBHgZST0DNIs8viR74=;
 b=NcX72spDMwVeYwczwK5tK7rwa12XzVLghBGuU8EhhVNE4TnPx2/5KNgVQW64d0WsLg
 qqNjwgEwJZdcv/3phgbRE+2i+LJk4GIos8pdui8GVBjbViBS1TJ27dC5O1DDfWfuJ0Um
 hy6P+5NqPY+yjN/X4bMKKY/gWEyDA3dF8lfp53TXs+N5aUCf0EadzkqlljRIkYKQoe3H
 czVIXCyTFPAOld8Y7t/7i52HMhA+/7e26y53zOysP5+fkQTztlQdwMVKdepCDbsAh6PH
 cBOEUK09CdCiIoM9EbfPIhSrxAMmyXCyWI4wsbCRkgzEMqwVj76u2Hx45duE0H1Zo7Gb
 TSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708530431; x=1709135231;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=myFLBQaugo1POv6o9n6uKoNiFUBHgZST0DNIs8viR74=;
 b=EdjD6Je39Z5fVsxumpk0GLjCJt0Dd+vf1Mbp5XoqAJ+17xRz2xFcloxVZB/OafwD/0
 YgvHs2dsfsRfobl+8FhLQyV8hZhxVY1VkkuZJXD4CtgPccHp/FBfL+A+pIQmfCy3CbLT
 b11K23OWbCtMubVxiFDqIMAzmCAjL7gCnZi4mU6WT8xNbteX0/up/ani3V87AQk29glM
 lUsf/SJ/9JfhrAl+hofj8fD7AWaEjpQzpH+CoEqWYnam5data7Qc+IeiPW7bZdNeXROU
 DG+J/uKhfTkcg8MM8YH7nfSnCUMETvN7hmWoUuCzV5Esu+tzwsboCvIQnqYBdRiwj856
 H6WQ==
X-Gm-Message-State: AOJu0YwCha8vjVuDwaX7C829Q+MKNmao7Xi+M8JHA2u4nOiP54iIpVrR
 fINOkMZNA/eRyZ7qDu6RTpGwQwPF1kgXjk9nto+jkC4wHBPeb773x6CpJx7dBAfx23lE1z8q/1F
 5OlI=
X-Google-Smtp-Source: AGHT+IHmupMqzs084Pb5VRVKG1Kg0Mkq+vSg9TQoKe75eOvJnO9VXa+vJqZR2HBJMLpylFrUhxkmLw==
X-Received: by 2002:a17:906:b191:b0:a3e:9b8b:bb16 with SMTP id
 w17-20020a170906b19100b00a3e9b8bbb16mr5691361ejy.42.1708530431322; 
 Wed, 21 Feb 2024 07:47:11 -0800 (PST)
Received: from [10.232.133.81] ([88.128.88.5])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1709062dc200b00a3cf8cb80c1sm5070920eji.156.2024.02.21.07.47.10
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:47:11 -0800 (PST)
Message-ID: <e9cc0cb2-7c47-4be9-9e4e-909a73399679@suse.com>
Date: Wed, 21 Feb 2024 16:47:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231222094455.3878-1-xuyang2018.jy@fujitsu.com>
 <20231222094455.3878-3-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231222094455.3878-3-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fchownat03: Add error tests for fchownat()
 system call
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

This could be merged with fchownat01, by extending the tcase structure 
and checking when exp_errno flag is defined or not.

Regards,
Andrea

On 12/22/23 10:44, Yang Xu wrote:
> A series of tests were added to test the negative results of fchownat()
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                              |   1 +
>   testcases/kernel/syscalls/fchownat/.gitignore |   1 +
>   .../kernel/syscalls/fchownat/fchownat03.c     | 101 ++++++++++++++++++
>   3 files changed, 103 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/fchownat/fchownat03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b7ceb25d3..589c2c9a3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -275,6 +275,7 @@ fchown05_16 fchown05_16
>   #fchownat test case
>   fchownat01 fchownat01
>   fchownat02 fchownat02
> +fchownat03 fchownat03
>   
>   fcntl01 fcntl01
>   fcntl01_64 fcntl01_64
> diff --git a/testcases/kernel/syscalls/fchownat/.gitignore b/testcases/kernel/syscalls/fchownat/.gitignore
> index 35c00345b..60fac7e69 100644
> --- a/testcases/kernel/syscalls/fchownat/.gitignore
> +++ b/testcases/kernel/syscalls/fchownat/.gitignore
> @@ -1,2 +1,3 @@
>   /fchownat01
>   /fchownat02
> +/fchownat03
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat03.c b/testcases/kernel/syscalls/fchownat/fchownat03.c
> new file mode 100644
> index 000000000..85591dd93
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Linux Test Project, 2006-2023
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * - fchownat() fails with ENOTDIR  if dir_fd is file descriptor to the file
> + *   and pathname is relative path of the file.
> + * - fchownat() fails with EBADF if dir_fd is invalid.
> + * - fchownat() fails with EINVAL if flag is invalid.
> + * - fchownat() fails with ENAMETOOLONG if pathname is too long.
> + * - fchownat() fails with ELOOP if too many symbolic links were
> + *   encountered while resolving path.
> + * - fchownat() fails with ENOENT if the file does not exist.
> + * - fchownat() fails with EFAULT if pathname points outside accessible
> + *   address space.
> + */
> +
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define TESTFILE  "testfile"
> +#define TESTELOOP "test_eloop1"
> +#define PATH_LEN (PATH_MAX + 2)
> +
> +static int dir_fd, fd;
> +static int invalid_fd = -1;
> +static char *testfile;
> +static char path[PATH_LEN];
> +static char *long_path = path;
> +static char *testeloop;
> +static char *emptypath;
> +static char *bad_path;
> +
> +static struct tcase {
> +	int *fds;
> +	char **filenames;
> +	int flag;
> +	int exp_errno;
> +	char *desc;
> +} tcases[] = {
> +	{&fd, &testfile, 0, ENOTDIR, "path prefix is not a directory"},
> +	{&invalid_fd, &testfile, 0, EBADF, "invalid fd"},
> +	{&dir_fd, &testfile, -1, EINVAL, "invalid flag"},
> +	{&dir_fd, &long_path, 0, ENAMETOOLONG, "pathname is too long"},
> +	{&dir_fd, &testeloop, 0, ELOOP, "too many symbolic links"},
> +	{&dir_fd, &emptypath, 0, ENOENT, "the file does not exist"},
> +	{&dir_fd, &bad_path, 0, EFAULT, "inaccessible address space"},
> +};
> +
> +static void setup(void)
> +{
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
> +
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
> +
> +	fd = SAFE_OPEN("testfile2", O_CREAT | O_RDWR, 0600);
> +
> +	memset(path, 'a', PATH_LEN);
> +
> +	SAFE_SYMLINK("test_eloop1", "test_eloop2");
> +	SAFE_SYMLINK("test_eloop2", "test_eloop1");
> +
> +	bad_path = tst_get_bad_addr(NULL);
> +}
> +
> +static void fchownat_verify(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	TST_EXP_FAIL(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
> +		     tc->flag), tc->exp_errno, "fchownat() fails with %s",
> +		     tc->desc);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > -1)
> +		SAFE_CLOSE(fd);
> +
> +	if (dir_fd > -1)
> +		SAFE_CLOSE(dir_fd);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = fchownat_verify,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&testfile, .str = TESTFILE},
> +		{&testeloop, .str = TESTELOOP},
> +		{&emptypath, .str = ""},
> +		{},
> +	},
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
