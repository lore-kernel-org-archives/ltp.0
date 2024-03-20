Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B507C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 09:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87B4D3CE66A
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 10:02:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 484C63CD424
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:01:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41532140E7BB
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 10:01:14 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42K8uMaH006870; Wed, 20 Mar 2024 09:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=icZLerUsnBYjQvSvmzjDTv4vDdy4LpV+1AcBeH3do6M=;
 b=s8qh3/MzHekjJ43L47SKFhVCik4JrMvavA5vYf+3oWfhcriJgtBqgOqRV4xH2dLa/tM9
 1lic0z8cFvtlFGEIpQRSL2N/8MevC3yMpwhCXrrWW09B3vK3XczRB7YkBNqyddaYYyfW
 tdgZKUcMHPZ/yPtKe70JUijbMAF32fXPFyyFBJHvoJIjFu0DwxISAW5K7cra9pLQxFUU
 fYr2HHESrZwFBocLfLkSIkcM8p4OnSbOBP46zfgEP0yfSTH+zODxQ/o48HguTIX+ub/6
 N3Z3LHhHGQAWfHNrUBEB5o+DWVqk/hf/PnWLQGs5AxcI7VYjgvAmhRmtXIJR/6C9iDMq tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyt5nr9j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 09:01:11 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42K8vt68008365;
 Wed, 20 Mar 2024 09:01:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyt5nr9hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 09:01:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42K6sufW010083; Wed, 20 Mar 2024 09:01:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav2960-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 09:01:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42K916Jk11862278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 09:01:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FED820040;
 Wed, 20 Mar 2024 09:01:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A63D20043;
 Wed, 20 Mar 2024 09:01:06 +0000 (GMT)
Received: from [9.152.212.129] (unknown [9.152.212.129])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2024 09:01:06 +0000 (GMT)
Message-ID: <84d44ee1-4f1e-453a-8c8b-df837cfe4efe@linux.ibm.com>
Date: Wed, 20 Mar 2024 10:01:06 +0100
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240320063218.449072-1-pvorel@suse.cz>
 <20240320063218.449072-2-pvorel@suse.cz>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20240320063218.449072-2-pvorel@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EAoyL3eDfoCPXnjtNOh9-AyBHZdKc-Cj
X-Proofpoint-ORIG-GUID: qvNWC8ZMrX6fli0mPkhgFv6YOAwq6TJr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1011 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200071
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 3/20/24 07:32, Petr Vorel wrote:
> From: Mete Durlu <meted@linux.ibm.com>
> 
> When SElinux is in enforcing state and SEpolicies disallow anonymous
> pipe usage with fanotify_mark(), related fanotify14 testcases fail with
> EACCES instead of EINVAL. Accept both errnos when SElinux is in
> enforcing state to correctly evaluate test results.
> 
> Replace TST_EXP_FD_OR_FAIL with TST_EXP_FAIL when testing
> fanotify_mark() as it returns -1 on failure and 0 on success not a file
> descriptor.
> 
> Co-developed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks good to me! Thanks for handling this.

> ---
> Hi,
> 
> this is a replacement of Mete's v2 fanotify14: fix anonymous pipe testcases:
> https://lore.kernel.org/ltp/20240312120829.178305-2-meted@linux.ibm.com/
> 
> Kind regards,
> Petr
> 
>   .../kernel/syscalls/fanotify/fanotify14.c     | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
> index d02d81495..b554af22a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
> @@ -30,6 +30,7 @@
>   
>   #ifdef HAVE_SYS_FANOTIFY_H
>   #include "fanotify.h"
> +#include "tst_selinux.h"
>   
>   #define MNTPOINT "mntpoint"
>   #define FILE1 MNTPOINT"/file1"
> @@ -47,6 +48,7 @@ static int pipes[2] = {-1, -1};
>   static int fanotify_fd;
>   static int ignore_mark_unsupported;
>   static int filesystem_mark_unsupported;
> +static int se_enforcing;
>   static unsigned int supported_init_flags;
>   
>   struct test_case_flags_t {
> @@ -283,9 +285,18 @@ static void do_test(unsigned int number)
>   
>   	tst_res(TINFO, "Testing %s with %s",
>   		tc->mark.desc, tc->mask.desc);
> -	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> -					 tc->mask.flags, dirfd, path),
> -					 tc->expected_errno);
> +
> +	if (tc->pfd && se_enforcing) {
> +		const int exp_errs[] = {tc->expected_errno, EACCES};
> +
> +		TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> +				 tc->mask.flags, dirfd, path),
> +				 exp_errs);
> +	} else {
> +		TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> +						 tc->mask.flags, dirfd, path),
> +						 tc->expected_errno);
> +	}
>   
>   	/*
>   	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
> @@ -334,6 +345,8 @@ static void do_setup(void)
>   	SAFE_FILE_PRINTF(FILE1, "0");
>   	/* Create anonymous pipes to place marks on */
>   	SAFE_PIPE2(pipes, O_CLOEXEC);
> +
> +	se_enforcing = tst_selinux_enforcing();
>   }
>   
>   static void do_cleanup(void)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
