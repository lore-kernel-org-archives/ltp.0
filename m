Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B701E77188
	for <ltp@archiver.kernel.org>; Mon, 30 Dec 2024 20:44:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F0C83F022A
	for <ltp@archiver.kernel.org>; Mon, 30 Dec 2024 21:44:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E6553EF3ED
 for <ltp@lists.linux.it>; Mon, 30 Dec 2024 21:43:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5E7521011832
 for <ltp@lists.linux.it>; Mon, 30 Dec 2024 21:43:44 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUE6DxI015425;
 Mon, 30 Dec 2024 20:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F2G9Tt
 3Te+rFmUbbhIz4CvSCoO8c+P1/VsXhqhm6ef4=; b=ZDTtK0CINhqbwUtrYselPW
 csUlNYA+igw/ILcHGCqC6lyMaLWkInfEbBTdRrtLiMbt/wyyLUqXPyZjeIFUZNOo
 tsl8QwvKRg1/oFqEp446+JcxB5sSeXxEaNY7ZDyOlmFwQV4HD0JaHhFuNfMFa1qj
 GdXgz7rxFgALpE8dDHCMmrpxov1j+K82M8UZprYwN/gAJIKY7Ex+xyRh+hfa4U6F
 wDDvDNKrg+qtVykxI8RYWsfmHbYKT5BK2izO5heAARgZfOZHz3tlnpv6lL/i5hB6
 /Srq3iQxl9TJ26bSarPZvH4hzdrhG23+g7NldoO49KKyfI1g127sbBv47cXcnryw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43uw04hk3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Dec 2024 20:43:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUHkVCr014589;
 Mon, 30 Dec 2024 20:43:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43tunsfmc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Dec 2024 20:43:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BUKhfET50463278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Dec 2024 20:43:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A563658052;
 Mon, 30 Dec 2024 20:43:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C7E758045;
 Mon, 30 Dec 2024 20:43:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.97.206]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Dec 2024 20:43:41 +0000 (GMT)
Message-ID: <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Mon, 30 Dec 2024 15:43:40 -0500
In-Reply-To: <20241213222014.1580991-3-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-3-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6tElxNeSnOrpeWur1lPSuYgbEe0KxMk7
X-Proofpoint-ORIG-GUID: 6tElxNeSnOrpeWur1lPSuYgbEe0KxMk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412300176
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/8] ima_setup.sh: Allow to load predefined
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
[snip]

> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2009 IBM Corporation
> -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
>  # Author: Mimi Zohar <zohar@linux.ibm.com>
>  
>  TST_TESTFUNC="test"
> @@ -72,14 +72,20 @@ require_policy_readable()
>  	fi
>  }
>  
> -require_policy_writable()
> +check_policy_writable()
>  {
> -	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> -
> -	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> -	# CONFIG_IMA_READ_POLICY
> +	[ -f $IMA_POLICY ] || return 1
> +	# workaround for kernels < v4.18 without fix
> +	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
>  	echo "" 2> log > $IMA_POLICY
> -	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> +	grep -q "Device or resource busy" log && return 1
> +	return 0
> +}
> +
> +require_policy_writable()
> +{
> +	check_policy_writable || tst_brk TCONF \
> +		"IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
>  }
>  
>  check_ima_policy_content()
> @@ -158,6 +164,34 @@ print_ima_config()
>  	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
>  }
>  
> +load_ima_policy()
> +{
> +	local policy="$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> +
> +	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$policy" -a -f "$policy" ]; then
> +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=1 to load policy for this test"
> +		return
> +	fi
> +
> +	if [ -z "$policy" -o ! -f "$policy" ]; then
> +		tst_res TINFO "no policy for this test"
> +		LTP_IMA_LOAD_POLICY=
> +		return
> +	fi
> +
> +	tst_res TINFO "trying to load '$policy' policy:"
> +	cat $policy
> +	if ! check_policy_writable; then
> +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
> +		LTP_IMA_LOAD_POLICY=
> +		return
> +	fi
> +
> +	cat "$policy" 2> log > $IMA_POLICY
> +	if grep -q "Device or resource busy" log; then
> +		tst_brk TBROK "Loading policy failed"
> +	fi

To write to the IMA securityfs policy file, check_policy_writable() used "echo",
while here it's using "cat".  "cat" fails when signed policies are required.
Perhaps add something like:
+
+       if grep -q "write error: Permission denied" log; then
+               tst_brk TBROK "Loading unsigned policy failed"
+       fi

> +}

Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
