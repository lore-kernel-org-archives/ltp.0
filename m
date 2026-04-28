Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DB7FF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 11:14:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 892A93E28DF
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:14:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC55A3E28DF
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:14:05 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 081101A008B0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:14:03 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S6fC0r2585373; Tue, 28 Apr 2026 11:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3uRKdw
 v52ukjXXCHo7RCtaYIAECjkn2UCxRB0GPU+fs=; b=oL1UJPlRStyJZpRzuZsgLo
 DdooXbpZ9FbyExqXiOw3PvLgqqs1RRfpQSesKnknHK5CSWih+AftLIUpUXckBKPN
 MyctaPbdnvXxB/KKz4DTO9clMGDZmrCWez4brfZob8yHO3vDzm8kAne7GCrtpTyl
 VJF64NKaVGMIbYc1pPGE5O96SLDu5BnHSAhZJmS/WG+xemIn2aTxUCv9y2H2N2EL
 XTttb7zSXlT0po0Yz1l6VQ52ACDKjsXLBu01YcoZuDqYHqmDIeX/l+ce70A8xBoW
 fz9qjwjCPrRo728OBlECjUlklEPkRwIoTHhvFOcw/QcSauINH1GCWPprOd4N8p+w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb553sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 11:14:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SBCgqc024399;
 Tue, 28 Apr 2026 11:14:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g97ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 11:14:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SBDx9357541082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 11:13:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87CD258059;
 Tue, 28 Apr 2026 11:13:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94D5D58058;
 Tue, 28 Apr 2026 11:13:58 +0000 (GMT)
Received: from [9.123.9.99] (unknown [9.123.9.99])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 11:13:58 +0000 (GMT)
Message-ID: <7caefb9b-4694-4aeb-b6e2-38b235f71de0@linux.ibm.com>
Date: Tue, 28 Apr 2026 16:43:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>
References: <20260412122842.1074017-1-samir@linux.ibm.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260412122842.1074017-1-samir@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f09679 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Tty9oNO6AAAA:8 a=R93Jy7f2AAAA:8 a=JfrnYn6hAAAA:8
 a=QyXUC8HyAAAA:8 a=ybZZDoGAAAAA:8 a=MzNpcRfeCFv6TWDuB_oA:9 a=QEXdDO2ut3YA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=Bts-Es6F1CBXvF7u4C_G:22 a=_4ULuFcjZWfTdIrHNsp6:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=0RhZnL1DYvcuLYC8JZ5M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA5NyBTYWx0ZWRfX7Qufkzm4UhGL
 9tgm4LvIPPf3zwS7WIymQerXK74dXPIuPclwzkBe8m3qpa38RzuyxCvCHTzNZtFAnlR/od0uJiU
 cAQ44cQ9vliszLroqjSaepSkZZkYcrKjAwTuvD6en4JSPpDBjG8Zx4vtx5CLh7BlLjYPuHIegWs
 gZjeAD0UV0ep8XCEdq7qByBGN6O5/tx/wRjKgwqy/TqJT9wBZUBGGI7BtJ7V5+QPWgFBYqdhh+o
 RBoxTEDS1gxuWRTJc6LyiZvpjl5wUFxIM85hWumHR8AGnnZiKBEDNM50hZl6qsUJ2F3xZ2s6USX
 lVePFpfwbxwXsxZjBZUlxN5LMRldpNlpJdJdomM4LTONsbyBurWwphGrOkKJKrq/xhZ/ZLaPP1e
 O/pWN3venK+ciGIuZMTxx9Jqq61SnhUWIMTdpD1rRFOjYx/NqDu4c2sXVBIwqZJPJ7Vguy4djAp
 1XzM4bgwA1qU7JJPDxA==
X-Proofpoint-GUID: 5uUBxCthJZPdw_aG7nCyGqyJEWD5zrMA
X-Proofpoint-ORIG-GUID: 5uUBxCthJZPdw_aG7nCyGqyJEWD5zrMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280097
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cfs-scheduler: Fixed "make check" errors and
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 12/04/26 5:58 pm, Samir wrote:
> Fixed all make check errors and warnings in cfs_bandwidth01.c and
> hackbench.c to comply with LTP coding style.
>
> cfs_bandwidth01.c:
> - Remove initialization of static variable to 0
>
> Patch v1: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/
>
> Addressed review comments from patch v1 -> patch v2
> hackbench.c:
> - Drop SPDX-License-Identifier header addition.
> - Remove obsolete header metadata.
> - Keep short description and add trailing period.
> - Remove initialization of static variables to 0.
> - Convert zero-length array to C99 flexible array.
> - Drop variadic barf() change.
> - Drop __func__-based error messages.
> - Separate assignments from if conditions.
> - Fix pointer declaration spacing.
> - Add blank line after declarations.
> - Fix spacing in macro and struct initialization.
> - Remove unnecessary braces for single statement.
> - Use Authors block for contributor attribution.
>
> Signed-off-by: Samir <samir@linux.ibm.com>
> ---
>   .../sched/cfs-scheduler/cfs_bandwidth01.c     |  2 +-
>   .../kernel/sched/cfs-scheduler/hackbench.c    | 71 ++++++-------------
>   2 files changed, 24 insertions(+), 49 deletions(-)
>
> diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> index e52858f8e..8c511f060 100644
> --- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> +++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> @@ -35,7 +35,7 @@
>   
>   static struct tst_cg_group *cg_level2, *cg_level3a, *cg_level3b;
>   static struct tst_cg_group *cg_workers[3];
> -static int may_have_waiters = 0;
> +static int may_have_waiters;
>   
>   static void set_cpu_quota(const struct tst_cg_group *const cg,
>   			  const float quota_percent)
> diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
> index 6f37060aa..846985e3b 100644
> --- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
> +++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
> @@ -1,49 +1,20 @@
>   /******************************************************************************/
> -/* Copyright Rusty Russell,                                                   */
> -/* Copyright Pierre Peiffer                                                   */
> -/* Copyright Zhang, Yanmin,                                                   */
> -/* Copyright Ingo Molnar,                                                     */
> -/* Copyright Arjan van de Ven,                                                */
>   /* Copyright (c) International Business Machines  Corp., 2008                 */
>   /*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> +/* Authors: Rusty Russell <rusty@rustcorp.com.au>                             */
> +/*          Pierre Peiffer <pierre.peiffer@bull.net>                          */
> +/*          Ingo Molnar <mingo@elte.hu>                                       */
> +/*          Arjan van de Ven <arjan@infradead.org>                            */
> +/*          "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>                    */
> +/*          Nathan Lynch <ntl@pobox.com>                                      */
> +/*          Subrata Modak <subrata@linux.vnet.ibm.com>                        */
>   /*                                                                            */
>   /******************************************************************************/
>   
>   /******************************************************************************/
>   /*                                                                            */
> -/* File:        hackbench.c                                                   */
> -/*                                                                            */
>   /* Description: hackbench tests the Linux scheduler. Test groups of 20        */
> -/*              processes spraying to 20 receivers                            */
> -/*                                                                            */
> -/* Total Tests: 1                                                             */
> -/*                                                                            */
> -/* Test Name:   hackbench01 and hackbench02                                   */
> -/*                                                                            */
> -/* Test Assertion:                                                            */
> -/*                                                                            */
> -/* Author(s):   Rusty Russell <rusty@rustcorp.com.au>,                        */
> -/*              Pierre Peiffer <pierre.peiffer@bull.net>,                     */
> -/*              Ingo Molnar <mingo@elte.hu>,                                  */
> -/*              Arjan van de Ven <arjan@infradead.org>,                       */
> -/*              "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,               */
> -/*              Nathan Lynch <ntl@pobox.com>                                  */
> -/*                                                                            */
> -/* History:     Included into LTP                                             */
> -/*                  - June 26 2008 - Subrata Modak<subrata@linux.vnet.ibm.com>*/
> +/*              processes spraying to 20 receivers.                           */
>   /*                                                                            */
>   /******************************************************************************/
>   #include <pthread.h>
> @@ -59,24 +30,24 @@
>   #include <sys/poll.h>
>   #include <limits.h>
>   
> -#define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
> +#define SAFE_FREE(p) { if (p) { free(p); (p) = NULL; } }
>   #define DATASIZE 100
>   static struct sender_context **snd_ctx_tab;	/*Table for sender context pointers. */
>   static struct receiver_context **rev_ctx_tab;	/*Table for receiver context pointers. */
> -static int gr_num = 0;		/*For group calculation */
> +static int gr_num;		/*For group calculation */
>   static unsigned int loops = 100;
>   /*
>    * 0 means thread mode and others mean process (default)
>    */
>   static unsigned int process_mode = 1;
>   
> -static int use_pipes = 0;
> +static int use_pipes;
>   
>   struct sender_context {
>   	unsigned int num_fds;
>   	int ready_out;
>   	int wakefd;
> -	int out_fds[0];
> +	int out_fds[];
>   };
>   
>   struct receiver_context {
> @@ -115,7 +86,7 @@ static void fdpair(int fds[2])
>   static void ready(int ready_out, int wakefd)
>   {
>   	char dummy;
> -	struct pollfd pollfd = {.fd = wakefd,.events = POLLIN };
> +	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN };
>   
>   	/* Tell them we're ready. */
>   	if (write(ready_out, &dummy, 1) != 1)
> @@ -210,7 +181,8 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
>   		barf("pthread_attr_setstacksize");
>   #endif
>   
> -	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
> +	err = pthread_create(&childid, &attr, func, ctx);
> +	if (err != 0) {
>   		fprintf(stderr, "pthread_create failed: %s (%d)\n",
>   			strerror(err), err);
>   		exit(-1);
> @@ -235,11 +207,12 @@ void reap_worker(pthread_t id)
>   }
>   
>   /* One group of senders and receivers */
> -static unsigned int group(pthread_t * pth,
> +static unsigned int group(pthread_t *pth,
>   			  unsigned int num_fds, int ready_out, int wakefd)
>   {
>   	unsigned int i;
>   	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context) + num_fds * sizeof(int));
> +
>   	if (!snd_ctx)
>   		barf("malloc()");
>   	else
> @@ -305,8 +278,11 @@ int main(int argc, char *argv[])
>   		argv++;
>   	}
>   
> -	if (argc >= 2 && (num_groups = atoi(argv[1])) == 0)
> -		print_usage_exit();
> +	if (argc >= 2) {
> +		num_groups = atoi(argv[1]);
> +		if (num_groups == 0)
> +			print_usage_exit();
> +	}
>   
>   	printf("Running with %d*40 (== %d) tasks.\n",
>   	       num_groups, num_groups * 40);
> @@ -363,9 +339,8 @@ int main(int argc, char *argv[])
>   
>   	/* free the memory */
>   	for (i = 0; i < num_groups; i++) {
> -		for (j = 0; j < num_fds; j++) {
> +		for (j = 0; j < num_fds; j++)
>   			SAFE_FREE(rev_ctx_tab[i * num_fds + j])
> -		}
>   		SAFE_FREE(snd_ctx_tab[i]);
>   	}
>   	SAFE_FREE(pth_tab);


Hi,

I wanted to gently follow up on this patch submission. If you have any 
feedback or concerns, I'm happy to address them and submit a revised 
version.

Thank you for your time and consideration.

Best regards,
Samir (samir@linux.ibm.com)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
