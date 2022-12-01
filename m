Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601BBC47088
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:03:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46EEE3CC4BD
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:03:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DB823CC488
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:01 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB7B9100376D
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:00 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1BkpjF030891; Thu, 1 Dec 2022 12:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=YUXXEwFG79cccfiFRpSRtMKkm7dapud4mBBam3aXvvc=;
 b=Snkc53pA7KocD+ylQDHbMEHkvcagiy7j+kzTcUBRQacINHFIjr1NlO9j7dyjIO3Xe6C7
 DWAoytHnD4g+m/htSYw43LQXm0MQQme0fNcTe8+Q+ArB7JLsHvNFJBM3ncWpngm3aRoD
 MA5WdoZlMp7cN013XalWWXT7AV/TCkjey/7j0I0btANL/68HsVQ2815Q4RnYyfZ4k4vl
 pokUjplBxS+ip7f/1moJuIf8i9q5bvGoPSSdoKF0oOjPVVA4xd5rdy/vUKI10ms3IVX0
 RN///uhPP6QfhkZgKvkZEGq+EzZaJ3iLq8FKRVcEReFKSie3CyxMgLdPhmUU+A7yk1sp vw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6upt8c10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:02:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1BpxX4001549;
 Thu, 1 Dec 2022 12:02:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 3m3ae9fa0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:02:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2B1C3Z578978946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:03:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0869A4054;
 Thu,  1 Dec 2022 12:02:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF13FA405C;
 Thu,  1 Dec 2022 12:02:50 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  1 Dec 2022 12:02:50 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:32:40 +0530
Message-Id: <20221201120248.139396-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120191533.164848-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4Nv94fVCrjFPPkN-cIzDa1Wv3XFGVytb
X-Proofpoint-ORIG-GUID: 4Nv94fVCrjFPPkN-cIzDa1Wv3XFGVytb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=801
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/8][PART 3] Hugetlb:Migrating the libhugetlbfs tests
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
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

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
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  | 108 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 122 +++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  | 156 ++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  | 239 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  |  83 ++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  | 103 ++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  | 153 +++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  | 147 +++++++++++
 11 files changed, 1138 insertions(+)
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
