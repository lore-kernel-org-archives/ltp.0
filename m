Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCB6CD4851
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 08:45:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55C383C6BFE
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 10:45:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42FB63C5E9F
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:45:07 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7287F6009C9
 for <ltp@lists.linux.it>; Tue, 19 May 2026 10:45:06 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J84w6O2799624
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GS6D5T
 6TWQkYchDWQZGHng9yTl5gFtku+U6JJ/P1U44=; b=MZh3IzwmzBsraKMBfyczWw
 fO0Y7R85sRsfWDBjJy/0/EPAXZONTpdx/C9fy7JD6caePlUAq+/2aqpFzGvlqBQS
 hE2tzZ9IGykUaHxJQXzcvXhfu1MwgW/Cj4ZYUf+kTdDgwP/0qdbO1XBwBSRDwZCC
 Cixc1u6PLh+8OkFw83L8DbA9VxPlFAKXj+JWaPOsPKupMvc73PDTjZckK7cyxUDy
 v+rQAaVilvPogWj72hGnXOvKD22PQ+IoUdNatEac6modsgWzH5J5+ljQNCQ9QkAN
 FfWHfN/iTqGWj4/f1/7toTXBSJHBuVVmneHvII2R7eTTltNInTOGaSkTQQwq/wLQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw3cpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64J8dCXl014487
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky1fn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64J8itTq25428524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DEC558059
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C39E5805B
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:54 +0000 (GMT)
Received: from [9.43.59.246] (unknown [9.43.59.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:44:54 +0000 (GMT)
Message-ID: <51507e20-d908-4213-967e-df74bacd87fa@linux.ibm.com>
Date: Tue, 19 May 2026 14:14:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20260507073417.64123-1-sachinp@linux.ibm.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20260507073417.64123-1-sachinp@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4NCBTYWx0ZWRfX4X9jw6s0vF2P
 ldDAnHYWms7gzbrqNB8Bw313KRfZZ2SPwus2gIO1tzIdwTYtI1U5Kt+rpb5afK9mWh8iXN2R9UQ
 OITLPY2xn4KiF3rapzj7HkKiR9H17Cz/SQ+3LPYdZpOemX+nCIdmyD4mB8pschWaBRhZDpuc71n
 xzQOnDO4U+TTaVqq9nTJSzlLa1Za9U+1/ZNkgq/19eUOD+GH2u85P8BleR0oW1dETrqYZo0ivCm
 tx3oz46+2KfVOq10O8bqZ2yHARYxrZZUzcGnRTdXSWFog6b6Li2YE5e3rfl4TO8INK+MfzJoTLI
 W/WAamlkI/0XzpaV2JZcNzWvgKL6bGWf+F3rTo0M2BqQKSEKTYqJ8zqi9/xyUIgRiN6dgC6r8Eo
 cOGdoGROeZBcyDsnmJElj2zcx8+yKHoy0rJUK5yF9SbJuSuKON7ZK4mFXBvRGlJ215N5mkbWP7R
 0Uk9ZbJLMTKxQCepJjA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0c2309 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=6W1MH8sdw8fM1a1v2L8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s2UjhdCldhl9VOrPUqFlumm-eFVRuvw7
X-Proofpoint-GUID: s2UjhdCldhl9VOrPUqFlumm-eFVRuvw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190084
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] io_uring: Add io_uring04 test for vectored
 I/O operations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A gentle reminder.

Let me know if there are any additional review comments
on this patch series.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
