Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A96CD98CE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 05:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653703E234E
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 07:31:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4ADD93E2367
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:30:06 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 756852005D9
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:30:05 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F1maO7932482; Mon, 15 Jun 2026 05:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bufyas
 L6zdmpbUe+/A1JLO9X24+6KLxdVKaNcA6NwEE=; b=QME6DaOM3EW1HTkbrtBOIr
 YTbmhWgVWTBPizySVKHtS8p/XfBkparTxW6nV6ZioYx+czrzGDlxbRfz8eG7k7Vc
 YPHZFHYLkXLlw0CxT5sAChqrif12i44mp0kHAt0/sK+2zIR8chkTeMqNDKjW3m4i
 pnQ5ON0a/tYadaRaDewR+h2YNpJDTqA5IWfX726CoEYKo7ET+AB9daNeDwhoPI2a
 Unezfounz+02iYbMF/mLG8GZ94OGimkSyh12OzdiIDkXYbfuyDuCKukpbsAzyEQA
 8cfPFujvRHbv2hSORCboP+fNYIRfS9jKIVfBwvJMvkpTrvRGDLUz7e7aJFgx2QiA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkxxp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 05:30:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F5Jbbm028824;
 Mon, 15 Jun 2026 05:30:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpw9ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 05:30:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65F5U08a31523522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2026 05:30:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB61B2004E;
 Mon, 15 Jun 2026 05:30:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D12412004D;
 Mon, 15 Jun 2026 05:29:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.62])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2026 05:29:59 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 15 Jun 2026 10:59:49 +0530
Message-Id: <20260615052953.18183-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260615052953.18183-1-sachinp@linux.ibm.com>
References: <20260615052953.18183-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA1MyBTYWx0ZWRfX8Q0gmM+fjPzn
 9V9Mk3gTj5tel7h7JOe+vV7VfPP6n6FtXwkj/rVDsy6o4pZETIiVbjDkUeKFErdDf8dX9/YtcX0
 z4Sx8aG4emkOMjyO1sgkgFpRBy1iX7c=
X-Proofpoint-GUID: cBQPiVzfN6zY6SuGOWU9Mm-wtoJw45CX
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2f8ddb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaZOuUcuEhqKilkFWQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA1MyBTYWx0ZWRfX/RxPB0QiYhZj
 b2NoU3IUtY83Yj//wQdziDFpg9o1Tq+XaXzJ7iNIi7gexI7P+9EUN91GUT19yH2vPBcdwss8PjP
 aifBBViXeZIyMPFihosbdQbAsyOc3QaDAXAXvm7tkXcz0CO9o2JatVLGpgxIolZ8x21qhaSgSlo
 qaHoEr0L3oCyxh19sZs6bw9Xvx8jR3q1YoK1K6z4ZtuAeSe6nD1K/Ru4o40GytrIjXjp3YC1XjR
 4KSngGDwFyRhWMbU1ZChVNJDruu6w6y+ON4+TrIJ3wTkqU1KWZjTTry6btKZ6IB5yWJaSPKeQFK
 fBN6rF5ceawLEedTIUpvoDkhLcNWpz3OprLf81Fw1ox6PFDmYQOCTwAUTkJiRpqGYVjUQzz69gG
 TvAuu+nfKF5kyIdkxdty9kyhJ21Fi0oErWk7BcbTwylF5Uj3+md3/np2TNfZTvkyO/N0Gvbw+xv
 PgJZhiHtQn2Sa8cjg6w==
X-Proofpoint-ORIG-GUID: cBQPiVzfN6zY6SuGOWU9Mm-wtoJw45CX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150053
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 4/8] fs/acl: Add default ACL inheritance test
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
YWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KVjkgY2hhbmdlczoKLSBObyBj
aGFuZ2UKClY4IGNoYW5nZXM6Ci0gTm8gY2hhbmdlCgpWNyBjaGFuZ2VzOgotIE5vIGNoYW5nZQoK
VjYgY2hhbmdlczoKLSBBZGRlZCBIQVZFX1NZU19YQVRUUl9IIGd1YXJkCi0gUmVtb3ZlZCByZWR1
bmRhbnQgZXJyb3IgY2hlY2tpbmcsIHJlbHlpbmcgb24gbGlicmFyeSBmdW5jdGlvbnMKLSBVcGRh
dGVkIGFsZ29yaXRobSBkb2N1bWVudGF0aW9uIHdpdGggY29ycmVjdCBmb3JtYXQKLSB2NSBsaW5r
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDYwODA5MjIwMC45MjgyNy0xLXNhY2hp
bnBAbGludXguaWJtLmNvbS9ULyN0CgpWNSBjaGFuZ2VzOgotIFN3aXRjaCB0byBrZXJuZWwgb25s
eSB0ZXN0IHZhbGlkYXRpb24gdG8gcmVtb3ZlIGRlcGVuZGVuY3kgb24gbGliYWNsCiAgYW5kIHVz
ZXJhZGQvZGVsIGNvbW1hbmRzLgotIHY0IGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRw
LzIwMjYwNjA0MDY1NDE3LjI1OTI0LTEtc2FjaGlucEBsaW51eC5pYm0uY29tL1QvI3QKClY0IGNo
YW5nZXM6Ci0gUmVtb3ZlIHVudXNlZMKgYWNsX2dldF9maWxlKCnCoGJsb2NrCi0ga2VlcCBtb2Rl
LWJpdCB2YWxpZGF0aW9uIHdpdGggZXhwbGFuYXRvcnkgY29tbWVudAotIHYzIGxpbmsgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwNjAzMDY1NzQ0LjQ3MTA2LTEtc2FjaGlucEBsaW51
eC5pYm0uY29tL1QvI3QKClYzIGNoYW5nZXM6Ci0gVXBkYXRlZCBjb3B5cmlnaHQgaGVhZGVyIGFz
IHBlciBMVFAgZm9ybWF0LgotIHYxIGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIw
MjYwNjAyMTIxOTU4LjI3NDk0LTEtc2FjaGlucEBsaW51eC5pYm0uY29tL1QvI3QKClYyIGNoYW5n
ZXM6Ci0gTm8gY2hhbmdlcwoKVjEgY2hhbmdlczoKLSBVc2UgSEFWRV9MSUJBQ0wgZ3VhcmRzIGlu
IC5jIGNvZGUKLSBSZXBvcnQgVENPTkYgd2hlbiBsaWJhY2wgaXMgbm90IGF2YWlsYWJsZQotIHJm
YyBsaW5rIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC80Nzc4MzZmZC04MGM4LTQxNjgtYmZl
Ni0wMGIzNzRiYjI1MzRAbGludXguaWJtLmNvbS9ULyN0CgotLS0KIHJ1bnRlc3QvZnMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8u
Z2l0aWdub3JlICAgICAgfCAgIDEgKwogdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVy
aXQwMS5jIHwgMTEzICsrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAx
MTUgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvZnMv
YWNsL2FjbF9pbmhlcml0MDEuYwoKZGlmZiAtLWdpdCBhL3J1bnRlc3QvZnMgYi9ydW50ZXN0L2Zz
CmluZGV4IGYyNTQ4N2EzMy4uZmQyOTVlZGM3IDEwMDY0NAotLS0gYS9ydW50ZXN0L2ZzCisrKyBi
L3J1bnRlc3QvZnMKQEAgLTkyLDMgKzkyLDQgQEAgc3F1YXNoZnMwMSBzcXVhc2hmczAxCiBhY2xf
dXNlcl9vYmowMSBhY2xfdXNlcl9vYmowMQogYWNsX21hc2swMSBhY2xfbWFzazAxCiBhY2xfb3Ro
ZXIwMSBhY2xfb3RoZXIwMQorYWNsX2luaGVyaXQwMSBhY2xfaW5oZXJpdDAxCmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9m
cy9hY2wvLmdpdGlnbm9yZQppbmRleCBjM2VjMGZhZDMuLmJjMDNiYTFmZCAxMDA2NDQKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvLmdpdGlnbm9yZQorKysgYi90ZXN0Y2FzZXMva2VybmVs
L2ZzL2FjbC8uZ2l0aWdub3JlCkBAIC0xLDMgKzEsNCBAQAogL2FjbF91c2VyX29iajAxCiAvYWNs
X21hc2swMQogL2FjbF9vdGhlcjAxCisvYWNsX2luaGVyaXQwMQpkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9h
Y2wvYWNsX2luaGVyaXQwMS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4u
NWFmOTZiOTEyCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNs
X2luaGVyaXQwMS5jCkBAIC0wLDAgKzEsMTEzIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vci1sYXRlcgorLyoKKyAqIENvcHlyaWdodCAoYykgMjAyNiBJQk0KKyAqCisg
KiBPcmlnaW5hbCBzaGVsbCB0ZXN0IGJ5IEthaSBaaGFvIChsdGNkM0Bjbi5pYm0uY29tKQorICog
Q29udmVydGVkIHRvIEMgYnkgU2FjaGluIFNhbnQgPHNhY2hpbnBAbGludXguaWJtLmNvbT4KKyAq
LworCisvKlwKKyAqIFRlc3QgZGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2UgdXNpbmcgZGlyZWN0IHhh
dHRyIG1hbmlwdWxhdGlvbi4KKyAqCisgKiBWZXJpZnkgdGhhdCBmaWxlcyBjcmVhdGVkIGluIGEg
ZGlyZWN0b3J5IHdpdGggZGVmYXVsdCBBQ0xzIGluaGVyaXQKKyAqIHRob3NlIEFDTHMgYXMgdGhl
aXIgYWNjZXNzIEFDTHMuIERlZmF1bHQgQUNMcyBhcmUgb25seSBhcHBsaWNhYmxlCisgKiB0byBk
aXJlY3RvcmllcyBhbmQgZGVmaW5lIHRoZSBhY2Nlc3MgQUNMcyB0aGF0IGZpbGVzIGFuZCBzdWJk
aXJlY3RvcmllcworICogY3JlYXRlZCB3aXRoaW4gdGhhdCBkaXJlY3Rvcnkgd2lsbCBpbmhlcml0
LgorICoKKyAqIFRoaXMgdGVzdCB1c2VzIGFyYml0cmFyeSBVSURzIHdpdGhvdXQgY3JlYXRpbmcg
YWN0dWFsIHVzZXJzLCB0ZXN0aW5nCisgKiBvbmx5IHRoZSBrZXJuZWwgQUNMIGltcGxlbWVudGF0
aW9uLgorICoKKyAqIFtBbGdvcml0aG1dCisgKgorICogLSBTZXQgZGVmYXVsdCBBQ0wgb24gcGFy
ZW50IGRpcmVjdG9yeSB3aXRoIHJlYWQtb25seSBwZXJtaXNzaW9ucworICogLSBDcmVhdGUgYSBu
ZXcgZmlsZSBpbiB0aGF0IGRpcmVjdG9yeSB3aXRoIHVtYXNrIDAKKyAqIC0gVmVyaWZ5IHRoZSBm
aWxlIGluaGVyaXRzIHRoZSBkZWZhdWx0IEFDTCBhcyBpdHMgYWNjZXNzIEFDTAorICogLSBDaGVj
ayB0aGF0IGZpbGUgcGVybWlzc2lvbnMgbWF0Y2ggdGhlIGluaGVyaXRlZCBBQ0wgKDA0NDQpCisg
Ki8KKworI2luY2x1ZGUgImFjbF9saWIuaCIKKworI2lmZGVmIEhBVkVfU1lTX1hBVFRSX0gKKwor
I2RlZmluZSBURVNUX1VJRCAxMDAwCisjZGVmaW5lIFRFU1RfR0lEIDEwMDAKKworc3RhdGljIHZv
aWQgcnVuKHZvaWQpCit7CisJc3RydWN0IGFjbCAqYWNsOworCXN0cnVjdCBzdGF0IHN0OworCisJ
dHN0X3JlcyhUSU5GTywgIlRlc3RpbmcgZGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2UiKTsKKwlyZXNl
dF90ZXN0X3BhdGgoKTsKKworCVNBRkVfQ0hPV04oVEVTVERJUiwgVEVTVF9VSUQsIFRFU1RfR0lE
KTsKKworCWFjbCA9IGFjbF9pbml0KCk7CisKKwlhY2xfYWRkX2VudHJ5KGFjbCwgQUNMX1VTRVJf
T0JKLCBBQ0xfUkVBRCwgMCk7CisJYWNsX2FkZF9lbnRyeShhY2wsIEFDTF9HUk9VUF9PQkosIEFD
TF9SRUFELCAwKTsKKwlhY2xfYWRkX2VudHJ5KGFjbCwgQUNMX09USEVSLCBBQ0xfUkVBRCwgMCk7
CisKKwlpZiAoYWNsX3NldF9maWxlKFRFU1RESVIsIEFDTF9UWVBFX0RFRkFVTFQsIGFjbCkgPCAw
KSB7CisJCWlmIChlcnJubyA9PSBFT1BOT1RTVVBQKSB7CisJCQlhY2xfZnJlZShhY2wpOworCQkJ
dHN0X2JyayhUQ09ORiB8IFRFUlJOTywgIkFDTCBub3Qgc3VwcG9ydGVkIik7CisJCX0KKwkJYWNs
X2ZyZWUoYWNsKTsKKwkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgIkFDTCBzZXR1cCBmYWlsZWQi
KTsKKwl9CisKKwlhY2xfZnJlZShhY2wpOworCisJY3JlYXRlX3dpdGhfdW1hc2tfYXMoVEVTVF9V
SUQsIFRFU1RfR0lELCAwNjY2LCAwLCAwKTsKKworCVNBRkVfU1RBVChURVNURklMRSwgJnN0KTsK
KworCS8qCisJICogRm9yIGEgbWluaW1hbCBBQ0wgKGNvbnRhaW5pbmcgb25seSBBQ0xfVVNFUl9P
QkosIEFDTF9HUk9VUF9PQkosCisJICogYW5kIEFDTF9PVEhFUiksIHRoZSBtb2RlIGJpdHMgYXJl
IHRoZSBjYW5vbmljYWwgcmVwcmVzZW50YXRpb24uCisJICogVmVyaWZ5aW5nIHRoZSBtb2RlIGJp
dHMgY29uZmlybXMgdGhlIGluaGVyaXRlZCBBQ0wgd2FzIGFwcGxpZWQuCisJICovCisJaWYgKChz
dC5zdF9tb2RlICYgMDc3NykgIT0gMDQ0NCkgeworCQl0c3RfcmVzKFRGQUlMLAorCQkJIkZpbGUg
cGVybWlzc2lvbnMgMCVvLCBleHBlY3RlZCAwNDQ0IGZyb20gZGVmYXVsdCBBQ0wiLAorCQkJc3Qu
c3RfbW9kZSAmIDA3NzcpOworCQljbGVhbnVwX3Rlc3RmaWxlKCk7CisJCXJldHVybjsKKwl9CisK
KwljbGVhbnVwX3Rlc3RmaWxlKCk7CisJdHN0X3JlcyhUUEFTUywgIkRlZmF1bHQgQUNMIGluaGVy
aXRhbmNlIHdvcmtzIGNvcnJlY3RseSIpOworfQorCitzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQor
eworCXJlc2V0X3Rlc3RfcGF0aCgpOworfQorCitzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCit7
CisJY2xlYW51cF90ZXN0X3BhdGhzKCk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVz
dCA9IHsKKwkudGVzdF9hbGwgPSBydW4sCisJLnNldHVwID0gc2V0dXAsCisJLmNsZWFudXAgPSBj
bGVhbnVwLAorCS5uZWVkc19yb290ID0gMSwKKwkubW91bnRfZGV2aWNlID0gMSwKKwkubW50cG9p
bnQgPSBNTlRQT0lOVCwKKwkuZm9ya3NfY2hpbGQgPSAxLAorCS5maWxlc3lzdGVtcyA9IChzdHJ1
Y3QgdHN0X2ZzW10pIHsKKwkJey50eXBlID0gImV4dDIiLCAubW50X2RhdGEgPSAiYWNsIn0sCisJ
CXsudHlwZSA9ICJleHQzIiwgLm1udF9kYXRhID0gImFjbCJ9LAorCQl7LnR5cGUgPSAiZXh0NCIs
IC5tbnRfZGF0YSA9ICJhY2wifSwKKwkJey50eXBlID0gInhmcyJ9LAorCQl7LnR5cGUgPSAiYnRy
ZnMifSwKKwkJe30KKwl9Cit9OworCisjZWxzZQorCVRTVF9URVNUX1RDT05GKCJzeXMveGF0dHIu
aCBpcyBub3QgYXZhaWxhYmxlIik7CisjZW5kaWYKLS0gCjIuMzkuMQoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
