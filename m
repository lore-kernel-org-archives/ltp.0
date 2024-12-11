Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CE1E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 09:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733910802; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=jRsNgeMD/vpm4kjFa+vf4BbXCyzqyfsvTcuowbXsRkw=;
 b=mQs6mU9oMMh1+5luB8mTs0tR7hSptkFYiXHBSfXjlVEBEPHNTGll0j47pVJh2MCX8y1Ys
 ACXQyRUVrlVFnSFev23l92JrDF/kJZuKPGGMRo8PFpXLHNdyWOpOW6QCKTCdVEC/PbqBSBh
 66dEpiA3XIdbeW38wR7R6CDNpNnrlyM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4E2B3E7D10
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:53:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6343E7D06
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:52:46 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4ACC31A05C9A
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:52:46 +0100 (CET)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so10611372a12.2
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733910765; x=1734515565; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9mUe88YLYUZDOy57rQiATgNw+5bV7pP2q+cOpeIZP5Y=;
 b=ePkx4BkAAYlQjDEzK/n5A4vlOVNgV1IhvQ8kovi4S0fNIVkLK8sWR32HwPRhYC4vXe
 +i2MUkKGEZsfJjXq+zv55uD6UL/2NQt6ZMFgXLlD9PHwmOI1bjnbjLJ3t4GIAB78K/ZY
 cdrHVk+54LhFcEeRk/asM9Ltq+ZBz/DFPq57SMlMdiC8usDASUvgaUIRHHSoEwor9lrU
 Bhfm2OMFsS8hvTBKhOAu2OIgR8U1T1XWFvjtTiBvzF112imrnW1//gW7HjK89X2HjBRx
 ocpsUp7CrZ8OLH9gs56Kqew3NkZodfAgjf1Z+te6LdswFVloE0Aq8xC6tbxFge1bxEw+
 rmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733910765; x=1734515565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9mUe88YLYUZDOy57rQiATgNw+5bV7pP2q+cOpeIZP5Y=;
 b=aWB0m+UM5ELVvwLwq//9vI/oS//M3cvNCqyMK95srpJrgVGAbRJgVIbLp+ZyukdXLY
 nv5yaXbMZAqLAxjTr6VTZDExPSxEE+6rfSY7BBQXLHAd3uYUcPffl/4I3rG6uAbec3ty
 rc3NhR6jGC1htC8UCBwgnBkD3d2AjKazBx2BEr5WhZ6ccGoKXZ7L4iMdv7jtySgOvXjY
 H7NmB02apxkqC6oLeexoiw8iCaEIgghQuA2/1cS+PIp2HhvhVad8pPin4r/7/xBQEx7Z
 +NLu3eXVAADfnF56P2U6YB309HduYxoW4LRmghQ8Y0rubDupom994EZz+JauMQ0QgYHK
 6GBw==
X-Gm-Message-State: AOJu0Yy0qGXjv+Zj9ZfXYTVsnCPtIlpNsskarEf0GHaZ5dCEBqjgWAZi
 iUNTEdFfLp19DBZiVcoY4UZOAu3rPoF3f7KTI0rh+wgvoyBKevuj/mosTCjsPyMCQNM7lPBa+Vd
 XG/0=
X-Gm-Gg: ASbGncsRCvcB1AJ6Ri5KYgmYLKPA069YkxcrGj3UXU5/pO95CIfjBPIJ5hK3XvLaqWY
 mq97twOb1xJGYmbRjoUv13RqYJQZ6cHVJ0b3TCVkEYkxQQpmmobiUQEvK++Tny58fu/7tz4V9y+
 XxkCF6/erXrpn6zvbB2rVbWonLqgcRo3Yxt6nfJpTB9ygzgCezwd3XOlcy2+2LrWl31gLSOvI4P
 f3/EeV5DxI3ZCyJim97hZSKZlYlsdbLG6J0PszGt16wGkr9+tr+mni7IH6mRt4LtQ==
X-Google-Smtp-Source: AGHT+IHhMF9o65OpLfZXsyoEAbi+nWotNgwoCqXH9/rpTPMieSDGzkN48M7q8d08FnvMgwf571JALA==
X-Received: by 2002:a17:907:920d:b0:aa6:85a4:31f8 with SMTP id
 a640c23a62f3a-aa6b11f0745mr168573766b.33.1733910765283; 
 Wed, 11 Dec 2024 01:52:45 -0800 (PST)
Received: from [192.168.42.37] ([193.86.92.181])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149a25cc5sm8817645a12.7.2024.12.11.01.52.44
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 01:52:45 -0800 (PST)
Message-ID: <948a0308-d9ec-425e-9da1-40c872bc33e6@suse.com>
Date: Wed, 11 Dec 2024 10:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
 <20241203-madvise_guard_install-v1-2-c0485abbfc73@suse.com>
 <20241211003048.GG386508@pevik>
 <76fb3af9-0a29-4b3b-9c1f-d66bedabbd73@lucifer.local>
Content-Language: en-US
In-Reply-To: <76fb3af9-0a29-4b3b-9c1f-d66bedabbd73@lucifer.local>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add madvise12 test
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

Thanks for the review. Pushed with suggested changes.

Andrea

On 12/11/24 10:29, Lorenzo Stoakes via ltp wrote:
> On Wed, Dec 11, 2024 at 01:30:48AM +0100, Petr Vorel wrote:
>> Hi Andrea,
>>
>> [ I dared to Cc Lorenzo, the author of the kernel implementation ]
> I'm not that scary am I? :)))
>
> Feel free to cc- me on anything relating to this even if obviously in the
> LTP project happy to be included! :)
>
>>> Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is
>>> trying to access memory advised with it.
>> Test LGTM, thanks for covering a new kernel feature.
> All good, looks fine to me, though might be worth expanding over time, we
> have some self tests in the kernel for this, see
> tools/testing/selftests/mm/guard-pages.c.
>
> But it's nice to have a basic LTP regression test to assert the fundamental
> thing is working as it should, and also nice that you implement it from
> your perspective rather than mine, where I am obviously rather influenced
> by implementation details.
>
> Also note I submitted man pages for the change, you can pull it from [0]
> and view it via:
>
> $ man --manpath=. 2 madvise
>
> [0]:git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
>
> Hopefully these will get distributed around soon!
>
> Thanks for doing this for my feature, much appreciated overall!
>
> Cheers, Lorenzo
>
>> Closes: https://github.com/linux-test-project/ltp/issues/1210
>>
>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>> ---
>>>   runtest/syscalls                              |   1 +
>>>   testcases/kernel/syscalls/madvise/.gitignore  |   1 +
>>>   testcases/kernel/syscalls/madvise/madvise12.c | 102 ++++++++++++++++++++++++++
>>>   3 files changed, 104 insertions(+)
>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>> index 5fd62617df1a116b1d94c57ff30f74693320a2ab..ded035ee82d0e97c67cc1e7c487b010634b2d1a0 100644
>>> --- a/runtest/syscalls
>>> +++ b/runtest/syscalls
>>> @@ -1000,6 +1000,7 @@ madvise08 madvise08
>>>   madvise09 madvise09
>>>   madvise10 madvise10
>>>   madvise11 madvise11
>>> +madvise12 madvise12
>>>   newuname01 newuname01
>>> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
>>> index 722ac3c34306bac414313f1ce36ca98d715cd04c..758e601a9c4e7682a925f16184d14f2357009bc2 100644
>>> --- a/testcases/kernel/syscalls/madvise/.gitignore
>>> +++ b/testcases/kernel/syscalls/madvise/.gitignore
>>> @@ -8,3 +8,4 @@
>>>   /madvise09
>>>   /madvise10
>>>   /madvise11
>>> +/madvise12
>>> diff --git a/testcases/kernel/syscalls/madvise/madvise12.c b/testcases/kernel/syscalls/madvise/madvise12.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..2bdf843f016a7c9d175a31b76ae805d63c4cbc80
>>> --- /dev/null
>>> +++ b/testcases/kernel/syscalls/madvise/madvise12.c
>>> @@ -0,0 +1,102 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (c) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
>>> + */
>>> +
>>> +/*\
>>> + * [Description]
>>> + *
>>> + * Verify that MADV_GUARD_INSTALL is causing SIGSEGV when someone is accessing
>>> + * memory advised with it.
>> Maybe add:
>> 	* This is a test for feature implemented in
>> 	* 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
>>
>> The rest LGTM.
>>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>
>> Kind regards,
>> Petr
>>
>>> + *
>>> + * [Algorithm]
>>> + *
>>> + * - allocate a certain amount of memory
>>> + * - advise memory with MADV_GUARD_INSTALL
>>> + * - access to memory from within a child and verify it gets killed by SIGSEGV
>>> + * - release memory with MADV_GUARD_REMOVE
>>> + * - verify that memory has not been modified before child got killed
>>> + * - modify memory within a new child
>>> + * - verify that memory is accessable and child was not killed by SIGSEGV
>>> + */
>>> +
>>> +#include "tst_test.h"
>>> +#include "lapi/mmap.h"
>>> +
>>> +#define MAP_SIZE (8 * TST_KB)
>>> +
>>> +static char *addr;
>>> +
>>> +static void run(void)
>>> +{
>>> +	pid_t pid;
>>> +	int status;
>>> +
>>> +	memset(addr, 0, MAP_SIZE);
>>> +
>>> +	TST_EXP_PASS(madvise(addr, MAP_SIZE, MADV_GUARD_INSTALL));
>>> +
>>> +	pid = SAFE_FORK();
>>> +	if (!pid) {
>>> +		tst_res(TINFO, "Modifying memory content");
>>> +
>>> +		memset(addr, 'a', MAP_SIZE);
>>> +		exit(0);
>>> +	}
>>> +
>>> +	SAFE_WAITPID(pid, &status, 0);
>>> +
>>> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
>>> +		tst_res(TPASS, "Child ended by SIGSEGV as expected");
>>> +	else
>>> +		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
>>> +
>>> +	TST_EXP_PASS(madvise(addr, MAP_SIZE, MADV_GUARD_REMOVE));
>>> +
>>> +	for (int i = 0; i < MAP_SIZE; i++) {
>>> +		if (addr[i] == 'a') {
>>> +			tst_res(TFAIL, "Memory content has been modified");
>>> +			return;
>>> +		}
>>> +	}
>>> +
>>> +	tst_res(TPASS, "Memory content didn't change");
>>> +
>>> +	pid = SAFE_FORK();
>>> +	if (!pid) {
>>> +		tst_res(TINFO, "Modifying memory content");
>>> +
>>> +		memset(addr, 'b', MAP_SIZE);
>>> +		exit(0);
>>> +	}
>>> +
>>> +	SAFE_WAITPID(pid, &status, 0);
>>> +
>>> +	if (!WIFSIGNALED(status))
>>> +		tst_res(TPASS, "Child ended without being signaled");
>>> +	else
>>> +		tst_res(TFAIL, "Child ended with %s", tst_strstatus(status));
>>> +}
>>> +
>>> +static void setup(void)
>>> +{
>>> +	addr = SAFE_MMAP(NULL, MAP_SIZE,
>>> +			PROT_READ | PROT_WRITE,
>>> +			MAP_PRIVATE | MAP_ANONYMOUS,
>>> +			-1, 0);
>>> +}
>>> +
>>> +static void cleanup(void)
>>> +{
>>> +	if (addr)
>>> +		SAFE_MUNMAP(addr, MAP_SIZE);
>>> +}
>>> +
>>> +static struct tst_test test = {
>>> +	.test_all = run,
>>> +	.setup = setup,
>>> +	.cleanup = cleanup,
>>> +	.needs_root = 1,
>>> +	.forks_child = 1,
>>> +	.min_kver = "6.13",
>>> +};
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
