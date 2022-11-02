Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FF4C4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 11:50:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A08183CAD45
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 12:50:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AF693CAD4B
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 12:49:43 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 57C5A14004E3
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 12:49:41 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2ATiPj032203;
 Wed, 2 Nov 2022 11:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=R4cBkaepjRP7rW7YllaUc3gC6Icm51yOuTkkQs0N9Ok=;
 b=RVMLnsywMnljYTZTeFT/6rrtoqtx2E0fJdlZnOntA6CYjI7jI6mR6G7S5nZmwq9Awjy1
 RK2S3n6GXnr9j5dDusX76/+2DA5OQGu2aV4vXscE08fli7My3v7zssES5yhYbQxHhLXI
 hQkSzUvMuy83h4Abx9JesSFCaxVy3WEIG3U3Mb61HkR6/HhKR4SAiM32AmVPsGwoJEog
 S+4kUq8RgM96T8OIngFsiDwIQ55L3tjbWSvaOKw0cUTL/S9hXrdWkhjODeQTMPuf6CDH
 UcvRBBlbsHes+cUpRyvIss2Ue800HOkbhwQi9Qi3JGRnAq5RwWga/batfHh16SB6iNur qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkpunahjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:49:40 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2ATkRr032284;
 Wed, 2 Nov 2022 11:49:39 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkpunahj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:49:39 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2BZ53b006267;
 Wed, 2 Nov 2022 11:49:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 3kgut9d00w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Nov 2022 11:49:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A2BnX3T65274346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Nov 2022 11:49:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B659A4054;
 Wed,  2 Nov 2022 11:49:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA2AAA405C;
 Wed,  2 Nov 2022 11:49:29 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.85.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  2 Nov 2022 11:49:29 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  2 Nov 2022 17:19:20 +0530
Message-Id: <20221102114923.447871-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102114923.447871-1-tsahu@linux.ibm.com>
References: <20221102114923.447871-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xge6S3sB6SxBBXVlo9kTfVtOBtYXNdNf
X-Proofpoint-ORIG-GUID: nw1VE1Ss7Lztm8R5A-H23bGUt1Dyhq0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020070
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/4] Hugetlb: Add new tst_test options for hugeltb
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
 lib/tst_test.c     | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 47 insertions(+), 5 deletions(-)

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
index 8ccde1629..9965706ef 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1021,6 +1021,29 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
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
@@ -1191,15 +1214,16 @@ static void do_setup(int argc, char *argv[])
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
@@ -1217,6 +1241,9 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->needs_hugetlbfs)
+		prepare_and_mount_hugetlb_fs();
+
 	if (tst_test->needs_device && !mntpoint_mounted) {
 		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
 
@@ -1299,8 +1326,12 @@ static void do_cleanup(void)
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
