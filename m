Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DD606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pmk1wB4i
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28C1B3E9BDD
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 15:45:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 574AA3CFD76
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:44:51 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8B46E1002035
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:44:50 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAELQH2540788; Fri, 23 Oct 2026 13:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=O0iZ7zf9jtmCrZ45dwInCNX+ujHpuYprO3ffjfuY3
 a4=; b=pmk1wB4iu18MJzWWEq0jsVvlUfzwpfw5BYo2VG9vAPAqnDU7axt4p2XSP
 bGCMSxj3gKe110D/oULY63vU5Ufqv/gSjnULc7RO/P587q7idTzQCDrbtAsM8crL
 n5SIrqVKDQF/cN61QPbBZCRTsyUVtd9pfdoqCgKj2Io/HbldDJ6gf8lbeF7Nk1fZ
 zENHtYBqXnxQTzdeyjt5ru6FQdS26i9febRrRmi/RNLj6YVM4n7kKWUiaNLtc4wn
 Vj2Ww9eGi5J6f6TKPRw9A/jgkOsJD4KnSOQ0dm3reG3AQKr3UEYHLOU2Wyj4hpsZ
 3BRhjazxSD9MeH3dkhYl2YUPF5l1Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b4wed-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAJxor2010130; Fri, 23 Oct 2026 13:44:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck5pvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 13:44:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NDihJD28312166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 13:44:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A7172004D;
 Fri, 23 Oct 2026 13:44:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8286B20040;
 Fri, 23 Oct 2026 13:44:42 +0000 (GMT)
Received: from ltcden9-lp5.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2026 13:44:42 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 24 Oct 2026 04:30:40 +0200
Message-ID: <20261024023044.80055-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb64cf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=PSspHyTkfXszmI0gyW4A:9
X-Proofpoint-ORIG-GUID: OaKDY-akKGdLkrKyCabUapRewaFdXyCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfXw1SLNV29LTFv
 p4sgFesdsZrFCye11jxf0tkU2UkEMGRA2hGiVbG9T+d3CrnbT6attd2JIPMNKPtdc1/7yHkq+Kt
 j3gHDNz1hJlBWuN2dUjaeUL4qpQJCfrrFZy4k+PtqAmJVSGK9WBZaouIFJSN0gM5HcOgjgki4Yn
 4d14Oigu7sJE1YuR1Lem97sQ7QZWPU5SYQTJW4M48GLAHbqJcRvlyZz/KLUfHByTTeiCWrYc9lv
 2m0KZPqq/+Ti2WJZ3vR/Y3DC5hJYwh800HD+12GSE0qE1NfQNMqNzkcqt6t42iXeOwQ2lqJinh/
 ztkxKnmqDbz9IyxsnJeeZofGdq9j7NJhcO61MgCgUsUivuM6vAzmgFsXz4gusnLlrhr1kQnG2c9
 mahqtAOIyt+AtHILCXfRwpjMgHHm5Vx2/m/6fjjhfiHU0LgFWqvcE58bvsr5YRG7hPgPOgVvcAh
 hiUhW3q4r4frxHjGwlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfXwnlUzfdoQafF
 93kTa/NolqrmfBL/RVePUR3LXXA0HBfOJMoAtI2OqEdD2rMeX+q0MQF5koLsNqQ/gw7RW/VXwmx
 kNXEbin/sZFJhcbqpr4Ay6fuJTvD3zI=
X-Proofpoint-GUID: OaKDY-akKGdLkrKyCabUapRewaFdXyCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230053
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/4] sched/psi: Add tests for PSI interface
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch series adds four new test cases for the Linux kernel's
Pressure Stall Information (PSI) interface (/proc/pressure/{cpu,memory,io}).

Currently, LTP lacks dedicated test coverage for PSI functionality, trigger
parsing rules, and stall accounting. These tests ensure kernel compliance
and validate PSI behavior.

Test series breakdown:
  1. psi_invalid_trigger01 (1/4):
     Tests trigger input validation in /proc/pressure/memory. Checks that
     invalid trigger strings return EINVAL and valid boundary values succeed.

  2. psi_multiple_trigger01 (2/4):
     Tests that only one trigger is allowed per open file description,
     and second triggers on the same or dup()'d file descriptor fail with EBUSY.

  3. psi_proc_format01 (3/4):
     Validates the file format of /proc/pressure/{cpu,memory,io}, ensuring
     percentages are between 0 and 100, totals never decrease, and CPU full
     stall reports 0.00.

  4. psi_accounting01 (4/4):
     Validates real stall accounting within isolated cgroups (cgroup v2)
     for CPU contention, memory throttling via memory.high, and O_DIRECT
     synchronous block I/O stalls.

Samir Mulani (4):
  sched/psi: Add psi_invalid_trigger01 test
  sched/psi: Add psi_multiple_trigger01 test
  sched/psi: Add psi_proc_format01 test
  sched/psi: Add psi_accounting01 test

 runtest/sched                                 |   5 +
 testcases/kernel/sched/psi/.gitignore         |   4 +
 testcases/kernel/sched/psi/Makefile           |   7 +
 testcases/kernel/sched/psi/psi_accounting01.c | 356 ++++++++++++++++++
 .../kernel/sched/psi/psi_invalid_trigger01.c  | 135 +++++++
 .../kernel/sched/psi/psi_multiple_trigger01.c | 172 +++++++++
 .../kernel/sched/psi/psi_proc_format01.c      | 191 ++++++++++
 7 files changed, 870 insertions(+)
 create mode 100644 testcases/kernel/sched/psi/.gitignore
 create mode 100644 testcases/kernel/sched/psi/Makefile
 create mode 100644 testcases/kernel/sched/psi/psi_accounting01.c
 create mode 100644 testcases/kernel/sched/psi/psi_invalid_trigger01.c
 create mode 100644 testcases/kernel/sched/psi/psi_multiple_trigger01.c
 create mode 100644 testcases/kernel/sched/psi/psi_proc_format01.c

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
