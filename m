Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0488CC433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 19:52:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89A9F3CD936
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 20:52:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D90B43CD8C8
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 20:52:24 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A274C1000995
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 20:52:22 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8HmkUB020249;
 Tue, 8 Nov 2022 19:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=m1+NEA8Z0cwu+TsbVFctTVErjVTMuMJ+u1hI0qdRpi4=;
 b=HJFWGjfUvnJzC72NPDMUmJssUg5RNhlNbgGP36QzmO7WjiZp05V1COh4XZB05j7qa7po
 l/2WXhnD8lrMTPVa+XYKH3v2vKgmCr1x7O56P99UVmLXZJzhhIAGEFfSdyyczxeB2k7i
 zAanAciPFVvO3F0VTwSUhZYt0XLYpsbe8lDfwdrZpVqmUYVV5y5ZEhAuD8tRj8Wl8x/R
 zKA5Pyu3TY6R7sXiTqGaRLWL46quExSiKgimpF9wnFg4eCzjzqFBOmp4czXCqDIvz4qE
 j99qM+RNACE9YvDPLJgYQU4cufOLafwXb9fpQ5v4dnHhZPbYdJPFb3g2IfYX24y4iFAF Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kquudb7nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:20 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A8I17t1009674;
 Tue, 8 Nov 2022 19:52:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kquudb7my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A8JpZHG026738;
 Tue, 8 Nov 2022 19:52:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04ams.nl.ibm.com with ESMTP id 3kngqdckme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:17 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A8JqE5T53412206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Nov 2022 19:52:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EF87A404D;
 Tue,  8 Nov 2022 19:52:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E33FAA4040;
 Tue,  8 Nov 2022 19:52:10 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.4.5])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  8 Nov 2022 19:52:10 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  9 Nov 2022 01:22:02 +0530
Message-Id: <20221108195207.232115-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mY9kQz1BkqbFAj6PKHJekFa7BOnOu7z6
X-Proofpoint-GUID: F54AUQYmWP7qhdp4zpoyWwmmcxqZB0tS
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=780
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080125
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5][PART 2] Hugetlb:Migrating the libhugetlbfs
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
 vaibhav@linux.ibm.com, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, 
This patch series is in continution to first part [1].
This series include 5 more tests taken from libhugetlbfs.

ref:
 1. https://lore.kernel.org/all/20221104162511.28658-1-tsahu@linux.ibm.com/

v1 -> v2
	1. Fixed comments

Tarun Sahu (5):
  Hugetlb: Migrating libhugetlbfs counters
  Hugetlb: Migrating libhugetlbfs directio
  Hugetlb: Migrating libhugetlbfs fadvise_reserve
  Hugetlb: Migrating libhugetlbfs fallocate_align
  Hugetlb: Migrating libhugetlbfs fallocate_basic

 runtest/hugetlb                               |   6 +
 testcases/kernel/mem/.gitignore               |   5 +
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  10 +
 .../hugetlb/hugefallocate/hugefallocate01.c   | 169 +++++++
 .../hugetlb/hugefallocate/hugefallocate02.c   |  90 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 438 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  |  87 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  |  93 ++++
 8 files changed, 898 insertions(+)
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
