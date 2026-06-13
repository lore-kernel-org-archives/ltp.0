Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281F2CD8CA8
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 09:07:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74A243E5E41
	for <ltp@archiver.kernel.org>; Sat, 13 Jun 2026 11:07:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A08E3E5E42
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:54 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 908F91000D45
 for <ltp@lists.linux.it>; Sat, 13 Jun 2026 11:05:53 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65D6cELo044771; Sat, 13 Jun 2026 09:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Y5J0KG
 u4XMiG3xUIN8+usUr525qAv9MhQV4lLKvBVeQ=; b=SQHIwifSJSfR+iFKtZo5wo
 HyRcvC1fCg8xoUAGQ0NCuGcFEluqa7d96BBgZZzlUMLfkocVh3YTEWNkRzl+j7kR
 gkmwfMXrYvILHzJ0/nK9ov4HTcI+MY/j2nRSZKciyZMmMxJb+xdjmHGwYvYL9RIH
 T+n4f5pke2hTCPV9YoNzgA/XnycebOz/kMNoqukp83bvM8tH7OsOpAgM+AhcPbzR
 d6f3UoaVoLMudzt1C3AOdHWcUjxwx6wYATbZeurzVkhwAW8j/Ppr9D5L+JmKmRn+
 Xfadi563BFklSfoZQB/h+kazbX/Z7yNGy8AbQAJD3QUsKAytMSRU8wrOYKrEYMuQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23n891r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 09:05:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65D94alF026096;
 Sat, 13 Jun 2026 09:05:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a3e81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Jun 2026 09:05:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65D95nIK49545582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Jun 2026 09:05:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 009C12004B;
 Sat, 13 Jun 2026 09:05:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4452C20040;
 Sat, 13 Jun 2026 09:05:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.78.90])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 13 Jun 2026 09:05:48 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 13 Jun 2026 14:35:39 +0530
Message-Id: <20260613090543.78643-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260613090543.78643-1-sachinp@linux.ibm.com>
References: <20260613090543.78643-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2d1d6f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaZOuUcuEhqKilkFWQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfX4eSS0NJMFWp0
 95nDoEuCpe3dOsDakO7rR9LHs3nIpzkwukq/rCir8WdjPxXCZM2arjBGW3KFTkbr3VA7Z1mNviD
 G1hDVtuajqdW1Lmd8GfLj2buR099CQW1sDIzhCZy1sj+sWFf01QB1iJ0AGLKb6V/jbbisRIbsm0
 kqxafEvVkx7/XhkaDPG+aEOCol4j77lplVWBkflw6tWtpDqJ6TJLv2ezCNbqyIbocQNPqV46NMy
 xkxnx5Ok3VCpLDIaniTsEO390tAk+TPAFW3PfxvMOk3l0AVvPDr+qIbUzlPpl96PS+RlrxfzRDS
 6dM6fg84S1iQqYGfnasDz5SZd88dII31TyttOMXd9d5//EJNfb3OE3RvHEnD0w6sgdTsjBkY542
 Y9ci0V9BKt9+MrYKa0vS2Wj44c7/sK/ODXg+RcFdqPu01kN+2c011/Bf5WekeCNxT+S1cxvdoCA
 Hr+ssl/3INwwEsNdEvw==
X-Proofpoint-GUID: LQ1WtrzCmbh3tGK0JgRJB3rAAJVLlrQ6
X-Proofpoint-ORIG-GUID: LQ1WtrzCmbh3tGK0JgRJB3rAAJVLlrQ6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDA4NyBTYWx0ZWRfXzkHaPIqbCIzi
 GweDj3Zpp8Eek1cM+zXoL3/1Q5ZhgiqQYQie5w6ekFvGfOG9zy0gdY9/AZdlwdHqkEJAk3mYZxx
 wuy0tAJICiXGiNuQBxQLAKrlZ7ZJglc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130087
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 4/8] fs/acl: Add default ACL inheritance test
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
YWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KVjggY2hhbmdlczoKLSBObyBj
aGFuZ2UKClY3IGNoYW5nZXM6Ci0gTm8gY2hhbmdlCgpWNiBjaGFuZ2VzOgotIEFkZGVkIEhBVkVf
U1lTX1hBVFRSX0ggZ3VhcmQKLSBSZW1vdmVkIHJlZHVuZGFudCBlcnJvciBjaGVja2luZywgcmVs
eWluZyBvbiBsaWJyYXJ5IGZ1bmN0aW9ucwotIFVwZGF0ZWQgYWxnb3JpdGhtIGRvY3VtZW50YXRp
b24gd2l0aCBjb3JyZWN0IGZvcm1hdAotIHY1IGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bHRwLzIwMjYwNjA4MDkyMjAwLjkyODI3LTEtc2FjaGlucEBsaW51eC5pYm0uY29tL1QvI3QKClY1
IGNoYW5nZXM6Ci0gU3dpdGNoIHRvIGtlcm5lbCBvbmx5IHRlc3QgdmFsaWRhdGlvbiB0byByZW1v
dmUgZGVwZW5kZW5jeSBvbiBsaWJhY2wKICBhbmQgdXNlcmFkZC9kZWwgY29tbWFuZHMuCi0gdjQg
bGluayBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA2MDQwNjU0MTcuMjU5MjQtMS1z
YWNoaW5wQGxpbnV4LmlibS5jb20vVC8jdAoKVjQgY2hhbmdlczoKLSBSZW1vdmUgdW51c2VkwqBh
Y2xfZ2V0X2ZpbGUoKcKgYmxvY2sKLSBrZWVwIG1vZGUtYml0IHZhbGlkYXRpb24gd2l0aCBleHBs
YW5hdG9yeSBjb21tZW50Ci0gdjMgbGluayBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAy
NjA2MDMwNjU3NDQuNDcxMDYtMS1zYWNoaW5wQGxpbnV4LmlibS5jb20vVC8jdAoKVjMgY2hhbmdl
czoKLSBVcGRhdGVkIGNvcHlyaWdodCBoZWFkZXIgYXMgcGVyIExUUCBmb3JtYXQuCi0gdjEgbGlu
ayBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA2MDIxMjE5NTguMjc0OTQtMS1zYWNo
aW5wQGxpbnV4LmlibS5jb20vVC8jdAoKVjIgY2hhbmdlczoKLSBObyBjaGFuZ2VzCgpWMSBjaGFu
Z2VzOgotIFVzZSBIQVZFX0xJQkFDTCBndWFyZHMgaW4gLmMgY29kZQotIFJlcG9ydCBUQ09ORiB3
aGVuIGxpYmFjbCBpcyBub3QgYXZhaWxhYmxlCi0gcmZjIGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbHRwLzQ3NzgzNmZkLTgwYzgtNDE2OC1iZmU2LTAwYjM3NGJiMjUzNEBsaW51eC5pYm0u
Y29tL1QvI3QKCi0tLQogcnVudGVzdC9mcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAxICsKIHRlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUgICAgICB8ICAgMSArCiB0
ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMgfCAxMTMgKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jCgpkaWZm
IC0tZ2l0IGEvcnVudGVzdC9mcyBiL3J1bnRlc3QvZnMKaW5kZXggZjI1NDg3YTMzLi5mZDI5NWVk
YzcgMTAwNjQ0Ci0tLSBhL3J1bnRlc3QvZnMKKysrIGIvcnVudGVzdC9mcwpAQCAtOTIsMyArOTIs
NCBAQCBzcXVhc2hmczAxIHNxdWFzaGZzMDEKIGFjbF91c2VyX29iajAxIGFjbF91c2VyX29iajAx
CiBhY2xfbWFzazAxIGFjbF9tYXNrMDEKIGFjbF9vdGhlcjAxIGFjbF9vdGhlcjAxCithY2xfaW5o
ZXJpdDAxIGFjbF9pbmhlcml0MDEKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNs
Ly5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdub3JlCmluZGV4IGMz
ZWMwZmFkMy4uYmMwM2JhMWZkIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8u
Z2l0aWdub3JlCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNsLy5naXRpZ25vcmUKQEAgLTEs
MyArMSw0IEBACiAvYWNsX3VzZXJfb2JqMDEKIC9hY2xfbWFzazAxCiAvYWNsX290aGVyMDEKKy9h
Y2xfaW5oZXJpdDAxCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5o
ZXJpdDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi41YWY5NmI5MTIKLS0tIC9kZXYvbnVsbAor
KysgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC9hY2xfaW5oZXJpdDAxLmMKQEAgLTAsMCArMSwx
MTMgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisvKgor
ICogQ29weXJpZ2h0IChjKSAyMDI2IElCTQorICoKKyAqIE9yaWdpbmFsIHNoZWxsIHRlc3QgYnkg
S2FpIFpoYW8gKGx0Y2QzQGNuLmlibS5jb20pCisgKiBDb252ZXJ0ZWQgdG8gQyBieSBTYWNoaW4g
U2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgorICovCisKKy8qXAorICogVGVzdCBkZWZhdWx0
IEFDTCBpbmhlcml0YW5jZSB1c2luZyBkaXJlY3QgeGF0dHIgbWFuaXB1bGF0aW9uLgorICoKKyAq
IFZlcmlmeSB0aGF0IGZpbGVzIGNyZWF0ZWQgaW4gYSBkaXJlY3Rvcnkgd2l0aCBkZWZhdWx0IEFD
THMgaW5oZXJpdAorICogdGhvc2UgQUNMcyBhcyB0aGVpciBhY2Nlc3MgQUNMcy4gRGVmYXVsdCBB
Q0xzIGFyZSBvbmx5IGFwcGxpY2FibGUKKyAqIHRvIGRpcmVjdG9yaWVzIGFuZCBkZWZpbmUgdGhl
IGFjY2VzcyBBQ0xzIHRoYXQgZmlsZXMgYW5kIHN1YmRpcmVjdG9yaWVzCisgKiBjcmVhdGVkIHdp
dGhpbiB0aGF0IGRpcmVjdG9yeSB3aWxsIGluaGVyaXQuCisgKgorICogVGhpcyB0ZXN0IHVzZXMg
YXJiaXRyYXJ5IFVJRHMgd2l0aG91dCBjcmVhdGluZyBhY3R1YWwgdXNlcnMsIHRlc3RpbmcKKyAq
IG9ubHkgdGhlIGtlcm5lbCBBQ0wgaW1wbGVtZW50YXRpb24uCisgKgorICogW0FsZ29yaXRobV0K
KyAqCisgKiAtIFNldCBkZWZhdWx0IEFDTCBvbiBwYXJlbnQgZGlyZWN0b3J5IHdpdGggcmVhZC1v
bmx5IHBlcm1pc3Npb25zCisgKiAtIENyZWF0ZSBhIG5ldyBmaWxlIGluIHRoYXQgZGlyZWN0b3J5
IHdpdGggdW1hc2sgMAorICogLSBWZXJpZnkgdGhlIGZpbGUgaW5oZXJpdHMgdGhlIGRlZmF1bHQg
QUNMIGFzIGl0cyBhY2Nlc3MgQUNMCisgKiAtIENoZWNrIHRoYXQgZmlsZSBwZXJtaXNzaW9ucyBt
YXRjaCB0aGUgaW5oZXJpdGVkIEFDTCAoMDQ0NCkKKyAqLworCisjaW5jbHVkZSAiYWNsX2xpYi5o
IgorCisjaWZkZWYgSEFWRV9TWVNfWEFUVFJfSAorCisjZGVmaW5lIFRFU1RfVUlEIDEwMDAKKyNk
ZWZpbmUgVEVTVF9HSUQgMTAwMAorCitzdGF0aWMgdm9pZCBydW4odm9pZCkKK3sKKwlzdHJ1Y3Qg
YWNsICphY2w7CisJc3RydWN0IHN0YXQgc3Q7CisKKwl0c3RfcmVzKFRJTkZPLCAiVGVzdGluZyBk
ZWZhdWx0IEFDTCBpbmhlcml0YW5jZSIpOworCXJlc2V0X3Rlc3RfcGF0aCgpOworCisJU0FGRV9D
SE9XTihURVNURElSLCBURVNUX1VJRCwgVEVTVF9HSUQpOworCisJYWNsID0gYWNsX2luaXQoKTsK
KworCWFjbF9hZGRfZW50cnkoYWNsLCBBQ0xfVVNFUl9PQkosIEFDTF9SRUFELCAwKTsKKwlhY2xf
YWRkX2VudHJ5KGFjbCwgQUNMX0dST1VQX09CSiwgQUNMX1JFQUQsIDApOworCWFjbF9hZGRfZW50
cnkoYWNsLCBBQ0xfT1RIRVIsIEFDTF9SRUFELCAwKTsKKworCWlmIChhY2xfc2V0X2ZpbGUoVEVT
VERJUiwgQUNMX1RZUEVfREVGQVVMVCwgYWNsKSA8IDApIHsKKwkJaWYgKGVycm5vID09IEVPUE5P
VFNVUFApIHsKKwkJCWFjbF9mcmVlKGFjbCk7CisJCQl0c3RfYnJrKFRDT05GIHwgVEVSUk5PLCAi
QUNMIG5vdCBzdXBwb3J0ZWQiKTsKKwkJfQorCQlhY2xfZnJlZShhY2wpOworCQl0c3RfYnJrKFRC
Uk9LIHwgVEVSUk5PLCAiQUNMIHNldHVwIGZhaWxlZCIpOworCX0KKworCWFjbF9mcmVlKGFjbCk7
CisKKwljcmVhdGVfd2l0aF91bWFza19hcyhURVNUX1VJRCwgVEVTVF9HSUQsIDA2NjYsIDAsIDAp
OworCisJU0FGRV9TVEFUKFRFU1RGSUxFLCAmc3QpOworCisJLyoKKwkgKiBGb3IgYSBtaW5pbWFs
IEFDTCAoY29udGFpbmluZyBvbmx5IEFDTF9VU0VSX09CSiwgQUNMX0dST1VQX09CSiwKKwkgKiBh
bmQgQUNMX09USEVSKSwgdGhlIG1vZGUgYml0cyBhcmUgdGhlIGNhbm9uaWNhbCByZXByZXNlbnRh
dGlvbi4KKwkgKiBWZXJpZnlpbmcgdGhlIG1vZGUgYml0cyBjb25maXJtcyB0aGUgaW5oZXJpdGVk
IEFDTCB3YXMgYXBwbGllZC4KKwkgKi8KKwlpZiAoKHN0LnN0X21vZGUgJiAwNzc3KSAhPSAwNDQ0
KSB7CisJCXRzdF9yZXMoVEZBSUwsCisJCQkiRmlsZSBwZXJtaXNzaW9ucyAwJW8sIGV4cGVjdGVk
IDA0NDQgZnJvbSBkZWZhdWx0IEFDTCIsCisJCQlzdC5zdF9tb2RlICYgMDc3Nyk7CisJCWNsZWFu
dXBfdGVzdGZpbGUoKTsKKwkJcmV0dXJuOworCX0KKworCWNsZWFudXBfdGVzdGZpbGUoKTsKKwl0
c3RfcmVzKFRQQVNTLCAiRGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2Ugd29ya3MgY29ycmVjdGx5Iik7
Cit9CisKK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCit7CisJcmVzZXRfdGVzdF9wYXRoKCk7Cit9
CisKK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKK3sKKwljbGVhbnVwX3Rlc3RfcGF0aHMoKTsK
K30KKworc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1biwK
Kwkuc2V0dXAgPSBzZXR1cCwKKwkuY2xlYW51cCA9IGNsZWFudXAsCisJLm5lZWRzX3Jvb3QgPSAx
LAorCS5tb3VudF9kZXZpY2UgPSAxLAorCS5tbnRwb2ludCA9IE1OVFBPSU5ULAorCS5mb3Jrc19j
aGlsZCA9IDEsCisJLmZpbGVzeXN0ZW1zID0gKHN0cnVjdCB0c3RfZnNbXSkgeworCQl7LnR5cGUg
PSAiZXh0MiIsIC5tbnRfZGF0YSA9ICJhY2wifSwKKwkJey50eXBlID0gImV4dDMiLCAubW50X2Rh
dGEgPSAiYWNsIn0sCisJCXsudHlwZSA9ICJleHQ0IiwgLm1udF9kYXRhID0gImFjbCJ9LAorCQl7
LnR5cGUgPSAieGZzIn0sCisJCXsudHlwZSA9ICJidHJmcyJ9LAorCQl7fQorCX0KK307CisKKyNl
bHNlCisJVFNUX1RFU1RfVENPTkYoInN5cy94YXR0ci5oIGlzIG5vdCBhdmFpbGFibGUiKTsKKyNl
bmRpZgotLSAKMi4zOS4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
