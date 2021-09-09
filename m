From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu,  9 Sep 2021 18:33:26 +0200
Subject: [LTP] [PATCH 2/2] rtc01: add workaround for broken CMOS RTC on
 Microsoft Hyper-V cloud
In-Reply-To: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210909163326.42598-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rtc01 fails on missed alarm on multiple different Azure instances if the
alarm is set for the next minute:

  rtc01 0 TINFO : RTC READ TEST:
  rtc01 1 TPASS : RTC READ TEST Passed
  rtc01 0 TINFO : Current RTC date/time is 11-6-2021, 09:00:58.
  rtc01 0 TINFO : RTC ALARM TEST :
  rtc01 0 TINFO : Alarm time set to 09:01:03.
  rtc01 0 TINFO : Waiting 5 seconds for the alarm...
  rtc01 2 TFAIL : rtc01.c:151: Timed out waiting for the alarm

Reproduced easily with rtcwake:

  $ rtcwake -d rtc0 -m on -s 50 -v

If alarm is set for now+60 seconds, it works fine.  Clearly Microsoft
Hyper-V cloud instances have a broken CMOS RTC which unfortunately
cannot be easily fixed.  Adding simple workaround to extend the time to
60 seconds allows to avoid false positives in expense of longer testing
time.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/device-drivers/rtc/rtc01.c | 25 +++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index ebd15306d583..51b144f201ad 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -64,6 +64,23 @@ void read_alarm_test(void)
 	unsigned long data;
 	fd_set rfds;
 	struct timeval tv;
+	unsigned int alarm_sec = 5;
+
+	if (tst_is_virt(VIRT_HYPERV)) {
+		/*
+		 * Microsoft Hyper-V hypervisor has broken CMOS RTC which
+		 * does not generate interrupts if alarm is set for 5-59
+		 * seconds from now and it advances to next the minute
+		 * (e.g. 10:12:57 -> 10:13:02).
+		 * However alarm set to fire in 60 seconds (and more) works
+		 * fine.
+		 *
+		 * This was confirmed on different Linux kernels (from v4.15 up
+		 * to v5.14.2) and instances (Standard_B1ms, Standard_B4ms,
+		 * Standard_D4s_v3, Standard_D8d_v4).
+		 */
+		alarm_sec = 60;
+	}
 
 	tst_resm(TINFO, "RTC READ TEST:");
 
@@ -82,8 +99,8 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "RTC ALARM TEST :");
 
-	/* Set Alarm to 5 Seconds */
-	rtc_tm.tm_sec += 5;
+	/* Set Alarm to 5 (or more) seconds */
+	rtc_tm.tm_sec += alarm_sec;
 	if (rtc_tm.tm_sec >= 60) {
 		rtc_tm.tm_sec %= 60;
 		rtc_tm.tm_min++;
@@ -127,9 +144,9 @@ void read_alarm_test(void)
 		return;
 	}
 
-	tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
+	tst_resm(TINFO, "Waiting %u seconds for the alarm...", alarm_sec+1);
 
-	tv.tv_sec = 6;		/* set 6 seconds as the time out */
+	tv.tv_sec = alarm_sec+1;		/* set 5+1 seconds as the time out */
 	tv.tv_usec = 0;
 
 	FD_ZERO(&rfds);
-- 
2.30.2

