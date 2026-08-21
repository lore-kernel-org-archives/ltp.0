Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF71C5DF7D
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 18:50:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642213D0EEC
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 20:50:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BB703C55FC
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 20:50:12 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7783D1A000BC
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 20:50:10 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LIW4cC2365055
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 18:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SnhD8E
 yjd59Zu6yMwptyo1eU2hR05bGJWOaQf/2/PlI=; b=VQsfAGlDbCqvM07YoNBr8X
 x0r7NFN6dbvHQXo3aeyWRQDqz3Hn+537lWhqGlXDN9fyEzoKdUZPA9M8c7/p4GXF
 nQRl6MdTuaLPUUbZLbc996F/aA2GtuIPRemMXs2c692IUUl5HAboZGr5O6WB4dfl
 lDdG5ReHMWxhLaguhkL9vfoQfpqlDGYDG/fkess/UXw2ccXhtpGhlVELHCZOU6Hm
 fWH8tNdwBpRxGpiv2x4GyDEnJPrNuPvleuYQdj410bLBHJ1P9UWuD2J4ZXEfu8h8
 6cFHx6EsOl+mdFw9eG2IMJRJCKh+7RZ4U/BEiaRc9GNCTg79XAZCHa/o21fe6X1Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ujxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 18:50:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LIfT4h004388;
 Fri, 21 Aug 2026 18:50:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekpb2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 18:50:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67LIo6AD5833332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Aug 2026 18:50:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C77E58052;
 Fri, 21 Aug 2026 18:50:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5028C58056;
 Fri, 21 Aug 2026 18:50:05 +0000 (GMT)
Received: from [9.43.42.13] (unknown [9.43.42.13])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Aug 2026 18:50:04 +0000 (GMT)
Message-ID: <88d2ad6c-6c85-4535-8f38-8599217fa42c@linux.ibm.com>
Date: Sat, 22 Aug 2026 00:20:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxtestproject.agent@gmail.com
References: <20260820125552.47435-1-samir@linux.ibm.com>
 <20260820184002.4137-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20260820184002.4137-1-linuxtestproject.agent@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a889de0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=78ECQTVGfME8GtVG01MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jXUJpa-GjGY09Xg7QKQXtatg5vSGRK7r
X-Proofpoint-GUID: zOO9rrDcUNy55qnoLYzTKzyKvFK8QzND
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0NyBTYWx0ZWRfXwWjaA/xEfYfc
 eHdk1dWrhOutMJP8LaeuTHM3VJV6Q1urCnSeziLjfwC4QAjRtupxDZlZbS3MHcfaPpebAAgIpIJ
 QfATUQtcqQwXALlacruVK8R5TpUmWec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0NyBTYWx0ZWRfXxWmYv6Y80qn5
 jpW7Gyknf9xSP07iEdTH4AxeI7CxDf4MJg+WvGB1LsKiYPMlhy5FoUcT0ZgYU9tDvSRxuVBegSK
 CTkR9y/3xyNe4c8TVivguz3t+rVqZ5u0DJc8mpmE0TOt15Jdfdh68tU43n47DFg9pdsZJMtJs8d
 GxGOiZ14Fzz6NtCWGYAn5RJOTj/W/JoGWjTNy228lez8JHV8GGLj4Unz0CejUZsILK6Hk7TQc3a
 Qygzan2e280RTnotWeGlbByZHyusAhZQhAc5kGmC80a+7EFlJWh0VbxH1fklK1IG6OzZB2Vri8t
 PI0UNuljm6txEei347n7MNpdzD/PMfX/kV8pWUks4YpOIWsSweXcrPT/UONeALdfIml2hQ4ANnN
 P0Pa1lAQF/E6hVoET0UL/3suXR5FldmVza/8WOf/wla00Y2K0ACbiTgL6K0sDeKexJPV5d+pIIc
 eaX/MYUeg0DUKtgkTWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210147
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugeshmat: Add hugeshmat06 migrated from
 libhugetlbfs shm-perms
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

Ck9uIDIxLzA4LzI2IDEyOjEwIGFtLCBsaW51eHRlc3Rwcm9qZWN0LmFnZW50QGdtYWlsLmNvbSB3
cm90ZToKPiBIaSBTYW1pciwKPgo+IE9uIEF1ZyAyMCwgMjAyNiwgU2FtaXIgTXVsYW5pIHdyb3Rl
Ogo+PiBodWdldGxiL2h1Z2VzaG1hdDogQWRkIGh1Z2VzaG1hdDA2IG1pZ3JhdGVkIGZyb20gbGli
aHVnZXRsYmZzIHNobS1wZXJtcwo+PiAjZGVmaW5lIEhQQUdFU19JTl9TRUcJNAo+PiAjZGVmaW5l
IE1BWF9DSElMRFJFTgkxMjgKPj4KPj4gCWl0ZXJhdGlvbnMgPSBNSU4oKGxvbmcpdHN0X2h1Z2Vw
YWdlcywgKGxvbmcpTUFYX0NISUxEUkVOKTsKPiBDb3VsZCB0aGUgaXRlcmF0aW9uIGNvdW50IHJl
dGFpbiB0aGUgb3JpZ2luYWwgdGVzdCdzIGV4aGF1c3Rpb24gZ3VhcmFudGVlPwo+IEVhY2ggbGVh
a2VkIGF0dGFjaCByZXNlcnZlcyBIUEFHRVNfSU5fU0VHIHBhZ2VzLCBzbyBhIHBvb2wgY29udGFp
bmluZyBOCj4gaHVnZXBhZ2VzIHJlcXVpcmVzIG1vcmUgdGhhbiBOIC8gSFBBR0VTX0lOX1NFRyBh
dHRhY2hlcyB0byBleHBvc2UgdGhlIGxlYWsuCj4gVGhlIG9yaWdpbmFsIHRlc3QgY2FsY3VsYXRl
ZCB0aGF0IHZhbHVlIHBsdXMgb25lLgo+Cj4gV2l0aCB0aGlzIGNhcCwgb25lIGV4ZWN1dGlvbiBj
YW4gcGFzcyB3aXRob3V0IGRldGVjdGluZyB0aGUgYnVnIHdoZW4gdGhlIHBvb2wKPiBjb250YWlu
cyA1MTIgb3IgbW9yZSBodWdlcGFnZXMuIEV2ZW4gdGhlICItaSA1IiBydW50ZXN0IGVudHJ5IGlz
IGluc3VmZmljaWVudAo+IGF0IDI1NjAgb3IgbW9yZS4gQ291bGQgdGhlIGNvdW50IGluc3RlYWQg
YmUgZGVyaXZlZCBmcm9tIHRoZSBwb29sIGFuZCBzZWdtZW50Cj4gc2l6ZXMsIGluY2x1ZGluZyB0
aGUgZmluYWwgYXR0YWNoIHRoYXQgZXhjZWVkcyB0aGUgcG9vbD8KRml4ZWQuIFJlcGxhY2VkIE1J
Tih0c3RfaHVnZXBhZ2VzLCBNQVhfQ0hJTERSRU4pIHdpdGggdHN0X2h1Z2VwYWdlcyAvIApIUEFH
RVNfSU5fU0VHICsgMSBhbmQgcmVtb3ZlZCBNQVhfQ0hJTERSRU4uIE5vdyB0aGUgY291bnQgaXMg
ZGVyaXZlZCAKZnJvbSB0aGUgcG9vbCBzaXplIGFuZCBzZWdtZW50IHNpemUsIGFuZCBpbmNsdWRl
cyB0aGUgZmluYWwgYXR0YWNoIHRoYXQgCm11c3QgZmFpbCBvbiBhIGJ1Z2d5IGtlcm5lbC4KPgo+
PiAJCQlpZiAoc2htYWRkciA9PSAodm9pZCAqKS0xKSB7Cj4+IAkJCQl0c3RfcmVzKFRGQUlMIHwg
VEVSUk5PLAo+PiAJCQkJCSJDaGlsZCAlZDogc2htYXQoKSBmYWlsZWQsIGh1Z2VwYWdlIHJlc2Vy
dmF0aW9uIHBvb2wgbWF5IGJlIGV4aGF1c3RlZCIsCj4+IAkJCQkJZ2V0cGlkKCkpOwo+PiAJCQkJ
ZXhpdChFWElUX0ZBSUxVUkUpOwo+PiAJCQl9Cj4gQ291bGQgdGhlIGNoaWxkIGV4aXQgc3VjY2Vz
c2Z1bGx5IGFmdGVyIHJlcG9ydGluZyBURkFJTD8KPiB0c3RfcmVhcF9jaGlsZHJlbigpIGNvbnZl
cnRzIHRoaXMgbm9uemVybyBzdGF0dXMgaW50byBhbiBhZGRpdGlvbmFsIFRCUk9LCj4gKCJJbnZh
bGlkIGNoaWxkIGV4aXQgdmFsdWUiKSBhbmQgYWJvcnRzIHRoZSBwYXJlbnQuIExUUCBhbHJlYWR5
IHByb3BhZ2F0ZXMgdGhlCj4gY2hpbGQncyB0c3RfcmVzKCkgcmVzdWx0LCBzbyB0aGUgcmVncmVz
c2lvbiBzaG91bGQgcmVtYWluIGEgVEZBSUwgcmF0aGVyIHRoYW4KPiBhbHNvIGJlY29taW5nIGEg
YnJva2VuLXRlc3QgcmVzdWx0LgpGaXhlZC4gQ2hhbmdlZCBib3RoIGV4aXQoRVhJVF9GQUlMVVJF
KSB0byBleGl0KEVYSVRfU1VDQ0VTUykg4oCUIG9uY2UgaW4gCnRoZSBzaG1hdCgpIGZhaWx1cmUg
cGF0aCBhbmQgb25jZSBpbiB0aGUgcGF0dGVybi1taXNtYXRjaCBwYXRoLiBBbHNvIAp1cGRhdGVk
IHRoZSBjb21tZW50IGFib3ZlIHRzdF9yZWFwX2NoaWxkcmVuKCkgd2hpY2ggd2FzIGluY29ycmVj
dGx5IApkZXNjcmliaW5nIHRoZSBiZWhhdmlvci4KPj4gc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0
ZXN0ID0gewo+PiAJLm5lZWRzX3Jvb3QJID0gMSwKPiBUaGlzIGlzIGRlc2NyaWJlZCBhcyBhIHJl
Z3Jlc3Npb24gdGVzdCwgYnV0IHRoZSB0ZXN0IGhhcyBubyAudGFncyBlbnRyeS4KPiBDb3VsZCB0
aGUgY29ycmVzcG9uZGluZyBsaW51eC1naXQgcmVncmVzc2lvbiBmaXggdGFnIGJlIGFkZGVkPwpG
aXhlZC4gVGhlIHJlZ3Jlc3Npb24gd2FzIGZpeGVkIGJ5IHVwc3RyZWFtIGNvbW1pdCBmODNhMjc1
ZGJjNWMgKCJtbTogCmFjY291bnQgZm9yIE1BUF9TSEFSRUQgbWFwcGluZ3MgdXNpbmcgVk1fTUFZ
U0hBUkUgYW5kIG5vdCBWTV9TSEFSRUQgaW4gCmh1Z2V0bGJmcyIgYnkgTWVsIEdvcm1hbikuIEFk
ZGVkIHRoZSAudGFncyBlbnRyeSB3aXRoIHRoZSAxMi1jaGFyYWN0ZXIgCmhhc2gsIGNvbnNpc3Rl
bnQgd2l0aCB0aGUgb3RoZXIgdGVzdHMgaW4gdGhlIHNhbWUgZGlyZWN0b3J5Lgo+PiArL2h1Z2V0
bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA2Cj4gQ291bGQgdGhpcyBiaW5hcnkgaW5zdGVhZCBiZSBp
Z25vcmVkIGJ5Cj4gdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htYXQvLmdpdGln
bm9yZSBhcyAvaHVnZXNobWF0MDY/IE5ldyB0ZXN0Cj4gYmluYXJpZXMgc2hvdWxkIHVzZSBhIGxl
YWYtZGlyZWN0b3J5IC5naXRpZ25vcmUgcmF0aGVyIHRoYW4gdGhlIHNoYXJlZAo+IHRlc3RjYXNl
cy9rZXJuZWwvbWVtLy5naXRpZ25vcmUuClRoaXMgY2hhbmdlIGlzIG5vdCByZXF1aXJlZC4KPj4g
LypcCj4+ICAgKiBUZXN0cyBzaGFyZWQgbWVtb3J5IGJlaGF2aW9yIHdoZW4gbXVsdGlwbGUgcHJv
Y2Vzc2VzIGF0dGFjaCB0byBhCj4+ICAgKiBodWdlcGFnZS1iYWNrZWQgc2VnbWVudCB3aXRoIGRp
ZmZlcmVudCBwZXJtaXNzaW9ucy4KPiBDb3VsZCB0aGUgZXhwb3J0ZWQgZGVzY3JpcHRpb24gZXhw
bGFpbiB3aHkgcm9vdCBpcyByZXF1aXJlZD8gVGhlIHRlc3Qgc2V0cwo+IC5uZWVkc19yb290IGJl
Y2F1c2UgdGhlIGZyYW1ld29yayBhZGp1c3RzIHRoZSBodWdlcGFnZSBwb29sIGFuZCBtb3VudHMK
PiBodWdldGxiZnMuCj4KPj4gICAqIHBvb2wuICBUaGlzIGlzIGRldGVjdGVkIGJ5IHVzaW5nIHJh
dyBzaG1hdCgpIGluIGVhY2ggY2hpbGQgc28gdGhhdCBhCj4gQ291bGQgc2htYXQoKSB1c2UgdGhl
ICI6bWFucGFnZTpgc2htYXQoMilgIiByb2xlIGhlcmU/IFN5c2NhbGxzIGluIGV4cG9ydGVkCj4g
dGVzdCBkZXNjcmlwdGlvbnMgc2hvdWxkIHVzZSB0aGVpciBtYW4tcGFnZSByb2xlLgpGaXhlZCBi
b3RoLiBBZGRlZCBhIHNlbnRlbmNlIGluIHRoZSBleHBvcnRlZCBkZXNjcmlwdGlvbiBleHBsYWlu
aW5nIHRoYXQgCnJvb3QgaXMgcmVxdWlyZWQgYmVjYXVzZSB0aGUgTFRQIGZyYW1ld29yayBhZGp1
c3RzIHRoZSBodWdlcGFnZSBwb29sIGFuZCAKbW91bnRzIGh1Z2V0bGJmcy4gQWxzbyBjaGFuZ2Vk
IHNobWF0KCkgdG8gOm1hbnBhZ2U6YHNobWF0KDIpYCBpbiB0aGUgCnNhbWUgYmxvY2suCj4gVmVy
ZGljdCAtIE5lZWRzIHJldmlzaW9uCj4KPiAtLS0KPiBOb3RlOgo+Cj4gVGhlIGFnZW50IGNhbiBz
b21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCj4gZmlu
ZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBs
ZWFzZQo+IGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgo+Cj4g
UmVnYXJkcywKPiBMVFAgQUkgUmV2aWV3ZXIKClJlZ2FyZHMsCgpTYW1pcgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
