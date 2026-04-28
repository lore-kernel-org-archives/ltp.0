Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41739FF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 11:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8F1F3E49E8
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:21:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62ED23C682F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:21:21 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB76D1400159
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:21:20 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S671hZ2845814; Tue, 28 Apr 2026 11:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zg9/yM
 fhyVP/62loP1N0SyfgfImQvDFnpDyVK4YGjDc=; b=rVXgBzbrNXSB2BXuGxW6Pp
 pHN+M/o/fTjhJYEQIDVGgfwwxTlWxiwOdnH6oDKt5FAMT3f5vgYoZmFnmyrOqZ+e
 QsMkYa+J5SIGgEk3INoZVZUA2txE3PEDYJHTe7B1t8EZRhldvTJ50x8QVLByuEYa
 IlI9KUSofkEIUHqGFd6zZg5CpMo5C5h33VE3j3ch7ebDlh3ujU84QdVzbfadgodC
 GIZNEWk3Zpv/CpJBPP5WhyHP92Bh9K4V9KsoxAFYYxLR+2vIgR3mMC6DVdiizWo5
 12gSLL1oYNKbJevpbFDNlbK4vkY1gTEv3GGtMXP3Q6tjcZ1itvk3jZudVIAkXlyQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r54ac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 11:21:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SBCkD1025842;
 Tue, 28 Apr 2026 11:21:17 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk1ddq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 11:21:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SBLGo665995250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 11:21:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63D2C58059;
 Tue, 28 Apr 2026 11:21:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72D9A58058;
 Tue, 28 Apr 2026 11:21:15 +0000 (GMT)
Received: from [9.123.9.99] (unknown [9.123.9.99])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 11:21:15 +0000 (GMT)
Message-ID: <7f656e34-0e5a-43ad-9cfc-8584a4a537be@linux.ibm.com>
Date: Tue, 28 Apr 2026 16:51:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260408044431.128811-1-samir@linux.ibm.com>
 <adYi-71K4yb5-wu6@yuki.lan>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <adYi-71K4yb5-wu6@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LT7sizT371veAJ5XQeVVoFFN8n28_pxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwMyBTYWx0ZWRfX7/4p8MOUPbdM
 KwbekwzEEe4liEEKYcjAHjLWgmXaLlSSMIzpWJ9tfQmMLLcEzgCniplFRioOkOfZL9pA8Lknd6A
 3JguEWI/L2VUTlHwIqom2H4cpcOSXwtmfviIvpFN049yAVRAdJp5eYW9K6qHLcMsocT8XlI7tIq
 9c8IO+6bau7Pla3eDjXS6LIvrHMF6LdNvhFRiwKjx1UU3KFhof8jAAaCwdTKamH4ItO8WO5rJEn
 XVL3dFUJ0Xmq7PQNcqAjPaVcsZ5uww3FLLu1oOZZ1mgZn7mOXrx1JFWPJVbZ7vmKZFcd27d96ej
 aUrQNwQPkQA82moGBor49RGof20DZJKAQnd/gV9VT4azPIlSuJ1TYlfLuAECciLE3fmapncEJV5
 GaMSxehT7VFC14GbuZXMxlkWu093R8disoX684LFCVQeILyynJ5B9rWZA+p8zxW65q6S08g/pD6
 KbXzzbZP5wUDkVWtJzA==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0982e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=TN7TQ4ZcqBPOxRvAQjkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LT7sizT371veAJ5XQeVVoFFN8n28_pxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280103
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nptl01: Fix "make check" warnings and errors
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


On 08/04/26 3:12 pm, Cyril Hrubis wrote:
> Hi!
> Again, no point in fixing the test without rewriting it into a new test
> API.
>

Hi,

Thanks for the feedback. I'd like to rewrite this using the new API. Can 
you guide me on how to proceed?

Best regards,
Samir

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
