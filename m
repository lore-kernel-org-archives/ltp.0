Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD476C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 11:31:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F006C3CBCAB
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 12:31:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D02F03C8B38
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 12:31:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2196C140096D
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 12:31:13 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 70B6A21D70;
 Thu, 15 Dec 2022 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671103873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyC6xJS/iQ5lBzmI36Ww3b/zRdsDxWZAwGbqdtxXwHg=;
 b=obCJYFfTjtKYoVWoGoLxJd/cKn/SRGLWQ/Gg/5+ucnFHVvMqJj/2aMWGZ5elMbcpxmSP7f
 r/jqPdPqaTvrwcBwSJjD72m1KtjOIQvUCa8pChKREOHCHNnvIa7UpdoK4aZRM2WAT2oAym
 Dmo8XIGEHYrjOrAs75ynU1m/KLWIt3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671103873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyC6xJS/iQ5lBzmI36Ww3b/zRdsDxWZAwGbqdtxXwHg=;
 b=acIHWwee98UbrwEETAWYWrNSq3ZSUwiDb++DWTm0LmBTLMNDDSOJpDC2nhhctAmv2L+lOM
 MZGPGRiZXAELFDCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 404CC2C141;
 Thu, 15 Dec 2022 11:31:13 +0000 (UTC)
References: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671018303-2079-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <2faccaca-7b09-629f-a818-4d78211eae5c@fujitsu.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Thu, 15 Dec 2022 11:25:10 +0000
Organization: Linux Private Site
In-reply-to: <2faccaca-7b09-629f-a818-4d78211eae5c@fujitsu.com>
Message-ID: <87cz8kq4xr.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/6] shell: Remove old kernel version check
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

"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi ALL
>
>
>> The oldest supported test distribution kernel version is 3.0[1], we don't need these checks.
>> If users want to run these cases on old kernel, they can use old release tag.
>> 
>> [1]https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   testcases/commands/mkswap/mkswap01.sh         |  7 +----
>>   .../kernel/containers/netns/netns_sysfs.sh    |  4 ---
>>   .../cgroup/cgroup_regression_test.sh          |  9 ------
>>   .../kernel/controllers/cpuset/cpuset_funcs.sh |  9 ------
>>   .../memcg/functional/memcg_limit_in_bytes.sh  |  4 ---
>>   .../memcg_memsw_limit_in_bytes_test.sh        |  6 +---
>>   .../memcg/regression/memcg_regression_test.sh |  4 ---
>>   .../kernel/power_management/pm_include.sh     | 24 ++++++----------
>>   .../kernel/power_management/runpwtests01.sh   |  2 +-
>>   .../kernel/power_management/runpwtests02.sh   |  2 +-
>>   .../kernel/power_management/runpwtests03.sh   |  2 +-
>>   .../kernel/power_management/runpwtests04.sh   |  2 +-
>>   .../kernel/power_management/runpwtests05.sh   | 11 ++------
>>   .../kernel/power_management/runpwtests06.sh   |  8 ++----
>>   .../runpwtests_exclusive01.sh                 | 11 ++------
>>   .../runpwtests_exclusive02.sh                 |  8 ++----
>>   .../runpwtests_exclusive03.sh                 | 11 ++------
>>   .../runpwtests_exclusive04.sh                 |  2 +-
>>   .../runpwtests_exclusive05.sh                 | 11 ++------
>>   .../security/cap_bound/run_capbounds.sh       |  6 ----
>>   .../tracing/dynamic_debug/dynamic_debug01.sh  |  4 ---
>>   .../ftrace_stress/ftrace_trace_clock.sh       | 28 ++++---------------
>>   .../ftrace_stress/ftrace_trace_stat.sh        |  6 ----
>>   .../multicast/grp-operation/mcast-lib.sh      |  1 -
>>   24 files changed, 37 insertions(+), 145 deletions(-)
>> 
>> diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
>> index fe1695876..e03c46c31 100755
>> --- a/testcases/commands/mkswap/mkswap01.sh
>> +++ b/testcases/commands/mkswap/mkswap01.sh
>> @@ -51,12 +51,7 @@ mkswap_verify()
>>   		local pagesize=$PAGE_SIZE
>>   	fi
>>   
>> -	if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
>> -		tst_res TINFO "Waiting for $dev_file to appear"
>> -		tst_sleep 100ms
>> -	else
>> -		TST_RETRY_FUNC "check_for_file $dev_file" 0
>> -	fi
>> +	TST_RETRY_FUNC "check_for_file $dev_file" 0
>>   
>>   	swapon $swapfile 2>/dev/null
>>   
>> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
>> index 9fc390eaf..179242721 100755
>> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
>> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
>> @@ -18,10 +18,6 @@ do_setup()
>>   	DUMMYDEV_HOST="dummy_test0"
>>   	DUMMYDEV="dummy_test1"
>>   
>> -	if tst_kvcmp -lt "2.6.35"; then
>> -		tst_brk TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
>> -	fi
>> -
>>   	setns_check
>>   	if [ $? -eq 32 ]; then
>>   		tst_brk TCONF "setns not supported"
>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> index bfa9097ec..d26456b2d 100755
>> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> @@ -16,10 +16,6 @@ do_setup()
>>   {
>>   	mkdir cgroup/
>>   
>> -	if tst_kvcmp -lt "2.6.29"; then
>> -		tst_brk TCONF ignored "test must be run with kernel 2.6.29 or newer"
>> -	fi
>> -
>>   	if [ ! -f /proc/cgroups ]; then
>>   		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
>>   	fi
>> @@ -255,11 +251,6 @@ test5()
>>   #---------------------------------------------------------------------------
>>   test6()
>>   {
>> -	if tst_kvcmp -ge "3.0"; then
>> -		tst_res TCONF "CONFIG_CGROUP_NS is NOT supported in Kernels >= 3.0"
>> -		return
>> -	fi
>> -
>
> Here should return directly instead of removing. IOW, the test6 is 
> useless. But now it is safe because "grep -q -w "ns" /proc/cgroups" also 
> return directly. So I mean to remove this test6 at a separate patch in 
> the future or v3.

It needs removing in a V3 IMO. Because the below logic has not been
tested in a long time and may not reliably result in TCONF.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
