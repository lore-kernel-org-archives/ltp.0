Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3775BC001DB
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 06:22:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B2BE3CCDEA
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 08:22:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8285F3C88DB
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 08:22:38 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BAE6D6006DE
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 08:22:35 +0200 (CEST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E63LEx005564; Mon, 14 Aug 2023 06:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FhKGQft4qjyZP36I6TwOsNS2bp4/eWa7V5+CDbaiZ+Y=;
 b=ASnWVOZziO4dQA2Y+E5908/ZyPyYSsl6VxEiAU5m6Brr+hi7xU3gAjzOm3y61hErpeQh
 a/DVHKXp37HyTu9S4cPmEGCAGaYtFlncreilBnnpq71ki/+ECY6vE4FveSPu9YFdZNGj
 K64m+G1ggmCWyY16uFateCNKQO5GZqJklsgtI2S0Ng9gNThWh4qmehc1xEP5ceBI/v2M
 go1CXE3toaYsYLS+31yxWeDliTY4AEd96CCOiGPn2rc43kyqAZ7ZhX21oZAilZ9vmoPh
 uKlFneVqPwj3nE1O+FgZtLd5BdHpEXVV3L1r7hyh7DPniW//qJebuclpXp0T5s5ZGUmb 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfenqrqny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:18:31 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37E648pi008902;
 Mon, 14 Aug 2023 06:18:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfenqrqnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:18:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E6AS53002427; Mon, 14 Aug 2023 06:18:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendmsrmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 06:18:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37E6ISEG24052388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 06:18:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F61020043;
 Mon, 14 Aug 2023 06:18:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC95920040;
 Mon, 14 Aug 2023 06:18:26 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown
 [9.171.10.33]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Aug 2023 06:18:26 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: ltp@lists.linux.it, chris@mips.com, chrubis@suse.cz,
 gaowanlong@cn.fujitsu.com, pvorel@suse.cz, raj.khem@gmail.com,
 tdavies@darkphysics.net, vishalc@linux.ibm.com
Date: Mon, 14 Aug 2023 11:48:08 +0530
Message-Id: <20230814061810.2297146-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kXiBCXMztiXjjkQoEfBi4kqpUj6imekL
X-Proofpoint-ORIG-GUID: XOL4n6WVka91b462SUvyvEUp0KZS6at1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=617 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140055
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Ebizzy Benchmark Tool: Enhancements for Thread
 Safety and Record Count Handling
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch 1: Enhancing Thread Safety in Ebizzy Benchmark Tool

This patch is aimed at improving the thread safety in the ebizzy benchmarking
tool. A potential issue was identified where the shared variable 'records_read'
was susceptible to race conditions when concurrently updated by multiple
threads. This behavior could lead to skewing of the benchmark results. To
mitigate this issue, a mutex for 'records_read' is introduced in this patch. The
mutex ensures thread-safe updates and consequently improves the reliability of
the benchmark. 

Patch 2: Enhanced Record Count Handling

This patch modifies `ebizzy.c` to handle situations with high record counts more
effectively, especially when the count exceeds `UINT_MAX`. It includes adjusting
the `records_read` variable type from `unsigned int` to `unsigned long
long`. This adjustment allows the benchmark tool to handle a broader range of
record counts accurately. Additionally, the patch introduces error checking for
integer overflow during the summation of `local_records_read` to
`records_read`. Upon detecting an overflow, an appropriate error message is
displayed, and the program exits.

These improvements cater to scenarios where `ebizzy` is run with a large number
of threads over a substantial period. For example, when `ebizzy` is run for 60
seconds with 96 threads, and each thread processes between 5 to 6 million
records, the total record count can easily surpass `UINT_MAX`. This would lead
to an overflow. With these modifications, such situations are properly handled
and reported.

Vishal Chourasia (2):
  Enhanced thread safety in ebizzy benchmark tool
  Handle high record counts and prevent integer overflow

 utils/benchmark/ebizzy-0.3/ebizzy.c | 36 ++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
