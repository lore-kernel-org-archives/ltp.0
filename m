Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F78C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:46:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16F733C922B
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:46:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8860E3C104E
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:46:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D189C600D78
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:46:05 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1E91B1F388
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640083565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhZb4e/D0IM+tUSFTWluTbeenmW3aBJhjRUxakp7XM4=;
 b=u/+aQOTs9vNQjOpqiRe2l/bIuxgM2ILn8Jy9oU8+D9+UkdxjGQNWclGtH0stuumD1mV75h
 k2daHJdTHAgWNPSp07sLnCHC96e6avqqsDXMKZz03rDMO0Rg7DRywJ3nE6wB6UokIWdepx
 gLDxLc8zheU5BWKPDpOdOMmrkezxf7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640083565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhZb4e/D0IM+tUSFTWluTbeenmW3aBJhjRUxakp7XM4=;
 b=Vvu7YkfcodQ4B5QqLlrthWSu0ugdeI5AccDzDJrEiZBeY6lM0Bt6gh9F3LqJLeyBkZPgUq
 s+iiL/WbdTfuaRCg==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E0FEEA3B81;
 Tue, 21 Dec 2021 10:46:04 +0000 (UTC)
References: <20211220131043.18894-1-rpalethorpe@suse.com>
 <20211220131043.18894-3-rpalethorpe@suse.com> <YcCk13sQIpG+E0jR@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Dec 2021 08:38:03 +0000
In-reply-to: <YcCk13sQIpG+E0jR@yuki>
Message-ID: <87a6gufd77.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] cgroup: Add memcontrol02
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

Cyril Hrubis <chrubis@suse.cz> writes:

>> +
>> +static void test_memcg_current(unsigned int n)
>> +{
>> +	size_t current;
>> +
>> +	cg_child = tst_cgroup_group_mk(cg_test, "child");
>> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
>> +	TST_EXP_POSITIVE(current == 0, "(current=%zu) == 0", current);
>
> I find these TST_EXP_POSITIVE() macros slightly confusing.
>
> Note that we do have TST_EXP_VAL(), so this can be better defined as
> TST_EXP_VAL(current, 0);
>
> But even then all the macros all written in a way that they do expect
> a syscall as a first parameter and the messages are not clear.

Possibly it should just be TST_EXP(bool_expr, fmt, ...). That would be like
practically every other testing framework. OTOH LTP is somewhat special
as we usually are checking the return value of a syscall. So I should
probably leave these macros alone in this case.

>
> Maybe we need a different solution. We already have tst_assert_foo()
> functions for sysfs/proc files so maybe we need something as compare
> function for the cgroup file attributes:

Frankly that is poor naming. One would expect tst_assert to be similar
to assert from assert.h.

>
> 	enum cmp {
> 		CMP_EQ,
> 		CMP_NE,
> 		CMP_LT,
> 		CMP_GT,
> 		CMP_LE,
> 		CMP_GE,
> 		CMP_EPS,
> 	};
>
> 	CGROUP_ASSERT_CMP_SIZE(cg_child, "memory.current", CMP_EQ, 0);
>
> 	CGROUP_ASSERT_CMP_SIZE(cg_child, "memory.current", CMP_EPS, file, 10);
>
>
> 	or even simple macro that would compare two values accordingly
> 	to the OP and print PASS/FAIL would be better than this.
>

I think it would be simpler to just create a general assert_expr
macro. The above function won't neatly handle loading multiple values
from multiple files. Nor will it handle transforming values.

We could implement SQL queries for sys files, like osquery, that would
be neat!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
