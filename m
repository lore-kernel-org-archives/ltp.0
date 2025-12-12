Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBEBD43369
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 03:43:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFF043D00B7
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 04:43:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71B133C84D5
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 04:42:48 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0F0F600903
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 04:42:47 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC1636C000648;
 Fri, 12 Dec 2025 03:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=v0QAD6
 3WevZqYrVB5vpFZxjShS0FfrRNEuzeRgxxHeY=; b=MATZJC1RIXTgJYKmD73fIN
 WB6XFvFubOEr7xfnFXk+7l1hDSnH3YMY24z5b6YkdbesWcr33jAWUvOz9pOJS7hg
 lsHBM69O2b+byFmvx92LQLXIUWYZ2ehGkk1dr6B4ziEkHbIk/vO5Wr41o4Xah/Qj
 HvTKWpS1WTaVelZhptTQECi9mSQAabkADJNIYv2fkG9MtRRWXHuYkP1nz7vTKhko
 mFoWrnv4VAd3jynv6JNqVY55GYfFdIh7y79RPI+r71A+P+8MFQ+d5hbbNkyNqaN8
 IiHFOJ+OfwHozUPWmgVJoTmpuj78T+W2uaWPhiTtXOHUdxdgH0ha+Gp5+4JOwzDw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww2p90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 03:42:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC1VaMS009026;
 Fri, 12 Dec 2025 03:42:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytn9xh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 03:42:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC3gi7h27066892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 03:42:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 974A55805E;
 Fri, 12 Dec 2025 03:42:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3AC3458056;
 Fri, 12 Dec 2025 03:42:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.160.123]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 03:42:44 +0000 (GMT)
Message-ID: <c5450636264354dbf4d5e52d2441904d665e96ee.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20251211111046.87297-1-pvorel@suse.cz>
References: <20251211111046.87297-1-pvorel@suse.cz>
Date: Thu, 11 Dec 2025 22:42:43 -0500
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dtkko2ikqHx62JpeleZRQLhnp4VO73ti
X-Proofpoint-ORIG-GUID: dtkko2ikqHx62JpeleZRQLhnp4VO73ti
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693b8f35 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kUrTGkXgEzY-5oqraUYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX1fVXH+FLMZaj
 qubePY+4MyM337sqO/qglts/NvMztnBHjhuNMN3AhpHfqSN5xMeDbQsuqo+njM/Aljv4PH3LOV8
 AR4C4poXezQAR65o6foXrrSzjEzLFnLkx++nD7FzpcW+P574RExRasxiIa9QIBaRyJ+8r6vaa7z
 0zYJKhFAPyseNMbr/2UGTh9E7AMPS4IC0HtThJRhDuzsetBViZKTHwvpZ0pVD7oBodOXPSuZ9rC
 b9rGS2e1veH93fWRuHfBz24Vo4ZNvl0HsSfruRA0+58cfXrrJY4udCQIOv1kflcTVvsSvAT8Usn
 SKBPMdLVt6yJ+rDJ/N5KwsCSMKRqG4H/sAOGxfjVTGWJB4Hy7Wic0L0Ry5FScaDKkDZiAwlOGtS
 o7lXZW2ZWuDjQpraHob+SdGUdxU8ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_violations.sh: Another fix of condition
 evaluation
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

On Thu, 2025-12-11 at 12:10 +0100, Petr Vorel wrote:
> c0c35509f9 was not enough to fix evaluation against empty
> $expected_violations:
> 
> ima_violations 1 TINFO: verify open writers violation
> /opt/ltp/testcases/bin/ima_violations.sh: line 96: [: 0: unary operator expected
> 
> Therefore split checks into two if.
> 
> Also improvements (readability)
> * shorten line length with saving subtraction into variable
> * evaluate empty variable with ${:-}
> 
> Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support multiple violations")
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Martin, Petr.  LGTM

> ---
> NOTE: this was found on old SLES 4.4 based kernel which does not log
> validations. But missing validations might be just a Secure Boot related
> setup problem:
> 
> $ mokutil --sb-state
> Secure Boot: EFI variables not supported on SUT
> 
> Events are logged when Secure Boot is off:
> $ mokutil --sb-state
> SecureBoot disabled
> 
> Or maybe violations worked differently on the old kernel (I remember
> only 6.15 change).

Violations only occur when there are policy rules containing "func=FILE_CHECK"
defined.  The secure boot mode should only affects the arch specific policies,
which do not include "func=FILE_CHECK" rules.  There is a slight difference
between the builtin the original "ima_tcb" and newer "ima_policy=tcb" policies,
which might affect violations.

-- 
thanks, 

Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
