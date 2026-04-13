Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6C5E9381A
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 05:28:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82CFF3E2670
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 07:28:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E34B3C0E59
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 07:27:47 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B51BF600110
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 07:27:46 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CMQWVI3538921; Mon, 13 Apr 2026 05:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=SVxOFqRsC3ixlg75cc2qGaS9t15PHb
 AACdkUvwUVwrQ=; b=E6pCvlA8lvfKB48vyH1r7LEKMm8qSSxTeqjiU+3u0q74L4
 EIWhhKaPGF8Pky8J8etSw6hgEKD2yhRLugMF9h8RIvkdpSVFkTCw/ebUT/kT8k4N
 gXZ+r0fu5mmS6hYuqvF3OUfHageYSyP6+4FvaT0DZvQ4R/Gw+UXRn0DhXFAUcx+Q
 i+j/ScqlRT4fkd4+UT8W1zVBZxGzfOhlW0Hz436KBYCDsq3w17QPz3MW4t+f4Az0
 /yT7wvM05dx9+vmsYxouhW3l7i83BYCrhPvzz1Zq7Pca4iPpNlVLoigZYgCqZJ9Z
 GmVPmiMsRj6Ig+lMPItZo4z0etuyXl/OPifvg3dA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3p4yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 05:27:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D55us6025781;
 Mon, 13 Apr 2026 05:27:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1bh5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 05:27:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63D5RgEj10158610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 05:27:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A22958059;
 Mon, 13 Apr 2026 05:27:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DAA35804B;
 Mon, 13 Apr 2026 05:27:40 +0000 (GMT)
Received: from [9.43.104.112] (unknown [9.43.104.112])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Apr 2026 05:27:39 +0000 (GMT)
Message-ID: <f5b8b153-2fd8-4e6e-8446-0d9fe82221cd@linux.ibm.com>
Date: Mon, 13 Apr 2026 10:57:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <6215241a-07c4-4eed-8549-0e0afc2fc096@linux.ibm.com>
 <adxiNs3KpMO-nEVG@redhat.com>
Content-Language: en-US
From: Soma Das <somadas1@linux.ibm.com>
In-Reply-To: <adxiNs3KpMO-nEVG@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GBn07ya7JYmr6zWUa4XqJ-4zr8dppvxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA0OCBTYWx0ZWRfXwnEmqReBXbq9
 +fvkEP4JGMeSmu8lgCv9MjT0w9osXsOOGrsQ/PHmigPRVWyagV2Ekqrd6Uw3aBuMraBcR02awlG
 0xShJW4/f9mU3uhxK44r8JF0/xCOy+cu/Y3jkFwaJHgLBVEnWabwFosAOYaRK3hMG+bSz/vSC+N
 zgdjQ/XMg+jkA5o4Z+Hh2mD3Eokk2A9Kucr7H/eFwkP0gA53D4Kw1v7nmeovBgvrZAqIQsUti3m
 dJMpdS3FVW0doICsx0u+OhjA8a7d6PmLc2Swgx+zYvVdNRyNiuFW3l0nBsncQ41ayB9NTHLD1M4
 wzC4X1OQftcB88j8LD4BtNbS4dJ3LLnrjYxQz0NGDgysBW0GFWMyvd0Pq1JA/JQfCrhNNIt2HiK
 xMzV6j1XwjoHGi4pDPxd8BbL8oeaXTCFIzu6A1/XFNk9YYUfyQsV81m21PQ1R/MfldKJHuTgnjV
 yPqYz9OABWIwxB3T9Mg==
X-Proofpoint-GUID: RADzpe4uVJwHV5Hu1T2jYSo2FjqfJxrz
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dc7ed0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=pGLkceISAAAA:8
 a=WVoxJWIhaqlnrWsZqHgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=20KFwNOVAAAA:8
 a=TEv-KCbQBO2lq7Ilr10A:9 a=3ZE5zfFXTYcXvKQm:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130048
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mmap: fix intermittent OOM kill of test parent in
 mmap22
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

SGkgTGkgV2FuZywKClRoYW5rcyBmb3IgdGhlIHJldmlldy4KClVuZGVyc3Rvb2QuIFNldHRpbmcg
dGhlIGNoaWxkIHRvICsxMDAwIHJlbW92ZXMgbWVtb3J5IHByZXNzdXJlIAppbW1lZGlhdGVseSBv
bmNlIGl0IGdldHMga2lsbGVkLCBjYXVzaW5nIHRoZSBwYXJlbnQgdG8gdGltZSBvdXQgd2l0aCAK
VEZBSUwuIEknbGwgcmV3b3JrIHVzaW5nIHlvdXIgc3VnZ2VzdGVkIHxzdHJlc3NfY2hpbGQoKXwg
YXBwcm9hY2ggd2l0aCAKMU1CIGNodW5rcyBhbmQgdGhlIDgwJSB0aHJlc2hvbGQgZGVsYXkuCgpJ
J2xsIGFsc28gY2hlY2sgfGxpYi90c3RfbWVtdXRpbHMuaHwgYmVmb3JlIGZpbmFsaXppbmcuCgp2
MiB3aWxsIGJlIHJlYmFzZWQgb24gbGF0ZXN0IG1hc3RlciBhbmQgc2VudCB2aWEgZ2l0IHNlbmQt
ZW1haWwuCgpUaGFua3MsIFNvbWEgRGFzCgoKT24gMTMvMDQvMjYgODo1NSBBTSwgTGkgV2FuZyB3
cm90ZToKPiBIaSBTb21hLAo+Cj4+ICDCoHN0YXRpYyB2b2lkIHN0cmVzc19jaGlsZCh2b2lkKQo+
PiAgwqB7Cj4+ICDCoCDCoCDCoGZvciAoOzspIHsKPj4gQEAgLTYzLDkgKzgyLDI1IEBAIHN0YXRp
YyB2b2lkIHRlc3RfbW1hcCh2b2lkKQo+Pgo+PiAgwqAgwqAgwqB2ZWMgPSBTQUZFX01BTExPQyhu
cGFnZXMpOwo+Pgo+PiArwqAgwqAgLyoKPj4gK8KgIMKgIMKgKiBQcm90ZWN0IHRoZSBwYXJlbnQg
KHRlc3QgaGFybmVzcykgZnJvbSB0aGUgT09NIGtpbGxlci4gQm90aCBwYXJlbnQKPj4gK8KgIMKg
IMKgKiBhbmQgY2hpbGQgc2hhcmUgdGhlIHNhbWUgbWVtY2csIHNvIHdpdGhvdXQgYW4gZXhwbGlj
aXQgaGludCB0aGUgT09NCj4+ICvCoCDCoCDCoCoga2lsbGVyIHBpY2tzIGJhc2VkIG9uIGhldXJp
c3RpY3MgdGhhdCBjYW4gZmF2b3VyIHRoZSBwYXJlbnQuCj4+ICvCoCDCoCDCoCovCj4+ICvCoCDC
oCBzZXRfb29tX3Njb3JlX2FkaigtMTAwMCk7Cj4+ICsKPj4gIMKgIMKgIMKgY2hpbGQgPSBTQUZF
X0ZPUksoKTsKPj4gLcKgIMKgIGlmICghY2hpbGQpCj4+ICvCoCDCoCBpZiAoIWNoaWxkKSB7Cj4+
ICvCoCDCoCDCoCDCoCAvKgo+PiArwqAgwqAgwqAgwqAgwqAqIE1ha2UgdGhlIGNoaWxkIHRoZSBw
cmVmZXJyZWQgT09NIHZpY3RpbS4gSWYgT09NIGZpcmVzIHdoaWxlCj4+ICvCoCDCoCDCoCDCoCDC
oCogdGhlIHN0cmVzcyB3b3JrZXIgaXMgZmlsbGluZyBtZW1vcnksIHRoZSBrZXJuZWwgbXVzdCBr
aWxsIHRoZQo+PiArwqAgwqAgwqAgwqAgwqAqIGNoaWxkIChzdHJlc3Mgd29ya2VyKSBhbmQgbm90
IHRoZSBwYXJlbnQgKHRlc3QgaGFybmVzcykuCj4+ICvCoCDCoCDCoCDCoCDCoCogb29tX3Njb3Jl
X2Fkaj0xMDAwIGlzIHRoZSBtYXhpbXVtLCBndWFyYW50ZWVpbmcgdGhpcyBwcm9jZXNzCj4+ICvC
oCDCoCDCoCDCoCDCoCogaXMgY2hvc2VuIGZpcnN0IHdpdGhpbiB0aGUgY2dyb3VwLgo+PiArwqAg
wqAgwqAgwqAgwqAqLwo+PiArwqAgwqAgwqAgwqAgc2V0X29vbV9zY29yZV9hZGooMTAwMCk7Cj4g
U2V0dGluZyB0aGUgY2hpbGQncyBvb21fc2NvcmVfYWRqIHRvIDEwMDAgZG9lcyBzZXZlcmVseSBj
b21wcm9taXNlIHRoZQo+IHZhbGlkaXR5IG9mIHRoZSB0ZXN0LiBUaGlzIHdvdWxkIHR5cGljYWxs
eSByZXN1bHQgaW4gYSBmYWxzZSBuZWdhdGl2ZS4KPgo+IEJlY2F1c2Ugb25jZSB0aGUgY2hpbGQg
Z2V0cyBraWxsZWQgdGhlIG1lbW9yeSBzdHJlc3Mgd2lsbCBkaXNhcHBlYXIKPiBpbW1lZGlhdGVs
eSwgYnV0IHRoZSBwYXJlbnQgc3RpbGwga2VlcHMgbG9vcGluZyBmb3IgY2hlY2sgaWYga2VybmVs
IHJlY2xhaW0KPiB0aG9zZSBtZW1vcnksIGl0IHdpbGwgZXZhbnRhdWxseSByZXBvcnQgVEZBSUwg
d2hlbiB0aW1lIGVsYXBzZWQuCj4KPiBJbnN0ZWFkIG9mIG1vZGlmeWluZyBvb21fc2NvcmVfYWRq
IHRvIGludGVyZmVyZSB3aXRoIHRoZSBPT00ga2lsbGVyLCBhCj4gYmV0dGVyIGFwcHJvYWNoIGlz
IHRvIG9wdGltaXplIGhvdyB0aGUgY2hpbGQgcHJvY2VzcyBnZW5lcmF0ZXMgbWVtb3J5Cj4gcHJl
c3N1cmUsIG1ha2luZyBpdCBtb3JlIHJlZmxlY3RpdmUgb2YgcmVhbC13b3JsZCBtZW1vcnkgcmVj
bGFpbSBzY2VuYXJpb3MuCj4KPiBGb3IgZXhhbXBsZSwgdGhlIGNoaWxkIHByb2Nlc3MgY2FuIGFs
bG9jYXRlIGxhcmdlciBjaHVua3MgKGUuZy4sIDFNQikgdG8KPiByYXBpZGx5IGJ1aWxkIHVwIG1l
bW9yeSBwcmVzc3VyZS4gT25jZSB0aGUgdG90YWwgYWxsb2NhdGVkIG1lbW9yeSBhcHByb2FjaGVz
Cj4gdGhlIGNncm91cCBsaW1pdCAoZS5nLiwgODAlIGNhcGFjaXR5KSwgYSBzbWFsbCBkZWxheSBj
YW4gYmUgaW50cm9kdWNlZAo+IGludG8gdGhlIGFsbG9jYXRpb24gbG9vcC4gVGhpcyBhcHByb2Fj
aCBlZmZpY2llbnRseSBkcml2ZXMgdGhlIHN5c3RlbSB0bwo+IGl0cyBtZW1vcnkgbGltaXQgd2hp
bGUgcHJvdmlkaW5nIHRoZSBrZXJuZWwncyByZWNsYWltIG1lY2hhbmlzbSBhIHN1ZmZpY2llbnQK
PiB0aW1lIHdpbmRvdyB0byBpZGVudGlmeSBhbmQgZHJvcCBNQVBfRFJPUFBBQkxFIHBhZ2VzLiBJ
dCBhbHNvIGVmZmVjdGl2ZWx5Cj4gYXZvaWRzIGFuIGluc3RhbnRhbmVvdXMgbWVtb3J5IHNwaWtl
IHRoYXQgd291bGQgb3RoZXJ3aXNlIHRyaWdnZXIgdGhlIE9PTQo+IGtpbGxlciBwcmVtYXR1cmVs
eS4KPgo+ICNkZWZpbmUgQ0hVTktfU0laRSAoMTAyNCAqIDEwMjQpCj4KPiBzdGF0aWMgdm9pZCBz
dHJlc3NfY2hpbGQoc2l6ZV90IGNnX2xpbWl0KQo+IHsKPiAJc2l6ZV90IGFsbG9jYXRlZCA9IDA7
Cj4gCXNpemVfdCB0aHJlc2hvbGQgPSBjZ19saW1pdCAqIDggLyAxMDsKPgo+IAlmb3IgKDs7KSB7
Cj4gCQljaGFyICpidWYgPSBtYWxsb2MoQ0hVTktfU0laRSk7Cj4KPiAJCWlmICghYnVmKSB7Cj4g
CQkJdXNsZWVwKDEwMDAwKTsKPiAJCQljb250aW51ZTsKPiAJCX0KPgo+IAkJbWVtc2V0KGJ1Ziwg
J0InLCBDSFVOS19TSVpFKTsKPiAJCWFsbG9jYXRlZCArPSBDSFVOS19TSVpFOwo+Cj4gCQlpZiAo
YWxsb2NhdGVkID49IHRocmVzaG9sZCkgewo+IAkJCXVzbGVlcCgxMDAwKTsKPiAJCX0KPiAJfQo+
IH0KPgo+IEFuZCBzb21lIHdvcmtmbG93IGlzc3VlczoKPgo+ICAgLSBwbGVhc2UgcmViYXNlIHlv
dSBjb2RlIG9uIHRoZSBsYXRlc3QgYnJhbmNoIGJlZm9yZSBjb29raW5nIGEgcGF0Y2guCj4KPiAg
IC0gVXNlIGdpdCBzZW5kLWVtYWlsIHRvIHNlbmQgcGF0Y2ggdG8gTFRQIG1haWxpbmcgbGlzdC4K
Pgo+ICAgLSBGWUk6IExUUCBoYXMgYWxyZWFkeSBhY2hpZXZlZCB0aGUgb29tIHByb3RlY3Rpb24g
ZnVjbnRpb25zOgo+ICAgICBzZWU6IGxpYi90c3RfbWVtdXRpbHMuaAo+Cj4gTm90ZToKPiAgIFRo
aXMgd29yay1lbWFpbCB3aWxsIGJlIGRpc2FibGVkIHNvb24sIHJlcGx5IHRvOndhbmdsaS5haGF1
QGdtYWlsLmNvbQo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
