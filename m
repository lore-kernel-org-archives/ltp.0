Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D718C3065C
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719913953; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=JPsD2srlYZy0Gud2mxPB+5Ivu4zJ+2Zs4vaKvu5JeS0=;
 b=Bt/EU8mXk7Y44pFRMzL+zhehTSvJmn8S9XC7JVepkFtb5G4T5cmfqzvxciWmZLAUU3JUp
 VU1WAoFKLP14hqRacYVg+FW4aIeNMvmxb4GcrhNXupozLHcZcm7xxEjs4nCVRq5ylIRbtDc
 xcJRsLbvHSPKsX21YS9WC8zLJGOYyds=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D8F33D3EBD
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 11:52:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E5B43D3E93
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 11:52:12 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BECC1009BE6
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 11:52:11 +0200 (CEST)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so46448641fa.3
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719913930; x=1720518730; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jErwJfxgsbdcwDuSWpz6tl3SYkizBamcwITgPpfZ6LA=;
 b=Ik+kDk89qcAd5aZ+4H5qbPxXuKUXPQvYucRCVzJ43PSRl5eti/YVbnQyFGvQVp21qx
 pg78FfgDD2I3nxeYxaBnNJdM1HjjxbNTNBhBj4Iaygn0ReAmeuaEi4S5mZB1DdNdf02D
 7apMRWRzg04i8GCemDY8R+D8EwXTmm/Mni38cTcNbaEngg7NJnUhNDkR0+egrVUtSqUG
 Ov5sA3Sd7yrFdhsSEp8Gtt3TQ/mHcCGe+wE6UI2Bm9Yf4M9vwll6YOJE4kc36gIuoBNs
 xEX+dBiosxlEfEnMMZTmfR6KTEjrcwG55Qii6HOxtIZHzF+PQBLFeaEdBAGLGpNNnFi9
 F1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719913930; x=1720518730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jErwJfxgsbdcwDuSWpz6tl3SYkizBamcwITgPpfZ6LA=;
 b=QHIl8bCk47eE4e1jBOKbVP2s1Ahb9DkuOdnZ3NhSrIOzx/SsyT23hT96qIwKXDBkja
 0uzzOUtbAxaSnvR4sa9vlCwwSJh5///aRLqX9ucpXLPcNTzqgSwTkKZ8M5UmogNX5siO
 RS9yDJRxUEs0biDrOGovye+oEHRipzwjuQGxGf0p9hwhiWY3qqdcE6619evL848j8whG
 T2KTnCF5vdOq3k0dHgd76jJXIC8yI2RutjKeNsJdONVm5Eta6PJlmdAnZuzh2+GOQS1v
 4vOwc6TD2tXDPCTpj+YgYGUzZ+a525xE22ScO3AK7PRGxYlWAPlvoM1jm5dyMJku8fXa
 2lsQ==
X-Gm-Message-State: AOJu0YxHtqTDgAjmQTPd8Lr6329iM34BGXPjFBXZ6Iji2xRupTRFbtvk
 f1y0Q8Ea+5E/Tu0PHUWUWRbm4jJpYATBg/XFw0BN+yZEnbk/7KMEtD0+lUtudJ8=
X-Google-Smtp-Source: AGHT+IEdLSfgOXXhcWMrd4ht8uzHeHJLC9a06HXt5eAb7pcvVZ8bLlVQeKbpR1ncFkN+ILGmyyW8Fg==
X-Received: by 2002:a2e:a786:0:b0:2ec:5075:83d2 with SMTP id
 38308e7fff4ca-2ee5e392a0emr57716391fa.22.1719913929862; 
 Tue, 02 Jul 2024 02:52:09 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c8f1asm79995995ad.48.2024.07.02.02.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 02:52:09 -0700 (PDT)
Message-ID: <a5905244-ec46-4e5f-9f1b-dbf641a2535a@suse.com>
Date: Tue, 2 Jul 2024 11:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240419123137.6731-1-andrea.cervesato@suse.de>
 <Znl4ozB8fGrAcvtD@yuki>
Content-Language: en-US
In-Reply-To: <Znl4ozB8fGrAcvtD@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add lstat03 test
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

Hi!

On 6/24/24 15:46, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/syscalls/lstat/.gitignore b/testcases/kernel/syscalls/lstat/.gitignore
>> index a497a445f..72cba871f 100644
>> --- a/testcases/kernel/syscalls/lstat/.gitignore
>> +++ b/testcases/kernel/syscalls/lstat/.gitignore
>> @@ -2,3 +2,5 @@
>>   /lstat01_64
>>   /lstat02
>>   /lstat02_64
>> +/lstat03
>> +/lstat03_64
>> diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
>> new file mode 100644
>> index 000000000..af852169f
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/lstat/lstat03.c
>> @@ -0,0 +1,204 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> + *    Author: David Fenner, Jon Hendrickson
>> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that lstat() provides correct information according
>> + * with device, access time, block size, ownership, etc.
>> + * The implementation provides a set of tests which are specific for each one
>> + * of the `struct stat` used to read file and symlink information.
>> + */
>> +
>> +#include "tst_test.h"
>> +
>> +#define MNTPOINT "mntpoint"
>> +
>> +static void test_dev(void)
>> +{
>> +	char *filename = "file_dev";
>> +	char *symname = MNTPOINT"/sym_dev";
>> +
>> +	tst_res(TINFO, "Test symlink device");
>> +
>> +	SAFE_TOUCH(filename, 0777, NULL);
>> +	SAFE_SYMLINK(filename, symname);
> I suppose that I missed part of the discussion, but why isn't it
> possible to create a single file that has as many things different as
> possible in the test setup and simply use it in all tests?
>
>> +	struct stat path;
>> +	struct stat link;
>> +
>> +	TST_EXP_PASS(lstat(filename, &path));
>> +	TST_EXP_PASS(lstat(symname, &link));
>> +
>> +	TST_EXP_EXPR(path.st_dev != link.st_dev, "path.st_dev != link.st_dev");
>> +	TST_EXP_EXPR(path.st_ino != link.st_ino, "path.st_ino != link.st_ino");
> Hmm, the TST_EXP_EXPR() does not seem to do the stringification as the
> rest of the macros and we have to repeat the arguments here. I suppose
> that we need:
>
> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 22b39fb14..5e83eeaca 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -340,8 +340,9 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>                          &tst_exp_err__, 1, ##__VA_ARGS__);                     \
>          } while (0)
>   
> -#define TST_EXP_EXPR(EXPR, FMT, ...)                                           \
> -       tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: " FMT, ##__VA_ARGS__);
> +#define TST_EXP_EXPR(EXPR, ...)                                                    \
> +       tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "     \
> +                TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__))
>   
>   #define TST_EXP_EQ_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {\
>          TYPE tst_tmp_a__ = VAL_A; \
> diff --git a/testcases/kernel/syscalls/fork/fork04.c b/testcases/kernel/syscalls/fork/fork04.c
> index b0c6bebe0..413cd5eb4 100644
> --- a/testcases/kernel/syscalls/fork/fork04.c
> +++ b/testcases/kernel/syscalls/fork/fork04.c
> @@ -29,7 +29,7 @@ static void run_child(void)
>   
>          TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
>                  "%s environ variable has been inherited by the child",
> -               ENV_KEY)
> +               ENV_KEY);
>   
>          tst_res(TINFO, "Unset %s environ variable inside child", ENV_KEY);
>   
> @@ -72,7 +72,7 @@ static void run(void)
>          } else {
>                  TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
>                          "%s environ variable is still present inside parent",
> -                       ENV_KEY)
> +                       ENV_KEY);
>          }
>   
>          TST_CHECKPOINT_WAKE_AND_WAIT(0);
> @@ -85,7 +85,7 @@ static void run(void)
>          else {
>                  TST_EXP_EXPR(strcmp(ENV_VAL0, val) == 0,
>                          "%s environ variable didn't change inside parent",
> -                       ENV_KEY)
> +                       ENV_KEY);
>          }
>   }
>
>
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void test_nlink(void)
>> +{
>> +	char *filename = "file_nlink";
>> +	char *symname = "sym_nlink";
>> +
>> +	tst_res(TINFO, "Test symlink hard link");
>> +
>> +	SAFE_TOUCH(filename, 0777, NULL);
> We should link the filename to a different name here.
>
>> +	SAFE_SYMLINK(filename, symname);
>> +
>> +	struct stat path;
>> +	struct stat link;
>> +
>> +	TST_EXP_PASS(lstat(filename, &path));
>> +	TST_EXP_PASS(lstat(symname, &link));
>> +
>> +	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);
> And then this would be actually different, which is what we should test
> for.
Indeed, this is the case of link(), not symlink(). Since we are testing 
symlink syscall, I will remove this part of the test.
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void test_ownership(void)
>> +{
>> +	char *filename = "file_all";
>> +	char *symname = "sym_ownership";
>> +
>> +	tst_res(TINFO, "Test symlink ownership");
>> +
>> +	SAFE_TOUCH(filename, 0777, NULL);
>> +	SAFE_SYMLINK(filename, symname);
>> +
>> +	SAFE_CHOWN(symname, 1000, 1000);
>> +
>> +	struct stat path;
>> +	struct stat link;
>> +
>> +	TST_EXP_PASS(lstat(filename, &path));
>> +	TST_EXP_PASS(lstat(symname, &link));
>> +
>> +	TST_EXP_EXPR(path.st_uid != link.st_uid, "path.st_uid != link.st_uid");
>> +	TST_EXP_EXPR(path.st_gid != link.st_gid, "path.st_gid != link.st_gid");
>> +
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void test_filesize(void)
>> +{
>> +	char *filename = "file_size";
>> +	char *symname = "sym_size";
>> +	int fd;
>> +
>> +	tst_res(TINFO, "Test symlink filesize");
>> +
>> +	SAFE_TOUCH(filename, 0777, NULL);
>> +
>> +	fd = SAFE_OPEN(filename, O_WRONLY, 0777);
>> +	tst_fill_fd(fd, 'a', TST_KB, 500);
>> +	SAFE_CLOSE(fd);
>> +
>> +	SAFE_SYMLINK(filename, symname);
>> +
>> +	struct stat path;
>> +	struct stat link;
>> +
>> +	TST_EXP_PASS(lstat(filename, &path));
>> +	TST_EXP_PASS(lstat(symname, &link));
>> +
>> +	TST_EXP_EXPR(path.st_size != link.st_size, "path.st_size != link.st_size");
>> +	TST_EXP_EXPR(path.st_blocks != link.st_blocks, "path.st_blocks != link.st_blocks");
>> +
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void test_blksize(void)
>> +{
>> +	char *filename = "file_blksize";
>> +	char *symname = MNTPOINT"/sym_blksize";
>> +
>> +	tst_res(TINFO, "Test symlink blksize");
>> +
>> +	SAFE_TOUCH(filename, 0777, NULL);
>> +	SAFE_SYMLINK(filename, symname);
>> +
>> +	struct stat path;
>> +	struct stat link;
>> +
>> +	TST_EXP_PASS(lstat(filename, &path));
>> +	TST_EXP_PASS(lstat(symname, &link));
>> +
>> +	TST_EXP_EXPR(path.st_blksize != link.st_blksize, "path.st_blksize != link.st_blksize");
>> +
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void test_timestamp(void)
>> +{
>> +	char *filename = "file_timestamp";
>> +	char *symname = "sym_timestamp";
>> +
>> +	tst_res(TINFO, "Test symlink timestamp");
>> +
>> +	SAFE_TOUCH(filename, 0777, NULL);
>> +
>> +	/* we wait a bit before creating symlink in order to obtain
>> +	 * different timestamp values
>> +	 */
>> +	sleep(1);
>> +	SAFE_SYMLINK(filename, symname);
> This should really be done in the test setup, since as it is now the
> test would sleep for 1 second for each iteration with -i.
>
>> +	struct stat path;
>> +	struct stat link;
>> +
>> +	TST_EXP_PASS(lstat(filename, &path));
>> +	TST_EXP_PASS(lstat(symname, &link));
>> +
>> +	TST_EXP_EXPR(path.st_atime != link.st_atime, "path.st_atime != link.st_atime");
>> +	TST_EXP_EXPR(path.st_mtime != link.st_mtime, "path.st_mtime != link.st_mtime");
>> +	TST_EXP_EXPR(path.st_ctime != link.st_ctime, "path.st_ctime != link.st_ctime");
>> +
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	test_dev();
>> +	test_nlink();
>> +	test_ownership();
>> +	test_filesize();
>> +	test_blksize();
>> +	test_timestamp();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char opt_bsize[32];
>> +	const char *const fs_opts[] = {opt_bsize, NULL};
>> +	struct stat sb;
>> +	int pagesize;
>> +
>> +	SAFE_STAT(".", &sb);
>> +	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
>> +
>> +	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
>> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
>> +}
>> +
>> +static void cleanup(void)
>> +{
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
>> +	.needs_device = 1,
>> +	.mntpoint = MNTPOINT,
>> +};
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
