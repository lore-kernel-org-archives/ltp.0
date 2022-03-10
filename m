Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD6DC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:48:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9470F3C6D8F
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 13:47:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F7AD3C013E
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 13:47:47 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E90B10005B6
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 13:47:43 +0100 (CET)
X-QQ-mid: bizesmtp81t1646916456tgljb0js
Received: from [10.4.23.96] ( [58.240.82.166]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 10 Mar 2022 20:47:35 +0800 (CST)
X-QQ-SSF: 01400000002000C0I000000A0000000
X-QQ-FEAT: Y/4E1fKPEOqish88RDQVcGUHjViLTYesQbfYSBVzNd40ukwlRpQzEw48BoVwz
 7A3EvbnOdeQiyW4pO2aD6UxePEbzXorj6uoWJxEyia0OkH0bd44b/XfzIaBrK8SyJMBexXZ
 fcJrc8S9uwgk/Qfmb0qPIwbLvJn1qQ4BN/5QRU6Db3/itWaJxpwNMnIPb5EltDooWFFM3OT
 oAl3u5cCXvrOJghya98z2LlGEvsbViyK343QJxhzgZpeDQnUyImNWmed4BQ85/OgD5O+QXK
 0U90Y9HugYYw9dnCWxdc/CoGUSMJHUXshZ9UVrCFNxtPQP7Dj0dzSDWPg57fYyBBGm4jjLA
 zV5X5uKmUX1eC7gapfiXpkASYWeJuLel2DSFbi+
X-QQ-GoodBg: 2
Message-ID: <07b78ab4-5f1a-504d-d3fd-2e16e12bc47f@uniontech.com>+C673BB87EFA0CECE
Date: Thu, 10 Mar 2022 20:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220304065210.28591-1-zhanglianjie@uniontech.com>
 <YiiqzRFzIr+Zttc8@yuki>
From: zhanglianjie <zhanglianjie@uniontech.com>
In-Reply-To: <YiiqzRFzIr+Zttc8@yuki>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/clock_settime03: Fix testcases have been
 waiting, timeout failure
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 2022/3/9 21:25, Cyril Hrubis wrote:
> Hi!
>> If the system enables auto-synchronization time configuration,
>> this test case will wait until the timeout. Therefore,
>> the automatic synchronization time configuration of the system needs to be turned off in the setup phase.
>>
>> message:
>> tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
>> clock_settime03.c:35: TINFO: Testing variant: syscall with old kernel spec
>> tst_test.c:1506: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>> tst_test.c:1507: TBROK: Test killed! (timeout?)
>>
>> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
>>
>> diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
>> index f196a257c..e783f1d3f 100644
>> --- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
>> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
>> @@ -14,9 +14,11 @@
>>
>>   #define TIMER_DELTA	3
>>   #define ALLOWED_DELTA	(50 * 1000) /* 50 ms */
>> +#define BUFF_SIZE PATH_MAX
>>
>>   static struct tst_ts start, end;
>>   static struct tst_its its;
>> +static char cmd[BUFF_SIZE];
>>
>>   static struct time64_variants variants[] = {
>>   #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
>> @@ -31,6 +33,7 @@ static struct time64_variants variants[] = {
>>   static void setup(void)
>>   {
>>   	struct time64_variants *tv = &variants[tst_variant];
>> +	int ret;
>>
>>   	tst_res(TINFO, "Testing variant: %s", tv->desc);
>>   	start.type = end.type = its.type = tv->ts_type;
>> @@ -40,6 +43,11 @@ static void setup(void)
>>   	    sizeof(start.ts.kern_old_ts.tv_sec) == 4) {
>>   		tst_brk(TCONF, "Not Y2038 safe to run test");
>>   	}
>> +
>> +	snprintf(cmd, sizeof(cmd), "timedatectl set-ntp false");
> 
> There is no reason to print the command into a temporary buffer.
> 
>> +	ret = tst_system(cmd);
>> +	if (ret)
>> +		tst_brk(TBROK | TST_ERR, "failed to timedatectl set-ntp");
> 
> And this is certainly wrong too.
> 
> - The TST_ERR is not correct flag to be passed to tst_brk().
> 
> - The test must continue even if the timedatectl is not present on the
>    system, otherwise the test will be broken on systems without systemd
> 
> So at least we shouldn't exit the test if the tst_system() returned
> command-not-found.
Thank you for your review, I have already submitted V2.

> 
>>   }
>>
>>   static void run(void)
>> @@ -109,4 +117,8 @@ static struct tst_test test = {
>>   	.setup = setup,
>>   	.needs_root = 1,
>>   	.restore_wallclock = 1,
>> +	.needs_cmds = (const char *[]) {
>> +		"timedatectl",
>> +		NULL
>> +	},
> 
> And this is wrong too, again the test should be able to run on systems
> without systemd.
> 
>>   };
>> --
>> 2.20.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Kind regards,
Lianjie



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
