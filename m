Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B86DC44508
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 15:07:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C46963E968C
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 17:07:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E9E23E56A3
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:06:46 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6072B1A004F3
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 17:06:45 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEfgML1615379; Tue, 14 Jul 2026 15:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=S296ZXQPoJYNwG0dPwlRLS1AuwMLTbhpmIqX617ru
 4A=; b=IAYNJsMPugHDUqNg//9Fw6zuwqkwc/uXNVyM4chKGw56B2pUp1GBbX/4O
 RHrYr1rMbU2VCXkn7PdCLcuw0i1ut/hxrALVqLzeLN2CVvWiFQjFY56TFEXybm/n
 lt5WebEWR25CCh+SBTGtX2XxIivubF/E8kZh6AHm5N2ymeVrAA0v4zjspddMjgZQ
 NnSzJ/g04wxfz0HjVcMag0IxCuXZEgjdAUZAS8foBEtxTcPQt1qBQXKRidU3/n/b
 5+TkkBiqlnYYbW4FxDo2RyL1cZ740xhDKHvw4hFccUMG7V+h0thHYkhf5YyCTVmz
 gvdjAmMrj/9uP933HgbXzhsNJZ14g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt6vny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:06:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EF4fP3029852;
 Tue, 14 Jul 2026 15:06:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jucne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 15:06:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EF6brd23200190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 15:06:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C0A22004D;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7225A20043;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ehn-de.ibm.com (unknown
 [9.224.74.129]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 15:06:37 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 17:06:27 +0200
Message-ID: <20260714150631.250972-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o5NkJgAGu1wfGQ437pqf5YYDzdxsDGzF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfX73Ox7hay7+lE
 M0971wKcN+JCF34evz1RQQLpgGXBhTZu58UHBgJ8EwPhJ3vtKmx0xD8KCR4i/Z1JAWC0nixY+5N
 d9vHRi+f2wm0xYxS2EoR5EslMS0Enok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE1MyBTYWx0ZWRfX8q2yrQV49dmE
 8CfvaeNbDp6YbvMDfVAHOvjY0O2gSaX+p5IL0JT5U7HOY4U4rUu93Piykp++tf0Kb76WJ8axS/p
 AiNcx1Yqzgy1KfyHORp6w02kFO71PwIfr6KNVZlb62jvVBMFs5yvHR0VUhhzZJHNmDyDyYnBKpJ
 U3ZgQNtRHW1Iab5LnUI4VD6peeR4HCQyZNrP/Qc4UNs6TfJKz0/OkMPFwyy/eYsaw/h9LuYXH7g
 tBGSYXMhbnxaRzIXXSaM89oYRdP4t2cKRUS8bNSGqJTASR9b4Qwj1Pq9rkoBMLKIl0+7MY5f53Q
 gwrvMWoJAqoNaBD7zRT60iBcb3NpF4IPHg31ADBB9JDLj6QiIDKPswRGjDgwxv2tdrg45hqJYVu
 NkQdCkcV+d7PuYZ7s1zO78o5NPbjNT4rhd3J0qqV3zkDjhRO/XZNf13XEU5Pk1qnkUVexULVMnK
 EQo68d2C9gEy+bFydYA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a565082 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=bUZvfx3gJ-fX8eLhwmMA:9
X-Proofpoint-GUID: o5NkJgAGu1wfGQ437pqf5YYDzdxsDGzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140153
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/3] Separate ptrace tests for
 CONFIG_PROC_MEM_FORCE_PTRACE
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

thp04 is a CVE-2017-1000405 regression test. If direct
/proc/self/mem writes are blocked by CONFIG_PROC_MEM_FORCE_PTRACE=y,
the CVE cannot be triggered and thp04 should report TCONF.

Add separate ptrace tests for the CONFIG_PROC_MEM_FORCE_PTRACE behavior
instead:

- ptrace12 checks that writing to /proc/self/mem is rejected with EIO.
- ptrace13 checks that a parent can write to a traced child's memory via
  /proc/pid/mem.

Both ptrace tests use read-only mappings, so the writes require
FOLL_FORCE and exercise the CONFIG_PROC_MEM_FORCE_PTRACE enforcement.

Validated on s390x with CONFIG_PROC_MEM_FORCE_PTRACE=y:

- ptrace12: TPASS
- ptrace13: TPASS, 100 iterations

Follow-up to the previous thp04 ptrace mode discussion:
https://lore.kernel.org/all/20260709175927.268677-1-japo@linux.ibm.com/

Jan Polensky (3):
  thp04: Simplify to focus on CVE-2017-1000405 race test only
  ptrace: add test for /proc/self/mem write rejection
  ptrace: add test for /proc/pid/mem writes under ptrace

 testcases/kernel/mem/thp/thp04.c            | 166 +++++++++-----
 testcases/kernel/syscalls/ptrace/.gitignore |   2 +
 testcases/kernel/syscalls/ptrace/ptrace12.c |  99 ++++++++
 testcases/kernel/syscalls/ptrace/ptrace13.c | 236 ++++++++++++++++++++
 4 files changed, 450 insertions(+), 53 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace12.c
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace13.c


base-commit: d139524b04d360c4dabaee61a6066a9a52b0e454
prerequisite-patch-id: fb884fb8843ffadb56383142ca39c8f3f2db898d
prerequisite-patch-id: 16fc00d302aefbf6fb17e972a4390341bfbb0e50
prerequisite-patch-id: 6e77ef09b2259daae915f4a4895bf0879b7b7211
prerequisite-patch-id: 1d13f676c1c1b9b37e97b1e18ae75611a3516f96
prerequisite-patch-id: 11b8f2b102029b41838899f2a78132b50cac12a0
prerequisite-patch-id: 811e85d9a4158f72559de5f551ad93f109362c96
--
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
