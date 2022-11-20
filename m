Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EDBC433FE
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 19:16:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAE1D3CCC9E
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 20:16:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B27573C1BB8
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:50 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CDA101385628
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:47 +0100 (CET)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AKJ7vDa023491; Sun, 20 Nov 2022 19:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=8adQMueKUc6PGDJr4ZO5iymRzLk77RuNmeiQVxvCM78=;
 b=myyPXNQVt4m+xIqDNXj8rNNbIT4HxJ4c3jQanW9JIWtHLOAJDmADI0pe3EbwSsa2eNbA
 xDHB4L9tJe3xvYRC73t7/4bINVNkzLRvU6SzfHro2dxu6PhDqiJDTqEHrIvgWZn+nllA
 CjSr/s5C0dYbmcV1X7KJrTG3HTILj6B4fJDjoL/Qd0ov4W9ZKA+2WtHLuQsXrcQUWwEQ
 KL++leZR8XFZFYJVt2HIcwvVqCsL3WOrh4Tk7SsnmR3BsMKysOY7FypX5ybShNVYxVxT
 FY7JcXjtKinYpu6+ho4yd+jSA/AMBHn1MuXx08EPMH40+//XyJ7RVr1efOC0G7QYWdMU Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8yqej24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:45 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKJCIL9003357;
 Sun, 20 Nov 2022 19:15:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8yqej1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:44 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKJ4wjl027639;
 Sun, 20 Nov 2022 19:15:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 3kxpdhsmh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AKJFdRs3342912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Nov 2022 19:15:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECC8752054;
 Sun, 20 Nov 2022 19:15:38 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.36.159])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 974C25204F;
 Sun, 20 Nov 2022 19:15:35 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 00:45:26 +0530
Message-Id: <20221120191533.164848-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n1fAe_5kIN4f0AcupTaMpKHmhzt3QPaY
X-Proofpoint-GUID: 8i9rP7qkQc7oZPbfNArWaUFqJbNzg-JO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211200162
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/7][PART 2] Hugetlb:Migrating the libhugetlbfs
 tests
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
This patch series is in continuation to first part [1]
This series include 5 more tests taken from libhugetlbfs.

Background:
Libhugetlbfs is not being maintained actively, and some distro is dropping
support for it. There are some tests that are good for testing hugetlb
functionality in kernel. These patches include tests from libhugetlbfs.

ref:
 1. https://lore.kernel.org/all/20221104162511.28658-1-tsahu@linux.ibm.com/

v4 -> v5
	1. PATCH[1/7] Removed the srand() call from tst_creat_unlinked.
	2. PATCH[2/7] Reworked on the code. Removed the macro based
	condition check. Added condition check for each function call
	and created a new function for loop action.

v3 -> v4
	1. Removing redundant access call to check if file already exists.
	and removing the retry path, as the case is very rare.

v2 -> v3
	1. Changed from setjmp/longjmp logic to check/return logic in
	hugemmap10.c
	2. Added a new patch to create support for custom flags in
	tst_creat_unlinked api.
	3. Added patch to add safe macros for posix_fadvise call.
	4. Updated coding asthetics.
	5. Added description along with the line of failure in hugemmap10.c

v1 -> v2
	1. Fixed comments

Tarun Sahu (7):
  Hugetlb: Add new argument flags in tst_creat_unlinked
  Hugetlb: Migrating libhugetlbfs counters
  Hugetlb: Migrating libhugetlbfs directio
  Hugetlb: Safe macro for posix_fadvise call
  Hugetlb: Migrating libhugetlbfs fadvise_reserve
  Hugetlb: Migrating libhugetlbfs fallocate_align
  Hugetlb: Migrating libhugetlbfs fallocate_basic

 include/tst_safe_macros.h                     |  17 +
 include/tst_test.h                            |   2 +-
 lib/tst_test.c                                |  16 +-
 runtest/hugetlb                               |   6 +
 testcases/kernel/mem/.gitignore               |   5 +
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  10 +
 .../hugetlb/hugefallocate/hugefallocate01.c   | 169 +++++++
 .../hugetlb/hugefallocate/hugefallocate02.c   |  90 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |   2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |   2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |   2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 462 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  |  87 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  |  84 ++++
 14 files changed, 946 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/Makefile
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
