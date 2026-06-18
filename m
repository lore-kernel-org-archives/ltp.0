Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E75FCD98E4
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 03:26:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 335533E6BEF
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 05:26:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D02A3C5BAD
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 05:26:06 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6042C200336
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 05:26:06 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmiC9978544
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=caflGrmfqd7jqlAhs4z/HoxEyD3F
 jujwH59L7gD2nTA=; b=DSI+Mw7zoUC/GjfhyLEtHOGAtIhFatcm3k18GeD8ueW+
 BLNQcGP3nF3wn6yZxanQCzRS1y6J6YtP/8J181HQsDWnY0+f53SGERqgf8B+phOS
 Cj5TEod82aaJmrquONxiyoXkoDGiqxYhwyGez8x70tofUOBs3RobUp7JWnWk71kP
 qPf1dIrZYWXl2wjYOpxYeLKx7PBeQ5Kj81ZvW/D6w4tBBJrsU9UMW9LK9lEqwHDM
 FJjZ8ngtOHqNxLbHLCJhHEczVoq3/WHibptW7oQK+fm6t03ljZnCiF4yB/QkVa7G
 nyFbJJwkNLyCl0F3uQBnt/tgkR0TQKVuHszwecQGHQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx60eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I3Jg2O017751
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev1729puj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I3Q32V18481704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A1BA5805C
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0C9258051
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:02 +0000 (GMT)
Received: from [9.123.7.204] (unknown [9.123.7.204])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 03:26:02 +0000 (GMT)
Message-ID: <f3181c24-f3b8-4083-ac42-fb2da6cfa8a1@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:56:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
From: priyama2 <priyama2@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EFrQcun8U2-V2ASSVGyAG8lznBpLCx3Y
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a33654c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1t4K5szfbZNWS4p5R8cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAyNyBTYWx0ZWRfX6gPuwY8rkNdQ
 pYLDF/8Cr1vN04kb2s/JWg6XNxilu+AXEZh55WGhBxhQ2oG5nTkGB2USFQi0ypmCtn5XvZtpz1V
 uCJ7TydYhIcewqhCRbtCBKg1c0cAUGM=
X-Proofpoint-ORIG-GUID: EFrQcun8U2-V2ASSVGyAG8lznBpLCx3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAyNyBTYWx0ZWRfX1SdMS/SZYY1t
 wPWHn0n/eaXja3s6Lb+cx9Qw+zd4NQgoOEIw5qTiO+gW2PNKGaQE30yy9XCvVZ7AqAEOfyJlxdU
 /wfhVhf4Stib5FPdYmGQSkNQIVsVDIB/pQFlb1yphZGpHxQTEmfbE2f+OfYFZkGLTq3BXKGmTl9
 RyukbuT2IFIY8z+jLsEdeCsIGEcWinvjxoumqhxt7O9pOzH+HgdSgWzrd/l7y8ukdbK2u9Meosr
 pJYSCEsuLXfOUw+Pyebh1V4IQ3W31saR4VEYEt5hbhLxwoSTAMPis9WRajIgvyGvjWPPlLciW/m
 oSQwqAnDPGbeMGYP/FTg46n3Fd91v+hvfAfjaVAhA3IYO0Ud05iMrHhKIyFQpaCFRh4cJfhsSoT
 15TBvja1t/8UsNV068Y7muFyJuaWABNm3xBkbY0zuXt/pZc6pA+AanJkdv08+RiLUvKXMwgBuYj
 4gIb2pLQliq8Azr3Ljg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180027
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] RFC: Proposed cgroup v2 and openat2 test case contributions
 for LTP
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

SGkgYWxsLAoKRm9sbG93aW5nIHJlY2VudCBkaXNjdXNzaW9ucyBvbiB0aGUgbWFpbGluZyBsaXN0
IGFuZCBzdWdnZXN0aW9ucyB0byAKaW1wcm92ZSBjZ3JvdXAgY292ZXJhZ2UgaW4gTFRQLCBJIHJl
dmlld2VkIHRoZSBleGlzdGluZyB0ZXN0cyBhbmQga2VybmVsIApzZWxmdGVzdHMgYW5kIGNhbWUg
dXAgd2l0aCBhIHNldCBvZiBwb3RlbnRpYWwgdGVzdCBjYXNlcyB0aGF0IEkgYmVsaWV2ZSAKY291
bGQgc3RyZW5ndGhlbiBMVFAncyBjb3ZlcmFnZS4KCkJlZm9yZSBJIHN0YXJ0IGltcGxlbWVudGlu
ZyB0aGVtLCBJIHdvdWxkIGFwcHJlY2lhdGUgZmVlZGJhY2sgZnJvbSB0aGUgCmNvbW11bml0eSB0
byBhdm9pZCBkdXBsaWNhdGluZyBleGlzdGluZyB3b3JrIGFuZCB0byB1bmRlcnN0YW5kIHdoaWNo
IAphcmVhcyB3b3VsZCBiZSB0aGUgbW9zdCB2YWx1YWJsZSB0byBwcmlvcml0aXplLgoKCiAgICAg
IENhbmRpZGF0ZSB0ZXN0IGNhc2VzCgoKICAgICAgICBjZ3JvdXAgdjIKCiAgKgoKICAgIHxjZ3Jv
dXB2Ml9ub19pbnRlcm5hbF9wcm9jZXNzMDF8IOKAkyBWYWxpZGF0ZSBlbmZvcmNlbWVudCBvZiB0
aGUgIm5vCiAgICBpbnRlcm5hbCBwcm9jZXNzIiBydWxlLgoKICAqCgogICAgfGNncm91cHYyX2Nv
bnRyb2xsZXJfcHJvcGFnYXRpb24wMXwg4oCTIFZlcmlmeSBjb250cm9sbGVyIHByb3BhZ2F0aW9u
CiAgICBhY3Jvc3MgbmVzdGVkIGhpZXJhcmNoaWVzLgoKICAqCgogICAgfGNncm91cDJfbWVtX3Bz
aTAxfCDigJMgVmFsaWRhdGUgbWVtb3J5IFBTSSBhY2NvdW50aW5nIHdpdGhpbiBjZ3JvdXBzLgoK
ICAqCgogICAgfGNncm91cDJfY3B1X2J1cnN0MDF8IOKAkyBWZXJpZnkgQ1BVIGJ1cnN0IHF1b3Rh
IGJlaGF2aW91ci4KCiAgKgoKICAgIHxjZ3JvdXAyX2RlbGVnYXRpb24wMXwg4oCTIFRlc3QgZGVs
ZWdhdGlvbiBib3VuZGFyaWVzIGFuZCBwZXJtaXNzaW9uCiAgICBlbmZvcmNlbWVudC4KCiAgKgoK
ICAgIHxjZ3JvdXAyX2lvX2Nvc3QwMXwg4oCTIFZhbGlkYXRlIEkvTyBjb3N0IGNvbnRyb2xsZXIg
YWNjb3VudGluZy4KCgogICAgICAgIFBTSQoKICAqCgogICAgfHBzaV9tZW1vcnlfcHJlc3N1cmUw
MXwKCiAgKgoKICAgIHxwc2lfaW9fcHJlc3N1cmUwMXwKCiAgKgoKICAgIHxwc2lfY3B1X3ByZXNz
dXJlMDF8CgoKICAgICAgICBjcHVzZXQKCiAgKgoKICAgIHxjcHVzZXRfcGFydGl0aW9uX3Jvb3Qw
MXwKCiAgKgoKICAgIHxjcHVzZXRfcGFydGl0aW9uX2hvdHBsdWcwMXwKCgogICAgICAgIG9wZW5h
dDIKCiAgKgoKICAgIHxvcGVuYXQyX3N5bWxpbmswMXwg4oCTIFZhbGlkYXRlIHxSRVNPTFZFX05P
X1NZTUxJTktTfCBiZWhhdmlvdXIgYW5kCiAgICBleHBlY3RlZCB8RUxPT1B8IGhhbmRsaW5nLgoK
CiAgICAgIFBvdGVudGlhbCBlbmhhbmNlbWVudHMgdG8gZXhpc3RpbmcgY292ZXJhZ2UKCkkgYW0g
YWxzbyBjb25zaWRlcmluZyB0ZXN0cyB0aGF0IGNvbXBsZW1lbnQgZXhpc3RpbmcgZnVuY3Rpb25h
bGl0eSBieSAKZm9jdXNpbmcgb24gZWRnZSBjYXNlcyBhbmQgZXJyb3IgaGFuZGxpbmcsIHN1Y2gg
YXM6CgogICoKCiAgICBJbnZhbGlkIHxzdWJ0cmVlX2NvbnRyb2x8IHN0YXRlIHRyYW5zaXRpb25z
IGFuZCByb2xsYmFjayB2ZXJpZmljYXRpb24KCiAgKgoKICAgIFRocmVhZGVkIG1vZGUgdHJhbnNp
dGlvbiByYWNlcwoKICAqCgogICAgVGhyZWFkIG1pZ3JhdGlvbiBydWxlIGVuZm9yY2VtZW50Cgog
ICoKCiAgICBIaWVyYXJjaGljYWwgcmVzb3VyY2UgbGltaXQgdmFsaWRhdGlvbgoKICAqCgogICAg
SW52YWxpZCBoaWVyYXJjaHkgb3BlcmF0aW9ucyBhbmQgcGVybWlzc2lvbiBib3VuZGFyeSBjaGVj
a3MKCiAgKgoKICAgIE5VTUEgcG9saWN5IGFuZCBtaWdyYXRpb24gdmFsaWRhdGlvbgoKTXkgaW50
ZW50aW9uIGlzIHRvIGZvY3VzIG9uIGRldGVybWluaXN0aWMgZXJyb3IgcGF0aHMsIGNvcm5lciBj
YXNlcywgCmNvbmN1cnJlbmN5LCBhbmQgaW50ZWdyYXRpb24gc2NlbmFyaW9zIHRoYXQgbWF5IGNv
bXBsZW1lbnQgZXhpc3RpbmcgTFRQIAp0ZXN0cyBhbmQga2VybmVsIHNlbGZ0ZXN0cywgcmF0aGVy
IHRoYW4gZHVwbGljYXRpbmcgY3VycmVudCBjb3ZlcmFnZS4KCkNvdWxkIHRoZSBtYWludGFpbmVy
cyBhbmQgY29tbXVuaXR5IHBsZWFzZSBzaGFyZToKCiAxLgoKICAgIFdoaWNoIG9mIHRoZXNlIGlk
ZWFzIHdvdWxkIGJlIG1vc3QgdmFsdWFibGUgdG8gaW1wbGVtZW50IGZpcnN0PwoKIDIuCgogICAg
V2hldGhlciBhbnkgb2YgdGhlc2Ugb3ZlcmxhcCB3aXRoIG9uZ29pbmcgd29yayBvciBwbGFubmVk
IHBhdGNoZXM/CgogMy4KCiAgICBXaGV0aGVyIHRoZXJlIGFyZSBvdGhlciBhcmVhcyBpbiBjZ3Jv
dXAgdjIgb3IgcmVsYXRlZCBzdWJzeXN0ZW1zCiAgICB3aGVyZSBhZGRpdGlvbmFsIExUUCBjb3Zl
cmFnZSB3b3VsZCBiZSBtb3JlIGJlbmVmaWNpYWw/CgpJJ2QgYmUgaGFwcHkgdG8gcmVmaW5lIHRo
ZSBwcm9wb3NhbHMgYmFzZWQgb24gdGhlIGZlZWRiYWNrIGJlZm9yZSAKc3RhcnRpbmcgaW1wbGVt
ZW50YXRpb24uCgpUaGFua3MgaW4gYWR2YW5jZSBmb3IgeW91ciBndWlkYW5jZS4KCkJlc3QgcmVn
YXJkcywKUHJpeWFtYQoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
