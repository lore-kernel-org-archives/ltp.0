From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Fri, 3 Mar 2017 01:21:47 +0000 (UTC)
Subject: [LTP] [PATCH v2] min_free_kbytes: Check panic_on_oom in advance
In-Reply-To: <1488503881-1954-1-git-send-email-the_hoang0709@yahoo.com>
References: <1488503881-1954-1-git-send-email-the_hoang0709@yahoo.com>
Message-ID: <1109024670.904855.1488504107390@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
Sorry I for spam. I missed LTP in the subject. Please ignore this. I sent another mail.
Best regards,
Hoang      From: "the_hoang0709@yahoo.com" <the_hoang0709@yahoo.com>
 To: ltp@lists.linux.it 
Cc: the_hoang0709@yahoo.com
 Sent: Friday, 3 March 2017, 8:18
 Subject: [PATCH v2] min_free_kbytes: Check panic_on_oom in advance
   
From: Hoang Nguyen <the_hoang0709@yahoo.com>

Testcase usually trigger reset if panic_on_oom is enabled by default.
Add panic_on_oom checking before running.

Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index cb00f40..1f6fc8f 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -239,6 +239,11 @@ static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
 void setup(void)
 {
     tst_require_root();
+    if (get_sys_tune("panic_on_oom")) {
+        tst_brkm(TCONF, NULL,
+            "panic_on_oom is set, disable it to run these testcases");
+    }
+
     tst_sig(FORK, DEF_HANDLER, cleanup);
     TEST_PAUSE;
 
-- 
2.7.4



   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170303/b2f44d97/attachment.html>
