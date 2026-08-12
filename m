Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D24C5CFCF
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:30:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32F003DAD38
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:30:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9788A3DAEFC
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:12 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C1047200392
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:29:11 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB3Pqi1433797; Wed, 12 Aug 2026 13:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=TgRdamc0g9qLAg/w+GwSJ+L545Yd
 9VO9h3ZRdV2v+XU=; b=W4nCzZ9ZjUocr+WR/ip7NeK3T/DOxVMA9Wg9ggQ/1RIn
 mH59B+8AC7BMtgrRT9DlpoTXa5oJUm3SQvU2shSMyYVeY/gkB8irprwa85oOiroa
 7hsTm3eoZtv87IVSYIZS5ljP3kR/S78jUSoD6H89CGztkvR1Wejz53bYDJsMmvFG
 Rr2Nu8EwMMqeeHeb7niBCr8V3xu+ZacBwNYtNKoMJ6KqwBbqhB/gYt1mfQZXh+ge
 xTNbLDJaP0VJm5HhABPws/UnrqqGtanY20kKOdfzgmdY7V/CF7FSo4NZJG1Bg9iz
 etpVYeMZKzVcXxX8qS/xNKs+6c6NRGyeT3pZlpee9g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk02kuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDQLe1003734;
 Wed, 12 Aug 2026 13:29:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjx5pt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 13:29:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CDT4o834800000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 13:29:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3210220043;
 Wed, 12 Aug 2026 13:29:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF42B20040;
 Wed, 12 Aug 2026 13:29:03 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.155.95]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 13:29:03 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 12 Aug 2026 15:28:56 +0200
Message-ID: <20260812132901.202632-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfXxMKxA8OKrcGa
 xArGlkGMTJHrzHFGUvVoVCcyynMjQeuFUT4/JqAZbYX/JjWJj9OW635fFS+4zM7C2ly2Iu8S+/5
 rcQdXxMPEnBpXJEw4qN4xRsl2F5kNsvWWxTWRYjQk2E/tQAClpfvxi8Kyv74piPAKP7zDcyYzQU
 mXpp7/Xx+JpY7JqUwzeYspc7FdxfHqznZGIXhDKe0VP8YMDhkYx4GuRHceTjXMBG84Zl54Yi3ko
 5iOWeDRJ/m+oS+XUXe2jQ9p/KMcW+xt2HZ1DKBn4a+2MtI1eU88QXh+ORRe4oMkrLsmB766Lld8
 AwVkcIOyljc1LZ5uu7q0AK1LFUT9UQlp2X7nQxCehrrenOCIKAz+JIiMuExrVNZOY1yM1LQGffa
 +em3lm+vzUTtxNmnn6iRNPlpR0FoMZnR/Ord+fJJS2UGJ5YbGo/5PLQ+ieTjuYDhhr10ljRoSAR
 ItewUcqAe3TOxjQh7pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX6O1fUXfH4rDy
 pbcJWUY2OPZe5eOWPKnkQuVjEtsYYmZgfmgKXjgodcqsY413q9oKVm3dv0Mt3ZcvChpiCL+69MN
 hBfbqnhITXJs0ZAMxagajakrNjcK5nI=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c7525 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sJC30AaRGQGFaD_2Be8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S0U_9apeLQEjCThV6AogK_2gEl48RQyW
X-Proofpoint-ORIG-GUID: S0U_9apeLQEjCThV6AogK_2gEl48RQyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120106
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] Handle FORCE_PTRACE in thp04 and add ptrace
 coverage
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

dGhwMDQgaXMgYSBDVkUtMjAxNy0xMDAwNDA1IHJlZ3Jlc3Npb24gdGVzdC4gSWYgZGlyZWN0Ci9w
cm9jL3NlbGYvbWVtIHdyaXRlcyBhcmUgYmxvY2tlZCBieSBDT05GSUdfUFJPQ19NRU1fRk9SQ0Vf
UFRSQUNFPXksCnRoZSBDVkUgY2Fubm90IGJlIHRyaWdnZXJlZCBhbmQgdGhwMDQgc2hvdWxkIHJl
cG9ydCBUQ09ORi4KCkFkZCBzZXBhcmF0ZSBwdHJhY2UgdGVzdHMgZm9yIHRoZSBDT05GSUdfUFJP
Q19NRU1fRk9SQ0VfUFRSQUNFIGJlaGF2aW9yCmluc3RlYWQ6CgotIHB0cmFjZTEyIGNoZWNrcyB0
aGF0IHdyaXRpbmcgdG8gL3Byb2Mvc2VsZi9tZW0gaXMgcmVqZWN0ZWQgd2l0aCBFSU8uCi0gcHRy
YWNlMTMgY2hlY2tzIHRoYXQgYSBwYXJlbnQgY2FuIHdyaXRlIHRvIGEgdHJhY2VkIGNoaWxkJ3Mg
bWVtb3J5IHZpYQogIC9wcm9jL3BpZC9tZW0uCgpCb3RoIHB0cmFjZSB0ZXN0cyB1c2UgcmVhZC1v
bmx5IG1hcHBpbmdzLCBzbyB0aGUgd3JpdGVzIHJlcXVpcmUKRk9MTF9GT1JDRSBhbmQgZXhlcmNp
c2UgdGhlIENPTkZJR19QUk9DX01FTV9GT1JDRV9QVFJBQ0UgZW5mb3JjZW1lbnQuCgpUZXN0ZWQg
b24gczM5MHggd2l0aCBDT05GSUdfUFJPQ19NRU1fRk9SQ0VfUFRSQUNFPXk6CgotIHRocDA0OiBU
Q09ORiAoZGlyZWN0IC9wcm9jL3NlbGYvbWVtIHdyaXRlcyBibG9ja2VkKQotIHB0cmFjZTEyOiBU
UEFTUwotIHB0cmFjZTEzOiBUUEFTUywgMTAwIGl0ZXJhdGlvbnMKCkZvbGxvdy11cCB0byB0aGUg
cHJldmlvdXMgdGhwMDQgcHRyYWNlIG1vZGUgZGlzY3Vzc2lvbjoKaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjYwNzA5MTc1OTI3LjI2ODY3Ny0xLWphcG9AbGludXguaWJtLmNvbS8KCkNo
YW5nZXMgaW4gdjQ6Ci0gdGhwMDQ6IHByb3ZlIHRoZSAvcHJvYy9zZWxmL21lbSBwcm9iZSBjaGFu
Z2VzIG1lbW9yeSBiZWZvcmUgcnVubmluZyB0aGUgcmFjZQotIHRocDA0OiB0aWdodGVuIGRpcmVj
dC13cml0ZSByZXN1bHQgaGFuZGxpbmcgYW5kIGRvY3VtZW50IGJsb2NrZWQtd3JpdGUgYmVoYXZp
b3IKLSBwdHJhY2UxMjogZ2F0ZSB0aGUgdGVzdCBvbiBDT05GSUdfUFJPQ19NRU1fRk9SQ0VfUFRS
QUNFPXkKLSBwdHJhY2UxMjogdHJlYXQgc3VjY2Vzc2Z1bCAvcHJvYy9zZWxmL21lbSB3cml0ZXMg
YXMgVEZBSUwgdW5kZXIgdGhlIHJlcXVpcmVkIGNvbmZpZwotIHB0cmFjZTEzOiB1c2UgYSB0cmFj
ZXItY29udHJvbGxlZCBQVFJBQ0VfSU5URVJSVVBUIGluaXRpYWwgc3RvcAotIHB0cmFjZTEzOiBm
aXggdGhlIGl0ZXJhdGlvbiBkaWFnbm9zdGljIGFuZCBjbGVhbiB1cCB3YWl0LXN0YXR1cyBoYW5k
bGluZwotIHB0cmFjZTEzOiB1c2UgUFRSQUNFX0tJTEwgZm9yIG5vcm1hbCB0ZXJtaW5hdGlvbgoK
Q2hhbmdlcyBpbiB2MzoKLSBBbGwgcGF0Y2hlczogRml4ZWQgUlNUIGRvYyBmb3JtYXR0aW5nIChh
ZGRlZCBibGFuayBsaW5lcyBiZWZvcmUgbGlzdHMpCi0gQWxsIHBhdGNoZXM6IFJlbW92ZWQgcmVk
dW5kYW50IGNvbW1lbnRzIHBlciBMVFAgY29kaW5nIHN0eWxlCi0gdGhwMDQ6IFJlbW92ZWQgY29t
bWVudHMgcmVzdGF0aW5nIHBvaW50ZXIgYXJpdGhtZXRpYwotIHB0cmFjZTEyOiBLZXB0IG9ubHkg
aW50ZW50LWZvY3VzZWQgRk9MTF9GT1JDRSBjb21tZW50Ci0gcHRyYWNlMTM6IFJlbW92ZWQgdW51
c2VkIHNoYXJlZF9zdGF0ZS5yZXN1bHQgZmllbGQKLSBwdHJhY2UxMzogUmVtb3ZlZCBtaXNsZWFk
aW5nICJwcmV2aW91cyBpdGVyYXRpb24iIGNvbW1lbnQKLSBwdHJhY2UxMzogQ2xhcmlmaWVkIGl0
ZXJhdGlvbiBjb3VudGVyIGluIFRGQUlMIG1lc3NhZ2UgdG8gc2hvdyB3aGljaCB3cml0ZSBpcyBi
ZWluZyB2ZXJpZmllZAotIHB0cmFjZTEzOiBLZXB0IG9ubHkgaW50ZW50LWZvY3VzZWQgRk9MTF9G
T1JDRSBjb21tZW50IGFuZCBzeW5jaHJvbml6YXRpb24gcGF0dGVybiBjb21tZW50CgpDaGFuZ2Vz
IGluIHYyOgotIHRocDA0OiBSZW1vdmVkIC5mb3Jrc19jaGlsZCBmbGFnIChub3QgbmVlZGVkIHdp
dGhvdXQgYWN0dWFsIGZvcmspCi0gdGhwMDQ6IENoYW5nZWQgTUFQX1NIQVJFRCB0byBNQVBfUFJJ
VkFURSBmb3IgY2hpbGQgc3RhdGUgbWFwcGluZwotIHRocDA0OiBBZGRlZCBtaXNzaW5nICNpbmNs
dWRlIDxzdHJpbmcuaD4gZm9yIG1lbXNldCgpCi0gdGhwMDQ6IFJlbmFtZWQgc3RydWN0IGNoaWxk
X3N0YXRlIOKGkiBzdHJ1Y3QgdGhwX3N0YXRlIChubyBsb25nZXIgdXNlcyBmb3JrKQotIHRocDA0
OiBSZW5hbWVkIGNoaWxkIOKGkiBzdGF0ZSwgY2hpbGRfc2V0dXAoKSDihpIgdGhwX3NldHVwKCks
IGNoaWxkX2NsZWFudXAoKSDihpIgdGhwX2NsZWFudXAoKQotIHB0cmFjZTEyOiBSZW1vdmVkIGRl
cHJlY2F0ZWQgW0Rlc2NyaXB0aW9uXSBsaW5lIGZyb20gZG9jIGJsb2NrCi0gcHRyYWNlMTI6IFJl
cGxhY2VkIGJhcmUgd3JpdGUoKSB3aXRoIFRFU1QoKSBtYWNybywgdXNpbmcgVFNUX1JFVC9UU1Rf
RVJSCi0gcHRyYWNlMTI6IEFkanVzdGVkIHNldHVwIGNvbW1lbnQgdG8gY2xhcmlmeSBwYWdlIGlu
aXRpYWxpemF0aW9uIHNlcXVlbmNlCi0gcHRyYWNlMTM6IFJlbW92ZWQgZGVwcmVjYXRlZCBbRGVz
Y3JpcHRpb25dIGxpbmUgZnJvbSBkb2MgYmxvY2sKLSBwdHJhY2UxMzogQWRkZWQgbWlzc2luZyAj
aW5jbHVkZSA8c3RyaW5nLmg+IGZvciBtZW1zZXQoKQotIEJvdGggcHRyYWNlIHRlc3RzOiBBZGRl
ZCB0byBydW50ZXN0L3N5c2NhbGxzCgp2MzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjYwNzIxMjAyNDUyLjMxNTU4MS0xLWphcG9AbGludXguaWJtLmNvbS8KdjI6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcxNjA5NTAwNC45Mjc5My0xLWphcG9AbGludXguaWJtLmNv
bS8KdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcxNDE1MDYzMS4yNTA5NzIt
MS1qYXBvQGxpbnV4LmlibS5jb20vCgpKYW4gUG9sZW5za3kgKDMpOgogIHRocDA0OiBncm91cCBy
dW50aW1lIHN0YXRlIGFuZCBza2lwIHdoZW4gL3Byb2Mvc2VsZi9tZW0gd3JpdGVzIGFyZQogICAg
YmxvY2tlZAogIHB0cmFjZTogYWRkIHRlc3QgZm9yIC9wcm9jL3NlbGYvbWVtIHdyaXRlIHJlamVj
dGlvbgogIHB0cmFjZTogYWRkIHRlc3QgZm9yIC9wcm9jL3BpZC9tZW0gd3JpdGVzIHVuZGVyIHB0
cmFjZQoKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIg
KwogdGVzdGNhc2VzL2tlcm5lbC9tZW0vdGhwL3RocDA0LmMgICAgICAgICAgICB8IDE3OSArKysr
KysrKysrKystLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvLmdpdGlnbm9y
ZSB8ICAgMiArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9wdHJhY2UxMi5jIHwg
IDk1ICsrKysrKysrKwogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvcHRyYWNlMTMu
YyB8IDIwMiArKysrKysrKysrKysrKysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCA0MjggaW5zZXJ0
aW9ucygrKSwgNTIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9wdHJhY2UvcHRyYWNlMTIuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3B0cmFjZTEzLmMKCgpiYXNlLWNvbW1pdDogMGI2
OTU1MGUwNTViNTM4NTgyMmYwMDFlMmEyN2ZlZGZiZWYzMTgxNgpwcmVyZXF1aXNpdGUtcGF0Y2gt
aWQ6IDQ3OGU2YmU2NDZmNDcxN2UwODRkZDFlZWMxODc2NjViODU0ZWEwMjgKcHJlcmVxdWlzaXRl
LXBhdGNoLWlkOiAxNmZjMDBkMzAyYWVmYmY2ZmIxN2U5NzJhNDM5MDM0MWJmYmIwZTUwCnByZXJl
cXVpc2l0ZS1wYXRjaC1pZDogNmU3N2VmMDliMjI1OWRhYWU5MTVmNGE0ODk1YmYwODc5YjdiNzIx
MQpwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDFkMTNmNjc2YzFjMWI5YjM3ZTk3YjFlMThhZTc1NjEx
YTM1MTZmOTYKcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiAxMWI4ZjJiMTAyMDI5YjQxODM4ODk5ZjJh
NzgxMzJiNTBjYWMxMmEwCnByZXJlcXVpc2l0ZS1wYXRjaC1pZDogODExZTg1ZDlhNDE1OGY3MjU1
OWRlNWY1NTFhZDkzZjEwOTM2MmM5NgotLSAKMi41NS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
