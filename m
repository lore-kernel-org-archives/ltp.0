Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1964AC25B75
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717139765; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=seNXY9Xag5ng+e1r4QpdiEe8ZWPQpmWrFflmVRoa9iA=;
 b=HpENgd8MixSMSd3P7ZZwmPa4q41p34x8G9Pivr0rURrWSz1NBPMUQCqHQ99+2L6M1wAKL
 SrXKuhbquax16CmbFsAylgK1tN/SBcVSW9U55xwAyEIXmLOPIwFa1MNZcNnyEGvE2DfoW/d
 GIAI3d3IQq5CauFa8xBIMRUP6ALxvx8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 026EC3D074F
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 09:16:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81E7D3C0831
 for <ltp@lists.linux.it>; Fri, 31 May 2024 09:15:43 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 30E3E1400153
 for <ltp@lists.linux.it>; Fri, 31 May 2024 09:15:42 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6265d48ec3so155481666b.0
 for <ltp@lists.linux.it>; Fri, 31 May 2024 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717139741; x=1717744541; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/TJWsRTIzcstraLWP3/SSfgBw0WXSoXIVzbRUo7+4iE=;
 b=LrgjSVYMbrEFrofiKDMeP+sKWEfo3HDnVzroX/+GXdQ9KxrarOgCHMi9I3Rvgo1r6A
 tZh1NBlYaCtizmX7Mk3L/2jTCH+wrGS7PXhmIch2POQ7wVnWUziWzjpGkfxVd6bXOB+b
 Pu+N0rYm7R0iAvtmn9OGyik0ZuFahxuAn7uiUH2F2vlazK/HLb8i5mW9m1CPmqJCM/Th
 MZ+qGHWZMPcl4oNhWcICsamFiwdBDtTj8U4pZ63YXzstFYL5S5fNqDDOXlinpal5KdJw
 YuiPLEqfamDKE/P5UDrA5OogHNrY4IwlRWyLrf8gvBjXAXMfXistywWJEHp53vlUfSai
 WddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717139741; x=1717744541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TJWsRTIzcstraLWP3/SSfgBw0WXSoXIVzbRUo7+4iE=;
 b=JcI86R550YTKZUmBiDUWvvZfpdt24iOErDONVcEuk2ZjgzYP5N4wAoEqpjYcyxik1Z
 iMscbpR4G3f26cKWdAdKBMqWZ7k6/TOg24r2DBmQs/E8JBBEUC4PeeF8sThMR0662yXD
 DIOFV8F1a/I7PQ3WkSGVq8qeuMDsYM5kc6ORaEncWO8H+oK3GetJHhEG6OBamvwhGt0B
 gh41NCC3+Uu6Fd3Ooyk/mpUDGfCszMP8P3pVHiQd/ko8sqD+l4WV3lXPMQhf291Pmd9M
 qWMUNLdjVi+BYoOu8LDLWTTMfqX6PeDCDQAGmRDdkvSQ9boNGt3GJHlanH328M1eQVnk
 MMbw==
X-Gm-Message-State: AOJu0Yxt1lBkUMB6n4o+Eb2mPWgGyUk9aEJD/tmIvbLURbdyr4kxHkmv
 FL+iDKxS3Kf9NmbhBH9bON5/hrczpyhguEfEHMufFgwqD7qqPlLsYTQZnkeWUCg=
X-Google-Smtp-Source: AGHT+IFKV+K2jXcOmiNERzZGId27TI/+tqNDq8GeVLwRxoSjD7poOLhVCmNaMcqrims3B5pkA6mP3w==
X-Received: by 2002:a17:906:4350:b0:a59:ba2b:590b with SMTP id
 a640c23a62f3a-a682272f3a0mr56235666b.71.1717139741457; 
 Fri, 31 May 2024 00:15:41 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.46.100])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e6f03094sm55607066b.30.2024.05.31.00.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:15:41 -0700 (PDT)
Message-ID: <885f7007-5726-475e-8f34-5554bed7aa1f@suse.com>
Date: Fri, 31 May 2024 09:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-1-fa96f07d0fca@suse.com> <ZlhZiZBUsEnmtwNT@yuki>
Content-Language: en-US
In-Reply-To: <ZlhZiZBUsEnmtwNT@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Add ioctl_ficlone01 test
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

On 5/30/24 12:48, Cyril Hrubis wrote:
> Hi!
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that ioctl() FICLONE feature clones file content from
>> + * one file to an another.
>> + *
>> + * [Algorithm]
>> + *
>> + * * populate source file
>> + * * clone source content inside destination file
>> + * * verify that source content has been cloned inside destination file
>> + * * write a single byte inside destination file
>> + * * verify that source content didn't change while destination did
> This is very minor but I find dashes to be a better choice for lists
> inside of C comments.
>
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/fs.h"
>> +
>> +#define MNTPOINT "mnt"
>> +#define SRCPATH MNTPOINT "/file0"
>> +#define DSTPATH MNTPOINT "/file1"
>> +
>> +#define FILEDATA "qwerty"
>> +#define FILESIZE sizeof(FILEDATA)
>> +
>> +static int src_fd = -1;
>> +static int dst_fd = -1;
>> +
>> +static void run(void)
>> +{
>> +	char buff[FILESIZE];
>> +	struct stat src_stat;
>> +	struct stat dst_stat;
>> +
>> +	src_fd = SAFE_OPEN(SRCPATH, O_CREAT | O_RDWR, 0640);
>> +	dst_fd = SAFE_OPEN(DSTPATH, O_CREAT | O_RDWR, 0640);
>> +
>> +	tst_res(TINFO, "Writing data inside src file");
>> +
>> +	SAFE_WRITE(1, src_fd, FILEDATA, FILESIZE);
>> +	SAFE_FSYNC(src_fd);
>> +
>> +	TST_EXP_PASS(ioctl(dst_fd, FICLONE, src_fd));
>> +	if (TST_RET == -1)
>> +		return;
>> +
>> +	SAFE_FSYNC(dst_fd);
>> +
>> +	tst_res(TINFO, "Verifing that data is cloned between files");
>> +
>> +	SAFE_FSTAT(src_fd, &src_stat);
>> +	SAFE_FSTAT(dst_fd, &dst_stat);
>> +
>> +	TST_EXP_EXPR(src_stat.st_ino != dst_stat.st_ino,
>> +		"inode is different. %lu != %lu",
>> +		src_stat.st_ino,
>> +		dst_stat.st_ino);
>> +
>> +	TST_EXP_EQ_LI(src_stat.st_size, dst_stat.st_size);
>> +
>> +	SAFE_READ(0, dst_fd, buff, FILESIZE);
>> +
>> +	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
>> +		"dst file has the src file content (\"%s\" - %ld bytes)",
>> +		buff,
>> +		FILESIZE);
>> +
>> +	tst_res(TINFO, "Writing a byte inside dst file");
>> +
>> +	SAFE_WRITE(SAFE_WRITE_ALL, dst_fd, "a", 1);
>> +	SAFE_FSYNC(dst_fd);
>> +
>> +	tst_res(TINFO, "Verifing that src file content didn't change");
>> +
>> +	SAFE_FSTAT(src_fd, &src_stat);
>> +	SAFE_FSTAT(dst_fd, &dst_stat);
>> +
>> +	TST_EXP_EQ_LI(dst_stat.st_size, src_stat.st_size + 1);
>> +
>> +	SAFE_READ(0, src_fd, buff, FILESIZE);
>> +
>> +	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
>> +		"src file content didn't change");
> So you append to the file but then only read the initial part? That does
> not sound right. I guess that easiest solution is to seek to the start
> of the file or od pwrite() so that we overwrite the first byte rather
> than appending.
>
> Or at least check the return value from the read.
>
>> +	SAFE_CLOSE(src_fd);
>> +	SAFE_CLOSE(dst_fd);
>> +	src_fd = -1;
>> +	dst_fd = -1;
> This is not needed, the SAFE_CLOSE() macro sets the fd to -1.
>
>> +	remove(SRCPATH);
>> +	remove(DSTPATH);
> Please use SAFE_UNLINK() instead.
>
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (src_fd != -1)
>> +		SAFE_CLOSE(src_fd);
>> +
>> +	if (dst_fd != -1)
>> +		SAFE_CLOSE(dst_fd);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.cleanup = cleanup,
>> +	.min_kver = "4.5",
>> +	.needs_root = 1,
>> +	.mount_device = 1,
>> +	.mntpoint = MNTPOINT,
>> +	.dev_fs_type = "btrfs",
>
> I suppose that we need .use_filesystems or similar and convert the
> dev_fs_type to an array so that we can run this test on xfs as well...
This might be tricky to implement, since we need to adapt .dev_fs_ops as 
well..
>> +};
>>
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
