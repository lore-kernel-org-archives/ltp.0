Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59400FEEF24
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:20:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0797D3E214D
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 13:20:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F97B3C9314
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:20:37 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DCD8E60082D
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:20:36 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636Lmfgn2326605; Tue, 7 Apr 2026 11:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QCIANb21erl11WBbE7AB5oPR8vHVefkggzdgbUBYl
 d4=; b=N7Wu2k4yUlCnDfTa6/E7hqQQ6LXp9UbO5YSZUyOM1HWI+fSivBTcVdlIg
 ZYUUiC9SLfbh1HMHz11SfgM1VwoCxC4QwrnBkOXZBqNakqOADF08HN89CQsxsrUZ
 LKlI4xeW4txawHrEa453SyNO4PEkmeQMMSM1HTKYbYzqgGg7DIHef7Ee72q5oYbs
 IepSwIYiNKhavwrlvvgEoBOlcj5sum9QFqNbPC0bYdqfwiSakg21uPV/35mG7Y9T
 vEOXZGQP1GFuwVIwwNFDZkZz4ilit15hdjDdD0qCItp40zjwKo4l2efI5ClWC8gd
 Ccc3CObUGa0OjHNAx6LqUnIZdtfIw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kac4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2026 11:20:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BHjFt019008;
 Tue, 7 Apr 2026 11:20:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9an0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2026 11:20:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 637BKU6k54133198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Apr 2026 11:20:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2892520049;
 Tue,  7 Apr 2026 11:20:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DDBA20040;
 Tue,  7 Apr 2026 11:20:29 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Apr 2026 11:20:29 +0000 (GMT)
From: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  8 Apr 2026 10:14:31 +0530
Message-ID: <20260408044431.128811-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwNiBTYWx0ZWRfXx+ZXzWR7TBUi
 qctSaPGS5NKZXI5q47WcBA8dUniN7K/DAuHeFZCA0wh51fceys+TJUkBVgIr+RHqkW2C7zERJve
 M4b3IkhkN5KeOH6KUtWncGmUdJzsUDLLtQuRa863+6wpbNaMW5EJMbV1bGB+I7FByuKCGMenNeT
 pkLODvVZIjDAxF2b5czL71zsDUBPN6OWOlY6FbMFmNlHNnpnwHtdzjJFZU7w8G1hiWaXv4buzTX
 DQUiguDnPeXQOFMKN0K8Vzr/mzuTruet4ijg2rcDrs2yV6lABy28J1DX+R+fvjvuy1EO8gLvMfI
 joghmmc+RFk16uT2E12L1fTDX3HfHW1kSfNJVOV3IkZ7GSkKv7PKx5oR0kqrarzuWdME8QjDQYb
 TgmaqD9JOYBiPFUK9RONIm4maZokGr7fWz4sL2So+Xfaw2GH9t1rwWo5HGG3V0RCpJ8Li0Bf+jn
 NmUPt31ZbNPU+KlDl9w==
X-Proofpoint-ORIG-GUID: DeH0MOq9cedyLs0Axo4VfzyFcYhhs_ac
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d4e882 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=WdhFN2Bf4an_YImpd_MA:9
X-Proofpoint-GUID: DeH0MOq9cedyLs0Axo4VfzyFcYhhs_ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070106
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nptl01: Fix "make check" warnings and errors
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
Cc: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

- Add SPDX-License-Identifier tag (GPL-2.0-or-later)
- Remove FSF mailing address from license header
- Fix function definitions to use (void) for no parameters
- Remove extern declaration from .c file (optarg)
- Remove unnecessary initialization of global variable idle_count
- Fix pointer declarations spacing (foo *bar instead of foo * bar)
- Separate assignments from if conditions (10 occurrences)
- Make cleanup() function static to avoid extern warning
- Use __func__ in usage() function instead of hardcoded string
- Add (void) casts for unused function parameters to suppress warnings

This resolves 23 "make check" errors, 4 "make check" warnings, and 3
compiler warnings about unused parameters.

Signed-off-by: Samir <samir@linux.ibm.com>
---
 testcases/kernel/sched/nptl/nptl01.c | 77 +++++++++++++++-------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/sched/nptl/nptl01.c b/testcases/kernel/sched/nptl/nptl01.c
index e80f70cb7..b04b6f7f9 100644
--- a/testcases/kernel/sched/nptl/nptl01.c
+++ b/testcases/kernel/sched/nptl/nptl01.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 /**********************************************************
  *
@@ -51,14 +39,14 @@
 
 char *TCID = "nptl01";		/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
-void cleanup();
+static void cleanup(void);
 
 pthread_mutex_t req;
 pthread_mutex_t ack;
 pthread_mutex_t waitx;
 pthread_cond_t parent;
 pthread_cond_t child;
-int idle_count = 0;
+int idle_count;
 
 /*
  * The time to wait should be set appropriately so that the waiting thread
@@ -69,74 +57,82 @@ int idle_count = 0;
  */
 #define NSECS_TO_WAIT	(1)
 
-void call_mutex_init(pthread_mutex_t * mutex, char *buf, size_t buf_len)
+void call_mutex_init(pthread_mutex_t *mutex, char *buf, size_t buf_len)
 {
 	int ret;
 
-	if ((ret = pthread_mutex_init(mutex, NULL)) != 0) {
+	ret = pthread_mutex_init(mutex, NULL);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_mutex_init failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
 }
 
-void call_mutex_lock(pthread_mutex_t * mutex, char *buf, size_t buf_len)
+void call_mutex_lock(pthread_mutex_t *mutex, char *buf, size_t buf_len)
 {
 	int ret;
 
-	if ((ret = pthread_mutex_lock(mutex)) != 0) {
+	ret = pthread_mutex_lock(mutex);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_mutex_lock failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
 }
 
-void call_mutex_unlock(pthread_mutex_t * mutex, char *buf, size_t buf_len)
+void call_mutex_unlock(pthread_mutex_t *mutex, char *buf, size_t buf_len)
 {
 	int ret;
 
-	if ((ret = pthread_mutex_unlock(mutex)) != 0) {
+	ret = pthread_mutex_unlock(mutex);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_mutex_unlock failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
 }
 
-void call_cond_init(pthread_cond_t * cond, char *buf, size_t buf_len)
+void call_cond_init(pthread_cond_t *cond, char *buf, size_t buf_len)
 {
 	int ret;
 
-	if ((ret = pthread_cond_init(cond, NULL)) != 0) {
+	ret = pthread_cond_init(cond, NULL);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_cond_init failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
 }
 
-void call_cond_wait(pthread_cond_t * cond, pthread_mutex_t * mutex,
+void call_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex,
 		    char *buf, size_t buf_len)
 {
 	int ret;
 
-	if ((ret = pthread_cond_wait(cond, mutex)) != 0) {
+	ret = pthread_cond_wait(cond, mutex);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_cond_wait failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
 }
 
-void call_cond_signal(pthread_cond_t * cond, char *buf, size_t buf_len)
+void call_cond_signal(pthread_cond_t *cond, char *buf, size_t buf_len)
 {
 	int ret;
 
-	if ((ret = pthread_cond_signal(cond)) != 0) {
+	ret = pthread_cond_signal(cond);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_cond_signal failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
 }
 
-void do_timedwait(pthread_cond_t * cond, pthread_mutex_t * mutex,
+void do_timedwait(pthread_cond_t *cond, pthread_mutex_t *mutex,
 		  char *buf, size_t buf_len, int i)
 {
 	struct timeval tv;
 	struct timespec ts;
 	int ret;
 
+	(void)i;
+
 	if (gettimeofday(&tv, NULL) != 0) {
 		tst_brkm(TBROK, cleanup, "gettimeofday failed: %s",
 			 strerror_r(errno, buf, buf_len));
@@ -148,7 +144,8 @@ void do_timedwait(pthread_cond_t * cond, pthread_mutex_t * mutex,
 	ts.tv_nsec = ts.tv_nsec % 1000000000;
 
 	call_mutex_lock(mutex, buf, buf_len);
-	if ((ret = pthread_cond_timedwait(cond, mutex, &ts)) != ETIMEDOUT) {
+	ret = pthread_cond_timedwait(cond, mutex, &ts);
+	if (ret != ETIMEDOUT) {
 #if DEBUG
 		tst_resm(TINFO,
 			 "Loop %d of 1000000: pthread_cond_timedwait() didn't timeout",
@@ -166,6 +163,8 @@ void *run(void *arg)
 {
 	char buf[1024];
 
+	(void)arg;
+
 	while (1) {
 		call_mutex_lock(&ack, buf, sizeof(buf));
 		idle_count = 1;
@@ -188,22 +187,25 @@ void create_child_thread(char *buf, size_t buf_len)
 	pthread_t child_tid;
 	int ret;
 
-	if ((ret = pthread_attr_init(&attr)) != 0) {
+	ret = pthread_attr_init(&attr);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_attr_init failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
-	if ((ret = pthread_attr_setdetachstate(&attr,
-					       PTHREAD_CREATE_DETACHED)) != 0) {
+	ret = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup,
 			 "pthread_attr_setdetachstate failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
-	if ((ret = pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM)) != 0) {
+	ret = pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_attr_setscope failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
 
-	if ((ret = pthread_create(&child_tid, &attr, run, NULL)) != 0) {
+	ret = pthread_create(&child_tid, &attr, run, NULL);
+	if (ret != 0) {
 		tst_brkm(TBROK, cleanup, "pthread_create failed: %s",
 			 strerror_r(ret, buf, buf_len));
 	}
@@ -211,13 +213,15 @@ void create_child_thread(char *buf, size_t buf_len)
 
 void trap_alarm(int sig)
 {
+	(void)sig;
+
 	tst_brkm(TFAIL, cleanup, "Test hang longer than %d sec detected",
 		 MAXTIME);
 }
 
 static void usage(const char *progname)
 {
-	fprintf(stderr, "usage: %s -l loops\n", progname);
+	fprintf(stderr, "%s: %s -l loops\n", __func__, progname);
 	fprintf(stderr, "\t-l specify the number of loops to carry out\n");
 }
 
@@ -226,7 +230,6 @@ int main(int argc, char **argv)
 #ifdef USING_NPTL
 	char buf[1024];
 	int i;
-	extern char *optarg;
 	int numloops = NUMLOOPS;
 
 	while ((i = getopt(argc, argv, "l:")) != -1) {
@@ -297,7 +300,7 @@ int main(int argc, char **argv)
  *cleanup() -  performs all ONE TIME cleanup for this test at
  *              completion or premature exit.
  */
-void cleanup()
+static void cleanup(void)
 {
 
 	tst_exit();
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
