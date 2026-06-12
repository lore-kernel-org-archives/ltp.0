Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E963CD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:27:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D640D3E5E61
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:27:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F0923E6A5C
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:19 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B9D3200ACD
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:25:12 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BNB6RF723488; Fri, 12 Jun 2026 10:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Xd9+n3
 whH0IVtVmZxsSMjnHCYxm/TifLXLHX6LeH+0I=; b=X4XtbDxFKa72GHHo8TDmTt
 1CaHJqsffklftZgBBm6D27KvxP+5QQ3EUW9wdDzmB0/NImQy8B6zXlJcleipyP41
 Pwa8S3STpDzCAj7tjSKZuIWNy8Ben/Sn10bBYqudg2TXMGPJSF9BUdVkhmXdFFqE
 T6WEi40DDa2EEIj2uuC0M+YtWxbacwuAfWtN3gXQ++PORsRtjzZaT1gJlWo6iInb
 mMJaHhayQdrmy4KYi9TYdabVK2egaLrAK0uDv+WbcoNDl3IM9QXFBY5sdAyyOVJ4
 V+6Yi0uMRljTS7srmaZ9uXgUevv3+kIg7bJz5YT1xDAaM4qrjKRD7VnFvOsFW/PQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dgecd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CAJfGZ009245;
 Fri, 12 Jun 2026 10:25:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08qbs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 10:25:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65CAP71D51970320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 10:25:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF3AA20043;
 Fri, 12 Jun 2026 10:25:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15F5E20040;
 Fri, 12 Jun 2026 10:25:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.57.69])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 10:25:06 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 12 Jun 2026 15:54:58 +0530
Message-Id: <20260612102502.24071-5-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260612102502.24071-1-sachinp@linux.ibm.com>
References: <20260612102502.24071-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX4pdbMyCnnjsx
 TED6CzqzLzds8lJJcuQMiF/hOfRGsBLNJ+kjZRMvsZvOh/gBoN+LeLxd27wb8U9ER5oHuBaIJgr
 yAW9MMxWh3cpUj1ssa3Pp0z+LChX9Dg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfXyHfyZ6E4XPtn
 HwR7KxXUcrA1r3orl61Q9YiR/TzuCbIJIqPBrlUOP3STftxfg5uemt/7M7P7YJi+jRRC1DnOavR
 EBXFuGtKZRYoasi1IKrOgn6P+zbDFk/xyvoWFXexZx+j9/m1J4PThmmAZVs4NFm0BIeQqJNqYvx
 3TMeflka9HyH9sNq4GvckkNxOpeKxD1wZ6gCuHPVs7Zj0f4Ha2YBokccn3NA7Pvleo7NfgbmVm7
 degRLgS6xAW+0BDoXcKc33GcvLfbJhRlJrsB0cJtAbFq2zQF+E0McFzk66H/6WUuOoJQGRTJ1M7
 SkoOV+o8X7p3hlIy6Y9fLaoyVKx6yhUM4NMY8sYq6bEVUVrELDMWRss9HwFzbtYUZWEzJkrajMx
 +QqQcCepktsNf/Wkjp1qRCEWIFOD1pCD+tveLmn3IKoUrtsnTAQ5UfXERFW5QXtsBorGzgRJhho
 ndV/izLTmls9dyJu9OA==
X-Proofpoint-ORIG-GUID: yXoDI-w4tFHoSknICnuVzfEZsmU4sjoZ
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2bde86 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qaZOuUcuEhqKilkFWQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yXoDI-w4tFHoSknICnuVzfEZsmU4sjoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/8] fs/acl: Add default ACL inheritance test
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
YWNoaW4gU2FudCA8c2FjaGlucEBsaW51eC5pYm0uY29tPgotLS0KVjYgY2hhbmdlczoKLSBBZGRl
ZCBIQVZFX1NZU19YQVRUUl9IIGd1YXJkCi0gUmVtb3ZlZCByZWR1bmRhbnQgZXJyb3IgY2hlY2tp
bmcsIHJlbHlpbmcgb24gbGlicmFyeSBmdW5jdGlvbnMKLSBVcGRhdGVkIGFsZ29yaXRobSBkb2N1
bWVudGF0aW9uIHdpdGggY29ycmVjdCBmb3JtYXQKLSB2NSBsaW5rIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2x0cC8yMDI2MDYwODA5MjIwMC45MjgyNy0xLXNhY2hpbnBAbGludXguaWJtLmNvbS9U
LyN0CgpWNSBjaGFuZ2VzOgotIFN3aXRjaCB0byBrZXJuZWwgb25seSB0ZXN0IHZhbGlkYXRpb24g
dG8gcmVtb3ZlIGRlcGVuZGVuY3kgb24gbGliYWNsCiAgYW5kIHVzZXJhZGQvZGVsIGNvbW1hbmRz
LgotIHY0IGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwNjA0MDY1NDE3LjI1
OTI0LTEtc2FjaGlucEBsaW51eC5pYm0uY29tL1QvI3QKClY0IGNoYW5nZXM6Ci0gUmVtb3ZlIHVu
dXNlZMKgYWNsX2dldF9maWxlKCnCoGJsb2NrCi0ga2VlcCBtb2RlLWJpdCB2YWxpZGF0aW9uIHdp
dGggZXhwbGFuYXRvcnkgY29tbWVudAotIHYzIGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bHRwLzIwMjYwNjAzMDY1NzQ0LjQ3MTA2LTEtc2FjaGlucEBsaW51eC5pYm0uY29tL1QvI3QKClYz
IGNoYW5nZXM6Ci0gVXBkYXRlZCBjb3B5cmlnaHQgaGVhZGVyIGFzIHBlciBMVFAgZm9ybWF0Lgot
IHYxIGxpbmsgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwNjAyMTIxOTU4LjI3NDk0
LTEtc2FjaGlucEBsaW51eC5pYm0uY29tL1QvI3QKClYyIGNoYW5nZXM6Ci0gTm8gY2hhbmdlcwoK
VjEgY2hhbmdlczoKLSBVc2UgSEFWRV9MSUJBQ0wgZ3VhcmRzIGluIC5jIGNvZGUKLSBSZXBvcnQg
VENPTkYgd2hlbiBsaWJhY2wgaXMgbm90IGF2YWlsYWJsZQotIHJmYyBsaW5rIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2x0cC80Nzc4MzZmZC04MGM4LTQxNjgtYmZlNi0wMGIzNzRiYjI1MzRAbGlu
dXguaWJtLmNvbS9ULyN0CgotLS0KIHJ1bnRlc3QvZnMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdub3JlICAgICAgfCAg
IDEgKwogdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jIHwgMTEzICsrKysr
KysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMTUgaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvZnMvYWNsL2FjbF9pbmhlcml0MDEu
YwoKZGlmZiAtLWdpdCBhL3J1bnRlc3QvZnMgYi9ydW50ZXN0L2ZzCmluZGV4IGYyNTQ4N2EzMy4u
ZmQyOTVlZGM3IDEwMDY0NAotLS0gYS9ydW50ZXN0L2ZzCisrKyBiL3J1bnRlc3QvZnMKQEAgLTky
LDMgKzkyLDQgQEAgc3F1YXNoZnMwMSBzcXVhc2hmczAxCiBhY2xfdXNlcl9vYmowMSBhY2xfdXNl
cl9vYmowMQogYWNsX21hc2swMSBhY2xfbWFzazAxCiBhY2xfb3RoZXIwMSBhY2xfb3RoZXIwMQor
YWNsX2luaGVyaXQwMSBhY2xfaW5oZXJpdDAxCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L2ZzL2FjbC8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvLmdpdGlnbm9yZQpp
bmRleCBjM2VjMGZhZDMuLmJjMDNiYTFmZCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9m
cy9hY2wvLmdpdGlnbm9yZQorKysgYi90ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbC8uZ2l0aWdub3Jl
CkBAIC0xLDMgKzEsNCBAQAogL2FjbF91c2VyX29iajAxCiAvYWNsX21hc2swMQogL2FjbF9vdGhl
cjAxCisvYWNsX2luaGVyaXQwMQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wv
YWNsX2luaGVyaXQwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5j
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uNWFmOTZiOTEyCi0tLSAvZGV2
L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2wvYWNsX2luaGVyaXQwMS5jCkBAIC0w
LDAgKzEsMTEzIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cgorLyoKKyAqIENvcHlyaWdodCAoYykgMjAyNiBJQk0KKyAqCisgKiBPcmlnaW5hbCBzaGVsbCB0
ZXN0IGJ5IEthaSBaaGFvIChsdGNkM0Bjbi5pYm0uY29tKQorICogQ29udmVydGVkIHRvIEMgYnkg
U2FjaGluIFNhbnQgPHNhY2hpbnBAbGludXguaWJtLmNvbT4KKyAqLworCisvKlwKKyAqIFRlc3Qg
ZGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2UgdXNpbmcgZGlyZWN0IHhhdHRyIG1hbmlwdWxhdGlvbi4K
KyAqCisgKiBWZXJpZnkgdGhhdCBmaWxlcyBjcmVhdGVkIGluIGEgZGlyZWN0b3J5IHdpdGggZGVm
YXVsdCBBQ0xzIGluaGVyaXQKKyAqIHRob3NlIEFDTHMgYXMgdGhlaXIgYWNjZXNzIEFDTHMuIERl
ZmF1bHQgQUNMcyBhcmUgb25seSBhcHBsaWNhYmxlCisgKiB0byBkaXJlY3RvcmllcyBhbmQgZGVm
aW5lIHRoZSBhY2Nlc3MgQUNMcyB0aGF0IGZpbGVzIGFuZCBzdWJkaXJlY3RvcmllcworICogY3Jl
YXRlZCB3aXRoaW4gdGhhdCBkaXJlY3Rvcnkgd2lsbCBpbmhlcml0LgorICoKKyAqIFRoaXMgdGVz
dCB1c2VzIGFyYml0cmFyeSBVSURzIHdpdGhvdXQgY3JlYXRpbmcgYWN0dWFsIHVzZXJzLCB0ZXN0
aW5nCisgKiBvbmx5IHRoZSBrZXJuZWwgQUNMIGltcGxlbWVudGF0aW9uLgorICoKKyAqIFtBbGdv
cml0aG1dCisgKgorICogLSBTZXQgZGVmYXVsdCBBQ0wgb24gcGFyZW50IGRpcmVjdG9yeSB3aXRo
IHJlYWQtb25seSBwZXJtaXNzaW9ucworICogLSBDcmVhdGUgYSBuZXcgZmlsZSBpbiB0aGF0IGRp
cmVjdG9yeSB3aXRoIHVtYXNrIDAKKyAqIC0gVmVyaWZ5IHRoZSBmaWxlIGluaGVyaXRzIHRoZSBk
ZWZhdWx0IEFDTCBhcyBpdHMgYWNjZXNzIEFDTAorICogLSBDaGVjayB0aGF0IGZpbGUgcGVybWlz
c2lvbnMgbWF0Y2ggdGhlIGluaGVyaXRlZCBBQ0wgKDA0NDQpCisgKi8KKworI2luY2x1ZGUgImFj
bF9saWIuaCIKKworI2lmZGVmIEhBVkVfU1lTX1hBVFRSX0gKKworI2RlZmluZSBURVNUX1VJRCAx
MDAwCisjZGVmaW5lIFRFU1RfR0lEIDEwMDAKKworc3RhdGljIHZvaWQgcnVuKHZvaWQpCit7CisJ
c3RydWN0IGFjbCAqYWNsOworCXN0cnVjdCBzdGF0IHN0OworCisJdHN0X3JlcyhUSU5GTywgIlRl
c3RpbmcgZGVmYXVsdCBBQ0wgaW5oZXJpdGFuY2UiKTsKKwlyZXNldF90ZXN0X3BhdGgoKTsKKwor
CVNBRkVfQ0hPV04oVEVTVERJUiwgVEVTVF9VSUQsIFRFU1RfR0lEKTsKKworCWFjbCA9IGFjbF9p
bml0KCk7CisKKwlhY2xfYWRkX2VudHJ5KGFjbCwgQUNMX1VTRVJfT0JKLCBBQ0xfUkVBRCwgMCk7
CisJYWNsX2FkZF9lbnRyeShhY2wsIEFDTF9HUk9VUF9PQkosIEFDTF9SRUFELCAwKTsKKwlhY2xf
YWRkX2VudHJ5KGFjbCwgQUNMX09USEVSLCBBQ0xfUkVBRCwgMCk7CisKKwlpZiAoYWNsX3NldF9m
aWxlKFRFU1RESVIsIEFDTF9UWVBFX0RFRkFVTFQsIGFjbCkgPCAwKSB7CisJCWlmIChlcnJubyA9
PSBFT1BOT1RTVVBQKSB7CisJCQlhY2xfZnJlZShhY2wpOworCQkJdHN0X2JyayhUQ09ORiB8IFRF
UlJOTywgIkFDTCBub3Qgc3VwcG9ydGVkIik7CisJCX0KKwkJYWNsX2ZyZWUoYWNsKTsKKwkJdHN0
X2JyayhUQlJPSyB8IFRFUlJOTywgIkFDTCBzZXR1cCBmYWlsZWQiKTsKKwl9CisKKwlhY2xfZnJl
ZShhY2wpOworCisJY3JlYXRlX3dpdGhfdW1hc2tfYXMoVEVTVF9VSUQsIFRFU1RfR0lELCAwNjY2
LCAwLCAwKTsKKworCVNBRkVfU1RBVChURVNURklMRSwgJnN0KTsKKworCS8qCisJICogRm9yIGEg
bWluaW1hbCBBQ0wgKGNvbnRhaW5pbmcgb25seSBBQ0xfVVNFUl9PQkosIEFDTF9HUk9VUF9PQkos
CisJICogYW5kIEFDTF9PVEhFUiksIHRoZSBtb2RlIGJpdHMgYXJlIHRoZSBjYW5vbmljYWwgcmVw
cmVzZW50YXRpb24uCisJICogVmVyaWZ5aW5nIHRoZSBtb2RlIGJpdHMgY29uZmlybXMgdGhlIGlu
aGVyaXRlZCBBQ0wgd2FzIGFwcGxpZWQuCisJICovCisJaWYgKChzdC5zdF9tb2RlICYgMDc3Nykg
IT0gMDQ0NCkgeworCQl0c3RfcmVzKFRGQUlMLAorCQkJIkZpbGUgcGVybWlzc2lvbnMgMCVvLCBl
eHBlY3RlZCAwNDQ0IGZyb20gZGVmYXVsdCBBQ0wiLAorCQkJc3Quc3RfbW9kZSAmIDA3NzcpOwor
CQljbGVhbnVwX3Rlc3RmaWxlKCk7CisJCXJldHVybjsKKwl9CisKKwljbGVhbnVwX3Rlc3RmaWxl
KCk7CisJdHN0X3JlcyhUUEFTUywgIkRlZmF1bHQgQUNMIGluaGVyaXRhbmNlIHdvcmtzIGNvcnJl
Y3RseSIpOworfQorCitzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQoreworCXJlc2V0X3Rlc3RfcGF0
aCgpOworfQorCitzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCit7CisJY2xlYW51cF90ZXN0X3Bh
dGhzKCk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKKwkudGVzdF9hbGwg
PSBydW4sCisJLnNldHVwID0gc2V0dXAsCisJLmNsZWFudXAgPSBjbGVhbnVwLAorCS5uZWVkc19y
b290ID0gMSwKKwkubW91bnRfZGV2aWNlID0gMSwKKwkubW50cG9pbnQgPSBNTlRQT0lOVCwKKwku
Zm9ya3NfY2hpbGQgPSAxLAorCS5maWxlc3lzdGVtcyA9IChzdHJ1Y3QgdHN0X2ZzW10pIHsKKwkJ
ey50eXBlID0gImV4dDIiLCAubW50X2RhdGEgPSAiYWNsIn0sCisJCXsudHlwZSA9ICJleHQzIiwg
Lm1udF9kYXRhID0gImFjbCJ9LAorCQl7LnR5cGUgPSAiZXh0NCIsIC5tbnRfZGF0YSA9ICJhY2wi
fSwKKwkJey50eXBlID0gInhmcyJ9LAorCQl7LnR5cGUgPSAiYnRyZnMifSwKKwkJe30KKwl9Cit9
OworCisjZWxzZQorCVRTVF9URVNUX1RDT05GKCJzeXMveGF0dHIuaCBpcyBub3QgYXZhaWxhYmxl
Iik7CisjZW5kaWYKLS0gCjIuMzkuMQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
