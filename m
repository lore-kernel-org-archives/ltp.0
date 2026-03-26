Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FFC10A62FF
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:57:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC9D3CD439
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:57:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABA583C1014
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:35:27 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1AA681A0118A
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:35:26 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q07X6v018998
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=YkKzeGSDIIWpTxGruwn0di7k7jlw
 bWio8x9q8sGxqHc=; b=aVGYWVe7gGA9rfzICdgRJhkerECqX30EGUQxgNdYtWwv
 wDjgAHUGw+MtjOaRCRjWHGOiYNYJ5VqZnB0a6zqDMTSOt6ImIc5YgXf2bSEqyqmT
 K6E3RQmfV4rp57QEkiETvovSS7vDub5CBa4FIl6uowYFNPi41oAb+mDD8Ih6jJiQ
 mdolkAF7zEhVJXyyGwbdrcGUmMg5/MRUPNPfc4IDXLhq+LEw2QsWlbXls9a3WY4m
 MZXKUtgP6lCtaMMocao9wLND/GC4nJlJUUZOYlBCQbd1RxGwUKYODfdG3ER/jQwc
 TJjGExDYmr9B7KJXUznC15cROFggA2R4/OCmPaMi2g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty4nkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q6H2T0008749
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnthdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QAZMLv19399168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1E93580D4
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E7EA580D3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:22 +0000 (GMT)
Received: from [9.39.25.141] (unknown [9.39.25.141])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 10:35:22 +0000 (GMT)
Message-ID: <af85e481-49a8-4a58-903a-40a2d9037bea@linux.ibm.com>
Date: Thu, 26 Mar 2026 16:05:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: priyama2 <priyama2@linux.ibm.com>
To: ltp@lists.linux.it
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c50bec cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=uC0LhYRBjIeR18ormdwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA3MSBTYWx0ZWRfX5KS/Vt2vp1nZ
 0zlbpczB86zV42sj0BTqe6O2XElj4K0bSZeFUTdNv1SRZvWT2CeKEuCrTYBtQxbo+hhbUWsVhfS
 wn6El1mBikvE0KlqSFNyjxY8f4x7ccngocdcoV2z2w5pEraR/2C/iUYQ6o0d8yP1MzBwPEQ3tCh
 IEfdgMN4203LBpe5nJh6Yfap0agKMCaKUdNUPnqoWZRklIUSVG9OXa9l4G/RTK6A7sHAnxBIcJc
 dDkETBhtFa9G7skBN2Ubn98UDb4/aEXYZWxaEBHCNgMIgsDkhUIVevORRtynA6S0K7BQTSeHAVt
 2+L4D6pienJKzfSJv8doSHTQAR5obGepte+w0CtaaI4tKtWE3TNBs3aaca/Dnc6cHpEbBQ++1bU
 Fx1ay7EFqLvCoxRp6QRZ+Vs6QAfJbtAB2b1h82rqODNhfiuw7nTIwa6y1mvcR4Da4KadqmChy1O
 +0e9WrepCNYZvArQZOw==
X-Proofpoint-GUID: QcpGt7hfmEhmusJWN0jD8Y7xVM76SC1_
X-Proofpoint-ORIG-GUID: QcpGt7hfmEhmusJWN0jD8Y7xVM76SC1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260071
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 26 Mar 2026 15:56:29 +0100
Subject: [LTP] zram01 page size vs cluster size
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

Hello maintainers,

This discussion is regarding the zram01 testcase to exercise on POWER.

In POWER page size is 64KB and zram sector is also 64KB

Since zram uses system page size as sector size the sector size would be 
considered as 64K

But, as per zram01 test mkfs.exfat runs on the default cluster size of 4K

Here cluster size is lesser then sector size and hence this testcase 
fails on POWER

Any recommendations as such where we can tune page size to 4K so that 
sector and cluster size becomes same and thus we can exercise the 
mkfs.exfat on POWER ?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
