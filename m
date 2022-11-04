Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5B8C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:08:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 981FA3CB341
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:08:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B2143CB404
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:09 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C2DD200AF3
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 07:27:37 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A45E1di002751;
 Fri, 4 Nov 2022 06:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1eyorjX8j5kMsvQsFN6KlU4QMBZsys7uHzjS3DMzSEQ=;
 b=I9q+4XYmxi+EjD8rv/z85l9KUIkJBy6FoP2i7/Af6UABkhV44rZzpvn3CY/Cl23H0dHV
 M9e/0XMDXS3O58fvL1Jcd7mwjilQWNDDItXZ649hAR6fuEyKO15sG2+sITo6paHAZGeZ
 CTM6gW8YbpZBKEAmcsOtg5JOd7sbflpwBmHpeNIRMp+kZj5ZQMTJgVjeNZrSfw5dqO3H
 a/obtbeBmJrREqXLFFafd8idMJvF6zQRcGheRWus+jYI8aDf/Dc3qe9gVFQOrLjWLrGv
 gF40ZKbGlL1DZFoA6c8WvjdjNuiPougQgRj01y3ZubdxGxI3HTde1BGI0kYjXab7Dpc5 jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphk3cqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:35 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A45Yjc9007806;
 Fri, 4 Nov 2022 06:27:35 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmphk3cpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:34 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A46LhU5009854;
 Fri, 4 Nov 2022 06:27:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04fra.de.ibm.com with ESMTP id 3kgut8yd2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A46RTPU131734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Nov 2022 06:27:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 741414C046;
 Fri,  4 Nov 2022 06:27:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7CA54C044;
 Fri,  4 Nov 2022 06:27:25 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.126.70])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Nov 2022 06:27:25 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 11:57:13 +0530
Message-Id: <20221104062716.615021-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221104062716.615021-1-tsahu@linux.ibm.com>
References: <20221104062716.615021-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UG3o5BzzLc9SE7IFxScDc15B1NL4viiz
X-Proofpoint-GUID: yIg0Slf1MMCC3PhmmJVE9XOnxK0EKbmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040041
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/4] Hugetlb: Add new tst_test options for hugeltb
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
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_hugepage.h |  7 +++++++
 include/tst_test.h     | 10 ++++++++++
 lib/tst_test.c         | 32 +++++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 7fba02c40..46327c79a 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -8,6 +8,13 @@
 
 #define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 #define PATH_NR_HPAGES	"/proc/sys/vm/nr_hugepages"
+#define PATH_OC_HPAGES "/proc/sys/vm/nr_overcommit_hugepages"
+
+#define MEMINFO_HPAGE_TOTAL  "HugePages_Total:"
+#define MEMINFO_HPAGE_FREE   "HugePages_Free:"
+#define MEMINFO_HPAGE_RSVD   "HugePages_Rsvd:"
+#define MEMINFO_HPAGE_SURP   "HugePages_Surp:"
+#define MEMINFO_HPAGE_SIZE   "Hugepagesize:"
 
 extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
 extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
diff --git a/include/tst_test.h b/include/tst_test.h
index a69965b95..acf2421de 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -176,6 +176,10 @@ struct tst_test {
 	int all_filesystems:1;
 	int skip_in_lockdown:1;
 	int skip_in_compat:1;
+	/*
+	 * If set, the hugetlbfs will be mounted at .mntpoint.
+	 */
+	int needs_hugetlbfs:1;
 
 	/*
 	 * The skip_filesystems is a NULL terminated list of filesystems the
@@ -357,6 +361,12 @@ unsigned int tst_remaining_runtime(void);
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
index 8ccde1629..b225ba082 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1021,6 +1021,28 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
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
+			path, tid);
+
+	fd = mkstemp(template);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "mkstemp(%s) failed", template);
+
+	SAFE_UNLINK(template);
+	return fd;
+}
+
 static const char *limit_tmpfs_mount_size(const char *mnt_data,
 		char *buf, size_t buf_size, const char *fs_type)
 {
@@ -1191,15 +1213,16 @@ static void do_setup(int argc, char *argv[])
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
@@ -1217,6 +1240,9 @@ static void do_setup(int argc, char *argv[])
 		}
 	}
 
+	if (tst_test->needs_hugetlbfs)
+		prepare_and_mount_hugetlb_fs();
+
 	if (tst_test->needs_device && !mntpoint_mounted) {
 		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
