Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F40FC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739178322; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=/NXc1YYJNolgF90yyJOrp0bNbMcbBdwerBt4atiy5YM=;
 b=FADwwyaHB9ZXix2zp8ULOeW4KjvRAv34YKu/crYUe3wukBKS2xOcFUNjRVKKtmd8rmf6E
 zCrlyZx6zWg+YprstxYY47iT+rUIkNxmbrvQRpSNH+2LLkSDyEBrB5RIf8kTzy9KGoISynY
 W2nXQUp3dS94wiKgi5guBnFLF4aCabY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 348453C92A9
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:05:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1ED03C92A9
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:05:00 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBA6B140C9B5
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:04:58 +0100 (CET)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3061513d353so41910371fa.2
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 01:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739178298; x=1739783098; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tol3ELGpWs8rKraUM5DRhgHGycmxSLgir7HEV3xNdmc=;
 b=TmYLR1oWfxJ16WZIkpbxZKBpUelEKpNgxzG1ck6UDkCZnY/O2ZhaJXYisEXfD5sQiI
 /CS9JSjA1T8Ekbo0PkTVb1QZpFGVSadWMvkkWkOdDEK6MP/VnyHgKWUA6anrpv+yGMVs
 POF9oUdcD9oNcxElfe9mGbIxdWH0fEmUJuccFY/Krs/K0RChR1Jb9X5EugcPceDYuvvf
 u/KpF9xo+2v0C99tW6jXHZHto8X6/YafoOczk/aEoLmHwMqVFf4MRqXX6G7XWe8d8fXd
 ha2N8GyRrsOt/3pK9TAjmchKIdTUiDxe5Rhcx231S6+WTQdAOQlebVjEAyIPiFa5BN8P
 6fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739178298; x=1739783098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tol3ELGpWs8rKraUM5DRhgHGycmxSLgir7HEV3xNdmc=;
 b=gePdZ2591YIhFn/8aKfFH3ZieiQUW7tFRg0tl74nMKmvWoqexfBokyRhRrv3xZ4UHC
 xruCfVTmAa3YeH0KxG3j75disDBLMWUYLdoNn03q1l4qNFWvEplov2WLzxCz0JVy4WAH
 UR9Gg3O9bRFnydcpd2Qmc0edqmjadDQjzjzgurUVGRqUMOmiEMfJZL635oIn+ZwKd+q7
 JLbPwoRIdHhA7BSlpIECjnY5UeIsQkpBipwzvUgC6WkZ4kc0NISWbNtZUQoSJOxj3Rw3
 Wrj4gJUn1uRLsdaq98xjwWY4XPsvC/BO2rEs5iM2lfv7XnxqcvYJgZYkhN277dXKpZz6
 FZKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURY5SlAeXnYZPw41zhEeYbCiImOffKKJziQbusSbVzoRjPQe40Qi4HgmUkH0lSl2yZ6bs=@lists.linux.it
X-Gm-Message-State: AOJu0YynRx0lO5m8NrBg3qd0qQwAyNGEPddS2vrlmyIhrYFA1tiiaXwu
 rrE4AypN77xbzSBnfwBbz7Pdln1i/QYWea32dMifz09gZdN4H/armkNSn8z/Wvw=
X-Gm-Gg: ASbGncsaNuVlQ/iBf8is61KYY61wkx4tQzgbNQREI7Ptv/rQLyrf3gqt5pi1UNcjkuv
 41j7RV9NpM0ay+1k4uF5pfpt632BgcozC3c+Klv34waoTPrwjeyhPdg3YP1yQUmtypgrkyuvPvx
 xvPnFqKdYL4wiDlB6JyCiJafoBJtuc7Lmx2SWuuxeMR2UHhsXu5ROfcpYQjoF6hzCBp++AJ8LOa
 sMCwJVSrF2Y5MPLjgxvxBA3Xz2GK/UU3Plpl/zdqbc4BL4WZVB04xgRq7nIy+qRNt/u+9XlkS5/
 eOTi6JiN+x+1IHeC1IMigWH2de6KilewclV1nVpuGNJEr/TQb0fjDdrCkmXUM7A5HCyvrf6E+n6
 F1yAflRhKVktG6rfyOoXtYXH1MIN7IWXxy4ITfaoI1q+9nntw6XI=
X-Google-Smtp-Source: AGHT+IHakAj2DI6VxHwrZZe9cC6HFHZz7iTLCdv5ymG2lyUMzd4aLih3pukQQK+P2Ls9gip1Q+RxdA==
X-Received: by 2002:a2e:a545:0:b0:308:f580:72a8 with SMTP id
 38308e7fff4ca-308f580759fmr2362741fa.11.1739178297838; 
 Mon, 10 Feb 2025 01:04:57 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-308d9b6755asm7590721fa.59.2025.02.10.01.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 01:04:57 -0800 (PST)
Message-ID: <affc9255-bf3b-4571-9712-2b20e5b974ee@suse.com>
Date: Mon, 10 Feb 2025 10:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 "Ricardo B. Marliere" <rbm@suse.com>, Linux Test Project <ltp@lists.linux.it>
References: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
 <20250114-conversions-v1-1-7869a9f786d0@suse.com>
 <7f1c0594-e6ef-497b-852a-e8fe6ee2afe4@suse.com>
 <D7EQ8W8TM84D.T8OZ3RKV2RH3@marliere.net>
Content-Language: en-US
In-Reply-To: <D7EQ8W8TM84D.T8OZ3RKV2RH3@marliere.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] mmap001: Convert to new API
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

Hi!

A few comments below about the code.

On 1/29/25 18:19, Ricardo B. Marliere wrote:
> Hi Andrea,
>
> thanks for reviewing!
>
> On Wed Jan 15, 2025 at 10:14 AM -03, Andrea Cervesato wrote:
>> Hi!
>>
>> On 1/14/25 23:26, Ricardo B. Marliere via ltp wrote:
>>> From: Ricardo B. Marliere <rbm@suse.com>
>>>
>>> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
>>> ---
>>>    testcases/kernel/syscalls/mmap/mmap001.c | 206 ++++++++-----------------------
>>>    1 file changed, 49 insertions(+), 157 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
>>> index dabb7d1e4998b1097e179abe23555926f5841117..bc9b4155e8b53f942ef694fdf3187c0e544a97cd 100644
>>> --- a/testcases/kernel/syscalls/mmap/mmap001.c
>>> +++ b/testcases/kernel/syscalls/mmap/mmap001.c
>>> @@ -1,183 +1,75 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>    /*
>>>     * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
>>>     *                    Aaron Laffin <alaffin@sgi.com>
>>> + * Copyright (c) 2025 Linux Test Project
>>> + */
>>> +
>>> +/*\
>>> + * [Description]
>>>     *
>>> - * This program is free software; you can redistribute it and/or
>>> - * modify it under the terms of the GNU General Public License
>>> - * as published by the Free Software Foundation; either version 2
>>> - * of the License, or (at your option) any later version.
>>> - *
>>> - * This program is distributed in the hope that it will be useful,
>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> - * GNU General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU General Public License
>>> - * along with this program; if not, write to the Free Software
>>> - * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
>>> - *
>>> - * mmap001.c - Tests mmapping a big file and writing it once
>>> + * Tests mmapping a big file and writing it once
>> Description is a bit short and it needs a bit more information. For
>> example, what we expect to see and what could happen during test (SEGV
>> for example).
> Ack.
>
>>> -		if (TEST_RETURN == -1) {
>>> -			tst_resm(TFAIL | TTERRNO,
>>> -				 "munmapping %s failed", filename);
>>> -		} else {
>>> -			tst_resm(TPASS, "munmapping %s successful", filename);
>>> -		}
>>> +	/*
>>> +	 * Seems that if the map area was bad, we'd get SEGV,
>>> +	 * hence we can indicate a PASS.
>>> +	 */
>> If this is true, we need to find a way to test that specific scenario.
>> This can e done by forking a process where test is running and to check
>> if SIGSEGV killed it after calling SAFE_WAITPID()
> Good idea, I kept the original comment and TPASS string but it could
> surely be expanded. What do you think of the following? I'll be sending
> as v2 when the series receive some more reviewing.
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
> index bc9b4155e8b5..10ce7a48e7c2 100644
> --- a/testcases/kernel/syscalls/mmap/mmap001.c
> +++ b/testcases/kernel/syscalls/mmap/mmap001.c
> @@ -8,7 +8,8 @@
>   /*\
>    * [Description]
>    *
> - * Tests mmapping a big file and writing it once
> + * This test will map a big file to memory and write to it once,
> + * making sure nothing bad happened in between such as a SIGSEGV.
>    */
>   
>   #include "tst_test.h"
> @@ -25,6 +26,8 @@ static void setup(void)
>   
>   static void run(void)
>   {
> +	pid_t pid;
> +	int status;
>   	char *array;
>   	unsigned int i;
>   	unsigned int pages, memsize;
> @@ -40,20 +43,23 @@ static void run(void)
>   	SAFE_LSEEK(fd, memsize, SEEK_SET);
>   	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\0", 1);
>   
> -	array = SAFE_MMAP(NULL, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
> -
> -	tst_res(TINFO, "touching mmaped memory");
> -	for (i = 0; i < memsize; i++)
> -		array[i] = (char)i;
> -
> -	/*
> -	 * Seems that if the map area was bad, we'd get SEGV,
> -	 * hence we can indicate a PASS.
> -	 */
> -	tst_res(TPASS, "we're still here, mmaped area must be good");
> -
> -	SAFE_MSYNC(array, memsize, MS_SYNC);
> -	SAFE_MUNMAP(array, memsize);
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		array = SAFE_MMAP(NULL, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
> +		tst_res(TINFO, "touching mmapped memory");
> +		for (i = 0; i < memsize; i++)
> +			array[i] = (char)i;
> +		SAFE_MSYNC(array, memsize, MS_SYNC);
> +		SAFE_MUNMAP(array, memsize);
> +		exit(0);
> +	} else {
No need for else here. Remember to call "make check" on the folder to 
verify code correctness. "make check-mmap001" in this case.
Also, I was thinking that we don't have a mechanism to know if file is 
updated or not, so please take a look at my patch on mmap001 (mmap21). 
I'm gonna send a v2 so you can take a look at the final idea.
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (WIFSIGNALED(status) && WEXITSTATUS(status) == SIGSEGV)
> +			tst_res(TFAIL, "test was killed by SIGSEGV");
> +		else
> +			tst_res(TPASS,
> +				"memory was mapped and written to successfully");
> +	}
>   }
>   
>   static void cleanup(void)
> @@ -66,6 +72,7 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.test_all = run,
>   	.cleanup = cleanup,
> +	.forks_child = 1,
>   	.options =
>   		(struct tst_option[]){
>   			{ "m:", &m_copt,
>
>
>
>> Kind regards,
>> Andrea
> Thank you,
> -	Ricardo.
>
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
