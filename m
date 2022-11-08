Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BFCC433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 08:28:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C61A3CD88F
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 09:28:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5C633CD84A
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 09:28:03 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 810AE1A009AE
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 09:28:01 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A871ddu026843;
 Tue, 8 Nov 2022 08:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=rPjndZ5cTwDFyC3zAXTpBOK6iN7GEjn2VfM095MqhTM=;
 b=g5LGzWW6vyHhbh2ZFKfN2zc+Egi/misOylbbpTArmr0x+cOgm/P4rfR2ouW1eft2u5rz
 jKTWFVQtfq4ODcKpcHINDm/PF9lMC1xQJlybu/UTPT0Gis8FV358hQmAZKFSAF8I29Cn
 4GlP12nOTsJ7HSBtMrqSWICUS+J8n8MrpNAYjQ45gGBnsQQgvSXKWUNrejJRG2Vv/NY8
 EiCiYPgaFEe7UXPao9garCVBnm+p/BVFuFJDXrJRYUvpjpYtrmVJHdql3mFeIO7iQpKR
 lnGg2YyoYXUvml8M6Ly0noKpjKo1TVBBubFfvhCgNM99MIrPAMNZ0ef7LFPU0NMkqb9K SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1vt94w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 08:27:59 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A88BqDf023543;
 Tue, 8 Nov 2022 08:27:58 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp1vt94vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 08:27:58 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A88LdLb001096;
 Tue, 8 Nov 2022 08:27:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma02fra.de.ibm.com with ESMTP id 3kngpgjqpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 08:27:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A88RrxK64094602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Nov 2022 08:27:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80DDC42041;
 Tue,  8 Nov 2022 08:27:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAF8F4203F;
 Tue,  8 Nov 2022 08:27:49 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.50.217])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  8 Nov 2022 08:27:49 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue,  8 Nov 2022 13:57:42 +0530
Message-Id: <20221108082747.176492-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u3IG2zeC7sakNPmoSm4io2sQ9IcmGkm_
X-Proofpoint-GUID: QzHbZM3F30p0v4V8-nj_lKlvitv8udNA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=697
 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080043
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5][PART 2] Hugetlb:Migrating the libhugetlbfs tests
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
This patch series is in continution to first part [1].
This series include 5 more tests taken from libhugetlbfs.

ref:
	1. https://lore.kernel.org/all/20221104162511.28658-1-tsahu@linux.ibm.com/

Tarun Sahu (5):
  Hugetlb: Migrating libhugetlbfs counters
  Hugetlb: Migrating libhugetlbfs directio
  Hugetlb: Migrating libhugetlbfs fadvise_reserve
  Hugetlb: Migrating libhugetlbfs fallocate_align
  Hugetlb: Migrating libhugetlbfs fallocate_basic

 runtest/hugetlb                               |   6 +
 testcases/kernel/mem/.gitignore               |   5 +
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  10 +
 .../hugetlb/hugefallocate/hugefallocate01.c   | 172 +++++++
 .../hugetlb/hugefallocate/hugefallocate02.c   |  95 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  | 438 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  |  88 ++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  |  89 ++++
 8 files changed, 903 insertions(+)
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
