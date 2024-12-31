Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BD1E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 03:42:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 767DD3F02A4
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 04:42:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BCA23DB768
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 04:42:27 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3AF5F653724
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 04:42:25 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUE6FX6015984;
 Tue, 31 Dec 2024 03:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pn4vmw
 tkJMTYZiyVGk0aBMMJbSTZuD4L/EbNblNBloU=; b=Yw1BLGsLGOZDCJLcyHBwPO
 7vYzMp0GrS3vAE772wAwJA+nu9yeaDOjnt7+hBl7rfjUpFa2mnzON/eptX4p1E1d
 BF6NOayPLI/tPMf57a9+Mx2II6NJSOgpLndUKGlYiAo+6MTq2gVBAMbVY7mDEhPY
 kvrwMnwFCk+0tyFKKvETAbgRMGh1sE2U/I2fnK5UaihrFBMbMzOClZZ5IaErUdn+
 n8nSUvdLL49CzLH6xixkaBwpCYRyIYor9HSEoXjUV28F8W1XAhknJRz16hq7GOyx
 ej0hnKOSCdlNzQbuNdHKyghe2QwCNiaxlQWjpqPlCS5tIVYHl/9cuAfeviBUKKXQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43uw04jk71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 03:42:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BV066MS003996;
 Tue, 31 Dec 2024 03:42:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43twvjrgdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Dec 2024 03:42:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BV3gLbV62652798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Dec 2024 03:42:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D707058055;
 Tue, 31 Dec 2024 03:42:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6355A5804B;
 Tue, 31 Dec 2024 03:42:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.96.225]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Dec 2024 03:42:21 +0000 (GMT)
Message-ID: <d4fd124d03bc2e13d62abe97febeb34c2ffe1603.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Mon, 30 Dec 2024 22:42:20 -0500
In-Reply-To: <20241213222014.1580991-8-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-8-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H212Q2vQDwRqm0HW4etw1UabTl1Ar0Eb
X-Proofpoint-ORIG-GUID: H212Q2vQDwRqm0HW4etw1UabTl1Ar0Eb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310027
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/8] ima_violations.sh: Check for a required
 policy
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> Add check for ^func=FILE_CHECK'
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../kernel/security/integrity/ima/tests/ima_violations.sh    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 0f710dea2e..73b9fe6f30 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2009 IBM Corporation
> -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
>  # Author: Mimi Zohar <zohar@linux.ibm.com>
>  #
>  # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
> @@ -9,6 +9,7 @@
>  TST_SETUP="setup"
>  TST_CLEANUP="cleanup"
>  TST_CNT=3
> +REQUIRED_POLICY='^func=FILE_CHECK'

The first field of an IMA policy rule is the 'action', followed by the
condition. Use "func=FILE_CHECK" instead.

thanks,

Mimi

>  
>  setup()
>  {
> @@ -17,6 +18,8 @@ setup()
>  	LOG="/var/log/messages"
>  	PRINTK_RATE_LIMIT=
>  
> +	require_ima_policy_content_if_readable "$REQUIRED_POLICY"
> +
>  	if status_daemon auditd; then
>  		LOG="/var/log/audit/audit.log"
>  	elif tst_check_cmds sysctl; then


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
