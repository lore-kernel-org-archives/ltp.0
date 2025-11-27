Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28362CFD2F6
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 07:23:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA9103CB235
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:23:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13FDC3CBD4C
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 08:22:51 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 92367140075B
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 08:22:49 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28Eob004883;
 Thu, 27 Nov 2025 07:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WrITWaLw+sIuxR6jz
 MMyb9PgjaxZhuZBE0q8K9up7pQ=; b=lWEmnCmJeKiTNSkAgVufR/pEf+pg3lIuo
 3V9VnRm9alcT9kjB/sHFHHnis6PsiE4cwe0rjvLxOmIOdUr/KB12UKVU7gIZSo+T
 WHi+jnB9s3MOAMxkjFhdXA0RTcYLWe0KqamHWwx6MSqL9SPK8EDH1Qe+rT2nOFHB
 pKey9kOvKyYPt5qYbqvjkhNHxrxY9jIhCw8XfAiBpVb6vYonpcsMO+EB+SZZetKy
 i/WDooVAf0woOho+lZosxEXA41KBvW6xL0df8ySJEe95RWSNwwG5cP0WS8DlUpl2
 kYKHp/Wsxs864LQTmsvY48dX1gyNuRLrhEC5IU2YqejSro26tKmPQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u26yyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 07:22:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR64D43013916;
 Thu, 27 Nov 2025 07:22:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgnetx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 07:22:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AR7Mg6v60358920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 07:22:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8434620043;
 Thu, 27 Nov 2025 07:22:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A882320040;
 Thu, 27 Nov 2025 07:22:41 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.124.217.43]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 07:22:41 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 12:52:30 +0530
Message-ID: <20251127072231.2104445-2-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
References: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX2KoL9BMQb7vZ
 3E5LyLVHUemm4LLJ7HMxUfFemmVyP/6atoP29wDI6z7WsC/bFxLVK1as9vHekX86CfyWgw+Dt/0
 39oJ6zy+Jd6CI2gvd5doUMxoS1GGoayQToNQF//+dDEqrbtCV+GyISyvE5X62htad9AhxqZjaqT
 Kbo29ijblUwaE3c7Z66K8T+HVgkR8BTDVBCUZwW4918upt5HrtmHAb/zNHf6eDAOH45ynezYrMa
 yCDN7HkGQ07JZ9iFfbm/F3hnMZp+qivxnlRHr7lbWNtum5zSD9tRGKMQOyEWOBra9qmk7+wadhF
 RLwWCaC+TLPPEw++fzlywu9tJGN23KUqoNhyoUHcxxFWQNEH6q9Tia2D0vnZWaq1m3S2tQW65+8
 Bqjdnd1+0ZDoTz+yfU42D2QJRZm4mQ==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=6927fc47 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=13Y0w-MyWRrMoNZ8uN8A:9
X-Proofpoint-ORIG-GUID: y45bhB9A9_c1fcqgqejxK4GsGaTdIwXh
X-Proofpoint-GUID: y45bhB9A9_c1fcqgqejxK4GsGaTdIwXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] Adding magic definition required for hugemmap40.
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Defining HUGETLBFS_MAGIC.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 include/tst_fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index ceae78e7e..c829170fb 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -33,6 +33,7 @@
 #define TST_FUSE_MAGIC     0x65735546
 #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
 #define TST_EXFAT_MAGIC    0x2011BAB0UL
+#define HUGETLBFS_MAGIC	   0x958458f6
 
 /* fs/bcachefs/bcachefs_format.h */
 #define TST_BCACHE_MAGIC		0xca451a4e
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
