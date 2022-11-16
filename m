Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7A3C4321E
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 11:26:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08C9F3CD038
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 12:26:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D6D3CD018
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:24 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8454C10009BA
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:22 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AGAn5aC010422; Wed, 16 Nov 2022 11:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=kTfeVIuVoOecD9VISC46q9exwzeDvx7LolvfhKQnpTg=;
 b=BdZJlTBCYrT4BL1p5PHP2a8uxemlF21XATxUwoyOUv/0lpL5miHQz0DfJjsEazUMzwOo
 YR2tARHiBozZxduMhmRiboFHiu2dqaK3ouoVlDuyZESc0ujyHIVvYVAbUAVvz0sjtqIW
 /hmr4oI/WMDLLJgAEA735/VQxw560qQlCOBqf5W/p0l3mo1kkhAKG4haBKEIGsGjst/r
 glZBVRIkT2jfCOnVsV3/Y4je4MqGHMikfQa5qaoyjKyTk0tV1EUSC5DIS4PPR9ezvOuE
 TcC15SsYf8kut/mxHmTyWJI3L4pCgnXjf6mKf5bz2ph46Hli/aEOsKt2+iLpA7q1kiGG AA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvxeg0wue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:20 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGAp238021313;
 Wed, 16 Nov 2022 11:26:20 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvxeg0wtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGBLjn4008357;
 Wed, 16 Nov 2022 11:26:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 3kt348wt24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AGBQE7r13107956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Nov 2022 11:26:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1053642042;
 Wed, 16 Nov 2022 11:26:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD6754203F;
 Wed, 16 Nov 2022 11:26:11 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 16 Nov 2022 11:26:11 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 16 Nov 2022 16:55:09 +0530
Message-Id: <20221116112516.261535-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cgCNha3xhHgEj4w80K-0jiaFwIpuYLPd
X-Proofpoint-ORIG-GUID: NBhL2tYD-a9aHoMoblk6cIeh2_etzCAq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 mlxlogscore=990 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160074
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/7] Hugetlb:Migrating the libhugetlbfs tests
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
v3 -> v4
	1. Removing redundant access call to check if file already exist.
	and removing the retry path, as the case is very rare in PATCH[1/7].

Tarun Sahu (7):
  Hugetlb: Migrating libhugetlbfs noresv-reserve-resv-page
  Hugetlb: Migrating libhugetlbfs noresv-regarded-as-resv
  Hugetlb: Migrating libhugetlbfs private
  Hugetlb: Migrating libhugetlbfs readahead_reserve
  Hugetlb: Migrating libhugetlbfs readback
  Hugetlb: Migrating libhugetlbfs shared
  Hugetlb: Migrating libhugetlbfs shm-fork

 runtest/hugetlb                               |   7 +
 testcases/kernel/mem/.gitignore               |   7 +
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 196 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  | 166 +++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  | 107 ++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 129 ++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  | 120 +++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  98 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 104 ++++++++++
 9 files changed, 934 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
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
