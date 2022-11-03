Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2330C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 05:43:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0E193C8AF9
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 06:43:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90F5D3C8AF9
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 06:43:36 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C0C56008DB
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 06:43:34 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A35MBCg024190;
 Thu, 3 Nov 2022 05:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UCFlnjjDUhFfcfA79or94EfsOs67iwu+iie+7AeS3sA=;
 b=leOfugWeklHXMApQTMRmnYXpnTnqqFLRCE8BMgwfJnHRTw8S4JhO/0NEE2vpGk2Fp/D8
 5fTX1pKNPuJcrm2Je6eZ/chYFNYQoakvvES1XFqqzexqttEpEm4o9UA6IB5vdpuRZp9F
 fSN/UOpo9JdDVAUyHpRBmGvOpn6bVUejPWZN64lE5X81EMcC+opGC2UcKSFi/IPl+n6G
 +feYByH4LLtDcAtMQ4nu6dD0e6ZS/34EHyMfp/YqRFffE2fxqcjSOcj34IxdoE/Qqs99
 vCJaOvcj7sQRuUqFWTakvsNLCimR9RALY84Z/+L/mHV6ZuB4FcfUWg6Do589IYBpyIBx RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km7ebggd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:33 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A35gGoA022020;
 Thu, 3 Nov 2022 05:43:32 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km7ebggc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A35apAX000625;
 Thu, 3 Nov 2022 05:43:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 3kgut98462-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Nov 2022 05:43:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2A35buN144040528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Nov 2022 05:37:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D11144C040;
 Thu,  3 Nov 2022 05:43:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2005B4C04A;
 Thu,  3 Nov 2022 05:43:24 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.64.81])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  3 Nov 2022 05:43:23 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  3 Nov 2022 11:13:14 +0530
Message-Id: <20221103054317.499221-2-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103054317.499221-1-tsahu@linux.ibm.com>
References: <20221103054317.499221-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0qnz2_HIe_wMuXsDZBSaorp299ML3v8y
X-Proofpoint-ORIG-GUID: x4B8Niryc0sKUE1fDiyD0i2RnWHTXCm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030039
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/4] Hugetlb: Add new tst_test options for hugeltb
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
 include/tst_test.h | 10 ++++++++++
 lib/tst_test.c     | 32 +++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

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
