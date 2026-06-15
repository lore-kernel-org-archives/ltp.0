Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E06CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE5503E5C70
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 17:17:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6F533E5C31
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:07 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BA09C6002CE
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 17:16:06 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FEmFlw2711734; Mon, 15 Jun 2026 15:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sgGwur
 cg9duFryu7QVNTMoHcsqWKEK9mS1xHS8coiU4=; b=J8zuztK4i7CzCK8u97wtQy
 bP69tH1Nz0mHYYEBUgMDelReSYjMVwW9qxbuO2MvxwW1wcHeWY/Xys7qYALKEOx5
 oTZB1NCkbCRpZnVVV4QnwLZE5GqU4YV7CxjXUHy/Ig7wyhiTt2SlL2pwCbI2Zemp
 PBpKbognCsuXhpA2TfYm+nl+WMze14x+nwo0NMM9/Fkd1gIn/1o8zOKbtzfoxtMY
 Ex1dDMd3NahUAKq2DlQyps7C07B+bmB9jhub6bECaMc+ec4A5bMdE0N0w6IozCsk
 DvUxrPzJxEDWwbjNYnxq85gV7pnBTI3KP6FaDw0LSNKmoocfogcuWi3mjLWPw/gQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nh6gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 15:16:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FF4ccj030641;
 Mon, 15 Jun 2026 15:16:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpyapq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 15:16:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65FFG2eu45416866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2026 15:16:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE59420040;
 Mon, 15 Jun 2026 15:16:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58CF520049;
 Mon, 15 Jun 2026 15:16:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.84.221])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2026 15:16:01 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 20:45:51 +0530
Message-Id: <20260615151555.71638-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260615151555.71638-1-sachinp@linux.ibm.com>
References: <20260615151555.71638-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a301734 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaZOuUcuEhqKilkFWQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfX0Hpf04vyax7F
 sDZgMtfKOtESyc5llnQ3XELJy/lEw6oXzCneBe3rK17zteW0eZ93hP3UBxc+hgH+xhIYxxQ/hRq
 SrSIgn/kya5lPRVv6EOGPs2Fzu0LhC3xkHNCz10mVdQnjzOOkK6InRDRywixakVKWKydup+tnfr
 hs4lVQ8KMQ1vCL1lAW412uj/O/RW/asMBgU047fj1UyyqgM0/FUZJFVenUBV5gsTLp61w/maX4P
 LjOHRLIFCJeVzrgHRrn56ASbuP567OP/cAHCZjDuQaPNXmRrzvCzAWdW6U+YVkveue3GcHDDOWZ
 sM0rw5qxpM1GXcV3YBMlYHSBDFRV6z5BbbXsDL58i4nGFNmB3Rybbyfc6M3399ePcw0JTLKDrP+
 xlllyRq03JWPvfn7ioEFsKFyzl73TSfFoTu4Q15WLi8hr8Q3oeUUbP68xDt0yLEVlAbcnndJvLG
 ZohVay2cuoaT05yvnCA==
X-Proofpoint-GUID: c_sLlWm08BgM0XGSr75Owfq930zy14Kg
X-Proofpoint-ORIG-GUID: c_sLlWm08BgM0XGSr75Owfq930zy14Kg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1NiBTYWx0ZWRfX4AiHsKDEDNCj
 EPSwjFck/LoSoJcd8iMWW/scVYvJSMIKRbDafBXMb/fo5UDsERZOpNOsqMxl7FRtYjMj/NZAgJg
 aghSJk/aVZeSbYg0fHoJ2M1ZkQHjzz4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150156
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 4/8] fs/acl: Add default ACL inheritance test
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
YWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KTm8gY2hhbmdlcyBpbiBWNyB0
byBWMTEKClY2IGNoYW5nZXM6Ci0gQWRkZWQgSEFWRV9TWVNfWEFUVFJfSCBndWFyZAotIFJlbW92
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
