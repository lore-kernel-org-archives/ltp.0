Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29850E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 08:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736326462; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=eNHTFcdfDXcvMBjAwW93+q2PRMNr2nW9t9+jj9+f0V0=;
 b=VUtGi3+cmh9Pxs6z36btTpOZBdbDwQ6mhKSRsj6W7wxQPzmmUyT/o8/6vJOE/9/dym/qw
 p38Dt8/gp6uaWwgcBaLGjcnyJO53JS+mnYLZWpXm071LZbVrs2BX7kd8TvvZpcE44AGIq3k
 /dYtvsCjmgqhke1eARe6lkx7YmWedm0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C2443C1B3F
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 09:54:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A34553C194E
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 09:54:00 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C89BD6281C2
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 09:53:59 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so113265675e9.2
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 00:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736326439; x=1736931239; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N64cADVzLrmCfs2rHOGuQqBgUmrbOq530DmiFtPkxOw=;
 b=U+n6DsdXKGp69pcn7BrtCKtlLiG2Rai/M7/xoHXK1Kj+wnwlM0TUhvJywL20f/HYpF
 7h3um+vhLTXMD+lRAbNSTkKGaw4GRLTV4rCjb3TsPf1MlA7zkEN2Gu7o1P1nZyJtqXAw
 kwS6vmJirVuIbh4iAPXp+tWLG3XwVykM8cCF2GoZ2xjlqMCJ/p2mT5iEsPQGCVzZx5rp
 Da9r9nKOIqRGvQE9/eYsJ0a0xvL9CcUw0FKCdNfq3fiaMKS7p1J5dROJ0YD6AoGuimvO
 BYTRE2vTovB/I7kXq059KOsjXsF9gKl6yJFB4K+906FvjzC2XMesqHAYRKQomG8hDlH0
 4m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736326439; x=1736931239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N64cADVzLrmCfs2rHOGuQqBgUmrbOq530DmiFtPkxOw=;
 b=dzRkWKK/FPtw+MuJU5f2EzhOyagQ1oosMFLEMd1rqzbK0CMM48J6goneOqs5Xk3Dyw
 f5yiwfsfOzVs37WG323o26BvWt51NIiSkEGikj7aUVlWK4JdFxquaCL8H/J0aCKgaowF
 YBs8t1OS15RzQBLWnEEFi3SY80FX79wv9Y3bzphAAAmCUr92b7KIwe5KvYfsjLv8fuyc
 /AqeUmnDWctZrsDc1nchjAQZFlKbVVERy027O06TMhu+bw5YxOpLWtvWvvN5cU9CgKYz
 CcankgCfvNAOJ6AnHsbCQcBjV0xxU7WU3E7VhDXTQ70TeoQBokx7/nTx7qXJodyA1Lxv
 p2XA==
X-Gm-Message-State: AOJu0Yw+LKpG4cXH9gdl+euLvZE4qxAcaPU2tJtAyxGBwJD+It/szPkO
 Ssu295V0+xPcsnqrE+xHdtPa+5jXtgCIRytb2yMNuevjQ4ffRX9d9gZsxCNuEQk=
X-Gm-Gg: ASbGncv51DU7qvqgc42aA/LnwIK6cIbrz0NAEymmzpUU7sl5mm3wYGIF/UV3t0M7VZ2
 jxOdaKLLaIgvuS8MquT+1/ZRw+XZRqtQkfEc9eHgYmL3d8HkoH5JhLN+KWiI7yLngZimUATkGUZ
 IE46smVmxnyglMiGIEZKWxGyRyxs/ZEow25pIUFV3zAPXhyGzCi+I6a77FjViy+PqSItFLk/tjz
 +wrL8K0HTGsQzVEJESBRDRXvBc0rkqMv1yP7GJ4GYndYX6WZHEoMX5R7b03SutU69/rjnXDQA/k
 mVUez+K4N1na4c33w3AiQdxMqOnEuWauOr5rNKbQUEgKmaBk5j2b5G24cVOyi8QAi2qbjqNrX34
 pI9Uu4Q5NQ3g+mMDQrmI=
X-Google-Smtp-Source: AGHT+IHUtvfrnXGm5wAVn9uD41E8f4RODfIHSQ8nXG0wimOlbukc/B3KmlOCPoraNISSMbFN5PVjLg==
X-Received: by 2002:a05:600c:5122:b0:432:d797:404a with SMTP id
 5b1f17b1804b1-436e26ddee4mr12006895e9.22.1736326439210; 
 Wed, 08 Jan 2025 00:53:59 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c848a47sm51765354f8f.62.2025.01.08.00.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 00:53:58 -0800 (PST)
Message-ID: <6ced38de-4c36-443d-bf29-b3b404981561@suse.com>
Date: Wed, 8 Jan 2025 09:53:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-2-e293a8d99cf6@suse.com> <20241218185508.GA77804@pevik>
Content-Language: en-US
In-Reply-To: <20241218185508.GA77804@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] Add lsm_get_self_attr01 test
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
Cc: Casey Schaufler <casey@schaufler-ca.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 12/18/24 19:55, Petr Vorel wrote:
> Hi Andrea,
>
> [ Cc Casey, the author of the syscalls and kselftest tests ]
>
>> Verify that lsm_get_self_attr syscall is raising errors when invalid
>> data is provided.
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   runtest/syscalls                                   |  2 +
>>   testcases/kernel/syscalls/lsm/Makefile             |  7 ++
>>   testcases/kernel/syscalls/lsm/lsm_common.h         | 57 +++++++++++++++
>>   .../kernel/syscalls/lsm/lsm_get_self_attr01.c      | 81 ++++++++++++++++++++++
> You miss the change in .gitignore. You added it in the next commit. Could you
> please before merge rebase, so that it's added for lsm_get_self_attr01 in this
> commit? (in case of some revert).
+1
>>   4 files changed, 147 insertions(+)
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 5fd62617df1a116b1d94c57ff30f74693320a2ab..d59faf08a3f36b5f64d56952f69641191c70bf33 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -756,6 +756,8 @@ lseek02 lseek02
>>   lseek07 lseek07
>>   lseek11 lseek11
>> +lsm_get_self_attr01 lsm_get_self_attr01
>> +
>>   lstat01 lstat01
>>   lstat01_64 lstat01_64
>>   lstat02 lstat02
>> diff --git a/testcases/kernel/syscalls/lsm/Makefile b/testcases/kernel/syscalls/lsm/Makefile
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..8cf1b9024d8bdebe72408c90fef4b8b84ce9dc4b
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/lsm/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/syscalls/lsm/lsm_common.h b/testcases/kernel/syscalls/lsm/lsm_common.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..33ddda13720d843907404662e6c6dc72ffac3233
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/lsm/lsm_common.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +#ifndef LSM_GET_SELF_ATTR_H
>> +#define LSM_GET_SELF_ATTR_H
>> +
>> +#include "tst_test.h"
>> +#include "lapi/lsm.h"
>> +
>> +static inline struct lsm_ctx *next_ctx(struct lsm_ctx *tctx)
>> +{
>> +	return (struct lsm_ctx *)((void *)tctx + sizeof(*tctx) + tctx->ctx_len);
>> +}
>> +
>> +static inline void read_proc_attr(const char *attr, char *val, const size_t size)
>> +{
>> +	int fd;
>> +	char *ptr;
>> +	char path[BUFSIZ];
>> +
>> +	memset(val, 0, size);
>> +	memset(path, 0, BUFSIZ);
>> +
>> +	snprintf(path, BUFSIZ, "/proc/self/attr/%s", attr);
>> +
>> +	tst_res(TINFO, "Reading %s", path);
>> +
>> +	fd = SAFE_OPEN(path, O_RDONLY);
>> +
>> +	if (read(fd, val, size) > 0) {
>> +		ptr = strchr(val, '\n');
>> +		if (ptr)
>> +			*ptr = '\0';
>> +	}
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static inline int verify_enabled_lsm(const char *name)
>> +{
>> +	int fd;
>> +	char data[BUFSIZ];
>> +
>> +	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
>> +	SAFE_READ(0, fd, data, BUFSIZ);
>> +	SAFE_CLOSE(fd);
>> +
>> +	if (!strstr(data, name)) {
>> +		tst_res(TINFO, "%s is running", name);
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +#endif
>> diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..2317941af1b73240368820e6a51591e7c18cc140
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr01.c
>> @@ -0,0 +1,81 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that lsm_get_self_attr syscall is raising errors when invalid data is
>> + * provided.
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/lsm.h"
>> +
>> +static struct lsm_ctx *ctx;
>> +static uint32_t ctx_size;
>> +static uint32_t ctx_size_small;
>> +
>> +static struct tcase {
>> +	uint32_t attr;
> .attr = LSM_ATTR_CURRENT is the same for all 4 testcases.
> Can you please remove it from the test struct and use it directly?
I will keep it in order to test EOPNOTSUPP for overset attr flag, I will 
add this test case in the next version of the patchset.
>
>> +	struct lsm_ctx **ctx;
> The same applies to ctx.
>
> Also, kselftest test tools/testing/selftests/lsm/lsm_get_self_attr_test.c is
This is tested by lsm_get_self_attr02.
> testing also for ctx being NULL. Then it would make sense to use it.
> You would then need to use verify_enabled_lsm(), which you added in this commit
> but not use it (e.g. lsm_get_self_attr_test.c in kselftest checks for values
> when no lsm is set). Obviously you would have to store also errno for the case
> when lsm is not stored.
>
> On some Tumbleweed VM (6.10.0-rc7) I have the default:
>
> $ cat /sys/kernel/security/lsm
> lockdown,capability,landlock,yama,apparmor,bpf,ima,evm
>
> When I boot with lsm= kernel parameter, I get:
>
> $ cat /sys/kernel/security/lsm
> lockdown,capability,ima,evm
>
> And with that test fails:
>
> # ./lsm_get_self_attr01
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_test.c:1893: TINFO: LTP version: 20240930-146-gccd20cd77
> tst_test.c:1897: TINFO: Tested kernel: 6.10.0-rc7-3.g92abc10-default #1 SMP PREEMPT_DYNAMIC Wed Jul 10 14:15:11 UTC 2024 (92abc10) x86_64
> tst_test.c:1728: TINFO: Timeout per run is 0h 00m 30s
> lsm_get_self_attr01.c:67: TPASS: size is NULL : EINVAL (22)
> lsm_get_self_attr01.c:67: TPASS: flags is invalid : EINVAL (22)
> lsm_get_self_attr01.c:67: TFAIL: size is too smal expected E2BIG: EOPNOTSUPP (95)
> lsm_get_self_attr01.c:67: TPASS: flags force to use ctx attributes : EINVAL (22)
>
> => I would vote for having 2 variants to use EOPNOTSUPP or at least check with
> verify_enabled_lsm() and TCONF. Otherwise sooner or later somebody report a bug
> in the test.

Yeah, probably this is the best approach. I will add a helper checking 
for current LSM and eventually TCONF if they are not present in 
combination with LSM_ATTR_CURRENT.

Andrea



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
