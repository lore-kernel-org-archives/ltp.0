Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E53C4332F
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 19:16:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F2BC3CCCA8
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 20:16:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9861B3C1BB8
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:51 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DF60E636CD2
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:50 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AKIoPT5004995; Sun, 20 Nov 2022 19:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=llOzHzBbcNlEdmv/ov201yflhqjLMDsjBEoQO9osAnk=;
 b=IljIU+uufP3xuv+M1g9Fhq/Mfbf953+q06ayEs/ne2pPhGcR1YpxGs9NUnCrmg4vKPJP
 LeyL/KN9uDtdeYvRyA1HL/1eG71GdKvzM9dcQlYpe0BQI5rjgawuzZN9p70f83VXqiWf
 K0axJqr/aJdIB4BMa/oB53XLEFKa+kEi0EvPaSt3rN4ym/FcicVl1NpEeRLASoEGf8A1
 iAmQ96l1B6RDwQ4KFw/MQn58EWDgHEVW7r4yHIA7vdTGACoB0kD87O2YVJpwoJsq+fpP
 951Vi4FiMIDvfookmtex9QVA1BI2S9i3oiL/XD8O64IMevA0Pupn6/IFGCCFOF18lObV 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky930xhmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:48 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKJFVWP007968;
 Sun, 20 Nov 2022 19:15:48 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky930xhmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKJ4uKD027636;
 Sun, 20 Nov 2022 19:15:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3kxpdhsmh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AKJFhNq3998410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Nov 2022 19:15:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECC3F5204F;
 Sun, 20 Nov 2022 19:15:42 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.36.159])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6844E52050;
 Sun, 20 Nov 2022 19:15:39 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 00:45:27 +0530
Message-Id: <20221120191533.164848-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120191533.164848-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fzQt5Koer4QkcT_dTelz6XwhCs1MfzaH
X-Proofpoint-ORIG-GUID: KQtbDEmysb2OGkKxs-Yj0Y74n9B0AcD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=926 lowpriorityscore=0 malwarescore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211200162
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/7] Hugetlb: Add new argument flags in
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
 include/tst_test.h                               |  2 +-
 lib/tst_test.c                                   | 16 ++++++++++++----
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c     |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c     |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c     |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

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
index b225ba082..9c4c4f064 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1027,18 +1027,26 @@ static void prepare_and_mount_hugetlb_fs(void)
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
 
-	fd = mkstemp(template);
-	if (fd < 0)
-		tst_brk(TBROK | TERRNO, "mkstemp(%s) failed", template);
+	len = strlen(template) - 1;
+	while (template[len] == 'X') {
+		c = rand() % 3;
+		range = start[c] == '0' ? 10 : 26;
+		c = start[c] + (rand() % range);
+		template[len--] = (char)c;
+	}
 
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
