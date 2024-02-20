Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15526C48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708433642; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=xufIF/eDiYgf1jLaDU1PLIHjrdL9FZXPUyiFIQnHTuw=;
 b=eVPRxrFrY/cgOlN5sNcgPDe72E9T///UiUfYrCmgeDj5xKdjLYUZuh6hXWuf2KXamEO9S
 BkOmg9JA112gLXApELzGJrv6VKNsnAHI7oC6yO791V95u7ku4M9IUzBszpKeuzsU31tTPEL
 nlgpqDbcanEACJBUyVryXVa2a1yR5p0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78AD43CF1F2
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 13:54:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3630B3C06DF
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:53:40 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0560C10124A8
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:53:38 +0100 (CET)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3c1a6c10bbso696336666b.3
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 04:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708433618; x=1709038418; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vMTxFFoqdG4Zd0qEjrciOp4M5319KbeRghq+NH5Wd2E=;
 b=AMxqIMLOJ3nI+hB3d8e9BMUT3gVlWg73vlM/4YhoNmB+J6ftesMPUKY2Hzj9FwlT6G
 lt0p46SGi+NcgAnJzal6ehglYsGwn3ibVG0mw0+bRBYw5zVyNxFKa4R/2eC0SsETsfOF
 883aX74+f1PEV7H0VumlXQ5sLE2kULJio66wlhCPeUmKvNAWW9eVg9QRIpVBVKrqEmlq
 sfSqP4ZaHPhUECWtTlPW6VFGIMD0BpsMhk8KqImSxgASq2CGhSbTKbhV3vqy4dZRg23C
 f/zvvhdnQhNcV5+1fugEFDVeToLxItfyWVPm/EdI7UQRVCP/47ioa5GgnR4LYAxrZMn9
 4nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708433618; x=1709038418;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vMTxFFoqdG4Zd0qEjrciOp4M5319KbeRghq+NH5Wd2E=;
 b=DO5CSv3pCkL2j43L6hBreqI4CTKGRdGRXwCbVauiu2iZbxyBGgSIZJsDpbfUqt64Xu
 1hQosnmspGiOPFpYA/8yZGMuiZN116zMbRy8S6dt2t++2o1b7zyPhlYnSj65t2czRTTH
 I+RY4SeGnJWN/nkw6HKk6E7lfuRyLT940EVZDgYXDLczIZ2AgYaijDW8NILE76FnAkYO
 R703osTk5YB1txEvxHFDsN3ooBbWeKYOK0HmpywBgzUs8nBX3j7SvH3zd6APtIgs3feF
 Rf0FZA8eGcAzt1ni0jvxs1JhzyU6aVGqbChuO6nuzuNlikp59ncZ11zjz9u8nijmcZ8c
 W7kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSf/MEnky1yrl+5eXZd9f38cxWnJfcTWK3zZCbQ6iYBboWFoyB4aBnh1EFJFtjqXnDgNh4cbkhkMvYzQ3wZnZTFi4=
X-Gm-Message-State: AOJu0Yz2AMIBizmNb9K8vL9iaIxib87Cvhsm+70jDY+girulUjCN53nr
 ByC1hAIWfm+ypkstFvDJqhsMleKUPnmuI3QibZ1N3g0sNiab1AJWlCm91PSTUABCBSx8w9JWtsC
 i00E=
X-Google-Smtp-Source: AGHT+IF4JHRCW0LvqnTZKw9RgwqO4FMufTVUPE70lCeb8QeDVvLkmGOOsQb3gwJgA5H7apy1ZYeZOA==
X-Received: by 2002:a17:906:8c4:b0:a3d:b6c2:fc58 with SMTP id
 o4-20020a17090608c400b00a3db6c2fc58mr8747736eje.2.1708433618417; 
 Tue, 20 Feb 2024 04:53:38 -0800 (PST)
Received: from [10.232.133.61] ([88.128.88.10])
 by smtp.gmail.com with ESMTPSA id
 rg8-20020a1709076b8800b00a3e28471fa4sm3434738ejc.59.2024.02.20.04.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:53:38 -0800 (PST)
Message-ID: <b19a0003-5d5e-410b-ad23-3c0a982d2222@suse.com>
Date: Tue, 20 Feb 2024 13:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240119090713.13753-1-andrea.cervesato@suse.de>
In-Reply-To: <20240119090713.13753-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add link01 test
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
please ignore this patch since the test case is covered by link02 already.

Andrea

On 1/19/24 10:07, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> This test verifies that link() is working correctly on symlink()
> generated files, renaming the symbolic link and checking that
> stat() information are preserved.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/syscalls                        |  2 +-
>   testcases/kernel/syscalls/link/link01.c | 47 +++++++++++++++++++++++++
>   2 files changed, 48 insertions(+), 1 deletion(-)
>   create mode 100644 testcases/kernel/syscalls/link/link01.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 68460de0b..00a0dd87e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -692,7 +692,7 @@ lchown03_16 lchown03_16
>   lgetxattr01 lgetxattr01
>   lgetxattr02 lgetxattr02
>   
> -link01 symlink01 -T link01
> +link01 link01
>   link02 link02
>   link04 link04
>   link05 link05
> diff --git a/testcases/kernel/syscalls/link/link01.c b/testcases/kernel/syscalls/link/link01.c
> new file mode 100644
> index 000000000..e1cda7054
> --- /dev/null
> +++ b/testcases/kernel/syscalls/link/link01.c
> @@ -0,0 +1,47 @@
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
> + * This test verifies that link() is working correctly on symlink()
> + * generated files, renaming the symbolic link and checking that
> + * stat() information are preserved.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	struct stat oldlink_stat;
> +	struct stat newlink_stat;
> +	char *symname0 = "my_symlink0";
> +	char *symname1 = "my_symlink1";
> +
> +	SAFE_SYMLINK(tst_get_tmpdir(), symname0);
> +	SAFE_STAT(symname0, &oldlink_stat);
> +
> +	SAFE_LINK(symname0, symname1);
> +	SAFE_STAT(symname1, &newlink_stat);
> +
> +	TST_EXP_EQ_LI(oldlink_stat.st_ino, newlink_stat.st_ino);
> +	TST_EXP_EQ_LI(oldlink_stat.st_nlink, newlink_stat.st_nlink);
> +
> +	if (TST_RET == -1) {
> +		SAFE_UNLINK(symname0);
> +		remove(symname1);
> +	} else {
> +		SAFE_UNLINK(symname1);
> +		remove(symname0);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
