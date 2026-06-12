Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18FECD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 17:21:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CACE3E6B3B
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:21:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC79E3E6B3C
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 19:19:43 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E9D811400C5A
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 19:19:41 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CEVaYa4146518; Fri, 12 Jun 2026 17:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=S35hjq
 ydmtC5foBiRwNdGFd8251RmKaC0LLoaBvhFeE=; b=VqG/XdyRKNebXGuAWm3wbn
 CS8A43/kTuVahp3Fke4DtJqXyO0nApnmYv6lVekE0Dv0PxG4BKcUBpmMm6CGl1Vq
 ajRlmmVZQsrHnK9lx2sW0Azj5+bKl8PHrQ6w3iTzAEAmsd9pGzggGY6vx516EXuq
 eT+ChfwKDZdpnWJia+6Se6Tn9QcYH0VQ1zFwKX3bZzsYVCYpyGbLqwPFQvyhH4ws
 IMBKcWcqpgLYTZZFviLUPEZiPCEp9CbE6DUFmD6Ngmt1duUrePyECmfIf7aHACHw
 FyPjLRlvpqdmSGCPaqWpfE5oioDLe6vJVN+e/Kg0zlmmgrHoQPdKBpYqDZzhkC4A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ca5sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 17:19:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CGnemE025523;
 Fri, 12 Jun 2026 17:19:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a8ufd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 17:19:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65CHJaQP50397498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 17:19:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64E5020040;
 Fri, 12 Jun 2026 17:19:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B16612004D;
 Fri, 12 Jun 2026 17:19:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.87.219])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 17:19:35 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 22:49:26 +0530
Message-Id: <20260612171930.11964-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260612171930.11964-1-sachinp@linux.ibm.com>
References: <20260612171930.11964-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE1OSBTYWx0ZWRfXwg6FG6PWBftF
 uw8usk2gNUPo4hg25ReUW3w887e6uLcW30fH6IXR+0XFtg6Mj7lEGeyuImVy7sh6mnkMGO00LCL
 fUCCOa+AMMzUOQv8VKgiflSzoNIxt+E=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2c3fab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaZOuUcuEhqKilkFWQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wx99lJp597rcK8dTVSwctKdMu_0X6ulo
X-Proofpoint-ORIG-GUID: wx99lJp597rcK8dTVSwctKdMu_0X6ulo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE1OSBTYWx0ZWRfX2XWBgmI0tsTV
 9SCFXpTiQqxGu4baFKo/y+rEiHBM6bEGhO5TuI12ZWtHTmBL1Y21Q8hhYDz7OO3aNHMVLWNgZzw
 zZ25OD6//vzgf1BvtASHupUVmBwgpJtXTKFnnX6yrJ5YY3seQkQLoV+CRfogLx23gNr1My8Bd6l
 VLpsMzzDNc3y3Mh4UL7kqajeja8ERCoHRWlD9X+w+gwDeHSDHxPku9+YuigcQc4vChh5Bf9Vgua
 CbrTK41FIb92mMbfmyadPjj/4edIuJhO9a85b8APKHQtoyyPe+3tf2Or4hy9Iund5oaYIA+JxAH
 h+Ov77l/Poq/aHIAIZnZYQc7vr7zp6pgbngyltL7Qsk+fUP5q2Vghr+bszxbIDQ0PQPDTPaQMre
 bFONJuWeckCfF9WjLcLs9s0y8BmwAf8NR2cyxKSiCjF+BEHYTtNPiaPuCO/aUv24zxRgkJRwhzG
 Qn2+zXsPuknHCaU4WvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120159
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 4/8] fs/acl: Add default ACL inheritance test
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
YXMgMDQ0NCBwZXJtaXNzaW9ucyBpbmhlcml0ZWQgZnJvbSB0aGUKZGVmYXVsdCBBQ0wuCgpTdWdn
ZXN0ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PgpTaWduZWQtb2ZmLWJ5OiBT
YWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KVjcgY2hhbmdlczoKLSBObyBj
aGFuZ2UKClY2IGNoYW5nZXM6Ci0gQWRkZWQgSEFWRV9TWVNfWEFUVFJfSCBndWFyZAotIFJlbW92
ZWQgcmVkdW5kYW50IGVycm9yIGNoZWNraW5nLCByZWx5aW5nIG9uIGxpYnJhcnkgZnVuY3Rpb25z
Ci0gVXBkYXRlZCBhbGdvcml0aG0gZG9jdW1lbnRhdGlvbiB3aXRoIGNvcnJlY3QgZm9ybWF0Ci0g
djUgbGluayBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA2MDgwOTIyMDAuOTI4Mjct
MS1zYWNoaW5wQGxpbnV4LmlibS5jb20vVC8jdAoKVjUgY2hhbmdlczoKLSBTd2l0Y2ggdG8ga2Vy
bmVsIG9ubHkgdGVzdCB2YWxpZGF0aW9uIHRvIHJlbW92ZSBkZXBlbmRlbmN5IG9uIGxpYmFjbAog
IGFuZCB1c2VyYWRkL2RlbCBjb21tYW5kcy4KLSB2NCBsaW5rIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2x0cC8yMDI2MDYwNDA2NTQxNy4yNTkyNC0xLXNhY2hpbnBAbGludXguaWJtLmNvbS9ULyN0
CgpWNCBjaGFuZ2VzOgotIFJlbW92ZSB1bnVzZWTCoGFjbF9nZXRfZmlsZSgpwqBibG9jawotIGtl
ZXAgbW9kZS1iaXQgdmFsaWRhdGlvbiB3aXRoIGV4cGxhbmF0b3J5IGNvbW1lbnQKLSB2MyBsaW5r
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDYwMzA2NTc0NC40NzEwNi0xLXNhY2hp
bnBAbGludXguaWJtLmNvbS9ULyN0CgpWMyBjaGFuZ2VzOgotIFVwZGF0ZWQgY29weXJpZ2h0IGhl
YWRlciBhcyBwZXIgTFRQIGZvcm1hdC4KLSB2MSBsaW5rIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2x0cC8yMDI2MDYwMjEyMTk1OC4yNzQ5NC0xLXNhY2hpbnBAbGludXguaWJtLmNvbS9ULyN0CgpW
MiBjaGFuZ2VzOgotIE5vIGNoYW5nZXMKClYxIGNoYW5nZXM6Ci0gVXNlIEhBVkVfTElCQUNMIGd1
YXJkcyBpbiAuYyBjb2RlCi0gUmVwb3J0IFRDT05GIHdoZW4gbGliYWNsIGlzIG5vdCBhdmFpbGFi
bGUKLSByZmMgbGluayBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvNDc3ODM2ZmQtODBjOC00
MTY4LWJmZTYtMDBiMzc0YmIyNTM0QGxpbnV4LmlibS5jb20vVC8jdAoKLS0tCiBydW50ZXN0L2Zz
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogdGVzdGNhc2VzL2tlcm5lbC9m
cy9hY2wvLmdpdGlnbm9yZSAgICAgIHwgICAxICsKIHRlc3RjYXNlcy9rZXJuZWwvZnMvYWNsL2Fj
bF9pbmhlcml0MDEuYyB8IDExMyArKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hh
bmdlZCwgMTE1IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2Vy
bmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMKCmRpZmYgLS1naXQgYS9ydW50ZXN0L2ZzIGIvcnVu
dGVzdC9mcwppbmRleCBmMjU0ODdhMzMuLmZkMjk1ZWRjNyAxMDA2NDQKLS0tIGEvcnVudGVzdC9m
cworKysgYi9ydW50ZXN0L2ZzCkBAIC05MiwzICs5Miw0IEBAIHNxdWFzaGZzMDEgc3F1YXNoZnMw
MQogYWNsX3VzZXJfb2JqMDEgYWNsX3VzZXJfb2JqMDEKIGFjbF9tYXNrMDEgYWNsX21hc2swMQog
YWNsX290aGVyMDEgYWNsX290aGVyMDEKK2FjbF9pbmhlcml0MDEgYWNsX2luaGVyaXQwMQpkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvLmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9r
ZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUKaW5kZXggYzNlYzBmYWQzLi5iYzAzYmExZmQgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9mcy9hY2wvLmdpdGlnbm9yZQpAQCAtMSwzICsxLDQgQEAKIC9hY2xfdXNlcl9vYmow
MQogL2FjbF9tYXNrMDEKIC9hY2xfb3RoZXIwMQorL2FjbF9pbmhlcml0MDEKZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNsL2FjbF9pbmhlcml0MDEuYyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvZnMvYWNsL2FjbF9pbmhlcml0MDEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwMDAuLjVhZjk2YjkxMgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMv
YWNsL2FjbF9pbmhlcml0MDEuYwpAQCAtMCwwICsxLDExMyBAQAorLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKy8qCisgKiBDb3B5cmlnaHQgKGMpIDIwMjYgSUJN
CisgKgorICogT3JpZ2luYWwgc2hlbGwgdGVzdCBieSBLYWkgWmhhbyAobHRjZDNAY24uaWJtLmNv
bSkKKyAqIENvbnZlcnRlZCB0byBDIGJ5IFNhY2hpbiBTYW50IDxzYWNoaW5wQGxpbnV4LmlibS5j
b20+CisgKi8KKworLypcCisgKiBUZXN0IGRlZmF1bHQgQUNMIGluaGVyaXRhbmNlIHVzaW5nIGRp
cmVjdCB4YXR0ciBtYW5pcHVsYXRpb24uCisgKgorICogVmVyaWZ5IHRoYXQgZmlsZXMgY3JlYXRl
ZCBpbiBhIGRpcmVjdG9yeSB3aXRoIGRlZmF1bHQgQUNMcyBpbmhlcml0CisgKiB0aG9zZSBBQ0xz
IGFzIHRoZWlyIGFjY2VzcyBBQ0xzLiBEZWZhdWx0IEFDTHMgYXJlIG9ubHkgYXBwbGljYWJsZQor
ICogdG8gZGlyZWN0b3JpZXMgYW5kIGRlZmluZSB0aGUgYWNjZXNzIEFDTHMgdGhhdCBmaWxlcyBh
bmQgc3ViZGlyZWN0b3JpZXMKKyAqIGNyZWF0ZWQgd2l0aGluIHRoYXQgZGlyZWN0b3J5IHdpbGwg
aW5oZXJpdC4KKyAqCisgKiBUaGlzIHRlc3QgdXNlcyBhcmJpdHJhcnkgVUlEcyB3aXRob3V0IGNy
ZWF0aW5nIGFjdHVhbCB1c2VycywgdGVzdGluZworICogb25seSB0aGUga2VybmVsIEFDTCBpbXBs
ZW1lbnRhdGlvbi4KKyAqCisgKiBbQWxnb3JpdGhtXQorICoKKyAqIC0gU2V0IGRlZmF1bHQgQUNM
IG9uIHBhcmVudCBkaXJlY3Rvcnkgd2l0aCByZWFkLW9ubHkgcGVybWlzc2lvbnMKKyAqIC0gQ3Jl
YXRlIGEgbmV3IGZpbGUgaW4gdGhhdCBkaXJlY3Rvcnkgd2l0aCB1bWFzayAwCisgKiAtIFZlcmlm
eSB0aGUgZmlsZSBpbmhlcml0cyB0aGUgZGVmYXVsdCBBQ0wgYXMgaXRzIGFjY2VzcyBBQ0wKKyAq
IC0gQ2hlY2sgdGhhdCBmaWxlIHBlcm1pc3Npb25zIG1hdGNoIHRoZSBpbmhlcml0ZWQgQUNMICgw
NDQ0KQorICovCisKKyNpbmNsdWRlICJhY2xfbGliLmgiCisKKyNpZmRlZiBIQVZFX1NZU19YQVRU
Ul9ICisKKyNkZWZpbmUgVEVTVF9VSUQgMTAwMAorI2RlZmluZSBURVNUX0dJRCAxMDAwCisKK3N0
YXRpYyB2b2lkIHJ1bih2b2lkKQoreworCXN0cnVjdCBhY2wgKmFjbDsKKwlzdHJ1Y3Qgc3RhdCBz
dDsKKworCXRzdF9yZXMoVElORk8sICJUZXN0aW5nIGRlZmF1bHQgQUNMIGluaGVyaXRhbmNlIik7
CisJcmVzZXRfdGVzdF9wYXRoKCk7CisKKwlTQUZFX0NIT1dOKFRFU1RESVIsIFRFU1RfVUlELCBU
RVNUX0dJRCk7CisKKwlhY2wgPSBhY2xfaW5pdCgpOworCisJYWNsX2FkZF9lbnRyeShhY2wsIEFD
TF9VU0VSX09CSiwgQUNMX1JFQUQsIDApOworCWFjbF9hZGRfZW50cnkoYWNsLCBBQ0xfR1JPVVBf
T0JKLCBBQ0xfUkVBRCwgMCk7CisJYWNsX2FkZF9lbnRyeShhY2wsIEFDTF9PVEhFUiwgQUNMX1JF
QUQsIDApOworCisJaWYgKGFjbF9zZXRfZmlsZShURVNURElSLCBBQ0xfVFlQRV9ERUZBVUxULCBh
Y2wpIDwgMCkgeworCQlpZiAoZXJybm8gPT0gRU9QTk9UU1VQUCkgeworCQkJYWNsX2ZyZWUoYWNs
KTsKKwkJCXRzdF9icmsoVENPTkYgfCBURVJSTk8sICJBQ0wgbm90IHN1cHBvcnRlZCIpOworCQl9
CisJCWFjbF9mcmVlKGFjbCk7CisJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJBQ0wgc2V0dXAg
ZmFpbGVkIik7CisJfQorCisJYWNsX2ZyZWUoYWNsKTsKKworCWNyZWF0ZV93aXRoX3VtYXNrX2Fz
KFRFU1RfVUlELCBURVNUX0dJRCwgMDY2NiwgMCwgMCk7CisKKwlTQUZFX1NUQVQoVEVTVEZJTEUs
ICZzdCk7CisKKwkvKgorCSAqIEZvciBhIG1pbmltYWwgQUNMIChjb250YWluaW5nIG9ubHkgQUNM
X1VTRVJfT0JKLCBBQ0xfR1JPVVBfT0JKLAorCSAqIGFuZCBBQ0xfT1RIRVIpLCB0aGUgbW9kZSBi
aXRzIGFyZSB0aGUgY2Fub25pY2FsIHJlcHJlc2VudGF0aW9uLgorCSAqIFZlcmlmeWluZyB0aGUg
bW9kZSBiaXRzIGNvbmZpcm1zIHRoZSBpbmhlcml0ZWQgQUNMIHdhcyBhcHBsaWVkLgorCSAqLwor
CWlmICgoc3Quc3RfbW9kZSAmIDA3NzcpICE9IDA0NDQpIHsKKwkJdHN0X3JlcyhURkFJTCwKKwkJ
CSJGaWxlIHBlcm1pc3Npb25zIDAlbywgZXhwZWN0ZWQgMDQ0NCBmcm9tIGRlZmF1bHQgQUNMIiwK
KwkJCXN0LnN0X21vZGUgJiAwNzc3KTsKKwkJY2xlYW51cF90ZXN0ZmlsZSgpOworCQlyZXR1cm47
CisJfQorCisJY2xlYW51cF90ZXN0ZmlsZSgpOworCXRzdF9yZXMoVFBBU1MsICJEZWZhdWx0IEFD
TCBpbmhlcml0YW5jZSB3b3JrcyBjb3JyZWN0bHkiKTsKK30KKworc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCkKK3sKKwlyZXNldF90ZXN0X3BhdGgoKTsKK30KKworc3RhdGljIHZvaWQgY2xlYW51cCh2
b2lkKQoreworCWNsZWFudXBfdGVzdF9wYXRocygpOworfQorCitzdGF0aWMgc3RydWN0IHRzdF90
ZXN0IHRlc3QgPSB7CisJLnRlc3RfYWxsID0gcnVuLAorCS5zZXR1cCA9IHNldHVwLAorCS5jbGVh
bnVwID0gY2xlYW51cCwKKwkubmVlZHNfcm9vdCA9IDEsCisJLm1vdW50X2RldmljZSA9IDEsCisJ
Lm1udHBvaW50ID0gTU5UUE9JTlQsCisJLmZvcmtzX2NoaWxkID0gMSwKKwkuZmlsZXN5c3RlbXMg
PSAoc3RydWN0IHRzdF9mc1tdKSB7CisJCXsudHlwZSA9ICJleHQyIiwgLm1udF9kYXRhID0gImFj
bCJ9LAorCQl7LnR5cGUgPSAiZXh0MyIsIC5tbnRfZGF0YSA9ICJhY2wifSwKKwkJey50eXBlID0g
ImV4dDQiLCAubW50X2RhdGEgPSAiYWNsIn0sCisJCXsudHlwZSA9ICJ4ZnMifSwKKwkJey50eXBl
ID0gImJ0cmZzIn0sCisJCXt9CisJfQorfTsKKworI2Vsc2UKKwlUU1RfVEVTVF9UQ09ORigic3lz
L3hhdHRyLmggaXMgbm90IGF2YWlsYWJsZSIpOworI2VuZGlmCi0tIAoyLjM5LjEKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
