Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842A8C25B75
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 07:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717142015; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=P2s/Hxp3GrPCrZK94x5BECjJhKFQtsDvnMzD4xI23LA=;
 b=qBgOK6LlruetZOkgc2DP8UBOynRyjrD0zseGMQ8nW43K7YB2Jtv4zYMOv0IB0DOTRS0Oq
 IrjJnfznX7nGB+8qpvLsDmwF6gevrXd3IMledprU1ccLU5yojQEHK4PLCNAdpyQ83XJnxox
 OUE7upRBlFF5Em63kBGIMpI7gq75WO8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 973343D0756
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 09:53:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC9A53D074A
 for <ltp@lists.linux.it>; Fri, 31 May 2024 09:53:13 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F25E4600EC7
 for <ltp@lists.linux.it>; Fri, 31 May 2024 09:53:12 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b7c82e39eso1798211e87.1
 for <ltp@lists.linux.it>; Fri, 31 May 2024 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717141992; x=1717746792; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dWzYcZRG0h63NCcA9/zvvrMZCVAexiwi7EbTgOY6M6Y=;
 b=FneK+T1NRGM3LcbwMGyo+5ZwspxoE1fqxXnMigJPjOxOA4J0bHWTOTd4cQIx8GNHkR
 tZMe8WsGxQa/hchXVY+2N2fdGzfQDnhcyuw91w6PdinqpCvBHGR5sWuDGyNHDWnOfNlD
 tgSrCKbHDyiU9mxYhHbbRxpXvHMqX1LOxte8v8u0JhnyEYhWqsISdVc8o+C68Pfw2a3S
 UNgaUAhPycvm5scqKv1/SCUFBHAOv2ojC5ki7xy1/hixoC1LFjYEa+0tyesvpXt+Kenw
 FRT2N6tU9xU8yY7iOdN/gW1l8He6cZ7/EczZvlt9UoqP7V9IqfmAxtTsAUUzi4Fdwrna
 psCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717141992; x=1717746792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWzYcZRG0h63NCcA9/zvvrMZCVAexiwi7EbTgOY6M6Y=;
 b=W+fka2Y+Rz5jxyzbqSjH8NYgvzQk0fCHyrXpBaucTnQvpNUh/Xhv606ekbOhcAvjDG
 zras0MEO0dwsaGrVIymprhzy03W8nwam/9Wptn+Om5e62oOaz/j5vWbVmtIaWW6k3L7w
 59YiR4GQDmzVfI2VXW3uWwOTLb6nIv1DGdvgj0dbRajyUcO1pquOccUoq8I3AjAz1CEI
 VPldC3IWJ1APtiPeGZIJ5m9VBKXf7Ti1pVOBcvjgX1G2IEWn2f+mjPfXmYBzlgOyBNHw
 H4lvHIkz/c7EBFNOR4YcOzexsMkoPklN6NUNHBHpbVgtyS+rNJ1VIHcZF39Knb3WHwl0
 7g6g==
X-Gm-Message-State: AOJu0Yxr7bWVT/e6DbyOnCtB+So+YITOBgjjUi81p4pFk/O9cMG+8Me+
 48Xm4l4tUlyu38jj24dqtArVQBSYyUMnT/1chGJriGPf31zt/6b1mL4z4lYmpao=
X-Google-Smtp-Source: AGHT+IEkMRt8r2Y58X6GQPyUOJWsgbgLSwlMd3Qasia+LXXpDX5FE6BqYJzGpAdThTgWpFE2AQvRqg==
X-Received: by 2002:a05:6512:2508:b0:51b:1e76:4ea9 with SMTP id
 2adb3069b0e04-52b895608d9mr932973e87.4.1717141992064; 
 Fri, 31 May 2024 00:53:12 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.46.100])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bbed6bsm692708a12.40.2024.05.31.00.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:53:11 -0700 (PDT)
Message-ID: <82ac2455-ab1c-4bdf-b4e3-5ae56dfb9871@suse.com>
Date: Fri, 31 May 2024 09:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-3-fa96f07d0fca@suse.com> <ZlhacuOD8hYVLYS6@yuki>
Content-Language: en-US
In-Reply-To: <ZlhacuOD8hYVLYS6@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add ioctl_ficlone03 test
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

Hi,

On 5/30/24 12:52, Cyril Hrubis wrote:
> Hi!
>>   inotify_init1_01 inotify_init1_01
>>   inotify_init1_02 inotify_init1_02
>> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
>> index 3d25fdfb2..d0b470714 100644
>> --- a/testcases/kernel/syscalls/ioctl/.gitignore
>> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
>> @@ -24,3 +24,4 @@
>>   /ioctl_sg01
>>   /ioctl_ficlone01
>>   /ioctl_ficlone02
>> +/ioctl_ficlone03
>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
>> new file mode 100644
>> index 000000000..c6f9806a3
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that ioctl() FICLONE feature correctly raises exceptions
>> + * when it's supposed to.
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/fs.h"
>> +
>> +#define MNTPOINT "mnt"
>> +
>> +static int invalid_fd = -1;
>> +static int rw_file = -1;
>> +static int ro_file = -1;
>> +static int wo_file = -1;
>> +static int dir_fd = -1;
>> +static int immut_fd = -1;
>> +static int mnt_file = -1;
>> +
>> +static struct tcase {
>> +	int *src_fd;
>> +	int *dst_fd;
>> +	int errno_exp;
>> +	char *msg;
>> +} tcases[] = {
>> +	{&invalid_fd, &rw_file, EBADF, "invalid source"},
>> +	{&rw_file, &invalid_fd, EBADF, "invalid destination"},
> Can we move these invalid_fd tests into a separate test and use tst_fd
> to loop over all kinds of invalid input and output file descriptors?
>
I don't know if it's worth to loop over all possible cases. Each one of 
them has a specific test case.
Also, invalid_fd test cases would look so simple that it makes more 
sense to keep it here.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
