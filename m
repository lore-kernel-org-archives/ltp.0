Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE770C433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 12:59:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 014D33CAFAE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 14:59:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18F953CAFAA
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:38 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E8211000463
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:36 +0200 (CEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9Yv3x016911
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=y7YcpuYow2T0HK6Em8BRk82zKdzrz6GP1C0onZOSDR4=;
 b=Bs7Pwn88AbOV3EGwYwcXB0OBe9VSVgsqtymvq1Bm9zH7SJ+A3VomyAWjML07QwPTZthu
 B8cFyACKUgwe0yYxNJlz0B67P66+FRQGpAkGMGc8Xcvsmwatt7R4AM2a9u3vbIlDZ8M0
 rHrZUHS1dicb9asn+898pcygnGGQeiCxKNfAenqbDKugr+oRZkKHUw3rpc9zcEzfMV5S
 9+DSCn0gzrOkiid3qBIe9LQ8eb6QiX+K1GdAAhDjcHikyexuKKRmpnfJsdRUw918TzJB
 n5yAUebUZmIcEO/5YMLC8FdOknSNZ11BkdJqkFIzhWdVA738JR8bEPVDxIi0degeWRxB yQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86hjmk28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpCEA010004
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg91kjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCwTBG8585802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:58:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79A4E11C04C;
 Sun, 16 Oct 2022 12:58:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C11D11C04A;
 Sun, 16 Oct 2022 12:58:27 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:27 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:02 +0530
Message-Id: <20221016125731.249078-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CyMgiSLpOVxX4P_r9vdK-aI8ASHGtnpA
X-Proofpoint-ORIG-GUID: CyMgiSLpOVxX4P_r9vdK-aI8ASHGtnpA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=790 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160070
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/29] Hugetlb: Migrating libhugetlbfs tests
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
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
environment. This series do not include all the tests, I
will post another series for the remaining tests soon.

ref:
1: https://lore.kernel.org/all/20220908173947.17956-1-tsahu@linux.ibm.com/

Tarun Sahu (29):
  Hugetlb: Migrating libhugetlbfs brk_near_huge
  Hugetlb: Migrating libhugetlbfs chunk-overcommit
  Hugetlb: Migrating libhugetlbfs corrupt-by-cow-opt
  Hugetlb: Migrating libhugetlbfs counters
  Hugetlb: Migrating libhugetlbfs directio
  Hugetlb: Migrating libhugetlbfs fadvise_reserve
  Hugetlb: Migrating libhugetlbfs fallocate_align
  Hugetlb: Migrating libhugetlbfs fallocate_basic
  Hugetlb: Migrating libhugetlbfs fork-cow
  Hugetlb: Migrating libhugetlbfs huge_at_4GB_normal_below
  Hugetlb: Migrating libhugetlbfs huge_below_4GB_normal_above
  Hugetlb: Migrating libhugetlbfs icache-hygiene
  Hugetlb: Migrating libhugetlbfs madvise_reserve
  Hugetlb: Migrating libhugetlbfs map_high_truncate_2
  Hugetlb: Migrating libhugetlbfs misalign
  Hugetlb: Migrating libhugetlbfs misaligned_offset
  Hugetlb: Migrating libhugetlbfs mlock
  Hugetlb: Migrating libhugetlbfs mmap-cow
  Hugetlb: Migrating libhugetlbfs mmap-gettest
  Hugetlb: Migrating libhugetlbfs mprotect
  Hugetlb: Migrating libhugetlbfs mremap-fixed-huge-near-normal
  Hugetlb: Migrating libhugetlbfs mremap-fixed-normal-near-huge
  Hugetlb: Migrating libhugetlbfs noresv-reserve-resv-page
  Hugetlb: Migrating libhugetlbfs noresv-regarded-as-resv
  Hugetlb: Migrating libhugetlbfs private
  Hugetlb: Migrating libhugetlbfs readahead_reserve
  Hugetlb: Migrating libhugetlbfs readback
  Hugetlb: Migrating libhugetlbfs shared
  Hugetlb: Migrating libhugetlbfs shm-fork

 runtest/hugetlb                               |  31 ++
 testcases/kernel/mem/.gitignore               |  29 ++
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  10 +
 .../hugetlb/hugefallocate/hugefallocate01.c   | 187 +++++++
 .../hugetlb/hugefallocate/hugefallocate02.c   | 116 +++++
 .../kernel/mem/hugetlb/hugefork/Makefile      |  10 +
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  | 220 ++++++++
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 196 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 163 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 173 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  | 102 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 475 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 111 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  | 114 +++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 160 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 204 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  | 250 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  | 112 +++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  | 126 +++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  | 173 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  | 166 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  | 108 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  | 222 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  | 170 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  | 283 +++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  | 168 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  | 148 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  | 166 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  | 107 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 129 +++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  | 120 +++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  98 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 104 ++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  75 +++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   5 +
 35 files changed, 5031 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/Makefile
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/Makefile
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
