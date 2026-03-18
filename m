Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0684F103E163
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:03:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2A6C3E238A
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:03:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D8AA3C2A00
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:03:36 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 990FB1000DD5
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:03:35 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IA4FK21196137
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=JmihQKv0A5Bo+srTMmdi4GMv0MM+A+R1qXpx8kaKw
 Bk=; b=SsBwYkyhfpz4FVOsI1AgrfEr3WbsFpkdFYETh9j9MiAvm7Z4TSj3TMbgw
 pwVxGjXzV+TBKHk+8WqceAA2FGv7W8CxLPcVKjUQTc9oCTOTrOiHeADSF5Wbebt4
 FC0Enrd0mPo1jjU7CO1/kvzrJmX/IAdps8zttxzed1QaT0O6vBUoUP8t3cMsOTeH
 OdbM+gJS3JWGoEKdE3oMkcn0pt9hkIaTotM2L+Ic0F/vPYV9mWHA/Ud6QENrnZcM
 NKWzc4p3Nnd1g67qJfjdSsxGpJNTHauy4fX4YJ+T7lZLUPfiMV1lvqpaeOoU2u8V
 7AkYZwE/q/FiTktdKUKaRM8wESmEw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64smkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I9f8u5028785
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkdmmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62IB3UOn29032928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AC0120063
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C35652004F
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.45.26])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:03:29 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 16:33:26 +0530
Message-Id: <20260318110328.52031-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oi10GNtmEWGS0wVgaD70BqK00YWy6u4F
X-Proofpoint-GUID: oi10GNtmEWGS0wVgaD70BqK00YWy6u4F
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69ba8685 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8 a=9jQOUj5RBP8j_AnpNUoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5MCBTYWx0ZWRfXySevjTPVO5Oo
 MDiJ+S9OjEauKntjH7mWbvivvjCC+U8qzuM95h4w6ydWE6irPZrZU8wlY50NqFuQBL8b4lpXu79
 Yi9le8KPbFr2ZNZTAx1PH4M81WbPoWN9kw+clQIyJcz5rvzXuFw7pcU8cbZkKrIZ53H1LO1VmNl
 amD07zZMJLrjiW1UBPzaB1vqLQC6QtSVz6DXsiZwOuC5+HGB4E80y5SAqHjNO9SciVa6fuDf2Wz
 6A1PicwXde7VEwZaDIaorlpqN1qbX09yw30/xRmq+a+Cy6b1JSBRCzfDBQ4/rXOFK+hTQXJVSve
 nUaXbFUSJeOltskgiKHWuc7w2lQ0xB9rpBakWbCVKVMsJZNivmnhYi6dFnRkXgm9gwe/038+tdp
 xd0TcwwkJ77ej00VqhzA+ORWJUIBhVBU23Q4HC2hRXO0KPzGmvYjHvEkoZva4HUZTpDvnUrTq3Z
 I2jm10i+iI6NyZ8nm/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180090
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] [PATCH 0/2] io_uring READ(V), WRITE(v) operation tests
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch series adds a set of test case to validate
IOURING READ & WRITE (io_uring03), READV & WRITEV (io_uring04)
operations. The patch also adds a common header file to
avoid code duplication.

These patches have been tested successfully on ppc64le
arch (fedora and SLES flavours)

Code is available
at https://github.com/sacsant/ltp/tree/uring_fio

Test run:

$  ./io_uring03
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_io_XN0m3T as tmpdir (tmpfs filesystem)
tst_test.c:2059: TINFO: LTP version: 20210524-3958-g3203be536
......
tst_test.c:1887: TINFO: Overall timeout per run is 0h 00m 30s
io_uring03.c:195: TINFO: Testing IORING_OP_WRITE
io_uring03.c:199: TPASS: IORING_OP_WRITE completed successfully
io_uring03.c:205: TINFO: Testing IORING_OP_READ
io_uring03.c:210: TPASS: IORING_OP_READ completed successfully
io_uring03.c:214: TPASS: Data integrity verified
io_uring03.c:236: TINFO: Testing partial I/O operations
io_uring03.c:247: TPASS: Partial write (first half) succeeded
io_uring03.c:252: TPASS: Partial write (second half) succeeded
io_uring03.c:260: TPASS: Full read after partial writes succeeded
io_uring03.c:264: TPASS: Partial I/O data integrity verified

Summary:
passed   7
failed   0
broken   0
skipped  0
warnings 0
$ ./io_uring04
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_io_ekmpZP as tmpdir (tmpfs filesystem)
tst_test.c:2059: TINFO: LTP version: 20210524-3958-g3203be536
.......
tst_test.c:1887: TINFO: Overall timeout per run is 0h 00m 30s
io_uring04.c:218: TINFO: Testing IORING_OP_WRITEV and IORING_OP_READV
io_uring04.c:226: TINFO: Writing 4096 bytes using 4 vectors
io_uring04.c:230: TPASS: IORING_OP_WRITEV completed successfully
io_uring04.c:235: TINFO: Reading 4096 bytes using 4 vectors
io_uring04.c:239: TPASS: IORING_OP_READV completed successfully
io_uring04.c:258: TPASS: Data integrity verified across all 4 vectors
io_uring04.c:270: TINFO: Testing partial vector operations
io_uring04.c:284: TPASS: Partial IORING_OP_WRITEV (2 vectors) succeeded
io_uring04.c:294: TPASS: Partial IORING_OP_READV (2 vectors) succeeded
io_uring04.c:305: TPASS: Partial vector data integrity verified
io_uring04.c:319: TINFO: Testing vectors with varying sizes
io_uring04.c:352: TPASS: IORING_OP_WRITEV with varying sizes succeeded
io_uring04.c:359: TPASS: IORING_OP_READV with varying sizes succeeded
io_uring04.c:365: TPASS: Varying size vector data integrity verified

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0
$


Sachin Sant (2):
  io_uring: Test IORING READ and WRITE operations
  io_uring: Test READV and WRITEV operations

 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/io_uring/.gitignore |   2 +
 .../kernel/syscalls/io_uring/io_uring03.c     | 145 ++++++++++
 .../kernel/syscalls/io_uring/io_uring04.c     | 248 ++++++++++++++++++
 .../syscalls/io_uring/io_uring_common.h       | 227 ++++++++++++++++
 5 files changed, 624 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring03.c
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring04.c
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring_common.h

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
