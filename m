Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747B4F589DD
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 14:25:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 111CD3E2596
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 16:25:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A57D3E28E6
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 16:24:54 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 60F6A60029A
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 16:24:53 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N72hFY3514991; Thu, 23 Apr 2026 14:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZZYK5N
 bBvBOUDENefyGzyT3Mhv1qZQbZW+BK21kA5YE=; b=iUubUPfLLQ090kzZ+RIBys
 1QgD4HCWJsqXgTeU1PkYG8rTLLgzOGejbadwU3J3YMirogSp/kPnOUWr4IaED/8I
 hu70YuiX+O3Rzkav36tHd58KqYukQ3bbQTLj8TByhvPiLBegnypjko5y/p+n2b9l
 OilvJ0HWsdpwJ54Q6tPPqulFLBqSSLAuaLN6MPRrxwq3WwHqL+EABySiTc80GIXi
 ovFruWZQwDsO+8yrCKhDeOb/VYCD6LkAOcp9NQyONveIr5cVuwDLd1t5CEYdH7qq
 DGfGAXcZuA5+lrL9SE8z0oXjW0gITrhe8XJHCOwbjn/AWMQ9TndygY8eKOyXeNLQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2947s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 14:24:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEKF7x000661;
 Thu, 23 Apr 2026 14:24:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxxx5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 14:24:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NEOnkL28836374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 14:24:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 816ED58051;
 Thu, 23 Apr 2026 14:24:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 312FB5805C;
 Thu, 23 Apr 2026 14:24:47 +0000 (GMT)
Received: from [9.43.55.56] (unknown [9.43.55.56])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 14:24:46 +0000 (GMT)
Message-ID: <d830bdb8-e355-4d74-af0c-8678d6bfad7e@linux.ibm.com>
Date: Thu, 23 Apr 2026 19:54:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: pavrampu@linux.ibm.com
References: <69d8e6e5.5d0a0220.90693.5372@mx.google.com>
Content-Language: en-US
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <69d8e6e5.5d0a0220.90693.5372@mx.google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfXxA/gvcfG2GqW
 2c/oNxbrJ7AS/w8zQpbthdroDVvnGdFAgzd86MHr9tTgP7oyjogH1JL1CKFTISbvOhg1dY0c5Ti
 QY4XO8Pb6TESSOHXH/oePnuGnrZHtByqdF9zJM2ov8fbfzxItSh/Bwo6fl+FhiCBAem+uM46u3R
 vZlfLRL8Fz0dKHeE3FiAMbj0H4QUl+KTjSq0Rv8ArwqrtrZAweSeQ0l/dAnc9qfKBwzWSwdFYFn
 iqBkDkaxJtBYIryvG1YyJhotU+gNqSIxk/m0D45yja5DMuxx9g/HyXxewtWCujyd8UFehb1DKU4
 YfXPEj6YMZUQr3UTx7jhfcwEDpgG0ySYkTV6vbq4JnNaf6fQuIzBx1TuOCHbIvqApJVAnTtKHNr
 Vgu+7BpLaGQw1ZVsF1wF2ka7Anbz3ZD8B00jp9PJxxeflPUuj8eKU5QGodCAC8A4g2QZ6+1X5hM
 PXzlnK8dII+kOeOKmhg==
X-Proofpoint-ORIG-GUID: wlippW-ykjLdsGBKTvVaydsUwRWMm8d9
X-Proofpoint-GUID: wlippW-ykjLdsGBKTvVaydsUwRWMm8d9
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69ea2bb3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=6z3k2skA22KyvPbf0_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230142
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix memcontrol04 test failures on PowerPC64
 architecture.
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

CgpPbiAxMC8wNC8yNiA1OjMyIHBtLCBBbmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAgd3JvdGU6Cj4g
SGkgUGF2aXRocmEsCj4KPiBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhpcyByZXZpZXcgYmVmb3Jl
IHByb2NlZWRpbmcuIEkgdGhpbmsgdGhpcwo+IHBhdGNoIGlzIG5vdCBuZWVkZWQsIGJ1dCBhdCBs
ZWFzdCB5b3UgY2FuIHRyeSBhbmQgc2VlIGlmIG90aGVyCj4gcGVvcGxlIHdpbGwgc3BvdCBzb21l
dGhpbmcgdXNlZnVsLgo+Cj4gaHR0cHM6Ly9naXRodWIuY29tL2FjZXJ2L2x0cC1hZ2VudC9hY3Rp
b25zL3J1bnMvMjQxODk0ODU3NDUKPgo+IG1lbWNvbnRyb2wwWzM0XSBoYXZlIGEgbG9uZyBzdG9y
eSBvZiBzcG9yYWRpYyBmYWlsdXJlcyByZWxhdGVkIHRvCj4gdGhlIGtlcm5lbCBhc3luYyBuYXR1
cmUgYW5kIG1lbW9yeSBtYW5hZ2VtZW50IGltcGxlbWVudGF0aW9uLCBzbwo+IEkgYmVsaWV2ZSB0
aGlzIGlzIG5vdCBnb25uYSBmaXggdGhlIHRlc3QgaW4gdGhlIGxvbmcgcnVuLgo+Cj4gQnV0IG1h
eWJlIEknbSB3cm9uZy4gSXQncyBiZXR0ZXIgaWYgeW91IHNlbmQgYSB2MiBmaXJzdCwgZml4aW5n
Cj4gdGhlIGlzc3VlcywgdGhlbiBvdGhlciBwZW9wbGUgY2FuIHByb3Blcmx5IHJldmlldyBpdC4K
SGkgUGF2aXRocmEsCgpUaGUgZml4IGRvZXNuJ3Qgc2VlbSB0byBhZGRyZXNzIHRoZSByZWFsIHBy
b2JsZW0uIFRoaXMgdGVzdCBkb2VzIHNlZW0gZmxha3kuCkRlcGVuZGluZyBvbiBob3cgbWFueSBp
dGVyYXRpb25zIGFyZSBleGVjdXRlZCwgdGhlIGZhaWwgY291bnQgY2FuIHZhcnkuCgpJIHRyaWVk
IHNvbWUgZGVidWdnaW5nIG9uIG9uZSBvZiB0aGUgc3lzdGVtIEkgaGFkIGFjY2VzcyB0by4KClRo
ZSB0ZXN0IGZhaWxzIHdpdGggbWVtb3J5LmN1cnJlbnQgdmFsdWVzIG11Y2ggbG93ZXIgdGhhbiBl
eHBlY3RlZDoKIMKgIFRGQUlMOiAoQS9CL0MgbWVtb3J5LmN1cnJlbnQ9NjY4NDY3Mikgfj0gMzQ2
MDMwMDgKIMKgIFRGQUlMOiAoQS9CL0QgbWVtb3J5LmN1cnJlbnQ9NTM3Mzk1Mikgfj0gMTc4MjU3
OTIKCkl0IHNlZW1zIHRoZSBjaGlsZCBwcm9jZXNzZXMgYWxsb2NhdGluZyBwYWdlY2FjaGUgd2Vy
ZSBleGl0aW5nCmltbWVkaWF0ZWx5IGFmdGVyIGFsbG9jYXRpb24gKHZpYSB0c3RfcmVhcF9jaGls
ZHJlbigpKSwgY2F1c2luZyB0aGUKcGFnZWNhY2hlIHRvIGJlIGZyZWVkIGJlZm9yZSB0aGUgdGVz
dCBjb3VsZCBtZWFzdXJlIG1lbW9yeS5jdXJyZW50IHZhbHVlcy4KCkEgcG90ZW50aWFsIGZpeCBj
YW4gYmUgYXMgZm9sbG93czoKTW9kaWZ5IGFsbG9jX3BhZ2VjYWNoZV9pbl9jaGlsZCgpIHRvIGtl
ZXAgY2hpbGRyZW4gYWxpdmUgZHVyaW5nIHRlc3Q6Ci0gQWRkIFRFU1RfRE9ORSBjaGVja3BvaW50
IGZvciBjaGlsZCBsaWZlY3ljbGUgY29vcmRpbmF0aW9uCi0gUGFyZW50IHdhaXRzIGZvciBDSElM
RF9JRExFIGNoZWNrcG9pbnQgYmVmb3JlIHByb2NlZWRpbmcKLSBDaGlsZCBzaWduYWxzIENISUxE
X0lETEUgYWZ0ZXIgYWxsb2NhdGlvbiBhbmQgZnN5bmMKLSBDaGlsZCB3YWl0cyBmb3IgVEVTVF9E
T05FIHRvIGtlZXAgbWVtb3J5IGFsbG9jYXRlZCBkdXJpbmcgdGVzdAotIE1vZGlmeSBjbGVhbnVw
X3N1Yl9ncm91cHMoKSB0byB3YWtlIHdhaXRpbmcgY2hpbGRyZW4gYmVmb3JlIGNsZWFudXAKLSBD
aGFuZ2UgYWxsb2NfYW5vbl9pbl9jaGlsZCgpIHRvIHVzZSBTQUZFX1dBSVRQSUQoKSBmb3Igc3Bl
Y2lmaWMgY2hpbGQKClRoaXMgd2lsbCBlbnN1cmUgcGFnZWNhY2hlIHJlbWFpbnMgYWxsb2NhdGVk
IGR1cmluZyBtZW1vcnkgcHJlc3N1cmUKdGVzdGluZywgYWxsb3dpbmcgY29ycmVjdCBtZW1vcnku
Y3VycmVudCBtZWFzdXJlbWVudHMuCgpVbnRlc3RlZCBwYXRjaDoKCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwNC5jIApiL3Rlc3RjYXNl
cy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMKaW5kZXggNzE1Y2M1YmNk
Li5kMDE4OGExZGEgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVt
Y2cvbWVtY29udHJvbDA0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1j
Zy9tZW1jb250cm9sMDQuYwpAQCAtNDcsNyArNDcsOCBAQCBzdGF0aWMgc3RydWN0IHRzdF9jZ19n
cm91cCAqbGVhZl9jZ1s0XTsKIMKgc3RhdGljIGludCBmZCA9IC0xOwoKIMKgZW51bSBjaGVja3Bv
aW50cyB7Ci3CoCDCoCDCoCDCoENISUxEX0lETEUKK8KgIMKgIMKgIMKgQ0hJTERfSURMRSwKK8Kg
IMKgIMKgIMKgVEVTVF9ET05FLAogwqB9OwoKIMKgZW51bSB0cnVua19jZyB7CkBAIC02Nyw2ICs2
OCwxNiBAQCBzdGF0aWMgdm9pZCBjbGVhbnVwX3N1Yl9ncm91cHModm9pZCkKIMKgewogwqAgwqAg
wqAgwqAgc2l6ZV90IGk7CgorwqAgwqAgwqAgwqBmb3IgKGkgPSBBUlJBWV9TSVpFKGxlYWZfY2cp
OyBpID4gMDsgaS0tKSB7CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghbGVhZl9jZ1tpIC0g
MV0pCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOworCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFRTVF9DSEVDS1BPSU5UX1dBS0UyKFRFU1RfRE9ORSwKK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFSUkFZX1NJ
WkUobGVhZl9jZykgLSAxKTsKK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHN0X3JlYXBfY2hpbGRy
ZW4oKTsKK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7CivCoCDCoCDCoCDCoH0KKwogwqAg
wqAgwqAgwqAgZm9yIChpID0gQVJSQVlfU0laRShsZWFmX2NnKTsgaSA+IDA7IGktLSkgewogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFsZWFmX2NnW2kgLSAxXSkKIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOwpAQCAtODgsNyArOTksNyBAQCBzdGF0aWMg
dm9pZCBhbGxvY19hbm9uX2luX2NoaWxkKGNvbnN0IHN0cnVjdCAKdHN0X2NnX2dyb3VwICpjb25z
dCBjZywKIMKgIMKgIMKgIMKgIGNvbnN0IHBpZF90IHBpZCA9IFNBRkVfRk9SSygpOwoKIMKgIMKg
IMKgIMKgIGlmIChwaWQpIHsKLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHN0X3JlYXBfY2hpbGRy
ZW4oKTsKK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU0FGRV9XQUlUUElEKHBpZCwgTlVMTCwgMCk7
CiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47CiDCoCDCoCDCoCDCoCB9CgpAQCAtMTA3
LDcgKzExOCw3IEBAIHN0YXRpYyB2b2lkIGFsbG9jX3BhZ2VjYWNoZV9pbl9jaGlsZChjb25zdCBz
dHJ1Y3QgCnRzdF9jZ19ncm91cCAqY29uc3QgY2csCiDCoCDCoCDCoCDCoCBjb25zdCBwaWRfdCBw
aWQgPSBTQUZFX0ZPUksoKTsKCiDCoCDCoCDCoCDCoCBpZiAocGlkKSB7Ci3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHRzdF9yZWFwX2NoaWxkcmVuKCk7CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFRT
VF9DSEVDS1BPSU5UX1dBSVQoQ0hJTERfSURMRSk7CiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXR1cm47CiDCoCDCoCDCoCDCoCB9CgpAQCAtMTE3LDYgKzEyOCwxMSBAQCBzdGF0aWMgdm9pZCBh
bGxvY19wYWdlY2FjaGVfaW5fY2hpbGQoY29uc3Qgc3RydWN0IAp0c3RfY2dfZ3JvdXAgKmNvbnN0
IGNnLAogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ2V0cGlkKCksIHRzdF9jZ19ncm91cF9uYW1l
KGNnKSwgc2l6ZSk7CiDCoCDCoCDCoCDCoCBhbGxvY19wYWdlY2FjaGUoZmQsIHNpemUpOwoKK8Kg
IMKgIMKgIMKgU0FGRV9GU1lOQyhmZCk7CisKK8KgIMKgIMKgIMKgVFNUX0NIRUNLUE9JTlRfV0FL
RShDSElMRF9JRExFKTsKK8KgIMKgIMKgIMKgVFNUX0NIRUNLUE9JTlRfV0FJVChURVNUX0RPTkUp
OworCiDCoCDCoCDCoCDCoCBleGl0KDApOwogwqB9CgoKLS0gClRoYW5rcwotIFNhY2hpbgoKCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
