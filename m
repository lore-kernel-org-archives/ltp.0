Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C83F46C4D
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 15:50:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80C1F3D227E
	for <ltp@archiver.kernel.org>; Mon,  6 Apr 2026 17:50:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A16A13C9917
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 17:50:21 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5DC61400078
 for <ltp@lists.linux.it>; Mon,  6 Apr 2026 17:50:20 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636EX8ng3045555
 for <ltp@lists.linux.it>; Mon, 6 Apr 2026 15:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=ad9qfeNhnI5GYQJMbJv46BkT1rA2
 qpuhDlqMGYF6784=; b=JFYcgA+wAr6x5e8s3j1EvFomnonrWgVGJxn0znFE9EuF
 8M8KnKxlq+E7wDNq84V1T5EfVU1ktbfCFe9Afo0lINmQaXil4Kmu1xMEL9Snwlgr
 WNuJ9rATvDDvGOODW9hTAKkY9YwebPhL4XXFUVDiIXLn0f62v1Sm0Vscl6Wn+sv9
 kvAnVY4hjbJw8PQzHA2hpjli2wc20+LNTukybSjWlOKeSaHK/Kpm8G2aUiXwe7p/
 2dWuPatBDrhZ+kcWc1IcL7Kwu2lsGRB19PSVMTMG/QwOGjRp9+RkYiHj9HiEp482
 OSG8LTE4wn1cTczR6RuwdIWsg4Ea63W+tGzGK/05Nw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2qbt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 06 Apr 2026 15:50:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636CSjqo014325
 for <ltp@lists.linux.it>; Mon, 6 Apr 2026 15:50:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbf6jw3hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 06 Apr 2026 15:50:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 636FoDHc45482420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2026 15:50:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A86B2004B;
 Mon,  6 Apr 2026 15:50:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC7F620040;
 Mon,  6 Apr 2026 15:50:12 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.19.88]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2026 15:50:12 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  6 Apr 2026 21:20:04 +0530
Message-ID: <20260406155008.2216006-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE1NiBTYWx0ZWRfX5XlXDAS5+iMx
 heb/gUJFGzaBnaH3nYM54ZirBm0R0Ni/8gPpiN8MmhbyJEp4g2/RblBP7ID3Wzj7jfZ4buM4nj+
 91cRt5OlUxVvPtHQHKoaQFGv41OF+u68NtHx8P6evzbBh5e0iRmY1DZhOrRAT7m7k/cB4iTYnZB
 zk3eaUVeNq43MItPwsIyhEYsqwkkTsBBo0Ptv55MCFPjl2BbHN/vg0npypYQITvRz76tOvVZ7RG
 D4/a6AAh6c73FcdJgwirM2yBIa+Jmm35E5n96shxfZmpqNn/w6IxUD57DGDbJ7agf79GOVk683I
 P86atOHoGRlmWRzc4tGqTowE7r5MPuCJX8xxvzFdjCU4s/Fh+t1uzwK5mt6kvlCGx4cFjtSA/Cf
 I/DhSDQh+IztnxzXV8xvHDOKmJ7LzUjUXKA9CiH31yFMtP2yqqR+plHqt7OKd8+90SkmU/buCY6
 5OAMJAgZ4ao4sSLiQrg==
X-Proofpoint-GUID: xS9H8gmpfBs5uFJ6Ej-4QqldjoTySAYL
X-Proofpoint-ORIG-GUID: xS9H8gmpfBs5uFJ6Ej-4QqldjoTySAYL
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d3d63a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=oai8hwNIdXh5_XZuB5IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060156
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fixed hugeshmat05 Test Failure with 1GB Hugepages.
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
IGFuZCBhZGp1c3QgdGVzdApzaXplcyBhY2NvcmRpbmdseS4KClNpZ25lZC1vZmYtYnk6IFBhdml0
aHJhIDxwYXZyYW1wdUBsaW51eC5pYm0uY29tPgotLS0KIC4uLi9tZW0vaHVnZXRsYi9odWdlc2ht
YXQvaHVnZXNobWF0MDUuYyAgICAgICB8IDQ1ICsrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1hdDA1LmMgYi90ZXN0
Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwNS5jCmluZGV4IDNi
MmFlMzUxYy4uODcwYTYxZWMxIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
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
LCBJUENfUk1JRCwgTlVMTCk7CkBAIC02OSwxNiArNzMsMzkgQEAgdm9pZCBzaG1fdGVzdChpbnQg
c2l6ZSkKIHN0YXRpYyB2b2lkIHRlc3RfaHVnZXNobWF0KHZvaWQpCiB7CiAJdW5zaWduZWQgaW50
IGk7CisJbG9uZyB0c3Rfc2l6ZXNbNF07CisKKwkvKgorCSAqIEZvciBsYXJnZSBodWdlcGFnZSBz
aXplcyAoZS5nLiwgMUdCKSwgd2UgbmVlZCB0byBlbnN1cmUKKwkgKiB0ZXN0IHNpemVzIGFyZSB3
aXRoaW4gcmVhc29uYWJsZSBib3VuZHMgYW5kIHByb3Blcmx5IGFsaWduZWQuCisJICogVGhlIG9y
aWdpbmFsIHRlc3QgdXNlZCBOKmhwYWdlX3NpemUgd2hpY2ggY291bGQgYmUgNEdCIGZvciAxR0Ig
cGFnZXMuCisJICoKKwkgKiBXZSBhZGp1c3QgdGhlIHRlc3QgdG8gdXNlIE4vMiBtdWx0aXBsaWVy
IGZvciBsYXJnZSBodWdlcGFnZXMKKwkgKiB0byBhdm9pZCBleGNlc3NpdmUgbWVtb3J5IHJlcXVp
cmVtZW50cyB3aGlsZSBzdGlsbCB0ZXN0aW5nIHRoZQorCSAqIGFsaWdubWVudCBib3VuZGFyeSBj
b25kaXRpb25zIHdpdGggbXVsdGlwbGUgcGFnZXMuCisJICovCisJaWYgKGhwYWdlX3NpemUgPj0g
MTAyNCAqIDEwMjQgKiAxMDI0KSB7CisJCS8qIEZvciAxR0Igb3IgbGFyZ2VyIGh1Z2VwYWdlcywg
dXNlIE4vMiBwYWdlcyAoMiBwYWdlcyBmb3IgTj00KSAqLworCQlsb25nIG11bHRpcGxpZXIgPSBO
IC8gMjsKIAotCWNvbnN0IGludCB0c3Rfc2l6ZXNbXSA9IHsKLQkJTiAqIGhwYWdlX3NpemUgLSBw
YWdlX3NpemUsCi0JCU4gKiBocGFnZV9zaXplIC0gcGFnZV9zaXplIC0gMSwKLQkJaHBhZ2Vfc2l6
ZSwKLQkJaHBhZ2Vfc2l6ZSArIDEKLQl9OworCQl0c3Rfc2l6ZXNbMF0gPSBtdWx0aXBsaWVyICog
aHBhZ2Vfc2l6ZSAtIHBhZ2Vfc2l6ZTsKKwkJdHN0X3NpemVzWzFdID0gbXVsdGlwbGllciAqIGhw
YWdlX3NpemUgLSBwYWdlX3NpemUgLSAxOworCQl0c3Rfc2l6ZXNbMl0gPSBocGFnZV9zaXplOwor
CQl0c3Rfc2l6ZXNbM10gPSBocGFnZV9zaXplICsgMTsKKwkJdHN0X3JlcyhUSU5GTywgIlVzaW5n
IE4vMj0lbGQgaHVnZXBhZ2UgdGVzdCBzaXplcyBmb3IgbGFyZ2UgaHVnZXBhZ2VzIiwgbXVsdGlw
bGllcik7CisJfSBlbHNlIHsKKwkJLyogRm9yIHNtYWxsZXIgaHVnZXBhZ2VzICgyTUIsIDE2TUIs
IGV0Yy4pLCB1c2Ugb3JpZ2luYWwgdGVzdCAqLworCQl0c3Rfc2l6ZXNbMF0gPSBOICogaHBhZ2Vf
c2l6ZSAtIHBhZ2Vfc2l6ZTsKKwkJdHN0X3NpemVzWzFdID0gTiAqIGhwYWdlX3NpemUgLSBwYWdl
X3NpemUgLSAxOworCQl0c3Rfc2l6ZXNbMl0gPSBocGFnZV9zaXplOworCQl0c3Rfc2l6ZXNbM10g
PSBocGFnZV9zaXplICsgMTsKKwkJdHN0X3JlcyhUSU5GTywgIlVzaW5nIE49JWQgaHVnZXBhZ2Ug
dGVzdCBzaXplcyIsIE4pOworCX0KIAotCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHRzdF9z
aXplcyk7ICsraSkKKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh0c3Rfc2l6ZXMpOyArK2kp
IHsKKwkJdHN0X3JlcyhUSU5GTywgIlRlc3Rpbmcgc2l6ZTogJWxkIGJ5dGVzIiwgdHN0X3NpemVz
W2ldKTsKIAkJc2htX3Rlc3QodHN0X3NpemVzW2ldKTsKKwl9CiAKIAl0c3RfcmVzKFRQQVNTLCAi
Tm8gcmVncmVzc2lvbiBmb3VuZC4iKTsKIH0KLS0gCjIuNTMuMAoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
