Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA659C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 18:38:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 255EE3CF64E
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 20:38:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 062D23CE442
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:38:27 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4FAEF20097B
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 20:38:27 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIVmC43370219
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 18:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+jVN11
 hr9AZJj6APwrCaEJNhWWH75ExcyCJVZFGkvsg=; b=KaMHpne7oNdHX+yWtNBac9
 T6XNVB5vzkwmNBYlMWyXpQ63V2TUd6s9StUxqD1vru2hQuomk41w+yhb+nUdpr+A
 SGQexDS0Tkn6zphW9+okVG/XZQtgppZ/w4MMKqvcBgr9WAz53sDwOc5qMcNzylDj
 kU/4+38VhFq15XZAHUaCk//q6sBTSKF+KB5rgkswTBehKsLIu150sBvPWcJXlWmO
 wmgDthLyKrtDmGGVaqAtE+VK0goVY71uHBspogiyxdmWQJy4Q+5FsKt5wtVs7BqC
 Gc+p+fNcF05jpQEu+a+CKDidxBxoPHGrSHhblIKB/dA7JygEJgpgN+JgXHlAJBgQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4c5tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 18:38:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KIQosx026000;
 Thu, 20 Aug 2026 18:38:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekg7w0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Aug 2026 18:38:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67KIcOqU30343810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Aug 2026 18:38:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A1265805C;
 Thu, 20 Aug 2026 18:38:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4399E5805A;
 Thu, 20 Aug 2026 18:38:23 +0000 (GMT)
Received: from [9.43.90.108] (unknown [9.43.90.108])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Aug 2026 18:38:22 +0000 (GMT)
Message-ID: <fc6fafaf-9fcd-4e7c-96e8-39deca9fe042@linux.ibm.com>
Date: Fri, 21 Aug 2026 00:08:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxtestproject.agent@gmail.com
References: <20260818113032.41963-1-samir@linux.ibm.com>
 <20260818173424.8975-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260818173424.8975-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a8749a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=N_oFlX0r_UYQ_cq5FE0A:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-ORIG-GUID: z8ghoATMdgSI4gkFRLsrCJlP_uIx9ej5
X-Proofpoint-GUID: MimmFmWlN7jUH5i-9UPsG1OcqGQJCqZ-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzOSBTYWx0ZWRfX8zi3QPDAKClv
 OGKADMYAhLyAfKB6JYN6Llesqdpu5HXcHVspFQGKrqpVHjS/JaNCiEPq1Y/EAKOO/o1Hj3YktXE
 8KC9ayF/4cB1oR0olNqyc8qZR2y3wsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzOSBTYWx0ZWRfXz0BLvSkWJQAz
 bN/F24AgIvNJMI8mjR/+mkf30vxibTOX0wmr3Dx6ndLV9FuxD6gebK3TwiRrgGb44TRomuyqCIT
 GXvXRYhaZV6TlsGL1LBGr5FSmU6yNo0zmBJ7NWiR5R8mI0Kp5YwhM4TQXZkP/2kMX9+VWFCWARi
 ZlL38cTNvmFy8hYXSYSrYpWAl1TnxTAerIOFuFeZippWY4PE0htnc2Sk1fLruUpHOW0CiR11tX7
 VOES2O1qtoVvhvX2adq7TTxIzvPw8QPAxoM4VOomu+S2QpK3Fv/ZkZTD8BfBzDM6V4pcIIJQtln
 SLoA/wLBbdm4bJfcD2lXOwZ5V9j+qS1NRzN89GM9shDmAJfZxxlel1/25xwLSsYLkP3NaLqJWLP
 AnChiJyxCgq6qoraSNzrFO63fIVpNLUFPq3eGU93Mf1OYqf9e+Mk6v+Vupe2enj9c/qSmD8+phw
 AdcR/SJggNk7PhVzhtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200139
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched/cfs-scheduler: Fix 'make check' errors and warnings
 in hackbench.c.
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


On 18/08/26 11:04 pm, linuxtestproject.agent@gmail.com wrote:
> Hi Samir,
>
> On Tue, Aug 18, 2026, Samir Mulani wrote:
>> sched/cfs-scheduler: Fix 'make check' errors and warnings in hackbench.c.
>> Fix all 'make check' warnings in hackbench.c to comply with the LTP
>> coding style guidelines.
> [Minor] Could create_worker() and reap_worker() be made static, or could the
> claim above be narrowed? The affected directory's make check still reports
> that both symbols have no prototype or library prefix and asks whether they
> should be static.


Thanks for pointing this out. Both |create_worker()| and |reap_worker()| 
are only used within |hackbench.c|, so I'll make them static in the next 
revision.

> Verdict - Needs revision
>
> ---
> Note:
>
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
>
> Regards,
> LTP AI Reviewer
>
Regards,
Samir

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
