Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A5C25B75
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 11:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716980498; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=3mr/m3Xn1J4PhGn9AnbPQpLva4axzIJZtYQJ0/xx+uI=;
 b=iVRXlDt6Rix2uuf5lXtLk5LEXTS4dPUfhIvvq0uyi7m0aZaIMBCCnr8BWcMGhrRpPOmE0
 BtlAQDQN+BYpkyFA1LZSOSMFlLhgyFp4Ryb2OqlwiPqpG9TbxmW0+/177M+1pJhkkLnS+Ua
 JRw+TNFrgs3Ac/qaxKMgC28g8NnS5Kw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E50A3D066F
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 13:01:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DB933CFF1A
 for <ltp@lists.linux.it>; Wed, 29 May 2024 13:01:14 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2FE4140838E
 for <ltp@lists.linux.it>; Wed, 29 May 2024 13:01:11 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57a033c2e9fso955436a12.2
 for <ltp@lists.linux.it>; Wed, 29 May 2024 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716980471; x=1717585271; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HuH5VkentOHikFqiY+CFffNr4fkbQ4H/oYZUjAq6HX4=;
 b=U6LlUIIG09e7YiZ05ThrFbg4cgR5EYPXYGpqkc2gFhMBiqoypONQQ84rNtB3O+iLZw
 Eb/p1uGqwrz9mNeKKXamPdndjcP/Za+pIiRd2iteIm3CCY1+FBzkFUMHJ7LiAWZcMDOR
 dHmSQrEFqWXF9lP7J584FlR2RGYcztuZ8PxiaiJBSwSgEb76ms5+ZqdCTofSxao2MkGw
 Lh/fwlOzWW/CnQ9nwIxjphiqLKyAzP72GDxzLbHBnP/fDL5ywaKFOAFJzLBXGr8V+Pwx
 i8IHjXZsMM/nhKQdvPNRAt3AQJTh5xlcmRRo2kXBHN2TtxR3HX4yB79QD5jjEnZxcZit
 x7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716980471; x=1717585271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HuH5VkentOHikFqiY+CFffNr4fkbQ4H/oYZUjAq6HX4=;
 b=Z1eHBiow08arhW9v1D4tl5CAvITzU/+Nvqq6qw4LSGicmvysmMpMAa49GbdZdpFSeS
 EUIFElSaat+mnsz1Fb9lYbIw2c5/xcuCklCtamLu+5iV7BfshAD10D5UuSwA6iYFvA2O
 XahrGqbHpIYG4I3VjBDutcDIb1sZi5+vxZnul8pu8r6mr30iIhgrXTmAGtuJCb2GDI8X
 lOwbLidLN3wD1sJAKIcq4BgRqctWu7YQA+6joHiilfd6bFhPK4CFSMk3PZcMqH1+17/S
 Kk09z33pbCMd/+QKMpHCQnTiPOjkqKJ2aBn6ATyjX0X8Qm2TCTSKXm+f7tP7PbJwnzuY
 G07Q==
X-Gm-Message-State: AOJu0YyySWy6ahwNBAIsIAXK9KZfi19EQUXAH1XONvO0ZoAcSZjudqOg
 rVpNYrEqtpZmEV0nr2IL8t5Gmf8klbUrBqXBj5u/G4jbyUhS3lwWjmpkFLxUaP5PAcLTnkVSCB1
 bJG4=
X-Google-Smtp-Source: AGHT+IFdZ3ZvqmeftuZVHOhgjQWEBpX2FUB3gznxyyqZrd5IAe2zc3dPB6cwgw8sibnkrAJHXAkmXA==
X-Received: by 2002:a50:bb41:0:b0:574:f27a:b3ec with SMTP id
 4fb4d7f45d1cf-57851942786mr13080978a12.16.1716980470596; 
 Wed, 29 May 2024 04:01:10 -0700 (PDT)
Received: from [192.168.178.40] ([213.220.156.60])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579ce607407sm4580135a12.74.2024.05.29.04.01.10
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 04:01:10 -0700 (PDT)
Message-ID: <5143bc92-1c2d-4866-810b-310665b01cc6@suse.com>
Date: Wed, 29 May 2024 13:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240510002331.31431-1-wegao@suse.com>
 <20240524085617.32303-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20240524085617.32303-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] chmod08.c: Block mode changes of symlinks
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

Hi Wei,

there's already a patch doing that. I wrote it long time ago, but it's 
pending for review. Please take a look if you are interested:
https://patchwork.ozlabs.org/project/ltp/patch/20240220131319.11761-1-andrea.cervesato@suse.de/

Andrea

On 5/24/24 10:56, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   runtest/syscalls                           |  1 +
>   testcases/kernel/syscalls/chmod/.gitignore |  1 +
>   testcases/kernel/syscalls/chmod/chmod08.c  | 67 ++++++++++++++++++++++
>   3 files changed, 69 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/chmod/chmod08.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index fe9ad0895..5754d8195 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -70,6 +70,7 @@ chmod03 chmod03
>   chmod05 chmod05
>   chmod06 chmod06
>   chmod07 chmod07
> +chmod08 chmod08
>   
>   chown01 chown01
>   chown01_16 chown01_16
> diff --git a/testcases/kernel/syscalls/chmod/.gitignore b/testcases/kernel/syscalls/chmod/.gitignore
> index 27ddfce16..f295f4dcb 100644
> --- a/testcases/kernel/syscalls/chmod/.gitignore
> +++ b/testcases/kernel/syscalls/chmod/.gitignore
> @@ -3,3 +3,4 @@
>   /chmod05
>   /chmod06
>   /chmod07
> +/chmod08
> diff --git a/testcases/kernel/syscalls/chmod/chmod08.c b/testcases/kernel/syscalls/chmod/chmod08.c
> new file mode 100644
> index 000000000..368a1d635
> --- /dev/null
> +++ b/testcases/kernel/syscalls/chmod/chmod08.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test for kernel commit
> + * 5d1f903f75a8 ("attr: block mode changes of symlinks")
> + */
> +
> +#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +
> +#define MODE 0644
> +#define TESTFILE "testfile"
> +#define TESTFILE_SYMLINK "testfile_symlink"
> +
> +static void run(void)
> +{
> +	struct stat stat_file, stat_sym;
> +	int mode = 0;
> +	char fd_path[100];
> +
> +	int fd = SAFE_OPEN(TESTFILE_SYMLINK, O_PATH | O_NOFOLLOW);
> +
> +	sprintf(fd_path, "/proc/self/fd/%d", fd);
> +
> +	TST_EXP_FAIL(chmod(fd_path, mode), ENOTSUP, "chmod(%s, %04o)",
> +			TESTFILE_SYMLINK, mode);
> +
> +	SAFE_STAT(TESTFILE, &stat_file);
> +	SAFE_LSTAT(TESTFILE_SYMLINK, &stat_sym);
> +
> +	stat_file.st_mode &= ~S_IFREG;
> +	stat_sym.st_mode &= ~S_IFLNK;
> +
> +	TST_EXP_EXPR(stat_file.st_mode != (unsigned int)mode,
> +			"stat(%s) mode=%04o", TESTFILE, stat_file.st_mode);
> +
> +	TST_EXP_EXPR(stat_sym.st_mode != (unsigned int)mode,
> +			"stat(%s) mode=%04o", TESTFILE, stat_sym.st_mode);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(TESTFILE, MODE, NULL);
> +	SAFE_SYMLINK(TESTFILE, TESTFILE_SYMLINK);
> +}
> +
> +static void cleanup(void)
> +{
> +	remove(TESTFILE);
> +	remove(TESTFILE_SYMLINK);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.min_kver = "6.6",
> +	.mntpoint = "mntpoint",
> +	.all_filesystems = 1
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
