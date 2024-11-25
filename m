Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698FDD690EF
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 09:51:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8F433DBB6E
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:51:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADD4D3DA8A5
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 16:30:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=pavrampu@linux.vnet.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B841C101A7E3
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 16:30:40 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APAJkbm022178;
 Mon, 25 Nov 2024 15:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=S6NJ63wDnPM9jEmd1shScIOSyGj+
 a9/GRJ9wvTtE1gU=; b=cbWwkoGhbiaslLpYMzyX/TtowHigU7JFXATASPDU8ZJw
 DRf1GZOjz7Xe8TEp94gZ5MhWA+nqionb7SUQZsDLUvAHAUpw94bjKUvCpHMb8fo9
 yPnoi1U5xSxHCYnrh2PFmpGJRlHB9S9mLgfkN3MwPHkGjMVztNfxsbiDYmsGZHMV
 ZpWfB1Cfsu+VQ7psKqFjk1QLUHj+N3crJIMw8zV5PSp/f/Z711z9yQKALYE6qWTN
 gENdtJfbFjG7oNNf7ggMwEaeYNvgqnyRdq+upoUWDJA8WatL5QSaJ5oEOdrKbduP
 vKQzhLSGtxv6aMZPOoITk/aG9DJ9JMselWVUUPs/AA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386n95gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 15:30:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4APAwh0q018509;
 Mon, 25 Nov 2024 15:30:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scrts6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 15:30:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4APFUZS155771590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 15:30:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B55972004B;
 Mon, 25 Nov 2024 15:30:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE29820043;
 Mon, 25 Nov 2024 15:30:34 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.124.220.116])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2024 15:30:34 +0000 (GMT)
From: Pavithra <pavrampu@linux.vnet.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 25 Nov 2024 21:00:06 +0530
Message-ID: <20241125153006.799645-1-pavrampu@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fxXkVdIzCQAG2m5NMV8dPiPxnVU9iGXq
X-Proofpoint-ORIG-GUID: fxXkVdIzCQAG2m5NMV8dPiPxnVU9iGXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250130
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 28 Nov 2024 10:49:51 +0100
Subject: [LTP] [PATCH v5] Origin:
 https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/shm-getraw.c
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
Cc: pavrampu@linux.vnet.ibm.com, rnsastry@linux.ibm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhlIHRlc3QgY3JlYXRlcyBhIHNoYXJlZCBtZW1vcnkgc2VnbWVudCwgdGhlbiBhdHRhY2hlcyBp
dCB0byB0aGUgcHJvY2Vzc+KAmXMgYWRkcmVzcyBzcGFjZS4KSXQgd3JpdGVzIGEgc3RyaW5nIHRv
IHRoZSBzaGFyZWQgbWVtb3J5IGZyb20gcmF3IGRldmljZSBhbmQgZGV0YWNoZXMgdGhlIHNoYXJl
ZCBtZW1vcnkKc2VnbWVudCBhbmQgZmluYWxseSByZW1vdmVzIGl0LgpUaGUgcHVycG9zZSBvZiB0
aGlzIHRlc3QgaXMgdG8gZW5zdXJlIHRoYXQgdGhlIHNoYXJlZCBtZW1vcnkgc3Vic3lzdGVtIGlz
IHdvcmtpbmcgY29ycmVjdGx5CndpdGggaHVnZXBhZ2VzLiBJdCBjaGVja3MgdGhhdCBzaGFyZWQg
bWVtb3J5IHNlZ21lbnRzIGNhbiBiZSBjcmVhdGVkLCBhdHRhY2hlZCwgd3JpdHRlbiB0bywKcmVh
ZCBmcm9tLCBkZXRhY2hlZCwgYW5kIHJlbW92ZWQgd2l0aG91dCBlcnJvcnMKClNpZ25lZC1vZmYt
Ynk6IFBhdml0aHJhIDxwYXZyYW1wdUBsaW51eC52bmV0LmlibS5jb20+Ci0tLQogcnVudGVzdC9o
dWdldGxiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKwogdGVzdGNhc2VzL2tl
cm5lbC9tZW0vLmdpdGlnbm9yZSAgICAgICAgICAgICAgIHwgIDEgKwogLi4uL2tlcm5lbC9tZW0v
aHVnZXRsYi9odWdlc2htbWlzYy9NYWtlZmlsZSAgIHwgIDkgKysrCiAuLi4vbWVtL2h1Z2V0bGIv
aHVnZXNobW1pc2MvaHVnZXNobW1pc2MwMS5jICAgfCA1OCArKysrKysrKysrKysrKysrKysrCiA0
IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1taXNjL01ha2VmaWxlCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9odWdlc2ht
bWlzYzAxLmMKCmRpZmYgLS1naXQgYS9ydW50ZXN0L2h1Z2V0bGIgYi9ydW50ZXN0L2h1Z2V0bGIK
aW5kZXggZjI5NGU5YWFhLi40MTIwMDgxODUgMTAwNjQ0Ci0tLSBhL3J1bnRlc3QvaHVnZXRsYgor
KysgYi9ydW50ZXN0L2h1Z2V0bGIKQEAgLTU2LDMgKzU2LDUgQEAgaHVnZXNobWdldDAyIGh1Z2Vz
aG1nZXQwMiAtaSAxMAogaHVnZXNobWdldDAzIGh1Z2VzaG1nZXQwMyAtaSAxMAogaHVnZXNobWdl
dDA1IGh1Z2VzaG1nZXQwNSAtaSAxMAogaHVnZXNobWdldDA2IGh1Z2VzaG1nZXQwNiAtaSAxMAor
CitodWdlc2htbWlzYzAxIGh1Z2VzaG1taXNjMDEKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvbWVtLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCmluZGV4
IGQ4ODQ4NGZhMS4uODg5MGQ0MjJlIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS8u
Z2l0aWdub3JlCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUKQEAgLTQ4LDYg
KzQ4LDcgQEAKIC9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDAzCiAvaHVnZXRsYi9odWdl
c2htZ2V0L2h1Z2VzaG1nZXQwNQogL2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDYKKy9o
dWdldGxiL2h1Z2VzaG1taXNjL2h1Z2VzaG1taXNjMDEKIC9rc20va3NtMDEKIC9rc20va3NtMDIK
IC9rc20va3NtMDMKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZXNobW1pc2MvTWFrZWZpbGUgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1t
aXNjL01ha2VmaWxlCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uODQ3MTVj
N2I1Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdl
c2htbWlzYy9NYWtlZmlsZQpAQCAtMCwwICsxLDkgQEAKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyMgQ29weXJpZ2h0IChDKSAyMDA5LCBDaXNjbyBTeXN0ZW1z
IEluYy4KKyMgTmdpZSBDb29wZXIsIEp1bHkgMjAwOQorCit0b3Bfc3JjZGlyICAgICAgICAgICAg
ICA/PSAuLi8uLi8uLi8uLi8uLgorCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay90
ZXN0Y2FzZXMubWsKK2luY2x1ZGUgJChhYnNfc3JjZGlyKS8uLi9NYWtlZmlsZS5pbmMKK2luY2x1
ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1p
c2MwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9odWdlc2ht
bWlzYzAxLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi43MjgxNDAxZTgK
LS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1t
aXNjL2h1Z2VzaG1taXNjMDEuYwpAQCAtMCwwICsxLDU4IEBACisjaW5jbHVkZSAiaHVnZXRsYi5o
IgorI2luY2x1ZGUgInRzdF9zYWZlX3N5c3ZfaXBjLmgiCisKKyNkZWZpbmUgTU5UUE9JTlQgImh1
Z2V0bGJmcy8iCisjZGVmaW5lIE5SX0hVR0VQQUdFUyAyCisKK3N0YXRpYyBpbnQgc2htaWQgPSAt
MTsKK3N0YXRpYyBzaXplX3Qgc2l6ZTsKK3N0YXRpYyBzaXplX3QgaTsKK3N0YXRpYyBzaXplX3Qg
cmV0OworCitzdGF0aWMgdm9sYXRpbGUgY2hhciAqc2htYWRkcjsKK3N0YXRpYyBpbnQgcmF3X2Zk
Oworc3RhdGljIGxvbmcgaHBhZ2Vfc2l6ZTsKKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKK3sK
KwlocGFnZV9zaXplID0gdHN0X2dldF9odWdlcGFnZV9zaXplKCk7Cit9CisKK3N0YXRpYyB2b2lk
IGNsZWFudXAodm9pZCkKK3sKKwlpZiAoc2htaWQgPj0gMCkKKwkJU0FGRV9TSE1DVEwoc2htaWQs
IElQQ19STUlELCBOVUxMKTsKK30KKworc3RhdGljIHZvaWQgcnVuX3Rlc3Qodm9pZCkKK3sKKwlz
aXplID0gaHBhZ2Vfc2l6ZSAqIE5SX0hVR0VQQUdFUzsKKwlyYXdfZmQgPSBTQUZFX09QRU4oIi9k
ZXYvcmFuZG9tIiwgT19SRE9OTFkpOworCXRzdF9yZXMoVElORk8sICJSZXF1ZXN0aW5nICV6dSBi
eXRlc1xuIiwgc2l6ZSk7CisKKyAgICAgICAgc2htaWQgPSBTQUZFX1NITUdFVChJUENfUFJJVkFU
RSwgc2l6ZSwgU0hNX0hVR0VUTEJ8U0hNX1J8U0hNX1cpOworCisJc2htYWRkciA9IFNBRkVfU0hN
QVQoc2htaWQsIDAsIFNITV9STkQpOworCXRzdF9yZXMoVElORk8sICJzaG1hZGRyOiAlcFxuIiwg
c2htYWRkcik7CisKKwkvKiBSZWFkIGEgcGFnZSBmcm9tIGRldmljZSBhbmQgd3JpdGUgdG8gc2ht
IHNlZ21lbnQgKi8KKwlmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSArPSBocGFnZV9zaXplKSB7CisJ
CWlmICghcmVhZChyYXdfZmQsIHNobWFkZHIsIGhwYWdlX3NpemUpKSB7CisJCQl0c3RfcmVzKFRG
QUlMIHwgVEVSUk5PLCAiQ2FuJ3QgcmVhZCBmcm9tIHJhdyBkZXZpY2UhIik7CisJCX0KKwl9CisK
KwlTQUZFX1NITURUKChjb25zdCB2b2lkICopc2htYWRkcik7CisKKwl0c3RfcmVzKFRQQVNTLCAi
VGVzdCBQYXNzZWQhIik7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwku
bmVlZHNfcm9vdCA9IDEsCisJLm1udHBvaW50ID0gTU5UUE9JTlQsCisJLm5lZWRzX2h1Z2V0bGJm
cyA9IDEsCisJLnNldHVwID0gc2V0dXAsCisJLmNsZWFudXAgPSBjbGVhbnVwLAorCS50ZXN0X2Fs
bCA9IHJ1bl90ZXN0LAorCS5odWdlcGFnZXMgPSB7MiwgVFNUX05FRURTfSwKK307Ci0tIAoyLjQz
LjUKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
