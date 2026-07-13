Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42E1C44508
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783944539; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=bHzMgIbwdfAu8JdXu9cQm/lTku4aIBD5ZJdA1EBgdno=;
 b=VlTK/vKisE8vM7eL4FjNfwnXHCX1Hf1J/kGyMH3U8ijBzLYLfpJHzEuCbOdocl+v/e8o0
 JuqHvsmZh90RbWq1pU9cxTsm0kUF7oLshqzhE0BhyKdbe2hCEpahyFTSm++Ymq2OwAnaUM0
 O8Tq/KhqGc49pTkts5BJGkOOk7nJoEc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C7D23E9692
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:08:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 972623C5EE9
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:08:37 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 05D9D2005E0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:08:36 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so975542f8f.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783944516; x=1784549316; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hzfNnX6D5N8mMRgYnBVxMFTsHwR/Ro5ynluuDEKI+Ts=;
 b=ERQI1xYODD5MzRqxjnCJiDFrBRpCrm4oOem/rN4Gu+gXmSXG9OuVNGISR2n3J80Nap
 iW5hq5GF9O4tpwdjT/ZDR/yiBEyVnX+saKivYHTATZybLtmy4jw7r6DSKBBewKL9FvHo
 EyrrqE7wEQ40xGpinOM0n5do3Qj3pb4x1gPe/kpLFqOs2xVLNTccD7vhyrgVKV+cCKe+
 dgsjsb32QjnptM7sUFIoLVBwi7iWH8VhGXzUxJHu4O2X0QkZG0SAHMe1nA1S248jhSx0
 jbRpj7OakMJ9J+cZz8upw/LMXgyuzqQWxneUmUn4O9jYhVCl1F5PER454rLpYIJMaQhd
 Az0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944516; x=1784549316;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzfNnX6D5N8mMRgYnBVxMFTsHwR/Ro5ynluuDEKI+Ts=;
 b=mUrcVS46/TPnoC40UdkP4zIJF6VbnJq3UA3HYNSSZoKPSg8dy3KlrT14k6Q79feKvi
 qYECu/VXPRAFD/mnqGEXPRn2DfLM+izzr8EpT7WqH1r0jZsmg/k4kkPxxELL3bJr6hyz
 fPEnTX6HMkyZbY0Q+LJOkdCQOKbWvIPjUPEtVXxZPRZsbKZGBQBxti0EhYPDLOai6XBf
 gi+lG/+4mzdmDS5GpuonGzAqmctdXJZojAKUuVFGSFhL1bCFfEP8p+CvhWVrJt+istBb
 6gG2cRe5NbZRGRq7MHYl9aDZodNwWqSMW/oXnRDMTfb/fV1Sopcj+jQTvAegDGXnpj0s
 wTvA==
X-Gm-Message-State: AOJu0YwxhsaPX/rIExG8kaCwcLm4kghcxa9ST9k9AL7XgCo7mAqy9biL
 /vWfQuefKCh6mHpR7XYdGCLLohfdew/LLmimzl6Is2+nr0tbUDkq1h1Dh9PyckKucVI=
X-Gm-Gg: AfdE7cn6VSvhcs6rC4CWmoaP9H9d+k5QmBFNBg+kVnwLE6HfUADNJ2kzwKmv01zxsd/
 9Nb10XJ828jP4ujYnfGlB0GPZsImQkiXjT7AkC/I4ufRmDba8quTwyIxDu28f13alpns7UlNE1y
 U6IAraCup4uS9BSR5w2i/vOYWlecPqHIfJOa8fHNXY62Od/IrTs4dmTqCgmmLmCm0VUWwevvq6L
 UI/p60i+ETU9f1S3usIF1LFSvV5QupYUeM9kxHjjaa5fcG6YUGPpB7CCbMS1bgiBS9ermOGXpcA
 iHygihSGZonDIV9IHLAUvcjy5TqsNRuKLMFCjK8e1QuoLQ65nbMTYs5tGig5n2t7Q9JVBo74P1l
 7RNQdC7N2JrBT5xnAwtGfA3ZzGszbCFOL9oSDBrO9JYpVcH+G1uNWJbUXcyo23xMRHPAggZzTsI
 aXdKVDZsIMBr1LGleje66GCBUXXN2OeAGA
X-Received: by 2002:a05:6000:26c2:b0:47e:4379:a4f1 with SMTP id
 ffacd0b85a97d-47f2dcb5be3mr10241962f8f.6.1783944516304; 
 Mon, 13 Jul 2026 05:08:36 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm79654339f8f.19.2026.07.13.05.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:08:35 -0700 (PDT)
Message-ID: <6a54d543.d87903e8.1f05cf.ba80@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260626061436.15253-1-wegao@suse.com>
Date: Mon, 13 Jul 2026 12:08:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9] fsconfig04: Check FSCONFIG_SET_PATH
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

Hi Wei,

> The fsconfig01.c does not test if FSCONFIG_SET_PATH has any effect;
> most of the calls there just set a dummy "sync" parameter. This test
> case aims to verify if the FSCONFIG_SET_PATH operation can be used
> to dynamically change the external journal device of an ext3 or ext4
> filesystem.
> 
> Closes: https://github.com/linux-test-project/ltp/issues/1169
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
> v8->v9:
> - Drop braces for single-statement inner branches
> 
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
>  .../kernel/syscalls/fsconfig/fsconfig04.c     | 180 ++++++++++++++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a021c79da..a7a9cf638 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -422,6 +422,7 @@ fremovexattr02 fremovexattr02
>  fsconfig01 fsconfig01
>  fsconfig02 fsconfig02
>  fsconfig03 fsconfig03
> +fsconfig04 fsconfig04
>  
>  fsmount01 fsmount01
>  fsmount02 fsmount02
> diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
> index cfedae5f7..bd3754c34 100644
> --- a/testcases/kernel/syscalls/fsconfig/.gitignore
> +++ b/testcases/kernel/syscalls/fsconfig/.gitignore
> @@ -1,3 +1,4 @@
>  /fsconfig01
>  /fsconfig02
>  /fsconfig03
> +/fsconfig04
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> new file mode 100644
> index 000000000..ce6c8fd01
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * This test aims to validate :manpage:`fsconfig(2)` with the
> + * FSCONFIG_SET_PATH operation in dynamically altering the external
> + * journal device of an ext3 or ext4 filesystem. Case acquires three
> + * loop devices (dev0, dev1, dev2), it formats dev1 and dev2 as
> + * external journal devices using the -O journal_dev option and assigns
> + * them the same UUID. Then formats dev0 (the main filesystem) multiple
> + * times, first associating it with dev1, then change to dev2, finally
> + * back to dev1 again as an external journal using the -J device= option.

This is not a description but the Description + Algorithm section. Please
split them so we understand what the test aims for + algorithm that is used.

> + *
> + * 2 Implementation notes in this case need mention:
> + *
> + * - To avoid "journal UUID does not match" error when switch external journal device
> + *   we have to assign same UUID to dev1/dev2
> + * - Before fsconfig test we have to format dev0 associating to dev1->dev2->dev1,
> + *   this will make sure both dev1/2's super block contain correct content. Otherwise
> + *   you will encounter error such as "EXT4-fs (loop0): External journal has more than
> + *   one user (unsupported) - 0" when switch external journal device using fsconfig.
> + */
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "lapi/fsmount.h"
> +
> +#define MNTPOINT	"mntpoint"
> +#define LOOP_DEV_SIZE 10
> +#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
> +
> +static int fd = -1;
> +static char dev0[PATH_MAX];
> +static char dev1[PATH_MAX];
> +static char dev2[PATH_MAX];
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	if (dev1[0])
> +		tst_detach_device(dev1);
> +
> +	if (dev2[0])
> +		tst_detach_device(dev2);
> +}
> +
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +
> +	strcpy(dev0, tst_device->dev);
> +
> +	if (tst_prealloc_file("dev1_file", 1024 * 1024, LOOP_DEV_SIZE))
> +		tst_brk(TBROK, "Failed to create dev1_file");
> +
> +	if (tst_find_free_loopdev(dev1, sizeof(dev1)) == -1)
> +		tst_brk(TBROK, "No free loop device found for dev1");
> +
> +	if (tst_attach_device(dev1, "dev1_file"))
> +		tst_brk(TBROK, "Failed to attach dev1_file to %s", dev1);
> +
> +	if (tst_prealloc_file("dev2_file", 1024 * 1024, LOOP_DEV_SIZE))
> +		tst_brk(TBROK, "Failed to create dev2_file");
> +
> +	if (tst_find_free_loopdev(dev2, sizeof(dev2)) == -1)
> +		tst_brk(TBROK, "No free loop device found for dev2");
> +
> +	if (tst_attach_device(dev2, "dev2_file"))
> +		tst_brk(TBROK, "Failed to attach dev2_file to %s", dev2);

This code is duplicated. We should create a helper that prealloc
and attach the device.

> +
> +	const char *const *mkfs_opts_set_UUID;
> +	const char *const *mkfs_opts_set_journal_dev1;
> +	const char *const *mkfs_opts_set_journal_dev2;
> +
> +	mkfs_opts_set_UUID = (const char *const []) {"-F", "-U", UUID,
> +		"-O", "journal_dev", NULL};
> +
> +	char device_option_dev1[PATH_MAX];
> +	char device_option_dev2[PATH_MAX];
> +
> +	snprintf(device_option_dev1, sizeof(device_option_dev1), "device=%s", dev1);
> +	snprintf(device_option_dev2, sizeof(device_option_dev2), "device=%s", dev2);
> +
> +	mkfs_opts_set_journal_dev1 = (const char *const []) {"-F", "-J",
> +		device_option_dev1, NULL};
> +
> +	mkfs_opts_set_journal_dev2 = (const char *const []) {"-F", "-J",
> +		device_option_dev2, NULL};
> +
> +	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev2, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> +}
> +
> +static void run(void)
> +{
> +	TEST(fd = fsopen(tst_device->fs_type, 0));
> +	if (fd == -1)
> +		tst_brk(TBROK | TTERRNO, "fsopen() failed");
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", dev0, 0));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP)
> +			tst_res(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
> +		else
> +			tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	char loop_name[NAME_MAX];
> +	char path[PATH_MAX];
> +	char device_str[NAME_MAX];
> +	unsigned int major, minor, device_num;
> +	unsigned int found = 0;
> +
> +	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
> +
> +	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
> +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
> +	device_num = (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
> +	snprintf(device_str, sizeof(device_str), "0x%04x", device_num);
> +
> +	char line[PATH_MAX];
> +	FILE *tune2fs;
> +
> +	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", dev0);
> +	tune2fs = SAFE_POPEN(path, "r");
> +
> +	while (fgets(line, PATH_MAX, tune2fs)) {
> +		if (*line && strstr(line, "Journal device:") && strstr(line, device_str)) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (found == 1)
> +		tst_res(TPASS, "Device found in journal");
> +	else
> +		tst_res(TFAIL, "Device not found in journal");
> +
> +	pclose(tune2fs);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.format_device = 1,

we already format the device manually.

> +	.mntpoint = MNTPOINT,
> +	.needs_cmds = (struct tst_cmd []) {
> +		{.cmd = "tune2fs"},
> +		{}
> +	},
> +	.filesystems = (struct tst_fs []) {
> +		{.type = "ext3"},
> +		{.type = "ext4"},
> +		{}
> +	},
> +};
> -- 
> 2.54.0
> 

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
