Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7389C001E0
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 09:35:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDA373CCDAE
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 11:35:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263E53C967F
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:35:14 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7077A2001D9
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:35:13 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37F9K7cf000627; Tue, 15 Aug 2023 09:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cx5KewYUIrtO0zW9a/3C7Qt/k5DMjKYAsx+jJC+s3fY=;
 b=sEbkA31904cNhe5rAt6ZKTHyQbsXMxflDHZA/2cm+WYB2Gt0opakyZ2jX7MZ6dDFxY0Z
 oajD+jcYx8ukClAv6PSJUnDmoEhfIABVDGsefcMyaTwhGtG5i6QG8UKA/PVueGs7FYd+
 h4U3g5/4PSShwj59Qn3PmvsZALu9u7Nw3DxT0RIfOxariW9RUqiM78O9Pob4xaa4gwsF
 MllUUke8LdYZ4caKmM8FB6ICae5v87O8CgGCV6GUtjm5Chf+MGfqwfKGBhRaQm2FZMF4
 wVnrocTvyo9xV/lyA6bSumupRmMN6RBOlebK5rzH6zwz3RwdAL5ES77dYyZfmEx0XMsY bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg6n106nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:10 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F9MGoF005223;
 Tue, 15 Aug 2023 09:31:10 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg6n106n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37F9NrKi018843; Tue, 15 Aug 2023 09:31:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq41b8wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Aug 2023 09:31:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37F9V78t20579022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Aug 2023 09:31:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BE852004B;
 Tue, 15 Aug 2023 09:31:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5571E20040;
 Tue, 15 Aug 2023 09:31:05 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown
 [9.171.75.125]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Aug 2023 09:31:05 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net
Date: Tue, 15 Aug 2023 15:00:48 +0530
Message-Id: <20230815093048.1155501-3-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230815093048.1155501-1-vishalc@linux.ibm.com>
References: <20230815093048.1155501-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KlJ4lg_bgZ5EqIQt0bGNgUc6op6RTqJ1
X-Proofpoint-ORIG-GUID: u1YsQ91z-xHi372m1gOt_PsWqPBSxR77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_08,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150081
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] ebizzy: prevent integer overflow in 64-bit
 systems
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
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

By handling the rate computation within the thread joining loop, we've optimized
our storage, ensuring we don't risk integer overflow, particularly in 64-bit
systems. Given that `uintptr_t` can handle values up to `(2^64)-1`, to create an
overflow with the current implementation on a system with 9,000,000,000
records/sec values, one would need to run more than (2^64-1)/9 billion threads,
which is astronomically high and practically impossible.

This change reinforces the reliability of our code on high-performance, 64-bit
systems, ensuring accurate record counting without potential overflows.

In the `start_threads` function of the `ebizzy` benchmark utility, the variable
previously named `records_read` has been refactored to `records_per_sec` to more
accurately reflect its purpose, which is to store the rate of records per
second.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index ae0981fbd..c3eac1133 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -456,7 +456,7 @@ static void start_threads(void)
 	unsigned int i;
 	struct rusage start_ru, end_ru;
 	struct timeval usr_time, sys_time;
-	uintptr_t records_read = 0;
+	uintptr_t records_per_sec = 0;
 	int err;
 
 	if (verbose)
@@ -493,14 +493,13 @@ static void start_threads(void)
 			fprintf(stderr, "Error joining thread %d\n", i);
 			exit(1);
 		}
-		records_read += record_thread;
+		records_per_sec += (record_thread / elapsed);
 	}
 
 	if (verbose)
 		printf("Threads finished\n");
 
-	printf("%tu records/s\n",
-	       (uintptr_t)(((double)records_read) / elapsed));
+	printf("%tu records/s\n", records_per_sec);
 
 	usr_time = difftimeval(&end_ru.ru_utime, &start_ru.ru_utime);
 	sys_time = difftimeval(&end_ru.ru_stime, &start_ru.ru_stime);
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
