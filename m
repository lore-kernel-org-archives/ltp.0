Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6A6C4345F
	for <ltp@archiver.kernel.org>; Sun, 21 Apr 2024 10:24:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 335623CFA9A
	for <ltp@archiver.kernel.org>; Sun, 21 Apr 2024 12:24:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4F8E3C0F50
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 12:24:36 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=geetika@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF970600ECF
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 12:24:34 +0200 (CEST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43LAFFDH002700
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 10:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=CkAF9UAH+TYyPvQ512C9KvLQuTnIP3Xw9GCXBJkZzIE=;
 b=D8RNXASj9lGaq7S4pSQppHrKpGqVumhyeC8RLs6/RnXoo7YFZ1HQFjgy+sBNJEZZ3Ymq
 lqhRfLDBbo9ZyGgxDMfdPHlirwTmpK1eoay3juvIajGfgRw1igfliWGEi2g98ssSZXpj
 igeJpK4QbFctLoK7byoDtWehGmeq04DiemnXZdZvgWSRrftBzJ5awLur4WStyCk/AjOl
 +Ne0Ne4wTmy4ZFiLdspx5beWivMBdboUN64LRPKFtJ1wYfxuQYbwo0yYTey4eLakTxVP
 207tt9uNUgwo7tF+y/QapSNdeuo1lLz0BjCik30o0fBmT2CKNFziQerviVmUuokQidKe LA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xn0u880au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 10:24:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43L7QH2D028740
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 10:24:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr21gjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 21 Apr 2024 10:24:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43LAOPBU49218000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Apr 2024 10:24:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6AD920043;
 Sun, 21 Apr 2024 10:24:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A815820040;
 Sun, 21 Apr 2024 10:24:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.123.5])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 21 Apr 2024 10:24:24 +0000 (GMT)
From: Geetika <geetika@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 21 Apr 2024 15:54:20 +0530
Message-Id: <20240421102420.97060-1-geetika@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1DZN24_555JX8Yq0G7CzeUzIdARR7uuF
X-Proofpoint-ORIG-GUID: 1DZN24_555JX8Yq0G7CzeUzIdARR7uuF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404210066
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add hugeshmmisc01,
 migrated shm-getraw.c from libhugetlbfs
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhpcyB0ZXN0IGlzIG1pZ3JhdGVkIGZyb20gOgpodHRwczovL2dpdGh1Yi5jb20vbGliaHVnZXRs
YmZzL2xpYmh1Z2V0bGJmcy9ibG9iL21hc3Rlci90ZXN0cy9zaG0tZ2V0cmF3LmMKClRoZSB0ZXN0
IGNyZWF0ZXMgYSBzaGFyZWQgbWVtb3J5IHNlZ21lbnQsIHRoZW4gYXR0YWNoZXMgaXQgdG8gdGhl
IHByb2Nlc3PigJlzCmFkZHJlc3Mgc3BhY2UuIEl0IHdyaXRlcyBhIHN0cmluZyB0byB0aGUgc2hh
cmVkIG1lbW9yeSBmcm9tIHJhdyBkZXZpY2UgYW5kCmRldGFjaGVzIHRoZSBzaGFyZWQgbWVtb3J5
IHNlZ21lbnQgYW5kIGZpbmFsbHkgcmVtb3ZlcyBpdC4KVGhlIHB1cnBvc2Ugb2YgdGhpcyB0ZXN0
IGlzIHRvIGVuc3VyZSB0aGF0IHRoZSBzaGFyZWQgbWVtb3J5IHN1YnN5c3RlbSBpcwp3b3JraW5n
IGNvcnJlY3RseSB3aXRoIGh1Z2VwYWdlcy4gSXQgY2hlY2tzIHRoYXQgc2hhcmVkIG1lbW9yeSBz
ZWdtZW50cyBjYW4KYmUgY3JlYXRlZCwgYXR0YWNoZWQsIHdyaXR0ZW4gdG8sIHJlYWQgZnJvbSwg
ZGV0YWNoZWQsIGFuZCByZW1vdmVkIHdpdGhvdXQgZXJyb3JzLgoKU2lnbmVkLW9mZi1ieTogR2Vl
dGlrYSA8Z2VldGlrYUBsaW51eC5pYm0uY29tPgotLS0KIHJ1bnRlc3QvaHVnZXRsYiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArCiB0ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0
aWdub3JlICAgICAgICAgICAgICAgfCAgIDEgKwogLi4uL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdl
c2htbWlzYy9NYWtlZmlsZSAgIHwgICA5ICsrCiAuLi4vbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2Mv
aHVnZXNobW1pc2MwMS5jICAgfCAxMzQgKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5n
ZWQsIDE0NiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5l
bC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9NYWtlZmlsZQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1pc2MwMS5jCgpk
aWZmIC0tZ2l0IGEvcnVudGVzdC9odWdldGxiIGIvcnVudGVzdC9odWdldGxiCmluZGV4IDI5OWMw
N2FjOS4uZWExOGY2ZWY2IDEwMDY0NAotLS0gYS9ydW50ZXN0L2h1Z2V0bGIKKysrIGIvcnVudGVz
dC9odWdldGxiCkBAIC01NSwzICs1NSw1IEBAIGh1Z2VzaG1nZXQwMSBodWdlc2htZ2V0MDEgLWkg
MTAKIGh1Z2VzaG1nZXQwMiBodWdlc2htZ2V0MDIgLWkgMTAKIGh1Z2VzaG1nZXQwMyBodWdlc2ht
Z2V0MDMgLWkgMTAKIGh1Z2VzaG1nZXQwNSBodWdlc2htZ2V0MDUgLWkgMTAKKworaHVnZXNobW1p
c2MwMSBodWdlc2htbWlzYzAxCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0
aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQppbmRleCBjOTZmZThiZmMu
LjQ5MzY3OWFlNiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQor
KysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCkBAIC00Nyw2ICs0Nyw3IEBACiAv
aHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwMgogL2h1Z2V0bGIvaHVnZXNobWdldC9odWdl
c2htZ2V0MDMKIC9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDA1CisvaHVnZXRsYi9odWdl
c2htbWlzYy9odWdlc2htbWlzYzAxCiAva3NtL2tzbTAxCiAva3NtL2tzbTAyCiAva3NtL2tzbTAz
CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1taXNjL01h
a2VmaWxlIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9NYWtlZmls
ZQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAuLjg0NzE1YzdiNQotLS0gL2Rl
di9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvTWFr
ZWZpbGUKQEAgLTAsMCArMSw5IEBACisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyCisjIENvcHlyaWdodCAoQykgMjAwOSwgQ2lzY28gU3lzdGVtcyBJbmMuCisjIE5n
aWUgQ29vcGVyLCBKdWx5IDIwMDkKKwordG9wX3NyY2RpciAgICAgICAgICAgICAgPz0gLi4vLi4v
Li4vLi4vLi4KKworaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNhc2VzLm1r
CitpbmNsdWRlICQoYWJzX3NyY2RpcikvLi4vTWFrZWZpbGUuaW5jCitpbmNsdWRlICQodG9wX3Ny
Y2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFyZ2V0Lm1rCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1taXNjL2h1Z2VzaG1taXNjMDEuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1pc2MwMS5jCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uMTU4NjdmMjUxCi0tLSAvZGV2L251
bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9odWdlc2ht
bWlzYzAxLmMKQEAgLTAsMCArMSwxMzQgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBM
R1BMLTIuMS1vci1sYXRlcgorLyoKKyAqIENvcHlyaWdodCAoQykgMjAwNS0yMDA2IERhdmlkIEdp
YnNvbiAmIEFkYW0gTGl0a2UsIElCTSBDb3Jwb3JhdGlvbi4KKyAqLworCisvKlwKKyAqW0Rlc2Ny
aXBpdG9uXQorICoKKyAqIE9yaWdpbjogaHR0cHM6Ly9naXRodWIuY29tL2xpYmh1Z2V0bGJmcy9s
aWJodWdldGxiZnMvYmxvYi9tYXN0ZXIvdGVzdHMvc2htLWdldHJhdy5jCisgKgorICogVGhlIHRl
c3QgY3JlYXRlcyBhIHNoYXJlZCBtZW1vcnkgc2VnbWVudCwgdGhlbiBhdHRhY2hlcyBpdCB0byB0
aGUgcHJvY2Vzc+KAmXMgYWRkcmVzcyBzcGFjZS4KKyAqIEl0IHdyaXRlcyBhIHN0cmluZyB0byB0
aGUgc2hhcmVkIG1lbW9yeSBmcm9tIHJhdyBkZXZpY2UgYW5kIGRldGFjaGVzIHRoZSBzaGFyZWQg
bWVtb3J5CisgKiBzZWdtZW50IGFuZCBmaW5hbGx5IHJlbW92ZXMgaXQuCisgKiBUaGUgcHVycG9z
ZSBvZiB0aGlzIHRlc3QgaXMgdG8gZW5zdXJlIHRoYXQgdGhlIHNoYXJlZCBtZW1vcnkgc3Vic3lz
dGVtIGlzIHdvcmtpbmcgY29ycmVjdGx5CisgKiB3aXRoIGh1Z2VwYWdlcy4gSXQgY2hlY2tzIHRo
YXQgc2hhcmVkIG1lbW9yeSBzZWdtZW50cyBjYW4gYmUgY3JlYXRlZCwgYXR0YWNoZWQsIHdyaXR0
ZW4gdG8sCisgKiByZWFkIGZyb20sIGRldGFjaGVkLCBhbmQgcmVtb3ZlZCB3aXRob3V0IGVycm9y
cworICoKKyAqLworCisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxzdGRsaWIuaD4KKyNp
bmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxzeXMvbW1h
bi5oPgorI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8YXNzZXJ0Lmg+CisjaW5jbHVkZSA8
c3lzL3R5cGVzLmg+CisjaW5jbHVkZSA8c3lzL3NobS5oPgorI2luY2x1ZGUgPHN5cy90eXBlcy5o
PgorI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8
ZmNudGwuaD4KKworI2luY2x1ZGUgImh1Z2V0bGIuaCIKKyNpbmNsdWRlICJ0c3Rfc2FmZV9zeXN2
X2lwYy5oIgorCisjZGVmaW5lIE1OVFBPSU5UICJodWdldGxiZnMvIgorI2RlZmluZSBTQUZFX0ZS
RUUocCkgeyBpZiAocCkgeyBmcmVlKHApOyAocCkgPSBOVUxMOyB9IH0KKyNkZWZpbmUgTlJfSFVH
RVBBR0VTIDIKKworc3RhdGljIGludCBzaG1pZCA9IC0xOworc3RhdGljIHNpemVfdCBzaXplOwor
c3RhdGljIHNpemVfdCBpOworc3RhdGljIHNpemVfdCByZXQ7CisKK3N0YXRpYyB2b2xhdGlsZSBj
aGFyICpzaG1hZGRyOworc3RhdGljIGNoYXIgKmJ1ZmZlcjsKK3N0YXRpYyBpbnQgcmF3X2ZkOwor
c3RhdGljIGxvbmcgaHBhZ2Vfc2l6ZTsKK3N0YXRpYyBpbnQgZmQ7CisKK3N0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpCit7CisJaHBhZ2Vfc2l6ZSA9IHRzdF9nZXRfaHVnZXBhZ2Vfc2l6ZSgpOworCWZk
ID0gdHN0X2NyZWF0X3VubGlua2VkKE1OVFBPSU5ULCAwKTsKK30KKworc3RhdGljIHZvaWQgY2xl
YW51cCh2b2lkKQoreworCWlmIChzaG1pZCA+PSAwKQorCQlTQUZFX1NITUNUTChzaG1pZCwgSVBD
X1JNSUQsIE5VTEwpOworCWlmIChmZCA+IDApCisJCVNBRkVfQ0xPU0UoZmQpOworfQorCitzdGF0
aWMgdm9pZCBjaGVja19odWdldGxiX3NobV9ncm91cCh2b2lkKQoreworCWNoYXIgZ2lkX2J1ZmZl
cls2NF0gPSB7MH07CisJZ2lkX3QgaHVnZXRsYl9zaG1fZ3JvdXA7CisJZ2lkX3QgZ2lkID0gZ2V0
Z2lkKCk7CisJdWlkX3QgdWlkID0gZ2V0dWlkKCk7CisKKwkvKiByb290IGlzIGFuIGV4Y2VwdGlv
biAqLworCWlmICh1aWQgPT0gMCkKKwkJcmV0dXJuOworCisJZmQgPSBTQUZFX09QRU4oIi9wcm9j
L3N5cy92bS9odWdldGxiX3NobV9ncm91cCIsIE9fUkRPTkxZKTsKKwlyZXQgPSBTQUZFX1JFQUQo
MCwgZmQsICZnaWRfYnVmZmVyLCBzaXplb2YoZ2lkX2J1ZmZlcikpOworCWh1Z2V0bGJfc2htX2dy
b3VwID0gYXRvaShnaWRfYnVmZmVyKTsKKwlTQUZFX0NMT1NFKGZkKTsKKwlpZiAoaHVnZXRsYl9z
aG1fZ3JvdXAgIT0gZ2lkKQorCQl0c3RfYnJrKFRDT05GLCAiRG8gbm90IGhhdmUgcGVybWlzc2lv
biB0byB1c2UgU0hNX0hVR0VUTEIiKTsKK30KKworc3RhdGljIHZvaWQgcnVuX3Rlc3Qodm9pZCkK
K3sKKwljaGVja19odWdldGxiX3NobV9ncm91cCgpOworCWJ1ZmZlciA9IFNBRkVfTUFMTE9DKGhw
YWdlX3NpemUqc2l6ZW9mKGNoYXIpKTsKKwlyYXdfZmQgPSBTQUZFX09QRU4oIi9kZXYvZnVsbCIs
IE9fUkRPTkxZKTsKKwlzaXplID0gaHBhZ2Vfc2l6ZSAqIE5SX0hVR0VQQUdFUzsKKwl0c3RfcmVz
KFRJTkZPLCAiUmVxdWVzdGluZyAlenUgYnl0ZXNcbiIsIHNpemUpOworCisJc2htaWQgPSBzaG1n
ZXQoMiwgc2l6ZSwgU0hNX0hVR0VUTEJ8SVBDX0NSRUFUfFNITV9SfFNITV9XKTsKKwlpZiAoc2ht
aWQgPCAwKSB7CisJCXRzdF9yZXMoVEZBSUwgfCBURVJSTk8sICJzaG1nZXQoKSBmYWlsZWQgd2l0
aCBlcnJvciAiKTsKKwkJZ290byB3aW5kdXA7CisJfSBlbHNlCisJCXRzdF9yZXMoVElORk8sICJz
aG1pZDogMHgleFxuIiwgc2htaWQpOworCisJc2htYWRkciA9IHNobWF0KHNobWlkLCAwLCBTSE1f
Uk5EKTsKKwlpZiAoc2htYWRkciA9PSBNQVBfRkFJTEVEKSB7CisJCXRzdF9yZXMoVEZBSUwgfCBU
RVJSTk8sICJzaG1hdCgpIGZhaWxlZCB3aXRoIGVycm9yICIpOworCQlnb3RvIHdpbmR1cDsKKwl9
IGVsc2UKKwkJdHN0X3JlcyhUSU5GTywgInNobWFkZHI6ICVwXG4iLCBzaG1hZGRyKTsKKworCS8q
IFJlYWQgYSBwYWdlIGZyb20gZGV2aWNlIGFuZCB3cml0ZSB0byBzaG0gc2VnbWVudCAqLworCWZv
ciAoaSA9IDA7IGkgPCBzaXplOyBpICs9IGhwYWdlX3NpemUpIHsKKwkJaWYgKCFyZWFkKHJhd19m
ZCwgYnVmZmVyLCBocGFnZV9zaXplKSkgeworCQkJdHN0X3JlcyhURkFJTCB8IFRFUlJOTywgIkNh
bid0IHJlYWQgZnJvbSByYXcgZGV2aWNlISIpOworCQkJZ290byB3aW5kdXA7CisJCX0KKwkJbWVt
Y3B5KChjaGFyICopKHNobWFkZHIgKyBpKSwgYnVmZmVyLCBocGFnZV9zaXplKTsKKwl9CisKKwlp
ZiAoc2htZHQoKGNvbnN0IHZvaWQgKilzaG1hZGRyKSAhPSAwKSB7CisJCXRzdF9yZXMoVEZBSUwg
fCBURVJSTk8sICJzaG1kdCgpIGZhaWxlZCIpOworCQlnb3RvIHdpbmR1cDsKKwl9CisKKwl0c3Rf
cmVzKFRQQVNTLCAiVGVzdCBQYXNzZWQhIik7Cit3aW5kdXA6CisJU0FGRV9GUkVFKGJ1ZmZlcik7
Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwkubmVlZHNfcm9vdCA9IDEs
CisJLm1udHBvaW50ID0gTU5UUE9JTlQsCisJLm5lZWRzX2h1Z2V0bGJmcyA9IDEsCisJLnNldHVw
ID0gc2V0dXAsCisJLmNsZWFudXAgPSBjbGVhbnVwLAorCS50ZXN0X2FsbCA9IHJ1bl90ZXN0LAor
CS5odWdlcGFnZXMgPSB7MiwgVFNUX05FRURTfSwKK307Ci0tIAoyLjM5LjMgKEFwcGxlIEdpdC0x
NDYpCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
