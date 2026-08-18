Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E0BC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 12:21:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5C083CC2B3
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:21:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EAF03C4B6D
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:21:27 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D218F60096A
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:21:26 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAVa0D069859; Tue, 18 Aug 2026 12:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=du1Q7R
 sMo11oyfERaMPlfGp1laL4dba/PBW0Ka0wdKQ=; b=GD7j1Qm7Dng80HXdQBduqd
 i6eeh5pkXpoS4dKafO7guATRdi20eFSzmKbwxiKthHJ6P5XnMvPdwXvhXkSpwDu8
 h+y6QTQzitjwzfWVsUQz6FBMhoWd17Z6XJvqrhQnHkeCS4deEWjAAM1JNCgZsZ5h
 KgncaW7I2nHP70f6//IohS9vAE77KRf/1gJuS0VWN9B2s3Nm4ri1Mzbq/uesjSis
 dkMs929/TpDw4iwcK4OE+IY1EA093EtmZ/XYCyVnnQ3UHsqgQiBYKd84jWTuYe0K
 E51Rjs9FmY+PM37njRt9HEVUhhnQueIlSjlwy+/q8vhzj78Ow2S6QBkvy79I0g3w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt7jfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:21:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ICBJXB029961;
 Tue, 18 Aug 2026 12:21:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh33j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:21:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ICLMj946465516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 12:21:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC0962004E;
 Tue, 18 Aug 2026 12:21:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42B1A20049;
 Tue, 18 Aug 2026 12:21:21 +0000 (GMT)
Received: from [9.123.14.0] (unknown [9.123.14.0])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 12:21:21 +0000 (GMT)
Message-ID: <6fac2e93-7de5-48b1-b29e-9b2f1028f067@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:51:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 linuxtestproject.agent@gmail.com
References: <6a799cc3.3b530373.1ff701.4966@mx.google.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <6a799cc3.3b530373.1ff701.4966@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a844e45 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=eKpspzUZXcA8bZrI7KoA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfXwvFQGll7AMr4
 2It0NDMYyKzGXUa/5E3QoV9gZwNut3z8bS6+H0V2TEYKl8CbGDMjwESRY3Wge/jKDI5p8+Av9fL
 EqP0PR84XVaMPLjtE1hk8HyMTeLtyrw=
X-Proofpoint-GUID: BahYphJTBksCitNIzE983pdgikWXB_V_
X-Proofpoint-ORIG-GUID: rT05JYvUSDYg1UglWahBVFt_WHtueoMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX22lrVr65S3qr
 M1N4W8Q1so3X2ipM/BButk283UMyB41kLaHzWfzEJcHDGIUPoYnMXG0xfvwsHNfkA89uY/Ix7Dg
 Ffv9qai0zUNZOX0+U5ogC9bhP1cLD1eNWy7uYCkJ9EmE2J2tpH3phZeQieHG3ij4cBDzAtFRi9o
 bXxuEol+0udZu2PZYQ9iwim0s/klAuX4kENiMBp8c1i+wqZVsH6pj89iB9JAKbvqhYaRKPf1plp
 ZOInlT7RwG0m3pQICpYei9R5Nc0xLtUfBSoeMANf0abhgrvfWKP1P4kODKpgCVhVHGdvc6MHbKZ
 Ew9WnqIwmfhNhC6JIys05O6WFXEG3EUC+qCOkAhMhGcnleu/11wgkVnVsZshrw2NNpt3SSub8nz
 lYbkY/J0KqzWCRh1lSsCIzWQ+AQpmZK5Eh/Pp37L+UCL7Vm7/W48OgFpghkY/vGb4Dieb8Fxn8g
 SlMPS9DYoMnwz6c/pXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180088
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol02: fix fd leak in cleanup path
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

On 10/08/26 3:11 pm, Andrea Cervesato wrote:
> Hi Disha,
> 
>>> fd is initialized to 0 (a valid file descriptor) so the cleanup()
>>> guard 'if (fd > -1)' would never trigger.
>>
>> Could this explanation be corrected? Zero is greater than -1, and the
>> cleanup guard is added by this patch rather than being an existing guard.
>> The relevant problem is that -1 is needed to distinguish an unopened
>> descriptor before cleanup tries to close it.
>>
>>> +	if (fd > -1)
>>> +		SAFE_CLOSE(fd);
>>
>> Could this use `fd != -1` instead? LTP file descriptors use -1 as the
>> invalid sentinel, and the LTP convention requires this form for cleanup
>> guards.
> 
> this is correct.
> 
>>
>> --- [PATCH 2/2] ---
>>
>>> #include <inttypes.h>
>>>
>>> -		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
>>> +		tst_res(TINFO, "Child %d in %s: Allocating anon: %zu",
>>
>> Could the now-unused `<inttypes.h>` include be removed from both
>> memcontrol03.c and memcontrol04.c? This patch replaces every `PRIdPTR`
>> use in both files.
> 
> And also this is correct. We should split the patch in two: one for
> memcontrol03 and one for memcontrol04
> 
Hi Andrea,

Thanks for the review. I've addressed all the comments and sent a v2.

Link to v2: 
https://lore.kernel.org/ltp/20260818121436.1397-1-disgoel@linux.ibm.com/

> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Regards,
Disha


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
