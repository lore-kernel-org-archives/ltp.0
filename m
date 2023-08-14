Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D93C001DB
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 19:47:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43E0F3CD4CA
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 21:47:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 834053C97CA
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 21:46:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEEF6600706
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 21:46:56 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37EJgAtL020574; Mon, 14 Aug 2023 19:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8rQUnKY7fZ6shVVdo7BZIVVo4t0I/5fpVwKk+gXA2TE=;
 b=OuPVclP3cRB0LB2V+CJ819OeXuDsZyX2ePhf7oG1qtgBJ+sFZyFlJLfMdchotPqSiFpE
 wiLTvBNTlPdKSSkeL0Th3adKmBKvPjp1lI2h8YrF1RTSbRZ3I3a1sDSGfEeTpqU6ayf0
 qaOsUa6lc0qGwrg1TzTCH7iFqmQ4DQ9fg06gbY0n04KvA4kBJ2ONApUMFcT5TiV70wnk
 E47Fg1P9qFdK4NNs9k/eFM9oW9N0p2j2XkZdxsYlpmQYPBJxsrf395akruPDeVYGniMp
 GI8a2ydODP5u6uzDePc5ECzOJ17U4zMxr+SWwThmvEPIVhkb+Q25OwtfHZDjVR1qR/mn Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sftner0f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 19:42:52 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EJgq4F022924;
 Mon, 14 Aug 2023 19:42:52 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sftner0ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 19:42:52 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37EIACYF003495; Mon, 14 Aug 2023 19:42:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semds7ja6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 19:42:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37EJgpre41156932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 19:42:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5F3D58043;
 Mon, 14 Aug 2023 19:42:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B955658053;
 Mon, 14 Aug 2023 19:42:47 +0000 (GMT)
Received: from [9.179.26.195] (unknown [9.179.26.195])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Aug 2023 19:42:47 +0000 (GMT)
Message-ID: <b330c653-54b1-ff0e-1ea2-f1c3f71316d9@linux.ibm.com>
Date: Tue, 15 Aug 2023 01:12:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230814061810.2297146-1-vishalc@linux.ibm.com>
 <20230814061810.2297146-2-vishalc@linux.ibm.com> <ZNpE_7LKnB6ZGFbK@yuki>
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <ZNpE_7LKnB6ZGFbK@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JzDgG2q5JDJQK0Ai4tUAz2S0J3pLW6nC
X-Proofpoint-GUID: QEs2-9x0CzXawLU_E1POzQao88WND4ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_17,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140181
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Enhanced thread safety in ebizzy benchmark
 tool
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

On 8/14/23 20:45, Cyril Hrubis wrote:
> Hi!
>> Modified ebizzy.c to improve thread safety by introducing a mutex for
>> 'records_read' shared variable.
>>
>> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> ---
>>  utils/benchmark/ebizzy-0.3/ebizzy.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
>> index 54b047130..1af004d9d 100644
>> --- a/utils/benchmark/ebizzy-0.3/ebizzy.c
>> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
>> @@ -85,6 +85,8 @@ static time_t start_time;
>>  static volatile int threads_go;
>>  static unsigned int records_read;
>>  
>> +pthread_mutex_t records_read_lock;
> 
> Can't we just initialze the mutex statically?
> 
> i.e.:
> 
> static pthread_mutex_t record_read_lock =  PTHREAD_MUTEX_INITIALIZER;
> 
> 
> Then we don't have to intialize/destroy it.>
> Or even better we can rework the code so that the value is passed up to
> the pthread_join() function which would serialize the code naturally,
> something as:
> 
> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
> index 54b047130..841bf0a1c 100644
> --- a/utils/benchmark/ebizzy-0.3/ebizzy.c
> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
> @@ -50,6 +50,7 @@
>  #include <time.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
> +#include <stdint.h>
> 
>  #include "ebizzy.h"
> 
> @@ -83,7 +84,6 @@ static char **hole_mem;
>  static unsigned int page_size;
>  static time_t start_time;
>  static volatile int threads_go;
> -static unsigned int records_read;
> 
>  static void usage(void)
>  {
> @@ -423,6 +423,8 @@ static unsigned int search_mem(void)
> 
>  static void *thread_run(void *arg __attribute__((unused)))
>  {
> +       uintptr_t records_thread;
> +
>         if (verbose > 1)
>                 printf("Thread started\n");
> 
> @@ -430,13 +432,13 @@ static void *thread_run(void *arg __attribute__((unused)))
> 
>         while (threads_go == 0) ;
> 
> -       records_read += search_mem();
> +       records_thread = search_mem();
> 
>         if (verbose > 1)
>                 printf("Thread finished, %f seconds\n",
>                        difftime(time(NULL), start_time));
> 
> -       return NULL;
> +       return (void *)records_thread;
>  }
> 
>  static struct timeval difftimeval(struct timeval *end, struct timeval *start)
> @@ -454,6 +456,7 @@ static void start_threads(void)
>         unsigned int i;
>         struct rusage start_ru, end_ru;
>         struct timeval usr_time, sys_time;
> +       unsigned int records_read = 0;
>         int err;
> 
>         if (verbose)
> @@ -484,11 +487,13 @@ static void start_threads(void)
>          */
> 
>         for (i = 0; i < threads; i++) {
> -               err = pthread_join(thread_array[i], NULL);
> +               uintptr_t record_thread;
> +               err = pthread_join(thread_array[i], (void *)&record_thread);
>                 if (err) {
>                         fprintf(stderr, "Error joining thread %d\n", i);
>                         exit(1);
>                 }
> +               records_read += record_thread;
>         }
> 
>         if (verbose)
> 
> 
Thank you for your review and insightful suggestions. Approach of
leveraging pthread_join() to naturally serialize the code and retrieve
the records_thread value is certainly elegant. By doing so, we can avoid
the overhead of mutex initialization and destruction, making the code
cleaner and readable.

I appreciate your expertise and input on this matter. I'll incorporate
your suggestions and send out the next version of the patch soon.

vishalc
>>  static void usage(void)
>>  {
>>  	fprintf(stderr, "Usage: %s [options]\n"
>> @@ -430,7 +432,9 @@ static void *thread_run(void *arg __attribute__((unused)))
>>  
>>  	while (threads_go == 0) ;
>>  
>> +	pthread_mutex_lock(&records_read_lock);
>>  	records_read += search_mem();
>> +	pthread_mutex_unlock(&records_read_lock);
>>  
>>  	if (verbose > 1)
>>  		printf("Thread finished, %f seconds\n",
>> @@ -456,6 +460,12 @@ static void start_threads(void)
>>  	struct timeval usr_time, sys_time;
>>  	int err;
>>  
>> +	/* Initialize the mutex before starting the threads */
>> +	if (pthread_mutex_init(&records_read_lock, NULL) != 0) {
>> +		fprintf(stderr, "Failed to initialize mutex\n");
>> +		exit(1);
>> +	}
>> +
>>  	if (verbose)
>>  		printf("Threads starting\n");
>>  
>> @@ -491,6 +501,8 @@ static void start_threads(void)
>>  		}
>>  	}
>>  
>> +	pthread_mutex_destroy(&records_read_lock);
>> +
>>  	if (verbose)
>>  		printf("Threads finished\n");
>>  
>> -- 
>> 2.39.3
>>
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
