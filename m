Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F54AC4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 09:50:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE2E03E55EC
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 11:50:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDD423E1CD6
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 11:50:15 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 184231A00816
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 11:50:14 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7CGOr2442765; Thu, 16 Jul 2026 09:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=EqKqjFpnnU+J7hfDIZqfLoDFzy2N
 Yd616dOTHxb6bZc=; b=TevCAo1VSYqKnMoTsd35vVYCC64dYXs6nIkf41EuCLs7
 Gz1IJAWBvy4BWbMg6/whaKReFSfMfOcF48mGKPqP2ukc8cSZWVvCUWJjNWMvwItJ
 B5Lg9oIM1iXRqmW2WulblVXiJSlwSSE/1gwC7PqxMjVvDN2WJW/4qKuwqPA07bGO
 VuNeQyHFVSvFfh715xxyXRcw2KbwLx8qx10jc2n+YAqxbSnUvB4wFo02Kw4iI23E
 c6VYVVr42WsOsNc26v0uzaSP9+VTx8ibO+CWiDuJiULz3AH8yTbUqhL3l+82edTE
 QgxbN8L4GwBmgW81h1nnXL8FUXTsr+B8JoNG7A4YrA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwyd04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 09:50:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G9nhFn009050;
 Thu, 16 Jul 2026 09:50:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qcmcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 09:50:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66G9o78Z27722048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 09:50:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D615F2004B;
 Thu, 16 Jul 2026 09:50:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DF3020043;
 Thu, 16 Jul 2026 09:50:07 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.74.245]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 09:50:07 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 11:50:00 +0200
Message-ID: <20260716095004.92793-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PjOrb0X55jXCCGOJ0wqFoR200q46M17k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX0Us17Kzw9jrd
 wI6olvqllQwz7L9y2Sc1nKVueHrjTkbFXo85y+MFfUQzdydCIMp7Nxj8pmiwKq+R04vjITmrsFo
 z2xKqEilGaTcs8LF7PrG1s7ADbPk3UQtoTYpy1Y2AQ5hk9yOttTpXYHhDcCEV9JhhsYvbVYmFOZ
 iYRk1GNcVxBjI3em4nV5WBHpZEDurCzzFYQkdytBxcdjppBiOHt59IDba5ouGZtwP3rnXAhfwvv
 nN6YPb7MdBHQpfXFdstxwOCLtp1/0AIyndKMe2aJ+EBuVBytlgW7CLsTga6GH1qeTdbjhGWXQ+1
 /qyMTvWXli0WEnXimWvlY9f2+gb0HnLMLZNJc7Zbg8ox6YVomXpwjrtQL/3UfDBMUTF3pz0EnNO
 PuIHuCkp/RUkjkram1DHXzuLcpXLdwbuvnsfsA6R6s0pNSZ09Rj/+cGWtZCZrblbDVOiDS1P3AF
 zutL0rdRTizQJoiAKgQ==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a58a954 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=kYN8gBHYuNCugSRwMhMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PjOrb0X55jXCCGOJ0wqFoR200q46M17k
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX4iJkWA2ZEuaa
 CEzJ7aF1KrzZuOONz/jIZV28myzd82pIm1pRfEKTlIHErX3+NvicIk4VRKSiqAYhs9sX5uji/gc
 Ovvyrxlf9VcW6+ksqwY8Jz9aa39BAXE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160099
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Separate ptrace tests for
 CONFIG_PROC_MEM_FORCE_PTRACE
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
c2UgdGhlIENPTkZJR19QUk9DX01FTV9GT1JDRV9QVFJBQ0UgZW5mb3JjZW1lbnQuCgpWYWxpZGF0
ZWQgb24gczM5MHggd2l0aCBDT05GSUdfUFJPQ19NRU1fRk9SQ0VfUFRSQUNFPXk6CgotIHB0cmFj
ZTEyOiBUUEFTUwotIHB0cmFjZTEzOiBUUEFTUywgMTAwIGl0ZXJhdGlvbnMKCkZvbGxvdy11cCB0
byB0aGUgcHJldmlvdXMgdGhwMDQgcHRyYWNlIG1vZGUgZGlzY3Vzc2lvbjoKaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYwNzA5MTc1OTI3LjI2ODY3Ny0xLWphcG9AbGludXguaWJtLmNv
bS8KCkNoYW5nZXMgaW4gdjI6Ci0gdGhwMDQ6IFJlbW92ZWQgLmZvcmtzX2NoaWxkIGZsYWcgKG5v
dCBuZWVkZWQgd2l0aG91dCBhY3R1YWwgZm9yaykKLSB0aHAwNDogQ2hhbmdlZCBNQVBfU0hBUkVE
IHRvIE1BUF9QUklWQVRFIGZvciBjaGlsZCBzdGF0ZSBtYXBwaW5nCi0gdGhwMDQ6IEFkZGVkIG1p
c3NpbmcgI2luY2x1ZGUgPHN0cmluZy5oPiBmb3IgbWVtc2V0KCkKLSB0aHAwNDogUmVuYW1lZCBz
dHJ1Y3QgY2hpbGRfc3RhdGUg4oaSIHN0cnVjdCB0aHBfc3RhdGUgKG5vIGxvbmdlciB1c2VzIGZv
cmspCi0gdGhwMDQ6IFJlbmFtZWQgY2hpbGQg4oaSIHN0YXRlLCBjaGlsZF9zZXR1cCgpIOKGkiB0
aHBfc2V0dXAoKSwgY2hpbGRfY2xlYW51cCgpIOKGkiB0aHBfY2xlYW51cCgpCi0gcHRyYWNlMTI6
IFJlbW92ZWQgZGVwcmVjYXRlZCBbRGVzY3JpcHRpb25dIGxpbmUgZnJvbSBkb2MgYmxvY2sKLSBw
dHJhY2UxMjogUmVwbGFjZWQgYmFyZSB3cml0ZSgpIHdpdGggVEVTVCgpIG1hY3JvLCB1c2luZyBU
U1RfUkVUL1RTVF9FUlIKLSBwdHJhY2UxMjogQWRqdXN0ZWQgc2V0dXAgY29tbWVudCB0byBjbGFy
aWZ5IHBhZ2UgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UKLSBwdHJhY2UxMzogUmVtb3ZlZCBkZXBy
ZWNhdGVkIFtEZXNjcmlwdGlvbl0gbGluZSBmcm9tIGRvYyBibG9jawotIHB0cmFjZTEzOiBBZGRl
ZCBtaXNzaW5nICNpbmNsdWRlIDxzdHJpbmcuaD4gZm9yIG1lbXNldCgpCi0gQm90aCBwdHJhY2Ug
dGVzdHM6IEFkZGVkIHRvIHJ1bnRlc3Qvc3lzY2FsbHMKCnYxOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNjA3MTQxNTA2MzEuMjUwOTcyLTEtamFwb0BsaW51eC5pYm0uY29tLwoKSmFu
IFBvbGVuc2t5ICgzKToKICB0aHAwNDogU2ltcGxpZnkgdG8gZm9jdXMgb24gQ1ZFLTIwMTctMTAw
MDQwNSByYWNlIHRlc3Qgb25seQogIHB0cmFjZTogYWRkIHRlc3QgZm9yIC9wcm9jL3NlbGYvbWVt
IHdyaXRlIHJlamVjdGlvbgogIHB0cmFjZTogYWRkIHRlc3QgZm9yIC9wcm9jL3BpZC9tZW0gd3Jp
dGVzIHVuZGVyIHB0cmFjZQoKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDIgKwogdGVzdGNhc2VzL2tlcm5lbC9tZW0vdGhwL3RocDA0LmMgICAgICAgICAg
ICB8IDE2NiArKysrKysrKystLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2Uv
LmdpdGlnbm9yZSB8ICAgMiArCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9wdHJh
Y2UxMi5jIHwgIDk2ICsrKysrKysrCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9w
dHJhY2UxMy5jIHwgMjM1ICsrKysrKysrKysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDQ0
OSBpbnNlcnRpb25zKCspLCA1MiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9wdHJhY2UxMi5jCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvcHRyYWNlMTMuYwoKCmJhc2UtY29t
bWl0OiBkMTM5NTI0YjA0ZDM2MGM0ZGFiYWVlNjFhNjA2NmE5YTUyYjBlNDU0CnByZXJlcXVpc2l0
ZS1wYXRjaC1pZDogZmI4ODRmYjg4NDNmZmFkYjU2MzgzMTQyY2EzOWM4ZjNmMmRiODk4ZApwcmVy
ZXF1aXNpdGUtcGF0Y2gtaWQ6IDE2ZmMwMGQzMDJhZWZiZjZmYjE3ZTk3MmE0MzkwMzQxYmZiYjBl
NTAKcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiA2ZTc3ZWYwOWIyMjU5ZGFhZTkxNWY0YTQ4OTViZjA4
NzliN2I3MjExCnByZXJlcXVpc2l0ZS1wYXRjaC1pZDogMWQxM2Y2NzZjMWMxYjliMzdlOTdiMWUx
OGFlNzU2MTFhMzUxNmY5NgpwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDExYjhmMmIxMDIwMjliNDE4
Mzg4OTlmMmE3ODEzMmI1MGNhYzEyYTAKcHJlcmVxdWlzaXRlLXBhdGNoLWlkOiA4MTFlODVkOWE0
MTU4ZjcyNTU5ZGU1ZjU1MWFkOTNmMTA5MzYyYzk2Ci0tCjIuNTUuMAoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
