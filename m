From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 11 May 2018 16:32:26 +0800
Subject: [LTP] [PATCH] lib/tst_test.sh: Detect quoted parameters
	correctly
In-Reply-To: <20180509113140.qeagydu6jyo73dfu@dell5510>
References: <20180508075025.kiwhybpeticscmbh@dell5510>
 <1525863262-29703-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180509113140.qeagydu6jyo73dfu@dell5510>
Message-ID: <5AF5551A.4040101@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/05/09 19:31, Petr Vorel wrote:
>> If we assign "$@" containing quoted parameters to TST_ARGS variable and pass
>> the variable into getopts, only the first number from quoted parameters can be
>> processed.  "$@" seems to be treated as an array by default, and declaring
>> TST_ARGS as an array could fix this issue.
>> You can reproduce the issue by the folliwng url:
>> [1] https://lists.linux.it/pipermail/ltp/2018-May/008042.html
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> ...
>> -	while getopts "hi:$TST_OPTS" name $TST_ARGS; do
>> +	while getopts "hi:$TST_OPTS" name "${TST_ARGS[@]}"; do
> ...
>
>> -	TST_ARGS="$@"
>> +	TST_ARGS=("$@")
> Thanks for your patch.
>
> NACK. Why: arrays are bashism :(.
> IMHO this doesn't have a solution which would be POSIX compliant
Hi Petr,

Sorry, i ignored the fact that arrays are bashism.

What about moving the process of TST_POS_ARGS to tst_pos_args() and passing "$@" into tst_run() directly?
For example(you can test it by running your special df01.sh and pids.sh):
-------------------------------------------------------------------
  testcases/commands/df/df01.sh |  2 +-
  testcases/lib/tst_test.sh     | 33 ++++++++++++++++++---------------
  2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index fbf1e2f..09656fb 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -228,4 +228,4 @@ test12()
         fi
  }

-tst_run
+tst_run "$@"
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34..a92d84b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -244,6 +244,22 @@ tst_rescmp()
         fi
  }

+tst_pos_args()
+{
+       shift $((OPTIND - 1))
+
+       if [ -n "$TST_POS_ARGS" ]; then
+               if [ -z "$TST_PRINT_HELP" -a $# -ne "$TST_POS_ARGS" ]; then
+                       tst_brk TBROK "Invalid number of positional paramters:"\
+                                       "have ($@) $#, expected ${TST_POS_ARGS}"
+               fi
+       else
+               if [ -z "$TST_PRINT_HELP" -a $# -ne 0 ]; then
+                       tst_brk TBROK "Unexpected positional arguments '$@'"
+               fi
+       fi
+}
+
  tst_run()
  {
         local tst_i
@@ -265,7 +281,7 @@ tst_run()

         OPTIND=1

-       while getopts "hi:$TST_OPTS" name $TST_ARGS; do
+       while getopts "hi:$TST_OPTS" name "$@"; do
                 case $name in
                 'h') tst_usage; exit 0;;
                 'i') TST_ITERATIONS=$OPTARG;;
@@ -420,8 +436,6 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
                 fi
         fi

-       TST_ARGS="$@"
-
         while getopts ":hi:$TST_OPTS" tst_name; do
                 case $tst_name in
                 'h') TST_PRINT_HELP=1;;
@@ -429,16 +443,5 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
                 esac
         done

-       shift $((OPTIND - 1))
-
-       if [ -n "$TST_POS_ARGS" ]; then
-               if [ -z "$TST_PRINT_HELP" -a $# -ne "$TST_POS_ARGS" ]; then
-                       tst_brk TBROK "Invalid number of positional paramters:"\
-                                         "have ($@) $#, expected ${TST_POS_ARGS}"
-               fi
-       else
-               if [ -z "$TST_PRINT_HELP" -a $# -ne 0 ]; then
-                       tst_brk TBROK "Unexpected positional arguments '$@'"
-               fi
-       fi
+       tst_pos_args "$@"
  fi

-------------------------------------------------------------------

But i am not sure this is a sane fix.  :-)

> I recommend testing shell related changes with checkbashisms script from Debian [1].
> Also testing it on dash can reveal bashisms (change /bin/sh symlink from bash to dash as
> some distros have as default).
Thanks for your suggestions.

Thanks,
Xiao Yang

>
> Kind regards,
> Petr
>
> [1] https://anonscm.debian.org/cgit/collab-maint/devscripts.git/plain/scripts/checkbashisms.pl
>
>
> .
>



