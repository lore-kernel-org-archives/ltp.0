From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Thu, 2 Mar 2017 02:48:50 +0000 (UTC)
Subject: [LTP] [PATCH] min_free_kbytes : Check panic_on_oom before
 running
In-Reply-To: <20170206132419.11060-1-the_hoang0709@yahoo.com>
References: <20170206132419.11060-1-the_hoang0709@yahoo.com>
Message-ID: <851455076.95831.1488422930997@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
Just a friendly ping. 
Best regards,
Hoang


 
 
  On Mon, Feb 6, 2017 at 20:24, the_hoang0709@yahoo.com<the_hoang0709@yahoo.com> wrote:   From: Hoang Nguyen <the_hoang0709@yahoo.com>

Check panic_on_oom before running min_free_kbytes testcase.

Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index cb00f40..8b6dc1c 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -71,6 +71,9 @@ int main(int argc, char *argv[])
 
     tst_parse_opts(argc, argv, NULL, NULL);
 
+    if (get_sys_tune("panic_on_oom"))
+        tst_brkm(TCONF, NULL,
+            "panic_on_oom is set, disable it to run these testcases");
     sa.sa_handler = sighandler;
     if (sigemptyset(&sa.sa_mask) < 0)
         tst_brkm(TBROK | TERRNO, cleanup, "sigemptyset");
-- 
2.10.1.windows.1

  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170302/0ce1d4ca/attachment.html>
