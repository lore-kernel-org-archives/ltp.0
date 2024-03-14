Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AADC54E5D
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 08:35:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2D2E3CFCDE
	for <ltp@archiver.kernel.org>; Thu, 14 Mar 2024 09:35:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DA143CD7F4
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 09:35:06 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 98CB91410639
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 09:35:03 +0100 (CET)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42E87TRJ022915; Thu, 14 Mar 2024 08:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VPFK+CkwylACAqmeu3kHqGVFqQiAi8iQmer9TO/9qA8=;
 b=OEUfUKeARe/J06Si2zmIeddZ96gc6met8mE65yft6vg45CjXQqrTp8n0/gWsFQAcgKeL
 yCsNux0j01YLtLu7dRe3hYOa4EEWsL1nqWIHLvUYTTCwC7xVQI0vLvZLdKQvr4yLVYgJ
 4m+OVh52JIpPNygpaaSDYVYqtw2ET2gSN6vRYFIlizZlfiSpZN+SYg0MYqIXShP3tjCc
 GB4g2USGW3ByCMGKRZT+g7Y7gMR9IIMjapcr/F/cgFweHjduwh12ViNCN0vyP6woOTGy
 e+kRikMDbbej2UqmYd9P1GPSntNOOZ3ScEDPHu82Gzjb/kNa41CYamTWlGC3y6AZ/JjI Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuwevgca0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 08:35:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42E8Z1Dm024399;
 Thu, 14 Mar 2024 08:35:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuwevgc9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 08:35:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42E5hPV0018155; Thu, 14 Mar 2024 08:35:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tkx7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Mar 2024 08:35:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42E8YvnX38863236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Mar 2024 08:34:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36D972004F;
 Thu, 14 Mar 2024 08:34:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0977D20043;
 Thu, 14 Mar 2024 08:34:57 +0000 (GMT)
Received: from [9.152.212.129] (unknown [9.152.212.129])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Mar 2024 08:34:56 +0000 (GMT)
Message-ID: <d1aab4a0-dde7-4c18-ba94-3fe0bd5a545c@linux.ibm.com>
Date: Thu, 14 Mar 2024 09:34:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Amir Goldstein <amir73il@gmail.com>
References: <20240312120829.178305-1-meted@linux.ibm.com>
 <20240312120829.178305-2-meted@linux.ibm.com>
 <CAOQ4uxgPK=t25OvBcevkQseFEr9S6p7PtU35p8T+snzqzN+ndg@mail.gmail.com>
 <20240313072623.GA519991@pevik>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20240313072623.GA519991@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U2eyjNPM80l-mf6pasPKLRrHODuSnCEQ
X-Proofpoint-ORIG-GUID: ohsrdSB8FjCBqaI2kRRpEE3W4KkFQZa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_05,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140058
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] fanotify14: fix anonymous pipe testcases
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

On 3/13/24 08:26, Petr Vorel wrote:

Hi,

thanks for the review. I can send a v3 with the suggested changes if
that will make things easier. Just let me know.

>>>          if (tc->pfd) {
>>>                  dirfd = tc->pfd[0];
>>>                  path = NULL;
>>> +               se_enforcing = is_selinux_enforcing();
> nit: this check should be in the setup function to be done only once.
> (by default it's done twice, because we have 2 testcases with pfd, we support
> -iN parameter, thus it's actually 2*N.). I'll fix it before merge.
>>>          }
>
Nice catch! I fully forgot that there was a setup function while I
was trying to find the best TST_ macro to use.

>>>          tst_res(TINFO, "Testing %s with %s",
>>>                  tc->mark.desc, tc->mask.desc);
>>> -       TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
>>> -                                        tc->mask.flags, dirfd, path),
>>> -                                        tc->expected_errno);
>>> +
>>> +       if (tc->pfd && se_enforcing) {
>>> +               const int exp_errs[] = {tc->expected_errno, EACCES};
>>> +
>>> +               TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
>>> +                                tc->mask.flags, dirfd, path),
>>> +                                exp_errs);
>>> +       } else {
>>> +               TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
>>> +                                                tc->mask.flags, dirfd, path),
>>> +                                                tc->expected_errno);
>>> +       }
> 
> 
>> This looks fine to me, but on second thought I am not sure how important
>> it is to special case se_enforcing.
>> We could probably always check for either error value.
> 
> I don't mind explicitly testing EACCES with SELinux. @Jan WDYT?
> 
> With a diff below (I can change it before merge + I would do the following work
> to integrate this into the LTP C API):
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> diff --git testcases/kernel/syscalls/fanotify/fanotify14.c testcases/kernel/syscalls/fanotify/fanotify14.c
> index 52c327dff..89d59c8b2 100644
> --- testcases/kernel/syscalls/fanotify/fanotify14.c
> +++ testcases/kernel/syscalls/fanotify/fanotify14.c
> @@ -49,6 +49,7 @@ static int pipes[2] = {-1, -1};
>   static int fanotify_fd;
>   static int ignore_mark_unsupported;
>   static int filesystem_mark_unsupported;
> +static int se_enforcing;
>   static unsigned int supported_init_flags;
>   
>   struct test_case_flags_t {
> @@ -290,12 +291,10 @@ static void do_test(unsigned int number)
>   	/* Set mark on non-dir only when expecting error ENOTDIR */
>   	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
>   	int dirfd = AT_FDCWD;
> -	int se_enforcing = 0;
>   
>   	if (tc->pfd) {
>   		dirfd = tc->pfd[0];
>   		path = NULL;
> -		se_enforcing = is_selinux_enforcing();
>   	}
>   
>   	tst_res(TINFO, "Testing %s with %s",
> @@ -360,6 +359,8 @@ static void do_setup(void)
>   	SAFE_FILE_PRINTF(FILE1, "0");
>   	/* Create anonymous pipes to place marks on */
>   	SAFE_PIPE2(pipes, O_CLOEXEC);
> +
> +	se_enforcing = is_selinux_enforcing();
>   }
>   
>   static void do_cleanup(void)
>> Let's see what Jan and Petr think.
> 
>> Thanks,
>> Amir.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
