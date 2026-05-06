Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B246BCD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:11:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D9053E6170
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:11:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D6323E6155
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:11:18 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DACF31400C4C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:11:17 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6464IM7q1011760; Wed, 6 May 2026 12:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oskf9K
 3qYDpALZ6RCo2Dby/Z6YcXnr+Tc+wzJZkrhUU=; b=IvG+Ta39AaleQ9vHaSK2Yo
 S9Gg85MMT6m0Sy8/rwtwNydgaA8aEnpLI9FlEa/ZF1hWK6lTZGB13BpYW2j/yl1y
 kaDsicoTAtJR6ZuqJpU+fiwWXzP2ON98QvWhXh+wFhyvpPdULvfqE8DIG1Byx81K
 CVoNpQ8SKd/A7pv1p85phTF0HpgnG4TJbxcmvbXDGBv+o5Oezuyi4FX9KIzc9ryy
 La24hi+1buq8k4gESBFZ9fSU6q8AOTuSj+xiLWTlIId7N/wZ3WAOvx6dzHft/zjz
 eOGVMpDAUEOtAH9ulY+8CQgw+PCmHg5/2nbZEJgMQXNxvyHPoXgEGKDKBktabpZQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4qvw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 12:11:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646C9pI1003425;
 Wed, 6 May 2026 12:11:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw66jn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 12:11:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646CBECT23134858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 12:11:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F70158068;
 Wed,  6 May 2026 12:11:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A06358056;
 Wed,  6 May 2026 12:11:13 +0000 (GMT)
Received: from [9.43.40.113] (unknown [9.43.40.113])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 12:11:12 +0000 (GMT)
Message-ID: <27137773-c7b1-4e69-abda-7a5f422ca837@linux.ibm.com>
Date: Wed, 6 May 2026 17:41:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <69fb29d1.050a0220.1a0ae1.230e@mx.google.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <69fb29d1.050a0220.1a0ae1.230e@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExOSBTYWx0ZWRfX1p4luAMK75pM
 YGD/5hJiPO2PDJYDM17dnulFpKOr2klUodpq3eoVTSPuviHIlVaFm3jpWuPKBiDRp9XxKMa9BV6
 CxngV7B+uwzIRqhjXFOLTnNTmmSbimEbShA27DHVnXRl8dHx54EdcGZopBkYMB+VCEVSPl5LPnZ
 xT1wwBQkcPh2yOdXkdo1pVNTp3H5pLEPq3Y6WdmQv88vettmdiRuu2bQtWwJZpnYO7+3t/s049Q
 DJfz1Z+77HoiT/EjcEXb3CJeOT/5wsJcficRAzemkJceQVZpje5+dlgTqLbvc13DPb4J2Yu9ILK
 SzIsD0cOEXdHJ0MrshplZsSiXcTUIo131n04ws6F+y/iW9dNfNvYvG9Nz95krA1/XQ+eEYH1ngw
 Tu/zGjCDe7eWA+swCjQue0IiRJCYNiPN1HvIbkJyoRe/TmqZolrAK/DKjO/Q5LwoQpO0XzLQ0Cm
 ugiC3s5M3E1KWzuHyCg==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fb2fe3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Zxngu23kNH_beUr0ANAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eqVrH85cEiHMXcXj3ivkUUh5MnoJdIDG
X-Proofpoint-ORIG-GUID: eqVrH85cEiHMXcXj3ivkUUh5MnoJdIDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060119
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] io_uring: Add test for READV and WRITEV
 operations
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



On 06/05/26 5:15 pm, Andrea Cervesato wrote:
> Hi Sachin,
>
> is it possible to separate the test into multiple ones?
Sure, can be done. Do you have any specific inputs on how to
split the test.

Split it into three tests, one for each of the following:

test_writev_readv();
test_partial_vectors();
test_varying_sizes();


> Having multiple tests scenarios inside a single binary means
> that (often) if one scenario fails, the others can't be tested.
Got it. Just curious, did you run into any test failure.

Thanks for the inputs.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
