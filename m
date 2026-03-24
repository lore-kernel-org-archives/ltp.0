Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723DBF532D4
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 05:23:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B01B3E6135
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 06:23:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D1D83C62D0
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:22:49 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4089E601A87
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:22:47 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O2WiLg3679602; Tue, 24 Mar 2026 05:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Yr6z7luNiRzNqXTgYaoIqvPZDWh0QpUaPM6O0i7VN
 Fw=; b=MhzsBu75HByk1PFPXyYr+hJtBKABv7xxytTwsMSv23Ab4b26oHewdl52j
 bS3dcEXpm0nzS5wTjHgTOUfTtO88IbT7gkOvQ6KDssmBv/Meek5Mkg0F3S+XYqVA
 Fka2ETAzF7Q6X27c25tJygxvl7Ne043uCmTqh8tHPDFiU8XMgrUjfwCoU9TW9UBo
 EHhW+4MVCmhNV8df6mqOktKf42kyZhq+0d9V3eYwbcSKTk4G11C7yK1+txtAALA3
 gp7DYWvDEzzBbPFxo3ebm0jB7N1I29pPp55l0AH8nXrVCIDBwV2sxkTx8Fb+KMsy
 IuO+pxSHcPt7Zz/WZpAbLIlXaKCPw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxswwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:22:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O48ZNW011824;
 Tue, 24 Mar 2026 05:22:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk034d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 05:22:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62O5MhXg45679004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 05:22:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A9E82004B;
 Tue, 24 Mar 2026 05:22:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A549420043;
 Tue, 24 Mar 2026 05:22:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.76.226])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 05:22:42 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 24 Mar 2026 10:52:38 +0530
Message-Id: <20260324052241.21455-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c21fa5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8woskG98NBR48u3ySxIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0MiBTYWx0ZWRfX0u0jzwVPlC8k
 dwy16xA/NRCOowonuf4Ypt97MXVVFrqWHJhxR/hyx3dIT1QFKosNEzOCOHvoIVkNMBPpoOJwOZY
 76a9iW8OTL253PUj6LbqAjdLS2CS9ERdj3dDGMNGYHgkJYasBKt7t+T2e07pw8R/LxrdLuJ4d/o
 lopjeoZaDun7/Y+D5uwRlOGronVZJryhATO8XMRLJlnjIqGu1xv3gHkByPOKjTRODrCoWjBxvl8
 iQ8Zz4fKyxJkayENa7Uk1mIjevVXMEtY/R0Mol7qGNxOpiX+JPSBXfxDRpJ7vGVrB/2AvcRSSCo
 zt3I4JO1PBd8E6bmevtPdqd2OuKpDBJ4+jiUI/ppsIkynhp9Gr+Mnt3WPGvVINLi/gu2TDIR1ej
 +1iDFPibYvM0X71imBoToIbJgtPo73VIBtSuUWUQcinSaOkMjCCc/so4AiryizmxwDC/UO0MhK7
 EjFOX38aAbWxt1P78Uw==
X-Proofpoint-GUID: k4tyEzfVgq4g4bskbC5ZNW5sAn_pVgS2
X-Proofpoint-ORIG-GUID: k4tyEzfVgq4g4bskbC5ZNW5sAn_pVgS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240042
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] io_uring READ(V), WRITE(v) operation tests
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

This patch series also refactors existing test io_uring01
to use the common structures and function defined in header.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
V2 changes:
- Use guarded buffer(including iovec) allocation
- Move setup/cleanup code from run to appropriate path
- Add a function to map the OP to the enum name
- Define and use generic cleanup functions
- Add a buffer size 0 in the middle of the iovec
- Simplify setup_io_uring_test to use common code.
- Link to V1: https://lore.kernel.org/ltp/20260320124742.75946-1-sachinp@linux.ibm.com/T/#t

Changes after RFC patch series:
- Addressed review comments
- Refactored io_uring01 test to use common code
- Removed git tags
- Link to RFC: https://lore.kernel.org/ltp/20260318110328.52031-1-sachinp@linux.ibm.com/T/#t

Test run:

$ ./testcases/bin/io_uring03
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_io_o1kf2Z as tmpdir (tmpfs filesystem)
....
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1887: TINFO: Overall timeout per run is 0h 02m 00s
io_uring03.c:62: TINFO: Testing IORING_OP_WRITE
io_uring_common.h:310: TPASS: OP=IORING_OP_WRITE (17) fd=4 buf=0x7fff83b0f000 len=4096 offset=0
io_uring03.c:68: TINFO: Testing IORING_OP_READ
io_uring_common.h:310: TPASS: OP=IORING_OP_READ (16) fd=4 buf=0x7fff83aef000 len=4096 offset=0
io_uring03.c:40: TPASS: Basic I/O data integrity verified
io_uring03.c:83: TINFO: Testing partial I/O operations
io_uring_common.h:310: TPASS: OP=IORING_OP_WRITE (17) fd=4 buf=0x7fff83b0f000 len=2048 offset=0
io_uring_common.h:310: TPASS: OP=IORING_OP_WRITE (17) fd=4 buf=0x7fff83b0f800 len=2048 offset=2048
io_uring_common.h:310: TPASS: OP=IORING_OP_READ (16) fd=4 buf=0x7fff83aef000 len=4096 offset=0
io_uring03.c:40: TPASS: Partial I/O data integrity verified

.....
ltcden8-lp8:/opt/ltp # ./testcases/bin/io_uring04
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_io_reAIwJ as tmpdir (tmpfs filesystem)
......
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1887: TINFO: Overall timeout per run is 0h 02m 00s
io_uring04.c:102: TINFO: Testing IORING_OP_WRITEV and IORING_OP_READV
io_uring04.c:106: TINFO: Writing 4096 bytes using 4 vectors
io_uring_common.h:326: TPASS: OP=IORING_OP_WRITEV (02) fd=4 iovs=0x7fffb832ffc0 nvecs=4 offset=0 expected_size=4096
io_uring04.c:112: TINFO: Reading 4096 bytes using 4 vectors
io_uring_common.h:326: TPASS: OP=IORING_OP_READV (01) fd=4 iovs=0x7fffb7bcffc0 nvecs=4 offset=0 expected_size=4096
io_uring04.c:92: TPASS: Basic vectored I/O: data integrity verified across 4 vectors
io_uring04.c:126: TINFO: Testing partial vector operations
io_uring_common.h:326: TPASS: OP=IORING_OP_WRITEV (02) fd=4 iovs=0x7fffb832ffc0 nvecs=2 offset=0 expected_size=2048
io_uring_common.h:326: TPASS: OP=IORING_OP_WRITEV (02) fd=4 iovs=0x7fffb832ffe0 nvecs=2 offset=2048 expected_size=2048
io_uring_common.h:326: TPASS: OP=IORING_OP_READV (01) fd=4 iovs=0x7fffb7bcffc0 nvecs=4 offset=0 expected_size=4096
io_uring04.c:92: TPASS: Partial vector I/O: data integrity verified across 4 vectors
io_uring04.c:154: TINFO: Testing vectors with varying sizes including zero-length buffer
io_uring_common.h:326: TPASS: OP=IORING_OP_WRITEV (02) fd=4 iovs=0x7fffb7b2ffc0 nvecs=4 offset=0 expected_size=1792
io_uring_common.h:326: TPASS: OP=IORING_OP_READV (01) fd=4 iovs=0x7fffb7aaffc0 nvecs=4 offset=0 expected_size=1792
io_uring04.c:92: TPASS: Varying size vector I/O with zero-length buffer: data integrity verified across 4 vectors

.....
$

---

Sachin Sant (3):
  io_uring: Test IORING READ and WRITE operations
  io_uring: Test READV and WRITEV operations
  io_uring: Refactor io_uring01 to use common code

 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/io_uring/.gitignore |   2 +
 .../kernel/syscalls/io_uring/io_uring01.c     | 145 ++-------
 .../kernel/syscalls/io_uring/io_uring03.c     | 140 +++++++++
 .../kernel/syscalls/io_uring/io_uring04.c     | 216 ++++++++++++++
 .../syscalls/io_uring/io_uring_common.h       | 278 ++++++++++++++++++
 6 files changed, 660 insertions(+), 123 deletions(-)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring03.c
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring04.c
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring_common.h

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
