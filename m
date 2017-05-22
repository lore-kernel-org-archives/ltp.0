From: Li Wang <liwang@redhat.com>
Date: Mon, 22 May 2017 11:54:41 +0800
Subject: [LTP] [PATCH v3 3/3] ltp/numa: use string to describe operation
In-Reply-To: <20170519122326.GA17258@rei.lan>
References: <20170519082724.10232-1-liwang@redhat.com>
 <20170519122326.GA17258@rei.lan>
Message-ID: <CAEemH2c2zzixjetBj8hKCgD_2tCiSN9FrE=0aNUmo4P9vDwD2A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 19, 2017 at 8:23 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> I've tested and pushed the patchset, thanks.
>
> And also found that memhog test fails on first iteration (when the
> memhog binary is not in the page cache) because the test script runs too
> fast and looks at the statistics even befor the memmhog binary has a
> chance to run. The problem can be simulated for me by dropping caches by
>
> echo 3 > /proc/sys/vm/drop_caches
>
> then running the test.
>
> I guess that the best solution would be to wait for the memhog to print
> at least one dot before we start the actuall test. Unfortunatelly I
> cannot think of any better solution than redirectiong the output to a
> file and then checking the content in the script in a loop.

Although I didn't hit this problem,  I believe the situation is easy
to reproduce. As you said above, something changes like:

$ git diff
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 4eda3f1..e3fe854 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -315,9 +315,20 @@ test8()
        # Memory will be allocated using round robin on nodes.
        Exp_incr=$(echo "$MB / $total_nodes" |bc)

-       numactl --interleave=all memhog -r1000000 1MB 2>&1 >/dev/null &
+       numactl --interleave=all memhog -r1000000 1MB 2>&1 >ltp_numa_test8.log &
        pid=$!

+       local retries=20
+       while [ $retries -gt 0 ]; do
+
+               if grep -m1 -q '.' ltp_numa_test8.log; then
+                       break
+               fi
+
+               retries=$((retries-1))
+               tst_sleep 50ms
+       done
+
        for node in $nodes_list; do
                Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)



Comment?


-- 
Regards,
Li Wang
Email: liwang@redhat.com
