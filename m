Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15652C54EE9
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 09:08:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 048FA3CA8CA
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 11:08:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D20FD3CA6F1
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:07:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C97BD200C2E
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 11:07:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D048E20469;
 Fri,  2 Sep 2022 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662109665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lqJMJics7jOUun4axohwuEOUCVE+XamfFRxAzRSVcFg=;
 b=F3L5bN5htav6xWaSFXTfvK4owOpbpztccgjjdHnCuadE2s3o/b6GTcVeiOuGe9aC/DaMvA
 Lm5G5jJ9e6xkPhSTKw0huEIxV0HzkN37Tg5k1QZNJSTZjtAdk4mMTV0u8+ia4rNymodqIz
 LM4LBJ0ogAuxQaUBo8jO85kmturEZos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662109665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lqJMJics7jOUun4axohwuEOUCVE+XamfFRxAzRSVcFg=;
 b=/VqqF8NGyuoD/Q59gJpoZuWP7BVNnieDkFA8O4ofYxdDWF8ijzUgbukmOm0CXRLcXqSg1d
 L2Sk5vKKhwqQBcBQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7CDA62C141;
 Fri,  2 Sep 2022 09:07:40 +0000 (UTC)
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
 <20220722120501.28670-3-andrea.cervesato@suse.com>
 <87r11nw0qv.fsf@suse.de> <945eb0ee-b346-5729-3dda-4bff39bb52d9@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Fri, 02 Sep 2022 10:05:29 +0100
In-reply-to: <945eb0ee-b346-5729-3dda-4bff39bb52d9@suse.com>
Message-ID: <87fsha2lge.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] Refactor mqns_01 using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato <andrea.cervesato@suse.com> writes:

> Hi!
>
> On 8/11/22 11:53, Richard Palethorpe wrote:
>> Hello,
>>
>> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
>>
>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>> ---
>>>   runtest/containers                         |   3 +-
>>>   testcases/kernel/containers/mqns/common.h  | 101 +++++++++++
>>>   testcases/kernel/containers/mqns/mqns_01.c | 193 +++++++--------------
>>>   3 files changed, 166 insertions(+), 131 deletions(-)
>>>   create mode 100644 testcases/kernel/containers/mqns/common.h
>>>
>>> diff --git a/runtest/containers b/runtest/containers
>>> index 2637b62fe..863a964ad 100644
>>> --- a/runtest/containers
>>> +++ b/runtest/containers
>>> @@ -16,7 +16,8 @@ pidns31 pidns31
>>>   pidns32 pidns32
>>>     mqns_01 mqns_01
>>> -mqns_01_clone mqns_01 -clone
>>> +mqns_01_clone mqns_01 -m clone
>>> +mqns_01_unshare mqns_01 -m unshare
>>>   mqns_02 mqns_02
>>>   mqns_02_clone mqns_02 -clone
>>>   mqns_03 mqns_03
>>> diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/common.h
>>> new file mode 100644
>>> index 000000000..92a77b566
>>> --- /dev/null
>>> +++ b/testcases/kernel/containers/mqns/common.h
>>> @@ -0,0 +1,101 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>> + */
>>> +
>>> +#ifndef MQNS_H
>>> +#define MQNS_H
>>> +
>>> +#include <stdlib.h>
>>> +#include "lapi/namespaces_constants.h"
>>> +#include "tst_test.h"
>>> +#include "tst_safe_posix_ipc.h"
>>> +
>>> +enum {
>>> +	T_CLONE,
>>> +	T_UNSHARE,
>>> +	T_NONE,
>>> +};
>>> +
>>> +static int dummy_child1(void *v)
>>> +{
>>> +	(void)v;
>>> +	return 0;
>>> +}
>>> +
>>> +static inline void check_newipc(void)
>>> +{
>>> +	int pid, status;
>>> +
>>> +	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child1,
>>>   NULL);
>> ltp_clone_quick is still part of the old API and only uses clone2. I
>> think it should be replaced with tst_clone. This may require extending
>> tst_clone. In fact we probably need a test variant to switch between the
>> clone2 and clone3 syscalls when using tst_clone.
>>
>> I'll leave it to you whether you want to try that and rebase this patch
>> set on it.
>>
> I see ltp_clone_quick as wrapper of ltp_clone, since it's using
> ltp_alloc_stack without calling it explicitly all the times before
> ltp_clone.

ltp_clone is also part of the old API. At some point we should remove that.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
