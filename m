Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D88C8302B
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751295127; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=L924iYO3CYDLPvfgyH/zosYlp7tTz1onEtXsO0m9GnY=;
 b=gu1QpAUJATHp6ksJr922ljUEjgWg74xxFT5tnZzFxuurbfbZDovrTUAdeHe9eXg9QRRvi
 6jaNzxZgyLOlvxm8WDUt+Nsug+dvqEp3nvxi4IX5zELDqeQOK23nvBTxneuurKBUoUWgnun
 cCxtt7Ap/oK7NJROXjcTHSb+AvqMBms=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84B393C5F68
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 16:52:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82A623C56F4
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 16:51:46 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 604AC1A001E8
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 16:51:38 +0200 (CEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8DNQf002460
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6xq7lki8XNGy4nNNUQ3YoGudKJAYlr9RJGJ
 JKkoyoPk=; b=fT0qQfQRFmLmukSDgk+RvCr7gPTW8ombYJgWeyuzRBEmUAzWJGV
 GoMXZ/CZIzRXvRvvZwuULNLuh5z/+L+gai9W6sIS1M3l/d/GrI6srvXV9mWeKJXM
 SpnrvsDUxvQNiWaLF+p1SI2VtyRjOCqQ6p2QlIsOCJJFI8msIDUGh5uochRmOhkZ
 oOkQAI0qWR/iCTzco2W9pkqdNhEW6o7LtMAk6lIlgVDCraYAFKotEfTdcuWpUZ8F
 6w+ioYhm11NxmWT0JwtBLBkyvOVM/E9nxBhr1rvHXlaWV4LEF8R8L49Jse7A6NdY
 DMQdhPh4yuoUF3Zg/qK4IoRn81MnQoJbpbQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcn44e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:51:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-74ad608d60aso2023749b3a.1
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 07:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751295095; x=1751899895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6xq7lki8XNGy4nNNUQ3YoGudKJAYlr9RJGJJKkoyoPk=;
 b=jpSX/Eg7V2zhjJVLZ18SiUoTnkLkBafkHFw3WRqrySaNRhQlo65XdtIwNuaHZDpFYO
 ZY9UaqWPIK/j8Dkc5eB8k9GiFP9JH0bBYddD9VwK47v63I+wIrGbUyn3XnQat+jjnlvB
 219xl/drpirozTiTrgnEhjAnRms4ST1wwAAbs+W5gc0tA+d5BpPC4dez4MTi8jy3qLuI
 35cUAiLuDpbQHp8Bn7u9ohqElrXVgqR2gN13FD7m87KexT03+wjp1vAOOTTRi6wAe4Hl
 ExcN+OXtjCOfUEsnMkfmrX2YlBthb0t9s92qHP5DpIB7i8fc3ccbk3fpaDAV+I7AR12a
 yK+Q==
X-Gm-Message-State: AOJu0Yx3BrSGwc+dI5o/X0ZFNiaBFUSCgGcfS7U0la29dBjSBGFdZ+Hh
 GxDnbetq/07gzbwb5IBnzSFAH7Vtvr1ivO8kSJOK/ixTnCWpm1co4F5ItLjtKLtfqHj5PzYdD1x
 cwK/RwAbmSoewo5wLCxLS5WRpuJ541uawE5uWGMD1gmfWlyAETW3k3LA17j1D1A==
X-Gm-Gg: ASbGncu850TiWRCGUiA5Pizc7v4zxhzz7pnuqd+dxF2/pLGIW+q9cnLcyMpnelVI3Kq
 cB8xtZAH4YhUjXvtBHaskmIT4YmkWCULvc+e73VYcZPzvsLvSo1nxD9DPMTCNBVOIFzraMu/Bjc
 2SsVwI0KTFqCEyvAG+Iyukt8jrGxZX7DORS7obffGuIEBsucx4ITAXq852ZOtmTV9WK/uPi35jv
 LTeUKyIT4XqkmXNe0tnFhZ1bF0ci3OnVcGOFFenRZ7E7UCVbW5sPz3LppFFdc560vutGYK1h0Yk
 dOY6hVZ2RZG8gRg61lkteRWFX5MhpTGwUvxvcDJRzwDOPgJ+GyZV+Nf4kA4w48iFBh9iwQUazVT
 a
X-Received: by 2002:a05:6a00:14c2:b0:73e:1e24:5a4e with SMTP id
 d2e1a72fcca58-74af6f7f8e2mr21764733b3a.24.1751295095226; 
 Mon, 30 Jun 2025 07:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd2OPle/bgMna9kuXZTEcV51AK3aBt/4XPNQm8ZVuzT76xFu5+86MDSJYvSA8f2DClfg2Kqg==
X-Received: by 2002:a05:6a00:14c2:b0:73e:1e24:5a4e with SMTP id
 d2e1a72fcca58-74af6f7f8e2mr21764684b3a.24.1751295094719; 
 Mon, 30 Jun 2025 07:51:34 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af540b203sm9279280b3a.8.2025.06.30.07.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 07:51:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 30 Jun 2025 07:51:28 -0700
Message-Id: <20250630145128.1254269-1-mike.tipton@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: kbnKvfKp1L9IcCz4kBgdb6nNFaTiLFql
X-Proofpoint-ORIG-GUID: kbnKvfKp1L9IcCz4kBgdb6nNFaTiLFql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyMiBTYWx0ZWRfX4me+mzfklvOv
 PeOnHq4NqRNbdbylUKCxdvuZprjYIRbTp7GiEHtDA+/9AxXwoR1qejbtEH+3b8tQhtfYdHhJB+l
 PtEY3gTggKjoi05+T3n8SZlm8rA4kJfikbfHYxYlDfOwzDacumkHXOHqap39gdMAm/yR9m8OC/n
 +pbFu0GkZRSMS/ZKRad2vd1Z3CQBwYmom/nVidHJbG7Jxz9YkT7wQ3tLLbJv8v1H70OL76YJOca
 iUxswIS9ell/+X44eS1chmG1CDDFWd2rvg9N90Mpq4B5P+10warYqsLF3WtFfJOnpTBm7CzDjVK
 XanLFGsP9N8c6mstuyvdoDJlYxiXaxrEuuRuBb2/dy7AfHlcLxSWipIXw8TwK7s15XeVv4OBlbp
 MUCrcp6U1x24VsEOiLIzvanKtzBP7KiWBqIQA0k3rxD4qVkul1laAN98a5K0ONCCG0KNRdsA
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=6862a478 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_eI-3EgdN9IBFPxNkDQA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300122
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] device-drivers/cpufreq_boost: Don't hardcode to
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
---
Changes in v2:
- Use proper maxspeed buf size in snprintf.
- Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/

 .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 67917b3fea25..bbb5f602de4b 100644
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
@@ -84,6 +88,40 @@ static void cleanup(void)
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
+		tst_resm(TINFO, "found boost-capable CPU (CPU%d)", i);
+		return i;
+	}
+
+	tst_resm(TINFO, "didn't find boost-capable CPU (assuming CPU0)");
+	return 0;
+}
+
 static void setup(void)
 {
 	int fd;
@@ -109,6 +147,10 @@ static void setup(void)
 	tst_resm(TINFO, "found '%s' driver, sysfs knob '%s'",
 		cdrv[id].name, cdrv[id].file);
 
+	cpu = find_boost_cpu();
+	snprintf(governor, sizeof(governor), _governor, cpu);
+	snprintf(maxspeed, sizeof(maxspeed), _maxspeed, cpu);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	SAFE_FILE_SCANF(NULL, cdrv[i].file, "%d", &boost_value);
@@ -120,16 +162,16 @@ static void setup(void)
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
@@ -176,12 +218,12 @@ static void test_run(void)
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
