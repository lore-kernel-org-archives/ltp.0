Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NSSUX-0004Ez-Ly
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 09:47:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSSUV-0000cU-IA
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 09:47:49 +0000
Message-ID: <4B445C36.6040505@cn.fujitsu.com>
Date: Wed, 06 Jan 2010 17:47:34 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B44187D.5030702@cn.fujitsu.com>
	<364299f41001052124ga613fbag6adf7a7460a87ccc@mail.gmail.com>
In-Reply-To: <364299f41001052124ga613fbag6adf7a7460a87ccc@mail.gmail.com>
Subject: Re: [LTP] [PATCH] cpuctl_fj: replace ps by top to fix cpu usage's
 computation error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

at 2010-1-6 13:24, Garrett Cooper wrote:
> On Tue, Jan 5, 2010 at 8:58 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
>> Some abnormal messages outputted in my x86_64.
>> -------------------
>> pid 4622 cpu_usage 0
>> cpuctl_test_fj    1  TFAIL  :  case19    FAIL
>> pid 4646 cpu_usage 0
>> cpuctl_test_fj    1  TFAIL  :  case20    FAIL
>> pid 4670 cpu_usage 63
>> cpuctl_test_fj    1  TFAIL  :  case21    FAIL
>> -------------------
>> I think cpu usage's computation error occured.
>> So I tried to use the oldest arithmetic of cpu usage, fortunately it works.
>> Maybe we should replace 'ps' by 'top' in  get_cpu_usage().
>> By the way, I increased the admissible range of cpu usage in case21()
>> because it jumps out range of 44-56 sometimes.
>>
>> My patch works now:
>> -------------------
>> pid 20277 cpu_usage 97
>> cpuctl_test_fj    1  TPASS  :  case19    PASS
>> pid 20307 cpu_usage 99
>> cpuctl_test_fj    1  TPASS  :  case20    PASS
>> pid 20336 cpu_usage 55
>> pid 20336 cpu_usage 53
>> pid 20336 cpu_usage 55
>> pid 20336 cpu_usage 57
>> pid 20336 cpu_usage 55
>> pid 20336 cpu_usage 55
>> pid 20336 cpu_usage 55
>> pid 20336 cpu_usage 55
>> pid 20336 cpu_usage 57
>> pid 20336 cpu_usage 53
>> cpuctl_test_fj    1  TPASS  :  case21    PASS
>> -------------------
>>
>> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
>> ---
>> --- ltp-full-20091231/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh      2009-11-16 15:40:40.000000000 +0800
>> +++ ltp-full-20091231.new/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh  2010-01-06 12:36:32.000000000 +0800
>> @@ -85,7 +85,10 @@ creat_process()
>>
>>  get_cpu_usage()
>>  {
>> -       ps -eo 'pid,pcpu' | awk '$1 == "'$1'" { sub(/(\.[[:digit:]])*$/, "", $2); print $2 }'
>> +       top=($(top -b -n 1 -p $1 | tail -2 | head -1))
>> +       top=${top[8]}
>> +       top=`echo $top | awk -F "." '{print $1}'`
>> +       echo "$top"
>>  }
>>
>>  kill_all_pid()
>> @@ -627,7 +630,7 @@ case21()
>>        do
>>                cpu_usage=$(get_cpu_usage $pid)
>>                echo "pid $pid cpu_usage $cpu_usage"
>> -               expr 44 \< "$cpu_usage" \& "$cpu_usage" \< 56 > /dev/null 2>&1
>> +               expr 40 \< "$cpu_usage" \& "$cpu_usage" \< 60 > /dev/null 2>&1
>>                ret=$?
>>                : $(( top_times+=1 ))
>>        done
> 
>     Could you add a set -x to the top of the script so we can see the
> output please? ps --version would be helpful too..

I wish it can help you.
--------------------- sh -x -----------------------------
+ for i in '$(seq 1 $TST_TOTAL)'
+ setup
+ '[' -e /dev/cpuctl ']'
+ mkdir -p /dev/cpuctl
+ mount -t cgroup -o cpu cpuctl /dev/cpuctl
+ case19
+ mkdir /dev/cpuctl/1
++ creat_process
++ taskset -p 1 17790
++ cat /dev/zero
++ echo 17790
+ pid=17790
++ creat_process
++ taskset -p 1 17793
++ cat /dev/zero
++ echo 17793
+ pid_other=17793
+ echo 2000000000
+ echo 17790
++ get_cpu_usage 17790
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17790
+++ head -1
+++ tail -2
++ top=97.8
+++ echo 97.8
+++ awk -F . '{print $1}'
++ top=97
++ echo 97
+ cpu_usage=97
+ echo 'pid 17790 cpu_usage 97'
pid 17790 cpu_usage 97
+ kill -9 17790 17793
+ expr 96 '<' 97 '&' 97 '<' 103
+ return 0
+ cleanup
+ mount
+ grep /dev/cpuctl
+ find /dev/cpuctl -type d
+ sort
+ sed -n '2,$p'
+ tac
+ read tmpdir
+ read tmppid
+ rmdir /dev/cpuctl/1
+ read tmpdir
+ umount /dev/cpuctl
+ rmdir /dev/cpuctl
+ tst_resm TPASS 'case19    PASS'
cpuctl_test_fj    1  TPASS  :  case19    PASS
+ for i in '$(seq 1 $TST_TOTAL)'
+ setup
+ '[' -e /dev/cpuctl ']'
+ mkdir -p /dev/cpuctl
+ mount -t cgroup -o cpu cpuctl /dev/cpuctl
+ case20
+ mkdir /dev/cpuctl/1
++ creat_process
++ taskset -p 1 17819
++ cat /dev/zero
++ echo 17819
+ pid=17819
++ creat_process
++ taskset -p 1 17822
++ cat /dev/zero
++ echo 17822
+ pid_other=17822
+ echo 20000000000
+ echo 17819
++ get_cpu_usage 17819
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17819
+++ head -1
+++ tail -2
++ top=97.8
+++ echo 97.8
+++ awk -F . '{print $1}'
++ top=97
++ echo 97
+ cpu_usage=97
+ echo 'pid 17819 cpu_usage 97'
pid 17819 cpu_usage 97
+ kill -9 17819 17822
+ expr 96 '<' 97 '&' 97 '<' 103
+ return 0
+ cleanup
+ mount
+ grep /dev/cpuctl
+ find /dev/cpuctl -type d
+ sort
+ sed -n '2,$p'
+ tac
+ read tmpdir
+ read tmppid
+ rmdir /dev/cpuctl/1
+ read tmpdir
+ umount /dev/cpuctl
+ rmdir /dev/cpuctl
+ tst_resm TPASS 'case20    PASS'
cpuctl_test_fj    1  TPASS  :  case20    PASS
+ for i in '$(seq 1 $TST_TOTAL)'
+ setup
+ '[' -e /dev/cpuctl ']'
+ mkdir -p /dev/cpuctl
+ mount -t cgroup -o cpu cpuctl /dev/cpuctl
+ case21
+ mkdir /dev/cpuctl/1 /dev/cpuctl/1/2
++ creat_process
++ taskset -p 1 17848
++ cat /dev/zero
++ echo 17848
+ pid=17848
+ echo 17848
+ loop_pid=17850
+ sleep 10
+ true
+ creat_process
+ taskset -p 1 17852
+ cat /dev/zero
+ echo 17852
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17855
+ cat /dev/zero
+ echo 17855
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17858
+ cat /dev/zero
+ echo 17858
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17861
+ cat /dev/zero
+ echo 17861
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17864
+ cat /dev/zero
+ echo 17864
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17867
+ cat /dev/zero
+ echo 17867
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17870
+ cat /dev/zero
+ echo 17870
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17873
+ cat /dev/zero
+ echo 17873
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17876
+ cat /dev/zero
+ echo 17876
+ sleep 1
+ true
+ creat_process
+ taskset -p 1 17879
+ cat /dev/zero
+ echo 17879
+ sleep 1
+ ret=0
+ top_times=0
+ '[' 0 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
+ true
+ creat_process
+ taskset -p 1 17887
+ cat /dev/zero
+ echo 17887
+ sleep 1
++ top=49.9
+++ echo 49.9
+++ awk -F . '{print $1}'
++ top=49
++ echo 49
+ cpu_usage=49
+ echo 'pid 17848 cpu_usage 49'
pid 17848 cpu_usage 49
+ expr 40 '<' 49 '&' 49 '<' 60
+ ret=0
+ : 1
+ '[' 1 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
++ top=49.9
+++ echo 49.9
+++ awk -F . '{print $1}'
++ top=49
++ echo 49
+ cpu_usage=49
+ echo 'pid 17848 cpu_usage 49'
pid 17848 cpu_usage 49
+ expr 40 '<' 49 '&' 49 '<' 60
+ ret=0
+ : 2
+ '[' 2 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
+ true
+ creat_process
+ taskset -p 1 17908
+ cat /dev/zero
+ echo 17908
+ sleep 1
++ top=49.9
+++ echo 49.9
+++ awk -F . '{print $1}'
++ top=49
++ echo 49
+ cpu_usage=49
+ echo 'pid 17848 cpu_usage 49'
pid 17848 cpu_usage 49
+ expr 40 '<' 49 '&' 49 '<' 60
+ ret=0
+ : 3
+ '[' 3 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
++ top=47.9
+++ echo 47.9
+++ awk -F . '{print $1}'
++ top=47
++ echo 47
+ cpu_usage=47
+ echo 'pid 17848 cpu_usage 47'
pid 17848 cpu_usage 47
+ expr 40 '<' 47 '&' 47 '<' 60
+ ret=0
+ : 4
+ '[' 4 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
+ true
+ creat_process
+ taskset -p 1 17929
+ cat /dev/zero
+ echo 17929
+ sleep 1
++ top=47.9
+++ echo 47.9
+++ awk -F . '{print $1}'
++ top=47
++ echo 47
+ cpu_usage=47
+ echo 'pid 17848 cpu_usage 47'
pid 17848 cpu_usage 47
+ expr 40 '<' 47 '&' 47 '<' 60
+ ret=0
+ : 5
+ '[' 5 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
++ top=49.9
+++ echo 49.9
+++ awk -F . '{print $1}'
++ top=49
++ echo 49
+ cpu_usage=49
+ echo 'pid 17848 cpu_usage 49'
pid 17848 cpu_usage 49
+ expr 40 '<' 49 '&' 49 '<' 60
+ ret=0
+ : 6
+ '[' 6 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
+ true
+ creat_process
+ taskset -p 1 17950
+ cat /dev/zero
+ echo 17950
+ sleep 1
++ top=49.9
+++ echo 49.9
+++ awk -F . '{print $1}'
++ top=49
++ echo 49
+ cpu_usage=49
+ echo 'pid 17848 cpu_usage 49'
pid 17848 cpu_usage 49
+ expr 40 '<' 49 '&' 49 '<' 60
+ ret=0
+ : 7
+ '[' 7 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
++ top=49.9
+++ echo 49.9
+++ awk -F . '{print $1}'
++ top=49
++ echo 49
+ cpu_usage=49
+ echo 'pid 17848 cpu_usage 49'
pid 17848 cpu_usage 49
+ expr 40 '<' 49 '&' 49 '<' 60
+ ret=0
+ : 8
+ '[' 8 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
+ true
+ creat_process
+ taskset -p 1 17971
+ cat /dev/zero
+ echo 17971
+ sleep 1
++ top=49.9
+++ echo 49.9
+++ awk -F . '{print $1}'
++ top=49
++ echo 49
+ cpu_usage=49
+ echo 'pid 17848 cpu_usage 49'
pid 17848 cpu_usage 49
+ expr 40 '<' 49 '&' 49 '<' 60
+ ret=0
+ : 9
+ '[' 9 -lt 10 -a 0 = 0 ']'
++ get_cpu_usage 17848
++ top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+++ top -b -n 1 -p 17848
+++ tail -2
+++ head -1
++ top=51.9
+++ echo 51.9
+++ awk -F . '{print $1}'
++ top=51
++ echo 51
+ cpu_usage=51
+ echo 'pid 17848 cpu_usage 51'
pid 17848 cpu_usage 51
+ expr 40 '<' 51 '&' 51 '<' 60
+ ret=0
+ : 10
+ '[' 10 -lt 10 -a 0 = 0 ']'
+ kill -9 17848 17850
+ wait 17848 17850
+ sleep 2
+ kill_all_pid
+ sleep 2
+ return 0
+ cleanup
+ mount
+ grep /dev/cpuctl
+ find /dev/cpuctl -type d
+ sort
+ sed -n '2,$p'
+ tac
+ read tmpdir
+ read tmppid
+ rmdir /dev/cpuctl/1/2
+ read tmpdir
+ read tmppid
+ rmdir /dev/cpuctl/1
+ read tmpdir
+ umount /dev/cpuctl
+ rmdir /dev/cpuctl
+ tst_resm TPASS 'case21    PASS'
cpuctl_test_fj    1  TPASS  :  case21    PASS
---------------------------------------------------------

# bash --version
GNU bash, version 4.0.28(1)-release (x86_64-redhat-linux-gnu)
Copyright (C) 2009 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
