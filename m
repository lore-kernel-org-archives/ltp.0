From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 11 May 2018 17:36:05 +0800
Subject: [LTP] [PATCH] lib/tst_test.sh: Detect quoted parameters
	correctly
In-Reply-To: <20180511091443.yzphiqa5sjo7674x@dell5510>
References: <20180508075025.kiwhybpeticscmbh@dell5510>
 <1525863262-29703-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180509113140.qeagydu6jyo73dfu@dell5510> <5AF5551A.4040101@cn.fujitsu.com>
 <20180511091443.yzphiqa5sjo7674x@dell5510>
Message-ID: <5AF56405.2010404@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/05/11 17:14, Petr Vorel wrote:
> Hi Xiao,
>> Hi Petr,
> Thanks for trying to solve this issue.
>
>> Sorry, i ignored the fact that arrays are bashism.
> No problem, I sometimes get caught by it as well. POSIX shell is also obscure...
>
>> What about moving the process of TST_POS_ARGS to tst_pos_args() and passing "$@" into tst_run() directly?
> I'd be against it. Not only that we'd have to change all test cases, but also that people
> would forget on it.
> Either we drop first getopts usage in tst_test.sh so we can work with "$@" directly in
Hi Petr,

"$@" in tst_run() is processed as the parameters of tst_run() instead of 
global  parameters by default.
This solution seems wrong.
> tst_run() or there is probably no other solution (and in that case we should document this
> feature).
>
> And I feel it's somehow against principle of encapsulation: normally you define variables
> for test, load library and run tests with tst_run().
> Influence running tests later with adding variable directly to tst_run() doesn't look
> right for me.
Hmmm, it is not a sane fix as you said. :-(
I will try to find another solution.

Thanks,
Xiao Yang
> Therefore I'd say NACK.
>
> BTW 9 test cases are quoting with " (most of them are networking):
>
> $ git grep -l -E '^[^#]+".*"' runtest/
> runtest/fs_readonly
> runtest/net.nfs
> runtest/net.tirpc_tests
> runtest/net_stress.ipsec_dccp
> runtest/net_stress.ipsec_icmp
> runtest/net_stress.ipsec_sctp
> runtest/net_stress.ipsec_tcp
> runtest/net_stress.ipsec_udp
> runtest/scsi_debug.part1
>
> and 1 test cases with "'":
> $ git grep -E "^[^#]+'" runtest/
> runtest/fs:read_all_dev read_all -d /dev -e '/dev/watchdog?(0)' -q -r 10
> But this one calls directly binary read_all, so it's working.
>
>> For example(you can test it by running your special df01.sh and pids.sh):
>> -------------------------------------------------------------------
>>   testcases/commands/df/df01.sh |  2 +-
>>   testcases/lib/tst_test.sh     | 33 ++++++++++++++++++---------------
>>   2 files changed, 19 insertions(+), 16 deletions(-)
>> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
>> index fbf1e2f..09656fb 100755
>> --- a/testcases/commands/df/df01.sh
>> +++ b/testcases/commands/df/df01.sh
>> @@ -228,4 +228,4 @@ test12()
>>          fi
>>   }
>> -tst_run
>> +tst_run "$@"
>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>> index 8d49d34..a92d84b 100644
>> --- a/testcases/lib/tst_test.sh
>> +++ b/testcases/lib/tst_test.sh
>> @@ -244,6 +244,22 @@ tst_rescmp()
>>          fi
>>   }
>> +tst_pos_args()
>> +{
>> +       shift $((OPTIND - 1))
>> +
>> +       if [ -n "$TST_POS_ARGS" ]; then
>> +               if [ -z "$TST_PRINT_HELP" -a $# -ne "$TST_POS_ARGS" ]; then
>> +                       tst_brk TBROK "Invalid number of positional paramters:"\
>> +                                       "have ($@) $#, expected ${TST_POS_ARGS}"
>> +               fi
>> +       else
>> +               if [ -z "$TST_PRINT_HELP" -a $# -ne 0 ]; then
>> +                       tst_brk TBROK "Unexpected positional arguments '$@'"
>> +               fi
>> +       fi
>> +}
>> +
>>   tst_run()
>>   {
>>          local tst_i
>> @@ -265,7 +281,7 @@ tst_run()
>>          OPTIND=1
>> -       while getopts "hi:$TST_OPTS" name $TST_ARGS; do
>> +       while getopts "hi:$TST_OPTS" name "$@"; do
>>                  case $name in
>>                  'h') tst_usage; exit 0;;
>>                  'i') TST_ITERATIONS=$OPTARG;;
>> @@ -420,8 +436,6 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
>>                  fi
>>          fi
>> -       TST_ARGS="$@"
>> -
>>          while getopts ":hi:$TST_OPTS" tst_name; do
>>                  case $tst_name in
>>                  'h') TST_PRINT_HELP=1;;
>> @@ -429,16 +443,5 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
>>                  esac
>>          done
>> -       shift $((OPTIND - 1))
>> -
>> -       if [ -n "$TST_POS_ARGS" ]; then
>> -               if [ -z "$TST_PRINT_HELP" -a $# -ne "$TST_POS_ARGS" ]; then
>> -                       tst_brk TBROK "Invalid number of positional paramters:"\
>> -                                         "have ($@) $#, expected ${TST_POS_ARGS}"
>> -               fi
>> -       else
>> -               if [ -z "$TST_PRINT_HELP" -a $# -ne 0 ]; then
>> -                       tst_brk TBROK "Unexpected positional arguments '$@'"
>> -               fi
>> -       fi
>> +       tst_pos_args "$@"
>>   fi
>> -------------------------------------------------------------------
>> But i am not sure this is a sane fix.  :-)
> :-)
>
> Kind regards,
> Petr
>
>
> .
>



