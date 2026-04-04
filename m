Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB8BE63FE0
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 16:56:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B88B3E29F4
	for <ltp@archiver.kernel.org>; Sat,  4 Apr 2026 18:56:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315833CD98D
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 18:56:29 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C48B0600472
 for <ltp@lists.linux.it>; Sat,  4 Apr 2026 18:56:28 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634FErJ2258416; Sat, 4 Apr 2026 16:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ljSthO
 0Nny1iwoHnOdLYD+8frqG2I993oTTj4UmGjuM=; b=qDZnCqF/eXpw+VEFXoqs+P
 0vR62pyFu7j0ibUu4FTc1WLDz+04NbTNheWVAXnLJpAhdqhy1U4R/kuH8c0lKr5m
 06WL10+ag4T4ZgoPb/r9wEn8zZSJJhxhbDVhR/05+yEC4WhsWrmMr8Uauvvxw2ii
 5U3CBuW2JVA9bB7vQO7yydGJIvN/pwTkiO/l4yZW63vMj9eupeykq6yd1HXIFBPj
 /4TQCPIN1Mx9T9bqkA1cFZOFvKSY1CZwv6rW/5ZaikW+PPRMbRf5OXia9xufg0Jz
 a4Qt5oGwSl/YFxUP0uvIJEwfVkI/xEFWnWHtxfGN4J5cy/4Zc+f9sEZI6BozdvaQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dar2g9kcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 16:56:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6349Ud22030995;
 Sat, 4 Apr 2026 16:56:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk9rmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Apr 2026 16:56:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 634GuPMR328388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Apr 2026 16:56:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 119B858055;
 Sat,  4 Apr 2026 16:56:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D1035804B;
 Sat,  4 Apr 2026 16:56:24 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Apr 2026 16:56:24 +0000 (GMT)
From: Soma Das <somadas1@linux.ibm.com>
To: liwang@redhat.com
Date: Sat,  4 Apr 2026 17:20:31 +0000
Message-Id: <20260404172031.819806-1-somadas1@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <adBl-CJwsLk8i43c@redhat.com>
References: <adBl-CJwsLk8i43c@redhat.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ya86afWjosz3W6URCBvUJ0ZLlxMRBS-m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE1OCBTYWx0ZWRfX/WrRNlaVvYpF
 otuREw1f0QhLGRWVj2+6PP6S581YmrkJHMtsNfOFCNbhlSUH3vuxI2vZR1fp3MFyDb9nMRBH2M+
 bFpegZtfFQzwB7+ulbqNmp0w2/1RqIat47HzycrSHX8Z9purlsNdtUlFMWthjH6R6qYQWRI/dMW
 ITIKMbdENuZ7e/tRQHHylesDVLuep1c65Vq4TqBLs61/4LUdebEWgrjJvDqq96SlrLveznsWk4z
 shsylV8654lRo++mJcLfRjVieRGmPd8pHAgbkUGSKlMnvi/f6hSj+XyCwRDoXfpu8tZOSfodQWl
 f/QVtBgMSKRJME9dqnZXbHcp9LVRCzkwYE7liYjl89n4XFK/CRKyfBbUT57hlX3T9iQp6657D4q
 /FNiBoeMF4380m+rM7QhM9949EN7MTSt6dEugBwSisw6v8uTDyRO8ewDNCY/PQNh0xtwWcBDvQI
 0tvMbJaT3WiCTb/atyA==
X-Authority-Analysis: v=2.4 cv=b+u/I9Gx c=1 sm=1 tr=0 ts=69d142bb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=lzfuAOLxaf_O7s3GLt4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ya86afWjosz3W6URCBvUJ0ZLlxMRBS-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040158
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] zram: skip exfat on systems with large page size
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
Cc: somadas1@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBBcHIgMDQsIDIwMjYgYXQgMDk6MTQ6MzJBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBJIHN0aWxsIHRoaW5rIHdlIHNob3VsZCBnbyB3aXRoIHRoZSAtYyBhcHByb2FjaCByYXRoZXIg
dGhhbiBza2lwcGluZy4KClRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIGV4cGxhbmF0aW9uLgoKVW5k
ZXJzdG9vZCDigJQgSSB3aWxsIHNlbmQgYSB2MiB3aXRoIHRoZSAtYyAkcGFnZV9zaXplIGFwcHJv
YWNoLgoKVGhhbmtzLApTb21hCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
