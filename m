Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D701DC48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708433208; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=0Sw2yyn+hCG2HksPHCW4L9cEZbu4Y9o4MX+uT8Dvpds=;
 b=P3M2WAd2iKouWSI5bS+pAb2RtqVt3mJU0jBGPV6DLe3OYtL3dTV11+lOJjSWNLG1egINP
 N7QvKJ6AEQeithXEjCafW5BbhsGYXDQ24hXHh26ZsYxgqGnpJ/c49t6DQLyHYiMPRTqk1Ke
 BhM8z4luqoyD3e+/UZoAXNmsGoXqgtI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B70613CF1E4
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 13:46:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AA473C06DF
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:46:25 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BBEAF200AD9
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:46:24 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3e75e30d36so386984566b.1
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 04:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708433184; x=1709037984; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yVx7DX/2FrbKsobzOOTgUAFT/NpDqyuTCTvcyWtYRhk=;
 b=PY6PPJKt3GoGI0dAUnIPKkN2nkI6X6uQNoGpfrMu7VhnC6MvO1vdEnTUlJCwcWhUEG
 QZCl7m5GYXrkbFmAqGWTcDwvn2HoPzwkNhw+M9FvWelnAvvOufNFkBca8PLcdWKmotUm
 Wh/X/Jseiu0WTz74wQCdH/6pf/oIQO/VM++wcPBIDN0NJitLrDTGB6GBEz+aUHs9flsw
 2eTL+E9yJkCB0pe1ZP8X1ZvZ3+tTFcyA8jPioZObWkIp45CrpUfIVPmlynid7tM+ETIM
 FE5PYHDTdKOZApsxIbb5kjnINFiTjvN6T5kHUb1oVrYVIMze5TyTkY1IOte7+F8vzRdJ
 qq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708433184; x=1709037984;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yVx7DX/2FrbKsobzOOTgUAFT/NpDqyuTCTvcyWtYRhk=;
 b=KFIuAEPLNs2Ttm/8dLKvOgQL/rubqbwCKwaycAwqu8vk6Yy/5CYzKRZXMmJbhPLnDD
 4qwYj90JoS/fd587oNMsBjJhbFfbEGfbBrtZBabPrhtdMpp9PrRwbC1NeSxa6nk1fQ0+
 NLAjGxwYd0SfvLyN4LN5oFVkgOrts2yxq35Zv1DGglRK/0GzP5ubLaiuUWP5wtk3Ww7+
 mlVxjsMf1dmkjzvDEkcVwSmLRtjCq406SlYom5U4bnHj7ZpMDuz0bmt6e9bPATtNtqG6
 FfmgAsb4p6AX3BT3lw5bvU8t9IWUyZV1o9p3nmN6mbetGEFgLHQ49BN5388KUc6Kf812
 V67g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQWdC8bXQT2TP5OH3xEYKzMCP/dqE10DWYU6jwKEm9AAXKI69yVwGEme2YUvOvQBv52MJ6YYKd0LaIzQVLEiWwu2Q=
X-Gm-Message-State: AOJu0YxF6pdIv/pXdmqaSNJg1Jb0ls0I+UJccJdwHBs+FyxzanvucU5+
 E4qgxGctfMfbDeosTfte07TdapcfWYqBeC4D26Nby0qZfLm8XH+WUm1U6VmzqV7ylHibw6XKpgE
 9VEg=
X-Google-Smtp-Source: AGHT+IG+PlaCaC0MrCSazsW8UYbR3blQvRaobHfuSNKOdOvRD1Ec/r/WHYCrWcGXWaXUoQiDKYvxPQ==
X-Received: by 2002:a17:906:2844:b0:a3c:4b73:e3c9 with SMTP id
 s4-20020a170906284400b00a3c4b73e3c9mr13865165ejc.4.1708433184150; 
 Tue, 20 Feb 2024 04:46:24 -0800 (PST)
Received: from [10.232.133.61] ([88.128.88.10])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a1709065ad300b00a3e786d8729sm2428768ejs.168.2024.02.20.04.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:46:23 -0800 (PST)
Message-ID: <c4adc3c1-d3d8-47b5-999a-f2bfa4694f34@suse.com>
Date: Tue, 20 Feb 2024 13:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240220123743.7181-1-andrea.cervesato@suse.de>
In-Reply-To: <20240220123743.7181-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add more testcases in mkdir03
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

On 2/20/24 13:37, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> We add more test cases in mkdir03 in order to check that mkdir()
> can't overwrite certain types of files, such as simlinks, directories,
> pipes, devices, etc.
> These test cases come from symlink01 refactoring.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/syscalls                           |  2 +-
>   testcases/kernel/syscalls/mkdir/.gitignore |  1 +
>   testcases/kernel/syscalls/mkdir/mkdir03.c  | 10 ++++
>   testcases/kernel/syscalls/mkdir/mkdir10.c  | 57 ++++++++++++++++++++++
>   4 files changed, 69 insertions(+), 1 deletion(-)
>   create mode 100644 testcases/kernel/syscalls/mkdir/mkdir10.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ef90076e4..aabc37519 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -757,8 +757,8 @@ mkdir02 mkdir02
>   mkdir03 mkdir03
>   mkdir04 mkdir04
>   mkdir05 mkdir05
> -mkdir05A symlink01 -T mkdir05
>   mkdir09 mkdir09
> +mkdir10 mkdir10
Please remove the runtest files modifications before merge. It's an 
error due to --amend.
Thanks
>   
>   #mkdirat test cases
>   mkdirat01 mkdirat01
> diff --git a/testcases/kernel/syscalls/mkdir/.gitignore b/testcases/kernel/syscalls/mkdir/.gitignore
> index 880ff50c0..416fbbd7c 100644
> --- a/testcases/kernel/syscalls/mkdir/.gitignore
> +++ b/testcases/kernel/syscalls/mkdir/.gitignore
> @@ -3,3 +3,4 @@
>   /mkdir04
>   /mkdir05
>   /mkdir09
> +/mkdir10
> diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
> index d5141bb64..42dfdb9f0 100644
> --- a/testcases/kernel/syscalls/mkdir/mkdir03.c
> +++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
> @@ -19,6 +19,9 @@
>   #include "tst_test.h"
>   
>   #define TST_EEXIST	"tst_eexist"
> +#define TST_PIPE	"tst_pipe"
> +#define TST_FOLDER	"tst_folder"
> +#define TST_SYMLINK "tst_symlink"
>   #define TST_ENOENT	"tst_enoent/tst"
>   #define TST_ENOTDIR_FILE "tst_enotdir"
>   #define TST_ENOTDIR_DIR	"tst_enotdir/tst"
> @@ -41,6 +44,9 @@ static struct tcase {
>   	{NULL, EFAULT},
>   	{long_dir, ENAMETOOLONG},
>   	{TST_EEXIST, EEXIST},
> +	{TST_FOLDER, EEXIST},
> +	{TST_PIPE, EEXIST},
> +	{TST_SYMLINK, EEXIST},
>   	{TST_ENOENT, ENOENT},
>   	{TST_ENOTDIR_DIR, ENOTDIR},
>   	{loop_dir, ELOOP},
> @@ -70,7 +76,11 @@ static void verify_mkdir(unsigned int n)
>   static void setup(void)
>   {
>   	unsigned int i;
> +	char *tmpdir = tst_get_tmpdir();
>   
> +	SAFE_SYMLINK(tmpdir, TST_SYMLINK);
> +	SAFE_MKFIFO(TST_PIPE, 0777);
> +	SAFE_MKDIR(TST_FOLDER, 0777);
>   	SAFE_TOUCH(TST_EEXIST, MODE, NULL);
>   	SAFE_TOUCH(TST_ENOTDIR_FILE, MODE, NULL);
>   
> diff --git a/testcases/kernel/syscalls/mkdir/mkdir10.c b/testcases/kernel/syscalls/mkdir/mkdir10.c
> new file mode 100644
> index 000000000..87f419916
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mkdir/mkdir10.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that mkdir() can't overwrite certain generated files, such
> + * as symlinks, pipes, devices, folders, etc.
> + */
> +
> +#include "tst_test.h"
> +
> +#define FILE_FOLDER "myfolder"
> +#define FILE_MYFILE "myfile"
> +#define FILE_FIFO "mypipe"
> +#define FILE_SYMLINK "mylink"
> +#define FILE_DEVICE "/dev/null"
> +
> +struct tcase {
> +	char *file;
> +	char *msg;
> +};
> +
> +static struct tcase tcases[] = {
> +	{FILE_FOLDER,	"folder already exists"},
> +	{FILE_MYFILE,	"file already exists"},
> +	{FILE_FIFO,		"fifo already exists"},
> +	{FILE_SYMLINK,	"symlink already exists"},
> +	{FILE_DEVICE,	"device already exists"},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	TST_EXP_FAIL(mkdir(tc->file, 0777), EEXIST, "%s", tc->msg);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_SYMLINK(tst_get_tmpdir(), FILE_SYMLINK);
> +	SAFE_MKFIFO(FILE_FIFO, 0777);
> +	SAFE_MKDIR(FILE_FOLDER, 0777);
> +	SAFE_TOUCH(FILE_MYFILE, 0777, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
