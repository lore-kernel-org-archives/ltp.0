From: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 14 Nov 2018 14:21:47 +0000
Subject: [LTP] [PATCH 2/2] [PATCH] cpuset_list_compute fix exit value
In-Reply-To: <20181114142147.38221-1-cristian.marussi@arm.com>
References: <20181114142147.38221-1-cristian.marussi@arm.com>
Message-ID: <20181114142147.38221-2-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Internal usage() helper was meant to use a custom exit value
provided by the caller, so use it.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../cpuset/cpuset_hotplug_test/cpuset_list_compute.c            | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
index b9f176af4..1c66b863a 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
@@ -24,7 +24,7 @@ int convert;
 static void usage(char *prog_name, int status)
 {
 	fprintf(stderr, USAGE, prog_name);
-	exit(1);
+	exit(status);
 }
 
 static void checkopt(int argc, char **argv)
-- 
2.17.1

