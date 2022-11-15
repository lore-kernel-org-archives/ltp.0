Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCB8C4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 07:09:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD9663CD157
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 08:09:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B01F63C9378
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 08:09:15 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 494AD1400441
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 08:09:13 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AF6bQMJ013531; Tue, 15 Nov 2022 07:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=HXOqUM0h6EeB5Dk5oT0HuI3oPSFUkzsmedWvlldYyHg=;
 b=UuE1+OGM2SL1pS/PPEET9QsEd/inoS5jjCOvxAH52lST3kRCV5a0zlMgB0OuGEhQCiSy
 gqenbgDi0aueLSPSXxFjrdMrQLpTkl14EiLss9h+GOQoEhMNt2bU3ATO9Y3QZbt6s1HW
 XmhJsI/8lj1I239AITTmqBFE6N7hdPg59T6bRP7/tu/C1vsoaKeCe6RkNzyLuTg0tFxj
 Wa8UYpeCkYjF+eNYqqHC8WIqrRosWaw50EcJ5QpFRIL7EHTOdDGjpaTxzTnBVeS0pw9s
 nFkL0bpiH/fSLEcgZtDlM5merGOCn/dRUNh6PfQ9TD9jcXFdlJu/pNcv/ubrCoQj30zL uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv5nrs3v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:11 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AF6xLJJ002448;
 Tue, 15 Nov 2022 07:09:11 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv5nrs3rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AF75rcU004846;
 Tue, 15 Nov 2022 07:09:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06fra.de.ibm.com with ESMTP id 3kt2rj2ubw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Nov 2022 07:09:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AF794585046930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Nov 2022 07:09:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66560AE053;
 Tue, 15 Nov 2022 07:09:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 277AFAE04D;
 Tue, 15 Nov 2022 07:09:02 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 15 Nov 2022 07:09:01 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 15 Nov 2022 12:37:45 +0530
Message-Id: <20221115070752.244461-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j-NNYyj2jhk36zS5HywlpqCCK_kRArNh
X-Proofpoint-ORIG-GUID: 0bY3rVom-Tc22kxiyWYLTZnv7Y59au0j
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=972 priorityscore=1501
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150051
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/7] Hugetlb:Migrating the libhugetlbfs tests
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

ref:
 1. https://lore.kernel.org/all/20221104162511.28658-1-tsahu@linux.ibm.com/

v1 -> v2
	1. Fixed comments
v2 -> v3
	1. Changed from setjmp/longjmp logic to check/return logic in
	hugemmap10.c
	2. Added a new patch to create support for custom flags in
	tst_creat_unlinked api.
	3. Added patch to add safe macros for posix_fadvise call.
	4. Updated coding asthetics.
	5. Added description along with the line of failure in hugemmap10.c

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
 lib/tst_test.c                                |  22 +-
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
 14 files changed, 951 insertions(+), 9 deletions(-)
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
