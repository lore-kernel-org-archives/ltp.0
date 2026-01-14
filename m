Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B4AD37E3F
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 15:12:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A95243C9CCA
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 16:12:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B763A3C9AA9
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 16:12:02 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B4F9360010D
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 16:12:01 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60EE1ctU013363;
 Wed, 14 Jan 2026 15:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VQS6zr
 w/Rv+8VRfrDR4ZQiwYSwb0FJjDA0oTmHAH6WU=; b=OAreXrHYnls+XNzOn+iule
 +0V9UeBMb1zz1ADs4xLBBrFl/gNH0g5KvHAcxHUtqtV2MCg0LHs2ucGx6wtIIKxO
 LFZZWPjVBpbRy1IMAb5mJy1s6a52OtlA4wYpPXoqp6i6cQt1y47bEIGgqRprV1Q5
 NQqh3O58RKdZ1aFUbd2SLh0phK/LV24KP1A2mxhpPyO/gnj7SyV5VSB4Kw7ydxmE
 XV6u1ZqCo2bgLGCsLgZ86gTZZFiv01lFMdbxFkfCzy97D82RxINHW7mdXPk9nW0Y
 mHppkXH5uwGuQmx/v7ffi1/MyegJp1HORKV1LQQ61iDm2lgcYxzbrn59Z0W2Cm5Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedt1kjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 15:11:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EEVVNV025848;
 Wed, 14 Jan 2026 15:11:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kkjqgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 15:11:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60EFBexh27591190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jan 2026 15:11:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B51985805E;
 Wed, 14 Jan 2026 15:11:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61A5E58066;
 Wed, 14 Jan 2026 15:11:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.13.234]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Jan 2026 15:11:58 +0000 (GMT)
Message-ID: <41d432e3b9c16d712080295235ca000a6cb6e07c.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260107155737.791588-2-pvorel@suse.cz>
References: <20260107155737.791588-1-pvorel@suse.cz>
 <20260107155737.791588-2-pvorel@suse.cz>
Date: Wed, 14 Jan 2026 10:11:58 -0500
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfX2Jr+Uv04Tgmz
 minhAVAqdl2On7tAwIyWTeS1Fcp06zgspCZGevN3omzM7+Ty/Y12tINMwGfGHXpdYhZCi3DaQ7P
 DATIa7WV64wNY1/TEATbbcnQ7X91pv6s3jYfx13b1y0E5eMMXGyvSTV4Paid1buZVBC9rTwwpOz
 BDI9xrwbWIB2gTBj6xEXlReGa0uHW7pPoi43NqkSElLFb0VK50Dkyzg0mwuiOChYaOxptsIOVqo
 XRfu51sUdr28QIxAcc0vu8VqdLp9KsFOllxa5bxukglmGGcnSxt2fIZBnFHcXZ1nT2d2DI/Ij5X
 jYnuy7v8Ru3AooyaUE3mjYZB8Mp3SaDIsRUNjiaRFmSoRKBXDW5g8v2wKXTW3KcD5Eyhmsl4CiC
 lgXbfr3lhhinDrVS2slsGqdf3Uiu+vPzcPtGA6XftiKH54EzuW/j/46HmhTiXsrq2J6Mnv9AFWx
 kUcvrTajafKNz1RyclA==
X-Proofpoint-GUID: GRGK8s7iYE32UZHOb2wVKvattaoOMkFt
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6967b240 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wlRH1G3uh7w6tWQy2i0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GRGK8s7iYE32UZHOb2wVKvattaoOMkFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140123
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ima_kexec.sh: Document kernel config
 dependencies
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCAyMDI2LTAxLTA3IGF0IDE2OjU3ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IENP
TkZJR19IQVZFX0lNQV9LRVhFQz15IGlzIGVub3VnaCBmb3IgdGVzdCwgaWUuIHRlc3QgaXMgd29y
a2luZyB3aXRoOgo+IAo+ICAgICAjIENPTkZJR19JTUFfS0VYRUMgaXMgbm90IHNldAo+ICAgICBD
T05GSUdfSEFWRV9JTUFfS0VYRUM9eQo+IAo+IFByb2JhYmx5IG9idmlvdXMgYXMgQ09ORklHX0hB
VkVfSU1BX0tFWEVDIGlzIGFyY2ggc3BlY2lmaWMgYW5kCj4gQ09ORklHX0lNQV9LRVhFQyBpcyAi
VFBNIFBDUnMgYXJlIG9ubHkgcmVzZXQgb24gYSBoYXJkIHJlYm9vdC4iCj4gYW5kIGltYV9rZXhl
Yy5jIHJlcXVpcmVzIENPTkZJR19IQVZFX0lNQV9LRVhFQyAob25seSBwYXJ0cyBhcmUgc2tpcHBl
ZAo+IHdoZW4gQ09ORklHX0lNQV9LRVhFQyBub3Qgc2V0KSBidXQgYmV0dGVyIHRvIGNsYXJpZnkg
Zm9yIHVzZXJzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
Pgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMv
aW1hX2tleGVjLnNoIHwgMyArKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+
IAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
dGVzdHMvaW1hX2tleGVjLnNoIGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL3Rlc3RzL2ltYV9rZXhlYy5zaAo+IGluZGV4IDc2ODg2OTBhZjIuLmRlNTk1ZmNkZDcgMTAw
NzU1Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3Rz
L2ltYV9rZXhlYy5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5
L2ltYS90ZXN0cy9pbWFfa2V4ZWMuc2gKPiBAQCAtNiw4ICs2LDExIEBACj4gICMKPiAgIyBWZXJp
ZnkgdGhhdCBrZXhlYyBjbWRsaW5lIGlzIG1lYXN1cmVkIGNvcnJlY3RseS4KPiAgIyBUZXN0IGF0
dGVtcHRzIHRvIGtleGVjIHRoZSBleGlzdGluZyBydW5uaW5nIGtlcm5lbCBpbWFnZS4KPiArIwo+
ICAjIFRvIGtleGVjIGEgZGlmZmVyZW50IGtlcm5lbCBpbWFnZSBleHBvcnQgSU1BX0tFWEVDX0lN
QUdFPTxwYXRobmFtZT4uCj4gICMgVGVzdCByZXF1aXJlcyBleGFtcGxlIElNQSBwb2xpY3kgbG9h
ZGFibGUgd2l0aCBMVFBfSU1BX0xPQURfUE9MSUNZPTEuCj4gKyMKPiArIyBUZXN0IHJlcXVpcmVz
IENPTkZJR19IQVZFX0lNQV9LRVhFQz15IChDT05GSUdfSU1BX0tFWEVDIGlzIG5vdCBtYW5kYXRv
cnkpLgoKQ29ycmVjdC7CoCBUaGUgdGVzdCB2ZXJpZmllcyB0aGF0IHRoZSBrZXJuZWwgaW1hZ2Ug
aXMgbWVhc3VyZWQuICBJdCBkb2VzIG5vdApleGVjdXRlIHRoZSBrZXhlYywgc28gdGhlcmUgaXMg
bm8gbmVlZCBmb3IgY2FycnlpbmcgdGhlIElNQSBtZWFzdXJlbWVudCBsaXN0CmFjcm9zcyBrZXhl
YyAoQ09ORklHX0lNQV9LRVhFQykuCgo+ICAKPiAgVFNUX05FRURTX0NNRFM9ImdyZXAga2V4ZWMg
c2VkIgo+ICBUU1RfQ05UPTMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
