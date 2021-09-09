From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu,  9 Sep 2021 18:33:25 +0200
Subject: [LTP] [PATCH 1/2] rtc01: add space to beginning of comments
Message-ID: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Improve readability of comments - no functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/device-drivers/rtc/rtc01.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index 8a1f62eadcec..ebd15306d583 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -67,7 +67,7 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "RTC READ TEST:");
 
-	/*Read RTC Time */
+	/* Read RTC Time */
 	ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
 	if (ret == -1) {
 		tst_resm(TFAIL | TERRNO, "RTC_RD_TIME ioctl failed");
@@ -82,7 +82,7 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "RTC ALARM TEST :");
 
-	/*set Alarm to 5 Seconds */
+	/* Set Alarm to 5 Seconds */
 	rtc_tm.tm_sec += 5;
 	if (rtc_tm.tm_sec >= 60) {
 		rtc_tm.tm_sec %= 60;
@@ -106,7 +106,7 @@ void read_alarm_test(void)
 		return;
 	}
 
-	/*Read current alarm time */
+	/* Read current alarm time */
 	ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
 	if (ret == -1) {
 		if (errno == EINVAL) {
@@ -129,13 +129,13 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
 
-	tv.tv_sec = 6;		/*set 6 seconds as the time out */
+	tv.tv_sec = 6;		/* set 6 seconds as the time out */
 	tv.tv_usec = 0;
 
 	FD_ZERO(&rfds);
 	FD_SET(rtc_fd, &rfds);
 
-	ret = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);	/*wait for alarm */
+	ret = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);	/* wait for alarm */
 
 	if (ret == -1) {
 		tst_resm(TFAIL | TERRNO, "select failed");
@@ -174,7 +174,7 @@ void update_interrupts_test(void)
 	struct timeval tv;
 
 	tst_resm(TINFO, "RTC UPDATE INTERRUPTS TEST :");
-	/*Turn on update interrupts */
+	/* Turn on update interrupts */
 	ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
 	if (ret == -1) {
 		if (errno == EINVAL)
@@ -187,7 +187,7 @@ void update_interrupts_test(void)
 	tst_resm(TINFO, "Waiting for  5 update interrupts...");
 	for (i = 1; i < 6; i++) {
 
-		tv.tv_sec = 2;	/*2 sec time out for each interrupt */
+		tv.tv_sec = 2;	/* 2 sec time out for each interrupt */
 		tv.tv_usec = 0;
 
 		FD_ZERO(&rfds);
@@ -231,10 +231,10 @@ int main(int argc, char *argv[])
 
 	rtc_fd = SAFE_OPEN(NULL, rtc_dev, O_RDONLY);
 
-	/*Read and alarm tests */
+	/* Read and alarm tests */
 	read_alarm_test();
 
-	/*Update interrupts test */
+	/* Update interrupts test */
 	update_interrupts_test();
 
 	close(rtc_fd);
-- 
2.30.2

