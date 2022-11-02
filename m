Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAD3C433FE
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 11:49:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FD953CACBB
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 12:49:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 336EB3CA6D1
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 12:49:39 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 647BF10007F3
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 12:49:37 +0100 (CET)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Bk1To021957;
 Wed, 2 Nov 2022 11:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=JjF08hkfoC3AswpqXHMPng2+wHugfvcolCtHJSWuYxE=;
 b=oxL1+X/1AsjkKuHFQjZPVaUuMtSOK29rPT0eBv63X+Rw019kkkzKsHWgdQYwnac6FWxP
 NuES/PtgOwRfNx1KOTNwUPc8S8/Po1FK0idOeaiqwxE9KO2Dulp5saej39RWVF4bmbD7
 A53ZJBe6iGBSw82b7hxAorp8jyVAvYvHo2+lMhi6/65ZgpBgnLqqSZBYgxodXC2NWrn1
 5CSdKGKmtX8HmIVFnTQKOJ6JEq4NOwyHPYEfMwm1orwpZ6RSp9hEZM+fBNlYo6PsOM3A
 l5HeCvFobH1LrG5INNssubXufBIQj4/i1Y/OkCGJaSBr7Yop4VWf0qBurGPYcf3VZIZq Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkmqfptxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:49:36 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A286E5S001424;
 Wed, 2 Nov 2022 11:49:35 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkmqfptwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:49:34 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2BZRPC018265;
 Wed, 2 Nov 2022 11:49:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04fra.de.ibm.com with ESMTP id 3kgut8w0dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:49:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A2BnTUg590400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Nov 2022 11:49:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C2B7A405B;
 Wed,  2 Nov 2022 11:49:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1EE2A4054;
 Wed,  2 Nov 2022 11:49:25 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  2 Nov 2022 11:49:25 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  2 Nov 2022 17:19:19 +0530
Message-Id: <20221102114923.447871-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dyclEDvVXkwtIZ12vfTZ9Pi0uj811WtP
X-Proofpoint-ORIG-GUID: CQ4aKX3Ox2_lnqciWkXW2dQChD35DvsY
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=668 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020070
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/4] Hugetlb:Migrating the libhugetlbfs tests
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

Tarun Sahu (4):
  Hugetlb: Add new tst_test options for hugeltb test support
  Hugetlb: Migrating libhugetlbfs brk_near_huge
  Hugetlb: Migrating libhugetlbfs chunk-overcommit
  Hugetlb: Migrating libhugetlbfs corrupt-by-cow-opt

 include/tst_test.h                            |  11 ++
 lib/tst_test.c                                |  41 ++++-
 runtest/hugetlb                               |   3 +
 testcases/kernel/mem/.gitignore               |   3 +
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   5 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 138 ++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 148 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  80 ++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   3 +
 9 files changed, 427 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
