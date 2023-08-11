Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4566AC001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 12:06:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3B2A3CD069
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 14:06:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 160413CD016
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 12:08:19 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65BBE601E69
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 12:08:17 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37BA1hA2029327; Fri, 11 Aug 2023 10:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FhKGQft4qjyZP36I6TwOsNS2bp4/eWa7V5+CDbaiZ+Y=;
 b=rxEaFcxru424wDJJewbufvXSWodxbEJOOwKgXeXJeQlpl5QxIkcbtQtuNBJCoWZtXsQ7
 chZJiZYUDPkU9NyRHayU8mz8/8QDUe7NnHpCO5An8YyVjD/yFsOrS27BLcdRzbSTsuDs
 d+ZZvhsfeCKPPl8fERqz8h3LWPsOJD4j/ZkANzng17cxlXz0CFbc0TqbUKWkB494Uw3S
 4JdiWW9x2NlUU0mTpSydbERwRkxRDUTX9DAwki/NDntccbiQ920AMwSUUaHjRNnSA12n
 kOUUUyuvXcRa8aw3XosKR61bszMAQevB7ZELqTK/Wtte0g1i0Kic1iVugW+9kypPGgvS 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdjvh075b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:14 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BA2UJa001270;
 Fri, 11 Aug 2023 10:04:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdjvh06rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37B8bTOw030364; Fri, 11 Aug 2023 10:04:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rp1t2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Aug 2023 10:04:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37BA3xS346924086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Aug 2023 10:03:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58FBC2006E;
 Fri, 11 Aug 2023 10:03:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5937E2006C;
 Fri, 11 Aug 2023 10:03:57 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.in.ibm.com (unknown
 [9.204.206.180])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Aug 2023 10:03:57 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net, vishalc@linux.ibm.com
Date: Fri, 11 Aug 2023 15:33:35 +0530
Message-Id: <20230811100337.1683673-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L9gSikyYmRnp3TGFlq8d1y4FUvou0BPs
X-Proofpoint-ORIG-GUID: B_tpNc32MlzbX7R10wfp7HFr8oWlhsKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=652 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110091
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Aug 2023 14:06:13 +0200
Subject: [LTP] [PATCH 0/2] Ebizzy Benchmark Tool: Enhancements for Thread
 Safety and Record Count Handling
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch 1: Enhancing Thread Safety in Ebizzy Benchmark Tool

This patch is aimed at improving the thread safety in the ebizzy benchmarking
tool. A potential issue was identified where the shared variable 'records_read'
was susceptible to race conditions when concurrently updated by multiple
threads. This behavior could lead to skewing of the benchmark results. To
mitigate this issue, a mutex for 'records_read' is introduced in this patch. The
mutex ensures thread-safe updates and consequently improves the reliability of
the benchmark. 

Patch 2: Enhanced Record Count Handling

This patch modifies `ebizzy.c` to handle situations with high record counts more
effectively, especially when the count exceeds `UINT_MAX`. It includes adjusting
the `records_read` variable type from `unsigned int` to `unsigned long
long`. This adjustment allows the benchmark tool to handle a broader range of
record counts accurately. Additionally, the patch introduces error checking for
integer overflow during the summation of `local_records_read` to
`records_read`. Upon detecting an overflow, an appropriate error message is
displayed, and the program exits.

These improvements cater to scenarios where `ebizzy` is run with a large number
of threads over a substantial period. For example, when `ebizzy` is run for 60
seconds with 96 threads, and each thread processes between 5 to 6 million
records, the total record count can easily surpass `UINT_MAX`. This would lead
to an overflow. With these modifications, such situations are properly handled
and reported.

Vishal Chourasia (2):
  Enhanced thread safety in ebizzy benchmark tool
  Handle high record counts and prevent integer overflow

 utils/benchmark/ebizzy-0.3/ebizzy.c | 36 ++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
