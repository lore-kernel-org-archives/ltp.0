Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C414C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 14:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38BBF3E6CD8
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 16:44:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F00A93E6CD1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 16:44:15 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F90114004E1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 16:44:14 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CE1hqR3717373; Wed, 12 Aug 2026 14:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F9cYfb
 NFgAuCgOA9L7FHuLTcU+UBkQ8woPtBxnEZJ1I=; b=IBseWLAn829H22PkpprVvg
 cQD8yvYwJyY60edlINjppFMlAWitInnQn6KNGH7EPNl0ILmAW84r4N38jMTb3wQN
 suzV345E3xAwLh18nzijPlLErx0BwCVobr9PbQhpTrUlKD0EjYldY85DAHWbnsrX
 EH/xoYqivRoYWDadXbcLqjtuEcMdaVBaBXnNU+j6svQoWesBGjko4G0ZsOqsv1Om
 aYlfgxhdTxp0QO8YeVrLJXTDlHOftz4jNrM/IYXbSY+JJ23CgUyOy1qaEXFi5+af
 +kC+OarzRxikImeE8M/C7yyFwjhf3Z//gG6MnU+OSW6RmcceYhdIrfgxtIFwif2g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwa5k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 14:44:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CEfKT5022193;
 Wed, 12 Aug 2026 14:44:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h6dgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 14:44:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CEhXG120185756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 14:43:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D24995805A;
 Wed, 12 Aug 2026 14:44:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8579658056;
 Wed, 12 Aug 2026 14:44:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.3.228]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 14:44:11 +0000 (GMT)
Message-ID: <3c2f063b14532bacc78eb6ea4b0c2d72804c1ec9.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260810143344.1029588-1-pvorel@suse.cz>
References: <20260810143344.1029588-1-pvorel@suse.cz>
Date: Wed, 12 Aug 2026 10:44:11 -0400
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c86bd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2gWyPJ6rYJl2tcFwkygA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RVB7Cd4c43Lr0s_X6lhDAgPNnwuRFYZx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExOSBTYWx0ZWRfX9eZ1JoTprEl+
 yggts4dFjvtUr0tRqHzK4Ou5TNcDhU+5lyWe1NPAzA6qgxhUkVQIUdc/QfidGCThxNh30+qEzyy
 YVAA8PF6TOEDX2D0sXXmwyWidcK48CWPaZJSXeSDkfWlocVBy+3fdJBMEc1RUoydKayRUKOchfn
 rIxCEM5xC+b8XOrxiEDFhIVJ5Oed7Bzk+X+JemparUZuKxQnRnutyzn/WXaJmX3tmZR6AsIa/bW
 cvOELRx3plKN2316YFQyABiM2Uj+6edgl9Nshz6EZHYcsaccpOr+1rwSoquase5f5giE0vGvXf/
 qo23PG5/oBUbT57560Z+vl5R3OqlFR1FknxcJqRqToUclmtyJ3iS6QoNfexfmpZ5VlGoB/AYsuI
 OWFwnqP/lM97Dk4mMHithEDHPkZ0lDKgSUcVGCctGKebJ7TzhGo3yjtNVdcBEXwqG+WASMCFQY8
 UzIBueZZ0vevdcJcTSQ==
X-Proofpoint-ORIG-GUID: RVB7Cd4c43Lr0s_X6lhDAgPNnwuRFYZx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExOSBTYWx0ZWRfX8Fsg7Vzv1U96
 Fy+iCDcATW+NzIvyjLAWRls24a/uNssruKENl4ym4dUq/bWADtNl0oxYXvrOQJJiroK1Ol5W+lY
 H/KrCEpz4pxJkds3ibTyMC4SNtWn/CE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120119
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] ima_setup.sh: Fix check_policy_writable()
 for kernel < 4.5
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

On Mon, 2026-08-10 at 16:33 +0200, Petr Vorel wrote:
> Writing into policy via echo on kernel < 4.5 effectively makes policy
> not writable (no point to check if the policy is writable). Therefore
> skip this extra check in check_policy_writable() on these old kernels.
> 
> This change improves IMA testing on kernel < 4.5:
> 
> 1) Allows to run ima_policy.sh which was previously skipped:
> 
>     ima_policy 1 TINFO: verify that invalid policy isn't loaded
>     ima_policy 1 TCONF: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)
> 
> 2) Fixes failing ima_violations.sh, which was failing due policy was not
>    writable:
> 
>     ima_violations 1 TINFO: Tested kernel: Linux susetest 4.4.140
>     ima_violations 1 TINFO: booted with IMA policy: tcb
>     ima_violations 1 TINFO: using log /var/log/audit/audit.log
>     ima_violations 1 TINFO: verify open writers violation
>     ima_violations 1 TFAIL: open_writers violation not added
>     ima_violations 2 TINFO: verify ToMToU violation
>     ima_violations 2 TFAIL: ToMToU violation not added
>     ima_violations 3 TINFO: verify open_writers using mmapped files
>     tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
>     tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
>     tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
>     tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
>     ima_mmap.c:33: TPASS: test completed
>     ima_violations 3 TFAIL: open_writers violation not added
> 
> 3) Fixes failing ima_conditionals.sh -r uid and ima_conditionals.sh -r fowner
> 
>     ima_conditionals 1 TINFO: request 'uid'
>     tst_security.c:115: TINFO: SecureBoot sysfs file not available
>     ima_conditionals 1 TINFO: verify measuring user files when requested via uid
>     tst_rod: Failed to open '/sys/kernel/security/ima/policy' for writing: Permission denied
>     ima_conditionals 1 TBROK: echo measure uid=65534 > /sys/kernel/security/ima/policy failed
> 
>     ima_conditionals 1 TINFO: request 'fowner'
>     tst_security.c:115: TINFO: SecureBoot sysfs file not available
>     ima_conditionals 1 TINFO: verify measuring user files when requested via fowner
>     tst_rod: Failed to open '/sys/kernel/security/ima/policy' for writing: Permission denied
>     ima_conditionals 1 TBROK: echo measure fowner=65534 > /sys/kernel/security/ima/policy failed
> 
> Fixes: cd96265e65 ("ima/ima_policy.sh: Improve check of policy writability")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> The same in v1.
> 
> @Mimi I appreciate your RBT or ABT.
> 
> Link to v1:
> https://lore.kernel.org/ltp/20260728114224.1055009-1-pvorel@suse.cz/T/#t
> 
>  .../kernel/security/integrity/ima/tests/ima_setup.sh  | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index b69d7c31d9..19f00532b1 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -95,10 +95,15 @@ require_policy_readable()
>  check_policy_writable()
>  {
>  	[ -f $IMA_POLICY ] || return 1
> -	# workaround for kernels < v4.18 without fix
> +
> +	# Workaround for kernels < v4.18 without fix
>  	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> -	echo "" 2> log > $IMA_POLICY
> -	grep -q "Device or resource busy" log && return 1
> +	# Require >= 4.5 to write multiple times via CONFIG_IMA_WRITE_POLICY
> +	# 38d859f991f3 ("IMA: policy can now be updated multiple times")
> +	if tst_kvcmp -ge 4.5; then
> +		echo "" 2> log > $IMA_POLICY
> +		grep -q "Device or resource busy" log && return 1
> +	fi
>  	return 0
>  }
>  

Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
