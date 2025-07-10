Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7178C83F17
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752167005; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=pSIPYxn9jgBwHksI29NMMTNPPn0WYfJzTHxbPYB8KI8=;
 b=McppD8pPY0nsLIM/l2dnJVteD7LrQgbiBtATZhF8HxgeOaG7PUfIspOmnq3OBMgTbeEir
 tSqELXQPuDd3EjlPemZPcrnupTwWW3zozrV3vHsbiM8HkV+Th39cQKTRmX2vfZ0mUxii50y
 xzbq9CHEa89exTCAQoiJnnMEqwYF0rM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7FD53CAFE7
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 19:03:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEA423CAF64
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 19:03:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D78E5100064B
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 19:03:03 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9F2Xg009964
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 17:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3c58ghKzKRDTu5izH+wxQuMKaudAeH/FZmT
 4qcTYci8=; b=i/TkrFSu8LR1BZIq1ylqZcwleRWsXh2DmdXfsJawHoVieU1J+KN
 VBAC2ZNchM3tXd2V57TyDaUsxYwiaIIykq1iT0yqAYQWg87xMh8WUhZlns4Q64S1
 zPomHryRiOY43CSp/rFk+5wQRZGr59JLucRXKyNAdcsheCRSK2Fd/ZvnNLV0bKfr
 mWUiq+DYb9AYuPJoUrUYa2ADJ0lDPtGTGSkpY5uZowXuHs9d0vxEbkwG2dfOlySM
 yn59XuEJaYShX4jUDTevPDvvy4SRpGnQL7sIzjLL7NMsS6Hs3xt+zJgZU7ICH3lK
 vUkxOU45VVBhM40hCS4MSPmv4opB/8exUTA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9dwr22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 17:03:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b31f112c90aso869556a12.0
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752166981; x=1752771781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3c58ghKzKRDTu5izH+wxQuMKaudAeH/FZmT4qcTYci8=;
 b=ZhqJXcPiwalYLvbI0AxeiP0rHmltRtjD6HbQDIp/UZYRkm0bCJMEPb4V1BNzxSHvD5
 YdSBOiUl0Wbyi/7g6r29PQbzp6syJ/Bj+0DGOVFh0SinQpV0w1Tx2qr4aKDT/ZBUGuDl
 ZyeRLe41VHwSpqdSBufMiawcAuDjHqRqrcrNS8dUfTK1OAzp7gDDO19oCunkBIf1cpd1
 85zaO4P/cZmFyAC85qrfrDtcJzxK1E3StXtNpxNWORc3OZSJLxgWbPq4U07Cw8RAagnX
 YiVGORbackiRZ/dhAxm0sDM4uZ+69zt7/9wBFUAxpBVxFweoyGtm+vW7owKy3ZojbT+R
 wMpA==
X-Gm-Message-State: AOJu0Yz0HL9x4H6XWA3Qvvv1I8t1VdI/KmgnQxUzy37Dc3QtNi2op/FC
 3LdW1s6FZKLdwgM5f3n4QN+88SBK1L1NoRO6JzwLLXr6uwjGVgqz6zkCChB6xWmf39Bx2j4EMmc
 ydLcWDJYG1c3B9Tq8lvMOJA9NrE0OV5wj7KZ27++57H0BOzVXAKWs3DwHaJX5aw==
X-Gm-Gg: ASbGnctJej6yhoIDnQcG15wSLccwI8cacp6JMICdaXO2POnE2Veys9vM2PdVJns+2RE
 PpdCVgDJ14FX52s3h1SSP04ISedWIy2z7IuglC1dnSmnp2PgyIYsAUCN9vm9gfvZmMhuCyhbauv
 QaDVeOrmWgi7D/xOjip1q8IssaYKvpBiN8zt4Krit6R5Ph3P3cj1BwfgRjlOsapmg9KQXvjPFda
 mwSVOpDGQMzn5H2vweaoVF3cyf/CLjJGyECuQc/qKpYsWlsfC9KIOKzstQueDik8vrsMz0D6MZW
 BqpAMxy8sSWzocT0Jypv4o9raeOSfWVkT7lvQJVquARmWyVlHiqKTAyX3/V8GGUQMAefPI2bCjG
 M
X-Received: by 2002:a05:6a21:9992:b0:225:ba92:447d with SMTP id
 adf61e73a8af0-23125aface0mr48494637.9.1752166980578; 
 Thu, 10 Jul 2025 10:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnlagQ1/hL/ZNAyvJ9tiIJI9Y8SzobTaHMFuTjlm3bEAjxSmTSk9DZhvognGMYfS6iNFsdFw==
X-Received: by 2002:a05:6a21:9992:b0:225:ba92:447d with SMTP id
 adf61e73a8af0-23125aface0mr48397637.9.1752166979506; 
 Thu, 10 Jul 2025 10:02:59 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe7281d5sm2680711a12.65.2025.07.10.10.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:02:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 10 Jul 2025 10:02:55 -0700
Message-Id: <20250710170255.4190556-1-mike.tipton@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: nImpZtxvNVun0Rvp28YvxFOTgPooj4rH
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=686ff246 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iox4zFpeAAAA:8
 a=_eI-3EgdN9IBFPxNkDQA:9 a=x9snwWr2DeNwDh03kgHS:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: nImpZtxvNVun0Rvp28YvxFOTgPooj4rH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0NSBTYWx0ZWRfX8NyzzuCDXrW4
 fiLslwoJtCjfjn1lRWLgvKzpqQNICVoI3Quu0kdh6QSJBTdkMnUKaR/wzvTFpQnXtMMEqii4sps
 W5pcRVDgQ1K6OHS5wtkJRXuKatgUUFAVp0DgF8VfF+Hns1+CJOXdxhbmuP6x6TQsrpU+qv2xRgH
 dJvoUjgKxC0LdZQC2khAQqTIBYR7Ll2OhuSatVArOyoBP/4pgY3xVLdbd1FCeS3jMrbJsoDtlTy
 Q/FwyJQxFl/bD7B5RxsUOn3goaGWwmjbriHJTctASlmKCz7H2dQIrP/oaayIsRmFT1Ho9JV6er+
 J6LJYwC3Tcgho+zz2f6W3tWmFPpx4UGWq2EtAjiRXz6AEchkd/rDXiYY/6JTih4kvrFgjjhM5Tj
 4yz+vLUgBNO7Pd/VXCCkb7Ule4MFWRCXwYLHNjikuCrKCJ+ECFnb14RMerPRaG5wULu4bD2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100145
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] device-drivers/cpufreq_boost: Don't hardcode to
 CPU0
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
From: Mike Tipton via ltp <ltp@lists.linux.it>
Reply-To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some systems don't support boost on every CPU, such as on many Qualcomm
chipsets. And if boost isn't supported on CPU0, then the test will fail
since there's no performance improvement.

Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
policy with boost enabled.

Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
Acked-by: Wei Gao <wegao@suse.com>
---
Changes in v4:
- Move error handling outside of find_boost_cpu() for improved
  readability.
- Collect Acked-by from Wei.
- Link to v3: https://lore.kernel.org/ltp/20250709151439.2840206-1-mike.tipton@oss.qualcomm.com/

Changes in v3:
- Abort when no CPUs report supporting boost instead of assuming CPU0.
- Link to v2: https://lore.kernel.org/ltp/20250630145128.1254269-1-mike.tipton@oss.qualcomm.com/

Changes in v2:
- Use proper maxspeed buf size in snprintf.
- Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/

 .../device-drivers/cpufreq/cpufreq_boost.c    | 60 ++++++++++++++++---
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 67917b3fea25..7aefd8844513 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -55,10 +55,14 @@ static int id = -1;
 
 static int boost_value;
 
-const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
+static int cpu;
+
+static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
+static char governor[64];
 static char governor_name[16];
 
-const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
+static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
+static char maxspeed[64];
 
 static void check_set_turbo(char *file, char *off)
 {
@@ -84,6 +88,38 @@ static void cleanup(void)
 		FILE_PRINTF(governor, "%s", governor_name);
 }
 
+static int find_boost_cpu(void)
+{
+	char buf[64];
+	int fd, i;
+
+	/*
+	 * The files we're looking for only exist for acpi_cpufreq. Continue
+	 * assuming CPU0 for intel_pstate.
+	 */
+	if (!strcmp(cdrv[id].name, "intel_pstate"))
+		return 0;
+
+	for (i = 0;; i++) {
+		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d", i);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1)
+			break;
+
+		close(fd);
+
+		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d/cpufreq/boost", i);
+		fd = open(buf, O_RDONLY);
+		if (fd == -1)
+			continue;
+
+		close(fd);
+		return i;
+	}
+
+	return -1;
+}
+
 static void setup(void)
 {
 	int fd;
@@ -109,6 +145,14 @@ static void setup(void)
 	tst_resm(TINFO, "found '%s' driver, sysfs knob '%s'",
 		cdrv[id].name, cdrv[id].file);
 
+	cpu = find_boost_cpu();
+	if (cpu == -1)
+		tst_brkm(TCONF, NULL, "boost not supported by any CPUs");
+
+	tst_resm(TINFO, "found boost-capable CPU (CPU%d)", cpu);
+	snprintf(governor, sizeof(governor), _governor, cpu);
+	snprintf(maxspeed, sizeof(maxspeed), _maxspeed, cpu);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	SAFE_FILE_SCANF(NULL, cdrv[i].file, "%d", &boost_value);
@@ -120,16 +164,16 @@ static void setup(void)
 	if (!strcmp(cdrv[i].name, "intel_pstate") && boost_value == cdrv[i].off)
 		check_set_turbo(cdrv[i].file, cdrv[i].off_str);
 
-	/* change cpu0 scaling governor */
+	/* change cpu scaling governor */
 	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
 	SAFE_FILE_PRINTF(cleanup, governor, "%s", "performance");
 
-	/* use only cpu0 */
+	/* use only a single cpu */
 	cpu_set_t set;
 	CPU_ZERO(&set);
-	CPU_SET(0, &set);
+	CPU_SET(cpu, &set);
 	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
+		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU%d", cpu);
 
 	struct sched_param params;
 	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
@@ -176,12 +220,12 @@ static void test_run(void)
 	/* Enable boost */
 	if (boost_value == cdrv[id].off)
 		SAFE_FILE_PRINTF(cleanup, cdrv[id].file, "%s", cdrv[id].on_str);
-	tst_resm(TINFO, "load CPU0 with boost enabled");
+	tst_resm(TINFO, "load CPU%d with boost enabled", cpu);
 	boost_time = load_cpu(max_freq_khz);
 
 	/* Disable boost */
 	SAFE_FILE_PRINTF(cleanup, cdrv[id].file, "%s", cdrv[id].off_str);
-	tst_resm(TINFO, "load CPU0 with boost disabled");
+	tst_resm(TINFO, "load CPU%d with boost disabled", cpu);
 	boost_off_time = load_cpu(max_freq_khz);
 
 	boost_off_time *= .98;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
