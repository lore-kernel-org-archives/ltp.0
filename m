From: Cristian Marussi <Cristian.Marussi@arm.com>
Date: Tue, 29 Jan 2019 19:25:34 +0000
Subject: [LTP] [PATCH v3]  memcg_stress_test.sh: ported to newlib
In-Reply-To: <20190129175019.GA14252@dell5510>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
 <20190104105407.48123-2-cristian.marussi@arm.com>
 <20190128163207.GA26834@dell5510>,<20190129175019.GA14252@dell5510>
Message-ID: <VI1PR08MB31815A4CF9A142A5B8A5E69F9E970@VI1PR08MB3181.eurprd08.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 29/01/2019 17:50, Petr Vorel wrote:> Hi Cristian,
>
> I suggest following cleanup of your patch (see bellow).
>
> This change, with my other cleanup patch [1] + your patch [2] can be seen on [3].
>
> Kind regards,
> Petr

Thanks for the review and the cleanup. (next I was going to rework following your today's advises, but you've been faster...)

I'll test asap.

Thanks

Regards

Cristian


________________________________
From: Petr Vorel <pvorel@suse.cz>
Sent: 29 January 2019 17:50:19
To: Cristian Marussi
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v3] memcg_stress_test.sh: ported to newlib

Hi Cristian,

I suggest following cleanup of your patch (see bellow).

This change, with my other cleanup patch [1] + your patch [2] can be seen on [3].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1032923/
[2] https://patchwork.ozlabs.org/patch/1020887/
[3] https://github.com/pevik/ltp/commits/christian/memcg_stress_test.sh.v3.fixes

diff --git testcases/kernel/controllers/cgroup_lib.sh testcases/kernel/controllers/cgroup_lib.sh
index c164932fa..7918b5636 100644
--- testcases/kernel/controllers/cgroup_lib.sh
+++ testcases/kernel/controllers/cgroup_lib.sh
@@ -33,7 +33,7 @@ is_cgroup_subsystem_available_and_enabled()
         [ $# -eq 0 ] && tst_brk TBROK "is_cgroup_subsystem_available_and_enabled: subsystem not defined"

         val=$(grep -w $subsystem /proc/cgroups | awk '{ print $4 }')
-       [ "x$val" = "x1" ] && return 0
+       [ "$val" = "1" ] && return 0

         return 1
 }
diff --git testcases/kernel/controllers/memcg/stress/Makefile testcases/kernel/controllers/memcg/stress/Makefile
index 773363cfc..a9678bf3b 100644
--- testcases/kernel/controllers/memcg/stress/Makefile
+++ testcases/kernel/controllers/memcg/stress/Makefile
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2009, Cisco Systems Inc.
 # Author: Ngie Cooper, September 2009
-#
-#    kernel/controllers/memcg/stress testcase suite Makefile.
-#

 top_srcdir              ?= ../../../../..

diff --git testcases/kernel/controllers/memcg/stress/memcg_process_stress.c testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
index 6af550012..422deaeee 100644
--- testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
+++ testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2009 FUJITSU LIMITED
- *
  * Author: Li Zefan <lizf@cn.fujitsu.com>
  */

diff --git testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 652d99e55..9972b6c45 100755
--- testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -7,25 +7,23 @@
 # Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
 # Added memcg enable/disable functionality: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com

-TST_TESTFUNC=testcase_
-TST_SETUP=do_setup
-TST_CLEANUP=do_cleanup
+TST_TESTFUNC=test
+TST_SETUP=setup
+TST_CLEANUP=cleanup
 TST_CNT=2
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"

-# Each test case runs for 900 secs when everything fine...
-# ...so the default 5mins timeout is not enough.
+# Each test case runs for 900 secs when everything fine
+# therefore the default 5 mins timeout is not enough.
 LTP_TIMEOUT_MUL=7

-. tst_test.sh
 . cgroup_lib.sh

-do_setup()
+setup()
 {
-       if ! is_cgroup_subsystem_available_and_enabled "memory";then
-               tst_res TWARN "Either Kernel does not support MEMORY resource controller or feature not enabled"
-               tst_brk TCONF ignored "Skipping all memory cgroup testcases...."
+       if ! is_cgroup_subsystem_available_and_enabled "memory"; then
+               tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
         fi

         echo 3 > /proc/sys/vm/drop_caches
@@ -40,7 +38,7 @@ do_setup()
         tst_res TINFO "Calculated available memory $MEM MB"
 }

-do_cleanup()
+cleanup()
 {
         if [ -e /dev/memcg ]; then
                 umount /dev/memcg 2> /dev/null
@@ -50,15 +48,12 @@ do_cleanup()

 do_mount()
 {
-       do_cleanup
+       cleanup

         mkdir /dev/memcg 2> /dev/null
         mount -t cgroup -omemory memcg /dev/memcg
 }

-
-# Run the stress test
-#
 # $1 - Number of cgroups
 # $2 - Allocated how much memory in one process? in MB
 # $3 - The interval to touch memory in a process
@@ -69,34 +64,31 @@ run_stress()

         do_mount

-       for i in $(seq 0 $(($1-1)))
-       do
+       for i in $(seq 0 $(($1-1))); do
                 mkdir /dev/memcg/$i 2> /dev/null
                 memcg_process_stress $2 $3 &
-               eval local pid$i=$!
+               eval pid$i=$!

                 eval echo \$pid$i > /dev/memcg/$i/tasks
         done

-       for i in $(seq 0 $(($1-1)))
-       do
+       for i in $(seq 0 $(($1-1))); do
                 eval kill -USR1 \$pid$i 2> /dev/null
         done

         sleep $4

-       for i in $(seq 0 $(($1-1)))
-       do
+       for i in $(seq 0 $(($1-1))); do
                 eval kill -KILL \$pid$i 2> /dev/null
                 eval wait \$pid$i

                 rmdir /dev/memcg/$i 2> /dev/null
         done

-       do_cleanup
+       cleanup
 }

-testcase_1()
+test1()
 {
         tst_res TINFO "testcase 1 started...it will run for $RUN_TIME secs"

@@ -105,7 +97,7 @@ testcase_1()
         tst_res TPASS "stress test 1 passed"
 }

-testcase_2()
+test2()
 {
         tst_res TINFO "testcase 2 started...it will run for $RUN_TIME secs"

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190129/95a19364/attachment.html>
