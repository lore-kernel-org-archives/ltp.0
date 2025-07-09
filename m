Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DF6C83F03
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752074109; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Fmr7OK1+V8ougOILkboA1aag5FaYpvfTr72cGEKI7qM=;
 b=rPnzMVLYf7giPWfGtFBcERxcmukjPJH8cAcl7U4srM0oYkA2u9g1FIdqJ/kA61OUGVFwN
 23Dfzf9XN0IgTv/PkE5Bxy8nJYj1JQrcKiQNp5/3UnAMWNwNbLTn+f/5K8JPtrWExxZGopU
 dUkWsRyCZO1RuyQe0FAgujBkLso20aQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1D63CAC6A
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 17:15:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A42F3CA304
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 17:14:49 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3D4441A01084
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 17:14:47 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CoduV009974
 for <ltp@lists.linux.it>; Wed, 9 Jul 2025 15:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=miGQOFmxto0a+4i4oS4UdZRI6Pwt6CCfGwC
 P2u8Qly0=; b=IhsMhUXQhfYrT4O/sXlTd/EG3MbWJYzvSOokPAzW5BLp7j0Qz5O
 qMYYEs7Wp+eUjD0Gp5U8LABDW8DD/1l5WBoLXvFBBsh5C+Gd7gMMtb7PA5ilrUw/
 7MnTfu9HGYG89rwWpitkqhTwqUYIjJuB9+Q/x7sPb2xThiSzCOjh13IQXVK7RlX4
 GRCWkSo+rigj01IyUQ80v0QMUQkUEQpIy12bchNEeEJDg8bypFQht/SIgctE9gC7
 ODGp1Rf3g1DAuEDDBxlZ8zeLAf7q8BFywZAgBkU0bGQX6FnDkrBtr8HHvc2jijTH
 gPv5dcgynMA1QRmZOnz5wKZStkVGcsJ3K2g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9dsh6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 15:14:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235c897d378so131205ad.1
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 08:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752074084; x=1752678884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=miGQOFmxto0a+4i4oS4UdZRI6Pwt6CCfGwCP2u8Qly0=;
 b=fpLmU48FdaaaRCpM3AwU4rlOaVfULNowCn3oLeIkbgxJDS6cpPP04PZ+hUCltOu3Y2
 X8CdfAWkDxk81AOripGnIyx5oNg16sc1QvlN3Dkwgz+Y40pSWH0M72QsPKLICCO+52IT
 a3/23aMLTmvwQLsadNJHqtQn0DkIN0oG1Mt+FaEX+aN6IchSXlOBWtev9/UK5DY0zH0L
 wal9if/9Bhzx6cMHayASw6V4IqYGkPPwgKJFZ+lM/w4ptoq9PA6awhSxpeLx9Ik6PgXz
 v1uQzqjXm/CEjHwWMDzqLKIlQ2IuBj9OVUpa7qyaF1onstMBiipGU5BQ1zkc5qK+OYsM
 sVgw==
X-Gm-Message-State: AOJu0Yz19iH6XhZX0b2K5yFwKxmBDGFiEiqZb2aP53FL87wI1FiTGD++
 PS63bvqu97K4dZNp6Nge5SKyxUH6//Wy0ek4A80CFYfJEaepdrgpbl1iYOmTlSp98o1zeDlQrkj
 eZabLur2X//WXdgH06fQeKbWXnh7+wKI+uN+D42sCBktt87w/gc62q+CmVfA8/A==
X-Gm-Gg: ASbGnctT7F1bZurDL0M+6US2CBsYUauGI6TJlm5S/c02SsploWGO6FJskXX8RGO9jkh
 kYCueRQReyRp5oTchlSExd8N08bfFXFfOYOCTHF20iKToYHHJfsDd0cgxsFsEE3tDwrJEbJOtLu
 3XdWeOUih4PNUiNaE55eld40TEnMNVi1qHqdcMMcYcZOz3YFcdNxYETn1cJ1uWvjJCjGDG2BKHU
 dUDt5DzP9sF3jRny7NGAA1pMEmNVwHZrLwUrmvmCyCkijoYBH/kWpT3zLnchclN6djgBDAyrlpQ
 NTW1UOEbeMzqzUMo58bBmsNSEpZIBXP1PFy9M9vsGpYUnR7uQD/Xvfi7NXWAsaUxGVFnw3o2OIp
 q
X-Received: by 2002:a17:903:74e:b0:234:ed31:fc94 with SMTP id
 d9443c01a7336-23ddb312601mr30207855ad.26.1752074084019; 
 Wed, 09 Jul 2025 08:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE71IoyUlNs9TNddPM9BPVHvlNOsG9jbS6PESvBbruMy55wk5AOqVg77t40NsC/AyRTprqxQ==
X-Received: by 2002:a17:903:74e:b0:234:ed31:fc94 with SMTP id
 d9443c01a7336-23ddb312601mr30207435ad.26.1752074083361; 
 Wed, 09 Jul 2025 08:14:43 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23dc3090346sm92661065ad.168.2025.07.09.08.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 08:14:42 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  9 Jul 2025 08:14:39 -0700
Message-Id: <20250709151439.2840206-1-mike.tipton@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: 492GvEOqy5HqWZZXbI1OIAK8kJ9TBWFG
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=686e8765 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_eI-3EgdN9IBFPxNkDQA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 492GvEOqy5HqWZZXbI1OIAK8kJ9TBWFG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzNyBTYWx0ZWRfX7li0Huh8MJGw
 f9RmuFt0hiaIxaoQQ90mRpbXBj5a2J3kumr3vStcBCjxj2kDnBHtJme8HfHIUNIzUXjYynrXLDH
 tVVF9ZVEbhCgZNf2SdFmpW4grC2KD5amyIkpe/x3+SRZNQG5n2mnU0cwH5+wnZ3HUiBY0m2/l3e
 tWmUs4M7pY1WmDTIAazGd4Au6V5JlxJsXjR7antxFCuxGwjyhhp/4i5CUnYB68tJgVTJjSNuW0Y
 kmrnVF6ofIXBoLEPkwhE7+WTHJVNx5CIxIzSXfTpu/SqX8Zx1OvLzLpsJEg8nSAT8c2RkAQR9RT
 x62JdVC0sbclCeaUwMkcIqYOwiqsJGgc/ziJ0nYEtF99ZDH9D7NjHIrRyzywrFg9cYiplW4/qK1
 EBKqzCVMeOB9UZKRBfKe/HFF8Y4+5vUUHPusYIDlDCWhR+aK58nqItGDCyCGTNtj1GRA+YOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090137
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] device-drivers/cpufreq_boost: Don't hardcode to
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
Changes in v3:
- Abort when no CPUs report supporting boost instead of assuming CPU0.
- Link to v2: https://lore.kernel.org/ltp/20250630145128.1254269-1-mike.tipton@oss.qualcomm.com/

Changes in v2:
- Use proper maxspeed buf size in snprintf.
- Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/

 .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 67917b3fea25..17d89c0cc164 100644
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
+	tst_brkm(TCONF, NULL, "boost not supported by any CPUs");
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
