Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982BBC47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 12:32:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 253173CEF25
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 13:32:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D29573CC7D3
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:32:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=yangx.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB77560079B
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 13:32:28 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="146754819"
X-IronPort-AV: E=Sophos;i="6.05,209,1701097200"; d="scan'208";a="146754819"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 21:32:28 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E1C9AC14A7
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:32:24 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 11BCCD9463
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:32:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9EEC822EB73
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 21:32:23 +0900 (JST)
Received: from [10.167.214.93] (unknown [10.167.214.93])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0B7A91A0070;
 Sun, 21 Jan 2024 20:32:19 +0800 (CST)
Message-ID: <3e496afd-a7e8-2141-9b66-878ad84206ec@fujitsu.com>
Date: Sun, 21 Jan 2024 20:32:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Petr Vorel <pvorel@suse.cz>, ice_yangxiao@163.com
References: <20240113144940.133746-1-ice_yangxiao@163.com>
 <20240117093712.GC2665992@pevik>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20240117093712.GC2665992@pevik>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28132.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28132.007
X-TMASE-Result: 10--21.414900-10.000000
X-TMASE-MatchedRID: oL1vkY0RODaPvrMjLFD6eDcodIZPkEsfkYC3rjkUXRLe6dEbvIyrxRIP
 baRMZ6zxwKkZaLNGSWoknOGoeIQzlgorSvYb1VTuuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVU+dN
 KUKmdFBBudEHjsosnVDMuZ8ZjqIORgX73VD8TMa03vTBeEjQNfg7iN9r6cjc/xKLCLOyCW5CmJ5
 jCyUYfidDaNZpK9gNY7gBMud2OLS6S2jwAoINujtfeP+V/VXwsBGvINcfHqhf2apmI5+Nrz91Ey
 kTzTHvr+vKnbgltiZzUEzDuRuhdKNU8BKnplvExvHKClHGjjr3/1JLsM3tGxjqUJVT3gpbTeUll
 3fhp3LPNfr8yF0I3uw4eLFudY+UfjyK/VqbtGFz3dt27LH8hnNhQO8CvZj/XZwUh4mDb2vujxYy
 RBa/qJQPTK4qtAgwIAYt5KiTiutm/v0UhTKC9nMRB0bsfrpPI6T/LTDsmJmg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/preadv: Make make check happy
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

Hi Petr

Thanks a lot for your detailed comment.
I have sent the v2 patch set as you suggested.

Best Regards,
Xiao Yang

On 2024/1/17 17:37, Petr Vorel wrote:
> Hi Xiao Yang,
> 
>> From: Xiao Yang <yangx.jy@fujitsu.com>
> 
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/preadv/preadv.h   | 19 ++------
>>   testcases/kernel/syscalls/preadv/preadv01.c | 26 +++++------
>>   testcases/kernel/syscalls/preadv/preadv02.c | 50 ++++++++++-----------
>>   3 files changed, 42 insertions(+), 53 deletions(-)
> 
>> diff --git a/testcases/kernel/syscalls/preadv/preadv.h b/testcases/kernel/syscalls/preadv/preadv.h
>> index 73466a9aa..c3e9e5f19 100644
>> --- a/testcases/kernel/syscalls/preadv/preadv.h
>> +++ b/testcases/kernel/syscalls/preadv/preadv.h
>> @@ -1,18 +1,7 @@
>> -/*
>> -* Copyright (c) 2015 Fujitsu Ltd.
>> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> -*
>> -* This program is free software; you can redistribute it and/or modify it
>> -* under the terms of version 2 of the GNU General Public License as
>> -* published by the Free Software Foundation.
>> -*
>> -* This program is distributed in the hope that it would be useful, but
>> -* WITHOUT ANY WARRANTY; without even the implied warranty of
>> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> -*
>> -* You should have received a copy of the GNU General Public License
>> -* alone with this program.
>> -*/
>> +/* SPDX-License-Identifier: GPL-2.0-or-later
> So you relicense from GPL v2 only to GPL v2+. You're the author, so you can do
> it (normally we shouldn't relicense). But maybe note that at the commit message?
> Thanks!
> 
>> + * Copyright (c) 2015 Fujitsu Ltd.
> nit: maybe add LTP copyright?
> * Copyright (c) Linux Test Project, 2016-2017
> 
>> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> + */
> 
>>   #ifndef PREADV_H
>>   #define PREADV_H
>> diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
>> index 62f9296f2..aba4748a5 100644
>> --- a/testcases/kernel/syscalls/preadv/preadv01.c
>> +++ b/testcases/kernel/syscalls/preadv/preadv01.c
>> @@ -1,17 +1,17 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> -* Copyright (c) 2015 Fujitsu Ltd.
>> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> -*/
>> + * Copyright (c) 2015 Fujitsu Ltd.
> nit: maybe add LTP copyright?
> * Copyright (c) Linux Test Project, 2016-2022
>> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> + */
> 
>>   /*
>> -* Test Name: preadv01
>> -*
>> -* Test Description:
>> -* Testcase to check the basic functionality of the preadv(2).
>> -* Preadv(2) should succeed to read the expected content of data
>> -* and after reading the file, the file offset is not changed.
>> -*/
>> + * Test Name: preadv01
> 
> Could you please convert to the docparse? Something like this:
> 
> /*\
>   * [Description]
> 
>   * Testcase to check the basic functionality of the preadv(2).
> 
>   * preadv(2) should succeed to read the expected content of data
>   * and after reading the file, the file offset is not changed.
>   */
> 
>> + *
>> + * Test Description:
>> + * Testcase to check the basic functionality of the preadv(2).
>> + * Preadv(2) should succeed to read the expected content of data
>> + * and after reading the file, the file offset is not changed.
>> + */
> 
>>   #define _GNU_SOURCE
> 
>> @@ -38,7 +38,7 @@ static struct tcase {
>>   	{1, CHUNK*3/2, CHUNK/2, 'b'}
>>   };
> 
>> -void verify_preadv(unsigned int n)
>> +static void verify_preadv(unsigned int n)
>>   {
>>   	int i;
>>   	char *vec;
>> @@ -81,7 +81,7 @@ void verify_preadv(unsigned int n)
>>   		 "with content '%c' expectedly", tc->size, tc->content);
>>   }
> 
>> -void setup(void)
>> +static void setup(void)
>>   {
>>   	char buf[CHUNK];
> 
>> @@ -94,7 +94,7 @@ void setup(void)
>>   	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, sizeof(buf));
>>   }
> 
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>>   	if (fd > 0)
>>   		SAFE_CLOSE(fd);
>> diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
>> index 500059e42..65d4795d6 100644
>> --- a/testcases/kernel/syscalls/preadv/preadv02.c
>> +++ b/testcases/kernel/syscalls/preadv/preadv02.c
>> @@ -1,32 +1,32 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> -* Copyright (c) 2015-2016 Fujitsu Ltd.
>> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> -*/
>> + * Copyright (c) 2015-2016 Fujitsu Ltd.
>> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> + */
> 
>>   /*
>> + * Test Name: preadv02
> nit: remove this ^ (useless)
> 
> Again, add docparse + simplify docs a bit:
> 
> /*\
>   * [Description]
>   *
>   * Test basic error handling of the preadv(2) syscall.
>   *
>   * 1) preadv(2) fails if iov_len is invalid (EINVAL)
>   * 2) preadv(2) fails if the vector count iovcnt is less than zero (EINVAL).
>   * 3) preadv(2) fails if offset is negative (EINVAL).
>   * 4) preadv(2) fails when attempts to read into a invalid address (EFAULT).
>   * 5) preadv(2) fails if file descriptor is invalid (EBADF).
>   * 6) preadv(2) fails if file descriptor is not open for reading (EBADF).
>   * 7) preadv(2) fails when fd refers to a directory (EISDIR).
>   * 8) preadv(2) fails if fd is associated with a pipe (ESPIPE).
>   */
> 
> With this, you can add my:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
>> + *
>> + * Description:
>> + * 1) preadv(2) fails if iov_len is invalid.
>> + * 2) preadv(2) fails if the vector count iovcnt is less than zero.
>> + * 3) preadv(2) fails if offset is negative.
>> + * 4) preadv(2) fails when attempts to read into a invalid address.
>> + * 5) preadv(2) fails if file descriptor is invalid.
>> + * 6) preadv(2) fails if file descriptor is not open for reading.
>> + * 7) preadv(2) fails when fd refers to a directory.
>> + * 8) preadv(2) fails if fd is associated with a pipe.
>> + *
>> + * Expected Result:
>> + * 1) preadv(2) should return -1 and set errno to EINVAL.
>> + * 2) preadv(2) should return -1 and set errno to EINVAL.
>> + * 3) preadv(2) should return -1 and set errno to EINVAL.
>> + * 4) preadv(2) should return -1 and set errno to EFAULT.
>> + * 5) preadv(2) should return -1 and set errno to EBADF.
>> + * 6) preadv(2) should return -1 and set errno to EBADF.
>> + * 7) preadv(2) should return -1 and set errno to EISDIR.
>> + * 8) preadv(2) should return -1 and set errno to ESPIPE.
>> + */
> 
>>   #define _GNU_SOURCE

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
