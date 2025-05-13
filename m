Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF5DC3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 16:57:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4949D3CC34A
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 18:57:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB5E33CB38F
 for <ltp@lists.linux.it>; Tue, 13 May 2025 18:56:51 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9CE99200935
 for <ltp@lists.linux.it>; Tue, 13 May 2025 18:56:50 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D7hfFM019228
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=R2HdxYDT51wFYy7Grduszl4IkjIJd4HH8VMAQAMb9
 xQ=; b=Qn7Iw7cNJ+RgcGUKvFK2RtKm7yiKvGPvGq+ML/OWXbZE82Ph3J6WixEE8
 BKIXjXdSr8W2GuNX+j9KnptpqI1UnGtyNbT0Hehezoz7e9DSax5KV+M1iTOJ0iyV
 z7aWyCqUNEckhJ7sBnuBrdGZsqN1X0zmDU83u5RGhXRJS2RWbG9s+CzMLFcJtx4d
 kNzfeRDcZImgpwvMX8lZmUhNmGlrZkSHjRSKFlXWy6o0dwmvL91UQyML+o2w62ck
 1x+MiE/CPleNXtv7ofh0ck0ogb5Kf6O2GKuagIR+6llF590PrkH8rOZA9NmHc3OR
 /Vdc/z1PaGmc73yEdc4t8H82tkDeA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kpp7ddk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DDuNpc026002
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jj4nv214-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Tue, 13 May 2025 16:56:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54DGuiht51577112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 16:56:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E855C2008B;
 Tue, 13 May 2025 16:56:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C81D220089;
 Tue, 13 May 2025 16:56:43 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.boeblingen.de.ibm.com
 (unknown [9.155.201.149])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 16:56:43 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 13 May 2025 18:56:38 +0200
Message-ID: <20250513165640.185122-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MTldJ0p93ejtRp7L_YUkgMyIJD86Myme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1OCBTYWx0ZWRfX/RoMRNqpRIRU
 cZV9L1Qjk00dba7mHa+tC7t+Tojf4dZUqJfkbHerTmdpQg+dqdZRHtEgvZo+ySIc5dTd8UVx8zI
 7jP+ahxFILks0z6H+mmC2RHPmLhTzgxadaiWhldtk5npNRgX3o9LkzIPGHV6BnqAXwkXsWJn5JO
 bmEz5caXWLosBgn5Hml8L0/D0SiimSvhW7PD62YWLmFmiHpWpcQvEwj4qtoGHoIfo4fbZ1l+NsC
 /REhvFEErO9kgYdCtjlnpIf2E8K/KoJrjrQCd6JvXze2qS8GXOhkhHS0FlNBvo9crGzzBXP+f0T
 TXOk+npRXoo1dTzrMSpPdiVOeVbhyfWPAJMrRHkQrj17n1cYk7f+8VMKxU29K3/HQpd0Vx4m9Oa
 4eS9HDoMVruxX/zRw25ifgWjcdMK9ak1nYWxFFA2puaj6PDcVNjH78utNaW/7JDub8bovhGb
X-Authority-Analysis: v=2.4 cv=ZY8dNtVA c=1 sm=1 tr=0 ts=682379d0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=dt9VzEwgFbYA:10 a=xjfiJxQMLVGwN3IwlnAA:9
X-Proofpoint-GUID: MTldJ0p93ejtRp7L_YUkgMyIJD86Myme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxlogscore=781 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1011 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130158
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v1 0/2] Fix NTFS-related failures in statmount02
 and
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

This patch series addresses two issues in the LTP statmount tests related to
incorrect assumptions about NTFS mounts via FUSE. Both issues stem from
FUSE-based mounting behavior, where the save_mount logic does not respect the
MS_RDONLY flag and reports the filesystem type as fuseblk instead of ntfs.

Jan Polensky (2):
  safe_macros.c: Fix missing ro flag for FUSE NTFS mounts
  statmount06.c: Fix incorrect fs_type assumption NTFS->FUSEBLK

 lib/safe_macros.c                                 | 9 +++++++--
 testcases/kernel/syscalls/statmount/statmount06.c | 8 +++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

--
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
