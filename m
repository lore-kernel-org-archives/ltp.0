Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E8BC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:57:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E4DC3D0B4D
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 13:57:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A43C83C74EA
 for <ltp@lists.linux.it>; Sun,  9 Jun 2024 15:01:38 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=vineethr@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 30731200C27
 for <ltp@lists.linux.it>; Sun,  9 Jun 2024 15:01:35 +0200 (CEST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459D1Ui3014933
 for <ltp@lists.linux.it>; Sun, 9 Jun 2024 13:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=gDnUnvHV7XNzq/0NKDtBowks5I
 7bL5BvCJsOAJ1trZc=; b=cuzmsnJMtKbNqknwjCsL/YG6Tl0YynlZuSXvTYY6RQ
 h6H+bwuj2l1j3amDZeAPlcN6GoTTcBmk+Dgc+LlN0SqdTi7UBAOCTPNFyC1ldbYJ
 ebX1YUFRl5xTlp89U76MykqPPm1nSO8i8KKM5C34mSyv7i94PA7VXTvJsv5bNxoc
 jRH9SbuiiAK/A9N1+jGFClNnnP7FK0jQcp8FRi5KlGWZTOkDUKFe72z4j587/BgO
 /NpbVM+kq1v7KPjHNM8fPIB/8k69ojSc944JBbN6mn8wYT+mBJmvf7MjxD2jNHo6
 frJoaFYGi4pwnkrVBGNjc2qIN45JK5HjlWOyj85P54Hw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yncve8042-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Jun 2024 13:01:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 459CGUr0008700 for <ltp@lists.linux.it>; Sun, 9 Jun 2024 13:01:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn4b2sv2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 09 Jun 2024 13:01:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 459D1Q3B55902584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 9 Jun 2024 13:01:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 374452004B;
 Sun,  9 Jun 2024 13:01:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6D3420063;
 Sun,  9 Jun 2024 13:01:24 +0000 (GMT)
Received: from li-fdfde5cc-27d0-11b2-a85c-e224154bf6d4.ibm.com.com (unknown
 [9.43.45.7]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  9 Jun 2024 13:01:24 +0000 (GMT)
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  9 Jun 2024 18:31:20 +0530
Message-ID: <20240609130120.62790-1-vineethr@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f48caVgDX3iSF90HL_iykA2aQwUTOWLE
X-Proofpoint-GUID: f48caVgDX3iSF90HL_iykA2aQwUTOWLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_09,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=913 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090102
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 10 Jun 2024 13:57:00 +0200
Subject: [LTP] [PATCH] ebizzy: Fix a typo in README
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
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixed a spelling mistake in the README ("anre" to "are").

Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 utils/benchmark/ebizzy-0.3/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/benchmark/ebizzy-0.3/README b/utils/benchmark/ebizzy-0.3/README
index 6552f420d..57797d3b2 100644
--- a/utils/benchmark/ebizzy-0.3/README
+++ b/utils/benchmark/ebizzy-0.3/README
@@ -11,7 +11,7 @@ Compiling
 ---------
 
 First configure ebizzy for your platform by typing "./configure".
-Currently Linux and Solaris anre supported.  Then type "make".  The
+Currently Linux and Solaris are supported.  Then type "make".  The
 resulting binary will be named "ebizzy".
 
 Running
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
