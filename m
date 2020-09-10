From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Wed, 9 Sep 2020 22:30:28 -0400
Subject: [LTP] [PATCH v2] route{4,
 6}-rmmod: Declare variables before using them
Message-ID: <1599705028-12889-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running route4-rmmod case, it reports the following error:
/opt/ltp/testcases/bin/route4-rmmod: line 100: lhost_module: unbound variable.

It fails because "set -u" is used in .testcases/lib/cmdlib.sh and
"set -u" treats unset variables and parameters as errors.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/network/stress/route/route4-rmmod | 3 +++
 testcases/network/stress/route/route6-rmmod | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 5947bb3..7aa1958 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -125,6 +125,9 @@ do_setup()
 	exit $TST_TOTAL
     fi
 
+    # The module name of the interface at the local host
+    lhost_module=
+
     # Make sure to clean up
     do_cleanup
 
diff --git a/testcases/network/stress/route/route6-rmmod b/testcases/network/stress/route/route6-rmmod
index 73f26f2..765a57a 100644
--- a/testcases/network/stress/route/route6-rmmod
+++ b/testcases/network/stress/route/route6-rmmod
@@ -121,6 +121,9 @@ do_setup()
 	exit $TST_TOTAL
     fi
 
+    # The module name of the interface at the local host
+    lhost_module=
+
     # Make sure to clean up
     do_cleanup
 
-- 
1.8.3.1



