Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3932FF55807
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 10:24:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AF623E2DBF
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 12:24:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D19B3E264F
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:23:51 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9E453600902
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:23:50 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JIqXs82886958; Mon, 20 Apr 2026 10:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=fkDkqWDhAnbEaVluQz7fT04YRjwN
 Yy8r85QXfGYDa8E=; b=bps+Kc80YeUGoANQAFCWygeS173KT4QbDnQh9v9NFTML
 JNfTRj+Y7dwiY8dc3mqTCkBvbwqJ0y8coLRsWoDfSWie2oX6GZKrO7P2rlWA4sOr
 cT9Q8FahTLyAYs18iRhnH/rbN+YnvwQ1YWw5d7rwW1OZ/T+hNQonL5pmQUXQgyBR
 h3IjNV6Y2AJ2+wye9TIjAJTH5D8kyziW5fkvSjO6ml7Ok5/86T18kPJy14AJAAbp
 3TD6X5kRR9PPS3CikXIO13OCi6WHs+zbIofRxnwHNNx8GLti8XJNom6iSH5HqB1o
 /SPAAEIwM8hMl8uKVXYZvQ67PtWS8FInVG3bQ1Vukg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6f9rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 10:23:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KAKa9G022356;
 Mon, 20 Apr 2026 10:23:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9jvb47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 10:23:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63KANhWA29557016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 10:23:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D514200D3;
 Mon, 20 Apr 2026 10:23:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30D5F200E1;
 Mon, 20 Apr 2026 10:23:42 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.124.217.129])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 10:23:41 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 20 Apr 2026 15:53:39 +0530
Message-ID: <20260420102339.729745-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwMCBTYWx0ZWRfX5i4gjVM0L7yU
 nJSSfqC97ygvg3vnieBkS1RUaXdcRsFpuE/rmPJ7rspiX8Agt4FjZfgdgqvScprEd3CTqDSsy1Z
 PYplA2lQt+ZwwYa41FbUQ0Y4FSGIonqHKWyw2V0jOjqt2gVnrX3mpkFvFmDwOZ87vRwNr16D9k/
 JAMjX7k+7OS13WZEbNyBqTufWIVfNvheRpoovP3aOBkDnJFKA9dnXUJNiV5qKOgaLFpOBYLEnnj
 L3kG8uw6fHh9aeTdgW33ar+sGrbrRjDHBJmbCNaoJsCletaXPdaty4IVmgMBB1iVI8grJVD4PIj
 QlQbel00YmMF7M9fNpfjUM/0Bmir4T3dhCD0aLEj76ClXBLXREk5HB4tcEkskMlUi/YARDGc8Hp
 FbQ/1LjIfQs0Rc7OUHeVFzCA1ksr+6jt2YgXl0S0oCHutmlUng6WtmcTr4xwoVDOP4mB27Ht6jI
 AK8QS89F3exvBZ9TZNA==
X-Proofpoint-GUID: Ndgkpe1qhf1U8HhkQJOzmge1REz8Eyly
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e5feb4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3UEEET4vfHQdTR_TBpwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ndgkpe1qhf1U8HhkQJOzmge1REz8Eyly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200100
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix hugeshmat05 test failure on lpar with 1GB
 hugepages.
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TW9kaWZpZWQgdGhlIHRlc3QgdG8gZGV0ZWN0IGxhcmdlIGh1Z2VwYWdlIHNpemVzICjiiaUxR0Ip
IGFuZCBhZGp1c3QgdGVzdCBzaXplcyBhY2NvcmRpbmdseS4KClNpZ25lZC1vZmYtYnk6IFBhdml0
aHJhIDxwYXZyYW1wdUBsaW51eC5pYm0uY29tPgotLS0KIC4uLi9tZW0vaHVnZXRsYi9odWdlc2ht
YXQvaHVnZXNobWF0MDUuYyAgICAgICB8IDMwICsrKysrKysrKysrKysrLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA1LmMgYi90ZXN0
Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwNS5jCmluZGV4IDNi
MmFlMzUxYy4uYzFlMzRmOTk5IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwNS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1
Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA1LmMKQEAgLTM3LDkgKzM3LDEzIEBAIHZvaWQgc2V0
dXAodm9pZCkKIHsKIAlwYWdlX3NpemUgPSBnZXRwYWdlc2l6ZSgpOwogCWhwYWdlX3NpemUgPSBT
QUZFX1JFQURfTUVNSU5GTygiSHVnZXBhZ2VzaXplOiIpICogMTAyNDsKKworCXRzdF9yZXMoVElO
Rk8sICJQYWdlIHNpemU6ICVsZCBieXRlcyIsIHBhZ2Vfc2l6ZSk7CisJdHN0X3JlcyhUSU5GTywg
Ikh1Z2VwYWdlIHNpemU6ICVsZCBieXRlcyAoJWxkIE1CKSIsCisJCWhwYWdlX3NpemUsIGhwYWdl
X3NpemUgLyAoMTAyNCAqIDEwMjQpKTsKIH0KIAotdm9pZCBzaG1fdGVzdChpbnQgc2l6ZSkKK3Zv
aWQgc2htX3Rlc3QobG9uZyBzaXplKQogewogCWludCBzaG1pZDsKIAljaGFyICpzaG1hZGRyOwpA
QCAtNTYsNyArNjAsNyBAQCB2b2lkIHNobV90ZXN0KGludCBzaXplKQogCX0KIAogCXNobWFkZHJb
MF0gPSAxOwotCXRzdF9yZXMoVElORk8sICJhbGxvY2F0ZWQgJWQgaHVnZSBieXRlcyIsIHNpemUp
OworCXRzdF9yZXMoVElORk8sICJhbGxvY2F0ZWQgJWxkIGh1Z2UgYnl0ZXMiLCBzaXplKTsKIAog
CWlmIChzaG1kdCgoY29uc3Qgdm9pZCAqKXNobWFkZHIpICE9IDApIHsKIAkJc2htY3RsKHNobWlk
LCBJUENfUk1JRCwgTlVMTCk7CkBAIC02OSwxMyArNzMsMjMgQEAgdm9pZCBzaG1fdGVzdChpbnQg
c2l6ZSkKIHN0YXRpYyB2b2lkIHRlc3RfaHVnZXNobWF0KHZvaWQpCiB7CiAJdW5zaWduZWQgaW50
IGk7CisJbG9uZyBtdWx0aXBsaWVyOworCWxvbmcgdHN0X3NpemVzWzRdOworCisJLyoKKwkgKiBG
b3IgbGFyZ2UgaHVnZXBhZ2Ugc2l6ZXMgKGUuZy4sIDFHQiksIHVzZSBOLzIgbXVsdGlwbGllciB0
byBhdm9pZAorCSAqIGV4Y2Vzc2l2ZSBtZW1vcnkgcmVxdWlyZW1lbnRzICg0R0IgZm9yIE49NCB3
aXRoIDFHQiBwYWdlcykgd2hpbGUKKwkgKiBzdGlsbCB0ZXN0aW5nIGFsaWdubWVudCBib3VuZGFy
eSBjb25kaXRpb25zIHdpdGggbXVsdGlwbGUgcGFnZXMuCisJICovCisJaWYgKGhwYWdlX3NpemUg
Pj0gMTAyNCAqIDEwMjQgKiAxMDI0KQorCQltdWx0aXBsaWVyID0gTiAvIDI7CisJZWxzZQorCQlt
dWx0aXBsaWVyID0gTjsKIAotCWNvbnN0IGludCB0c3Rfc2l6ZXNbXSA9IHsKLQkJTiAqIGhwYWdl
X3NpemUgLSBwYWdlX3NpemUsCi0JCU4gKiBocGFnZV9zaXplIC0gcGFnZV9zaXplIC0gMSwKLQkJ
aHBhZ2Vfc2l6ZSwKLQkJaHBhZ2Vfc2l6ZSArIDEKLQl9OworCXRzdF9zaXplc1swXSA9IG11bHRp
cGxpZXIgKiBocGFnZV9zaXplIC0gcGFnZV9zaXplOworCXRzdF9zaXplc1sxXSA9IG11bHRpcGxp
ZXIgKiBocGFnZV9zaXplIC0gcGFnZV9zaXplIC0gMTsKKwl0c3Rfc2l6ZXNbMl0gPSBocGFnZV9z
aXplOworCXRzdF9zaXplc1szXSA9IGhwYWdlX3NpemUgKyAxOwogCiAJZm9yIChpID0gMDsgaSA8
IEFSUkFZX1NJWkUodHN0X3NpemVzKTsgKytpKQogCQlzaG1fdGVzdCh0c3Rfc2l6ZXNbaV0pOwot
LSAKMi41My4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
