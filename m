Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE45FC433FE
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 11:07:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4813CAD00
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 12:07:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1FCF3CAD28
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 12:06:56 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E05D10007EF
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 12:06:54 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A29hbH9016343;
 Wed, 2 Nov 2022 11:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UMmYChLtxbr0IhXR1kGaNGV0uEfPeoHbC+wQ5LXTzQs=;
 b=dPd4iiVp/ti073qmg+b4023QK6TaA4adfolo/+LB2nOWvhqrHeTPSCLzRkplEUcoqA9b
 849DD1syVRSjeSVFmG0gZH7hOq5q65qwwW81ckDloJZsIEigytRm1CIdCw6UDIC6kxI2
 1cf3NOflFQfGXN0mvFxyVx5Z72cUjJHTB4yFSWZyKcR0RXOy0s8F8sqLMYupq/Y/QfRs
 DsrBr1EmjbfoYtZ1iM1iQGiy2e80zY6GqSEb9QqW3xaZk4kzh505g0Cr/26OrC6U3QBC
 3KqWIH/iQtFju+4cvObAjMKW1gKhu2yYiQzqbYIWSVgWxwQpsJtG/+1h8uP27gcq3duv Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjruhkuuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:06:53 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2Acthh003384;
 Wed, 2 Nov 2022 11:06:52 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjruhkutr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:06:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2B6fCR029539;
 Wed, 2 Nov 2022 11:06:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04ams.nl.ibm.com with ESMTP id 3kgut96kwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:06:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A2B6llX20382428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Nov 2022 11:06:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7AB2A4067;
 Wed,  2 Nov 2022 11:06:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88B89A4066;
 Wed,  2 Nov 2022 11:06:44 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.114.53])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  2 Nov 2022 11:06:44 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  2 Nov 2022 16:36:35 +0530
Message-Id: <20221102110638.413561-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102110638.413561-1-tsahu@linux.ibm.com>
References: <20221102110638.413561-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9lvy0yfD1bKzCSzqdBKcGDZnlgI1n5-I
X-Proofpoint-ORIG-GUID: 57HvxlC4Mrcirr3o76KJAi6wNi8rl4HZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020067
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] Hugetlb: Add new tst_test options for hugeltb
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Most of libhugetlbfs test require mounted hugetlbfs.

Here, this patch adds a new field in tst_test struct(include/tst_test.h)
which user can set if the test requires mounted hugetlbfs. Also, this
patch added support to create the unlinked file in the provided dirpath.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 include/tst_test.h | 11 +++++++++++
 lib/tst_test.c     | 44 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index a69965b95..01bc5a05b 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -176,6 +176,11 @@ struct tst_test {
 	int all_filesystems:1;
 	int skip_in_lockdown:1;
 	int skip_in_compat:1;
+	/*
+	 * If set, the test function will create a hugetlbfs mount point
+	 * at /tmp/xxxxxx, where xxxxxx is a random string.
+	 */
+	int needs_hugetlbfs:1;
 
 	/*
 	 * The skip_filesystems is a NULL terminated list of filesystems the
@@ -357,6 +362,12 @@ unsigned int tst_remaining_runtime(void);
  */
 void tst_set_max_runtime(int max_runtime);
 
+/*
+ * Create and open a random file inside the given dir path.
+ * It unlinks the file after opening and return file descriptor.
+ */
+int tst_creat_unlinked(const char *path);
+
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
  */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8ccde1629..3e9c3f676 100644
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
@@ -1021,6 +1022,29 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 	}
 }
 
+static void prepare_and_mount_hugetlb_fs(void)
+{
+	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
+	mntpoint_mounted = 1;
+}
+
+int tst_creat_unlinked(const char *path)
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
@@ -1191,15 +1215,16 @@ static void do_setup(int argc, char *argv[])
 		SAFE_MKDIR(tst_test->mntpoint, 0777);
 
 	if ((tst_test->needs_devfs || tst_test->needs_rofs ||
-	     tst_test->mount_device || tst_test->all_filesystems) &&
+	     tst_test->mount_device || tst_test->all_filesystems ||
+		 tst_test->needs_hugetlbfs) &&
 	     !tst_test->mntpoint) {
 		tst_brk(TBROK, "tst_test->mntpoint must be set!");
 	}
 
 	if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
-	    !!tst_test->needs_device > 1) {
+	    !!tst_test->needs_device + !!tst_test->needs_hugetlbfs > 1) {
 		tst_brk(TBROK,
-			"Two or more of needs_{rofs, devfs, device} are set");
+			"Two or more of needs_{rofs, devfs, device, hugetlbfs} are set");
 	}
 
 	if (tst_test->needs_devfs)
@@ -1217,6 +1242,9 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->needs_hugetlbfs)
+		prepare_and_mount_hugetlb_fs();
+
 	if (tst_test->needs_device && !mntpoint_mounted) {
 		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
 
@@ -1299,8 +1327,12 @@ static void do_cleanup(void)
 	if (ovl_mounted)
 		SAFE_UMOUNT(OVL_MNT);
 
-	if (mntpoint_mounted)
-		tst_umount(tst_test->mntpoint);
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
