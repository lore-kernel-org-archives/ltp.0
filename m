Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D111C54E60
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 12:08:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B3A83D0618
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 13:08:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D19253CE7C6
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 13:08:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=meted@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B9F5F204735
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 13:08:36 +0100 (CET)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CBq6M2016935
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PuhZ5nqiJZNfz6l+7+FY9HywlB9h63b4iFnyhXF0D3k=;
 b=KcnwAU79Fp/CJTCLZ7S+eAHsqeO9FEbb9KwI+CbvMw5zpvprNPDcBVH25kQGOl77YGxy
 gd90Vksodfij5X/j+GiqRNyjLNsSdMO1DveBxYvgZ2Nvu65V8ihJYq97RtXKGj0s5I/+
 znPP4UgqIN+yi5VQ8JINSwon5rmy0rQYNn+0ByEjeMVX3ETfLEpA1cVY/Tm7K7WPGl6h
 B8Pkzo2zz6DZnpfUYaCen/uNWbFJ5CyoJDhsem9kfNyyW0YsvRKP9W+rtmRmAHXJ6mlb
 heyy8PJTMC6HT/CRbsGUjLdgexFtRedVj0bRJV520lD4/4RzuZa2UXE1Rhab33yg0960 ig== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtpj4gbr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42CAPUXo013169
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4ak6hdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42CC8U3034472288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C65E2004D
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E15472004B
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:29 +0000 (GMT)
Received: from lenovoibm.ibmuc.com (unknown [9.171.44.81])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 12:08:29 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 12 Mar 2024 13:08:28 +0100
Message-ID: <20240312120829.178305-1-meted@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a-mK5zMpbJ0gs0qFRgg0EbCqxjJJ8Ll0
X-Proofpoint-ORIG-GUID: a-mK5zMpbJ0gs0qFRgg0EbCqxjJJ8Ll0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120093
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/1] fix fanotify anonymous pipe testcases
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

* v1 -> v2:
- accept both EINVAL and EACCES when SElinux is configured.
  Checking SElinux policies would be too much effort.
- replace TST_EXP_FD_OR_FAIL with TST_EXP_FAIL since fanotify_mark()
  returns 0 on success and -1 with errno on failure.

* v0 -> v1:
- sent wrong patch

Mete Durlu (1):
  fanotify14: fix anonymous pipe testcases

 .../kernel/syscalls/fanotify/fanotify14.c     | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
