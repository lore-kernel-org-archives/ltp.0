Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBC6C6FA8F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 10:11:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D79D3CC0ED
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 12:11:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 765193CA99A
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:11:08 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 869A3600EB0
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:11:07 +0200 (CEST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37TA6x1g015883; Tue, 29 Aug 2023 10:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ryS2/Iz1ge+tH4w2yq/CvRUoMUtVuqv9h85QXlgodok=;
 b=NsfDgCNeFJVVyPNLE4D3nCn6RMuopyfEBvlcxla2YTcq9Z9+5vzYZaPp0l6d8vXJXbWH
 t0i6brjtFnIvX7F3xKqLrLwnHWO8bOW4Aug3IqzYdegzuX5Fehhj7DMh6B3XmFe/Lb1b
 RutOsyI+0kFUvKg8iVDBEeKNybmS/UuMNFUA+UBeDy14EdRqBeGUo6d56OVxAWz7klUy
 SGv+XTb6a0yHS3fHMwOEzfNGn+T5wC5sYOxt/+Cx0Xf1JI1GYlvGB7z5HQwdwwd8hZp7
 jXFB1nWVhN5cfev6V3iCrrEM/DWI0llMj8bam9ys20gUgDOkHXm6RNtUfskkdp/BKxeT 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87hr8jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 10:07:04 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TA73V3017245;
 Tue, 29 Aug 2023 10:07:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87hr8d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 10:07:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37T9Rmsg020504; Tue, 29 Aug 2023 10:03:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3yaph1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 10:03:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37TA37eF34275738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 10:03:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 224975803F;
 Tue, 29 Aug 2023 10:03:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DF4C58060;
 Tue, 29 Aug 2023 10:03:03 +0000 (GMT)
Received: from [9.171.14.10] (unknown [9.171.14.10])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Aug 2023 10:03:03 +0000 (GMT)
Message-ID: <014a7886-865f-109a-acc4-bc06ba92ce9b@linux.ibm.com>
Date: Tue, 29 Aug 2023 15:33:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230815093048.1155501-1-vishalc@linux.ibm.com>
 <20230815093048.1155501-3-vishalc@linux.ibm.com> <ZONldbUOjaFGbr_L@yuki>
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <ZONldbUOjaFGbr_L@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 834fZA7oEgn4kcocbrrzmob9lyk_R7Xp
X-Proofpoint-GUID: FVzYuppVQf0cFSjU0l-Md4HtofwTnf_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290087
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] ebizzy: prevent integer overflow in 64-bit
 systems
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
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, raj.khem@gmail.com,
 chris@mips.com, ltp@lists.linux.it, tdavies@darkphysics.net,
 Vishal Chourasia <vishalc@linux.ibm.com>, gaowanlong@cn.fujitsu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 8/21/23 18:54, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> ---
>>  utils/benchmark/ebizzy-0.3/ebizzy.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
>> index ae0981fbd..c3eac1133 100644
>> --- a/utils/benchmark/ebizzy-0.3/ebizzy.c
>> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
>> @@ -456,7 +456,7 @@ static void start_threads(void)
>>  	unsigned int i;
>>  	struct rusage start_ru, end_ru;
>>  	struct timeval usr_time, sys_time;
>> -	uintptr_t records_read = 0;
>> +	uintptr_t records_per_sec = 0;
>>  	int err;
>>  
>>  	if (verbose)
>> @@ -493,14 +493,13 @@ static void start_threads(void)
>>  			fprintf(stderr, "Error joining thread %d\n", i);
>>  			exit(1);
>>  		}
>> -		records_read += record_thread;
>> +		records_per_sec += (record_thread / elapsed);
> 
> This actually introduces quite a bit rounding errors. Note that even
> with 10 second runtime we effectively throw away the last digit for each
> thread records and it's even worse for larger runtime. This kind of
> naive summing can easily add up to quite large differencies.
> 
> E.g. for a machine with 256 CPUs and 10 seconds the value would be on
> average smaller by:
> 
> 	512 (number of threads) * 5 (average last digit) / 10 (runtime)
> 
> So on average the result printed would be smaller by 256 units.
> 
> Either we have to switch the records_per_sec to double and compute the
> number in floating point, which should add up fine as long as the work
> done by a threads is more or less the same.
> 
> Or use uint64_t as a fixed point and use one or two bits for a fraction,
> which may be a bit safer than double and should work fine as long as
> we round properly.
> 
> This should be easy to debug as well, just print the number computed by
> the method that sum first and then divide and compare it with the number
> that sums the already divided values. These two shouldn't differ much,
> ideally the should be the same.
> 
To address this, We can modify the code to keep the records per second
as a `double` type until the point of printing. This ensures that we
maintain precision throughout the calculation.

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c
b/utils/benchmark/ebizzy-0.3/ebizzy.c
index ffc439a24..f9bc41ba9 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -456,6 +456,7 @@ static void start_threads(void)
        unsigned int i;
        struct rusage start_ru, end_ru;
        struct timeval usr_time, sys_time;
+       uintptr_t records = 0;
        double records_per_sec = 0.0;
        int err;

@@ -493,13 +494,15 @@ static void start_threads(void)
                        fprintf(stderr, "Error joining thread %d\n", i);
                        exit(1);
                }
+               records += record_thread;
                records_per_sec += ((double)record_thread / elapsed);
        }

        if (verbose)
                printf("Threads finished\n");

-       printf("%tu records/s\n", (uintptr_t) records_per_sec);
+       printf("Method 1: %tu records/s\n", (uintptr_t)((double)records
/ elapsed));
+       printf("Method 2: %tu records/s\n", (uintptr_t) records_per_sec);

        usr_time = difftimeval(&end_ru.ru_utime, &start_ru.ru_utime);
        sys_time = difftimeval(&end_ru.ru_stime, &start_ru.ru_stime);

Both methods yield the same result, confirming the accuracy of the
calculation. Here are some sample outputs:


$ ./ebizzy -S 10 -t 512
Method 1: 3049076 records/s
Method 2: 3049076 records/s

$ ./ebizzy -S 10 -t 1000
Method 1: 2273819 records/s
Method 2: 2273819 records/s

I will be sending a proper patch as reply to this thread.

vishal.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
