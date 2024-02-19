Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EE3C48BC3
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708355990; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=NkMnANgk1xQ3MtcWN+/9D+5HjAJa1aBei9wUNlWWzIY=;
 b=UZlRF9aStt7gmK3iHbi9Zgi+x/ljtzqKvzJIRdjrIJz/3s0sGwzkviIt5UsOBKeJQMJ4x
 fetwy5iwaKiTjx7ifirOyg7P8l8tO3TM/XJ8j2jXm3P5fgHW3mpL1849TSwiPbm76a2PM8p
 xyZvFkCteNTSdwKfbZlJZXLFkKLcjv8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545F43D0D3B
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 16:19:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49C853D0476
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:19:28 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 068711400DB8
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 16:19:27 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d61d51dd1so215825f8f.3
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 07:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708355967; x=1708960767; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oqq9xkMu8Jm3t3R5IEFoZ9Dt5A/XohdhVhy7IBQ51Is=;
 b=Xj0EwVZk1UVzD4VzW9c9kDlA0tPFWKBKEs+vFDW3Rt6jdR4FdWClkyRdI/H7AtkvJU
 Mblh9+pZ3lIjuxlAirgyp5eDaMvWqwjIjyNZwRT3sko13ieC5gYjnO3rsaKbIYmJI+FL
 mq1OZlTI22xJ2FJCXhXTW/h/ZEOO4n6nyfKwNdwzJ8rS7eJntSXS7BleQeyqz6hSxc0B
 bhp13+O5gjTHc3INKl/57GmpKo/bKLkEvq+uMnVEy4wvS62RyXp4a/HI+nYBJH2hEAs9
 YPXgzAxun8f0US1nsqT7AaryCBREOjQQwCPx4nl0nEbHFYxuBKfbSDWY59fIXDupjA1a
 5fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708355967; x=1708960767;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oqq9xkMu8Jm3t3R5IEFoZ9Dt5A/XohdhVhy7IBQ51Is=;
 b=XhYtkf3ow4UEQABpwxvBpWsw27QZSuI21vHHfJ1gMLNt+eXftiGGu7NEI/yb2+nzPs
 LnnAPv4p4dqr+GKZGaCEv7S7a5mi4xZ94PeDIU+27Cz7i0DcqUyOPyuvCIAFeVD9SOao
 1fIC3urpYvmFCZu9xxAbeGIZ3G4DaiAPVaVUoTzTQa1tbPY0IEky/ySUBnOj15w4VKoH
 2qEsBiY8YyXcdQT/tL45Nz3YSLUvhN8BfMDlVT9pmesmv5V1G1nRxSV6dm6wWNc+7Ym4
 WIXJFhbEokllpNN/EHT6rmIJIVpMDe55KkxqUhwqQ3SmtEVlQtePZrSEWlIc1pcSRJR0
 4Fng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe216Kq37UpA7E8Lj+o6ENhmjh4tczV+CQ+9wZam6RwY6ckN+XFZcq8qhiOcu9i8wmZmR9yQCnEPR6kFvhq7flYwg=
X-Gm-Message-State: AOJu0YxLCuCdt9/9q8RfP7SUWidH+VCSLq9ycdbY8AUvIxN+6AOGnn5o
 zl72CyO4zn2PJXbMXji2FR6U1EfOb1Qe+X2nGiUoE/F5JzjcySnShVANIT+HJyrUrYaiK4vrOOt
 smNE=
X-Google-Smtp-Source: AGHT+IGsxMM2aXF7Omp7nBYeN7dkBcbkLCn7uVXj5sC7IyGKDXObnlbMfle7Kh4+1Cg/NzPduKknjQ==
X-Received: by 2002:a5d:65c9:0:b0:33d:264d:6df6 with SMTP id
 e9-20020a5d65c9000000b0033d264d6df6mr4773220wrw.60.1708355967363; 
 Mon, 19 Feb 2024 07:19:27 -0800 (PST)
Received: from [10.232.133.61] ([88.128.88.52])
 by smtp.gmail.com with ESMTPSA id
 m10-20020adffa0a000000b0033d4d865413sm3894137wrr.14.2024.02.19.07.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 07:19:27 -0800 (PST)
Message-ID: <f8cb593b-af41-4cf1-9ce6-84b1e511064a@suse.com>
Date: Mon, 19 Feb 2024 16:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240219150920.17624-1-andrea.cervesato@suse.de>
In-Reply-To: <20240219150920.17624-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add stat04 test
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

Hi,

please ignore this one, I'm gonna add one thing more that has been forgot.

On 2/19/24 16:09, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> This test has been extracted from symlink01 test and it checks that
> stat() executed on file provide the same information of symlink linking
> to it.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/smoketest                         |  2 +-
>   runtest/syscalls                          |  4 +-
>   testcases/kernel/syscalls/stat/.gitignore |  2 +
>   testcases/kernel/syscalls/stat/stat04.c   | 47 +++++++++++++++++++++++
>   4 files changed, 52 insertions(+), 3 deletions(-)
>   create mode 100644 testcases/kernel/syscalls/stat/stat04.c
>
> diff --git a/runtest/smoketest b/runtest/smoketest
> index 83eebfe7b..5608417f9 100644
> --- a/runtest/smoketest
> +++ b/runtest/smoketest
> @@ -8,7 +8,7 @@ time01 time01
>   wait02 wait02
>   write01 write01
>   symlink01 symlink01
> -stat04 symlink01 -T stat04
> +stat04 stat04
>   utime01A symlink01 -T utime01
>   rename01A symlink01 -T rename01
>   splice02 splice02 -s 20
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7794f1465..ef90076e4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1529,8 +1529,8 @@ stat02 stat02
>   stat02_64 stat02_64
>   stat03 stat03
>   stat03_64 stat03_64
> -stat04 symlink01 -T stat04
> -stat04_64 symlink01 -T stat04_64
> +stat04 stat04
> +stat04_64 stat04_64
>   
>   statfs01 statfs01
>   statfs01_64 statfs01_64
> diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
> index fa0a4ce9f..0a62dc6ee 100644
> --- a/testcases/kernel/syscalls/stat/.gitignore
> +++ b/testcases/kernel/syscalls/stat/.gitignore
> @@ -4,3 +4,5 @@
>   /stat02_64
>   /stat03
>   /stat03_64
> +/stat04
> +/stat04_64
> diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
> new file mode 100644
> index 000000000..f44ff136e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/stat/stat04.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test checks that stat() executed on file provide the same information
> + * of symlink linking to it.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	char *symname = "my_symlink0";
> +	char *tmpdir = tst_get_tmpdir();
> +
> +	TST_EXP_PASS(symlink(tmpdir, symname));
> +
> +	struct stat path_stat;
> +	struct stat link_stat;
> +
> +	SAFE_STAT(tmpdir, &path_stat);
> +	SAFE_STAT(symname, &link_stat);
> +
> +	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
> +	TST_EXP_EQ_LI(path_stat.st_mode, link_stat.st_mode);
> +	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
> +	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
> +	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
> +	TST_EXP_EQ_LI(path_stat.st_size, link_stat.st_size);
> +	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
> +	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
> +	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
