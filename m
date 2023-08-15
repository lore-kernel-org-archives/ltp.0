Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC98C001B0
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 09:35:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 200C73CCD95
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 11:35:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C8923C967F
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:35:12 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C57D81A007E5
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:35:09 +0200 (CEST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37F9Rn4E020108; Tue, 15 Aug 2023 09:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=W9GkyBEdfEyRgIh4LuFuJZ/m+wWZpfxOowO1eA9+uTc=;
 b=ARnb2o7AVWnuKg8oMWgrbdRVha4UsxBhF4QEblOtJ9d5SRkpUjqub+gdmu9njBnsZiXm
 ebS6goo1kcsrsICMz/JQ0bC3Eqlun6/kKsl5B9kgjn8iLcpUhu3PaVN21xt9sBAsLEZS
 mTyroAqOloTtRO9y4QoqPbPCeTOvNj+bCEBmHpPHc4uuFY9XId88ODmT8ItOmZrgWFE1
 fg622w/DpTf+kH516KlIpyWx3PpzZs6ZpFbU/MygFgT7YF98IbnbW+BQ6V0+rdFam6oh
 0c/4HmFqji8EVVZ5I8eiWnffkyqYnc4CfswWGwJphss0DVqhqPJyIdVJnlohMC5No80z 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg6rer1e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:06 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F9U8in025454;
 Tue, 15 Aug 2023 09:31:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg6rer1dt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:05 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37F8U723001124; Tue, 15 Aug 2023 09:31:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsy47yp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37F9V2oD7144096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 09:31:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74AC82004B;
 Tue, 15 Aug 2023 09:31:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4BBC20040;
 Tue, 15 Aug 2023 09:31:00 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown
 [9.171.75.125]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Aug 2023 09:31:00 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net
Date: Tue, 15 Aug 2023 15:00:46 +0530
Message-Id: <20230815093048.1155501-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E_M3ztEXfRsYl-jKKonUBISanei1oDvg
X-Proofpoint-ORIG-GUID: MELk6M-_f1wOvZQkzmuHL0ZGBikbVbB0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_08,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150081
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Fix Integer Overflow and Thread Safety in
 Record Counting
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
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I am writing to present a patch set that addresses a significant issue we've
observed in our 64-bit systems. We noticed an integer overflow bug affecting our
results, which has prompted this set of changes.

Key Changes:

- Type Selection for Record Counting: We've shifted from using `unsigned int` to
  `uintptr_t` for tracking record counts. This is crucial, especially on 64-bit
  systems, to avoid potential integer overflows that can jeopardize the accuracy
  of our results. 
  
- Thread Safety for Record Counting: Previously, the design used a global
  `records_read` variable to accumulate counts from different threads. This
  approach didn't employ locks, posing potential race conditions. In this patch,
  we've rectified this by introducing a thread-local variable, `records_thread`,
  to individually store the record count of each thread. The accumulated total
  is then fetched safely during thread joining. 

Rationale:

These changes stem from our observations on certain 64-bit systems. The integer
overflow bug, combined with potential race conditions due to the unguarded
global variable, was impacting the integrity of our results. By switching to
`uintptr_t`, we ensure adequate space to hold larger counts typical for 64-bit
systems. Additionally, by introducing the thread-local variable and removing the
global counter, we've added a level of safety against concurrent access issues.  

This patch set ensures the robustness and accuracy of our system, particularly
in multi-threaded environments on 64-bit platforms.

Thank you for your time and consideration. I am open to any feedback and will
gladly make any necessary modifications. 

Changes in v2:
- Replaced mutex synchronization for global records_read updates with inherent
  serialization offered by pthread_join. 
- Link to v1: https://lore.kernel.org/all/20230814061810.2297146-1-vishalc@linux.ibm.com/

Vishal Chourasia (2):
  Enhance Thread Safety in Record Counting
  ebizzy: prevent integer overflow in 64-bit systems

 utils/benchmark/ebizzy-0.3/ebizzy.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
