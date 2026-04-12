Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DD4E937E0
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 12:36:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC4ED3E2683
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 14:36:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE053CF0FF
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 14:35:46 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7637B6002A5
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 14:35:45 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CAHXUr2164071; Sun, 12 Apr 2026 12:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mYEChG
 GSdRle+3tM2jBhslJV50qAf2HC+bH/dFZHiZE=; b=KS8AvCeqZtxoDEw908DKJe
 2JK+pibE5gpNrSNvafRtLBLwnDYtN4J7EBJj2il9f0XQU8atDco1U+dgF5uG+f/s
 QXV6URdqXD+moRDKAF+7XPnjqE5OXisYo7aIYnZBfKuMKXUKbqc3lJcKxmad1FE0
 ppEhJ1eNNkC3qn1S91GzWSvPh20qM7XktcTOqcHZ2de8kCb5XPhdX2oGj//V50C/
 hYmAgnb5ZUm18OLljEvIw3pON6teH6eptWlkqsXHAqZgCthHoeVLwbdLnCQYtEbC
 A5AMewcB6aOeyZ7fhhFuR451tAbEdcaq0uX1TdEIuhhtKBjDdu95mZCWmm3zXUSg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3ky5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 12:35:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63C9YcPv026284;
 Sun, 12 Apr 2026 12:35:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2uj98hp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 12:35:42 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63CCZfab28508898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 Apr 2026 12:35:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E182A58056;
 Sun, 12 Apr 2026 12:35:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8251C58052;
 Sun, 12 Apr 2026 12:35:39 +0000 (GMT)
Received: from [9.39.25.30] (unknown [9.39.25.30])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 Apr 2026 12:35:39 +0000 (GMT)
Message-ID: <88278cf9-82ae-4c02-8067-761cdb10a635@linux.ibm.com>
Date: Sun, 12 Apr 2026 18:05:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260407062336.127454-1-samir@linux.ibm.com>
 <20260407095418.GA17565@pevik>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260407095418.GA17565@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7n66jT8oyishXv7l0CeyzMQqx5qpQUIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDExOSBTYWx0ZWRfX4dmEogsNglRW
 D68G6TzmTFGzzBrdkOlfL4/MLB3pUC05q35BmBzSykw6vPxtXf3lJdNGGV+qZnURXrr/Pue0fdO
 JuezfnzJWkiobNzPqvEA5NZ8uLdtkLcao2ZLm3cApMLsLX2WGVrfdTZ2ncJbqtIYQ1d0NUR4lsm
 LubwVIaLj/2MPTi3FvBKklBkr4A5U2oyqfXSZA5WaaqRVNSyfnMYU4zRXwFUdik89YfG0lXZ0ay
 72leP5UTXMx69wIUVwvT+ZHt5A5proq4/eCHWqQGRuN0Af8nlCR67DPTSfHhS8tQKjA0guysiLr
 4peB2z49jDUUDnvUMMOyKJ/K9TQlUOqEqnCTBwDEsELmuPVd9xoW7gkvfGhRUpFY/Rhfnfge8j0
 JqhPv74od301V08iFfmjlhZvFouvLkdLxgJmT8iuuS6acKKler4+yi/njGcdhmNpHLl91B4FaJe
 HcWVQe+gpKN4s8fIqEA==
X-Proofpoint-GUID: 7n66jT8oyishXv7l0CeyzMQqx5qpQUIj
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69db919f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Tty9oNO6AAAA:8 a=R93Jy7f2AAAA:8 a=JfrnYn6hAAAA:8
 a=QyXUC8HyAAAA:8 a=ybZZDoGAAAAA:8 a=rCj4OHjsXE2XUgc9fzYA:9 a=QEXdDO2ut3YA:10
 a=Bts-Es6F1CBXvF7u4C_G:22 a=_4ULuFcjZWfTdIrHNsp6:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120119
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cfs-scheduler: Fixed "make check" errors and
 warnings.
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


On 07/04/26 3:24 pm, Petr Vorel wrote:
> Hi Samir,
>
>> Fixed all make check errors and warnings in cfs_bandwidth01.c and
>> hackbench.c to comply with LTP coding style.
> I guess you get that info with make check (which is using checkpatch.pl and
> other code).
>
>> cfs_bandwidth01.c:
>> - Remove initialization of static variable to 0
>> hackbench.c:
> FYI hackbench.c would deserve to rewrite into new C API. With that many of your
> fixes would be not needed because the old code would be deleted.
>
>> - Add SPDX-License-Identifier header
>> - Remove FSF mailing address paragraph
>> - Remove filename from file header
>> - Remove initialization of static variables to 0
>> - Convert zero-length array to C99 flexible array
>> - Modify barf() function to accept variadic arguments
>> - Use __func__ instead of hardcoded function names
>> - Separate assignments from if conditions
>> - Fix pointer declaration spacing
>> - Add blank line after declarations
>> - Fix spacing in macro and struct initialization
>> - Remove unnecessary braces for single statement
>> Both files now pass make check validation with 0 errors and 0 warnings.
>> Signed-off-by: Samir <samir@linux.ibm.com>
>> ---
>>   .../sched/cfs-scheduler/cfs_bandwidth01.c     |   2 +-
>>   .../kernel/sched/cfs-scheduler/hackbench.c    | 121 +++++++++---------
>>   2 files changed, 58 insertions(+), 65 deletions(-)
>> diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
>> index e52858f8e..8c511f060 100644
>> --- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
>> +++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
>> @@ -35,7 +35,7 @@
>>   static struct tst_cg_group *cg_level2, *cg_level3a, *cg_level3b;
>>   static struct tst_cg_group *cg_workers[3];
>> -static int may_have_waiters = 0;
>> +static int may_have_waiters;
> +1
>
>>   static void set_cpu_quota(const struct tst_cg_group *const cg,
>>   			  const float quota_percent)
>> diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
>> index 6f37060aa..6a30e1cc8 100644
>> --- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
>> +++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
>> @@ -1,51 +1,33 @@
>> -/******************************************************************************/
>> -/* Copyright Rusty Russell,                                                   */
>> -/* Copyright Pierre Peiffer                                                   */
>> -/* Copyright Zhang, Yanmin,                                                   */
>> -/* Copyright Ingo Molnar,                                                     */
>> -/* Copyright Arjan van de Ven,                                                */
>> -/* Copyright (c) International Business Machines  Corp., 2008                 */
>> -/*                                                                            */
>> -/* This program is free software;  you can redistribute it and/or modify      */
>> -/* it under the terms of the GNU General Public License as published by       */
>> -/* the Free Software Foundation; either version 2 of the License, or          */
>> -/* (at your option) any later version.                                        */
>> -/*                                                                            */
>> -/* This program is distributed in the hope that it will be useful,            */
>> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
>> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
>> -/* the GNU General Public License for more details.                           */
>> -/*                                                                            */
>> -/* You should have received a copy of the GNU General Public License          */
>> -/* along with this program;  if not, write to the Free Software               */
>> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
>> -/*                                                                            */
>> -/******************************************************************************/
>> -
>> -/******************************************************************************/
>> -/*                                                                            */
>> -/* File:        hackbench.c                                                   */
>> -/*                                                                            */
>> -/* Description: hackbench tests the Linux scheduler. Test groups of 20        */
>> -/*              processes spraying to 20 receivers                            */
>> -/*                                                                            */
>> -/* Total Tests: 1                                                             */
>> -/*                                                                            */
>> -/* Test Name:   hackbench01 and hackbench02                                   */
>> -/*                                                                            */
>> -/* Test Assertion:                                                            */
>> -/*                                                                            */
>> -/* Author(s):   Rusty Russell <rusty@rustcorp.com.au>,                        */
>> -/*              Pierre Peiffer <pierre.peiffer@bull.net>,                     */
>> -/*              Ingo Molnar <mingo@elte.hu>,                                  */
>> -/*              Arjan van de Ven <arjan@infradead.org>,                       */
>> -/*              "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,               */
>> -/*              Nathan Lynch <ntl@pobox.com>                                  */
>> -/*                                                                            */
>> -/* History:     Included into LTP                                             */
>> -/*                  - June 26 2008 - Subrata Modak<subrata@linux.vnet.ibm.com>*/
>> -/*                                                                            */
>> -/******************************************************************************/
>> +// SPDX-License-Identifier: GPL-2.0-or-later
> FYI we add SPDX only to files which has been converted into new LTP API. I'm ok
> to change it, but it would require to add additional cleanup.
>
>> +/*
>> + * Copyright Rusty Russell,
>> + * Copyright Pierre Peiffer
>> + * Copyright Zhang, Yanmin,
>> + * Copyright Ingo Molnar,
>> + * Copyright Arjan van de Ven,
> I know it's not your addition, but I wonder if a copyright without year even
> makes sense.
>
>> + * Copyright (c) International Business Machines  Corp., 2008
>> + */
>> +
>> +/*
>> + * Description: hackbench tests the Linux scheduler. Test groups of 20
>> + * processes spraying to 20 receivers
> Missing dot at the end.
>
>> + *
>> + * Total Tests: 1
> Useless, please remove.
>> + *
>> + * Test Name:   hackbench01 and hackbench02
> Useless, please remove (it can change anyway).
>> + *
>> + * Test Assertion:
> Useless, please remove.
>> + *
>> + * Author(s):   Rusty Russell <rusty@rustcorp.com.au>,
>> + *              Pierre Peiffer <pierre.peiffer@bull.net>,
>> + *              Ingo Molnar <mingo@elte.hu>,
>> + *              Arjan van de Ven <arjan@infradead.org>,
>> + *              "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
>> + *              Nathan Lynch <ntl@pobox.com>
> Hm, how about to add their mails in copyright section and remove this?
>
>> + *
>> + * History:     Included into LTP
>> + *                  - June 26 2008 - Subrata Modak<subrata@linux.vnet.ibm.com>
> I would remove this (we have git history anyway) and move him to copyright
> section.
>
>> + */
>>   #include <pthread.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>> @@ -58,25 +40,26 @@
>>   #include <sys/time.h>
>>   #include <sys/poll.h>
>>   #include <limits.h>
>> +#include <stdarg.h>
>> -#define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
>> +#define SAFE_FREE(p) { if (p) { free(p); (p) = NULL; } }
>>   #define DATASIZE 100
>>   static struct sender_context **snd_ctx_tab;	/*Table for sender context pointers. */
>>   static struct receiver_context **rev_ctx_tab;	/*Table for receiver context pointers. */
>> -static int gr_num = 0;		/*For group calculation */
>> +static int gr_num;		/*For group calculation */
>>   static unsigned int loops = 100;
>>   /*
>>    * 0 means thread mode and others mean process (default)
>>    */
>>   static unsigned int process_mode = 1;
>> -static int use_pipes = 0;
>> +static int use_pipes;
> +1
>
>>   struct sender_context {
>>   	unsigned int num_fds;
>>   	int ready_out;
>>   	int wakefd;
>> -	int out_fds[0];
>> +	int out_fds[];
>>   };
>>   struct receiver_context {
>> @@ -86,9 +69,14 @@ struct receiver_context {
>>   	int wakefd;
>>   };
>> -static void barf(const char *msg)
>> +static void barf(const char *fmt, ...)
>>   {
>> -	fprintf(stderr, "%s (error: %s)\n", msg, strerror(errno));
>> +	va_list args;
>> +
>> +	va_start(args, fmt);
>> +	vfprintf(stderr, fmt, args);
>> +	va_end(args);
>> +	fprintf(stderr, " (error: %s)\n", strerror(errno));
>>   	exit(1);
> FYI in new C API we have tst_brk() and tst_res().
>>   }
>> @@ -108,18 +96,18 @@ static void fdpair(int fds[2])
>>   		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
>>   			return;
>>   	}
>> -	barf("Creating fdpair");
>> +	barf("Creating %s", __func__);
> Adding va_*() just to post the name of the function looks useless for me.
> Please drop this change.
>
>>   }
>>   /* Block until we're ready to go */
>>   static void ready(int ready_out, int wakefd)
>>   {
>>   	char dummy;
>> -	struct pollfd pollfd = {.fd = wakefd,.events = POLLIN };
>> +	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN };
>>   	/* Tell them we're ready. */
>>   	if (write(ready_out, &dummy, 1) != 1)
>> -		barf("CLIENT: ready write");
>> +		barf("CLIENT: %s write", __func__);
>>   	/* Wait for "GO" signal */
>>   	if (poll(&pollfd, 1, -1) != 1)
>> @@ -210,7 +198,8 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
>>   		barf("pthread_attr_setstacksize");
>>   #endif
>> -	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
>> +	err = pthread_create(&childid, &attr, func, ctx);
>> +	if (err != 0) {
>>   		fprintf(stderr, "pthread_create failed: %s (%d)\n",
>>   			strerror(err), err);
>>   		exit(-1);
>> @@ -235,11 +224,12 @@ void reap_worker(pthread_t id)
>>   }
>>   /* One group of senders and receivers */
>> -static unsigned int group(pthread_t * pth,
>> +static unsigned int group(pthread_t *pth,
>>   			  unsigned int num_fds, int ready_out, int wakefd)
>>   {
>>   	unsigned int i;
>>   	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context) + num_fds * sizeof(int));
>> +
>>   	if (!snd_ctx)
>>   		barf("malloc()");
>>   	else
>> @@ -305,8 +295,11 @@ int main(int argc, char *argv[])
>>   		argv++;
>>   	}
>> -	if (argc >= 2 && (num_groups = atoi(argv[1])) == 0)
>> -		print_usage_exit();
>> +	if (argc >= 2) {
>> +		num_groups = atoi(argv[1]);
>> +		if (num_groups == 0)
>> +			print_usage_exit();
>> +	}
> +1, assigning variables is really better out of if / while,
> although here it's safe, because num_groups is initialized to 10.
>
> Kind regards,
> Petr
>
>>   	printf("Running with %d*40 (== %d) tasks.\n",
>>   	       num_groups, num_groups * 40);
>> @@ -329,7 +322,7 @@ int main(int argc, char *argv[])
>>   	snd_ctx_tab = malloc(num_groups * sizeof(void *));
>>   	rev_ctx_tab = malloc(num_groups * num_fds * sizeof(void *));
>>   	if (!pth_tab || !snd_ctx_tab || !rev_ctx_tab)
>> -		barf("main:malloc()");
>> +		barf("%s:malloc()", __func__);
>>   	fdpair(readyfds);
>>   	fdpair(wakefds);
>> @@ -363,9 +356,8 @@ int main(int argc, char *argv[])
>>   	/* free the memory */
>>   	for (i = 0; i < num_groups; i++) {
>> -		for (j = 0; j < num_fds; j++) {
>> +		for (j = 0; j < num_fds; j++)
>>   			SAFE_FREE(rev_ctx_tab[i * num_fds + j])
>> -		}
> +1
>>   		SAFE_FREE(snd_ctx_tab[i]);
>>   	}
>>   	SAFE_FREE(pth_tab);
>> @@ -373,3 +365,4 @@ int main(int argc, char *argv[])
>>   	SAFE_FREE(rev_ctx_tab);
>>   	exit(0);
>>   }
>> +
Hi Petr,

I have incorporated the requested review comments and submitted the 
revised version (v2). Thank you for your valuable feedback.
Patch v2: 
https://lore.kernel.org/ltp/20260412122842.1074017-1-samir@linux.ibm.com/T/#u


Thanks,
Samir

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
