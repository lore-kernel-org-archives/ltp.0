Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408F7CD1284
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 09:21:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F4C33CC868
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 11:21:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A4C43CD2B8
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 21:57:04 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com;
 envelope-from=samasth.norway.ananda@oracle.com; receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1064A140043E
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 21:57:01 +0100 (CET)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42QKRA9e004538
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=/lUd/XKYTE+jW9Us7H6vJ/1OFrNCJm0/mVdnwnPBSx4=;
 b=QtX7fBb0Bm3VzWIeLcf9/cxCsJmIaruiyNrS7v0TcHFN1IzSSHbKTBky/k+eHEv1Vldy
 U5N0HGPjgwT1k/J8E/4PoVQdxLoof/nD7PRDMCH+ylnTYKUruPS8KYpk+J7EaJWDjFa0
 WQeEAR60n5z6HtrJsHeLEko43i08HIhUUWCS/ry7FzowSrAfOeF63WU+BpYa0Yvkh+eV
 Bu44fYNb630mSBgGcuJpvz140lq1vnDwYH6/SD/HfRvKwKGWOxDQb1zA8g+0VvFPYkOH
 t1R/CcQbBbabN9aPC6YpOakNtz7NMcPe+TtpVDqk516TuectU8Hna9HlB0mM8elor8ZH CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1q4dx4e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:57:00 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42QJSx3a004872
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:56:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3x1nh7tu4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:56:59 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42QKuwIf016438
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:56:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3x1nh7tu4k-1; Tue, 26 Mar 2024 20:56:58 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 13:56:57 -0700
Message-ID: <20240326205657.3103176-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260150
X-Proofpoint-ORIG-GUID: H9a2MH6RERvF202TQlopztHenGRxB5Pl
X-Proofpoint-GUID: H9a2MH6RERvF202TQlopztHenGRxB5Pl
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Apr 2024 11:21:16 +0200
Subject: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
Cc: calum.mackay@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The function fallocate() is not supported on nfsv3. Thus when we run the
mremap06 test over a nfsv3 filesystem the test fails.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 testcases/kernel/syscalls/mremap/mremap06.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap06.c b/testcases/kernel/syscalls/mremap/mremap06.c
index 3bbaf441a..362b03e19 100644
--- a/testcases/kernel/syscalls/mremap/mremap06.c
+++ b/testcases/kernel/syscalls/mremap/mremap06.c
@@ -104,8 +104,14 @@ static void setup(void)
 	fd = SAFE_OPEN("testfile", O_CREAT | O_RDWR | O_TRUNC, 0600);
 
 	ret = fallocate(fd, 0, 0, mmap_size);
-	if (ret == -1)
+	if (ret != 0) {
+		if (errno == EOPNOTSUPP || errno == ENOSYS) {
+			tst_brk(TCONF,
+				"fallocate system call is not implemented");
+		}
 		tst_brk(TBROK, "fallocate() failed");
+		return;
+	}
 
 	buf = SAFE_MMAP(0, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
