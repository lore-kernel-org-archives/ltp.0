Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2A8C433FE
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 05:43:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12D443CAD6D
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 06:43:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ACBF3C8AF9
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 06:43:34 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E8FC140013A
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 06:43:31 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A34VeIn020946;
 Thu, 3 Nov 2022 05:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=x8DjsgTKq/Felpnd4QtAHAsH8N8FC5pykiX9lKo4TAQ=;
 b=oPZxNXYMCzSeH9OZRG/KBAI4XdQaOq4mikYBeFl28nZMYWyI80fUmeHdUZ1EOGbpFzXu
 4dpInHIhH22QCQ0Knn4RHw3qv8Jtbs53fx1kAiONmkOV4D2yR5nxJtDuvrYLgjz8t0c5
 5L1ZCXb8ZOC9P600F1JYtWvbtGtotxM48ZIrmdDnN90YRSpOtVIIkPqPKFkWQ0g5Qkbg
 QDLHZxAebHDR5WH5wD/7Y6yWP4ZBdRKGVZTppPRKCujo+jwvs79spc7KEqlB9kgsVamd
 XL8dzQFPnaVuxZ65fRB1Jv99i/cT51r703pYLqJ+Tv+KPjD7iRhzbCHnkaXTX6Tx3x8G kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km6pghpby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:29 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A35cjMk023035;
 Thu, 3 Nov 2022 05:43:28 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km6pghpag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A35ZZ4w010958;
 Thu, 3 Nov 2022 05:43:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 3kguej05bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A35hN2w51970502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Nov 2022 05:43:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EF8D4C04E;
 Thu,  3 Nov 2022 05:43:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2CAD4C040;
 Thu,  3 Nov 2022 05:43:19 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.64.81])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Nov 2022 05:43:19 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  3 Nov 2022 11:13:13 +0530
Message-Id: <20221103054317.499221-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tnp7sIYR33qSAuVRRaZnR8VljPKAfXuu
X-Proofpoint-GUID: Sp73czHWs0KYVsfxSmpUHqkBOcWttNTq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 impostorscore=0 mlxlogscore=742 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030039
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/4] Hugetlb:Migrating the libhugetlbfs tests
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

Hi,
Libhugetlbfs is not being maintained actively, and some distro is dropping
support for it. There are some tests that are good for testing hugetlb
functionality in kernel.

As per previous dicussion in RFC[1], Here, this patch series consists
of hugetlb tests taken from libhugetlbfs modified to work in ltp
environment.

Based on suggestion[2], I am reposting the patches again. Also, I added
suggested changes at [3].

ref:
1:https://lore.kernel.org/all/20220908173947.17956-1-tsahu@linux.ibm.com/
2:https://lore.kernel.org/all/87wn8xi61v.fsf@suse.de/
3:https://lore.kernel.org/all/20221016125731.249078-1-tsahu@linux.ibm.com/

v1 -> v2
	1. In (brk near huge) test [PATCH 1/3] removed unused library
	function test_addr_huge() and read_maps().
v2 -> v3
	1. Added a new patch commit for two new flags "needs_hugetlbfs" &
	"needs_unlinked_hugetlb_file" in tst_test and modified tests to use
	these flags. 
	2. Added taint check in test [PATCH 1/3].
	3. Removed redundant Hopt and nr_opt option.
	4. Corrected pre-processor ARCH based conditional flags in test
	[PATCH 1/3]
v3 -> v4
	1. Removed the needs_unlinked_hugetlb_file option in PATCH[1/4].
	2. Removed the redundant saved_oc_hugepages checks in PATCH[3/4].
	3. Updated the mntpoint checks in PATCH[1/4].
v4 -> v5
	1. Removed the needs_hugetlbfs check from needs_tmpdir function,
	because mntpoint is now mandatory option with needs_hugetlbfs.
	(PATCH[1/4])
v5 -> v6
	1. Edited the comment for needs_hugetlbfs PATCH[1/4].
	2. Changed TCID to tid and removed __func__ from tst_brk PATCH[1/4].
	3. Removed SAFE_UMOUNT in do_cleanup PATCH[1/4].
	4. Added the ARCH definition in Makefile PATCH[2/4].
	5. Removed ALIGN and use LTP_ALIGN PATCH[2/4].

Tarun Sahu (4):
  Hugetlb: Add new tst_test options for hugeltb test support
  Hugetlb: Migrating libhugetlbfs brk_near_huge
  Hugetlb: Migrating libhugetlbfs chunk-overcommit
  Hugetlb: Migrating libhugetlbfs corrupt-by-cow-opt

 include/tst_test.h                            |  10 ++
 lib/tst_test.c                                |  32 +++-
 runtest/hugetlb                               |   3 +
 testcases/kernel/mem/.gitignore               |   3 +
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   6 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 138 ++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 148 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  80 ++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   2 +
 9 files changed, 419 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
