Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047B7C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720599512; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=zMX0FP1ffYr2aI2wBKhadj92Gy1hN2md6rIN+FD9IHg=;
 b=Pd79gNpBZ6jVT1i4BJRzkIH3MgC/xBMTpVtNdZr5qhja4Uf/NZzQd9XszLbM7hT+i/lfr
 /dXr7d2XeMc/+1BYz13HJUbdG1fRWPMY79V7tIlQflk32IyPPOKmMenl3BYUWlC2sGFanFv
 xqh4v+jpPWo+NwZGY5AV5+1SzFGgKwE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51F9F3D3838
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 10:18:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E4263D0B06
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:18:10 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71E0D60154A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:18:09 +0200 (CEST)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eea8ea8bb0so50294411fa.1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1720599489; x=1721204289; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XS+vWl5/YVhXiRyZXunJuMWFBehet0PJMPL9GFl4ynU=;
 b=Ldwc9Vufl+LbpiCurWVm921FkWLB1Lz8wOV/R5RfIfqjemqAQjm9xOiuMTNq2ytUXg
 8psbQZXTamWq49hYSxluyUOg0af/cSKCoNDkeZqbl9ArQlC6N3qNVTz7KizLMf4StCEm
 noN1Z3xnuc/YrQ6DRH9H8e3NgHeHlFBNHXdgwtOYTCeVp34K1hw9HKzhbLnxuUiEog0j
 mIFJeLh0NllJ2DSwS7RHvEz5OE90O0p70yZKnG6x5o7gHihJkXzIZnp3NwczlXJK+Jrx
 2cei9xNQnCJjBZeZO2fvV5Tp2LuI2TWo2ohUxqjj++vVNWuojPxhSUtmvewhFdJc/PzA
 IFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720599489; x=1721204289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XS+vWl5/YVhXiRyZXunJuMWFBehet0PJMPL9GFl4ynU=;
 b=S47MfYtKGCoP8nVG7lasom5oNfDjin1IJeO3BPRy7X+xIV9p7FWPHUj91m3cdC4+tx
 b7aig8oOBNejD+CnoKavBwFTWvn13Q7PLaUK8ZH8SUXPQFK/0dw+QkYaY7BzfXrzzjIU
 rN8ta4CdFsbpYLM1US5/NPOMLjwvZGnUwg2lXINbfthwbxMaVqLlsBqs8qzLhRvk5sA9
 kIO4vnLxjhT0tff5MjI178rmWWgYdxCPRr3/b25Be29Bsdo69lMH4hs5Sk8dlC5LgMTw
 puEMrMVQKHZ+iLClom8Wt4ppV2IYsG+C/tTq0oz19zhQEDMFaR01HKbIPtZJiaogFKNQ
 OPbA==
X-Gm-Message-State: AOJu0YwvhxHGmlJ1l2XpJVKBkvPj01duqe9kY+m020qgU4nj0LSlaVLm
 V8bxk3rTeOwvs012mVnYBvBK9Wzp/ZNUQgQjsNczePnV8CCRu82pElfHdBHoM2k=
X-Google-Smtp-Source: AGHT+IFmS6+crug9DYWvw/0x7JiH+zkk6M5N4lOMrYyoZHe3Lcx8wrnPFuklrf6ZnPlOg/Ix+zmDpw==
X-Received: by 2002:a05:651c:b94:b0:2ee:4f58:7738 with SMTP id
 38308e7fff4ca-2eeb30e43bfmr39304061fa.17.1720599488261; 
 Wed, 10 Jul 2024 01:18:08 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.40.91])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d621c6300sm2502239a12.51.2024.07.10.01.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 01:18:07 -0700 (PDT)
Message-ID: <c27d1b47-bfb2-46f5-93ad-a426b0925009@suse.com>
Date: Wed, 10 Jul 2024 10:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
 <20240709-stat04-v2-1-2693a473a2ab@suse.com> <20240709211302.GA214763@pevik>
Content-Language: en-US
In-Reply-To: <20240709211302.GA214763@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Add stat04 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 7/9/24 23:13, Petr Vorel wrote:
> Hi all,
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>> This test has been extracted from symlink01 test and it checks that
>> stat() executed on file provide the same information of symlink linking
>> to it.
>> Reviewed-by: Li Wang <liwang@redhat.com>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   runtest/smoketest                         |   4 +-
>>   runtest/syscalls                          |   4 +-
>>   testcases/kernel/syscalls/stat/.gitignore |   2 +
>>   testcases/kernel/syscalls/stat/stat04.c   | 120 ++++++++++++++++++++++++++++++
>>   4 files changed, 126 insertions(+), 4 deletions(-)
>> diff --git a/runtest/smoketest b/runtest/smoketest
>> index f6f14fd2b..5608417f9 100644
>> --- a/runtest/smoketest
>> +++ b/runtest/smoketest
>> @@ -8,8 +8,8 @@ time01 time01
>>   wait02 wait02
>>   write01 write01
>>   symlink01 symlink01
>> -stat04 symlink01 -T stat04
>> -utime07 utime07
>> +stat04 stat04
>> +utime01A symlink01 -T utime01
> nit: Why replace utime07 with utime01? I suggest to merge without this change
> (modify only stat04).
This must be an error
> Original test also tested ENOENT and ELOOP, but we have this in stat03.c.
> (you probably have been discussing this previously.)
Yeah there's no need for that since it's tested somewhere else.
>
> @Cyril: will you add your RBT (you reviewed v1).
>
>>   rename01A symlink01 -T rename01
>>   splice02 splice02 -s 20
>>   df01_sh df01.sh
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index b6cadb2df..1e1203503 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1535,8 +1535,8 @@ stat02 stat02
>>   stat02_64 stat02_64
>>   stat03 stat03
>>   stat03_64 stat03_64
>> -stat04 symlink01 -T stat04
>> -stat04_64 symlink01 -T stat04_64
>> +stat04 stat04
>> +stat04_64 stat04_64
> OT: Out of curiosity, I'm looking into
> testcases/kernel/syscalls/utils/newer_64.mk, I have no idea why there is
> utils/newer_64.h part.
no idea...
>>   statfs01 statfs01
>>   statfs01_64 statfs01_64
>> diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
>> index fa0a4ce9f..0a62dc6ee 100644
>> --- a/testcases/kernel/syscalls/stat/.gitignore
>> +++ b/testcases/kernel/syscalls/stat/.gitignore
>> @@ -4,3 +4,5 @@
>>   /stat02_64
>>   /stat03
>>   /stat03_64
>> +/stat04
>> +/stat04_64
>> diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
>> new file mode 100644
>> index 000000000..4609f02d8
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/stat/stat04.c
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
> Also, original test was GPL v2 only, but with rewrite like this I guess we can
> have GPL v2+.
>
>> +/*
>> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> + *    Author: David Fenner, Jon Hendrickson
>> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test checks that stat() executed on file provide the same information
>> + * of symlink linking to it.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include "tst_test.h"
>> +
>> +#define FILENAME "file.txt"
>> +#define MNTPOINT "mntpoint"
>> +#define SYMBNAME MNTPOINT"/file_symlink"
>> +
>> +static char symb_path[PATH_MAX];
>> +static char file_path[PATH_MAX];
>> +static struct stat *file_stat;
>> +static struct stat *symb_stat;
>> +static char *tmpdir;
>> +
>> +static void run(void)
>> +{
>> +	SAFE_STAT(file_path, file_stat);
>> +	SAFE_STAT(symb_path, symb_stat);
>> +
>> +	TST_EXP_EQ_LI(file_stat->st_dev, symb_stat->st_dev);
>> +	TST_EXP_EQ_LI(file_stat->st_mode, symb_stat->st_mode);
>> +	TST_EXP_EQ_LI(file_stat->st_nlink, symb_stat->st_nlink);
>> +	TST_EXP_EQ_LI(file_stat->st_uid, symb_stat->st_uid);
>> +	TST_EXP_EQ_LI(file_stat->st_gid, symb_stat->st_gid);
>> +	TST_EXP_EQ_LI(file_stat->st_size, symb_stat->st_size);
>> +	TST_EXP_EQ_LI(file_stat->st_atime, symb_stat->st_atime);
>> +	TST_EXP_EQ_LI(file_stat->st_mtime, symb_stat->st_mtime);
>> +	TST_EXP_EQ_LI(file_stat->st_ctime, symb_stat->st_ctime);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char opt_bsize[32];
>> +	const char *const fs_opts[] = {opt_bsize, NULL};
>> +	struct stat sb;
>> +	int pagesize;
>> +	int fd;
>> +
>> +	tmpdir = tst_get_tmpdir();
>> +
>> +	if (strlen(tmpdir) >= (PATH_MAX - strlen(FILENAME))) {
>> +		tst_brk(TCONF, "Temporary folder name is too long. "
>> +			"Can't create file");
>> +	}
>> +
>> +	if (strlen(tmpdir) >= (PATH_MAX - strlen(SYMBNAME))) {
>> +		tst_brk(TCONF, "Temporary folder name is too long. "
>> +			"Can't create symbolic link");
>> +	}
> PATH_MAX is 4096, right? Is it really needed to test the length?
Yes, check previous conversation (easily buffer overflow).
>> +
>> +	/* change st_blksize / st_dev */
>> +	SAFE_STAT(".", &sb);
>> +	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
>> +
>> +	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
>> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
> Isn't symlink filesystem related? Shouldn't this be run on all_filesystems?
> But we could not force block size change.
This was suggested by @Cyril
>
>> +
>> +	SAFE_TOUCH(FILENAME, 0777, NULL);
>> +
>> +	/* change st_nlink */
>> +	SAFE_LINK(FILENAME, "linked_file");
>> +
>> +	/* change st_uid and st_gid */
>> +	SAFE_CHOWN(FILENAME, 1000, 1000);
>> +
>> +	/* change st_size */
>> +	fd = SAFE_OPEN(FILENAME, O_WRONLY, 0777);
>> +	tst_fill_fd(fd, 'a', TST_KB, 500);
>> +	SAFE_CLOSE(fd);
>> +
>> +	/* change st_atime / st_mtime / st_ctime */
>> +	usleep(1001000);
>> +
>> +	memset(file_path, 0, PATH_MAX);
>> +	snprintf(file_path, PATH_MAX, "%s/%s", tmpdir, FILENAME);
>> +
>> +	memset(symb_path, 0, PATH_MAX);
>> +	snprintf(symb_path, PATH_MAX, "%s/%s", tmpdir, SYMBNAME);
>> +
>> +	SAFE_SYMLINK(file_path, symb_path);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	free(tmpdir);
> nit: I know that tst_get_tmpdir() is first thing in setup(), but I would still
> guard it with if (tmpdir) (code may change later).
>
>> +
>> +	SAFE_UNLINK(SYMBNAME);
> nit: Ideally this would be guarded by flag that SAFE_SYMLINK(file_path,
> symb_path) got executed.
What if it doesn't?
>
>> +
>> +	if (tst_is_mounted(MNTPOINT))
>> +		SAFE_UMOUNT(MNTPOINT);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.needs_root = 1,
>> +	.needs_tmpdir = 1,
> nit: useless tag: needs_tmpdir (can be removed before merge).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
>> +	.needs_device = 1,
>> +	.mntpoint = MNTPOINT,
>> +	.bufs = (struct tst_buffers []) {
>> +		{&file_stat, .size = sizeof(struct stat)},
>> +		{&symb_stat, .size = sizeof(struct stat)},
>> +		{}
>> +	}
>> +};

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
