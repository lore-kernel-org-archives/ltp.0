Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33C5C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:43:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6398C3CB8EE
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:43:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0941F3CB8B9
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:31 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 45F2314001ED
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:28 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFcWkI003868; Sun, 25 Dec 2022 15:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=CULGf0r2lnWKj2Cv8vo1iUQlf2GceoXEv+yLVzJ/nYI=;
 b=BZEMsAlnbdiFQn62SZz3JFOWEVLq2tXIeQcA/dN1FgbffA1oNGhFwCcGmyRmfFXly/RX
 oLJYm9J3HgP/U5lHh9+Su+7NrNdB5Qu27HG8NQ6l1kB0DP9HDpT5F0IDoXDwLi2YPZU1
 SMxLamk9Tjdj/+QG1U/OPBqJPlFBFlb3kYN8vCKZhcaVeLb9t/MfpqumUxOIorBvQM2D
 /QwNflg+5snJYrvOQMLjQPfTgTDHTh7yVRZirK5DfIDLUePDnvEZC90SMvk+wC/iwL87
 b3sjBmocUhjl8By0uAvxWSsDQzxVhC8jMRzc11W42fyVXOTz9ZqYVE1K4vq0VTrIj6rY BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mprjcrmdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:26 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFgPpU016735;
 Sun, 25 Dec 2022 15:42:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mprjcrmdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BPFIDPp023609;
 Sun, 25 Dec 2022 15:42:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mns26hdva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgK7A23200346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC21520049;
 Sun, 25 Dec 2022 15:42:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8013120040;
 Sun, 25 Dec 2022 15:42:16 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:16 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:00 +0530
Message-Id: <20221225154213.84183-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IIhsVLbc_HnGFluBI9Moee-5b51Jwzq4
X-Proofpoint-GUID: o2bpkY5ZjMeTSnEM2LfIYKdCeR9v5Bk0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=818 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/13][PART 4] Hugetlb:Migrating the libhugetlbfs tests
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
This patch series is in continuation to part [1], part [2] and part [3].
This series include 13 more tests taken from libhugetlbfs.

Background:
Libhugetlbfs is not being maintained actively, and some distro is dropping
support for it. There are some tests that are good for testing hugetlb
functionality in kernel. These patches include tests from libhugetlbfs.

ref:
 1. https://lore.kernel.org/all/20221104162511.28658-1-tsahu@linux.ibm.com/
 2. https://lore.kernel.org/all/20221120191533.164848-1-tsahu@linux.ibm.com/
 3. https://lore.kernel.org/all/20221220063109.279007-1-tsahu@linux.ibm.com/

Tarun Sahu (13):
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
  Hugetlb: Migrating libhugetlbfs shared
  Hugetlb: Migrating libhugetlbfs shm-fork
  Hugetlb: Migrating libhugetlbfs mremap-expand-slice-collision

 runtest/hugetlb                               |  13 +
 testcases/kernel/mem/.gitignore               |  13 +
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 104 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  |  88 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  | 131 ++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  | 104 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  | 244 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  | 212 +++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  | 146 +++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  | 131 ++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  | 136 ++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  |  74 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 115 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  |  85 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  84 ++++++
 15 files changed, 1680 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
