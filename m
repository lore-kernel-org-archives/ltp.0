Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B201AC5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708691405; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=tov2eUhweMG+ACFFv62qQnPMQ1gUOfcy5q+9WOMAH/g=;
 b=aan9mmBdVHVpv81PaonaI6uTTvCI43RXJwk34/F3oVXH57L5KC+4lTCuF0JNv4AREKsSA
 B9EtocgfqbASF37A91RYHS6CXg90Ytt/LOYKUI9BEhchD9JmT8OAOa9r92020x8Nl6iQhn4
 HJbBVM1XjaL5wQf9whqsGM1BQ6YYcEU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F9193CF93E
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:30:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF7BE3CF5AB
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:29:42 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B65771401347
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:29:41 +0100 (CET)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5643eccad0bso1132220a12.1
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 04:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708691381; x=1709296181; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/o6j27JRJVJch9BU+cj87A77ZuojCFqZ4f8WSRR3Z5M=;
 b=M1X0eo1WGlUT+wbYv908ARp5Ch1bgeMo51BM8+9jodpGuRVMidNfu8jolNFDB7uNTb
 ZlkLjmOKbZ3qjosdO64yOOT2v+SHg5Yk5w6wSQmmZ52VnVRIE/tx9KeFarDehz1RuQtO
 yokr8cNXNaGf7LZ1pR+hI1WRykvztriGHxfiaSLwJN0YSBJicBaCf7E5ezP2hVCmhBpr
 w4ywGOBDzNosi4NG3gQQNlY8PHQC7/I93Vjh+akKbq3PbCmmi54s/u6pZmAkzzaaINfq
 kIVtenW52EJIpxfmVYFwdnqzKQ0uUk6u2gR6Pb9yHliGfWXXGHuJrtiLCNjZWWrObhfo
 N+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708691381; x=1709296181;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/o6j27JRJVJch9BU+cj87A77ZuojCFqZ4f8WSRR3Z5M=;
 b=qxRbjYGvwkgVzZoKm5yuWH2i+uoai1H/1PnbmxyqI+oRJXn+52sjSXlUIwJ9dSYtfp
 Mxq4J08c/QK0kDkcAF58SaozIGMTloi1sYR13kFC+I31+vdK67OV3haLkO9zB/9oxrCa
 D/MYGvB09jd8T9+IcJsGjuJ6zr3Dlib1BM+AsXFAB7rqGTV31PGmZlyzO/b9F65OEZiJ
 Y2sXmrMyzo7VhkLnztD0Jvrfd8qMrEuzj04guGuYTyv5kcdICIGB7tU91OZBiJf+QL3G
 d3R+jlQ5nPBDvFaiNnvv4vDImy/EswSJvhE0YwLFQXidep62owVThakYzblBxLoz5Tq6
 WGLg==
X-Gm-Message-State: AOJu0YyaZLiaN+SNx1Tcia4ZXsmkTVEiCwT6jbGmuEYaek3BqU4+Q0Fd
 T5+Q0dcyY348hFKLW3Z3B+RepSPR7bg3rUQmCT+GyZnYHbAqTop6zt9KJI7pBiQSHMKHiUTYb9e
 CEBk=
X-Google-Smtp-Source: AGHT+IG4uTh52V5tAqBqFkp/mKI8mA9Kw9T5lCIf0NHSoN6Qtwcb6YgvWdaqENTCChDxKnGRmzxyrg==
X-Received: by 2002:a17:906:dfe5:b0:a41:392d:e11c with SMTP id
 lc5-20020a170906dfe500b00a41392de11cmr108858ejc.26.1708691381140; 
 Fri, 23 Feb 2024 04:29:41 -0800 (PST)
Received: from [10.232.133.81] ([88.128.88.88])
 by smtp.gmail.com with ESMTPSA id
 vh9-20020a170907d38900b00a3f1ea776a1sm2889622ejc.94.2024.02.23.04.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 04:29:40 -0800 (PST)
Message-ID: <b42a273b-5f57-4cd0-8dd9-03b14da9b7fd@suse.com>
Date: Fri, 23 Feb 2024 13:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240222153648.2563-1-andrea.cervesato@suse.de>
 <20240222233614.GA1417479@pevik>
In-Reply-To: <20240222233614.GA1417479@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add stat04 test
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

On 2/23/24 00:36, Petr Vorel wrote:
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>> This test has been extracted from symlink01 test and it checks that
>> stat() executed on file provide the same information of symlink linking
>> to it.
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>> free() tmpdir
>> rename link_stat into link
>> rename path_stat into path
>>   runtest/smoketest                         |  2 +-
>>   runtest/syscalls                          |  4 +-
>>   testcases/kernel/syscalls/stat/.gitignore |  2 +
>>   testcases/kernel/syscalls/stat/stat04.c   | 50 +++++++++++++++++++++++
>>   4 files changed, 55 insertions(+), 3 deletions(-)
>>   create mode 100644 testcases/kernel/syscalls/stat/stat04.c
>> diff --git a/runtest/smoketest b/runtest/smoketest
>> index 83eebfe7b..5608417f9 100644
>> --- a/runtest/smoketest
>> +++ b/runtest/smoketest
>> @@ -8,7 +8,7 @@ time01 time01
>>   wait02 wait02
>>   write01 write01
>>   symlink01 symlink01
>> -stat04 symlink01 -T stat04
>> +stat04 stat04
>>   utime01A symlink01 -T utime01
>>   rename01A symlink01 -T rename01
>>   splice02 splice02 -s 20
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 7794f1465..ef90076e4 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1529,8 +1529,8 @@ stat02 stat02
>>   stat02_64 stat02_64
>>   stat03 stat03
>>   stat03_64 stat03_64
>> -stat04 symlink01 -T stat04
>> -stat04_64 symlink01 -T stat04_64
>> +stat04 stat04
>> +stat04_64 stat04_64
>>   statfs01 statfs01
>>   statfs01_64 statfs01_64
>> diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
>> index fa0a4ce9f..0a62dc6ee 100644
>> --- a/testcases/kernel/syscalls/stat/.gitignore
>> +++ b/testcases/kernel/syscalls/stat/.gitignore
>> @@ -4,3 +4,5 @@
>>   /stat02_64
>>   /stat03
>>   /stat03_64
>> +/stat04
>> +/stat04_64
>> diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
>> new file mode 100644
>> index 000000000..aebfacf5a
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/stat/stat04.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> + *    Author: David Fenner
>> + *    Copilot: Jon Hendrickson
> very nit:
>   * Author: David Fenner, Jon Hendrickson
>
>> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test checks that stat() executed on file provide the same information
>> + * of symlink linking to it.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include "tst_test.h"
>> +
>> +static void run(void)
>> +{
>> +	char *symname = "my_symlink0";
>> +	char *tmpdir = tst_get_tmpdir();
>> +
>> +	SAFE_SYMLINK(tmpdir, symname);
>> +
>> +	struct stat path;
>> +	struct stat link;
> nit: maybe define struct at the top of the function?
This is common in the first versions of C, but a good practice is to 
define variables as close as possible where they are used in order to 
improve readability.
>> +
>> +	TST_EXP_PASS(stat(tmpdir, &path));
>> +	free(tmpdir);
> If SAFE_SYMLINK() fails, free() will not happen. I wonder if we should bother
> (we'd have to set it NULL and add a cleanup function).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
>> +
>> +	TST_EXP_PASS(stat(symname, &link));
>> +
>> +	TST_EXP_EQ_LI(path.st_dev, link.st_dev);
>> +	TST_EXP_EQ_LI(path.st_mode, link.st_mode);
>> +	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);
>> +	TST_EXP_EQ_LI(path.st_uid, link.st_uid);
>> +	TST_EXP_EQ_LI(path.st_gid, link.st_gid);
>> +	TST_EXP_EQ_LI(path.st_size, link.st_size);
>> +	TST_EXP_EQ_LI(path.st_atime, link.st_atime);
>> +	TST_EXP_EQ_LI(path.st_mtime, link.st_mtime);
>> +	TST_EXP_EQ_LI(path.st_ctime, link.st_ctime);
>> +
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.needs_tmpdir = 1,
>> +};

According to Cyril suggestions we are probably done with this patch so 
it can be merged. Isn't it?

Thanks,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
