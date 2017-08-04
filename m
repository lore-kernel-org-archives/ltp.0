From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Aug 2017 14:08:08 +0200
Subject: [LTP] [PATCH v3] commands/keyctl01: Check keyctl support
 instead of kernel version
In-Reply-To: <20170720053812.4394-1-fenggw-fnst@cn.fujitsu.com>
References: <f659c98f-f3bc-72f8-0c51-14dc956beba8@cn.fujitsu.com>
 <20170720053812.4394-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170804120808.GA5400@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking at this closer we only check that the keyctl binary understands
these requests, shouldn't we as well try to request2 and unlink a key to
seek if kernel is up to the task?

And btw, it would be a bit cleaner to use a for loop to check for each
flag separately and tell user what flag is not supported:

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
old mode 100644
new mode 100755
index 76226ae4d..f831acbfc
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -34,11 +34,18 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="keyctl"
 . tst_test.sh
 
+check_keyctl()
+{
+       for op in $@; do
+               if ! keyctl 2>&1 | grep -q "keyctl $op"; then
+                       tst_brk TCONF "keyctl operation $op not supported"
+               fi
+       done
+}
+
 setup()
 {
-       if tst_kvcmp -le 2.6.33; then
-               tst_brk TCONF "Kernel newer than 2.6.33 is needed"
-       fi
+       check_keyctl negate request2 show unlink
 
        PATH_KEYSTAT="/proc/key-users"
        PATH_KEYQUOTA="/proc/sys/kernel/keys/root_maxbytes"


-- 
Cyril Hrubis
chrubis@suse.cz
