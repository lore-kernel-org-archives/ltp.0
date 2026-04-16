Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A8EF8A146
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 09:36:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 757A73E268D
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 11:36:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADE013C01A4
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 11:36:25 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B0CC8100094D
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 11:36:24 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8B7o31842709; Thu, 16 Apr 2026 09:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dYguJR
 kA9fQ89Du4odeV9M9oto1ItAteydBvzTj+O6s=; b=ZNxx1AE9Ma2d3bS3DBzK9c
 vvyvjPPCCuUAtokscklKahOQZ29rIvo2CyOJAF3ziE8JZdDHJIt4dxtbRgFhCx3a
 Qs7WUKOtHEuS6ucdy6dQ+HWXBW1jB1N8TBE0ciym95CjweOPgnSG87HZDNDY3iz7
 STK9h+tYktJz7kjRVhHKkI0HGAe7oWdA4ZSx/DYkKW6+fQEFKrjOama1essHEOid
 7WqdZCEv1bg/vN9eqIq29mUpBXdlVovedl7XTXhI+UBAweo9A6HQoogecLEkg/t6
 oSEyrd6qcyDg0qH7EdT1Fhi4E8cRpd9aBs/kPM6n18GIF9VV+1wo9/Fz6zj6m2Ow
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mvpc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 09:36:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G7KlSO003557;
 Thu, 16 Apr 2026 09:36:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnj8v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 09:36:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63G9aLAd33424046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 09:36:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3CDE5805A;
 Thu, 16 Apr 2026 09:36:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53AD258054;
 Thu, 16 Apr 2026 09:36:19 +0000 (GMT)
Received: from [9.43.36.193] (unknown [9.43.36.193])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 09:36:18 +0000 (GMT)
Message-ID: <d41449ae-b898-4ee5-b067-b8ff1cf5c836@linux.ibm.com>
Date: Thu, 16 Apr 2026 15:06:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20260324052241.21455-1-sachinp@linux.ibm.com>
 <20260324052241.21455-2-sachinp@linux.ibm.com>
 <b02c247c-94ed-4960-94c2-da62b2f5a474@suse.cz>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <b02c247c-94ed-4960-94c2-da62b2f5a474@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4NyBTYWx0ZWRfX6IrUZmQ4JUFM
 FW+uPzTQDuGOMcc6DroEaTp1UuJwRXM/1CLcLUA0pK3M5jfjElxN5fCQY9kMtSxa6nAmFjutSuN
 ZlJ+GkhS0kkvzq6oJU1H+EDNtVMHR2I8jTmWc+/yeYJXt5hP/WYbe1Cu8fgydEg1JXvY4mZssEf
 LEJ2ccd3TCyjXjd+tFporChlLYihzQXP6cJL4Uex3BkCP7bT0Hchd+OhWaJ2PHJifsnpePTlUc3
 vuA6JWGt4L3Hiard7q82kugVU7e7/YaH0P6CooqRT3FaTwWuSIV/7hlgpxaPqtpEEcAYj2GSkPE
 RKOLxn2FHICPyHCiXktmY+o91qK1rsLMwh3agRDZwCU2qEjO1xXpR68uycd4czLnxsOfixBlvJH
 cGqu1huMkpIyGE4MzJrM0yd36aoLVPA51OiY0iLPQHE2RVCuh/HsNrT+UudRoLedv+ohvsH9V9j
 3cJQoDr50IuUm1SoIJw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e0ad96 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Au47cNL6KygHqmR9bBIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5O66iIHt5A9TEzHf4tx4ympOJoVdbwVR
X-Proofpoint-ORIG-GUID: 5O66iIHt5A9TEzHf4tx4ympOJoVdbwVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160087
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] io_uring: Test IORING READ and WRITE
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAxNi8wNC8yNiAyOjI1IHBtLCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+IE9uIDMvMjQvMjYg
MDY6MjIsIFNhY2hpbiBTYW50IHdyb3RlOgo+PiArLyoKPj4gKyAqIE1hcCBpb191cmluZyBvcGVy
YXRpb24gY29kZSB0byBodW1hbi1yZWFkYWJsZSBuYW1lCj4+ICsgKi8KPj4gK3N0YXRpYyBpbmxp
bmUgY29uc3QgY2hhciAqaW9yaW5nX29wX25hbWUoaW50IG9wKQo+PiArewo+PiArwqDCoMKgIHN3
aXRjaCAob3ApIHsKPj4gK8KgwqDCoCBjYXNlIElPUklOR19PUF9SRUFEVjoKPj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAiSU9SSU5HX09QX1JFQURWIjsKPj4gK8KgwqDCoCBjYXNlIElPUklOR19P
UF9XUklURVY6Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gIklPUklOR19PUF9XUklURVYiOwo+
PiArwqDCoMKgIGNhc2UgSU9SSU5HX09QX1JFQUQ6Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
IklPUklOR19PUF9SRUFEIjsKPj4gK8KgwqDCoCBjYXNlIElPUklOR19PUF9XUklURToKPj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiAiSU9SSU5HX09QX1dSSVRFIjsKPgo+IEhpLAo+IElPUklOR19P
UF9SRUFEIGFuZCBJT1JJTkdfT1BfV1JJVEUgaGF2ZSBiZWVuIGFkZGVkIGluIGtlcm5lbCB2NS42
LiAKPiBTb21lIG9sZGVyIGRpc3Ryb3MgY3VycmVudGx5IGZhaWwgdG8gYnVpbGQgTFRQIGR1ZSB0
byB0aGVpciBtaXNzaW5nIAo+IGRlY2xhcmF0aW9ucyBzbyB5b3UnbGwgbmVlZCB0byBhZGQgdGhv
c2UgY29uc3RhbnRzIHRvIGxhcGkgaGVhZGVycy4KPgoKVGhhbmsgeW91IGZvciB0aGUgcmVwb3J0
LiBJIHdpbGwgc2VuZCBhIGZpeCB0byBhZGRyZXNzIHRoaXMuCgotLSAKVGhhbmtzCi0gU2FjaGlu
CgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
