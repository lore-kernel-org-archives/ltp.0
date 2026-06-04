Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11307CD6E68
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 06:56:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B00643E54DB
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 08:55:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CADF63E54DC
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 08:54:26 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1F74600941
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 08:54:25 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HIFuf3708001
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dEjINB
 JLfI+KZOZ3YF5fiXqNh9SqmJ4EMtPhhrSzQe4=; b=CfWTf/+hf/ogwxBwHilyBO
 /n0XtVPAwmCZVsKG1qXfWljKGweZMci1F8DbX1UzS52xd7NpKPfI1n5DZ2G7cyFf
 nL1rR5h3H8U5P6AonzrNGCEQJNqBJkdfbky0/5BE6XLO79sAO++lt0zq+eJUajMD
 i/HXwsFrtkoLujeC3HpFsrLFyryGrNGTuv2HwIm24Fh6obnv+fNDxRwnxeWDnrk2
 7CdAbtiIPrp+mpG7dEOv4MumWOLk3GmGTKNrmyB9QoD1up/NdU7X8NDIDqdUNx9l
 aQPIg6h1pKMIuSC73+hSKIa/V5e73cb9doHUn1JpAqlpuuCND0YJI1n8mgdt/ZEg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaee131-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 06:54:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6546sAVO028152
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhktqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 06:54:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6546sLaP48038394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 4 Jun 2026 06:54:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E6E82004D
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1954D20040
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.32.72])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:54:20 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 12:24:13 +0530
Message-Id: <20260604065417.25924-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260604065417.25924-1-sachinp@linux.ibm.com>
References: <20260604065417.25924-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a212120 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=hbbvtKXA8LCI-mQHJx8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H_JEdEP4wg3o-FlSgvJn7JYv0Lf1n08r
X-Proofpoint-ORIG-GUID: H_JEdEP4wg3o-FlSgvJn7JYv0Lf1n08r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2MiBTYWx0ZWRfXx1vHNXgCClCg
 n6QudVCEalhDf1kdeKjORGI2UqXGU8Swrc9pJzls5eMw6CWhwfNdNxLrgQxI1Gzwu6A28QxeeM1
 MRFQ9jDMUuXhzZZ8l9QM7gMR+7G8Rp/cN0oga1cT4agWoHsSBUalvWgyFSSdF4lK6Pjq02YWhEV
 Eu4weFEkbMJF+XwiMphlH5Od/Ip+bvp5Z2Zfed0Eh4VLjlxZ/JG5yG8Ckvz31sZcjwKu45JIp49
 4/bBNsWebXe7rQOor9ZdA57fGolk3JpgVS0lCwMQYpVlZ5pWsqmHkjU5GG78uBgUyMqeOpgnJlI
 aBbCNv4GLMvZcekqDnMS4qxf2c7X/emVLLnAjriQO5S2mDAaTU33Cp6htn/snRA+orAKC4exk7B
 T4T/cTPpwfIYAGHN1VedGIu8syI7jkvtT/D4W1oCHM3Ry5e1shme6c3hUvabjzKFcG975V1jx5L
 yzlC8hET+OmSA+1yWiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040062
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/8] fs/acl: Add default ACL inheritance test
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

QWRkIGFjbF9pbmhlcml0MDEgdGVzdCB0byB2YWxpZGF0ZSBkZWZhdWx0IEFDTCBpbmhlcml0YW5j
ZSBmcm9tCnBhcmVudCBkaXJlY3RvcnkgdG8gbmV3bHkgY3JlYXRlZCBmaWxlcy4KClRoZSB0ZXN0
IHZlcmlmaWVzIHRoYXQ6Ci0gRGVmYXVsdCBBQ0xzIHNldCBvbiBhIGRpcmVjdG9yeSBhcmUgaW5o
ZXJpdGVkIGJ5IG5ldyBmaWxlcwotIE5ldyBmaWxlIHBlcm1pc3Npb25zIHJlZmxlY3QgdGhlIGRl
ZmF1bHQgQUNMIGVudHJpZXMKLSBGaWxlIGNyZWF0ZWQgd2l0aCB1bWFzayAwIGdldHMgcGVybWlz
c2lvbnMgZnJvbSBkZWZhdWx0IEFDTAoKVGhpcyB0ZXN0IHNldHMgZGVmYXVsdCBBQ0wgd2l0aCBy
ZWFkLW9ubHkgcGVybWlzc2lvbnMgKHItLXItLXItLSkKb24gdGhlIHBhcmVudCBkaXJlY3Rvcnks
IGNyZWF0ZXMgYSBuZXcgZmlsZSB3aXRoIHVtYXNrIDAsIGFuZAp2ZXJpZmllcyB0aGUgZmlsZSBo
YXMgMDQ0NCBwZXJtaXNzaW9ucyBpbmhlcml0ZWQgZnJvbSB0aGUgZGVmYXVsdCBBQ0wuCgpTaWdu
ZWQtb2ZmLWJ5OiBTYWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KVjMgY2hh
bmdlczoKLSBSZW1vdmUgdW51c2VkwqBhY2xfZ2V0X2ZpbGUoKcKgYmxvY2sKLSBrZWVwIG1vZGUt
Yml0IHZhbGlkYXRpb24gd2l0aCBleHBsYW5hdG9yeSBjb21tZW50Ci0gdjIgbGluayBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA2MDMwNjU3NDQuNDcxMDYtMS1zYWNoaW5wQGxpbnV4
LmlibS5jb20vVC8jdAoKVjIgY2hhbmdlczoKLSBVcGRhdGVkIGNvcHlyaWdodCBoZWFkZXIgYXMg
cGVyIExUUCBmb3JtYXQuCi0gdjEgbGluayBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAy
NjA2MDIxMjE5NTguMjc0OTQtMS1zYWNoaW5wQGxpbnV4LmlibS5jb20vVC8jdAoKVjEgY2hhbmdl
czoKLSBVc2UgSEFWRV9MSUJBQ0wgZ3VhcmRzIGluIC5jIGNvZGUKLSBSZXBvcnQgVENPTkYgd2hl
biBsaWJhY2wgaXMgbm90IGF2YWlsYWJsZQotIHJmYyBsaW5rIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2x0cC80Nzc4MzZmZC04MGM4LTQxNjgtYmZlNi0wMGIzNzRiYjI1MzRAbGludXguaWJtLmNv
bS9ULyN0CgotLS0KIHJ1bnRlc3QvZnMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MSArCiB0ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdub3JlICAgICAgfCAgIDEgKwogdGVz
dGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jIHwgMTE2ICsrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvZnMvYWNsL2FjbF9pbmhlcml0MDEuYwoKZGlmZiAt
LWdpdCBhL3J1bnRlc3QvZnMgYi9ydW50ZXN0L2ZzCmluZGV4IGYyNTQ4N2EzMy4uZmQyOTVlZGM3
IDEwMDY0NAotLS0gYS9ydW50ZXN0L2ZzCisrKyBiL3J1bnRlc3QvZnMKQEAgLTkyLDMgKzkyLDQg
QEAgc3F1YXNoZnMwMSBzcXVhc2hmczAxCiBhY2xfdXNlcl9vYmowMSBhY2xfdXNlcl9vYmowMQog
YWNsX21hc2swMSBhY2xfbWFzazAxCiBhY2xfb3RoZXIwMSBhY2xfb3RoZXIwMQorYWNsX2luaGVy
aXQwMSBhY2xfaW5oZXJpdDAxCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8u
Z2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvLmdpdGlnbm9yZQppbmRleCBjM2Vj
MGZhZDMuLmJjMDNiYTFmZCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvLmdp
dGlnbm9yZQorKysgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdub3JlCkBAIC0xLDMg
KzEsNCBAQAogL2FjbF91c2VyX29iajAxCiAvYWNsX21hc2swMQogL2FjbF9vdGhlcjAxCisvYWNs
X2luaGVyaXQwMQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVy
aXQwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uZWFiZmM0YmQxCi0tLSAvZGV2L251bGwKKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jCkBAIC0wLDAgKzEsMTE2
IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorLyoKKyAq
IENvcHlyaWdodCAoYykgMjAyNiBJQk0KKyAqCisgKiBPcmlnaW5hbCBzaGVsbCB0ZXN0IGJ5IEth
aSBaaGFvIChsdGNkM0Bjbi5pYm0uY29tKQorICogQ29udmVydGVkIHRvIEMgYnkgU2FjaGluIFNh
bnQgPHNhY2hpbnBAbGludXguaWJtLmNvbT4KKyAqLworCisvKlwKKyAqIFRlc3QgZGVmYXVsdCBB
Q0wgaW5oZXJpdGFuY2UuCisgKgorICogVmVyaWZ5IHRoYXQgZmlsZXMgY3JlYXRlZCBpbiBhIGRp
cmVjdG9yeSB3aXRoIGRlZmF1bHQgQUNMcyBpbmhlcml0CisgKiB0aG9zZSBBQ0xzIGFzIHRoZWly
IGFjY2VzcyBBQ0xzLiBEZWZhdWx0IEFDTHMgYXJlIG9ubHkgYXBwbGljYWJsZQorICogdG8gZGly
ZWN0b3JpZXMgYW5kIGRlZmluZSB0aGUgYWNjZXNzIEFDTHMgdGhhdCBmaWxlcyBhbmQgc3ViZGly
ZWN0b3JpZXMKKyAqIGNyZWF0ZWQgd2l0aGluIHRoYXQgZGlyZWN0b3J5IHdpbGwgaW5oZXJpdC4K
KyAqCisgKiBbQWxnb3JpdGhtXQorICoKKyAqIDEuIFNldCBkZWZhdWx0IEFDTCBvbiBwYXJlbnQg
ZGlyZWN0b3J5IHdpdGggcmVhZC1vbmx5IHBlcm1pc3Npb25zCisgKiAyLiBDcmVhdGUgYSBuZXcg
ZmlsZSBpbiB0aGF0IGRpcmVjdG9yeSB3aXRoIHVtYXNrIDAKKyAqIDMuIFZlcmlmeSB0aGUgZmls
ZSBpbmhlcml0cyB0aGUgZGVmYXVsdCBBQ0wgYXMgaXRzIGFjY2VzcyBBQ0wKKyAqIDQuIENoZWNr
IHRoYXQgZmlsZSBwZXJtaXNzaW9ucyBtYXRjaCB0aGUgaW5oZXJpdGVkIEFDTCAoMDQ0NCkKKyAq
LworCisjaW5jbHVkZSAiYWNsX2xpYi5oIgorCit1aWRfdCB1c2VyMV91aWQsIHVzZXIyX3VpZCwg
dXNlcjNfdWlkOworZ2lkX3QgdXNlcjFfZ2lkLCB1c2VyMl9naWQsIHVzZXIzX2dpZDsKK2ludCB1
c2Vyc19jcmVhdGVkID0gMDsKKworI2lmZGVmIEhBVkVfTElCQUNMCisKK3N0YXRpYyB2b2lkIHJ1
bih2b2lkKQoreworCWFjbF90IGFjbDsKKwlzdHJ1Y3Qgc3RhdCBzdDsKKwlpbnQgZXJyOworCisJ
dHN0X3JlcyhUSU5GTywgIlRlc3RpbmcgZGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2UiKTsKKwlyZXNl
dF90ZXN0X3BhdGgoKTsKKworCWFjbCA9IGFjbF9pbml0KDMpOworCWlmICghYWNsKQorCQl0c3Rf
YnJrKFRCUk9LIHwgVEVSUk5PLCAiYWNsX2luaXQgZmFpbGVkIik7CisKKwlhZGRfYWNsX2VudHJ5
KGFjbCwgQUNMX1VTRVJfT0JKLCBBQ0xfUkVBRCk7CisJYWRkX2FjbF9lbnRyeShhY2wsIEFDTF9H
Uk9VUF9PQkosIEFDTF9SRUFEKTsKKwlhZGRfYWNsX2VudHJ5KGFjbCwgQUNMX09USEVSLCBBQ0xf
UkVBRCk7CisKKwlzZXRfYWNsX2ZpbGUoVEVTVERJUiwgQUNMX1RZUEVfREVGQVVMVCwgYWNsKTsK
KwlzYWZlX2FjbF9mcmVlKGFjbCk7CisKKwllcnIgPSBjcmVhdGVfd2l0aF91bWFza19hcyh1c2Vy
MV91aWQsIHVzZXIxX2dpZCwgMDY2NiwgMCk7CisJaWYgKGVycikgeworCQllcnJubyA9IGVycjsK
KwkJdHN0X3JlcyhURkFJTCB8IFRFUlJOTywgIkZhaWxlZCB0byBjcmVhdGUgdGVzdCBmaWxlIik7
CisJCXJldHVybjsKKwl9CisKKwlTQUZFX1NUQVQoVEVTVEZJTEUsICZzdCk7CisKKwkvKgorCSAq
IEZvciBhIG1pbmltYWwgQUNMIChjb250YWluaW5nIG9ubHkgQUNMX1VTRVJfT0JKLCBBQ0xfR1JP
VVBfT0JKLAorCSAqIGFuZCBBQ0xfT1RIRVIpLCB0aGUgbW9kZSBiaXRzIGFyZSB0aGUgY2Fub25p
Y2FsIHJlcHJlc2VudGF0aW9uLgorCSAqIFZlcmlmeWluZyB0aGUgbW9kZSBiaXRzIGNvbmZpcm1z
IHRoZSBpbmhlcml0ZWQgQUNMIHdhcyBhcHBsaWVkLgorCSAqLworCWlmICgoc3Quc3RfbW9kZSAm
IDA3NzcpICE9IDA0NDQpIHsKKwkJdHN0X3JlcyhURkFJTCwKKwkJCSJGaWxlIHBlcm1pc3Npb25z
IDAlbywgZXhwZWN0ZWQgMDQ0NCBmcm9tIGRlZmF1bHQgQUNMIiwKKwkJCXN0LnN0X21vZGUgJiAw
Nzc3KTsKKwkJY2xlYW51cF90ZXN0ZmlsZSgpOworCQlyZXR1cm47CisJfQorCisJY2xlYW51cF90
ZXN0ZmlsZSgpOworCXRzdF9yZXMoVFBBU1MsICJEZWZhdWx0IEFDTCBpbmhlcml0YW5jZSB3b3Jr
cyBjb3JyZWN0bHkiKTsKK30KKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKK3sKKwlpbml0X3Rl
c3RfdXNlcnMoKTsKKwlyZXNldF90ZXN0X3BhdGgoKTsKK30KKworc3RhdGljIHZvaWQgY2xlYW51
cCh2b2lkKQoreworCWNsZWFudXBfdGVzdF9wYXRocygpOworCWNsZWFudXBfdGVzdF91c2Vycygp
OworfQorCitzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7CisJLnRlc3RfYWxsID0gcnVu
LAorCS5zZXR1cCA9IHNldHVwLAorCS5jbGVhbnVwID0gY2xlYW51cCwKKwkubmVlZHNfcm9vdCA9
IDEsCisJLm1vdW50X2RldmljZSA9IDEsCisJLm1udHBvaW50ID0gTU5UUE9JTlQsCisJLmZvcmtz
X2NoaWxkID0gMSwKKwkuZmlsZXN5c3RlbXMgPSAoc3RydWN0IHRzdF9mc1tdKSB7CisJCXsudHlw
ZSA9ICJleHQyIiwgLm1udF9kYXRhID0gImFjbCJ9LAorCQl7LnR5cGUgPSAiZXh0MyIsIC5tbnRf
ZGF0YSA9ICJhY2wifSwKKwkJey50eXBlID0gImV4dDQiLCAubW50X2RhdGEgPSAiYWNsIn0sCisJ
CXsudHlwZSA9ICJ4ZnMifSwKKwkJey50eXBlID0gImJ0cmZzIn0sCisJCXt9CisJfSwKKwkubmVl
ZHNfY21kcyA9IChzdHJ1Y3QgdHN0X2NtZFtdKSB7CisJCXsuY21kID0gInVzZXJhZGQifSwKKwkJ
ey5jbWQgPSAidXNlcmRlbCJ9LAorCQl7fQorCX0KK307CisKKyNlbHNlCitUU1RfVEVTVF9UQ09O
RigibGliYWNsIG9yIEFDTCBoZWFkZXJzIGFyZSBub3QgYXZhaWxhYmxlIik7CisjZW5kaWYKLS0g
CjIuMzkuMQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
