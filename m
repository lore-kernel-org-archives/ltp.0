Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296EAC00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 08:14:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90CA13C95DC
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 10:14:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61C513C0895
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 18:11:29 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0F99F20075E
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 18:11:25 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278FY3ps029524
 for <ltp@lists.linux.it>; Mon, 8 Aug 2022 16:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject : date : message-id; s=corp-2022-7-12;
 bh=2JjPVKJsvkmU63BSudHAEmSXdO6+Aq3WqrXCNMzCuxY=;
 b=bENpYOtJJzab4ujtklendW0KYSMQ2w53YlMaqzdmHgf+fH1AiACKII6tWANXSob0igG/
 ob9xYAfNDbzfizG8P5VRAm8B01uS+Y206cYECq81+EmXslxD004rfLVjKdh+a2bwxvBh
 Xo31TQ5dnkZhy8qGvOps9u4HlQjnjH8HvrW9V5jODPfW6hpeuaD2toc24Xwuavw/7c6t
 eNnrTZT+/8XcRrFWQtKVBflzyn6EpIGF+ImzGKC9DKbZhRGrKVkbhkLk9UB+daVTbZw5
 ttVC6G/z7dFqdhtGibEsIizzps6B1HWroVrflzAj4khiuVHZcKSxnJOg18NN6wursdXI HA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsew143m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 08 Aug 2022 16:11:23 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 278G6X2q007794
 for <ltp@lists.linux.it>; Mon, 8 Aug 2022 16:11:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hser2269x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 08 Aug 2022 16:11:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 278G8O4C013776
 for <ltp@lists.linux.it>; Mon, 8 Aug 2022 16:11:14 GMT
Received: from boul.nl.oracle.com (dhcp-10-175-46-231.vpn.oracle.com
 [10.175.46.231])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3hser2269b-1; Mon, 08 Aug 2022 16:11:13 +0000
From: William Roche <william.roche@oracle.com>
To: ltp@lists.linux.it, william.roche@oracle.com
Date: Mon,  8 Aug 2022 18:11:11 +0200
Message-Id: <1659975072-29808-1-git-send-email-william.roche@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=930
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080078
X-Proofpoint-ORIG-GUID: _0MInOl_Hn2uaxjunuVdQVHv7qJAX9zH
X-Proofpoint-GUID: _0MInOl_Hn2uaxjunuVdQVHv7qJAX9zH
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 10 Aug 2022 10:14:29 +0200
Subject: [LTP] [LTP PATCH v1 0/1] Add some memory page soft-offlining control
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch is offering a new test to the LTP test suite to control the behavior
of the memory page soft-offlining: its goal is to stress the soft-offlining
mechanism while allocating memory. It verifies the content of a memory address
after a Soft-offline, and tries to reproduce the coditions of a race condition
where newly allocated page could generate a SIGBUS when touched.
(See Kernel upstream commit d4ae9916ea29 "mm: soft-offline: close the race against page allocation")

It is inspired by the existing memory allocation test:
testcases/kernel/mem/mtest07/mallocstress.c

Code tested on ARM and x86.

William Roche (1):
  syscalls/madvise11: Add some memory page soft-offlining control

 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/Makefile    |   2 +
 testcases/kernel/syscalls/madvise/madvise11.c | 381 ++++++++++++++++++
 3 files changed, 384 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
