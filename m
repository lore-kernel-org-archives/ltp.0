Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B70CD8C88
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 04:42:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E56F63E1C90
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 06:42:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 949883CA390
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:42:22 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6C8FC600901
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 06:42:21 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6570v3ZQ1971966
 for <ltp@lists.linux.it>; Sun, 7 Jun 2026 04:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=FXjtj/6jKSvygv0Uh4D7rs75hyecFP4ms/7qdI6ON
 A8=; b=X3ZPZIvTu0Gd9SSQHo0n8UmvLWU9NjpzGr7zeigGa+l27zFh3i2oFcvjC
 eaDqvMotlJzbsDcB7A4XQkodFmMDJ3ZJ6QU+YPIazYcwHcNC33jZ02hjChK/O0mD
 qobMU5oSULuuy52gCOsB5e+dI79CSBiQu9xsoznT035qwFc387Fm/mO0cg3kK2EK
 hQNmmQflWeXPmug1SkvKu+uWHQhRCrjwQjSwamggBwDp1VJXvp8OhAhlbdbwbl9L
 e9L7SylFUJSHscYokNIcMZfBcnmX/GjiTlh75JAQ9QF53ydti8l48MCOdJTYKPcH
 AkCbACWtF1dMaHPFBPdNGn1WgMrfQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhk37n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 04:42:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6574Yd4O010374
 for <ltp@lists.linux.it>; Sun, 7 Jun 2026 04:42:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvprkkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 04:42:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6574gF7e36962720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 7 Jun 2026 04:42:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17E8D20049;
 Sun,  7 Jun 2026 04:42:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2528D20040;
 Sun,  7 Jun 2026 04:42:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.81.23])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  7 Jun 2026 04:42:13 +0000 (GMT)
From: Praveen K Pandey <praveen@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun,  7 Jun 2026 10:11:55 +0530
Message-ID: <20260607044201.22859-1-praveen@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDA0MSBTYWx0ZWRfX/ls1kdzhUdCT
 3ivbOZTGxGjW+Ycxnlqrh7al8aP1kOTe08NTOQ0S7dfcFPSxuRuLQZUG+Itw3qRHIt4GQMutLk/
 LwKHA40vTZlTVRI3SYkPLSmT1alq3gJQuLg9QTtOcyiVBffK7Vk1cX4aGkjMXYdM1T/WsM3gM9l
 IXSuCiVMtSDKAWx+CkRMOc1eSwVqcAf+rqfSJGKelI3uY6Y0r8brXO1+jT1DXZnP0hx9VRONwDU
 +YVsdyIjTiRSZ9SamMZi5ktr0EBqNucolfPwSZS68KzL6a9HUQs7L25+78VNM8gC1Y4XmrQGqq8
 VOBiuLklUsKUC8ZpXwXM5YOEOePNcN0R9QzEyGt7SDSAQSsAvNX3FPQzdxNKl8iyShuS7E3cpPf
 kp/CX7tKjfQOsjEqCKGK/Wtv9loq3qWIzSr8tXbVVksom4b9GwLz79YkjcdTKRngsC8yCQj4JZc
 +/8xVIKrsA+3LQ1alyQ==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a24f6ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=eJIbC9Kyws5KvAAQrnoA:9
X-Proofpoint-ORIG-GUID: VRjuVGrYbFXEEYFDXE0mIgDt_XjfDNjc
X-Proofpoint-GUID: VRjuVGrYbFXEEYFDXE0mIgDt_XjfDNjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070041
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [LTP PATCH v3 0/5] ftrace: Convert shell tests to C
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

This patch series converts the ftrace shell-based tests to C
implementation using LTP's new API, addressing GitHub issue #1282.

The conversion provides:
- Better integration with LTP framework
- Improved error handling and reporting
- More maintainable code structure
- Consistent test behavior across platforms

Changes in v3:
- Fixed tst_tmpdir_path() usage by adding .needs_tmpdir = 1 to all tests
- Removed incorrect CVE-2015-8550 tag from ftrace_regression01
- Fixed memory leak in TST_RETRY_FUNC usage by assigning to variable and freeing
- Changed [Algorithm] sections from numbered lists to bullet points (using '-')
- Added root requirement documentation to all test doc comments
- Fixed Makefile LDLIBS placement (moved before generic_leaf_target.mk include)
- Created .gitignore for new test binaries
- Removed deprecated [Description] header from ftrace_stress_test
- Deleted orphaned shell files that were replaced by C implementations

Changes in v2:
- Fixed TST_NO_DEFAULT_MAIN placement in ftrace_lib.c (before includes)
- Removed tst_test.h include from ftrace_lib.h (libraries shouldn't include it)
- Fixed include order in test files (tst_test.h before ftrace_lib.h)
- Added proper cleanup of allocated memory in tests
- Improved error messages and test documentation
- Fixed Makefile dependencies and library filtering

Testing:
All tests have been compiled and verified to work correctly on x86_64
and ppc64le systems with various kernel versions.

Praveen K Pandey (5):
  ftrace: Add common library for C implementation
  ftrace: Convert ftrace_regression01.sh to C
  ftrace: Convert ftrace_regression02.sh to C
  ftrace: Convert ftrace_stress_test.sh to C
  ftrace: Remove obsolete shell test files

 runtest/tracing                               |   6 +-
 .../kernel/tracing/ftrace_test/.gitignore     |   4 +
 testcases/kernel/tracing/ftrace_test/Makefile |  19 +-
 .../kernel/tracing/ftrace_test/ftrace_lib.c   | 356 ++++++++++++++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.h   | 139 +++++++
 .../kernel/tracing/ftrace_test/ftrace_lib.sh  | 180 ---------
 .../tracing/ftrace_test/ftrace_regression01.c | 127 +++++++
 .../ftrace_test/ftrace_regression01.sh        |  83 ----
 .../tracing/ftrace_test/ftrace_regression02.c | 102 +++++
 .../ftrace_test/ftrace_regression02.sh        |  63 ----
 .../ftrace_stress/ftrace_buffer_size_kb.sh    |  45 ---
 .../ftrace_stress/ftrace_current_tracer.sh    |  32 --
 .../ftrace_stress/ftrace_ftrace_enabled.sh    |  38 --
 .../ftrace_function_profile_enabled.sh        |  38 --
 .../ftrace_stress/ftrace_set_event.sh         |  46 ---
 .../ftrace_stress/ftrace_set_ftrace_filter.sh | 119 ------
 .../ftrace_stress/ftrace_set_ftrace_pid.sh    |  37 --
 .../ftrace_stress/ftrace_stack_max_size.sh    |  27 --
 .../ftrace_stress/ftrace_stack_trace.sh       |  35 --
 .../ftrace_test/ftrace_stress/ftrace_trace.sh |  25 --
 .../ftrace_stress/ftrace_trace_clock.sh       |  27 --
 .../ftrace_stress/ftrace_trace_options.sh     |  58 ---
 .../ftrace_stress/ftrace_trace_pipe.sh        |  45 ---
 .../ftrace_stress/ftrace_trace_stat.sh        |  38 --
 .../ftrace_stress/ftrace_tracing_cpumask.sh   |  91 -----
 .../ftrace_stress/ftrace_tracing_enabled.sh   |  38 --
 .../ftrace_tracing_max_latency.sh             |  27 --
 .../ftrace_stress/ftrace_tracing_on.sh        |  38 --
 .../tracing/ftrace_test/ftrace_stress_test.c  | 326 ++++++++++++++++
 .../tracing/ftrace_test/ftrace_stress_test.sh | 121 ------
 30 files changed, 1074 insertions(+), 1256 deletions(-)
 create mode 100644 testcases/kernel/tracing/ftrace_test/.gitignore
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.c
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_lib.h
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_lib.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression01.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression01.sh
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_regression02.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
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
 create mode 100644 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.c
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress_test.sh

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
