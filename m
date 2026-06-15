Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B0CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 07:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECCAB3E59B4
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 09:26:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F5A23E59B4
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 09:25:26 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 472DF600A23
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 09:25:24 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6M6vj1607450; Mon, 15 Jun 2026 07:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lDebgg
 UbKpYDZZMwIraYeJeuD+lzd+Vumkff2KF+dN8=; b=FT5/YO3drvuQDe/i5V4jCo
 Xnt5UspPenFaAAemAdbcnmTtP8js2My/rfeVRrqgBDI8VYE97DTUGJRSA3Cr50I6
 2t/FwuwY4D0x9bZ5IGbjpIj1cghCe9fpF2DbrVfDPCTOi8c9RYkUPmzF0T25qDWB
 Ns22WY62Fqzd+lvLorPRmaoYgr0e74ID168iliCIDIBDv4egZDp0W2Dtkm7L3FQs
 QUBUESRRidgKt2hiTLEY804wSAexxILCbPxh3iyxni+hMlmePYq+sSlpDkP4TaQK
 EamtE9jMA+Fz/VJrvmN7KtP97Ty2HK+QWj5PreGJA0U4azVWtQDCr4naCQmCN7mQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0evxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 07:25:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F7JefH032539;
 Mon, 15 Jun 2026 07:25:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvwkec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 07:25:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65F7PKla40239382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2026 07:25:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D47DC2004B;
 Mon, 15 Jun 2026 07:25:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D7E820049;
 Mon, 15 Jun 2026 07:25:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.62])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2026 07:25:19 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 12:55:10 +0530
Message-Id: <20260615072514.53026-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260615072514.53026-1-sachinp@linux.ibm.com>
References: <20260615072514.53026-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DCmEiAO4TGzzZQ87-vKox0h1gPGvP3H5
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2fa8e3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaZOuUcuEhqKilkFWQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX0Hk/ZDRCxt2X
 VOfjUgHBRDBw06KRdlnwhqd/VvbIEns6UU7JCKvYmcqtbI7FaIPB316QfrYnombIObMXp1GSNbA
 3fPfDR3l70Fy8pOC7qJu4cssZ4831sWS/wgMMHWNuA9GZQFuRFeKyu8lArffvS3kWqCVToLyXB0
 h8eeBUVYQ47ElLI9C729+0S21BukL8zBXlXJknnR3+J2YCJYztc+1hmn8P8zpopZ8K4ANPyR8qX
 4VMU6LL2OIVNtSzWhRZWh6D9AMgPqANMJalSqgiHyNFMLz0jYQYEqQ5ZR5n6WU+FjZU9dAplJFP
 pA2OmydejdU9+f9wk9bOy1aI+5Q7lozZnSaa2YUU6VJompM7R0hH8D3rG+2GsPLyy31VNsP791g
 T/M8haAyAEYw5qC6Yn0r15XvVXsheWIwhUcd844I76zBf/MU/C/PgiuEg5sS8E8wRXgXQEUKrOV
 PhSSNqmvpGytCARjyoA==
X-Proofpoint-ORIG-GUID: DCmEiAO4TGzzZQ87-vKox0h1gPGvP3H5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NSBTYWx0ZWRfX57mwMtgh2Ayc
 rC/dcJy51V9lvGuqu2caiNDk/kgEnL+84yMj3P5+FUFP5wCPpecxte6bdsmQjVnXqxUP3yqsgTw
 q/cHDyBL1GvE/K0G+lFYi/AiEEtxqNI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150075
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 4/8] fs/acl: Add default ACL inheritance test
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
YWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KVjEwIGNoYW5nZXM6Ci0gTm8g
Y2hhbmdlCgpWOSBjaGFuZ2VzOgotIE5vIGNoYW5nZQoKVjggY2hhbmdlczoKLSBObyBjaGFuZ2UK
ClY3IGNoYW5nZXM6Ci0gTm8gY2hhbmdlCgpWNiBjaGFuZ2VzOgotIEFkZGVkIEhBVkVfU1lTX1hB
VFRSX0ggZ3VhcmQKLSBSZW1vdmVkIHJlZHVuZGFudCBlcnJvciBjaGVja2luZywgcmVseWluZyBv
biBsaWJyYXJ5IGZ1bmN0aW9ucwotIFVwZGF0ZWQgYWxnb3JpdGhtIGRvY3VtZW50YXRpb24gd2l0
aCBjb3JyZWN0IGZvcm1hdAotIHY1IGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIw
MjYwNjA4MDkyMjAwLjkyODI3LTEtc2FjaGlucEBsaW51eC5pYm0uY29tL1QvI3QKClY1IGNoYW5n
ZXM6Ci0gU3dpdGNoIHRvIGtlcm5lbCBvbmx5IHRlc3QgdmFsaWRhdGlvbiB0byByZW1vdmUgZGVw
ZW5kZW5jeSBvbiBsaWJhY2wKICBhbmQgdXNlcmFkZC9kZWwgY29tbWFuZHMuCi0gdjQgbGluayBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA2MDQwNjU0MTcuMjU5MjQtMS1zYWNoaW5w
QGxpbnV4LmlibS5jb20vVC8jdAoKVjQgY2hhbmdlczoKLSBSZW1vdmUgdW51c2VkwqBhY2xfZ2V0
X2ZpbGUoKcKgYmxvY2sKLSBrZWVwIG1vZGUtYml0IHZhbGlkYXRpb24gd2l0aCBleHBsYW5hdG9y
eSBjb21tZW50Ci0gdjMgbGluayBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA2MDMw
NjU3NDQuNDcxMDYtMS1zYWNoaW5wQGxpbnV4LmlibS5jb20vVC8jdAoKVjMgY2hhbmdlczoKLSBV
cGRhdGVkIGNvcHlyaWdodCBoZWFkZXIgYXMgcGVyIExUUCBmb3JtYXQuCi0gdjEgbGluayBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA2MDIxMjE5NTguMjc0OTQtMS1zYWNoaW5wQGxp
bnV4LmlibS5jb20vVC8jdAoKVjIgY2hhbmdlczoKLSBObyBjaGFuZ2VzCgpWMSBjaGFuZ2VzOgot
IFVzZSBIQVZFX0xJQkFDTCBndWFyZHMgaW4gLmMgY29kZQotIFJlcG9ydCBUQ09ORiB3aGVuIGxp
YmFjbCBpcyBub3QgYXZhaWxhYmxlCi0gcmZjIGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bHRwLzQ3NzgzNmZkLTgwYzgtNDE2OC1iZmU2LTAwYjM3NGJiMjUzNEBsaW51eC5pYm0uY29tL1Qv
I3QKCi0tLQogcnVudGVzdC9mcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsK
IHRlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUgICAgICB8ICAgMSArCiB0ZXN0Y2Fz
ZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMgfCAxMTMgKysrKysrKysrKysrKysrKysr
KysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jCgpkaWZmIC0tZ2l0
IGEvcnVudGVzdC9mcyBiL3J1bnRlc3QvZnMKaW5kZXggZjI1NDg3YTMzLi5mZDI5NWVkYzcgMTAw
NjQ0Ci0tLSBhL3J1bnRlc3QvZnMKKysrIGIvcnVudGVzdC9mcwpAQCAtOTIsMyArOTIsNCBAQCBz
cXVhc2hmczAxIHNxdWFzaGZzMDEKIGFjbF91c2VyX29iajAxIGFjbF91c2VyX29iajAxCiBhY2xf
bWFzazAxIGFjbF9tYXNrMDEKIGFjbF9vdGhlcjAxIGFjbF9vdGhlcjAxCithY2xfaW5oZXJpdDAx
IGFjbF9pbmhlcml0MDEKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5naXRp
Z25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdub3JlCmluZGV4IGMzZWMwZmFk
My4uYmMwM2JhMWZkIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdu
b3JlCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUKQEAgLTEsMyArMSw0
IEBACiAvYWNsX3VzZXJfb2JqMDEKIC9hY2xfbWFzazAxCiAvYWNsX290aGVyMDEKKy9hY2xfaW5o
ZXJpdDAxCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAx
LmMgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi41YWY5NmI5MTIKLS0tIC9kZXYvbnVsbAorKysgYi90
ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMKQEAgLTAsMCArMSwxMTMgQEAK
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisvKgorICogQ29w
eXJpZ2h0IChjKSAyMDI2IElCTQorICoKKyAqIE9yaWdpbmFsIHNoZWxsIHRlc3QgYnkgS2FpIFpo
YW8gKGx0Y2QzQGNuLmlibS5jb20pCisgKiBDb252ZXJ0ZWQgdG8gQyBieSBTYWNoaW4gU2FudCA8
c2FjaGlucEBsaW51eC5pYm0uY29tPgorICovCisKKy8qXAorICogVGVzdCBkZWZhdWx0IEFDTCBp
bmhlcml0YW5jZSB1c2luZyBkaXJlY3QgeGF0dHIgbWFuaXB1bGF0aW9uLgorICoKKyAqIFZlcmlm
eSB0aGF0IGZpbGVzIGNyZWF0ZWQgaW4gYSBkaXJlY3Rvcnkgd2l0aCBkZWZhdWx0IEFDTHMgaW5o
ZXJpdAorICogdGhvc2UgQUNMcyBhcyB0aGVpciBhY2Nlc3MgQUNMcy4gRGVmYXVsdCBBQ0xzIGFy
ZSBvbmx5IGFwcGxpY2FibGUKKyAqIHRvIGRpcmVjdG9yaWVzIGFuZCBkZWZpbmUgdGhlIGFjY2Vz
cyBBQ0xzIHRoYXQgZmlsZXMgYW5kIHN1YmRpcmVjdG9yaWVzCisgKiBjcmVhdGVkIHdpdGhpbiB0
aGF0IGRpcmVjdG9yeSB3aWxsIGluaGVyaXQuCisgKgorICogVGhpcyB0ZXN0IHVzZXMgYXJiaXRy
YXJ5IFVJRHMgd2l0aG91dCBjcmVhdGluZyBhY3R1YWwgdXNlcnMsIHRlc3RpbmcKKyAqIG9ubHkg
dGhlIGtlcm5lbCBBQ0wgaW1wbGVtZW50YXRpb24uCisgKgorICogW0FsZ29yaXRobV0KKyAqCisg
KiAtIFNldCBkZWZhdWx0IEFDTCBvbiBwYXJlbnQgZGlyZWN0b3J5IHdpdGggcmVhZC1vbmx5IHBl
cm1pc3Npb25zCisgKiAtIENyZWF0ZSBhIG5ldyBmaWxlIGluIHRoYXQgZGlyZWN0b3J5IHdpdGgg
dW1hc2sgMAorICogLSBWZXJpZnkgdGhlIGZpbGUgaW5oZXJpdHMgdGhlIGRlZmF1bHQgQUNMIGFz
IGl0cyBhY2Nlc3MgQUNMCisgKiAtIENoZWNrIHRoYXQgZmlsZSBwZXJtaXNzaW9ucyBtYXRjaCB0
aGUgaW5oZXJpdGVkIEFDTCAoMDQ0NCkKKyAqLworCisjaW5jbHVkZSAiYWNsX2xpYi5oIgorCisj
aWZkZWYgSEFWRV9TWVNfWEFUVFJfSAorCisjZGVmaW5lIFRFU1RfVUlEIDEwMDAKKyNkZWZpbmUg
VEVTVF9HSUQgMTAwMAorCitzdGF0aWMgdm9pZCBydW4odm9pZCkKK3sKKwlzdHJ1Y3QgYWNsICph
Y2w7CisJc3RydWN0IHN0YXQgc3Q7CisKKwl0c3RfcmVzKFRJTkZPLCAiVGVzdGluZyBkZWZhdWx0
IEFDTCBpbmhlcml0YW5jZSIpOworCXJlc2V0X3Rlc3RfcGF0aCgpOworCisJU0FGRV9DSE9XTihU
RVNURElSLCBURVNUX1VJRCwgVEVTVF9HSUQpOworCisJYWNsID0gYWNsX2luaXQoKTsKKworCWFj
bF9hZGRfZW50cnkoYWNsLCBBQ0xfVVNFUl9PQkosIEFDTF9SRUFELCAwKTsKKwlhY2xfYWRkX2Vu
dHJ5KGFjbCwgQUNMX0dST1VQX09CSiwgQUNMX1JFQUQsIDApOworCWFjbF9hZGRfZW50cnkoYWNs
LCBBQ0xfT1RIRVIsIEFDTF9SRUFELCAwKTsKKworCWlmIChhY2xfc2V0X2ZpbGUoVEVTVERJUiwg
QUNMX1RZUEVfREVGQVVMVCwgYWNsKSA8IDApIHsKKwkJaWYgKGVycm5vID09IEVPUE5PVFNVUFAp
IHsKKwkJCWFjbF9mcmVlKGFjbCk7CisJCQl0c3RfYnJrKFRDT05GIHwgVEVSUk5PLCAiQUNMIG5v
dCBzdXBwb3J0ZWQiKTsKKwkJfQorCQlhY2xfZnJlZShhY2wpOworCQl0c3RfYnJrKFRCUk9LIHwg
VEVSUk5PLCAiQUNMIHNldHVwIGZhaWxlZCIpOworCX0KKworCWFjbF9mcmVlKGFjbCk7CisKKwlj
cmVhdGVfd2l0aF91bWFza19hcyhURVNUX1VJRCwgVEVTVF9HSUQsIDA2NjYsIDAsIDApOworCisJ
U0FGRV9TVEFUKFRFU1RGSUxFLCAmc3QpOworCisJLyoKKwkgKiBGb3IgYSBtaW5pbWFsIEFDTCAo
Y29udGFpbmluZyBvbmx5IEFDTF9VU0VSX09CSiwgQUNMX0dST1VQX09CSiwKKwkgKiBhbmQgQUNM
X09USEVSKSwgdGhlIG1vZGUgYml0cyBhcmUgdGhlIGNhbm9uaWNhbCByZXByZXNlbnRhdGlvbi4K
KwkgKiBWZXJpZnlpbmcgdGhlIG1vZGUgYml0cyBjb25maXJtcyB0aGUgaW5oZXJpdGVkIEFDTCB3
YXMgYXBwbGllZC4KKwkgKi8KKwlpZiAoKHN0LnN0X21vZGUgJiAwNzc3KSAhPSAwNDQ0KSB7CisJ
CXRzdF9yZXMoVEZBSUwsCisJCQkiRmlsZSBwZXJtaXNzaW9ucyAwJW8sIGV4cGVjdGVkIDA0NDQg
ZnJvbSBkZWZhdWx0IEFDTCIsCisJCQlzdC5zdF9tb2RlICYgMDc3Nyk7CisJCWNsZWFudXBfdGVz
dGZpbGUoKTsKKwkJcmV0dXJuOworCX0KKworCWNsZWFudXBfdGVzdGZpbGUoKTsKKwl0c3RfcmVz
KFRQQVNTLCAiRGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2Ugd29ya3MgY29ycmVjdGx5Iik7Cit9CisK
K3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCit7CisJcmVzZXRfdGVzdF9wYXRoKCk7Cit9CisKK3N0
YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKK3sKKwljbGVhbnVwX3Rlc3RfcGF0aHMoKTsKK30KKwor
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1biwKKwkuc2V0
dXAgPSBzZXR1cCwKKwkuY2xlYW51cCA9IGNsZWFudXAsCisJLm5lZWRzX3Jvb3QgPSAxLAorCS5t
b3VudF9kZXZpY2UgPSAxLAorCS5tbnRwb2ludCA9IE1OVFBPSU5ULAorCS5mb3Jrc19jaGlsZCA9
IDEsCisJLmZpbGVzeXN0ZW1zID0gKHN0cnVjdCB0c3RfZnNbXSkgeworCQl7LnR5cGUgPSAiZXh0
MiIsIC5tbnRfZGF0YSA9ICJhY2wifSwKKwkJey50eXBlID0gImV4dDMiLCAubW50X2RhdGEgPSAi
YWNsIn0sCisJCXsudHlwZSA9ICJleHQ0IiwgLm1udF9kYXRhID0gImFjbCJ9LAorCQl7LnR5cGUg
PSAieGZzIn0sCisJCXsudHlwZSA9ICJidHJmcyJ9LAorCQl7fQorCX0KK307CisKKyNlbHNlCisJ
VFNUX1RFU1RfVENPTkYoInN5cy94YXR0ci5oIGlzIG5vdCBhdmFpbGFibGUiKTsKKyNlbmRpZgot
LSAKMi4zOS4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
