From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Dec 2018 17:24:26 +0100
Subject: [LTP] [PATCH 2/2] cgroup: fix mount errors in cgroup subsys
In-Reply-To: <20171122073848.6172-2-liwang@redhat.com>
References: <20171122073848.6172-1-liwang@redhat.com>
 <20171122073848.6172-2-liwang@redhat.com>
Message-ID: <20181213162426.GA2369@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Cristian,

> It is very easy to get failures when running these cgroup regression
> tests on the newer kernel. Maybe the cases should be rewriten in LTP
> new API someday, but currently this fix just as a workaround for it.

> Errors:
>   cgroup_regression_test    3  TFAIL  :  ltpapicmd.c:190: Failed to mount cpu subsys
>   cgroup_regression_test    5  TFAIL  :  ltpapicmd.c:190: mount net_prio and pids failed
>   cgroup_regression_test    7  TFAIL  :  ltpapicmd.c:190: failed to mount net_prio

Li, I pushed your old patch with some changes (see diff bellow):
* remove fix for 5th test (already fixed by Cristian 877c1228d)
* use awk for consistency (although I prefer using cut, I have feeling it's more
common than awk on embedded devices)
* remove bashism
* add local

@Cristian: some of issues, which needs to be addressed when rewriting into new API:
* remove bashisms, use #!/bin/sh
* Remove absolute (/bin/kill) and relative paths and cd into $LTPROOT/testcases/bin
* function for parsing /proc/mounts
* use local in functions, don't use global variables (failed)
* maybe shell code can be generated on the fly into tmp files. If not it'd be
better to use more obvious names than "test_10_2.sh"
* ...

Kind regards,
Petr


diff --git testcases/kernel/controllers/cgroup/cgroup_regression_test.sh testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 8b2918c3a..6cfc63866 100755
--- testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -170,13 +170,15 @@ test_2()
 #---------------------------------------------------------------------------
 test_3()
 {
+	local cpu_subsys_path
+
 	if [ ! -e /proc/sched_debug ]; then
 		tst_resm TCONF "CONFIG_SCHED_DEBUG is not enabled"
 		return
 	fi
 
 	if grep -q -w "cpu" /proc/cgroups ; then
-		cpu_subsys_path=$(grep -w cpu /proc/mounts | cut -d ' ' -f 2)
+		cpu_subsys_path=$(grep -w cpu /proc/mounts | awk '{ print $2 }')
 	else
 		tst_resm TCONF "CONFIG_CGROUP_SCHED is not enabled"
 		return
@@ -269,14 +271,7 @@ test_5()
 	fi
 
 	subsys1=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
-	subsys1_mount=$(basename $(grep -w $subsys1 /proc/mounts | cut -d ' ' -f 2))
 	subsys2=`tail -n 2 /proc/cgroups | head -1 | awk '{ print $1 }'`
-	subsys2_mount=$(basename $(grep -w $subsys2 /proc/mounts | cut -d ' ' -f 2))
-
-	if [ -n "$subsys1_mount" ] || [ -n "$subsys2_mount" ]; then
-		tst_resm TCONF "$subsys1 or $subsys2 has been mounted, skip"
-		return
-	fi
 
 	# Accounting here for the fact that the chosen subsystems could
 	# have been already previously mounted at boot time: in such a
@@ -402,7 +397,7 @@ test_7_1()
 	# remount with new subsystems added
 	# since 2.6.28, this remount will fail
 
-	if [ "$subsys_path" == "cgroup" ]; then
+	if [ "$subsys_path" = "cgroup" ]; then
 		mount -t cgroup -o remount xxx cgroup/ 2> /dev/null
 		/bin/kill -SIGTERM $!
 		wait $!
