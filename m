Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB9BF8A140
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 08:26:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06DB3E263D
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:26:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E7963D87C1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:26:28 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CE541A00706
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:26:26 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FNtrod127659; Thu, 16 Apr 2026 08:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=escKvo
 yUcuJkQSKnvstUwO6v4ZAKcqHu/LaHpIGl9NY=; b=YZ+nOG/O/q4ZDMAgHxHvra
 sVjSmDJcLbZ4hqwxdVOi5emSmLku78S5Es+X8LyVFfdlExUlE8KnATFBDUklFbw5
 IhpGlKMMasqJolvysD5Exmt0ArF0nc7BpSXE4ByWmRiPfvgYDEnPcN44QG22tPwb
 CmLYmtSzeoZcZobFbi7JgdExmGJ7P+qfbvsHYj1dy9UzX3LP8hx1O6nAvYDnmDx1
 WSc4XugtbqdSSNR2xlFoFJ97GekJe+8o0fk/s3P8KDhHBCS8Plvb9RdbjZYxlJ1d
 +CYLlPIMfwZNPrA1d/PBmAbvh8Kf2vpqVwJ0SV7QWSorqb53stIsslZipjVZZNuQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pkmb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 08:26:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G6FXeI015164;
 Thu, 16 Apr 2026 08:26:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mst840-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 08:26:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63G8QNOd21824240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 08:26:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E60C658055;
 Thu, 16 Apr 2026 08:26:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6621F5804B;
 Thu, 16 Apr 2026 08:26:20 +0000 (GMT)
Received: from [9.123.5.88] (unknown [9.123.5.88])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Apr 2026 08:26:20 +0000 (GMT)
Message-ID: <17da2ea7-b1f8-49ab-95ed-30083592e7fa@linux.ibm.com>
Date: Thu, 16 Apr 2026 13:56:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <wangli.ahau@gmail.com>, John Stultz <jstultz@google.com>
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
 <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
 <ad-sqJXCYZpBAKM0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANDhNCoAc4ktPUzqgam_oO7aAc4yp3nCqkcwQDvWs0zV15ZCaw@mail.gmail.com>
 <CANgNiRz7c7mJ3E2QQwHCHb4=DCk-S6vXe3Xkge05xfYe2LYTEQ@mail.gmail.com>
 <CANgNiRxV5Kd1Y3hHjM4mXaE2sdjhCQdp4Ff85YdqxL_DOSZdgw@mail.gmail.com>
Content-Language: en-US
From: Soma Das <somadas1@linux.ibm.com>
In-Reply-To: <CANgNiRxV5Kd1Y3hHjM4mXaE2sdjhCQdp4Ff85YdqxL_DOSZdgw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Xw79PeZSH08ZvO9XTzi8mQcnVFfe_6sf
X-Proofpoint-ORIG-GUID: OMrDFgDoHn6SIW407WEhkZEh1Pqe6gnm
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e09d30 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=T3dXcuBNJUA-V_xk3z0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3NyBTYWx0ZWRfX0uDAvJCwYQbQ
 BvwCTOPtOskQZ8JLp86iAAvu8Qvya1QZJ3HCkjEHBr8FSuB3mQA3HB3IKKLCLwYMSDd30W+wTJ4
 S/43pyNRHhpx/CcN0vVgdkEtPoLegrzKGubB7i1bkYf8oR3IG+rVzHfepo/tzMdIO98YQMESIMq
 FTDO9AEob1Mn3DmUxSjBMPxqwB3z9CtYkg8FDwNefPIv/x234yRnPeSiFEt0Ga02BX2s1GOstQ1
 GBbRiusJljycnD3ZhG/SxOTVaYLTRsqzwnhEfWwsQaJwn21rYQrVvxaXugQ+CgUH2jUTxYwDCZU
 eIZZ3sw/oLSsWSI1ESYRARtbQqjFXtSSB8r5ZbX2ynFHOCtgEOsEj7j/gTE0KFjRmMw0p+1zl6x
 az/QqiHQNt9a8PWqnfCw/BaNT7yQL0m2ppr+8yDZzvUkhc7LPhYF+cRmgcgkkMN6jJ0C0LtAi52
 ySpdNOtYEJJpu74TRfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160077
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: fix false failures on many-CPU
 systems
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

Hi Li, Jan, John,

Thank you all for the detailed review and discussion.

Based on the feedback, here is what I plan to incorporate in v2:

  *

    Pin only defense threads (one per CPU), leave offense unpinned

  *

    Replace |get_numcpus()| with |tst_ncpus_available()| to handle
    offline CPUs

  *

    Drop the RT throttle disabling entirely - unnecessary once defense
    is pinned per CPU

  *

    Remove the |usleep()| / |tst_check_preempt_rt()| block after kickoff

  *

    Add |join_threads()| before |pthread_barrier_destroy()| for clean
    |-i N| reruns (thanks Jan for catching this)

  *

    Split into separate patches - at minimum fixes #3 and #4 will be
    separate

  *

    Update commit message to clarify the test now verifies per-CPU
    SCHED_FIFO priority ordering

Will send v2 soon.

Thanks,
Soma


On 16/04/26 11:23 AM, Li Wang wrote:
>> That's why I tend to believe disabling throttling for this specific test is the
>> wise and practical approach.
> However, back to the original patch, disabling throttling was
> indeed a bit of an overprotection based on the pined method
> (I didn't realize that before).
>
> Once we go with pin 'defense' threads to every CPU, while leaving
> the offense thread unpinned, this throttling can be kept enabled.
>
> Whichever CPU gets unthrottled first will instantly execute its local
> defensetask, completely starving the lower-priority offense task.
>
> It relies on strict local preemption to perfectly mask the SMP sequential
> unthrottling latency, fixing the test without needing to disable
> sched_rt_runtime_us in the kernel.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
