Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F86CF11DF
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728563104; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=dYzhQZuo97BFG7Ly+r3d/V1EvYbdD6ajehXFW5Loas4=;
 b=IH5E7ChjzBtvEtEF/N8gvVF1KIfPAmLjm5WYzMOS0hneH4Bgsk7R5HBet8S8BDMwQkWLq
 udX2At6zxXcfEQwH0hABLRrJU7QWMzfxgaszs4mtvWRIOJDw7RKtYPbkfrLBSb24/oh3ema
 bfxDOr92qijzXptFCq9cQy8XMK1kHZY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 737503C4B94
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 14:25:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DF8E3C042F
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 14:24:44 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FEEA140C931
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 14:24:43 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c90333aaf1so824134a12.0
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728563083; x=1729167883; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GC/Fuc1xEI3bfGS26YrmXw/7prj4f0H9GfetWHvKEQ8=;
 b=gK08NxoswEsCOWLpC6+KeFShjdMuZAM8ZSHCoA1gFmIENrPgwECHD01WvCtbzDLnWf
 CFcFxzA0NM/uTkF7X0cPELkz1Pt0eHnRjwnmsCY1xpdWYp42ZOLMNSjkXv0M8uBThyia
 NObXuuzabZ/UzdLs57fyCX7L7YSnKJp18JVMMvzNLKTiRGqC0LjESNMHity9oy6it+Bs
 Wb+UBsNRuznGbc3m5VeeucPShtURK7YQc+ntIhI5o7DIidsrzUYhI85GtxqKAnlFxiEm
 btjW+uR98Oa7h1aXAYIVwiahhK1tMCVpprpyCH53xE+LHQ/S5BUArjCs5qQekbPBCHki
 m5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728563083; x=1729167883;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GC/Fuc1xEI3bfGS26YrmXw/7prj4f0H9GfetWHvKEQ8=;
 b=U96jcOLaw9sZgQsAdoOD1f7qu47RwbaRjps67qNWMMARiE7EmSYTbpPLp3p+D8dl0K
 cWm8fH7sFmzlHjKPLwTgCsXKWzsPMQVx6f26MzdT15F0ExtU1rjOwxvD9nu0EM+curqF
 psC78bPs5g32XdRuqITSb/itCb3ymhyXK01gG7jfNHANhbQwLUP9+BltbRf/LP3STpkS
 GyzEb89I+FX2XofXvphx5K58KglJpNfxGahBfobeR3si+tzQkia86QMcYv6Oagf5PkNB
 tN+mSOmlIzpoMw0QcIiuEPG9QNScVYix+c9FmqQnQO6SxAD34lS9yzLh7fBcCAhLs1Ac
 +dGw==
X-Gm-Message-State: AOJu0YyfWRCxDDYXdpbjZxSv+DTiUtJ+uezWxOiy4SuWshoTPfy1S2Xj
 ztm5GN9IVubp/JGN4xckuU7SjXguXMLOtwq17Mh7RZQXIai80NGIdRfCsYWBp30=
X-Google-Smtp-Source: AGHT+IFqjV32Ze8hLUyVJMzJn6yj1SwdEVtgeWjsFjEU3tCRm2KEuTO7ywwQJfnHfdf8uDCYMFtWgw==
X-Received: by 2002:a05:6402:2745:b0:5c8:84a8:5170 with SMTP id
 4fb4d7f45d1cf-5c91d65067cmr7592632a12.34.1728563082614; 
 Thu, 10 Oct 2024 05:24:42 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c93711a9e4sm702593a12.31.2024.10.10.05.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 05:24:42 -0700 (PDT)
Message-ID: <ac7fcf96-8283-47e8-bc2c-6bc9bab0d73f@suse.com>
Date: Thu, 10 Oct 2024 14:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
 <20240812-process_mrelease-v2-3-e61249986a0a@suse.com>
 <ZwP4VxOgCOI-BWMw@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZwP4VxOgCOI-BWMw@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add process_mrelease02 test
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

On 10/7/24 17:03, Cyril Hrubis wrote:
> Hi!
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that process_mrelease() syscall is raising errors:
>> + * * EBADF when a bad file descriptor is given
>> + * * EINVAL when flags is not zero
>> + * * EINVAL when memory of a task cannot be released because it's still running
>> + * * ESRCH when child has been closed
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +
>> +static int badfd = -1;
>> +static int pidfd;
>> +
>> +enum {
>> +	NO_CHILD,
>> +	EXIT_CHILD,
>> +	WAIT_CHILD,
>> +};
>> +
>> +static struct tcase {
>> +	int child_type;
>> +	int *fd;
>> +	int flags;
>> +	int exp_errno;
>> +	char *msg;
>> +} tcases[] = {
>> +	{NO_CHILD, &badfd, 0, EBADF, "bad file descriptor"},
>> +	{WAIT_CHILD, &pidfd, -1, EINVAL, "flags is not 0"},
>> +	{WAIT_CHILD, &pidfd, 0, EINVAL, "task memory cannot be released"},
>> +	{EXIT_CHILD, &pidfd, 0, ESRCH, "child is not running"},
>> +};
>> +
>> +static void run(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +	int status;
>> +
>> +	if (tc->child_type != NO_CHILD) {
>> +		pid_t pid;
>> +
>> +		pid = SAFE_FORK();
>> +		if (!pid) {
>> +			if (tc->child_type == WAIT_CHILD)
>> +				TST_CHECKPOINT_WAIT(0);
>> +
>> +			exit(0);
>> +		}
>> +
>> +		tst_res(TINFO, "Spawned waiting child with pid=%d", pid);
>> +
>> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
>> +
>> +		if (tc->child_type == EXIT_CHILD)
>> +			SAFE_WAITPID(pid, &status, 0);
>> +	}
> Why don't we instead fork two children in the setup, one of the waits
> and second exits and just set the pidfd once?
At the end of each test() the library calls tst_reap_children() and the 
waiting child will fail with ETIMEDOUT, so we need to spawn a child for 
each new test.
>> +	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
>> +		tc->exp_errno,
>> +		"%s", tc->msg);
>> +
>> +	if (tc->child_type != NO_CHILD) {
>> +		if (tc->child_type == WAIT_CHILD)
>> +			TST_CHECKPOINT_WAKE(0);
>> +
>> +		SAFE_CLOSE(pidfd);
>> +	}
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test = run,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.min_kver = "5.15",
>> +	.needs_checkpoints = 1,
>> +};
>>
>> -- 
>> 2.43.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
