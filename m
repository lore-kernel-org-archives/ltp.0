Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A86C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:31:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61A1C3CBA89
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:31:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD1673CBA51
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:31 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5EB6C6002A3
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:29 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BK6DWEg014804; Tue, 20 Dec 2022 06:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=p69rrTSut0LD+A/FFrrcq5hvmERrNbnuY3k7Vlxsi+E=;
 b=U1Yet1qhvcSDWgA5j+E1kXgzpe8ooL3r9t7FnPv6V30PXktnYvfuP0qWtwI8B+c4oiJK
 OFBqfEQGVKwEVFrAhRd93uIZKyRmaGuaKwwcnIqS76LnN2cNxgTWI3OOyTh/YUbRVADG
 68x4tbF3Os0pbgQagfF11Sx16Vzi3KhmKACJeA97lnQ5r4UmRkPiXEe8LwjOkoifb3tF
 HRQGS0SL047s4tKZUlneges1ItQViBCTZjGpWF21ZcMzf52JoF55je7nkt2Svrn+VFED
 3Xi+aTPqx/p8+2GJTJ5GqfjziOadkKB8ZygDSn38YErkz5S9MB3BfZlpnoGT6KpzI49s Sg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mk7kb0e5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJEMPNn025292;
 Tue, 20 Dec 2022 06:31:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mh6ywkhqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BK6VMGU40174034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Dec 2022 06:31:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8901E2004B;
 Tue, 20 Dec 2022 06:31:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46B0920043;
 Tue, 20 Dec 2022 06:31:19 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.42])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Dec 2022 06:31:18 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 12:01:01 +0530
Message-Id: <20221220063109.279007-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gkUb4R6ckFhGrPdYDGl_auGNigxkLzcW
X-Proofpoint-ORIG-GUID: gkUb4R6ckFhGrPdYDGl_auGNigxkLzcW
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=914 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200051
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/8][PART 3] Hugetlb:Migrating the libhugetlbfs
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
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V2:
	1. Added linux bug fix commit tag in testcases.
	2. Asthetics changes in [PATCH 1/8].
Hi,
This patch series is in continuation to part [1] and part [2]
This series include 8 more tests taken from libhugetlbfs.

Background:
Libhugetlbfs is not being maintained actively, and some distro is dropping
support for it. There are some tests that are good for testing hugetlb
functionality in kernel. These patches include tests from libhugetlbfs.

ref:
 1. https://lore.kernel.org/all/20221104162511.28658-1-tsahu@linux.ibm.com/
 2. https://lore.kernel.org/all/20221120191533.164848-1-tsahu@linux.ibm.com/
 3. https://lore.kernel.org/all/20221201120248.139396-1-tsahu@linux.ibm.com/

Tarun Sahu (8):
  Hugetlb: Migrating libhugetlbfs fork-cow
  Hugetlb: Migrating libhugetlbfs huge_at_4GB_normal_below
  Hugetlb: Migrating libhugetlbfs huge_below_4GB_normal_above
  Hugetlb: Migrating libhugetlbfs icache-hygiene
  Hugetlb: Migrating libhugetlbfs madvise_reserve
  Hugetlb: Migrating libhugetlbfs map_high_truncate_2
  Hugetlb: Migrating libhugetlbfs misalign
  Hugetlb: Migrating libhugetlbfs misaligned_offset

 runtest/hugetlb                               |   9 +
 testcases/kernel/mem/.gitignore               |   8 +
 .../kernel/mem/hugetlb/hugefork/Makefile      |  10 +
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  |  92 +++++++
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 126 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 159 ++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  | 243 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  |  83 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  | 103 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  | 153 +++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  | 147 +++++++++++
 12 files changed, 1134 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/Makefile
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
