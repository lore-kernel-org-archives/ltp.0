Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A08E9A04A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 15:59:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63E673D0785
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 16:59:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 953843C0424
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:59:15 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A38221A00991
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 16:59:13 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61J9Aofs1273596; Thu, 19 Feb 2026 15:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=v7ElgI4f7SLG0OxsgGhq6wix7azEHx
 phRwAL22+D81o=; b=oVlZj4EqC46eTyHp6LKdz7qtw2svT+QFjb/+bj7EQUEJiJ
 QxjqBG2w7LC/15+RIZkKUlZFjiTJBXHZwoPfaUOMCHCK6Ri/TseKLN7fR3wEN8sk
 MKnqRSacPLhzKAHuGXYA51pKpIyWMPaCPWwpl7GkIcpHlypBdmObiPIYdboKxqob
 FF909YBkvx+mkccsfeEXjp626zoXNyNnJlIOOcQ5cSM3yPFuntPq76PchGmLUnEe
 irMdl8gRNiSTDFvsbLJkP2EsweVcRZHHDUHpyBn7a0kZ1GITlN/6Y3J4ODBogljV
 vo6HfNff8W9/fLXxzBhfZLBLTFhm+2bRcdjuwYWQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4knj9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 15:59:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JDsYI3017891;
 Thu, 19 Feb 2026 15:59:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28mscq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 15:59:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61JFx9DJ16581040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Feb 2026 15:59:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8013A2004E;
 Thu, 19 Feb 2026 15:59:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6001E2004D;
 Thu, 19 Feb 2026 15:59:09 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.52.197.53]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 19 Feb 2026 15:59:09 +0000 (GMT)
Date: Thu, 19 Feb 2026 16:59:08 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>
Message-ID: <aZczTAi-j0CpZMeG@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260218190230.53759-1-japo@linux.ibm.com>
 <20260219081914.GA309124@pevik>
 <DGIT4WLL781W.28IHUB1N66A0D@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGIT4WLL781W.28IHUB1N66A0D@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE0MiBTYWx0ZWRfXzs2B09I0aNug
 dF38keYUm1+vg3RxXzCozifvVRtPYBpjJxtghsseEZc9Davwe1E3AK/vHYvaAeJILgL4nX47GZo
 3HvE6U/3Y4bBFOuYkW2HjJ3JVoA5qdBFyEtGGpJf4KmRqe8SVHOtAXB8BeClfUSmtOoQWOXJiRL
 /FBLtpSKsoyi4ENfE578KQw7OsquCigAuRob7MtlHK+tC6v7fQyGNXn4QtKO5kLcuAMMfYQpm6S
 KT5MlOLRzBCApssk1/OJsa1VyJUqouJmMBWAlUWdDrkkASM7LSAkMp/NxFpOLOWY8LCBrb/fzhR
 +0pB3rQp1GmFETNJR1JJ4YFRxGEkl+asJxk7pbkvkshs7b4IaWAfxM2ztG4cohYufMYsGU92D78
 tH4t1hoosgw3ndkDigc8bJ9n5cruZtYeUiRZkJiHvcbMvnI+wnauoj9kGYnmxAX852x1kQ/1ER6
 msguM5BgUeY+TBITm5g==
X-Proofpoint-ORIG-GUID: G9eKUWKznRtRqx-J0pj5ThZ3eunCLTDl
X-Proofpoint-GUID: G9eKUWKznRtRqx-J0pj5ThZ3eunCLTDl
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69973350 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=UXIAUNObAAAA:8
 a=iox4zFpeAAAA:8 a=ETZTLXptxDZlpstYU70A:9 a=CjuIK1q_8ugA:10
 a=a1s67YnXd6TbAZZNj1wK:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190142
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] ioctl_pidfd06: expect EREMOTE for
 PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 19, 2026 at 09:49:20AM +0100, Andrea Cervesato wrote:

>
> This is a tricky situation where we might use both approaches.
> TST_EXP_FAIL_ARR() would be my first go, but it's also true that the
> syscall should not fail with EREMOTE for un-patched kernels. We should
> expect that kernel fails with ESRCH. And we don't want to hide bugs.
>
> Anyway..
>
> We also don't have ways to verify if the underlying kernel has been
> patched or not, so we should assume that any kernel might receive this
> backported patch and TST_EXP_FAIL_ARR() remains the only logical
> solution for this test.
>
[snip]
>
> Also, since this is a new feature which has not been merged yet,
> we should tag the patch with [STAGING] tag in the git commit subject as
> per:
>
> https://linux-test-project.readthedocs.io/en/latest/developers/ground_rules.html#kernel-features-and-rcs
>
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
>
Hi Petr,
thank you very much for your detailed feedback. Your notes helped improve
my understanding, and I really appreciate the time and effort you put
into the review.

Hi Andrea,
thanks a lot for your suggestions as well.

I followed your suggestions as closely as possible and will send a v2
next.

Best regards,
Jan


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
