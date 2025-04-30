Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7A8C369DC
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746001707; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=EYF1+QEWwPaDOIQ9ZJFDQTVkkOydo2Jg1XlkrY44sFw=;
 b=BXTSfNKuAfs4B6R2Ml01+OcgbaiO7sjRkSMmdNPDVR5CyAXJdja3QSX154yB8TgjWSfrr
 HgcnvnuIvLD/WDaQCfVc0xljb+OchqMU/IIc04071EKtiF4pvQeluef8EJUu7lADntnTaMq
 a7Rfs1ZHOFrUxxKD7uCd0KXsteUTdk4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69A013CBC67
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 10:28:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ABA43CB38A
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 10:28:05 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D32768043F
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 10:28:04 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso53239615e9.0
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746001684; x=1746606484; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Os17QQTKiICGuKIGYv6ZGKol+sRSm4fnExdA8YTXNwM=;
 b=CEGu1TrNw1fF4H99ZsM46y1nzKSjXaYF1ThLOzAIuz5OcLPGNyHSlZOTqlbQsAGLYP
 FYQHxE4gMHYgkLBAxY7+3JxOg+M/oCy9La/8MLggQN1MlULaeFo2Kc8aMAgZm6sc9bz3
 uNx/avO7YmCYK9ssDT7HrrFLTfTirOdZFlRfdmXRaudKPMPksGuEvdHCiymfDbRsp6Wj
 r8u1M1qYLcL6IFF1ifqLqFHFej8GtaJTeeHcuAu+cQ5SW943k6ujEm+NZt41qgdicdUj
 0fBqoN6oxh6ttqmEfhqFl8HI5zRReXyNEnuD//JAHWBZ4Gnqz6H2zwRBqqmpaaC+YAfB
 ecIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746001684; x=1746606484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Os17QQTKiICGuKIGYv6ZGKol+sRSm4fnExdA8YTXNwM=;
 b=ORGWLE2K63oy5qhLZGC8FAiaQuVvSi+wYD+3Cyg8IqYmXKQg14psiGkkP6yUhei17K
 ua1WzaRmBJ7o0wCLljm0v8wy1veFjvlRefl+wZ40NRzqmfl8W81koB4P9mKZNHa22j/t
 a912Sx3/6hFjrkwzijVhv3J9X/vLU0SRhL4K/fm9hEK+CRaVn4TMDpWSpehAwQX+Hyee
 YsLkU5q4NZykL4rxrz3Ya3pfIO9aC8GRR60c8ebRENOJPNcbS0oLOw0G/tSq+EjzJdQA
 ZXYc62XNAw5q39u84+Fuj3OFrBCcKkDhGskCvO+a78u5c8Tv5WaoDilf1Abn+9oFHVL6
 nmyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpw05f2NhcZiYuZKcgQ6oWf1aPDb1fO5Wc7Lypcd0CIen7vMdqy7TIyCuVFfj8HAjNguc=@lists.linux.it
X-Gm-Message-State: AOJu0YyF4TrUTe56I9V0Zz+jk1TJnWhXa3SjwfRlbzHptEhpXshJonKP
 72yvX3cUrq1XeceO+6+GwltbwKZ8pgizxVKmJwK7ST47kYbOfNG9PEFrW0EbOT6v2c+icHOAjNM
 6
X-Gm-Gg: ASbGnct3JChVR5zhF/xzd0Kk1RWVsgvG3ucKlhZmtKDFQuP2iWe08ZwOazK8VoECYGU
 N+MkfYnkmv6Wr3Bn/w6K1/ZB8WSS0BSzH3ADMgUxRxGm9k9whE2mAAQzJfAqCdrsdKbJ7pHoFnX
 EMENIwxo/tFSEDv6djo9cVjAvrkW1TeqX/MEsPwi5wFCput/QFYHNm0TkfZp25WxIg268vCWoue
 lpw4vt38iLMjzVvsEwTRd1fSn8zCVV4KslbAHOMID3wGLMRgPlCB9N8SAT0MSifSt95cTy+1bx2
 bnA26iSN2CCyFoCeyJIzZfb+uas+KVvL4Bm/90vKNqyXTTzOn4mEuFqTWpvyBdPMx6k4fOhP3KT
 MZEmDfknhFL5DpzvqB+FHhtBZQQiCB1CPExoORTZV0jhnvjKtRDwe2CzgvapwXSiKQQrfc8KOhj
 fXndE=
X-Google-Smtp-Source: AGHT+IGIE/x1jTrFff460zMcD5oEtqmVFcWeA69aukFof8LM+QRfpQVHNgkGn1aQy/Vk82L8vXfEYA==
X-Received: by 2002:a05:600c:1d8d:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-441b268b9f9mr12820595e9.23.1746001683735; 
 Wed, 30 Apr 2025 01:28:03 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad784asm16315585e9.7.2025.04.30.01.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 01:28:03 -0700 (PDT)
Message-ID: <ebf36f89-da22-4c1c-a9df-116bafc39b57@suse.com>
Date: Wed, 30 Apr 2025 10:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250430192207.1089900-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250430192207.1089900-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig04.c: Use FSCONFIG_SET_FD set overlayfs
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

We miss a description for the commit.

On 4/30/25 21:22, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   runtest/syscalls                              |   1 +
>   testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
>   .../kernel/syscalls/fsconfig/fsconfig04.c     | 132 ++++++++++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e369536ea..658ab24c4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -410,6 +410,7 @@ fremovexattr02 fremovexattr02
>   fsconfig01 fsconfig01
>   fsconfig02 fsconfig02
>   fsconfig03 fsconfig03
> +fsconfig04 fsconfig04
>   
>   fsmount01 fsmount01
>   fsmount02 fsmount02
> diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
> index cfedae5f7..bd3754c34 100644
> --- a/testcases/kernel/syscalls/fsconfig/.gitignore
> +++ b/testcases/kernel/syscalls/fsconfig/.gitignore
> @@ -1,3 +1,4 @@
>   /fsconfig01
>   /fsconfig02
>   /fsconfig03
> +/fsconfig04
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> new file mode 100644
> index 000000000..c77dc9e3a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + *
> + * Basic fsconfig() test include use FSCONFIG_SET_FD set overlayfs
The description doesn't explain what test is doing. Also, we are not 
testing only overlayfs inside it due to .all_filesystems=1, so I'm a bit 
confused.
> + * Refer to selftests/filesystems/overlayfs/set_layers_via_fds.c
I checked the selftests but I don't see a 1:1 with our test. Is this a 
port? If it's not we probably don't need this comment.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "tst_safe_file_at.h"
> +#include "tst_safe_stdio.h"
> +
> +#define MNTPOINT	"mntpoint"
> +#define OVERLAYMNT	"set_layers_via_fds"
> +
> +static int fd, fd_context, fd_overlay;
They are not initialized to -1, so we are going to fail SAFE_CLOSE 
inside cleanup function.
Also it's better to define variables on multiple lines.
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	if (fd_context != -1)
> +		SAFE_CLOSE(fd_context);
> +
> +	if (fd_overlay != -1)
> +		SAFE_CLOSE(fd_overlay);
> +}
> +
> +static void run(void)
> +{
> +	int fsmfd;
> +
> +	fd = TST_EXP_FD(fsopen(tst_device->fs_type, 0));
> +
> +	TST_EXP_PASS(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
This should be tested separately.
> +
> +	TST_EXP_PASS(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
Also this.
> +
> +	fsmfd = TST_EXP_FD(fsmount(fd, 0, 0));
> +
> +	TST_EXP_PASS(mkdirat(fsmfd, "w", 0755));
> +	TST_EXP_PASS(mkdirat(fsmfd, "u", 0755));
> +	TST_EXP_PASS(mkdirat(fsmfd, "l1", 0755));
> +	TST_EXP_PASS(mkdirat(fsmfd, "l2", 0755));
> +
> +	int layer_fds[] = { [0 ... 3] = -EBADF };
> +
> +	layer_fds[0] = SAFE_OPENAT(fsmfd, "w", O_DIRECTORY);
> +	layer_fds[1] = SAFE_OPENAT(fsmfd, "u", O_DIRECTORY);
> +	layer_fds[2] = SAFE_OPENAT(fsmfd, "l1", O_DIRECTORY);
> +	layer_fds[3] = SAFE_OPENAT(fsmfd, "l2", O_DIRECTORY);
> +
> +	TST_EXP_PASS(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> +			MOVE_MOUNT_F_EMPTY_PATH));
> +
> +	SAFE_CLOSE(fsmfd);
This is one test case.
> +
> +	fd_context = TST_EXP_FD(fsopen("overlay", 0));
> +
> +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "workdir", NULL, layer_fds[0]));
> +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "upperdir", NULL, layer_fds[1]));
> +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[2]));
> +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_SET_FD, "lowerdir+", NULL, layer_fds[3]));
> +
> +	TST_EXP_PASS(fsconfig(fd_context, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +
> +	SAFE_MKDIR(OVERLAYMNT, 0555);
> +
> +	fd_overlay = TST_EXP_FD(fsmount(fd_context, 0, 0));
> +	SAFE_CLOSE(fd_context);
> +
> +	TST_EXP_PASS(move_mount(fd_overlay, "", AT_FDCWD, OVERLAYMNT,
> +			MOVE_MOUNT_F_EMPTY_PATH));
> +
> +	char line[PATH_MAX];
> +	FILE *file;
> +	int ret = 0;
> +	char workdir[PATH_MAX], upperdir[PATH_MAX], lowerdir1[PATH_MAX], lowerdir2[PATH_MAX];
> +	char *tmpdir_path = tst_tmpdir_path();
> +
> +	sprintf(workdir, "workdir=%s/%s/w", tmpdir_path, MNTPOINT);
> +	sprintf(upperdir, "upperdir=%s/%s/u", tmpdir_path, MNTPOINT);
> +	sprintf(lowerdir1, "lowerdir+=%s/%s/l1", tmpdir_path, MNTPOINT);
> +	sprintf(lowerdir2, "lowerdir+=%s/%s/l2", tmpdir_path, MNTPOINT);
> +
> +	file = SAFE_FOPEN("/proc/mounts", "r");
> +	while (fgets(line, sizeof(line), file)) {
> +		if (strstr(line, workdir) && strstr(line, upperdir)
> +				&& strstr(line, lowerdir1) && strstr(line, lowerdir2)) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +
> +	if (ret == 1)
> +		tst_res(TPASS, "overlay mount check pass");
> +	else
> +		tst_res(TFAIL, "overlay mount check failed");
> +
> +	TST_EXP_PASS_SILENT(system("ls -l"));
> +
This is not needed.
> +	char rmcmd[PATH_MAX];
> +
> +	sprintf(rmcmd, "rm -r ./%s/*", MNTPOINT);
> +	TST_EXP_PASS_SILENT(system(rmcmd));
Why we try to remove the whole mnpoint via rm command?
> +
> +	SAFE_CLOSE(fd_overlay);
> +	SAFE_UMOUNT(OVERLAYMNT);
> +	SAFE_RMDIR(OVERLAYMNT);
> +
> +	SAFE_CLOSE(fd);
> +
> +	for (int i = 0; i < 4; i++)
> +		SAFE_CLOSE(layer_fds[i]);
> +
> +	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
> +		SAFE_UMOUNT(MNTPOINT);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = fsopen_supported_by_kernel,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat", NULL},
> +};
In general I think we are not achieving the goal given by 
https://github.com/linux-test-project/ltp/issues/1169 so this patch 
can't be considered valid. There are many issues due to the mix of 
different flags usage and the broken execution of the test as well.

The idea is to test the following flags, each one separately in order to 
verify if they are correctly working:

- FSCONFIG_SET_PATH
- FSCONFIG_SET_BINARY
- FSCONFIG_SET_FD

All of them should be tested with a separate test in an atomic way: we 
open a new filesystem context object using fsopen(), then we set its 
key/keys via fsconfig() using one of the flags above and we verify that 
they affected the filesystem context.

There are also many other flags. I suggest you to take a look at 
include/uapi/linux/mount.h in case we need to cover more of them.

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
