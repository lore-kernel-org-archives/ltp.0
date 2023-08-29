Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1B0C83F12
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 09:42:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A5E63CC03F
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 11:42:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3DFD3C9762
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 11:41:51 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 441CE200D18
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 11:41:49 +0200 (CEST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37T9Dhmp028751; Tue, 29 Aug 2023 09:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BvKfaA8Af99anB4jqhdy/VbYxuKETZ7HTqAvhYog8M0=;
 b=FgaIgsje0P2IdN06H5p22vaJvaiLng64q5HcZnIeEiwFKf1PPpzxJ1oGGH7RNvGC/Cb3
 PMadFJXU+t0pTj72TnO6ux5KadPH6CTLrYEmlaGhwK9gpy0bXPTpv6xgbeV/TLvdYzE7
 RJYSoRt7ATY8VKH7VcgdZxJw4fgF5tWdf1RZnyF2oUTuonHd213LSyqZPLK2kWmoLy4D
 DVX9ps1zmXYjqa5pd6mlq434GsN1Sa4S1uv/B66DO1M3EEes2OoAHCn4P9J53mO7FmJt
 H9DZYtUlEMzgRgr3b4X5XGPsNCsaiGYZbwF4MpYW1SjorxLHX27Dtzsvl9nBD/nbKFo2 ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vyr98s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 09:37:43 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T9GPbK008696;
 Tue, 29 Aug 2023 09:37:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vyr97x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 09:37:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37T81gIb009897; Tue, 29 Aug 2023 09:37:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7ka5x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Aug 2023 09:37:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37T9beCN3146420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 09:37:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87F935805E;
 Tue, 29 Aug 2023 09:37:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A84065805A;
 Tue, 29 Aug 2023 09:37:37 +0000 (GMT)
Received: from [9.171.49.19] (unknown [9.171.49.19])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Aug 2023 09:37:37 +0000 (GMT)
Message-ID: <80f79239-8721-3746-2bea-b5f6b05e1329@linux.ibm.com>
Date: Tue, 29 Aug 2023 15:07:36 +0530
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
X-Proofpoint-ORIG-GUID: M2fRXFnDGFI3v9bfAF05IhN1E04JNrq0
X-Proofpoint-GUID: fI7hAbnStlLzvOoKp48Jj6Zuz1kLc3UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290082
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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
 gaowanlong@cn.fujitsu.com
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
> Sorry for the late reply.

Thank you for your insights on the potential rounding errors. I do see
significant rounding off error with proposed implementation.

$ ./ebizzy -S 10 -t 512
Method 1: 3049243 records/s
Method 2: 3049014 records/s
real 10.00 s
user 943.82 s
sys   0.00 s

$ ./ebizzy -S 10 -t 1000
Method 1: 2181487 records/s
Method 2: 2181041 records/s
real 10.00 s
user 947.33 s
sys   9.33 s

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
