From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 30 Sep 2016 16:42:06 +0200
Subject: [LTP] [PATCH] device-drivers/rtc: handle EINVAL on RTC_ALM_READ
Message-ID: <20160930164206.7f2b6f8e@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Report TCONF result after RTC_ALM_READ fails with EINVAL and skip
displaying the alarm time when this happens.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/device-drivers/rtc/rtc01.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index 7f9bc07..b3c7e1d 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -108,12 +108,17 @@ void read_alarm_test(void)
 	/*Read current alarm time */
 	ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
 	if (ret == -1) {
-		tst_resm(TFAIL | TERRNO, "RTC_ALM_READ ioctl failed");
-		return;
+		if (errno == EINVAL) {
+			tst_resm(TCONF | TERRNO, "RTC_ALM_READ not suported");
+		} else {
+			tst_resm(TFAIL | TERRNO, "RTC_ALM_READ ioctl failed");
+			return;
+		}
+	} else {
+		tst_resm(TINFO, "Alarm time set to %02d:%02d:%02d.",
+			 rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
 	}
 
-	tst_resm(TINFO, "Alarm time set to %02d:%02d:%02d.",
-		 rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
 	/* Enable alarm interrupts */
 	ret = ioctl(rtc_fd, RTC_AIE_ON, 0);
 	if (ret == -1) {
-- 
2.10.0
