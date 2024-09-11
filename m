Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2713EE4990
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 10:41:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F39263C1D3C
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 12:41:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 543CC3C1AE3
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 12:41:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=spoorthy@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1EA4B1010411
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 12:41:36 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B98pBh009441
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:to:from:subject:content-type
 :content-transfer-encoding; s=pp1; bh=1gNE1MxUUcDGb1HjO8KAQR8yFp
 quIHCzn9pHq72zOkA=; b=ZuSHBAGlNonAYcF4dk215M/CBorFdRWTGhsvacYHAa
 UfUwbjHbcQTwF/X/H3F+3kJapfWai7LLxzHpZwrk9tN7LpRehiFq84zeVB4lfDH3
 NgACttzyWW4GFJpM9xDGiEgl7028HC9HK9PTd87NYL3qWwhHfPynwByhoRXtuh87
 LtkhUb1JY6nsuAfDyCGRekTH4+NOsy8CYOVv8fNhg1xYuoYNJOyWWystg72OFM+s
 dPPxOvLICZh99OMozKv1fER9FBa2O41oDGMf0jaANJWpZ7VE7T1ujncRdted5nPE
 KZM2Y9YkB1PDcM3cserUrdIQsQ3jPMQBSRvYL0TeDpTw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebad2eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48BAPUuB032069
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmrrcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48BAfVKa10813770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A09F20043
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74F152004B
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:30 +0000 (GMT)
Received: from [9.200.59.47] (unknown [9.200.59.47])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 10:41:30 +0000 (GMT)
Message-ID: <3cfc8cf7-a7f4-4ccc-95d9-88bd358abd43@linux.ibm.com>
Date: Wed, 11 Sep 2024 16:11:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
From: spoorthy s <spoorthy@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pTEUQsBFZctchh611vF5QII8ekqAyPJv
X-Proofpoint-GUID: pTEUQsBFZctchh611vF5QII8ekqAyPJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110078
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs shm-perms
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

VGVzdCBEZXNjcmlwdGlvbjogVGVzdHMgdGhlIGJlaGF2aW9yIG9mIHNoYXJlZCBtZW1vcnkgd2hl
bgogwqBtdWx0aXBsZSB0aHJlYWRzIGF0dGFjaCB0byBhIHNlZ21lbnQgd2l0aCBkaWZmZXJlbnQg
cGVybWlzc2lvbnMuCgpBdCBvbmUgcG9pbnQsIHJlc2VydmF0aW9uIGFjY291bnRpbmcgb2YgZnJl
ZSBodWdlcGFnZXMgYmV0d2VlbiB0aGUgcGFyZW50CmFuZCBjaGlsZCBwcm9jZXNzZXMgbWF5IGJl
Y29tZSBpbmNvbnNpc3RlbnQgZHVyaW5nIG1lbW9yeSBvcGVyYXRpb25zLgpUaGUgcGFyZW50IGNy
ZWF0ZXMgNCBodWdlcGFnZXMgYW5kIGEgc2hhcmVkIG1lbW9yeSBzZWdtZW50CihzaXplIHNlZ21l
bnRfc2l6ZSwgcGVybWlzc2lvbiAwNjQwKSwgYXR0YWNoZXMgaXQsIGFuZCBpbml0aWFsaXplcwpm
b3VyIHBhcnRzIHdpdGggYSBwYXR0ZXJuICgweDU1KSwgdGhlbiBkZXRhY2hlcyBpdC4gQ2hpbGQg
cHJvY2Vzc2VzCmFyZSBjcmVhdGVkIGluIGEgbG9vcCwgZWFjaCByZWF0dGFjaGluZyB0aGUgc2Vn
bWVudCBpbiByZWFkLW9ubHkgbW9kZQp3aXRoIFNITV9SRE9OTFksIGRldGFjaGluZywgYW5kIGV4
aXRpbmcuIElmIGF0dGFjaC9kZXRhY2ggZmFpbHMgb3IKaWYgdGhlIHJlc2VydmF0aW9uIGFjY291
bnRpbmcgb2YgZnJlZSBodWdlcGFnZXMgZG9lc24ndCBtYXRjaApiZXR3ZWVuIHBhcmVudCBhbmQg
Y2hpbGQsIHRoZSB0ZXN0IGZhaWxzLiBJZiBhbGwgY2hpbGQgcHJvY2Vzc2VzIGV4aXQKc3VjY2Vz
c2Z1bGx5IGFuZCBhY2NvdW50aW5nIG1hdGNoZXMsIHRoZSB0ZXN0IHBhc3Nlcy4KClRlc3RlZCBh
bmQgdmVyaWZpZWQgdGhlIHN1Y2Nlc3Mgb2YgdGVzdCBjYXNlCgpTaWduZWQtb2ZmLWJ5OiBTcG9v
cnRoeSA8c3Bvb3J0aHlAbGludXguaWJtLmNvbT4KLS0tLS0tLQpDaGFuZ2VzIGluIHYyOgoxKU1h
a2UgY2hlY2sgZXJyb3JzIGFyZSB0YWtlbiBjYXJlCjIpc2VnbWVudF9zaXplIGlzIG5vdCBzdGF0
aWMKMylBZGRlZCBjaGVjayB0byBjb21wYXJlIHRoZSBmcmVlIGh1Z2VwYWdlIG1lbW9yeQotLS0t
LS0tCkNoYW5nZXMgaW4gdjM6CjEpUmVtb3ZlIHJlZHVuZGFudCB2YXJpYWJsZXMgYW5kIGNvbmRp
dGlvbmFsIGNoZWNrcwoyKUNvc21ldGljIGNoYW5nZXMgdG8gRGVzY3JpcHRpb24KLS0tLS0tLQog
wqBydW50ZXN0L2h1Z2V0bGLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwogwqB0ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0
aWdub3JlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCiDCoC4uLi9tZW0vaHVn
ZXRsYi9odWdlc2htYXQvaHVnZXNobWF0MDYuY8KgwqDCoMKgwqDCoCB8IDk3ICsrKysrKysrKysr
KysrKysrKysKIMKgMyBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCspCiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2ht
YXQwNi5jCgpkaWZmIC0tZ2l0IGEvcnVudGVzdC9odWdldGxiIGIvcnVudGVzdC9odWdldGxiCmlu
ZGV4IDI5OWMwN2FjOS4uMjQwNzAxYjJiIDEwMDY0NAotLS0gYS9ydW50ZXN0L2h1Z2V0bGIKKysr
IGIvcnVudGVzdC9odWdldGxiCkBAIC00NCw2ICs0NCw3IEBAIGh1Z2VzaG1hdDAyIGh1Z2VzaG1h
dDAyIC1pIDUKIMKgaHVnZXNobWF0MDMgaHVnZXNobWF0MDMgLWkgNQogwqBodWdlc2htYXQwNCBo
dWdlc2htYXQwNCAtaSA1CiDCoGh1Z2VzaG1hdDA1IGh1Z2VzaG1hdDA1IC1pIDUKK2h1Z2VzaG1h
dDA2IGh1Z2VzaG1hdDA2CgogwqBodWdlc2htY3RsMDEgaHVnZXNobWN0bDAxIC1pIDUKIMKgaHVn
ZXNobWN0bDAyIGh1Z2VzaG1jdGwwMiAtaSA1CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L21lbS8uZ2l0aWdub3JlIApiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUKaW5kZXgg
Yzk2ZmU4YmZjLi40YWQxZGMzMTMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5n
aXRpZ25vcmUKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQpAQCAtMzksNiAr
MzksNyBAQAogwqAvaHVnZXRsYi9odWdlc2htYXQvaHVnZXNobWF0MDMKIMKgL2h1Z2V0bGIvaHVn
ZXNobWF0L2h1Z2VzaG1hdDA0CiDCoC9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwNQorL2h1
Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA2CiDCoC9odWdldGxiL2h1Z2VzaG1jdGwvaHVnZXNo
bWN0bDAxCiDCoC9odWdldGxiL2h1Z2VzaG1jdGwvaHVnZXNobWN0bDAyCiDCoC9odWdldGxiL2h1
Z2VzaG1jdGwvaHVnZXNobWN0bDAzCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9o
dWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwNi5jIApiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1
Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA2LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMDAwLi5iY2IzMWIxZDQKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVs
L21lbS9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwNi5jCkBAIC0wLDAgKzEsOTcgQEAKKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisvKgorICogQ29weXJp
Z2h0IChDKSAyMDA1LTIwMDYsIElCTSBDb3Jwb3JhdGlvbi4KKyAqIEF1dGhvcjogRGF2aWQgR2li
c29uICYgQWRhbSBMaXRrZQorICovCisvKlwKKyAqIFtERVNDUklQVElPTl0KKyAqIFRlc3Qgc2hh
cmVkIG1lbW9yeSBiZWhhdmlvciB3aGVuIG11bHRpcGxlIHRocmVhZHMgYXJlIGF0dGFjaGVkCisg
KiB0byBhIHNlZ21lbnQgd2l0aCBkaWZmZXJlbnQgcGVybWlzc2lvbnMuwqAgQSBzZWdtZW50IGlz
IGNyZWF0ZWQKKyAqIGFuZCBjaGlsZHJlbiBhdHRhY2ggcmVhZC1vbmx5IHRvIGNoZWNrIHJlc2Vy
dmF0aW9uIGFjY291bnRpbmcuCisgKi8KKworI2luY2x1ZGUgImh1Z2V0bGIuaCIKKyNpbmNsdWRl
ICJ0c3Rfc2FmZV9zeXN2X2lwYy5oIgorCisjZGVmaW5lIFNFR01FTlRfS0VZICgweDgyYmExNWZm
KQorI2RlZmluZSBNTlRQT0lOVCAiaHVnZXRsYmZzLyIKKyNkZWZpbmUgSFBBR0VTX0lOX1NFR01F
TlQgNAorCitzdGF0aWMgaW50IGdsb2JhbF9zaG1pZCA9IC0xOworc3RhdGljIHZvaWQgKnNobWFk
ZHI7CitzdGF0aWMgbG9uZyBzZWdtZW50X3NpemUsIGhwYWdlX3NpemUsIHN0cmlkZTsKKworc3Rh
dGljIGludCBhdHRhY2hfc2VnbWVudChzaXplX3Qgc2Vnc2l6ZSwgaW50IHNobWZsYWdzLCBpbnQg
c2htcGVybXMpCit7CivCoMKgwqAgaW50IHNobWlkOworCivCoMKgwqAgc2htaWQgPSBTQUZFX1NI
TUdFVChTRUdNRU5UX0tFWSwgc2Vnc2l6ZSwgc2htZmxhZ3MpOworwqDCoMKgIHNobWFkZHIgPSBT
QUZFX1NITUFUKHNobWlkLCBzaG1hZGRyLCBzaG1wZXJtcyk7CivCoMKgwqAgZ2xvYmFsX3NobWlk
ID0gc2htaWQ7CivCoMKgwqAgcmV0dXJuIHNobWlkOworfQorCitzdGF0aWMgdm9pZCBzZXR1cCh2
b2lkKQoreworwqDCoMKgIGhwYWdlX3NpemUgPSB0c3RfZ2V0X2h1Z2VwYWdlX3NpemUoKTsKK8Kg
wqDCoCBzZWdtZW50X3NpemUgPSA0ICogaHBhZ2Vfc2l6ZTsKK8KgwqDCoCBzdHJpZGUgPSBocGFn
ZV9zaXplOworfQorCitzdGF0aWMgdm9pZCBjb21wYXJlX2ZyZWVfaHVnZXBhZ2VfbWVtb3J5KGxv
bmcgZnJlZV9lbmQsIGxvbmcgZnJlZV9zdGFydCkKK3sKK8KgwqDCoCBpZiAoZnJlZV9lbmQgIT0g
ZnJlZV9zdGFydCkKK8KgwqDCoCDCoMKgwqAgdHN0X3JlcyhURkFJTCwgIkZyZWUgaHVnZXBhZ2Vz
IGFmdGVyIGF0dGFjaGluZyBtdWx0aXBsZSB0aHJlYWRzIApkaWZmZXIgZnJvbSBpbml0aWFsIGFs
bG9jYXRpb24iKTsKK30KKworc3RhdGljIHZvaWQgcnVuX3Rlc3Qodm9pZCkKK3sKK8KgwqDCoCBj
aGFyICpwOworwqDCoMKgIGludCBpLCBpdGVyYXRpb25zOworwqDCoMKgIGxvbmcgdG90YWxfaHBh
Z2VzLCBmcmVlX3N0YXJ0LCBmcmVlX2VuZCwgdmFsOworCivCoMKgwqAgdG90YWxfaHBhZ2VzID0g
U0FGRV9SRUFEX01FTUlORk8oTUVNSU5GT19IUEFHRV9UT1RBTCk7CivCoMKgwqAgaXRlcmF0aW9u
cyA9ICh0b3RhbF9ocGFnZXMgKiBocGFnZV9zaXplKSAvIHNlZ21lbnRfc2l6ZSsxOworwqDCoMKg
IGF0dGFjaF9zZWdtZW50KHNlZ21lbnRfc2l6ZSwgSVBDX0NSRUFUIHwgU0hNX0hVR0VUTEIgfCAw
NjQwLCAwKTsKK8KgwqDCoCBwID0gKGNoYXIgKilzaG1hZGRyOworwqDCoMKgIGZvciAoaSA9IDA7
IGkgPCA0OyBpKyssIHAgKz0gc3RyaWRlKQorwqDCoMKgIMKgwqDCoCBtZW1zZXQocCwgMHg1NSwg
c3RyaWRlKTsKK8KgwqDCoCBmcmVlX3N0YXJ0ID0gU0FGRV9SRUFEX01FTUlORk8oTUVNSU5GT19I
UEFHRV9GUkVFKTsKK8KgwqDCoCBTQUZFX1NITURUKChjb25zdCB2b2lkICopc2htYWRkcik7CivC
oMKgwqAgZm9yIChpID0gMDsgaSA8IGl0ZXJhdGlvbnM7IGkrKykgeworwqDCoMKgIMKgwqDCoCBw
aWRfdCBwaWQ7CisKK8KgwqDCoCDCoMKgwqAgcGlkID0gU0FGRV9GT1JLKCk7CivCoMKgwqAgwqDC
oMKgIGlmICghcGlkKSB7CivCoMKgwqAgwqDCoMKgIMKgwqDCoCBhdHRhY2hfc2VnbWVudCgwLCAw
LCBTSE1fUkRPTkxZKTsKK8KgwqDCoCDCoMKgwqAgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBIUEFH
RVNfSU5fU0VHTUVOVDsgaSsrKQorwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIHZhbCA9ICoo
KGNoYXIgKilzaG1hZGRyICsgKGkgKiBocGFnZV9zaXplKSk7CivCoMKgwqAgwqDCoMKgIMKgwqDC
oCBTQUZFX1NITURUKCgoY29uc3Qgdm9pZCAqKXNobWFkZHIpKTsKK8KgwqDCoCDCoMKgwqAgwqDC
oMKgIGZyZWVfZW5kID0gU0FGRV9SRUFEX01FTUlORk8oTUVNSU5GT19IUEFHRV9GUkVFKTsKK8Kg
wqDCoCDCoMKgwqAgwqDCoMKgIGNvbXBhcmVfZnJlZV9odWdlcGFnZV9tZW1vcnkoZnJlZV9lbmQs
IGZyZWVfc3RhcnQpOworwqDCoMKgIMKgwqDCoCDCoMKgwqAgZXhpdChFWElUX1NVQ0NFU1MpOwor
wqDCoMKgIMKgwqDCoCB9CivCoMKgwqAgfQorwqDCoMKgIGZyZWVfZW5kID0gU0FGRV9SRUFEX01F
TUlORk8oTUVNSU5GT19IUEFHRV9GUkVFKTsKK8KgwqDCoCBjb21wYXJlX2ZyZWVfaHVnZXBhZ2Vf
bWVtb3J5KGZyZWVfZW5kLCBmcmVlX3N0YXJ0KTsKK8KgwqDCoCB0c3RfcmVhcF9jaGlsZHJlbigp
OworwqDCoMKgIHRzdF9yZXMoVFBBU1MsICJTdWNjZXNzZnVsbHkgdGVzdGVkIHNoYXJlZCBtZW1v
cnkgYmVoYXZpb3Igd2hlbiAKbXVsdGlwbGUgdGhyZWFkcyBhcmUgYXR0YWNoZWQiKTsKK30KKwor
c3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQoreworwqDCoMKgIGlmIChnbG9iYWxfc2htaWQgPj0g
MCkKK8KgwqDCoCDCoMKgwqAgU0FGRV9TSE1DVEwoZ2xvYmFsX3NobWlkLCBJUENfUk1JRCwgTlVM
TCk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKK8KgwqDCoCAubmVlZHNf
cm9vdCA9IDEsCivCoMKgwqAgLm1udHBvaW50ID0gTU5UUE9JTlQsCivCoMKgwqAgLm5lZWRzX2h1
Z2V0bGJmcyA9IDEsCivCoMKgwqAgLm5lZWRzX3RtcGRpciA9IDEsCivCoMKgwqAgLmZvcmtzX2No
aWxkID0gMSwKK8KgwqDCoCAuc2V0dXAgPSBzZXR1cCwKK8KgwqDCoCAuY2xlYW51cCA9IGNsZWFu
dXAsCivCoMKgwqAgLnRlc3RfYWxsID0gcnVuX3Rlc3QsCivCoMKgwqAgLmh1Z2VwYWdlcyA9IHsz
MiwgVFNUX05FRURTfSwKK307Ci0tIAoyLjQzLjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
