Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95665C88E64
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 12:02:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6E6B3E90B6
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 14:02:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A45A23C0857
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 14:02:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E63881400C59
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 14:02:04 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EA1nVi1741615; Mon, 14 Sep 2026 12:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=FfmBGTgFUIvtULbFwWDEWpQvskdnks
 Jhf7feZ/21JMo=; b=dfrsffDR8WOVO0k9BSzfhek57fhPbrpG2BeYg/YrmLQDD0
 lAfJiQ1kc/2Qb+ln/Hbv+j6hWO1GH/MPrREguund+k8ounyd9/mK3Fbu8AmUOdO4
 N5vpvCUv7Etxb0sJUBDzNjxKutb3f9g6n56BfqmkXdJSvk45TqWrXbJDnvXjgh55
 jMCDerLH9HH66jN2gjyMynIC72gc/wG9DVZhyS6zQMwEq/qeAFIlqexYDOt+AVa3
 eIddz2dew5CN0m3zmX/+J5V8uSGM6A6DzQ1IWIkUmXwBinSGI2kyQ8U5YCGUIpQ9
 g3TitDj+pXNMj//AuF0yp8huwY/B/khiKtwNdRFA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcus02e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 12:02:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9o6WW2045149; Mon, 14 Sep 2026 12:02:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2jwvuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 12:02:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EC1x9628639824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 12:01:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D06482004B;
 Mon, 14 Sep 2026 12:01:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB4A620040;
 Mon, 14 Sep 2026 12:01:59 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.224.74.129])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Sep 2026 12:01:59 +0000 (GMT)
Date: Mon, 14 Sep 2026 14:01:58 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aqfiNqIUe2YbXdxZ@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260908165430.251897-1-japo@linux.ibm.com>
 <6aa1961d.f007bc26.24ee53.1c5e@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aa1961d.f007bc26.24ee53.1c5e@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX7/tCIRzg0MDg
 DZfYITx8Am1B3T/xp2e4l3Xt7Qy2/m6F8xcLrf1oKV0R6wh781PVoKi6thrR1CBdHFHlKsDgogR
 07sLTHjWI5pPF6RPq3wwAgEGYreYlBQ=
X-Proofpoint-ORIG-GUID: 0Va4nvjJ-Kifm5gPlZl0JcLQKaRCKmE3
X-Proofpoint-GUID: 0Va4nvjJ-Kifm5gPlZl0JcLQKaRCKmE3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE3MSBTYWx0ZWRfX3tqNxu+gwKg7
 8LutKWIje8Kklg1ODhNTn2m0nhKcdUM4y68PQP8klv1Brunn4auT4tpoNNov0Lulh9WqMavL+yL
 UyrjkkIMUzr1xV+RBEDzxDS8X7Fzg7GBKR29Ynb2Oh1Lf1ebb3x2NN56n6KYJfilUXHY4R9gFPN
 99OJZ9yUxGxWiw18HW6scsEkYGp7BHgdV4dcAE88AtvfTd3mLxVZkHPDqEYeZuV3GJ8IO8E3hlL
 VcBLw3kweX3vLdqlycQ1e9DKzcApBlli3bEttlB3/UbCBbTASn8ugUBmvNXMJ/c9qfJnbyY2laq
 oFy+jge3YuZinT05m5cZic+s3AscEJyS7y+0I4Rl4XsbntPw0B4Rh18ODHY7XnH4HUbjQRyyOf5
 tmQ/7KJtiq1FVCRaToqv+cgIkrirT32THbXJ9uxXvo7GZ5Exd0Nb2+anC0on7B/2urCJWo6QV6g
 DelNymhCxrxk7vP3Tow==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa7e23a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=iox4zFpeAAAA:8 a=NEoMPeDislEHPeTwg6AA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140171
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/3] Handle FORCE_PTRACE in thp04 and add
 ptrace coverage
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 09, 2026 at 05:23:41PM +0000, Andrea Cervesato wrote:
> Hi Jan,
>
> the whole patchset is failing to compile. Can you please send a new
> version?
>
> https://github.com/linux-test-project/ltp/actions/runs/34259935546
>
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
Hi Andrea,

thanks for the report. v7 is on the way, fixes the build error in thp04
and two further issues in ptrace13 found during testing.

Best Regards
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
