Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F511C02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738576983; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Z4EEsr7Y0gvwKl7IyDew1aB3nclxwkWMRuiG88VvNbs=;
 b=kxeBDmJWf8LJ2TUFAmt9zlytkM4rTkp91bcz+lYpnJlEuyoRdaqy+ZMuC6Wg8oWKebfie
 rPLreCFwyhEJ9g40ij7pFIkmb8sdAdB4iLk0N9P1P+wxtiM7CgW/A/W3mTFQU4BNgiHov3U
 Q+sBRssB6mud33772DFsIYA0b8XOgKU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70BBE3C8E8C
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 11:03:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 090243C7AE1
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:02:41 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 591FE1BBEF06
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:02:40 +0100 (CET)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso8414601a12.0
 for <ltp@lists.linux.it>; Mon, 03 Feb 2025 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738576960; x=1739181760; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SLp00cwidrUfioAv/EVkhVceitrPpxzZNCFttftvmEM=;
 b=WOgl0Rx2QYsNwVIzPBQ0MwWBpTPcciE6yActpFUoGrYXb1/ruEsCIAvUqJAMOUn3Mj
 PjiVf8bqR245tQn3NRheNE/B3mGd2/Ce5CFRGS2XdwB7pKhI17lqiPBABgTw5kJvpZjf
 Kq0wJIRtgDSAsBjWnzE/W9TXvJu4XpBuidcXFJalHUNnBpNOzqcdAULfGIB3teIv8xfw
 ysnPfy0rmhiYvb8OWwO7opSkSbEikON4RrqFJOsZojOySoz0VxXE6Q4X23c9Wj+5B/S0
 TA/nbG056cujL4iBSSr4jOToryVSueK0pha02zUocL6typYxr4zm0DRqALJsootiTKzR
 R6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738576960; x=1739181760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLp00cwidrUfioAv/EVkhVceitrPpxzZNCFttftvmEM=;
 b=db0s3NRMDyxCS6OXSVo2yRpaD+ZqNKLlxphZLPFJo2YXqs62Wxml4/oTqppE+u5Vxx
 YFB9XmCn0XmHz8wzyOoKgB4iVI6uH+iMLr5fGBRT2vHXOWBScO2ZTnyhjrZwV5GFDVw5
 ONImceUn587c5aztymYaJNtqYjGj4eJqzlhn+5US9+fl7kYzEHuh2jsRITygEg47suAl
 Lyl8FVEAptzCzS3O2Z4C4hGfxZDXiqO31rCnB7UX5Jp1LPAHRJYAFwfHyu2c5rbCOKkH
 HqU50ce/4ynGZ2Q/q8Zbp+v1BCANX8u+9spHe4TDgf24RBFcGioTbisGLCb5Pssr10Qt
 eKvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5VVzbWSN3HjupkgtADC19rjHev5GEs2C6vRF5BfNFw3NkIvbPPR6Z/5P0GKkl9iXGStI=@lists.linux.it
X-Gm-Message-State: AOJu0YwAJg7MlHFyAgtLLvvh6opGo7gt4KR6QisdTZHCe6cpgVSSHNQA
 k+CLqqZ6aXNB4NuD0v+zyt2TwISTjqQ/VMT/TFZLveeCBGt5seJz7t2KZ+NqXy4=
X-Gm-Gg: ASbGncu9n0TuGkCBN9jEqxySRfF6Ii325/pTF9LzZIlk9odWbLvW6L77t/At044y27t
 732kc0pok8CqITJhyhCjIhiNkQAdm+kx3XcOFTW598W9MuJV6LaETY5LwRIm8sm3f1/ZZS5nz69
 sK4uJIsnq3N6skofKs4+hLtIVuiiMhQmeGCcnntLsNBjFtcCjcQb+lXVDCaAP+xPCE8bAo2cRTN
 kVjd3X68fCvOa/I+GMtbRYWmHUPA6j3AYpXUfY7m1vNamjwN9JeBTHA/drmoQ5lcjd1d4YMrWoh
 ZhmhzxDjygkE9yGqRRmZiEskMQ==
X-Google-Smtp-Source: AGHT+IFBcLHTaai+FPFW1d1QFiiqkfGKZwOqBkXIYRPf5i+6iTzNxnCRC7QqVuGh5EnoAB7IOwVeMA==
X-Received: by 2002:a05:6402:50ce:b0:5d1:1f2:1143 with SMTP id
 4fb4d7f45d1cf-5dc5efc70ebmr25251956a12.18.1738576959730; 
 Mon, 03 Feb 2025 02:02:39 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc724043b7sm7420772a12.40.2025.02.03.02.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:02:39 -0800 (PST)
Message-ID: <3de3ae91-a719-4d4e-b1a0-5a7bbbadbfd8@suse.com>
Date: Mon, 3 Feb 2025 11:02:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, ltp@lists.linux.it, pvorel@suse.cz
References: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
 <20250116084013.503341-3-ruansy.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250116084013.503341-3-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] fchownat03: Add error tests for fchownat()
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 1/16/25 09:40, Shiyang Ruan wrote:
> Move the 3 error tests form fchownat01 to here, and add tests for rest
> possible errnos per the man page.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/fchownat/.gitignore |   1 +
>   .../kernel/syscalls/fchownat/fchownat03.c     | 148 ++++++++++++++++++
>   2 files changed, 149 insertions(+)
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
> index 000000000..06928490b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2007-2024
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that,
> + * - fchownat() returns -1 and sets errno to EACCES if there is no permission
> +     to access to the file.
> + * - fchownat() returns -1 and sets errno to EBADF if the file descriptor
> + *   of the specified file is not valid.
> + * - fchownat() returns -1 and sets errno to EFAULT if the filename points
> +     outside of accessable address space.
> + * - fchownat() returns -1 and sets errno to EINVAL if the flag is invalid.
> + * - fchownat() returns -1 and sets errno to ELOOP if too many symbolic links
> + *   were encountered in resolving filename.
> + * - fchownat() returns -1 and sets errno to ENAMETOOLONG if the filename is
> +     too long.
> + * - fchownat() returns -1 and sets errno to ENOENT if the specified file does
> + *   not exist.
> + * - fchownat() returns -1 and sets errno to ENOTDIR if the file descriptor is
> + *   a file.
> + * - fchownat() returns -1 and sets errno to EPERM if the effective user id
> + *   of process does not match the owner of the file and the process is not
> + *   super user.
> + * - fchownat() returns -1 and sets errno to EROFS if the file is readonly.
> + */
> +
> +#define _GNU_SOURCE
> +#include <pwd.h>
> +#include "tst_test.h"
> +
> +#define TESTFILE		"testfile"
> +#define TESTFILE_EACCESS_DIR	"eaccess"
> +#define TESTFILE_EACCESS	TESTFILE_EACCESS_DIR"/eaccess"
> +#define TESTFILE_ELOOP		"testfile_eloop"
> +#define TESTFILE_ENOENT		"/tmp/does/not/exist"
> +#define TESTFILE_EPERM		"/dev/null"
> +#define TESTFILE_EROFS_MNT	"ro_mntpoint"
> +#define TESTFILE_EROFS		TESTFILE_EROFS_MNT"/file"
> +
> +static int file_fd = -1;
> +static int no_fd = -1;
> +static int dir_fd = -1;
> +
> +static char *file_eaccess;
> +static char *file_ebadf;
> +static char *file_efault;
> +static char *file_einval;
> +static char *file_eloop;
> +static char *file_enametoolong;
> +static char *file_enoent;
> +static char *file_enotdir;
> +static char *file_eperm;
> +static char *file_erofs;
> +
> +static struct tcase {
> +	char **filename;
> +	char *desc;
> +	int *fd;
> +	int flag;
> +	int exp_errno;
> +} tcases[] = {
> +	{&file_eaccess,      TESTFILE_EACCESS,  &dir_fd,  0,    EACCES},
> +	{&file_ebadf,        TESTFILE,          &no_fd,   0,    EBADF},
> +	{&file_efault,       "Invalid address", &dir_fd,  0,    EFAULT},
> +	{&file_einval,       TESTFILE,          &dir_fd,  9999, EINVAL},
> +	{&file_eloop,        TESTFILE_ELOOP,    &dir_fd,  0,    ELOOP},
> +	{&file_enametoolong, "aaaa...",         &dir_fd,  0,    ENAMETOOLONG},
> +	{&file_enoent,       TESTFILE_ENOENT,   &dir_fd,  0,    ENOENT},
> +	{&file_enotdir,      TESTFILE,          &file_fd, 0,    ENOTDIR},
> +	{&file_eperm,        TESTFILE_EPERM,    &dir_fd,  0,    EPERM},
> +	{&file_erofs,        TESTFILE_EROFS,    &dir_fd,  0,    EROFS},
> +};
> +
> +static void fchownat_verify(unsigned int n)
> +{
> +	uid_t euid = geteuid();
> +	gid_t egid = getegid();
> +
> +	TST_EXP_FAIL(fchownat(*tcases[n].fd, *tcases[n].filename, euid, egid, tcases[n].flag),
> +		     tcases[n].exp_errno,
> +		     "fchownat(%d, %s, %d, %d, %d)",
> +		     *tcases[n].fd, tcases[n].desc, euid, egid, tcases[n].flag);
> +}
> +
> +static void setup(void)
> +{
> +	struct passwd *ltpuser;
> +
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
> +
> +	/* EACCES setting */
> +	SAFE_SETEUID(0);
> +	SAFE_MKDIR(TESTFILE_EACCESS_DIR, S_IRWXU);
> +	SAFE_TOUCH(TESTFILE_EACCESS, 0666, NULL);
> +	ltpuser = SAFE_GETPWNAM("nobody");
> +	SAFE_SETEUID(ltpuser->pw_uid);
> +
> +	/* EFAULT setting */
> +	file_efault = tst_get_bad_addr(NULL);
> +
> +	/* ENOTDIR setting */
> +	file_fd = SAFE_OPEN("file_fd", O_CREAT | O_RDWR, 0600);
> +
> +	/* ELOOP setting */
> +	SAFE_SYMLINK(TESTFILE_ELOOP, "test_file_eloop2");
> +	SAFE_SYMLINK("test_file_eloop2", TESTFILE_ELOOP);
> +
> +	/* ENAMETOOLONG setting */
> +	memset(file_enametoolong, 'a', PATH_MAX+1);
> +	file_enametoolong[PATH_MAX+1] = 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (dir_fd != -1)
> +		SAFE_CLOSE(dir_fd);
> +	if (file_fd != -1)
> +		SAFE_CLOSE(file_fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.needs_rofs = 1,
> +	.mntpoint = TESTFILE_EROFS_MNT,
> +	.test = fchownat_verify,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&file_eaccess,      .str = TESTFILE_EACCESS},
> +		{&file_ebadf,        .str = TESTFILE},
> +		{&file_einval,       .str = TESTFILE},
> +		{&file_eloop,        .str = TESTFILE_ELOOP},
> +		{&file_enametoolong, .size = PATH_MAX+2},
> +		{&file_enoent,       .str = TESTFILE_ENOENT},
> +		{&file_enotdir,      .str = TESTFILE},
> +		{&file_eperm,        .str = TESTFILE_EPERM},
> +		{&file_erofs,        .str = TESTFILE_EROFS},
> +		{}
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
