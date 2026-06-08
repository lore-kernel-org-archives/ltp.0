Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784FFCD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:24:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0203D3E4E81
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:24:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09573E6F99
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:17 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD5B1200226
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:22:10 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65898RYN2767293; Mon, 8 Jun 2026 09:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L7xKYu
 JNYMkuwmmhgipZQyY8iMR3PKBY6+9ZZstfvwQ=; b=gNcOU6op8vVgtfftmOf8Jm
 8nLe7o3TAaSvSKTJg3CZYpEoDIFDkWTK5x9Y1Vmd5q2ORjkDh5/P29t01ZDZC4dZ
 fzqHK6PoZIOglNFl7JcIfxTd4cu8S35g8pzAfMBWU5eM7gOzj2RZhJ22ct1ED1N5
 AuEEiFMgK4r/0VyYyZ3Pms17QumFos2DoDg1ARs8Hj/IwifX4/kRG2dhcU6Vpl3l
 KQQP+Onv6qmpU3tG/531rf2Tfj1Um3jz3kBXrMzfYeBgcexicoTcsiHAwzuMbyAT
 HQZwjRQnz29jNQLWr4n7WCZgL9ZVECuEcTB7CIGW1DdxIQDEbC3lapVW4SnaeFyQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23pjyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589Jcx8027993;
 Mon, 8 Jun 2026 09:22:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgvjrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:22:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6589M5ud46072314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 09:22:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C39920049;
 Mon,  8 Jun 2026 09:22:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC8DC20040;
 Mon,  8 Jun 2026 09:22:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.109.84])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 09:22:04 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 14:51:56 +0530
Message-Id: <20260608092200.92827-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260608092200.92827-1-sachinp@linux.ibm.com>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a2689c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaZOuUcuEhqKilkFWQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: couQPY6ec6cY6ZJ5j-zwimWTaFQrtTdX
X-Proofpoint-GUID: couQPY6ec6cY6ZJ5j-zwimWTaFQrtTdX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXx6h9GiTfZRIR
 Qm9sjzNqpLVzpqlr5CNKwYVVGYxLaJ8pbV07yIKJszJe2FUH4SdO+XfYJSObn0QeH4zGOdRxl40
 th3Rbu2/MwtXe4PFtwNP3ifnKFA3U4mMR0NmR+lMQfgqTwBzaSz1sF11KsH0lDvnMEuO8COSptW
 bO+M2+s8F14k+aSSGlV3BNHgwaGuiyHoQF3IHWNy2qaBvYp4z6s/Zo8zwliprLQXg4twQQQSDem
 W/a82n7tK11A+jl7WGfDv5M/J0OYq/MXI2e3FBjEN+bLTSy3grmbUdxgqgDOXOdDseUZv0dcftY
 S0wV10T7d87ZOgHyG4R3cU/Uyl56oaf0YT4i1KaWF8o0xOM6ATsa1w/vQv4o6bhVuPUu9KA8+Sh
 ztz+H5gIzCm7zPYz6cGaCYg+UIgTreQVkoSVYL4rSVbK1bZQIPOphtb7J7Ag0FvWjH//ni0xC9w
 GFM/Lr4n+2fq2KeHkzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/8] fs/acl: Add default ACL inheritance test
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
YWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KVjQgY2hhbmdlczoKLSBTd2l0
Y2ggdG8ga2VybmVsIG9ubHkgdGVzdCB2YWxpZGF0aW9uIHRvIHJlbW92ZSBkZXBlbmRlbmN5IG9u
IGxpYmFjbAogIGFuZCB1c2VyYWRkL2RlbCBjb21tYW5kcy4KLSB2MyBsaW5rIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2x0cC8yMDI2MDYwNDA2NTQxNy4yNTkyNC0xLXNhY2hpbnBAbGludXguaWJt
LmNvbS9ULyN0CgpWMyBjaGFuZ2VzOgotIFJlbW92ZSB1bnVzZWTCoGFjbF9nZXRfZmlsZSgpwqBi
bG9jawotIGtlZXAgbW9kZS1iaXQgdmFsaWRhdGlvbiB3aXRoIGV4cGxhbmF0b3J5IGNvbW1lbnQK
LSB2MiBsaW5rIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDYwMzA2NTc0NC40NzEw
Ni0xLXNhY2hpbnBAbGludXguaWJtLmNvbS9ULyN0CgpWMiBjaGFuZ2VzOgotIFVwZGF0ZWQgY29w
eXJpZ2h0IGhlYWRlciBhcyBwZXIgTFRQIGZvcm1hdC4KLSB2MSBsaW5rIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2x0cC8yMDI2MDYwMjEyMTk1OC4yNzQ5NC0xLXNhY2hpbnBAbGludXguaWJtLmNv
bS9ULyN0CgpWMSBjaGFuZ2VzOgotIFVzZSBIQVZFX0xJQkFDTCBndWFyZHMgaW4gLmMgY29kZQot
IFJlcG9ydCBUQ09ORiB3aGVuIGxpYmFjbCBpcyBub3QgYXZhaWxhYmxlCi0gcmZjIGxpbmsgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzQ3NzgzNmZkLTgwYzgtNDE2OC1iZmU2LTAwYjM3NGJi
MjUzNEBsaW51eC5pYm0uY29tL1QvI3QKCi0tLQogcnVudGVzdC9mcyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAxICsKIHRlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUg
ICAgICB8ICAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMgfCAx
MjUgKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRp
b25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2lu
aGVyaXQwMS5jCgpkaWZmIC0tZ2l0IGEvcnVudGVzdC9mcyBiL3J1bnRlc3QvZnMKaW5kZXggZjI1
NDg3YTMzLi5mZDI5NWVkYzcgMTAwNjQ0Ci0tLSBhL3J1bnRlc3QvZnMKKysrIGIvcnVudGVzdC9m
cwpAQCAtOTIsMyArOTIsNCBAQCBzcXVhc2hmczAxIHNxdWFzaGZzMDEKIGFjbF91c2VyX29iajAx
IGFjbF91c2VyX29iajAxCiBhY2xfbWFzazAxIGFjbF9tYXNrMDEKIGFjbF9vdGhlcjAxIGFjbF9v
dGhlcjAxCithY2xfaW5oZXJpdDAxIGFjbF9pbmhlcml0MDEKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0
aWdub3JlCmluZGV4IGMzZWMwZmFkMy4uYmMwM2JhMWZkIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL2ZzL2FjbC8uZ2l0aWdub3JlCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5n
aXRpZ25vcmUKQEAgLTEsMyArMSw0IEBACiAvYWNsX3VzZXJfb2JqMDEKIC9hY2xfbWFzazAxCiAv
YWNsX290aGVyMDEKKy9hY2xfaW5oZXJpdDAxCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5o
ZXJpdDAxLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi43NjQyMzMwOGIK
LS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAx
LmMKQEAgLTAsMCArMSwxMjUgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyCisvKgorICogQ29weXJpZ2h0IChjKSAyMDI2IElCTQorICoKKyAqIE9yaWdpbmFs
IHNoZWxsIHRlc3QgYnkgS2FpIFpoYW8gKGx0Y2QzQGNuLmlibS5jb20pCisgKiBDb252ZXJ0ZWQg
dG8gQyBieSBTYWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgorICovCisKKy8qXAor
ICogVGVzdCBkZWZhdWx0IEFDTCBpbmhlcml0YW5jZSB1c2luZyBkaXJlY3QgeGF0dHIgbWFuaXB1
bGF0aW9uLgorICoKKyAqIFZlcmlmeSB0aGF0IGZpbGVzIGNyZWF0ZWQgaW4gYSBkaXJlY3Rvcnkg
d2l0aCBkZWZhdWx0IEFDTHMgaW5oZXJpdAorICogdGhvc2UgQUNMcyBhcyB0aGVpciBhY2Nlc3Mg
QUNMcy4gRGVmYXVsdCBBQ0xzIGFyZSBvbmx5IGFwcGxpY2FibGUKKyAqIHRvIGRpcmVjdG9yaWVz
IGFuZCBkZWZpbmUgdGhlIGFjY2VzcyBBQ0xzIHRoYXQgZmlsZXMgYW5kIHN1YmRpcmVjdG9yaWVz
CisgKiBjcmVhdGVkIHdpdGhpbiB0aGF0IGRpcmVjdG9yeSB3aWxsIGluaGVyaXQuCisgKgorICog
VGhpcyB0ZXN0IHVzZXMgYXJiaXRyYXJ5IFVJRHMgd2l0aG91dCBjcmVhdGluZyBhY3R1YWwgdXNl
cnMsIHRlc3RpbmcKKyAqIG9ubHkgdGhlIGtlcm5lbCBBQ0wgaW1wbGVtZW50YXRpb24uCisgKgor
ICogW0FsZ29yaXRobV0KKyAqCisgKiAxLiBTZXQgZGVmYXVsdCBBQ0wgb24gcGFyZW50IGRpcmVj
dG9yeSB3aXRoIHJlYWQtb25seSBwZXJtaXNzaW9ucworICogMi4gQ3JlYXRlIGEgbmV3IGZpbGUg
aW4gdGhhdCBkaXJlY3Rvcnkgd2l0aCB1bWFzayAwCisgKiAzLiBWZXJpZnkgdGhlIGZpbGUgaW5o
ZXJpdHMgdGhlIGRlZmF1bHQgQUNMIGFzIGl0cyBhY2Nlc3MgQUNMCisgKiA0LiBDaGVjayB0aGF0
IGZpbGUgcGVybWlzc2lvbnMgbWF0Y2ggdGhlIGluaGVyaXRlZCBBQ0wgKDA0NDQpCisgKi8KKwor
I2luY2x1ZGUgImFjbF9saWIuaCIKKworI2RlZmluZSBURVNUX1VJRCAxMDAwCisjZGVmaW5lIFRF
U1RfR0lEIDEwMDAKKworc3RhdGljIHZvaWQgcnVuKHZvaWQpCit7CisJc3RydWN0IGFjbCAqYWNs
ID0gTlVMTDsKKwlzdHJ1Y3Qgc3RhdCBzdDsKKwlpbnQgZXJyOworCisJdHN0X3JlcyhUSU5GTywg
IlRlc3RpbmcgZGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2UiKTsKKwlyZXNldF90ZXN0X3BhdGgoKTsK
KworCVNBRkVfQ0hPV04oVEVTVERJUiwgVEVTVF9VSUQsIFRFU1RfR0lEKTsKKworCWFjbCA9IGFj
bF9pbml0KCk7CisJaWYgKCFhY2wpCisJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJhY2xfaW5p
dCBmYWlsZWQiKTsKKworCWlmIChhY2xfYWRkX2VudHJ5KGFjbCwgQUNMX1VTRVJfT0JKLCBBQ0xf
UkVBRCwgMCkgPCAwKQorCQlnb3RvIGNsZWFudXBfYWNsOworCisJaWYgKGFjbF9hZGRfZW50cnko
YWNsLCBBQ0xfR1JPVVBfT0JKLCBBQ0xfUkVBRCwgMCkgPCAwKQorCQlnb3RvIGNsZWFudXBfYWNs
OworCisJaWYgKGFjbF9hZGRfZW50cnkoYWNsLCBBQ0xfT1RIRVIsIEFDTF9SRUFELCAwKSA8IDAp
CisJCWdvdG8gY2xlYW51cF9hY2w7CisKKwlpZiAoYWNsX3NldF9maWxlKFRFU1RESVIsIEFDTF9U
WVBFX0RFRkFVTFQsIGFjbCkgPCAwKSB7CisJCWlmIChlcnJubyA9PSBFT1BOT1RTVVBQKSB7CisJ
CQlhY2xfZnJlZShhY2wpOworCQkJdHN0X2JyayhUQ09ORiB8IFRFUlJOTywgIkFDTCBub3Qgc3Vw
cG9ydGVkIik7CisJCX0KKwkJZ290byBjbGVhbnVwX2FjbDsKKwl9CisKKwlhY2xfZnJlZShhY2wp
OworCWFjbCA9IE5VTEw7CisKKwllcnIgPSBjcmVhdGVfd2l0aF91bWFza19hcyhURVNUX1VJRCwg
VEVTVF9HSUQsIDA2NjYsIDApOworCWlmIChlcnIpIHsKKwkJZXJybm8gPSBlcnI7CisJCXRzdF9y
ZXMoVEZBSUwgfCBURVJSTk8sICJGYWlsZWQgdG8gY3JlYXRlIHRlc3QgZmlsZSIpOworCQlyZXR1
cm47CisJfQorCisJU0FGRV9TVEFUKFRFU1RGSUxFLCAmc3QpOworCisJLyoKKwkgKiBGb3IgYSBt
aW5pbWFsIEFDTCAoY29udGFpbmluZyBvbmx5IEFDTF9VU0VSX09CSiwgQUNMX0dST1VQX09CSiwK
KwkgKiBhbmQgQUNMX09USEVSKSwgdGhlIG1vZGUgYml0cyBhcmUgdGhlIGNhbm9uaWNhbCByZXBy
ZXNlbnRhdGlvbi4KKwkgKiBWZXJpZnlpbmcgdGhlIG1vZGUgYml0cyBjb25maXJtcyB0aGUgaW5o
ZXJpdGVkIEFDTCB3YXMgYXBwbGllZC4KKwkgKi8KKwlpZiAoKHN0LnN0X21vZGUgJiAwNzc3KSAh
PSAwNDQ0KSB7CisJCXRzdF9yZXMoVEZBSUwsCisJCQkiRmlsZSBwZXJtaXNzaW9ucyAwJW8sIGV4
cGVjdGVkIDA0NDQgZnJvbSBkZWZhdWx0IEFDTCIsCisJCQlzdC5zdF9tb2RlICYgMDc3Nyk7CisJ
CWNsZWFudXBfdGVzdGZpbGUoKTsKKwkJcmV0dXJuOworCX0KKworCWNsZWFudXBfdGVzdGZpbGUo
KTsKKwl0c3RfcmVzKFRQQVNTLCAiRGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2Ugd29ya3MgY29ycmVj
dGx5Iik7CisJcmV0dXJuOworCitjbGVhbnVwX2FjbDoKKwlhY2xfZnJlZShhY2wpOworCXRzdF9i
cmsoVEJST0sgfCBURVJSTk8sICJBQ0wgc2V0dXAgZmFpbGVkIik7Cit9CisKK3N0YXRpYyB2b2lk
IHNldHVwKHZvaWQpCit7CisJcmVzZXRfdGVzdF9wYXRoKCk7Cit9CisKK3N0YXRpYyB2b2lkIGNs
ZWFudXAodm9pZCkKK3sKKwljbGVhbnVwX3Rlc3RfcGF0aHMoKTsKK30KKworc3RhdGljIHN0cnVj
dCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1biwKKwkuc2V0dXAgPSBzZXR1cCwK
KwkuY2xlYW51cCA9IGNsZWFudXAsCisJLm5lZWRzX3Jvb3QgPSAxLAorCS5tb3VudF9kZXZpY2Ug
PSAxLAorCS5tbnRwb2ludCA9IE1OVFBPSU5ULAorCS5mb3Jrc19jaGlsZCA9IDEsCisJLmZpbGVz
eXN0ZW1zID0gKHN0cnVjdCB0c3RfZnNbXSkgeworCQl7LnR5cGUgPSAiZXh0MiIsIC5tbnRfZGF0
YSA9ICJhY2wifSwKKwkJey50eXBlID0gImV4dDMiLCAubW50X2RhdGEgPSAiYWNsIn0sCisJCXsu
dHlwZSA9ICJleHQ0IiwgLm1udF9kYXRhID0gImFjbCJ9LAorCQl7LnR5cGUgPSAieGZzIn0sCisJ
CXsudHlwZSA9ICJidHJmcyJ9LAorCQl7fQorCX0KK307Ci0tIAoyLjM5LjEKCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
