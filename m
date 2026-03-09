Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C2EF3717
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 17:22:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4BDA3DED72
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 18:22:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22A553DD46B
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 18:21:43 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5D5636003C4
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 18:21:42 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629FsbRo1602460; Mon, 9 Mar 2026 17:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=z094CI5AjDlfQpJbG90v3QymERtN6Isa+pyJx9LB9
 38=; b=fTEBctiwhaHck4E3XMCgbEchhHwl1UjisQ/SAE9ZPf/lIfH8EaHypyo4T
 S1w4/jc6jfxqjSemVArcI/3stMs4m6f99eN9jGhf098hZso+4rybsZAuGoTP85qH
 ngSCZbDPyweHXEYoORlBYQfRSJZZR1RxMRrzZQBQNJzeYUvcYSncBxiJXfdL5GkS
 ctmd/SuBRFMZl5OfKNU1yQEas2lS9otl6jV+dvf+eeX9ksjHoHVsAhZUe8Cn81Lt
 3oDXC2gCYsyOV/ORNGEYR5nQf8ZVjRVqI1a4Oop3raiEZaNHdalSprRBn44gTC5a
 eVMFrr+dj80HPHQxeCuIBDqlPHzYg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr7f1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:21:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629ESoFL015652;
 Mon, 9 Mar 2026 17:21:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybn5w2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:21:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629HLbSh51052934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 17:21:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF22020043;
 Mon,  9 Mar 2026 17:21:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7781820040;
 Mon,  9 Mar 2026 17:21:37 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.155.142]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 17:21:37 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Mon,  9 Mar 2026 18:20:54 +0100
Message-ID: <20260309172057.272946-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1MyBTYWx0ZWRfXzNuAO14hOfXR
 YNlJDF9O7vwypHJ+gUpCfVHCL3T133DZjkb0j74a/IpyWdk3+xddARiiXfN8d+B9CWnSQNwZIxO
 3Da4/GAtGnGVOh8N64tJhnrWA/CW+oXAZH7ucjlUw0q+J9M7iLZ9a+a+C9dt445iGFlWDvxaYza
 e0s3P4g1xJ/IR8sg2Nd9AB30wnnDGt/10rSBjGsP2VaGpsG9cu06bnF5IMuM9E/fUMWyEht+aqN
 oIMl4Dh24TjwC/ZPP/+3mEhx4WyhlkzsgFGlNxpJxpSXQQeWSULZ2OPbTF8DFk1N/noTb7b7nZ4
 ijImCcWIjTSbqk1+hSwUNtTMLmqXfP9vrXG1/ZVNcsR0TwmXO0T3Qt1N24XkoBfRu2kE4frawwX
 HWUXDhrPZETo1BQcPolq4ss/UYxLE2b15RNwaUi3BMi3j8eEU/mqqmjEbQdKeyxz/gUYeGLEVOE
 KDTVhuwmEYlj7lGkt4Q==
X-Proofpoint-GUID: PL_XM1AoK9oO-fXRgOKcH7gkaPcm3ZRx
X-Proofpoint-ORIG-GUID: PL_XM1AoK9oO-fXRgOKcH7gkaPcm3ZRx
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69af01a4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=-UZbGPPa-7BhyAQF3zgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090153
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/3] LTP: adjust socket xattr tests for kernel 7.0+;
 add .editorconfig
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

Linux 7.0 allows user.* xattrs on sockets (dc0876b9846d). Update
fsetxattr02/setxattr02 to expect success on 7.0+ (instead of -EPERM).

Add .editorconfig for consistent formatting.

Jan Polensky (3):
  fsetxattr02: Adapt test for kernel 7.0+ socket xattr support
  setxattr02: Adapt test for kernel 7.0+ socket xattr support
  editorconfig: add consistent formatting rules for LTP

 .editorconfig                                 | 36 +++++++++++++++++++
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   |  4 +++
 .../kernel/syscalls/setxattr/setxattr02.c     |  4 +++
 3 files changed, 44 insertions(+)
 create mode 100644 .editorconfig

--
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
