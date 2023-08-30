Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFAFC83F01
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 08:03:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E1F33CC025
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 10:03:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F01DC3C527F
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 10:03:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B48981A00242
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 10:03:39 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E48D8211DE;
 Wed, 30 Aug 2023 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693382618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYsBr5IIwN+FV3uiGNsAZvn4ShzhZIn3M9YZrUntzD8=;
 b=vg5xounMarX/NN1k6UXC5TPAeKK6PgpLc3no1cZGuuKHU1THObgUHBX6YBGZlSW2HcC60M
 qqjbXv2ooGEHZuQ13VV/7OMkm4qIwn7gztIySMlLoH3ty6hCAFjIw47q98uG1PxEUDWh2A
 NOZ900By0fd6gSL2n17kQ1xq94WHDyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693382618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FYsBr5IIwN+FV3uiGNsAZvn4ShzhZIn3M9YZrUntzD8=;
 b=jAOA9/A65eA29HGq853D63qMC679P8j1uyIQ7QFaYtld+tzoMTNXEN2Z8zsN62/1CjkPC7
 7nutaYDIHo2SDsAg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 447312C142;
 Wed, 30 Aug 2023 08:03:38 +0000 (UTC)
References: <20230509003148.16094-1-wegao@suse.com>
 <20230517120827.9350-1-wegao@suse.com> <875y53bcs8.fsf@suse.de>
 <AS8PR04MB81996C1CBF8578041D265E9FDEE7A@AS8PR04MB8199.eurprd04.prod.outlook.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Wed, 30 Aug 2023 09:02:31 +0100
Organization: Linux Private Site
In-reply-to: <AS8PR04MB81996C1CBF8578041D265E9FDEE7A@AS8PR04MB8199.eurprd04.prod.outlook.com>
Message-ID: <87msy9hs89.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] clone3: Add clone3's clone_args cgroup
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao <wegao@suse.com> writes:

> Hi Richard
>
> Thanks for your review. I flag my comments in former email start with [GW].
>
> Thanks.
> Regards
> Gao Wei
>
>
> -----Original Message-----
> From: Richard Palethorpe <rpalethorpe@suse.de> 
> Sent: Friday, August 25, 2023 6:36 PM
> To: Wei Gao <wegao@suse.com>
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] [PATCH v5] clone3: Add clone3's clone_args cgroup
>
> Hello,
>
> Wei Gao via ltp <ltp@lists.linux.it> writes:
>
>> Signed-off-by: Wei Gao <wegao@suse.com>
>> ---
>>  include/lapi/sched.h                        |   8 ++
>>  include/tst_cgroup.h                        |   4 +
>>  include/tst_clone.h                         |   1 +
>>  lib/tst_cgroup.c                            |   9 ++
>>  lib/tst_clone.c                             |   1 +
>>  runtest/syscalls                            |   1 +
>>  testcases/kernel/syscalls/clone3/.gitignore |   1 +
>>  testcases/kernel/syscalls/clone3/clone303.c | 101 
>> ++++++++++++++++++++
>>  8 files changed, 126 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/clone3/clone303.c
>>
>> diff --git a/include/lapi/sched.h b/include/lapi/sched.h index 
>> 1065665d1..ac766efc5 100644
>> --- a/include/lapi/sched.h
>> +++ b/include/lapi/sched.h
>> @@ -13,6 +13,7 @@
>>  #include <inttypes.h>
>>  #include "config.h"
>>  #include "lapi/syscalls.h"
>> +#include "lapi/sched.h"
>>  
>>  struct sched_attr {
>>  	uint32_t size;
>> @@ -54,6 +55,9 @@ struct clone_args {
>>  	uint64_t __attribute__((aligned(8))) stack;
>>  	uint64_t __attribute__((aligned(8))) stack_size;
>>  	uint64_t __attribute__((aligned(8))) tls;
>> +	uint64_t __attribute__((aligned(8))) set_tid;
>> +	uint64_t __attribute__((aligned(8))) set_tid_size;
>> +	uint64_t __attribute__((aligned(8))) cgroup;
>>  };
>>  
>>  static inline int clone3(struct clone_args *args, size_t size) @@ 
>> -133,4 +137,8 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
>>  # define CLONE_NEWTIME		0x00000080
>>  #endif
>>  
>> +#ifndef CLONE_INTO_CGROUP
>> +# define CLONE_INTO_CGROUP 0x200000000ULL #endif
>> +
>>  #endif /* LAPI_SCHED_H__ */
>> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h index 
>> 2826ddad1..be14d07c6 100644
>> --- a/include/tst_cgroup.h
>> +++ b/include/tst_cgroup.h
>> @@ -157,6 +157,10 @@ const char *
>>  tst_cg_group_name(const struct tst_cg_group *const cg)
>>  		      __attribute__ ((nonnull, warn_unused_result));
>>  
>> +/* This call returns a fd pointing to a v2 directory */ int 
>> +tst_cg_group_unified_dir_fd(const struct tst_cg_group *const cg)
>> +		      __attribute__ ((nonnull, warn_unused_result));
>> +
>>  /* Remove a descendant CGroup */
>>  struct tst_cg_group *
>>  tst_cg_group_rm(struct tst_cg_group *const cg) diff --git 
>> a/include/tst_clone.h b/include/tst_clone.h index 9ffdc68d1..7b278dfa7 
>> 100644
>> --- a/include/tst_clone.h
>> +++ b/include/tst_clone.h
>> @@ -11,6 +11,7 @@
>>  struct tst_clone_args {
>>  	uint64_t flags;
>>  	uint64_t exit_signal;
>> +	uint64_t cgroup;
>
> This is not used in the test being added so I will not merge it because I don't want to do any more work than necessary (I would still merge the rest of the test, but there is another issue below). The reason is because it may cause some test which does use tst_clone_args to fail because it increases the struct size. If some other test does not initialise the members correctly we may start sending uninitialised data to the kernel.
>
> In general I don't want to add anything which isn't immediately necessary without having to think about any potential problems it could cause.
>
> [GW]:  The point of this case is test cgroup parameter, if you remove this then following error will happen:
> tst_clone.c:18:21: error: 'const struct tst_clone_args' has no member named 'cgroup'
>    .cgroup = tst_args->cgroup,

But you use clone3 directly, I don't understand where tst_clone is being
used in the test?

>
>
>>  };
>>  
>>  /* clone3 with fallbacks to clone when possible. Be aware that it 
>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c index 
>> 274c73fea..43055e8cf 100644
>> --- a/lib/tst_cgroup.c
>> +++ b/lib/tst_cgroup.c
>> @@ -1112,6 +1112,15 @@ const char *tst_cg_group_name(const struct tst_cg_group *const cg)
>>  	return cg->group_name;
>>  }
>>  
>> +int tst_cg_group_unified_dir_fd(const struct tst_cg_group *const cg) 
>> +{
>> +	for (int i = 0; cg->dirs[i]; i++) {
>> +		if (cg->dirs[i]->dir_root->ver == TST_CG_V2)
>> +			return cg->dirs[i]->dir_fd;
>
> The loop is unecessary; cg->dirs_by_ctrl[0] is always the V2 directory if it exists.
>
> [GW]: I have updated and sent new Patch
>
> Otherwise the test LGTM. I'll set to changes requested in patchwork.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
