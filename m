Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EF9C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 11:26:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B03BF3CD04A
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 12:26:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3D1A3CD02A
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:24 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22AAC1400DC9
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 12:26:23 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AGAW0P9017426; Wed, 16 Nov 2022 11:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LFewP6PuGGXhFXa01jN91gWDys0ZM1nkQM1Pbbh878g=;
 b=q9QSncGWL6TBqQ0v4LIQ2p5RdB22vLvdYJOA8sHmgQBnVN6xPgctgPARltnmDiVv2vqh
 dJDjO93jYTa0PGqRwPunR/c3xUiO/RfPeq3SuhBdCYBQRy20Ns0vXSNQdL41+DagR9fF
 uNHyahvT9VR3OtByFY4VKbm+n7d1K0fWRm0usKy99VWQnGVbOZjo7S5Xq8pKxj6S6aU8
 YswoaET00SdDdrAZSeC4wH26q8UNkPqH3nUNPDjQLpzd9ofaYOpUA2M5KCTWcrOO7iHz
 j9umWjglvSR9atHn4kOuQwNDaM+jpq/68+A3UprX0Ld6GT22VxVzn4OHmO4sjzEL/gaR 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvx6q1gks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:22 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGAtTQn003210;
 Wed, 16 Nov 2022 11:26:21 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvx6q1gkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:21 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGBK9Du006078;
 Wed, 16 Nov 2022 11:26:20 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma01fra.de.ibm.com with ESMTP id 3ktbd9m1cs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 11:26:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AGBQGsY2884144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Nov 2022 11:26:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B23DF42045;
 Wed, 16 Nov 2022 11:26:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73D0A4203F;
 Wed, 16 Nov 2022 11:26:14 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 16 Nov 2022 11:26:14 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 16 Nov 2022 16:55:10 +0530
Message-Id: <20221116112516.261535-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116112516.261535-1-tsahu@linux.ibm.com>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8tD4Y3VoKr4qefmkME3ATM6Razjlz-CL
X-Proofpoint-ORIG-GUID: wqJixYqUWE0dS49d3Io3GkZjy84hJZ0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_02,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=895 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160074
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/7] Hugetlb: Add new argument flags in
 tst_creat_unlinked
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

Some test requires custom flags for file opened by tst_creat_unlinked
along with O_CREAT|O_EXCL|O_RDWR. This patch creates support to pass
custom flags in tst_creat_unlinked.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 include/tst_test.h                            |  2 +-
 lib/tst_test.c                                | 19 ++++++++++++++-----
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  2 +-
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index acf2421de..a62515bfe 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -365,7 +365,7 @@ void tst_set_max_runtime(int max_runtime);
  * Create and open a random file inside the given dir path.
  * It unlinks the file after opening and return file descriptor.
  */
-int tst_creat_unlinked(const char *path);
+int tst_creat_unlinked(const char *path, int flags);
 
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
diff --git a/lib/tst_test.c b/lib/tst_test.c
index b225ba082..d17b15ee8 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1027,18 +1027,27 @@ static void prepare_and_mount_hugetlb_fs(void)
 	mntpoint_mounted = 1;
 }
 
-int tst_creat_unlinked(const char *path)
+int tst_creat_unlinked(const char *path, int flags)
 {
 	char template[PATH_MAX];
+	int len, c, range;
 	int fd;
+	int start[3] = {'0', 'a', 'A'};
 
 	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
 			path, tid);
+	len = strlen(template) - 1;
+
+	srand(time(NULL));
+	while (template[len] == 'X') {
+		c = rand() % 3;
+		range = start[c] == '0' ? 10 : 26;
+		c = start[c] + (rand() % range);
+		template[len--] = (char)c;
+	}
 
-	fd = mkstemp(template);
-	if (fd < 0)
-		tst_brk(TBROK | TERRNO, "mkstemp(%s) failed", template);
-
+	flags |= O_CREAT|O_EXCL|O_RDWR;
+	fd = SAFE_OPEN(template, flags);
 	SAFE_UNLINK(template);
 	return fd;
 }
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
index bd0fb440a..3122d5b9d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -113,7 +113,7 @@ cleanup:
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
-	huge_fd = tst_creat_unlinked(MNTPOINT);
+	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index ce40e7b69..f66b331dc 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -118,7 +118,7 @@ static void run_test(unsigned int test_type)
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
-	huge_fd = tst_creat_unlinked(MNTPOINT);
+	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
index 1008395a4..ceb0f64a1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -60,7 +60,7 @@ static void run_test(void)
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
-	huge_fd = tst_creat_unlinked(MNTPOINT);
+	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
 }
 
 static void cleanup(void)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
