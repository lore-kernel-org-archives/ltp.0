Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC734C9833E
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 05:19:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662BF3E58ED
	for <ltp@archiver.kernel.org>; Mon, 28 Sep 2026 07:19:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54D303CB860
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 07:19:08 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6346A1400763
 for <ltp@lists.linux.it>; Mon, 28 Sep 2026 07:19:06 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RHajCl216876; Mon, 28 Sep 2026 05:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=rMDWoXHSNo5FBJUkbJeFFt4fPifU9Z7Dx+gzbw91Q
 ik=; b=TQNEpYwTWEf1Hkkxww9osq+kkIWFw4QXUe8RXZLDaQgpmESn+qmxQH2N+
 ifKfLF7Nk6t3FRUJwY3nx9BfOlvVht+8l0fx/uiPkIJSW5uQx2mE0C6sl8OlB9AR
 31TdoY17JEm1V91CzvPGWC5Z+duSScSRLjL+BB9zvxi3if9v3WwL1xq/GrEayQly
 TS807Le/xwY6umLbXvI4tjJmVnBhxpMh/ayeNe7N7SFedLeFKATo65b7jEfFNVJ6
 R1XsSpUNsNDtw3+dYLV5ITf4KgasTK6hR4SHsqvThOUtD72MKj2OI2iUXiuhWm2u
 yON4ZMHgeuBRGvycUZKsZJhGcQ9yQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5psy3sa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 05:19:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S3c15F2157899; Mon, 28 Sep 2026 05:19:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhbpwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 05:19:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68S5IxjK39059838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 05:19:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF9BC2004B;
 Mon, 28 Sep 2026 05:18:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00D3E20049;
 Mon, 28 Sep 2026 05:18:59 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 05:18:58 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 28 Sep 2026 07:17:33 +0200
Message-ID: <20260928051740.591819-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6815YKboKfRoTNdWLPe7iw3UBqi3ZiKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX6aneB2yhtp2K
 691ZjA6FndU4qgB+P88ogs2ahJdgIVl2ISMgPLFV5OP9oUyQqUJjV9Ze5N04Py3fGDltPF/ExGR
 XakdOggtPpdslyjUyK6ddoqiBUs6Zjm8vep7BNFwjKzxhSQR2rJX2iK5PLE2525o6WIqQThJDfJ
 N82l0X3BLaeTqwu/FOcs9u4G9rlK8kLtu7PqLSjDoW5PrjVhlExipiGt74xtwV16SffIv/RLQx+
 eMdhcmZOVszTsW9j6fI++TB92BdIPqLqrSjNYF/Ym/7k+64Kk4GT791EicYsVlCUQtSkDns9LTt
 6+OaTLStzwUtdymf2ucH6jmzHhaiQLnxX7n8DkQp2MzCcyIPaQuVb99WzfOORiE7SwSXWwuEVCs
 NLdksukBOj6kWtyNy3psgAq42Vtc22YIyyTC4lesKDYFORq0f/BkzfPOaAMLrvQsrWSHvBJSGwu
 vgfkEvuKN22jC5IbwBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX/9kryHF/Q3oU
 npyBNR0fyo0dyDknef6w3cWeOsLAl0n7fYZ834lbWDZMzoK62L72+tpv3y+Owgp7J1iaunLG+4z
 W1Nn8C/zVb+1Ly48rkdICXPyVDkavQc=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6ab9f8c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=jRc_dIdUI1FS3t0HffYA:9
X-Proofpoint-GUID: 6815YKboKfRoTNdWLPe7iw3UBqi3ZiKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280020
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] cgroup: Add tests for cgroupv2 cpu.max.burst
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
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

This patch series adds two new testcases to test the cgroupv2 cpu.max.burst
interface:

Patch 1 adds cpu_max_burst01 to test the basic functionality of cpu.max.burst.
It checks default values, read/write boundaries, stat accounting (nr_bursts
and burst_usec in cpu.stat), dynamic updates, and making sure the burst value
is preserved when quota is removed or period is changed.

Patch 2 adds cpu_max_burst_invalid01 to test invalid inputs to cpu.max.burst.
It checks that values like burst > quota, negative values, sum overflow,
garbage strings, and trailing characters are rejected with EINVAL and do
not change the saved burst value.

Both tests are written using the new LTP API and require CONFIG_CFS_BANDWIDTH=y
and the cgroupv2 cpu controller.

Thanks,
Samir Mulani

Samir Mulani (2):
  cgroup: Add cgroup_burst01 test
  cgroup: Add invalid burst test

 runtest/controllers                           |   2 +
 .../kernel/controllers/cgroup/.gitignore      |   2 +
 .../controllers/cgroup/cpu_max_burst01.c      | 650 ++++++++++++++++++
 .../cgroup/cpu_max_burst_invalid01.c          | 417 +++++++++++
 4 files changed, 1071 insertions(+)
 create mode 100644 testcases/kernel/controllers/cgroup/cpu_max_burst01.c
 create mode 100644 testcases/kernel/controllers/cgroup/cpu_max_burst_invalid01.c

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
