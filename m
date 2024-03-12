Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AADC54E58
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 12:09:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6344C3D0192
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 13:09:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DD823CE7C6
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 13:08:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6461714044C2
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 13:08:37 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CBqA7S008050
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i1NWaFCaTtanEd5cTnnr9nfZ1oHSQPVR526Whcm6+yY=;
 b=d3IsM4V2yozQbnlCreCxRPZw/7e/Aj224di5SItIRRZPjtm9uxqp96pEVYhhvR60kI1n
 lc3aLwur3kP41yw3ygFts2hAE06oUu/PnrwUPCD3vhX+G8PDFbh/4cmHUXlDo5x1dAzt
 Oom68zAzOybL9RhCI5QZoAKOWnDl1kBCrSEaijXpVj5Dc7ua0wu+U6g1kwPvgWd79EzX
 dGA02FmaRnKcHj4xFi0XB5bGHvHjTkL3bpVI8Qlm081ov4oTVhaj/Fy0yv22kPvR5aRR
 3U6n+L/UQYwovSjr97MivEgNYTsSO8CAZUGraZCZdcV3XJCVSCBupLVClbl5yINqDLcn QQ== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtpj6093b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CAvZ2Y018543
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4t1xdh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CC8UX232375226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7591820040
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 447DD2004F
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:30 +0000 (GMT)
Received: from lenovoibm.ibmuc.com (unknown [9.171.44.81])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:30 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 12 Mar 2024 13:08:29 +0100
Message-ID: <20240312120829.178305-2-meted@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312120829.178305-1-meted@linux.ibm.com>
References: <20240312120829.178305-1-meted@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xWzemS4H0Dxb2y4qO_mu3ef_-JQFiV7g
X-Proofpoint-ORIG-GUID: xWzemS4H0Dxb2y4qO_mu3ef_-JQFiV7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120093
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] fanotify14: fix anonymous pipe testcases
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

When SElinux is in enforcing state and SEpolicies disallow anonymous
pipe usage with fanotify_mark(), related fanotify14 testcases fail with
EACCES instead of EINVAL. Accept both errnos when SElinux is in
enforcing state to correctly evaluate test results.

Replace TST_EXP_FD_OR_FAIL with TST_EXP_FAIL when testing
fanotify_mark() as it returns -1 on failure and 0 on success not a file
descriptor.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index d02d81495..52c327dff 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -27,12 +27,14 @@
 #define _GNU_SOURCE
 #include "tst_test.h"
 #include <errno.h>
+#include <stdlib.h>
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
 
 #define MNTPOINT "mntpoint"
 #define FILE1 MNTPOINT"/file1"
+#define SELINUX_STATUS_PATH "/sys/fs/selinux/enforce"
 
 /*
  * List of inode events that are only available when notification group is
@@ -240,6 +242,19 @@ static struct test_case_t {
 	},
 };
 
+static int is_selinux_enforcing(void)
+{
+	char res;
+	int fd;
+
+	fd = open(SELINUX_STATUS_PATH, O_RDONLY);
+	if (fd <= 0)
+		return 0;
+	SAFE_READ(1, fd, &res, 1);
+	SAFE_CLOSE(fd);
+	return atoi(&res);
+}
+
 static void do_test(unsigned int number)
 {
 	struct test_case_t *tc = &test_cases[number];
@@ -275,17 +290,28 @@ static void do_test(unsigned int number)
 	/* Set mark on non-dir only when expecting error ENOTDIR */
 	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
 	int dirfd = AT_FDCWD;
+	int se_enforcing = 0;
 
 	if (tc->pfd) {
 		dirfd = tc->pfd[0];
 		path = NULL;
+		se_enforcing = is_selinux_enforcing();
 	}
 
 	tst_res(TINFO, "Testing %s with %s",
 		tc->mark.desc, tc->mask.desc);
-	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
-					 tc->mask.flags, dirfd, path),
-					 tc->expected_errno);
+
+	if (tc->pfd && se_enforcing) {
+		const int exp_errs[] = {tc->expected_errno, EACCES};
+
+		TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+				 tc->mask.flags, dirfd, path),
+				 exp_errs);
+	} else {
+		TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
+						 tc->mask.flags, dirfd, path),
+						 tc->expected_errno);
+	}
 
 	/*
 	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
