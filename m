Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0BF10706DE
	for <ltp@archiver.kernel.org>; Sat, 14 Mar 2026 15:13:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 311EC3E2379
	for <ltp@archiver.kernel.org>; Sat, 14 Mar 2026 16:13:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFC033CE841
 for <ltp@lists.linux.it>; Sat, 14 Mar 2026 16:13:19 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D22F514000FF
 for <ltp@lists.linux.it>; Sat, 14 Mar 2026 16:13:18 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E5r5jW567583; Sat, 14 Mar 2026 15:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=srdS+PNnPVYFaeaLrnriUOmXtM+PQWuFCmzMGUthL
 rU=; b=VWqOBHXF5IXO67QmoXt0I0OrHTS3HSPWvw236UaTCSbPpK+Ik4pmMVke5
 kMdFYuZRXQXE3K3WrrhHhyjSfUFu8chT1OH2Mk6xkN1SF543mUOd+w3kT6BnekpI
 AVoEjzxTlDAV5lEWvEoxLSuETe7Z2zNyfww9hX/73dpOUaM8jTFKRYQtMob3ILHB
 pnxL0a7gvn9PtdHWwvoItgXdUUAE6kQkq7FGL4FqxBZ+ekewPmHAtjqUkABMsdv5
 BI0U0S71AXh0jIYKcGYxLP6GyKXdGLk97I+/OON4kMoaOixoaGvqGdSSVpTEJgR3
 dKZtoruKyMUAcJLVlD6zGMIXPUcYg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybrsfyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 15:13:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62EF8HBl014698;
 Sat, 14 Mar 2026 15:13:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8jmp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 15:13:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62EFDCuP15532364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2026 15:13:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A46DE20043;
 Sat, 14 Mar 2026 15:13:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 400A120040;
 Sat, 14 Mar 2026 15:13:12 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.80.172]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 14 Mar 2026 15:13:12 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Sat, 14 Mar 2026 16:13:02 +0100
Message-ID: <20260314151304.82136-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b57b0b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NDk7QEINfGb4XWn2y_sA:9
X-Proofpoint-ORIG-GUID: oImPX7PGjIHbshSHNxBr1TrKcFo68FNV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDExOSBTYWx0ZWRfX9/GZT7a8nYQ8
 kLJ3TYIjTNvWTsFcflFllQMu7CSCfK7ffBbrqj4zpd3ZSVZP0RVVUI1hFngAijE5+N6jEbpSuy6
 O8mBbCgY3tLEQ2LwAg6g/5zJ3XQvOir+KaWCj0XkYgv8O4UbR8o3XZD+wfEaP36UOqtjzv/MmO9
 m6ZkT3n++VgIz1la7GdfxbuJLjzr/BK3FRoQThFjmWTvkoC37tG7Bmw/6od6Y2FXYDWMsfrTgPU
 0VV46jiNUZuIrEFNdDg/7yQHJ7Uzbjad6LxJLjJ0MaNTb+LznFlOSSsSRuefWQodG4f3CTvieqg
 hEoDgUZqLupj/l0/LL1ibjQKFr+5Oe1SGUnP4vK9oimeoADdn1biM2ogPKUCuPhKVmuJbgCMV4c
 AfnvRW3DvcDCExYjUo3KQMt7RRNHDdgQ4ZnM/IADwcUEObYwtJnNwA2hC0dT27eL5kDML3f6qrQ
 +eZFDek1tR+dmxrStOw==
X-Proofpoint-GUID: oImPX7PGjIHbshSHNxBr1TrKcFo68FNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140119
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] LTP: adjust socket xattr tests for kernel
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

Jan Polensky (2):
  fsetxattr02: Adapt test for kernel 7.1.0+ socket xattr support
  setxattr02: Adapt test for kernel 7.1.0+ socket xattr support

 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 7 ++++++-
 testcases/kernel/syscalls/setxattr/setxattr02.c   | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
