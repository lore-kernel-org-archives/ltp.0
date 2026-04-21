Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0FEF588C9
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 05:42:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 680923E1F85
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 07:42:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A8B43E1B19
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 07:42:20 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 274CA1400DF4
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 07:42:18 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJgp811536075; Tue, 21 Apr 2026 05:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d3yost
 709qgF8+kaaRo87RFsMc27JHJYbH32Hnjs3+k=; b=F4YHfmOc2tDPW4t+Ub8ch/
 Gd1KuaYrG2DuDLRx8IbjsBDPcawuNcrbb/r1uZ5iVJRpLgokJbvfrf8SKD7tCzi9
 BM5K1cyL0+R5e/G1zqEFWUJJw00fuI/DI5VfIHE5+QDXhoD5C0qmKzJr44s8//H9
 SYcoHgVu7jNfU5/lsbz7lXKdhRhNwsxsF6fMnC/i5jEEAcVrAp5rOBbQWwwHEMRO
 U5p7YtrKOIv4elxqNhjpUN4FBT77LhP3irAUKsBPC4zCziqK8cjqtzg15ahr69nc
 MXNxmQJGG8adE0/IfWJ6XbJHjRutHUlAwkdXg8ttGQseV1bbga9fffIVD4aGFHFg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6j58w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 05:42:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63L5ZGCV012467;
 Tue, 21 Apr 2026 05:42:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvqmm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 05:42:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63L5gF3g27525778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 05:42:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F37225805D;
 Tue, 21 Apr 2026 05:42:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED51458043;
 Tue, 21 Apr 2026 05:42:13 +0000 (GMT)
Received: from [9.43.100.134] (unknown [9.43.100.134])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 05:42:13 +0000 (GMT)
Message-ID: <c863cf21-44dd-4440-8be6-e8e509a9581b@linux.ibm.com>
Date: Tue, 21 Apr 2026 11:12:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20260416124144.19343-1-sachinp@linux.ibm.com>
 <d787013b-6553-4751-bb32-45b5610efafe@suse.cz>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <d787013b-6553-4751-bb32-45b5610efafe@suse.cz>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e70e38 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Wc6ArQDmqSo5o0SeNH0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA0OSBTYWx0ZWRfX8UjzbdisZLZs
 3lBU1AXWAao2ZdmxtO8V0Th+PHMhU+yaHu6b+GJFQbCIHKrZPe8o9uqRAybWFOlXI9Ctveg55AP
 9cGqCSoCDTD4ilbBvGhJDliWkdfa7+ib65JaH6tru+Xftt0PIHqrHoNtRUS3Aneu+5Fmrh36DJm
 JezrSZP+qoE2shfdMfyzaDEQUUv7TfOrWFXMdBOjhIS9ZIcGp+uaKoMrQGK/kyWgOwJP6Ngjg0L
 m8ySbE2ZuKgomSX6jqv9OKK7sHwcKJZYciPM1no8xc34j3gnqSyiSb3VAoTw7YT/3/+t/QJdhLk
 6X714goZcVmCsCkIx+3B5YA+x/Q3/O2z7ZmAsu1a9vv3/mRCNil2BODSxgoxyD3kAp8qKNwyIFo
 bwS4XwmmJG31u5QHOpJbYsgM6MMbD0O2Wc/UzValWB2PpY+lxVa49ZV0IaDOmM/2muj3U/PYpor
 4tS1VjCmaL37lgg9FJw==
X-Proofpoint-GUID: 349cK68NScTYUPV_QVfoc8n-tpP11q35
X-Proofpoint-ORIG-GUID: 349cK68NScTYUPV_QVfoc8n-tpP11q35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210049
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/io_uring: Add fallback definitions for
 OP_READ(WRITE)
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



On 16/04/26 9:48 pm, Martin Doucha wrote:
> Hi,
> while this patch fixes compilation on older system lacking these 
> constant definitions, the #ifndef macro is incorrect and always true.
>
> The system constants are defined using an enum so they're not directly 
> visible to the C preprocessor. The correct way to check for these two 
> constants is through AC_CHECK_DECLS() in configure.ac.
>

Thanks Martin for the feedback.
For some reason I did not receive this email until today.

I also see that you have already posted an updated patch to mailing list.
Let me know if you want me to send an updated patch based on the
feedback.

-- 
Thanks
- Sachin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
