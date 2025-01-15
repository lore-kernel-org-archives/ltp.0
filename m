Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914EDC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736944877; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=+BPM2aHj7B2PCwMfnWx8nAw3dbh9CMFjEzrdfh/K+kM=;
 b=luNYpicULKYn/xjE4zg3CtfIvA3AJfb/c0ryLtO8NKMhKCiH1G1orK7JdzAV7wdISg4ba
 qWlXH6JBIs+BajQQmz1hIwE1jky7IqQmV9drce8/oFTWmJS07zb1bzO/UTqbIs5RLA1bpXx
 fkDPE5Op5vzDgkEt8Mu9otjKtyz9Y8c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC7063C7B75
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:41:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB1B83C7A53
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:40:55 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB67D1016C4E
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:40:54 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f796586so69822055e9.3
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 04:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736944854; x=1737549654; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=huaMLO0q7V61j4y98vFJ10COryJ7RT9A40TI34LSmNs=;
 b=SHn7we9/8i9c0IYGqpzsBTm9WgcgRNL7Ez6RoMKFCqKtWs2q7IEORmMZBUfZcYNeRS
 MGRpTH9O0cHD8EEXQQB6ghd0mjGBoxAQpfaMwQUAPVvAvbPG/bVHoo+9xmPZa6ze4aQm
 chF9Olb15tJLF8+xzAz5o7O/zB0jxHZ1jVr9b5xOXDlbNnTc4/4zKcPKNUrmB6mkcyMo
 XAICHCZ1Kq60NQUdA2OTLjGVv92hY1a5A09GeAuo80lDdnW65MinFtBgjMIFMGCqnjBm
 ifoEIw63XjRVHy+s1vJ0XbQSD21ZnIgIjByAhMwk1y/ppcS81KWVqXl7dYu/g0EAtuZP
 7lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736944854; x=1737549654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=huaMLO0q7V61j4y98vFJ10COryJ7RT9A40TI34LSmNs=;
 b=MblVCzGE6OuDo5J+aFF36PEf4fOsFBvL40r9InAAXBEd3Aj0SGQ3blIM0r6ppKZT3d
 3lF1gpdZDGWH4F9vRvmXWJYACGCZ7+f53fX4h0pFA+vpcN4ODe6Wxopgo2rNu9Xtpm+D
 ViwAxy11IUNj/uPfc6th7YFMcgFA2kln6AHNi0YxKAPiwsSKKtg5CA3AynSSKgZxxTlh
 uG7zh8TTLwzdVT0/A/rHJ+YaT1/6/gOI/CqWWVyD2oAuBElJ91/nnnMYfes7IAGBEHim
 8ni6wOpg4z6DylGDEIawBjJMwrPA+ikP92+5HVNFcTqMtXt+nEeA2GUH7hwYX9sRi/GT
 eMQw==
X-Gm-Message-State: AOJu0YyvRaKw2UkYkSf30en02+hD/MPiyHPNeUD3eygmVZiphHpC8jUZ
 i+VILzD1jsIVkooY6bNqVjQHwUxizm/yWA347lnGnnShpIfFxn57dSpSsC4/+D4BBf2k/K+7pjh
 nSlaw8Q==
X-Gm-Gg: ASbGncsBoZ/GkhytmFrwC8U7cm74WgxiIxsj/rdu6NVBY48TMKFvYS5yCN8cxQ+nkOe
 eYPX9CDlpPdxrQmcEHJKGpKVa5VsEtRBJ0TvNdU9VHMFsgi4BzdmzSXOvEUSVLH0aVhDVHv3V9F
 8QIyY8RBnJ6hYLMqpRl5JTDM+cjjuyqizTeA5cWS8uW+e/wrIN2MmNypepQIkMRVmK/qUQUcVrf
 N3XZ1QgZANwkapYOGAGdLGTr8dcw4o8dY8SaCiCvyqLWxr1qjlVzwX9aw9kOGI942ml2puMpIqg
 LiZqFjXy8WB6qRls2Zyd0dBSGxuigS8glsoWWoTMLFMcYzo7iuRBq09Dyq6J/WOZ3V08KN5iE0t
 kJYiUFnBv+FnrKj0M0vY=
X-Google-Smtp-Source: AGHT+IHNvECnhNYlKdn8QbG3vo+QVI4cjgn4pSCxGGk5A5Fy8/b+bLeLjhCKM3lPM1URjBSKomagMw==
X-Received: by 2002:a5d:6c63:0:b0:38a:418e:1179 with SMTP id
 ffacd0b85a97d-38a872fc20bmr27882247f8f.2.1736944853788; 
 Wed, 15 Jan 2025 04:40:53 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm17786537f8f.97.2025.01.15.04.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:40:53 -0800 (PST)
Message-ID: <c3a91a38-10de-4400-9db2-4c46fbc73ee7@suse.com>
Date: Wed, 15 Jan 2025 13:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, Shiyang Ruan <ruansy.fnst@fujitsu.com>
References: <20250115091218.2630891-1-ruansy.fnst@fujitsu.com>
 <20250115091218.2630891-3-ruansy.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250115091218.2630891-3-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fchownat03: Move error tests from
 fchownat01
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

This is a new test, so we require a proper commit description for it, 
even if it comes from fchownat01.
The commit name might be "Add new fchownat03 test" and description 
should contain what the test is made for and where it comes from.

On 1/15/25 10:12, Shiyang Ruan via ltp wrote:
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/fchownat/.gitignore |  1 +
>   .../kernel/syscalls/fchownat/fchownat03.c     | 77 +++++++++++++++++++
>   2 files changed, 78 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/fchownat/fchownat03.c
>
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
> index 000000000..3c50eb39e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2007-2025
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that:
> + *
> + * 1. fchownat() returns -1 and sets errno to ENOTDIR if the file descriptor is
> + *    a file.
> + * 2. fchownat() returns -1 and sets errno to EBADF if the file descriptor
> + *    of the specified file is not valid.
> + * 3. fchownat() returns -1 and sets errno to EINVAL if the flag is not valid.
The list is kinda small, we have a huge number of cases which would be 
nice to extend. Please check fchownat(2) manual.
> + */
> +
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +
> +#define TESTFILE	"testfile"
> +#define TESTFILE2	"testfile2"
TESTFILE2 is never used in the test so it can be removed.
> +
> +static int fd;
> +static int no_fd = -1;
> +static int dir_fd;
> +
> +static struct tcase {
> +	int exp_errno;
> +	int flag;
> +	int *fd;
> +	char *filename;
> +} tcases[] = {
> +	{ ENOTDIR, 0, &fd, TESTFILE },
> +	{ EBADF, 0, &no_fd, TESTFILE },
> +	{ EINVAL, 9999, &dir_fd, TESTFILE },
> +};
> +
> +static void fchownat_verify(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	uid_t euid = geteuid();
> +	gid_t egid = getegid();
> +	int fd = *tc->fd;
> +	int flag = tc->flag;
> +	const char *filename = tc->filename;
There's no need to create new variables for the tcases attributes access.
> +
> +	TST_EXP_FAIL(fchownat(fd, filename, euid, egid, flag),
> +			tc->exp_errno,
> +			"fchownat(%d, %s, %d, %d, %d)",
> +			fd, filename, euid, egid, flag);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
> +	fd = SAFE_OPEN(TESTFILE2, O_CREAT | O_RDWR, 0600);
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
Better to initialize file descriptors to -1, then check here if they are 
!= -1 after setup() and test run.
> +
> +	if (dir_fd > 0)
> +		SAFE_CLOSE(dir_fd);
Same here.
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.test = fchownat_verify,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
