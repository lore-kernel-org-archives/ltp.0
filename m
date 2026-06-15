Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7FBCD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:25:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A488A3E5BE2
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:25:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F813E16F2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:25:15 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E11F200905
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:25:14 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoEiY2209115; Mon, 15 Jun 2026 11:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fCS5w+
 BWJy3VA3czmbD58vDU03UWC8APSYDWyZGQM6U=; b=Mvo9dKDU0tpBFNpDBTAWQQ
 UWeSTrYcrlyXR4hIsoVg02f8bfYpaU/yHTjJRmEsSXBvn4Vhoq0Rs2UoseJoS60W
 MN899jti8eHMgx25jbEpUZ6uRWK7ZmDxUnl6bowlykIwC1tHRptYsNb5G2wOwGhI
 0eYamfRj8zloKg7VqOQEbRgbL0MAMaJWVUM+JojUCAXdS+NRQPInSNzSXqgIJQxS
 G5Ktqp1P+Pc7IGf8yDWLaS6otlKlpJtrdSQAHbKwjb9CFX4OLCuEN6SZvi+lXjwF
 krk6iizKAR/z1gd2Z1epaT7DgUjndCgKuWNSuXmElXXVet7pUdGKMTcP4Q6+WMAQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0689-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 11:25:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FBJcEC013752;
 Mon, 15 Jun 2026 11:25:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjx980-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 11:25:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65FBPAfn24969978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2026 11:25:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D8555805C;
 Mon, 15 Jun 2026 11:25:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E66525805A;
 Mon, 15 Jun 2026 11:25:08 +0000 (GMT)
Received: from [9.43.52.62] (unknown [9.43.52.62])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2026 11:25:08 +0000 (GMT)
Message-ID: <b8dd71d1-5ce6-4fe1-9cb9-ccdc62058f7a@linux.ibm.com>
Date: Mon, 15 Jun 2026 16:55:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 linuxtestproject.agent@gmail.com
References: <6a2fc007.05603459.3d8ad6.7d03@mx.google.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <6a2fc007.05603459.3d8ad6.7d03@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExOSBTYWx0ZWRfX77nEUfZ+UKbw
 0mjFP4eTWiUisUmd7TR7Q6sAzH6V/iXJz1FntUwZZynEFVBatgGSIMt2ZK17ozWgETStZ+9NIvo
 v1iTjSgi5z+ji3pJT7yjTKgi5RiGC68=
X-Proofpoint-GUID: 3AkK2ACLL0jzWCze9KsVJ-71BhhiXLYc
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2fe118 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Hegta35w58iIvO78f10A:9
 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExOSBTYWx0ZWRfXyd2JmKLAW/u2
 Dgv9ORh4RWHN0mdVzKcWJHw4fY3/YC858h6F/J9UEzdVwNCOnu+ly2OM8mE8Fl6gl2GkF/V4qpl
 sFYKHP3uMHx97xWNpabOUwPRz3rBtmWULb3eckVvSQgw8vHGg24mJo/xEw+QVPqbikPd1fneDk/
 zRLqDq1zA2+9o5o+bGZ+tp+gsEs8yqrfMQKcGcTUf+O0RpR9p9OzU+ri/AGZSuYRQwDVIeanazD
 lkW1eY9fvFbFC/risUe8UyZ4oZ24kJXz96QzIfH4CmkJFdCL2026PKUmFhUUVdWGuFKQ4/BGBsC
 OYKWsGalp/7M5vLPOG2y+kiL8AFLA1UXPTogzK+i/dlN/atVTfv9i0e5L9wa8Hho2MVRool7/2k
 M3QuJRexRT0WW8yzgmZK6bw1z2AJ6rKxWa+9siHp7R1sI+tdjgUCAMfUtiq0gSUYosGEb2BhAks
 87DFMTTXZH+FM39fwrw==
X-Proofpoint-ORIG-GUID: M_H8-IO25NAogtSSfNyk8YIm5j_LaTqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150119
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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



On 15/06/26 2:34 pm, Andrea Cervesato wrote:
> Also, please don't define SAFE_* macros inside the tests, their
> are part of the core library and they should not be defined out
> of it. Instead, use inline functions.
I think you are referring to SAFE_TRY_UNLINK/RMDIR implemented in acl_lib.h

Apart from acl tests no other test use it today. In future there may be
additional users.
Would it make sense to move them to lib/safe_macros (tst_safe_macros)?

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
