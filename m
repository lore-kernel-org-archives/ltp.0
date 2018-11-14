From: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 14 Nov 2018 15:00:07 +0000
Subject: [LTP] [PATCH] [PATCH] cpuset_hotplug: fix cpuset_list_compute
Message-ID: <20181114150007.22246-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

cpuset_hotplug failed with:

Usage : cpuset_list_compute [-a|s] list1 [list2]

        -a|s   list1 add/subtract list2.[default: -a]

        -h     Help.
cpuset_hotplug 1 TFAIL: root group's cpus isn't expected(Result: 0,2-5, Expect: ).

It turned out that the helper cpuset_list_compute was always failing
because it was improperly handling getopt retval using a char variable;
in such a case the while() loop used around getopt never gets false,
and as a consequence getopt() keeps on being invoked parsing also the
following unknown non-option input material: this in turn leads to
the loop termination through the default switch-label that finally
terminates the program without doing anything each time.

This condition can also be spotted during the compilation process:

cpuset_list_compute.c: In function 'checkopt':
cpuset_list_compute.c:35:41: warning: comparison is always true due to limited range of data type [-Wtype-limits]
  while ((c = getopt(argc, argv, "ahs")) != -1) {
                                         ^~

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../cpuset/cpuset_hotplug_test/cpuset_list_compute.c           | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
index 17a332f8a..1c66b863a 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
@@ -29,8 +29,7 @@ static void usage(char *prog_name, int status)
 
 static void checkopt(int argc, char **argv)
 {
-	char c = '\0';
-	int optc = 0;
+	int c, optc = 0;
 
 	while ((c = getopt(argc, argv, "ahs")) != -1) {
 		switch (c) {
-- 
2.17.1

