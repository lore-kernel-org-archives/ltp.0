Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D6CE937E1
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 14:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2740B3E294E
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 16:16:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8B523D024C
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 16:16:31 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4CBA61400264
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 16:16:29 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63C412Fd1134075; Sun, 12 Apr 2026 14:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UG4mjC
 qD+u8nQnejai3hOaZT9Vg3mq/5OU8/0ZT4/x8=; b=J04+4lTc/TicGbkU0t5Sp/
 rwaxmf5hdyHSLpuKfKtEwcP2RhY/RVRAJLchYJLJTR/8Rc4n3FH8o81zQ7OXW6x+
 Gk7TWG5NeWOs5gCtGFgC8Yg4RXsmmIQ0WJcGBh2wAGs7bGVVw3xRPR9Uopsv8GSf
 xHd94T+HzLxBEgu8HyiKG6fogBEEBJ1JXOJjAuU3sY7z4IMEUiQq+srRh6phu6q6
 LrTuvpGueUB8yebdOyO1Chm0kCn7HSkM3hGnpni/idiwpNW24nxtAk8eyiTxYPfD
 NbH3o34FsnjTonzfrMuNEnjzSEYcJT4CiX9qrtYDImh8QYekS4zCHfsLZqnaI0uw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdxwuvyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 14:16:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63C94VRQ004569;
 Sun, 12 Apr 2026 14:16:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k1k8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 14:16:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63CEGQRe28377796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 Apr 2026 14:16:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A7B958056;
 Sun, 12 Apr 2026 14:16:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D36958052;
 Sun, 12 Apr 2026 14:16:25 +0000 (GMT)
Received: from [9.39.25.30] (unknown [9.39.25.30])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 Apr 2026 14:16:25 +0000 (GMT)
Message-ID: <5ea8ce47-4c93-42cf-b808-ff47faf50d70@linux.ibm.com>
Date: Sun, 12 Apr 2026 19:46:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260407054943.125260-1-samir@linux.ibm.com>
 <adYhNrtHEGBRO2xF@yuki.lan>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <adYhNrtHEGBRO2xF@yuki.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDEzNSBTYWx0ZWRfXzHs3TcJXiGTD
 ruCQQhjItdxjexi6eEdHIcBz673qusrWXy4Wkvo96daGUkiMYE29PVGzDfmozjKfLVW8l2EigW+
 Y1zAFjp1daQPvMY8+zWEKz2ZnsZEN8xkWLetZZgRxTj+ry4acDQa0wkcPm5gqfEFrgnzXdDgOOh
 P2EEGGGo/s9cOhY1+VXp3j87yQQmSRcqQSacoilfbktnaa9EVmY9YBC+qxRZgBJnA09ixrn2KnU
 P9UUN5h2jFICjBLBnf5MPbD+ZO8CzNhvZKouAbobVGC+tOa59VQDNyeKlWrLzbe8zUKv/ZAbZ0c
 v9tpIdmdhUg2vDWsVeEHzTQ/9ucm1dVVAd+uezZqV1URYsx3wzODsApDtrjBIKZ0CfIlo2kKWz7
 tozCIuctDUsejXux/wRYAuFShSJNIszHNRaa8swva8CRRLj9BakzFq2hX1hNuLjPV57NJYb9i7W
 8PrsU8+MtvVGgdmcfZA==
X-Proofpoint-ORIG-GUID: XIigK0kAD_BjOhh4kATRTTRt_IoOe6yw
X-Authority-Analysis: v=2.4 cv=TId1jVla c=1 sm=1 tr=0 ts=69dba93b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=0Ni6rV8TAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=XPV0lA1ZplilG_7S9OAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MEv8DOuCJPEGjlO0Qob3:22
X-Proofpoint-GUID: XIigK0kAD_BjOhh4kATRTTRt_IoOe6yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120135
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmget: Use __func__ instead of hardcoded
 function
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

Ck9uIDA4LzA0LzI2IDM6MDQgcG0sIEN5cmlsIEhydWJpcyB3cm90ZToKPiBIaSEKPj4gRml4ZWQg
aW46Cj4+IC0gaHVnZXNobWdldDAyLmM6ODMKPj4gLSBodWdlc2htZ2V0MDMuYzo3Ngo+PiAtIGh1
Z2VzaG1nZXQwNS5jOjc1Cj4+Cj4+IENoYW5nZWQgZnJvbTogdHN0X2JyayhUQlJPSyB8IFRFUlJO
TywgInNobWdldCAjc2V0dXAiKTsKPj4gQ2hhbmdlZCB0bzogICB0c3RfYnJrKFRCUk9LIHwgVEVS
Uk5PLCAic2htZ2V0ICMlcyIsIF9fZnVuY19fKTsKPiBZb3Ugc2hvdWxkIHJlYWxseSB1c2UgU0FG
RV9TSE1HRVQoKSBpbiB0aGUgc2V0dXAoKSBpbiB0aGUgMDIgYW5kIDA1Cj4gdGVzdHMgaW5zdGVh
ZC4KPgo+PiBTaWduZWQtb2ZmLWJ5OiDigJxTYW1pciA8c2FtaXJAbGludXguaWJtLmNvbT4KPj4g
LS0tCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1n
ZXQwMi5jIHwgMiArLQo+PiAgIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWdl
dC9odWdlc2htZ2V0MDMuYyB8IDIgKy0KPj4gICB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxi
L2h1Z2VzaG1nZXQvaHVnZXNobWdldDA1LmMgfCAyICstCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAyLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAyLmMKPj4gaW5kZXgg
YmJkOTY4YzA2Li4wNjVhYTA1ZmMgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDIuYwo+PiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAyLmMKPj4gQEAgLTgwLDcgKzgw
LDcgQEAgdm9pZCBzZXR1cCh2b2lkKQo+PiAgIAlzaG1faWRfMSA9IHNobWdldChzaG1rZXksIHNo
bV9zaXplLAo+PiAgIAkJCSAgU0hNX0hVR0VUTEIgfCBJUENfQ1JFQVQgfCBJUENfRVhDTCB8IFNI
TV9SVyk7Cj4+ICAgCWlmIChzaG1faWRfMSA9PSAtMSkKPj4gLQkJdHN0X2JyayhUQlJPSyB8IFRF
UlJOTywgInNobWdldCAjc2V0dXAiKTsKPj4gKwkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNo
bWdldCAjJXMiLCBfX2Z1bmNfXyk7Cj4+ICAgfQo+PiAgIAo+PiAgIHZvaWQgY2xlYW51cCh2b2lk
KQo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0
L2h1Z2VzaG1nZXQwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0
L2h1Z2VzaG1nZXQwMy5jCj4+IGluZGV4IDYyNTc2MWY2ZS4uMWYwN2Q1ODVhIDEwMDY0NAo+PiAt
LS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAz
LmMKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2Vz
aG1nZXQwMy5jCj4+IEBAIC03Myw3ICs3Myw3IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4+
ICAgCQkJCSAgU0hNX0hVR0VUTEIgfCBJUENfQ1JFQVQgfCBJUENfRVhDTCB8IFNITV9SVyk7Cj4+
ICAgCX0KPj4gICAJaWYgKGVycm5vICE9IEVOT1NQQykKPj4gLQkJdHN0X2JyayhUQlJPSyB8IFRF
UlJOTywgInNobWdldCAjc2V0dXAiKTsKPj4gKwkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInNo
bWdldCAjJXMiLCBfX2Z1bmNfXyk7Cj4gQW5kIGhlcmUgeW91IHNob3VsZCBwcm9iYWJseSBqdXN0
IHByaW50IHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJzaG1nZXQoKSIpOwo+Cj4gVGhlcmUgaXMg
ZW5vdWdoIGluZm9ybWF0aW9uIHByaW50ZWQgYnkgdGhlIHRzdF9icmsoKSB0byBsb2NhdGUgdGhl
Cj4gZmFpbHVyZSwgbm8gbmVlZCB0byBhZGQgbW9yZS4KPgo+PiAgIAo+PiAgIHN0YXRpYyB2b2lk
IGNsZWFudXAodm9pZCkKPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0
bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0
bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDUuYwo+PiBpbmRleCAzMzYzMTk2MDMuLmEyYmI5MDIw
ZCAxMDA2NDQKPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0
L2h1Z2VzaG1nZXQwNS5jCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZXNobWdldC9odWdlc2htZ2V0MDUuYwo+PiBAQCAtNzIsNyArNzIsNyBAQCB2b2lkIHNldHVwKHZv
aWQpCj4+ICAgCXNobV9pZF8xID0gc2htZ2V0KHNobWtleSwgc2htX3NpemUsCj4+ICAgCQkJICBT
SE1fSFVHRVRMQiB8IFNITV9SVyB8IElQQ19DUkVBVCB8IElQQ19FWENMKTsKPj4gICAJaWYgKHNo
bV9pZF8xID09IC0xKQo+PiAtCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAic2htZ2V0ICNzZXR1
cCIpOwo+PiArCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAic2htZ2V0ICMlcyIsIF9fZnVuY19f
KTsKPj4gICAKPj4gICAJLyogZ2V0IHRoZSB1c2VyaWQgZm9yIGEgbm9uLXJvb3QgdXNlciAqLwo+
PiAgIAlsdHBfdWlkID0gZ2V0dXNlcmlkKGx0cF91c2VyKTsKPj4gLS0gCj4+IDIuNTIuMAo+Pgo+
Pgo+PiAtLSAKPj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCkhpIEN5cmlsLAoKCkkgaGF2ZSBpbmNvcnBvcmF0ZWQgdGhlIHJlcXVlc3RlZCBy
ZXZpZXcgY29tbWVudHMgYW5kIHN1Ym1pdHRlZCB0aGUgCnJldmlzZWQgdmVyc2lvbiAodjIpLiBU
aGFuayB5b3UgZm9yIHlvdXIgdmFsdWFibGUgZmVlZGJhY2suClBhdGNoIHYyOiAKaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwNDEyMTQxMDM5LjEwNzUwOTUtMS1zYW1pckBsaW51eC5p
Ym0uY29tL1QvI3UKCgpUaGFua3MsClNhbWlyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
