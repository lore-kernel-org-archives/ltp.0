Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6B6C47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 05:34:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 366FA3CE616
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 06:34:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE30F3C801F
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:34:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23538256FC0
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:34:37 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42M5DBwC017079; Fri, 22 Mar 2024 05:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=2dQfb/TA02wZYESMRlyCH4tLsyQEnhtnV+zOr3MS/wc=;
 b=ftoTmiD1xSf6hG9WZjLnunXXTNa678AkS/jkyJ+aWwX7RyFBza/yA0c3sLxOMiE66+Mb
 STtyOn5+xvHkF/4oPOPL6YO4C1MGm4dxGK8BtgfyGPRVtlfI2CXvGCdEeo4Y8l1mp0wH
 nNeTMR4GfrrdCJLkNChqyssLgAnhDSnyhK5G1bEkdEYgNICpXoZ9lOrpQr9d3Y27WLQ8
 AX66VEMsVXdT1IyMH7jrdUl2OdGAIbI2TUQUx+UHTdYTB6MR5mHoB6yT+DTrqhMRAqLx
 r2P3lLq3Cy2YRCbiP437h8amKSsX1YJCt7gAjZsVAr6IpO/ALNKGmI4qNbqhqjBMIjTc iw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x13msg18f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 05:34:36 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42M5YFc1032540; Fri, 22 Mar 2024 05:34:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x16hr4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Mar 2024 05:34:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42M5YUYe47120874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2024 05:34:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73DB32014A;
 Fri, 22 Mar 2024 05:09:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5440920147;
 Fri, 22 Mar 2024 05:09:27 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com.com (unknown
 [9.43.69.223]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 Mar 2024 05:09:27 +0000 (GMT)
From: Shirisha G <shirisha@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 22 Mar 2024 10:38:59 +0530
Message-Id: <20240322050859.631139-1-shirisha@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xSFiskQV4i5lffuo29a6rosVCgW2Vc3F
X-Proofpoint-ORIG-GUID: xSFiskQV4i5lffuo29a6rosVCgW2Vc3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_01,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220037
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Migrating the libhugetlbfs/testcases/truncate.c
 test
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
Cc: Shirisha G <shirisha@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGVzdCBEZXNjcmlwdGlvbjogVGVzdCBpcyB1c2VkIHRvIHZlcmlmeSB0aGUgY29ycmVjdCBmdW5j
dGlvbmFsaXR5CmFuZCBjb21wYXRpYmlsaXR5IG9mIHRoZSBsaWJyYXJ5IHdpdGggdGhlICJ0cnVu
Y2F0ZSIgc3lzdGVtCmNhbGwgd2hlbiBvcGVyYXRpbmcgb24gZmlsZXMgcmVzaWRpbmcgaW4gYSBt
b3VudGVkCmh1Z2UgcGFnZSBmaWxlc3lzdGVtLgoKU2lnbmVkLW9mZi1ieTogU2hpcmlzaGEgRyA8
c2hpcmlzaGFAbGludXguaWJtLmNvbT4KLS0tCnY0OgogLS1BZGRyZXNzZWQgdGhlIGJlbG93IHJl
cXVlc3RlZCBjaGFuZ2VzCiAgMS4gQWRkZWQgU0FGRV9GVFJVTkNBVEUoKQogIDIuIEZpeGVkIHJ1
biB0ZXN0IG1vcmUgdGltZXMgKC1pTikKICAzLiBGaXhlZCB3YXJuaW5nOiB1bnVzZWQgcGFyYW1l
dGVyIOKAmHNpZ251beKAmSBbLVd1bnVzZWQtcGFyYW1ldGVyXQogIDQuIEFkZGVkIGJsYW5rIGxp
bmVzIHdoZXJldmVyIG5lZWRlZCB3aGljaCBoZWxwcyB0aGUgcmVhZGFiaWxpdHkKICA1LiBSYW4g
bWFrZSBjaGVjayBhbmQgZml4ZWQgdGhlIGlzc3VlcwotLS0KdjM6CiAtQWRkcmVzc2VkIHRoZSBi
ZWxvdyByZXF1ZXN0ZWQgY2hhbmdlcyAKICAxLiBSZW1vdmVkIFJBTkRPTV9DT05TVEFOVAogIDIu
IE1hZGUgaHBhZ2Vfc2l6ZSBhbmQgZmQgdG8gc3RhdGljCiAgMy4gVXNlZCBhIHZvbGF0aWxlIHZh
cmlhYmxlIGFzIGEgZmxhZwogICAgIHRvIHBhc3MgdGVzdCBpbiB0aGUgcnVuX3Rlc3QoKQogIDQu
IFJlbW92ZWQgdGhlIGZhaWx1cmUgY29uZGl0aW9uIGZvciBTQUZFX01NQVAoKQogIDUuIEhhdmUg
c2V0dXAgdGhlIGhhbmRsZXIgaW4gdGhlIHNldHVwKCkKICA2LiBBZGRlZCBTQUZFX01VTk1BUCgp
CiAgNy4gUmFuIG1ha2UgY2hlY2sgYW5kIGZpeGVkIGFsbCBpc3N1ZXMKLS0tCnYyOgogLUNvcnJl
Y3RlZCB0eXBvCi0tLQogcnVudGVzdC9odWdldGxiICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDEgKwogdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZSAgICAgICAgICAgICAg
IHwgIDEgKwogLi4uL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMzLmMgIHwg
ODcgKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDMzLmMKCmRpZmYgLS1naXQgYS9ydW50ZXN0L2h1Z2V0bGIgYi9ydW50ZXN0L2h1
Z2V0bGIKaW5kZXggMjk5YzA3YWM5Li4xMzAwZTgwZmIgMTAwNjQ0Ci0tLSBhL3J1bnRlc3QvaHVn
ZXRsYgorKysgYi9ydW50ZXN0L2h1Z2V0bGIKQEAgLTM1LDYgKzM1LDcgQEAgaHVnZW1tYXAyOSBo
dWdlbW1hcDI5CiBodWdlbW1hcDMwIGh1Z2VtbWFwMzAKIGh1Z2VtbWFwMzEgaHVnZW1tYXAzMQog
aHVnZW1tYXAzMiBodWdlbW1hcDMyCitodWdlbW1hcDMzIGh1Z2VtbWFwMzMKIGh1Z2VtbWFwMDVf
MSBodWdlbW1hcDA1IC1tCiBodWdlbW1hcDA1XzIgaHVnZW1tYXAwNSAtcwogaHVnZW1tYXAwNV8z
IGh1Z2VtbWFwMDUgLXMgLW0KZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRp
Z25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCmluZGV4IGM5NmZlOGJmYy4u
NDQ0YWNkZjUyIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUKQEAgLTM0LDYgKzM0LDcgQEAKIC9o
dWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzAKIC9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzEK
IC9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzIKKy9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFw
MzMKIC9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwMQogL2h1Z2V0bGIvaHVnZXNobWF0L2h1
Z2VzaG1hdDAyCiAvaHVnZXRsYi9odWdlc2htYXQvaHVnZXNobWF0MDMKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzMy5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMzLmMKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi5lYjIxZTIwNGMKLS0tIC9kZXYvbnVsbAorKysgYi90
ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzMuYwpAQCAtMCww
ICsxLDg3IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgor
LyoKKyAqIENvcHlyaWdodCAoQykgMjAwNS0yMDA2IElCTSBDb3Jwb3JhdGlvbi4KKyAqIEF1dGhv
cjogRGF2aWQgR2lic29uICYgQWRhbSBMaXRrZQorICovCisKKy8qXAorICogW0Rlc2NyaXB0aW9u
XQorICoKKyAqIFRlc3QgY2FzZSBpcyB1c2VkIHRvIHZlcmlmeSB0aGUgY29ycmVjdCBmdW5jdGlv
bmFsaXR5CisgKiBhbmQgY29tcGF0aWJpbGl0eSBvZiB0aGUgbGlicmFyeSB3aXRoIHRoZSAidHJ1
bmNhdGUiIHN5c3RlbSBjYWxsIHdoZW4KKyAqIG9wZXJhdGluZyBvbiBmaWxlcyByZXNpZGluZyBp
biBhIG1vdW50ZWQgaHVnZSBwYWdlIGZpbGVzeXN0ZW0uCisgKi8KKworI2luY2x1ZGUgImh1Z2V0
bGIuaCIKKyNpbmNsdWRlIDxzZXRqbXAuaD4KKyNpbmNsdWRlIDxzaWduYWwuaD4KKworI2RlZmlu
ZSBNTlRQT0lOVCAiaHVnZXRsYmZzLyIKKworc3RhdGljIGxvbmcgaHBhZ2Vfc2l6ZTsKK3N0YXRp
YyBpbnQgZmQ7CitzdGF0aWMgc2lnam1wX2J1ZiBzaWdfZXNjYXBlOworc3RhdGljIHZvbGF0aWxl
IGludCB0ZXN0X3Bhc3M7CitzdGF0aWMgaW50IHNpZ2J1c19jb3VudDsKKworc3RhdGljIHZvaWQg
c2lnYnVzX2hhbmRsZXIoaW50IHNpZ251bSBMVFBfQVRUUklCVVRFX1VOVVNFRCkKK3sKKwl0ZXN0
X3Bhc3MgPSAxOworCXNpZ2xvbmdqbXAoc2lnX2VzY2FwZSwgMTcpOworfQorCitzdGF0aWMgdm9p
ZCBydW5fdGVzdCh2b2lkKQoreworCXZvaWQgKnA7CisJdm9sYXRpbGUgdW5zaWduZWQgaW50ICpx
OworCisJc2lnYnVzX2NvdW50ID0gMDsKKwl0ZXN0X3Bhc3MgPSAwOworCisJc3RydWN0IHNpZ2Fj
dGlvbiBteV9zaWdhY3Rpb247CisKKwlteV9zaWdhY3Rpb24uc2FfaGFuZGxlciA9IHNpZ2J1c19o
YW5kbGVyOworCXAgPSBTQUZFX01NQVAoTlVMTCwgaHBhZ2Vfc2l6ZSwgUFJPVF9SRUFEfFBST1Rf
V1JJVEUsIE1BUF9TSEFSRUQsCisJCQlmZCwgMCk7CisJcSA9IHA7CisJKnEgPSAwOworCVNBRkVf
U0lHQUNUSU9OKFNJR0JVUywgJm15X3NpZ2FjdGlvbiwgTlVMTCk7CisJU0FGRV9GVFJVTkNBVEUo
ZmQsIDApOworCisJaWYgKHNpZ3NldGptcChzaWdfZXNjYXBlLCAxKSA9PSAwKQorCQkqcTsKKwll
bHNlCisJCXNpZ2J1c19jb3VudCsrOworCisJaWYgKHNpZ2J1c19jb3VudCAhPSAxKQorCQl0c3Rf
cmVzKFRGQUlMLCAiRGlkbid0IFNJR0JVUyIpOworCisJaWYgKHRlc3RfcGFzcyA9PSAxKQorCQl0
c3RfcmVzKFRQQVNTLCAiRXhwZWN0ZWQgU0lHQlVTIHRyaWdnZXJlZCIpOworCisJU0FGRV9NVU5N
QVAocCwgaHBhZ2Vfc2l6ZSk7Cit9CisKKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKK3sKKwlo
cGFnZV9zaXplID0gdHN0X2dldF9odWdlcGFnZV9zaXplKCk7CisJZmQgPSB0c3RfY3JlYXRfdW5s
aW5rZWQoTU5UUE9JTlQsIDApOworfQorCitzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCit7CisJ
aWYgKGZkID4gMCkKKwkJU0FGRV9DTE9TRShmZCk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rl
c3QgdGVzdCA9IHsKKwkubmVlZHNfcm9vdCA9IDEsCisJLm1udHBvaW50ID0gTU5UUE9JTlQsCisJ
Lm5lZWRzX2h1Z2V0bGJmcyA9IDEsCisJLm5lZWRzX3RtcGRpciA9IDEsCisJLnNldHVwID0gc2V0
dXAsCisJLmNsZWFudXAgPSBjbGVhbnVwLAorCS50ZXN0X2FsbCA9IHJ1bl90ZXN0LAorCS5odWdl
cGFnZXMgPSB7MSwgVFNUX05FRURTfSwKK307Ci0tIAoyLjM5LjMKCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
