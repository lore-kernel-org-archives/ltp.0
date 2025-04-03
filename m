Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BFBC3600C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 11:13:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F15243CB28C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 13:13:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FC783CB26A
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 13:12:46 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1B645600698
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 13:12:45 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533ADVkv023842;
 Thu, 3 Apr 2025 11:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=w7aNEA
 69xk4m3gvYCySIt0tB32WU2x8hm0iYjb/pK/U=; b=ER9Y7OvE8r0L9nhB0gtEJ5
 JMThepmpqoz4NcantQn8X7MwmqlRtQXKptfiL2G0gc5FC20Bzjlri8LZnZzvS0uB
 AwbEnpd4KZebdIkeBSHgwR/LZO8bgqDvunt1lzk8tKbL9tg56XbBajfnWy/+zSY5
 pHowiK6PJ6/4F47Cd8BdY6osF9/Jmwa/iNU+84kj59aGlKPu/TIgAw5qQW+JtL6M
 ybWukLK0ZhxDiaN2hseZjRc3oJKUYHEYnhLXPksdt7wL7xs/Qg+bNegbdFQTJych
 75IFdKi5SaNYgipAFp+rF8DWU6DMHwBnS4baowUoqW+gP5IofVcxSoseXejvJkBA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45scdr352a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 11:12:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5339UmQ1019410;
 Thu, 3 Apr 2025 11:12:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6tcs0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 11:12:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 533BCfhF39715538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 11:12:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B41485805A;
 Thu,  3 Apr 2025 11:12:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EC6558052;
 Thu,  3 Apr 2025 11:12:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.96.231]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Apr 2025 11:12:41 +0000 (GMT)
Message-ID: <6ba619b6c56e2e09abc325831b206cb6dad539a1.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 03 Apr 2025 07:12:40 -0400
In-Reply-To: <20250402224148.435022-1-pvorel@suse.cz>
References: <20250402224148.435022-1-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SIwqtsTxbVXrPiCXtqi-mFHBW9J5n0eN
X-Proofpoint-GUID: SIwqtsTxbVXrPiCXtqi-mFHBW9J5n0eN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030042
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH] ima_violations.sh: Fix min kernel
 version for test4+
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

On Thu, 2025-04-03 at 00:41 +0200, Petr Vorel wrote:
> Although 79eb71fae5 claims test[4-8] require kernel 6.14, it's actually for 6.15.
> 2 kernel commits were part of integrity-v6.15 and merged into mainline
> as a2d4f473df11. They will be part of 6.15-rc1.
> 
> While at it, document these kernel commits.
> 
> Fixes: 79eb71fae5 ("ima_violations.sh: require kernel v6.14 for minimizing violations tests")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi, all,
> 
> I'm sorry not catching this:
> https://lore.kernel.org/linux-integrity/174319448478.2953471.5705766506609559454.pr-tracker-bot@kernel.org/T/#t
> 
> We got this because openSUSE Tumbleweed reached 6.14 few days ago.
> Merged as
> https://github.com/linux-test-project/ltp/commit/34e13f8a76e801b8f4c3444beed2ed358324066e
> 

Thanks, Peter!

> 
>  .../kernel/security/integrity/ima/tests/ima_violations.sh   | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index c6b929a233..1d2f1d9447 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -5,6 +5,8 @@
>  # Author: Mimi Zohar <zohar@linux.ibm.com>
>  #
>  # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
> +# test[4-6] test 6.15 commit 5b3cd801155f ("ima: limit the number of open-writers integrity violations")
> +# test[7-8] test 6.15 commit a414016218ca ("ima: limit the number of ToMToU integrity violations")
>  
>  TST_SETUP="setup"
>  TST_CLEANUP="cleanup"
> @@ -176,8 +178,8 @@ test4()
>  {
>  	tst_res TINFO "verify limiting single open writer violation"
>  
> -	if tst_kvcmp -lt 6.14; then
> -		tst_brk TCONF "Minimizing violations requires kernel 6.14 or newer"
> +	if tst_kvcmp -lt 6.15; then
> +		tst_brk TCONF "Minimizing violations requires kernel 6.15 or newer"
>  	fi
>  
>  	local search="open_writers"


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
