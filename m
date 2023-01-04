Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3D6C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 043643CB685
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3BC33C2953
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:43 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DCB7A600711
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:41 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304Bf3uP002562; Wed, 4 Jan 2023 12:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=JiqwPytcJ7osrxPDkc6FW0Lz70KqZXACU9RgMVSUIzA=;
 b=BhQhxTHw17U4WcMqUGWWWfN/Wa+aqAsujv2pntr7BQBsPViSRS7fxGnnfjlQjtF8lBIc
 4kZvpkfJ3D4U3w6/hlt2cU4fPsl3PSfNNOxOnixipn8vXmoJXTBUyeWwpf8zMox6wGda
 OojcbOi+EmQ0r7i6KEbazfV90tquSdpQKAx70vFP0RiR543CoEWVYrS4Pxoc8JkrAPLq
 +b48Tg7h6vnZBuE/IfPhKrpEvUekgfSw2BHgPZU9pn/YtN41qNX9HDQ/irl8vBWL7va+
 PnQzeTxsTKgl9VkYEnMRdk4CrM1XhpQMr45RHN3kV7mGUJubEG5AD417oMXqfw9mDkLi lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw83x9pha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:38 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304CEwVp035381;
 Wed, 4 Jan 2023 12:22:37 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw83x9pg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:37 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3043xica028079;
 Wed, 4 Jan 2023 12:22:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6bugk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CMVXZ23724726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:22:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3260320043;
 Wed,  4 Jan 2023 12:22:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9A3720040;
 Wed,  4 Jan 2023 12:22:27 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:27 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:11 +0530
Message-Id: <20230104122224.369467-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b1Cfu8-eYpNB7Q5tCt6YoF_b8VEYyqQR
X-Proofpoint-GUID: N_SrISZHsr3eQIsGkg5vrr9cYdluCNg-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=762
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/13][PART 4] Hugetlb:Migrating the libhugetlbfs
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
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  |  90 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  |  86 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  | 116 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  |  89 +++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  | 226 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  | 186 ++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  | 118 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  | 103 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  | 121 ++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  |  66 +++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  | 107 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  |  75 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  76 ++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  19 ++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  11 +-
 17 files changed, 1514 insertions(+), 1 deletion(-)
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
