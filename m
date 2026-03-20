Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D86C108B919
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9603C3E279D
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:48:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6974E3D067A
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:49 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D92FA1400544
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:47:48 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JLTk493291959; Fri, 20 Mar 2026 12:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=B2GBUjddJOJvp8LlBluKYxAD8Nx/pB9GYGb1gXyXB
 nk=; b=hvFvKVu6QYMrVaPHDeVZCYqTMJ4uif2EsjWKtWua18mwOxPnK/JOlMBme
 ciH6xIOTVyOjDaysP/pPZyLFWKxnHfNVzN6SkYa/Y0qMrHz50yYj64xFAdmdjOKF
 Rhy4g0UbiR65loN57FDoG6FNkvHD9FNgB05mrQEL4nkOc1T0+unQyOoWaiTkbpBM
 o7Fr/DS6VlDmCYn2ffNmEysiLydfXvqtnyzHuJHlXKnZC4+M7f9kyRRvovyXfp9i
 8zV2G4AvNnxejLhsvw2Ix1xp0ocpeJhndCmGyaXakDWPNPZHTzv7UX8S0207cnkL
 NvwYJryutvs5w4rQSQ4OgyrNqwH9A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3danug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K7xZUM028739;
 Fri, 20 Mar 2026 12:47:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkq5j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 12:47:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KCliBG30998848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 12:47:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 155622004E;
 Fri, 20 Mar 2026 12:47:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58FA120040;
 Fri, 20 Mar 2026 12:47:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.5.99])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Mar 2026 12:47:43 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 20 Mar 2026 18:17:39 +0530
Message-Id: <20260320124742.75946-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bd41f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=b8lekoXllzO_O2yKhu4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwMCBTYWx0ZWRfX+DsJx2sn6DnT
 wcVYa6g5eRDI8pCgQkqxm95NRwQMw8upp/61X4txDkN6Rrl/NuhLQ1kt1KcOWkMgziiFG3u+COM
 1HIHA5cz2hE8lBSKFKMZOnf3yRQ69QlgHqojtyyZ4ZaV/3/XlHqPku090w+q1VVm3wgaHZzA3uN
 Xy3goysiMyFn4T45P7fxhg27gCSpw6outmdCxCJ5ORjc8M1CabPbnA3fRrb0oQ5WHWq6WJMqqgL
 Z+VCa4rInmd75nqAcKpZnHyCZ7r/5Q8dTxu5P123vKFurDZIwNVjur0Xh1wzQHB4nB9h9di4pxs
 4GYCxuCLD+GbWy0ZL/SPjWCVQ08Q/D3UbnX0Z2US5zujtQLwP87MJa1eD72PmQ6JxacrhcxP8Ie
 6liE0SRrDR6RjzXRaaQ/haGe9UHlZHcYTWH+T8qfq13ngrEOosQJ0P0DMxSntQWV+OMnFd3KRHO
 tEjufHLYx2kxCpeXKAg==
X-Proofpoint-GUID: Y99Nic1xnh6QRA_vLzf5KTM0-qb9Uo1W
X-Proofpoint-ORIG-GUID: Y99Nic1xnh6QRA_vLzf5KTM0-qb9Uo1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200100
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] io_uring READ(V), WRITE(v) operation tests
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

These patches have been tested successfully on ppc64le
arch (fedora and SLES flavours)

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
Changes from RFC patch series:
- Addressed review comments
- Refactored io_uring01 test to use common code
- Removed git tags
- Link to RFC: https://lore.kernel.org/ltp/20260318110328.52031-1-sachinp@linux.ibm.com/T/#t

Test run:

$ ./kirk -f iouring
....
Connecting to SUT: default

Suite: iouring
--------------
io_uring01: pass  (0.005s)
io_uring02: pass  (0.004s)
io_uring03: pass  (0.004s)
io_uring04: pass  (0.004s)

Execution time: 0.054s

Disconnecting from SUT: default

.....
------------------------
      TEST SUMMARY
------------------------
Suite:   iouring
Runtime: 0.017s
Runs:    4

Results:
    Passed:   23
    Failed:   0
    Broken:   0
    Skipped:  0
    Warnings: 0

Session stopped
$

---

Sachin Sant (3):
  io_uring: Test IORING READ and WRITE operations
  io_uring: Test READV and WRITEV operations
  io_uring: Refactor io_uring01 to use common code

 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/io_uring/.gitignore |   2 +
 .../kernel/syscalls/io_uring/io_uring01.c     | 111 +++-----
 .../kernel/syscalls/io_uring/io_uring03.c     | 130 +++++++++
 .../kernel/syscalls/io_uring/io_uring04.c     | 231 +++++++++++++++
 .../syscalls/io_uring/io_uring_common.h       | 265 ++++++++++++++++++
 6 files changed, 665 insertions(+), 76 deletions(-)
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring03.c
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring04.c
 create mode 100644 testcases/kernel/syscalls/io_uring/io_uring_common.h

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
