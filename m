Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D394C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748940974; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=iKYj5KkheV4W0NpskEv0s0J/XnZxxc0sfbrGcmePxyQ=;
 b=SUewOzpteIxxQ1xol6lMx3tgoiGiC8D9AweKmrLIRAVGS/jI+rVdAAeVexLQFPfytiBUP
 OIL9JQwxRFskZpiyWxVKTMvdjwqPmtBg9uUORU/KM/j2PYlRQQrw1ySRfewjMGjW2tGRqYm
 aPoeAjRDjGffyZIFN06orVc62Uvfz0A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C8683C9F72
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 10:56:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C94713C7C3C
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 10:55:52 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 086B2200BA4
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 10:55:50 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so58242805e9.1
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748940949; x=1749545749; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mrvyxqhMWEGtd3spmefO8Aa9N1Jzshkyi2zgEJQrb48=;
 b=NQwrsg4b0ALLqkA9kfarJdUmOoIUhRKqaN5LyBSEYqWPEFLoC7dtt/AyfIFLwQrVlG
 KOheSqArHJAiTs9dyOv/3d6FHHp9io12oISEM5AWljgAWorMqzpCfvHf3SOF7osDLajv
 xNRsumRK+1gBdsHRVUf/p8BksLzp4YXdPNs85pUrD8Sqro/R4s3ZDiWWDhyh2TSB5CjC
 A0788YH32SqIJpyagADVF3BbnSGkmAS6IckZBvaz0YJ5UDeNz0TN7p3Cvj5AQdE2HIWD
 bjehA2On3sc6semmuq7LSEJKS+3WwDL7VbmNtnUPr9ivm2tyL8EctHD1DJnTYlt5DbA1
 T5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748940949; x=1749545749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrvyxqhMWEGtd3spmefO8Aa9N1Jzshkyi2zgEJQrb48=;
 b=YeCrYdERBDrKXgaZ3ES8UsxY6CortjFotHZQflgEpRA+8rfmhRqCVz/bfMCNYR+Ntw
 4DH6f4Dbi53AGeRLYanTO1sPuLe9tFE2LhwhiVXWdcUpXUQCB7bO0tg2OspNsRbg79tg
 y7rtDFyZHJSmfsbCioKZ6zlbJhALW4m5UkoMg6vORrOSh2LS4Ax6+2fcMYwtQPKIVl4l
 i1qS4LvEnhO1AmcpdIsKiNO1IwFlCoxIloMV0d9JkbPq8RJGmO/ozY6mH03qwBsXchER
 SXFwoCa9k8jo74KVrs/eFXkA6stSaqZuPpgdcRoP006pKythZxuz9cdXwag4roqQEt42
 wieA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjIrnwy1a+bjMrBNBmIx4WLizyKflIWyoXPwuLMRvvDhi9MEHwlnFcZx+lnuDFT/f+CPk=@lists.linux.it
X-Gm-Message-State: AOJu0Yzd1lILcsTHjESpojNkYvjywfz5OLFlUMbyVq+Q9nXcEvrII2YQ
 7zLB7AEz2doQBvTgi2n3i9q5vdbKYZ4MkxuvwYR/3x/PAGwcD32aJAOHFKlTchIqObQ=
X-Gm-Gg: ASbGncsuJOHO/D4idxfMZ8wnMTCNM1aKj4VnvrEnchrtX/KpFQ2gOh/aCFcG6upqYPk
 qLCw140Lr2HhSIfZWcSgpuCvUzzSz1Q6uOub8CTlZovpO9OhNyjvD38B/5p+wUR3DC4DBJv/nWg
 aFVa19Mrmw9uqjVl4AONBSEVAF5H/FRfqDooeItA8/HdfC9q2wf64lc9Z8Y0rAWRgGccMSb7Yq/
 uM3N5owyu5Y+OAxVzN57zW/qdAfHf9i2FiTufsZNJxPhi3+RtCDnYVQ0wxWdGu3P8BbjEycnEDZ
 vxtsGKG17KHpMw4zwUhZsr4FgsXltSo4uOud+07r8xLGyp73tgE1d2I6/b7xkDe5AWceERsr
X-Google-Smtp-Source: AGHT+IHWBYKHClGyeUMgefphEruBAquMvuHd+57rT46uw0FEHzgPLnEmrxyEL97X229V4N51JBK50Q==
X-Received: by 2002:a05:600c:8b0d:b0:450:d5c8:29ae with SMTP id
 5b1f17b1804b1-4511ecb89bbmr84157145e9.1.1748940949228; 
 Tue, 03 Jun 2025 01:55:49 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8ed1bsm159385755e9.8.2025.06.03.01.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 01:55:48 -0700 (PDT)
Message-ID: <ce668d93-0edd-432f-abb4-dc8ca1a870db@suse.com>
Date: Tue, 3 Jun 2025 10:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250602155710.63165-1-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250602155710.63165-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] open12: Convert to new API
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

On 6/2/25 17:57, Martin Doucha wrote:
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> In addition to converting the test, also enable .all_filesystems.
> A follow-up patch fixes the useless O_APPEND testcase.
>
>   testcases/kernel/syscalls/open/open12.c | 247 +++++++++---------------
>   1 file changed, 90 insertions(+), 157 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
> index 188d17946..c8147bc9f 100644
> --- a/testcases/kernel/syscalls/open/open12.c
> +++ b/testcases/kernel/syscalls/open/open12.c
> @@ -1,134 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2014 Fujitsu Ltd.
>    * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program.
> + * Copyright (c) 2025 SUSE LLC <mdoucha@suse.cz>
>    */
> -/*
> - * DESCRIPTION
> - *	This test case will verify basic function of open(2) with the flags
> - *	O_APPEND, O_NOATIME, O_CLOEXEC and O_LARGEFILE.
> +/*\
> + * This test case will verify basic function of open(2) with the flags
> + * O_APPEND, O_NOATIME, O_CLOEXEC and O_LARGEFILE.
>    */
>   
>   #define _GNU_SOURCE
>   
> -#include <stdio.h>
> -#include <sys/types.h>
>   #include <sys/wait.h>
> -#include <unistd.h>
> -#include <mntent.h>
> -#include <errno.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   #include "lapi/fcntl.h"
>   #include "lapi/mount.h"
>   
>   #define MNTPOINT	"mntpoint"
> -#define TEST_FILE	MNTPOINT"/test_file"
> -#define LARGE_FILE	"large_file"
> -
> -#define DIR_MODE 0755
> -
> -char *TCID = "open12";
> +#define TEST_FILE	MNTPOINT "/test_file"
> +#define LARGE_FILE	MNTPOINT "/large_file"
>   
> -static const char *device;
> -static unsigned int mount_flag, skip_noatime;
> +static int fd = -1;
>   
> -static void setup(void);
> -static void cleanup(void);
>   static void test_append(void);
>   static void test_noatime(void);
>   static void test_cloexec(void);
>   static void test_largefile(void);
>   
> -static void (*test_func[])(void) = { test_append, test_noatime, test_cloexec,
> -				     test_largefile };
> +static void (*test_func[])(void) = {
> +	test_append, test_noatime, test_cloexec, test_largefile
> +};
>   
> -int TST_TOTAL = ARRAY_SIZE(test_func);
> -
> -int main(int argc, char **argv)
> +static void run(unsigned int n)
>   {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			(*test_func[i])();
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	test_func[n]();
>   }
>   
>   static void setup(void)
>   {
> -	const char *mount_flags[] = {"noatime", "relatime", NULL};
> -
> -	TEST_PAUSE;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
> -	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
> -
> -	if (tst_path_has_mnt_flags(cleanup, NULL, mount_flags)) {
> -		const char *fs_type;
> -
> -		fs_type = tst_dev_fs_type();
> -		device = tst_acquire_device(cleanup);
> -
> -		if (!device) {
> -			tst_resm(TINFO, "Failed to obtain block device");
> -			skip_noatime = 1;
> -			goto end;
> -		}
> -
> -		tst_mkfs(cleanup, device, fs_type, NULL, NULL);
> -
> -		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_STRICTATIME, NULL);
> -		mount_flag = 1;
> -	}
> -
> -end:
> -	SAFE_FILE_PRINTF(cleanup, TEST_FILE, TEST_FILE);
> +	SAFE_FILE_PRINTF(TEST_FILE, TEST_FILE);
>   }
>   
>   static void test_append(void)
>   {
>   	off_t len1, len2;
>   
> -	TEST(open(TEST_FILE, O_RDWR | O_APPEND, 0777));
> +	tst_res(TINFO, "Testing O_APPEND");
> +
> +	fd = TST_EXP_FD_SILENT(open(TEST_FILE, O_RDWR | O_APPEND, 0644));
Is there a reason why not using SAFE_OPEN() ? It doesn't seem to affect 
the code.
Also, if open() syscall fails we are not printing anything but the TINFO 
message and it makes sense to TBROK if there's a problem with opening 
the test file (LTP or system bug).
>   
> -	if (TEST_RETURN == -1) {
> -		tst_resm(TFAIL | TTERRNO, "open failed");
> +	if (!TST_PASS)
>   		return;
> -	}
>   
> -	len1 = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
> -	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, TEST_RETURN, TEST_FILE,
> -		sizeof(TEST_FILE));
> -	len2 = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
> -	SAFE_CLOSE(cleanup, TEST_RETURN);
> +	len1 = SAFE_LSEEK(fd, 0, SEEK_CUR);
> +	SAFE_WRITE(1, fd, TEST_FILE, strlen(TEST_FILE));
> +	len2 = SAFE_LSEEK(fd, 0, SEEK_CUR);
> +	SAFE_CLOSE(fd);
>   
>   	if (len2 > len1)
> -		tst_resm(TPASS, "test O_APPEND for open success");
> +		tst_res(TPASS, "O_APPEND works as expected");
>   	else
> -		tst_resm(TFAIL, "test O_APPEND for open failed");
> +		tst_res(TFAIL, "O_APPEND did not move write cursor");
Maybe we can use TST_EXP_EXPR here
>   }
>   
>   static void test_noatime(void)
> @@ -136,31 +69,23 @@ static void test_noatime(void)
>   	char read_buf;
>   	struct stat old_stat, new_stat;
>   
> -	if (skip_noatime) {
> -		tst_resm(TCONF,
> -		         "test O_NOATIME flag for open needs filesystems which "
> -		         "is mounted without noatime and relatime");
> -		return;
> -	}
> -
> -	SAFE_STAT(cleanup, TEST_FILE, &old_stat);
> +	tst_res(TINFO, "Testing O_NOATIME");
>   
> +	SAFE_STAT(TEST_FILE, &old_stat);
>   	sleep(1);
> +	fd = TST_EXP_FD_SILENT(open(TEST_FILE, O_RDONLY | O_NOATIME, 0644));
>   
> -	TEST(open(TEST_FILE, O_RDONLY | O_NOATIME, 0777));
> -
> -	if (TEST_RETURN == -1) {
> -		tst_resm(TFAIL | TTERRNO, "open failed");
> +	if (!TST_PASS)
>   		return;
> -	}
> -	SAFE_READ(cleanup, 1, TEST_RETURN, &read_buf, 1);
> -	SAFE_CLOSE(cleanup, TEST_RETURN);
> -	SAFE_STAT(cleanup, TEST_FILE, &new_stat);
> +
> +	SAFE_READ(1, fd, &read_buf, 1);
> +	SAFE_CLOSE(fd);
> +	SAFE_STAT(TEST_FILE, &new_stat);
>   
>   	if (old_stat.st_atime == new_stat.st_atime)
> -		tst_resm(TPASS, "test O_NOATIME for open success");
> +		tst_res(TPASS, "File access time was not modified");
>   	else
> -		tst_resm(TFAIL, "test O_NOATIME for open failed");
> +		tst_res(TFAIL, "File access time changed");
TST_EXP_EQ_LI() would also print the values
>   }
>   
>   static void test_cloexec(void)
> @@ -169,80 +94,88 @@ static void test_cloexec(void)
>   	int status;
>   	char buf[20];
>   
> -	TEST(open(TEST_FILE, O_RDWR | O_APPEND | O_CLOEXEC, 0777));
> -
> -	if (TEST_RETURN == -1) {
> -		tst_resm(TFAIL | TTERRNO, "open failed");
> -		return;
> -	}
> -
> -	sprintf(buf, "%ld", TEST_RETURN);
> +	tst_res(TINFO, "Testing O_CLOEXEC");
>   
> -	pid = tst_fork();
> -	if (pid < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
> +	fd = TST_EXP_FD_SILENT(open(TEST_FILE, O_RDWR | O_APPEND | O_CLOEXEC,
> +		0644));
Just in case of TST_EXP_FD_SILENT usage around the tests, TST_PASS is 
not checked here.
> +	sprintf(buf, "%d", fd);
snprintf() probably would be a better choice, even if buffer is big 
enough (64bits would be converted into 21 chars, so 20 chars are enough 
for 32-bits integer)
> +	pid = SAFE_FORK();
>   
>   	if (pid == 0) {
>   		if (execlp("open12_child", "open12_child", buf, NULL))
>   			exit(2);
>   	}
>   
> -	SAFE_CLOSE(cleanup, TEST_RETURN);
> +	SAFE_CLOSE(fd);
>   
>   	if (wait(&status) != pid)
> -		tst_brkm(TBROK | TERRNO, cleanup, "wait() failed");
> +		tst_brk(TBROK | TERRNO, "wait() failed");
>   
> -	if (WIFEXITED(status)) {
> -		switch ((int8_t)WEXITSTATUS(status)) {
> -		case 0:
> -			tst_resm(TPASS, "test O_CLOEXEC for open success");
> +	if (!WIFEXITED(status))
> +		tst_brk(TBROK, "open12_child exited with unexpected error");
> +
> +	switch (WEXITSTATUS(status)) {
> +	case 0:
> +		tst_res(TPASS, "File descriptor was closed by execlp()");
>   		break;
> -		case 1:
> -			tst_resm(TFAIL, "test O_CLOEXEC for open failed");
> +
Very nit: space between switch/case doesn't follow kernel coding style 
conventions
> +	case 1:
> +		tst_res(TFAIL, "File descriptor remained open after execlp()");
>   		break;
> -		default:
> -			tst_brkm(TBROK, cleanup, "execlp() failed");
> -		}
> -	} else {
> -		tst_brkm(TBROK, cleanup,
> -				 "open12_child exits with unexpected error");
> +
> +	default:
> +		tst_brk(TBROK, "execlp() failed");
>   	}
>   }
>   
>   static void test_largefile(void)
>   {
> -	int fd;
>   	off_t offset;
>   
> -	fd = SAFE_OPEN(cleanup, LARGE_FILE,
> -				O_LARGEFILE | O_RDWR | O_CREAT, 0777);
> +	tst_res(TINFO, "Testing O_LARGEFILE");
>   
> -	offset = lseek(fd, 4.1*1024*1024*1024, SEEK_SET);
offset = lseek(fd, 4.1 * TST_GB, SEEK_SET);
> -	if (offset == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "lseek failed");
> +	fd = TST_EXP_FD_SILENT(open(LARGE_FILE, O_LARGEFILE | O_RDWR | O_CREAT,
> +		0644));
>   
> -	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, LARGE_FILE,
> -		sizeof(LARGE_FILE));
> +	if (!TST_PASS)
> +		return;
>   
> -	SAFE_CLOSE(cleanup, fd);
> +	offset = lseek(fd, 4.1*1024*1024*1024, SEEK_SET);
>   
> -	TEST(open(LARGE_FILE, O_LARGEFILE | O_RDONLY, 0777));
> +	if (offset < 0) {
> +		tst_res(TFAIL | TERRNO, "lseek() past 4GB range failed");
> +		return;
> +	}
>   
> -	if (TEST_RETURN == -1) {
> -		tst_resm(TFAIL, "test O_LARGEFILE for open failed");
> +	SAFE_WRITE(1, fd, LARGE_FILE, strlen(LARGE_FILE));
> +	SAFE_CLOSE(fd);
> +	fd = open(LARGE_FILE, O_LARGEFILE | O_RDONLY, 0644);
> +
> +	if (fd < 0) {
> +		tst_res(TFAIL, "Cannot open large file again");
>   	} else {
> -		tst_resm(TPASS, "test O_LARGEFILE for open success");
> -		SAFE_CLOSE(cleanup, TEST_RETURN);
> +		tst_res(TPASS, "O_LARGEFILE works as expected");
> +		SAFE_CLOSE(fd);
>   	}
>   }
>   
>   static void cleanup(void)
>   {
> -	if (mount_flag && tst_umount(MNTPOINT) == -1)
> -		tst_brkm(TWARN | TERRNO, NULL, "umount(2) failed");
> -
> -	if (device)
> -		tst_release_device(device);
> -
> -	tst_rmdir();
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
>   }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = run,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(test_func),
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.all_filesystems = 1,
> +	.mntpoint = MNTPOINT,
> +	.filesystems = (struct tst_fs[]){
> +		{ .type = NULL, .mnt_flags = MS_STRICTATIME },
> +		{}
> +	}
> +};

The rest looks good to me.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
