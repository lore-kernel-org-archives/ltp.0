Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AC4C05027
	for <ltp@archiver.kernel.org>; Mon, 20 Feb 2023 10:27:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83B773CBCFB
	for <ltp@archiver.kernel.org>; Mon, 20 Feb 2023 11:26:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A1FC3C03AE
 for <ltp@lists.linux.it>; Mon, 20 Feb 2023 11:26:49 +0100 (CET)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C6B50100067C
 for <ltp@lists.linux.it>; Mon, 20 Feb 2023 11:26:47 +0100 (CET)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31K9DsxC028915; Mon, 20 Feb 2023 10:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=0Ro9dKgCXHnG+qKrBBhprZ2m62T/XgpDWBR+zvVEq0I=;
 b=c5vZ9lIHrCoq1SH1IRS5g+WL9fcd6ec2wl1yWoef3wC9DnvArY9QTVQbpnuBl3PAZCwy
 4sqCn2fbb+I5Qs10pKDZAn+loaqMAp99+c38YR/kUC8kDYPrGaLUF+YWpYjMj+o/Ewq6
 8WlQW5g1c0F5xREj48IiOvdnrb85obu25nFQnRszfPh9mEjUnITZqqaaj7Lo/GHPYXUp
 kcKYa1ZrSkzlWm1tAUB0NwhH50+ZwI1PXLS3PanSECwVPtLRGulvgRt5AVcmTnco2uT8
 B1X8V+IXldFOOnWWmQWGWQxcWbSr41gL0Inl0VKV9npiUZzVr5YJVCti/3vIYgO+a5uA bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcasxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Feb 2023 10:26:46 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31K9silA023408; Mon, 20 Feb 2023 10:26:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ntn43sbe2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Feb 2023 10:26:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31KAQU3S032696;
 Mon, 20 Feb 2023 10:26:45 GMT
Received: from instance-20210517-1606.osdevelopmeniad.oraclevcn.com
 (instance-20210517-1606.appad1iad.osdevelopmeniad.oraclevcn.com
 [100.100.230.212])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3ntn43sbdt-1; Mon, 20 Feb 2023 10:26:45 +0000
From: william.roche@oracle.com
To: rpalethorpe@suse.de, ltp@lists.linux.it
Date: Mon, 20 Feb 2023 10:26:44 +0000
Message-Id: <20230220102645.16842-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87h6vpq2lk.fsf@suse.de>
References: <87h6vpq2lk.fsf@suse.de>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200093
X-Proofpoint-GUID: v9vKD8KDjJ3KLsO8q1FpAnE7dLsXely4
X-Proofpoint-ORIG-GUID: v9vKD8KDjJ3KLsO8q1FpAnE7dLsXely4
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v3 0/1] Add some memory page soft-offlining control
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
Cc: william.roche@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: William Roche <william.roche@oracle.com>

Thank you very much Richard for your feedback about my previous patch version
proposal.
In this new version I made the changes you suggested:

- Changed the signal handler to avoid using unsafe code like "tst_res", and use
  a variable (with its mutex and cv) to inform an additional thread to end the
  test on a SIGBUS. The signal handler doesn't return to avoid a loop of SIGBUS
  delivery.

- Changed the code to use SAFE_MMAP and SAFE_MUNMAP

- The find_in_file() function could not be removed as I use it to verify if the
  hwpoison_inject module is already loaded or not, but I simplified it.

- And I'm now using getmntent() code to identify the debugfs mount point on the
  machine, and open the <debug_fs>/hwpoison/unpoison-pfn location.

Compile and check-madvise11 are clean, code tested on x86 and ARM.

Cheers,
William.


William Roche (1):
  madvise11: Add test for memory allocation / Soft-offlining possible
    race

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/Makefile    |   2 +
 testcases/kernel/syscalls/madvise/madvise11.c | 424 ++++++++++++++++++
 4 files changed, 428 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
