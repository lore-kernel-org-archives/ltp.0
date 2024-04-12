Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CCCC4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712899623; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=eHXmcJBhvI1LFwZgVTLy/2+OV0ApkRp2nsaP0ELoZkg=;
 b=NNQ/08ixQ0x+4JOqYSdnINa1vIrTzK8MtpX35MwWwhC6cW39nAZNjMcPuHQe31GAGEdMg
 LVNj+WJxu4MboP3LnfdyuJbHTq7BjA63QrF9zUaq4x0vEUon0gF/C7JxmwbVgFpVjHWAzGk
 psXr1gMqY0p+V8W1K1R+Mf/hPJEmv6o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA8363CF875
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 07:27:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB4613C6DA0
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 07:26:39 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com;
 envelope-from=samasth.norway.ananda@oracle.com; receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1591200BB0
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 07:26:37 +0200 (CEST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43C4Hqcp015476; Fri, 12 Apr 2024 05:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=sVfytZ9bJMGsTA/nhgGwH12vrfD0rZc34bJeySwUr+w=;
 b=Aqtb78eHr1LwiapKRNScqFcyv9TLQosRkseE6ooEHUECDjJeKajpdOoB3Vqvvqxvq72n
 cNCQ5Q3cMsUZUb7A2u2XFj3BTOvQ0ht347w0IJB8k6yn7HvayVOD9FzK/cx4mlZUNKyk
 b1yZoE67Jkafe+WM23NrHxqTKHDK6NpSgwoggoG/r5B8TU7/UR9ilXh1OKLORjUu4CaQ
 8Sc7syWPE7i9TVym7eaWbfoPReyOIXlKPUvQlDNd6JeqRvNeKx3J6m3Dxuz45lFNaieT
 FfETyWyFeiKVUiSiMXdvYseOsndvxmOSC+H33uUXVLlfp6dtVoWUEX8p3vGDpIr/8dWW CQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0uu2d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Apr 2024 05:26:35 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43C51XHv010590; Fri, 12 Apr 2024 05:26:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xavuagc2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Apr 2024 05:26:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43C5QYsY013149;
 Fri, 12 Apr 2024 05:26:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3xavuagc21-1; Fri, 12 Apr 2024 05:26:34 +0000
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 22:26:32 -0700
Message-ID: <20240412052632.1787731-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120036
X-Proofpoint-GUID: mRTYLAK7ZO3Par00oPvUuPZnbFBD8K1K
X-Proofpoint-ORIG-GUID: mRTYLAK7ZO3Par00oPvUuPZnbFBD8K1K
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mremap06: fallocate is not supported on nfsv4.1 or
 earlier
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
From: Samasth Norway Ananda via ltp <ltp@lists.linux.it>
Reply-To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: calum.mackay@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The function fallocate() is only supported over NFSv4.2. Thus when we
run the mremap06 ltp test over an NFSv4.1 or earlier filesystem the test
fails.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 testcases/kernel/syscalls/mremap/mremap06.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap06.c b/testcases/kernel/syscalls/mremap/mremap06.c
index 3bbaf441a..f3df0551c 100644
--- a/testcases/kernel/syscalls/mremap/mremap06.c
+++ b/testcases/kernel/syscalls/mremap/mremap06.c
@@ -104,8 +104,13 @@ static void setup(void)
 	fd = SAFE_OPEN("testfile", O_CREAT | O_RDWR | O_TRUNC, 0600);
 
 	ret = fallocate(fd, 0, 0, mmap_size);
-	if (ret == -1)
+	if (ret != 0) {
+		if (tst_fs_type(".") == TST_NFS_MAGIC && (errno == EOPNOTSUPP || errno == ENOSYS)) {
+			tst_brk(TCONF,
+				"fallocate system call is not implemented");
+		}
 		tst_brk(TBROK, "fallocate() failed");
+	}
 
 	buf = SAFE_MMAP(0, mmap_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
