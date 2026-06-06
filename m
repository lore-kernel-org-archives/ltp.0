Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6938ECD8C8E
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 14:32:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740113E5462
	for <ltp@archiver.kernel.org>; Sat,  6 Jun 2026 16:32:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F3273C73EE
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:31:54 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD8A1100043A
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 16:31:53 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6560PI1x3235884
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0u19g/hU5xxbR9hsZf9eVoHXgLqcRvT4pouNeREGl
 Bg=; b=C2Tg93niP+/4y2vJU+f+en3IyTm6dk+b5BrGZ+z235IxwghJthyGvXIXS
 737wulCqWt+vG8jMnvBTkh4JMkMg2objqoRPVTxeKWXsV+K01OyQDUUOip0pF8Vw
 Essbgl/BIn96LoumgBqZzuC5hwxfLWgvBAunAR/sqM8L3PdPFv4IUFVYLET89SaJ
 FwaYKmSryhbD8wVI6a4oWooWym2OwODwisRujGWhPun4V2sCtDX0lZr9PJfWMouY
 /Q/tzAsiOtZQOYiO71ynKnuk4GEpweRxsw+dQP3OaE/sthpICWLt+C3tjFBYC6Ke
 ATVvBHaWwcGOtdqUxv/atI9QPEMgA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhhh0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656EJdIm001928
 for <ltp@lists.linux.it>; Sat, 6 Jun 2026 14:31:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhwwjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 06 Jun 2026 14:31:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656EVlg553608894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 14:31:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 178B420043;
 Sat,  6 Jun 2026 14:31:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EC5320040;
 Sat,  6 Jun 2026 14:31:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.127.204])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 14:31:46 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat,  6 Jun 2026 20:01:28 +0530
Message-ID: <20260606143133.89156-1-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE0NCBTYWx0ZWRfX4K6n2kD3sHFe
 TM9SQiBbce4O+cojQvaz1NBK9HM0R8psDsqvvZxi3txJRN4v5diSjP85+y1IW7pL0DBNLkJfJ8V
 xW7Omy26u3U5L/E5lQVLV6NOJ3tBysWwrOTwUsZCstOXafZYoKGDsh61xi5vM7iFn5MKfE7DeQG
 oSKGzeZD3LP91DyzPMlEX1ppZoWOeIlsMtIj7uSYiCJLclcBmSsj+ZHxiEK6fkO9DcFU++jjZO8
 4gmmDGCyKfLMJ1Md/ZPpm2nrPJMvlljACOWvAxgJjAk+VvqSNRE78t1Nlf6BkfGD8VVrMp3LWTb
 gvyRChqqf4RWujuHtpTQcm/H/Ro12lt0+aGDjZXvtcuDLVKpNwdkmfySy/WyLzYLkbX8Y7qj6XV
 9eKLjjDHx/iQ8GqutHOaJzeggxV6qsVB26yx0pB9gdU2J+Dd6xSwHvM0gTnVNuHH0s8QSjMTdT3
 vfMBjmdsM2GFsSlA1Kg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a242f57 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8 a=k2bjv0AjNGqEt0crQ50A:9
X-Proofpoint-ORIG-GUID: M5JwoPwQKcSU_Yj4ok55RikOtt4VE-bR
X-Proofpoint-GUID: M5JwoPwQKcSU_Yj4ok55RikOtt4VE-bR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060144
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH 0/5] ftrace: Convert shell tests to C
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

This patch series converts the ftrace test suite from shell scripts to C
using the LTP new API. The conversion addresses several issues found in
the shell version on newer kernels (6.12+, 6.18.1+).

Key improvements in the C implementation:

1. Proper file existence checking before access
   - Fixes "No such file or directory" errors
   
2. Better error handling with TCONF reporting
   - Reports TCONF when features are unavailable instead of failing
   
3. Graceful handling of write errors
   - Fixes "Invalid argument" errors during cleanup on newer kernels
   
4. Multi-threaded stress testing
   - Uses pthread for concurrent testing of multiple ftrace features
   - Replaces 18 separate shell scripts with integrated C functions
   
5. Better performance and lower memory usage
   - No shell interpreter overhead
   - Single process instead of multiple shell processes

6. Removal of obsolete shell scripts
   - The ftrace_stress/ folder is removed as its functionality is now
     provided by ftrace_stress_test.c

The shell scripts in the main directory are retained for backward
compatibility during the transition period.

Testing:
- Built successfully on x86_64 and ppc64le
- All tests pass on kernel 6.12 and 6.18.1
- No regressions on older kernels (tested on 5.15, 6.1)
- Verified proper TCONF reporting when features are unavailable
- Stress test runs stably with all concurrent threads

Related GitHub issue: https://github.com/linux-test-project/ltp/issues/1282

Praveen K Pandey (5):
  ftrace: Add common library for C implementation
  ftrace: Add C implementation of ftrace_regression01
  ftrace: Add C implementation of ftrace_regression02
  ftrace: Add C implementation of ftrace_stress_test and update build
  ftrace: Remove obsolete shell scripts from ftrace_stress folder

 testcases/kernel/tracing/ftrace_test/Makefile  |  18 +-
 .../kernel/tracing/ftrace_test/ftrace_lib.c    | 348 ++++++++++++++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.h    | 142 +++++++
 .../ftrace_test/ftrace_regression01.c          | 131 +++++++
 .../ftrace_test/ftrace_regression02.c          | 103 ++++++
 .../ftrace_test/ftrace_stress_test.c           | 324 ++++++++++++++++
 .../ftrace_stress/ftrace_buffer_size_kb.sh     |  32 --
 .../ftrace_stress/ftrace_current_tracer.sh     |  32 --
 .../ftrace_stress/ftrace_ftrace_enabled.sh     |  26 --
 .../ftrace_function_profile_enabled.sh         |  26 --
 .../ftrace_stress/ftrace_set_event.sh          |  26 --
 .../ftrace_stress/ftrace_set_ftrace_filter.sh  |  26 --
 .../ftrace_stress/ftrace_set_ftrace_pid.sh     |  26 --
 .../ftrace_stress/ftrace_stack_max_size.sh     |  26 --
 .../ftrace_stress/ftrace_stack_trace.sh        |  26 --
 .../ftrace_stress/ftrace_trace.sh              |  26 --
 .../ftrace_stress/ftrace_trace_clock.sh        |  26 --
 .../ftrace_stress/ftrace_trace_options.sh      |  26 --
 .../ftrace_stress/ftrace_trace_pipe.sh         |  45 ---
 .../ftrace_stress/ftrace_trace_stat.sh         |  26 --
 .../ftrace_stress/ftrace_tracing_cpumask.sh    |  26 --
 .../ftrace_stress/ftrace_tracing_enabled.sh    |  26 --
 .../ftrace_stress/ftrace_tracing_max_latency.sh|  26 --
 .../ftrace_stress/ftrace_tracing_on.sh         |  26 --
 24 files changed, 1064 insertions(+), 538 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.h
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_current_tracer.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_ftrace_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_event.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_filter.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_set_ftrace_pid.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_max_size.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_stack_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_options.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_pipe.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_cpumask.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_on.sh

-- 
2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
