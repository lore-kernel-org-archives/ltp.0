Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FD3D58B07
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:27:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 751D73E4B8B
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:27:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 412843E48A1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:27:33 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF4C41A0067E
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:27:32 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62FLqcC3858738; Mon, 16 Mar 2026 12:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ORwM6JNdo0VHXi15Ifgb/+ZAkPM+oQ481E/dohoo/
 LA=; b=PJw0NDn0us2SRLFiys4ID8R5MSxC2+vFa64piiZ/OiyIMmVg5C5Jy86mO
 Fvpx/JzrIOD9ESVRCKiCRnCGnweTTfbCHpZqMiJeqPYyo9hg9keatfwqozdm19k6
 OKTU9OEhaa9x5//v0g7K/5PDv/+qGlP0qSOXWHjetMcz9OU9/HJZcBYbWBcWkKKr
 /fE3Yk9HjQuCxXsrrOQc/kafpsJPoPpH8EstiIvdpzo0sMWWSHxURHrK5+CZrCBD
 W/1ER8rkmsH8CMZg6JOYf653o0FphkIytm9FmDQA5/AknHgPo285Mx+LJJHCEoIz
 4Agk2XveuG87/j7Kj+KKMi9VIDF6g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hqmyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 12:27:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G9mkvW014024;
 Mon, 16 Mar 2026 12:27:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxvufb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 12:27:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62GCRR3p58327324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 12:27:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A62152004B;
 Mon, 16 Mar 2026 12:27:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D2EA20043;
 Mon, 16 Mar 2026 12:27:27 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.83.233]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 12:27:27 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Mon, 16 Mar 2026 13:27:23 +0100
Message-ID: <20260316122725.122719-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7KK9SGYePtzmINctg6IbT78l3A4zuqmW
X-Proofpoint-ORIG-GUID: 7KK9SGYePtzmINctg6IbT78l3A4zuqmW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MyBTYWx0ZWRfX1CHGhTK7OPKj
 H46cXAR0Dor9kF1NSR694+II9n1aeHnPPZqT5J9sfSKMe4j5ZzuJbMFGCYUbkhgvVMIyN4p/bkU
 7ziEDyZJ19ajgH7IuT7Zi8hqT1tB+ZUL2pByfLqQkFDEFZs7+GXVTIo1reVRbxptyQRvlqkGndj
 cl6ocYp22BHKmnw8Pr+09mqTu/KX0FWvAYPlp8UeUagGCLm0HYM8g53KAyphusiUsGos7Ir3OP3
 zm+wtvjcQo+txWc71PHGAPtaiZAOHIddPyfwei1QK5Oukt4/UyDkL20PcvNltlwVmQ/eqY2COyp
 Vj3Q28s7/bFpCLI884UtrmU2UmrfRvT6XLY80Te+g6YouO7h+DDfSwVLaUqw8EAdOAvbeWmkRhn
 mZshJ2xWYjW9SMdNEohFaKmNhccRWOh0KhKEfvfK2QWhcgDWN22bfWgvYirKYIfSJg7klyx4d9d
 wy8jsCWvrvIRLD08Row==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b7f732 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NDk7QEINfGb4XWn2y_sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160093
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] LTP: adjust socket xattr tests for kernel
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

Changes since v2:
- Move kernel check into setup() & add helper (thanks Petr) 
- Alter test description
Changes since v1:
- Fix kernel version 7.0+ -> 7.1.0+ (thanks Petr)
- Fix comments

Jan Polensky (2):
  fsetxattr02: Adapt test for kernel 7.1.0+ socket xattr support
  setxattr02: Adapt test for kernel 7.1.0+ socket xattr support

 .../kernel/syscalls/fsetxattr/fsetxattr02.c   | 22 ++++++++++++++++++-
 .../kernel/syscalls/setxattr/setxattr02.c     | 20 ++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
