Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA5EC433FE
	for <ltp@archiver.kernel.org>; Sat, 29 Oct 2022 07:14:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35DF3CA0EE
	for <ltp@archiver.kernel.org>; Sat, 29 Oct 2022 09:14:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 033663CA31F
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 09:14:01 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E550600778
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 09:14:00 +0200 (CEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29T6eR5L025924
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EB7bRzBcvUrPXQYMxwRbm3WsrUFfzLNvPo/Zey36rTE=;
 b=lw5YVe6uNaQVZpAxXTdq8X2upgssa6XLEKSKSDfoYkam4AD9KGlNhO0p5jReUw7vLPHr
 8DnaGKl2IDG3KQc6iDSUp4mePzU47eML7fSxeET2RHWBGxb9L62VAbPLtLX4DJvTzNkh
 uoj4rCCtq61bx1A6b4QZbxtyFJ9fU+nMRcOqYUqdByB0cJVJunWEBrk8E/7qWwxlNfa1
 Cn50YI4ohKFb/j8F4aEPcvq8b5YZEUXhUmiG3XlgQx0Ox+RCXU9XWAwxh6oWjqAvWdM4
 biInpe3NqY6Cm/ZBzG5EC35NCIZJms9IFWGmFy5wORoxnJERMbk26QbwCd/Nz42p33mY XQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgvn7bbc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:13:59 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29T6bau1026038
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:13:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06ams.nl.ibm.com with ESMTP id 3kguehr7xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:13:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29T78Xxh44564892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Oct 2022 07:08:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82B7311C04C;
 Sat, 29 Oct 2022 07:13:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81A1811C04A;
 Sat, 29 Oct 2022 07:13:51 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.56])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat, 29 Oct 2022 07:13:51 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 29 Oct 2022 12:43:41 +0530
Message-Id: <20221029071344.45447-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221029071344.45447-1-tsahu@linux.ibm.com>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5SaGoLIc66CxpYZ3n_8Al12F4-B5J2SV
X-Proofpoint-ORIG-GUID: 5SaGoLIc66CxpYZ3n_8Al12F4-B5J2SV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210290030
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for hugeltb
 test support
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
Cc: aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com, sbhat@linux.ibm.com,
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Most of libhugetlbfs test require mounted hugetlbfs and random opened
unlinked file for follow-up test actions.

Here, this patch adds two new field in tst_test struct(include/tst_test.h)
which user can set if the test requires mounted hugetlbfs and other one
for if test requires opened unlinked file.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 include/tst_test.h | 20 +++++++++++++++++-
 lib/tst_test.c     | 51 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index a69965b95..f36382ae9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -131,7 +131,7 @@ struct tst_tag {
 };
 
 extern unsigned int tst_variant;
-
+extern int tst_hugetlb_fd;
 #define TST_NO_HUGEPAGES ((unsigned long)-1)
 
 #define TST_UNLIMITED_RUNTIME (-1)
@@ -176,6 +176,18 @@ struct tst_test {
 	int all_filesystems:1;
 	int skip_in_lockdown:1;
 	int skip_in_compat:1;
+	/*
+	 * If set, the test function will create a hugetlbfs mount point
+	 * at /tmp/xxxxxx, where xxxxxx is a random string.
+	 */
+	int needs_hugetlbfs:1;
+	/*
+	 * If set, the test function will create and open a random file
+	 * under mounted hugetlbfs. To use this option, needs_hugetlbfs must
+	 * be set. The file descriptior will be set in tst_hugetlb_fd.
+	 * The close(tst_hugetlb_fd) will be called on test exit(cleanup).
+	 */
+	int needs_unlinked_hugetlb_file:1;
 
 	/*
 	 * The skip_filesystems is a NULL terminated list of filesystems the
@@ -357,6 +369,12 @@ unsigned int tst_remaining_runtime(void);
  */
 void tst_set_max_runtime(int max_runtime);
 
+/*
+ * Create and open a random file inside the given dir path.
+ * It unlinks the file after opening and return file descriptor.
+ */
+int tst_create_unlinked_file(const char *path);
+
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
  */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8ccde1629..43cba1004 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -925,7 +925,8 @@ static int needs_tmpdir(void)
 	       tst_test->needs_device ||
 	       tst_test->mntpoint ||
 	       tst_test->resource_files ||
-	       tst_test->needs_checkpoints;
+	       tst_test->needs_checkpoints ||
+		   tst_test->needs_hugetlbfs;
 }
 
 static void copy_resources(void)
@@ -1021,6 +1022,30 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 	}
 }
 
+static void prepare_and_mount_hugetlb_fs(void)
+{
+	tst_test->mntpoint = tst_get_tmpdir();
+	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
+	mntpoint_mounted = 1;
+}
+
+int tst_create_unlinked_file(const char *path)
+{
+	char template[PATH_MAX];
+	int fd;
+
+	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
+			path, TCID);
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO,
+			 "%s: mkstemp(%s) failed", __func__, template);
+
+	SAFE_UNLINK(template);
+	return fd;
+}
+
 static const char *limit_tmpfs_mount_size(const char *mnt_data,
 		char *buf, size_t buf_size, const char *fs_type)
 {
@@ -1094,6 +1119,8 @@ static void do_cgroup_requires(void)
 	tst_cg_init();
 }
 
+int tst_hugetlb_fd = -1;
+
 static void do_setup(int argc, char *argv[])
 {
 	if (!tst_test)
@@ -1217,6 +1244,17 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->needs_hugetlbfs)
+		prepare_and_mount_hugetlb_fs();
+
+	if (tst_test->needs_unlinked_hugetlb_file) {
+		if (!(tst_test->needs_hugetlbfs)) {
+			tst_brk(TBROK, "Option needs_unlinked_hugetlb_file "
+					"requires option needs_hugetlbfs");
+		}
+		tst_hugetlb_fd = tst_create_unlinked_file(tst_test->mntpoint);
+	}
+
 	if (tst_test->needs_device && !mntpoint_mounted) {
 		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
 
@@ -1299,8 +1337,15 @@ static void do_cleanup(void)
 	if (ovl_mounted)
 		SAFE_UMOUNT(OVL_MNT);
 
-	if (mntpoint_mounted)
-		tst_umount(tst_test->mntpoint);
+	if (tst_hugetlb_fd >= 0)
+		SAFE_CLOSE(tst_hugetlb_fd);
+
+	if (mntpoint_mounted) {
+		if (tst_test->needs_hugetlbfs)
+			SAFE_UMOUNT(tst_test->mntpoint);
+		else
+			tst_umount(tst_test->mntpoint);
+	}
 
 	if (tst_test->needs_device && tdev.dev)
 		tst_release_device(tdev.dev);
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
