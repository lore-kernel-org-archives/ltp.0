Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B07C38142
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 10:06:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA39D3CC75C
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 11:06:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85EF33CB34C
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 11:05:59 +0100 (CET)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A7EF600717
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 11:05:57 +0100 (CET)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30R9TFf5031076; Fri, 27 Jan 2023 10:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=CNWi9yGvfxXpISVza2BNU8HcXJZS0PJacHFsJDozeYo=;
 b=L4za5audrHtCUyG+7sAn26NtrQ9kPIvUmJBDOmvv7qoONt7WB4fgh7+gX+flagnFrrtb
 jJI6gVwaGQ+O97jbfpQWB154+u556IROVTAtXkp5hj8hy2WxKO9ZxCyjJPygEXcKNrzo
 ineFF4QVb+oVkFooO70O2zFS1dLPRQFGwyyEGQuU6Aotfm0p7ulA6PSz0pgdM5CY31s+
 A31HsPwqskl9eYMXqeaIM+pVJHsstIzeUFOcQ0yu+nH9Oif8CnWG4nL0/6nhnhYFTrHK
 XhHW3wjfYPfXiJW5djJRNCWsnQuY+ZTevO1rcAquQEXJsziE6hvwEB6tBQCeeHz5Wsv6 fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n14gvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jan 2023 10:05:55 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30R8aLxT037292; Fri, 27 Jan 2023 10:05:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3n86g8htgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Jan 2023 10:05:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RA2UM0026618;
 Fri, 27 Jan 2023 10:05:54 GMT
Received: from instance-20210517-1606.osdevelopmeniad.oraclevcn.com
 (instance-20210517-1606.appad1iad.osdevelopmeniad.oraclevcn.com
 [100.100.230.212])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3n86g8htfy-1; Fri, 27 Jan 2023 10:05:54 +0000
From: william.roche@oracle.com
To: ltp@lists.linux.it
Date: Fri, 27 Jan 2023 10:05:52 +0000
Message-Id: <20230127100553.29986-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87bksklax3.fsf@suse.de>
References: <87bksklax3.fsf@suse.de>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270095
X-Proofpoint-GUID: A8i45y5QIKtxWUiAvPcacHggPxNAD0Tc
X-Proofpoint-ORIG-GUID: A8i45y5QIKtxWUiAvPcacHggPxNAD0Tc
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v2 0/1] Add some memory page soft-offlining control
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

After a long delay (since August) and many days of work on this topic,
I come back with a new version of this test proposal.
This version is still using a set of threads running the same code and
competing with each other. They all allocate a set of memory pages,
write a sentinel value into each of them and soft-offline them before
verifying the sentinel value and unmapping them - in a loop.

I've tried to address all the feedbacks I had:

- added madvise11 to the runtest/syscalls file [Petr]
- more complete and compliant Description comment [Petr]
- removed no longer used header files
- removed inline comments [Petr + Richard]
- removed unnecessary comments [Petr]
- number of threads dynamically tuned (with limits) [Richard]
- warn about unexpected mmap errors [Richard]
- lower case (not camel) variable names [Petr + Richard]
- removal of an unneeded temporary "copy" variable [Richard]
- removed unnecessary additional checks of SAFE_* functions [Petr]
- removed the min_kver=2.6.33 [Petr]
- added the commit id into the test_tst structure [Richard]
- "make check-madvise11" is now clean [Petr + Richard]

But also:

- separate functions for mmap and madvise (dealing with error cases)
- simplified the page sentinel value setting and verification
- give information about number of threads and memory to be used by an
  iteration of the test
- count the iterations to unpoison the right number of pages in case of
  multiple successful iterations
- moved sigaction setting to setup()
- SAFE_MALLOC() used
- significantly reduced the number of threads used
- significantly reduced the runtime timeout



Note about the tst_fuzzy_sync framework use:
What required the largest part of my work was this aspect that has been
mentioned by Richard, as I agree with him about putting the emphasis on
the competing critical sections of code (mmap and madvise). I finally
could create a version of this test using the tst_fuzzy_sync mechanism
that could reproduce the race condition.
But I chose not to use it for the following reasons:
- my fuzzy version was not as reliable as the multithreaded version to
  identify our race condition -- On a kernel where the race fixed by
  d4ae9916ea29 is still there, the fuzzy version of the test could give
  false positive results on about 10% of the runs, where this
  multithreaded version hasn't shown a false positive in my tests.
- Another reason why I chose to submit this multithreaded test version is
  that it is generally (about 80% of the cases) much faster to fall on
  the race condition than the fuzzy version.

So I hope you'll find this multithreaded test useful.
Tested on ARM and x86.


William Roche (1):
  madvise11: Add test for memory allocation / Soft-offlining possible
    race

 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/Makefile    |   3 +
 testcases/kernel/syscalls/madvise/madvise11.c | 405 ++++++++++++++++++
 4 files changed, 410 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
