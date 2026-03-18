Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69110103E160
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:13:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E28D23C72BE
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:13:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5287F3C2EA3
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:13:14 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A9801A00CB7
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:13:13 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HJ7xjL711139; Wed, 18 Mar 2026 11:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QCQiXOOAqlof7Sfq6DKSpSt/7yFweX5tf8fKf9zEw
 +4=; b=fV6rGgjHmVsDdf6V+VNwu3yeBbHt8GUjVKIG+5fX02iZTJu4kX6RrRD75
 Ol/3RniGEOp6/T+dpDU8Xfs2vNju4DKsfQ1wlo0GJizobz/lw3stzd5xiNtFT1W0
 pBrl8MdBhygBc72BpL28cJSm15JSH9FYK9n94sYkqJn5kgL8945vDI41hvEVUh/z
 eAPBTHl0knerL7PlxXE8ezakJKgrLwS1mRRvFFqvEsmXavQZMSC2bBwtiKJeGiKx
 13S5T13NdUPlAdWfWBNiJ0W/rjAd8SRcrwLLrCHQjwOzZR3cyTWwfwigPYvAwJF6
 vgnqJek0Xcz7vb8dsbWfPKOGMgnsA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d0y4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 11:13:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I8nmke004581;
 Wed, 18 Mar 2026 11:13:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sdtd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 11:13:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62IBD8bW54264210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2026 11:13:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A60582004E;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E30E20043;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.aag-de.ibm.com (unknown
 [9.52.197.53]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Wed, 18 Mar 2026 12:13:04 +0100
Message-ID: <20260318111306.98139-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69ba88c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NDk7QEINfGb4XWn2y_sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5NSBTYWx0ZWRfX10zTcb27UQRI
 C2VyUqUXoy8kCcB/+EnztLbIcHk5O3Nn2v5nGcIigbIRscmYQFrPztyzcFSd/LsQ4RysmS0uzyZ
 uUIPhIwcviY+cwvQb99dukFW11bJknUq2AMZyzee9MVdSiHVGd281s5FAKhsSwFERr0spxV8kqT
 nk1Nn6TPK2wvoZXycH7xSQG0f8uqs9oy1a4Rrg85LjHNmFdGwmiwDDCa19Faarr5uNFkH7Z83Eb
 FgNlaG2YqzlcZ4uCUa+8wBzDUAJdlZjK0ooMb+AWazW70dAqpzQ4hJxiBZyAr59lf+yQTgj41aK
 tVujWMYO27wk1drpK+SJP9brwl07w4c6QI0W10p8bzmppWTYQLhiWRw8PkFXOgWNEIWLra87KMF
 iOg5dlqFOUjHElR10fNNuMIRUWvzYMlagkLSCOdtO91ntbRZTU5C2R3bUKdq/+mZKa3itPO6pq6
 M5qS6bKahCTEsel2nrQ==
X-Proofpoint-GUID: jofSapBzQ5q_rmATwU03xLtu9Pz5CQyu
X-Proofpoint-ORIG-GUID: jofSapBzQ5q_rmATwU03xLtu9Pz5CQyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180095
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] LTP: adjust socket xattr tests for kernel
 7.1.0+
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Linux 7.1.0 allows user.* xattrs on sockets (dc0876b9846d). Update
fsetxattr02/setxattr02 to expect success on 7.1.0+ (instead of -EPERM).

Changes since v3:
- Simplify the logic (thanks Andrea)
Changes since v2:
- Move kernel check into setup() & add helper (thanks Petr)
- Alter test description
Changes since v1:
- Fix kernel version 7.0+ -> 7.1.0+ (thanks Petr)
- Fix comments

Jan Polensky (2):
  fsetxattr02: Adapt test for kernel 7.1.0+ socket xattr support
  setxattr02: Adapt test for kernel 7.1.0+ socket xattr support

 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 15 ++++++++++++++-
 testcases/kernel/syscalls/setxattr/setxattr02.c   | 13 ++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

--
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
