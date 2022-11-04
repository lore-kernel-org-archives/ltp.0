Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749D6C4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:10:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B75F63CB375
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:10:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2EA73CB46B
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:13 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9B12E600AB2
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 07:27:33 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A45U4b2004640;
 Fri, 4 Nov 2022 06:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=+7Kz4K8w8P1Z8TslmYoCTAKhNNGZJ42ENnEsCVgSBZA=;
 b=kdkafGOdjn/AhR14FaYWWIObIJ85eAQHJ6li3I3d6OU8r1tOOszIAqcoK2cn1fm+Q0f7
 FZvi7Qr7DpLUmBfIFFf8Yyx2NaTVpHLyih+BZhU4HgeTP39Gc9AnaZbp25WNivA2aOSO
 NnwZlNKfiFXdCM0tFuPtbn89ycIvajrZNhjuG0YdHnli0DxkUKQLEfUalJN0v9Tyei6c
 EFrZwtJC2ZCMbTQjc478+GPavBlQ/mPUqWivttlGMcv8NHH5vy03A0jl3NZXGK94TgGE
 ox2oqO5ltETjpN3HuRqR94pynLkLS06ulEL4QGCsjhpes+CJTmuyZT3cI4qaNfFA//d7 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphd3g6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:31 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A462QQJ011157;
 Fri, 4 Nov 2022 06:27:31 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphd3g65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A46LEhr009831;
 Fri, 4 Nov 2022 06:27:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06fra.de.ibm.com with ESMTP id 3kguejfe0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A46RPHX5571140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Nov 2022 06:27:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DDEE4C04A;
 Fri,  4 Nov 2022 06:27:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 022B44C040;
 Fri,  4 Nov 2022 06:27:22 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.126.70])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Nov 2022 06:27:21 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 11:57:12 +0530
Message-Id: <20221104062716.615021-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1yBUrFj_IhDQDcSP93onVd1WR1zlvX0b
X-Proofpoint-ORIG-GUID: XqZw-8G0iEitcBt_hHl0C6kC7mJm36z0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=828 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040041
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/4] Hugetlb:Migrating the libhugetlbfs tests
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
v6 -> v7
	1. Removed ppc32 check from makefile, and checked for ppc32
	system at runtime in PATCH[2/4]
	2. Updated the test description in PATCH[2,3,4/4].
	3. Defined macros for Hugepage related strings.

Tarun Sahu (4):
  Hugetlb: Add new tst_test options for hugeltb test support
  Hugetlb: Migrating libhugetlbfs brk_near_huge
  Hugetlb: Migrating libhugetlbfs chunk-overcommit
  Hugetlb: Migrating libhugetlbfs corrupt-by-cow-opt

 include/tst_hugepage.h                        |   7 +
 include/tst_test.h                            |  10 ++
 lib/tst_test.c                                |  32 +++-
 runtest/hugetlb                               |   3 +
 testcases/kernel/mem/.gitignore               |   3 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 140 +++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 146 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  79 ++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   2 +
 9 files changed, 419 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
