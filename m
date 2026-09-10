Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31228C79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 17:17:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3F9E3E9278
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 19:17:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABBED3C2024
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 19:17:15 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8CE41000138
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 19:17:14 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AFD7bM3266412; Thu, 10 Sep 2026 17:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=H8pd0J
 eAvomFr7pIuxzliC6H87OPrSV73D+x0UxTo/E=; b=X5vJJ0x4+xib2QyaJ+pPU1
 lqP3JRA4Zg/Gd/qP76rw8Jze3VxCjGguNsaiYOuLmYG350u2LSeubMgVNjRLxhuA
 lywYPzPteoOP9IelYb8KzfUAcOvzP7PhD7Gzbht6XlhJvTQWk93m7VADCIvD2D2M
 V8qZzmOnQw1tWIxYhJV8MrxNEpX6Kegbgvla8gPTQbQw4zJ4IOSaaLh7uizUKrmG
 maYNuAtgWev5u0B4ybE8M14xqOGToIQLHQN1DXu4JK9/Mgq4CpQ76rdJuqkkfupw
 oy5D0hOzeGxAV2HUem08LClfZhhapKB7/Xjot830wGoAPipXYr/AgwX5HBf0ku0A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qp8uf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 17:17:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF7baB183831; Thu, 10 Sep 2026 17:17:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk1dce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 17:17:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68AHHAvp63635780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2026 17:17:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9869A58055;
 Thu, 10 Sep 2026 17:17:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80AE858043;
 Thu, 10 Sep 2026 17:17:09 +0000 (GMT)
Received: from [9.43.97.139] (unknown [9.43.97.139])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2026 17:17:09 +0000 (GMT)
Message-ID: <79205674-e10f-492b-a18b-f51a09533671@linux.ibm.com>
Date: Thu, 10 Sep 2026 22:47:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <6a8da2ac.87996512.214a96.27cc@mx.google.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <6a8da2ac.87996512.214a96.27cc@mx.google.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa2e618 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=iox4zFpeAAAA:8
 a=3AXiKTiIDPHFyvT3JqgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: TdmKNdDrB_GswaAkSR6KIHMyq2AHiqlo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIwOCBTYWx0ZWRfX8RR5O06/yfJu
 9Y7LcpYtRX/z+nND9Ass7Rx08MNNu9M0bg9Ef3DPaT34mwtfDyz5fNnR9AbMyMu//8JAFUSvyBt
 olTmNHKyJq4Z1gldDixbiX6e7Rm1G2rLah7vpQ7oU7ZBMLTqrykPp5MXhTuqPfbIajP+iTIquFb
 qXraInIIRUyoJplTPJ48zw69bGzW6U2ExPxmD98f5mwrD7PugBodemYAjkhSZfeRZItEi0p/soL
 uWTh1B6SAG5gSsW0a9A6MUfUuwfMENWNXHHAhR3Ka4L7Hpxmx0WeLH/c0yLfqjWlGPtNyGoSmwS
 ORu36eBkCgrMYkO9pl71+ZztF0s4Olmx9pgXEHawnZfXR0HXEcc+trow6nAOtI+VGGS8C7SJ65N
 xU6J+d0l1NR9UK68ndAOQzVqYWlvpFKoKbKuX7jnR3Touo+2tYz5B/m83RCDucGp8Q07chxjlTm
 Vv0t6+Al0bu1/HIRkMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIwOCBTYWx0ZWRfX1ituUpJ8/W/1
 JK/mmlq9vJLER/hueQTa5K47DNWQUpDHrgJMGps8/KCbiKU8uwolQ+Wsr80pMNey/8mjakLIzfV
 roNwT7HFE2d+K6xRnjfX7e79gnpwcxk=
X-Proofpoint-GUID: TdmKNdDrB_GswaAkSR6KIHMyq2AHiqlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100208
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] sched/cfs-scheduler: Fix 'make check' errors
 and warnings in hackbench.c
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gMjUvMDgvMjYgNzo0MSBwbSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToK
PiBIaSBTYW1pciwKPgo+IG1taC4uSSB3YXMgYWJvdXQgdG8gbWVyZ2UgdGhpcyBwYXRjaCwgYnV0
IHRoZW4gSSByZWFsaXplZCB0aGF0Cj4gdGhpcyB3YXMgYXBwbGllZCBvbiBhIG9sZCBBUEkgdGVz
dCwgd2hpY2ggaXMgZ29pbmcgdG8gYmUKPiByZXdyaXR0ZW4gYW55d2F5IGludG8gdGhlIG5ldyBB
UEkuIEZvciB0aGlzIHJlYXNvbiwgSSdtIG5vdAo+IHN1cmUgYW55bW9yZSBpZiBpdCdzIHRoZSBj
YXNlIHdlIGFyZSBtZXJnaW5nIGl0Lgo+Cj4gQXJlIHlvdSBwbGFubmluZyB0byByZXdyaXRlIHRo
ZSBjb2RlIGludG8gdGhlIG5ldyBMVFAgQVBJPwpZZXMsIEnigJltIHBsYW5uaW5nIHRvIHJld3Jp
dGUgaXQgdXNpbmcgdGhlIG5ldyBMVFAgQVBJIGFuZCB3aWxsIHNlbmQgYW4gCnVwZGF0ZWQgcGF0
Y2ggZm9yIHJldmlldy4KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4KCj4gLS0KPiBBbmRy
ZWEgQ2VydmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4Cj4gYW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmNvbQpCZXN0IHJlZ2FyZHMsClNhbWlyCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
