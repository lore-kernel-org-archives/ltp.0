Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59507C4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 15:48:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54F883CB0F6
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 17:48:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16B7A3CACAE
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 17:48:09 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 246E760029C
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 17:48:08 +0200 (CEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFdCJK029106
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=VCGfbDGjweVuIWdJVtWlBJzpfdkgnRDWzVthCQfZJpQ=;
 b=sAt4PskqSbzHZct/J3GvnFA9qo9RTUblwgNfJwlX92pKwG1yfmf91mIUEDYTiSIQv4qI
 xJ/iaZn6oLXTBdXRGWAc7au2aI4R+rS16NI7WGChFtfwxi8fgbWLRJvmG6kwzgGAoyJJ
 JcUFyqXl/3yhh//rdPg0ZNVVPma6XYsTYwYmmZ6mxhVNIjOZDI9ucIm5U/hpnYJRDs4/
 d5Wu1tx7H9JyzDorMRob2VjPOiwEE0C+K6il+mRJRCFDbnA7wmDD+GMoYKBA+4GPsdHm
 JdpVGXKDAmKlagILD9PievAjxzMLSlLi37dqEUWyGFn0lY7gyGAqOo6J+QwRnUdzsCdU IQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kakjg1dky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JFZObf025754
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 3k7mg97er6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29JFm1wm62128458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 15:48:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80B3311C050;
 Wed, 19 Oct 2022 15:48:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A1A711C04A;
 Wed, 19 Oct 2022 15:47:58 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.20.142])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 19 Oct 2022 15:47:57 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 19 Oct 2022 21:17:51 +0530
Message-Id: <20221019154754.75624-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OCqz_mdf6QmvsBtWXGzU9IEU1d5Y_KNX
X-Proofpoint-ORIG-GUID: OCqz_mdf6QmvsBtWXGzU9IEU1d5Y_KNX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=770 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190081
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Hugetlb:Migrating the libhugetlbfs tests
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
Libhugetlbfs is not being maintained actively, and some distro is dropping
support for it. There are some tests that are good for testing hugetlb
functionality in kernel.

As per previous dicussion in RFC[1], Here, this patch series consists
of hugetlb tests taken from libhugetlbfs modified to work in ltp
environment.

Based on suggestion[2], I am reposting the patches again. Also, I added
suggested changes by Cyril Hrubis and Li Wang[3].

ref:
1:https://lore.kernel.org/all/20220908173947.17956-1-tsahu@linux.ibm.com/
2:https://lore.kernel.org/all/87wn8xi61v.fsf@suse.de/
3:https://lore.kernel.org/all/20221016125731.249078-1-tsahu@linux.ibm.com/

Tarun Sahu (3):
  Hugetlb: Migrating libhugetlbfs brk_near_huge
  Hugetlb: Migrating libhugetlbfs chunk-overcommit
  Hugetlb: Migrating libhugetlbfs corrupt-by-cow-opt

 runtest/hugetlb                               |   3 +
 testcases/kernel/mem/.gitignore               |   3 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 156 ++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 166 ++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  90 ++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  75 ++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   5 +
 7 files changed, 498 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
