From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 4 May 2021 10:04:30 +0200
Subject: [LTP] [RFC] Shell API timeout sleep orphan processes
In-Reply-To: <YJDvIcgdl8ae58YB@pevik>
References: <f781c0d8-6707-56ba-fa14-e0dbc1b645a1@jv-coder.de>
 <YJDvIcgdl8ae58YB@pevik>
Message-ID: <5fdefbf3-2b4e-f44b-6cb2-c133ecf36975@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
>> The kill code is not working as expected, because it only kills the shell
>> process spawned by "sleep $sec && _tst_kill_test &".
>> We are running single ltp tests using robot framework and robot waits until
>> all processes of session have finished.
> Interesting. Do you mean $_tst_setup_timer_pid from _tst_setup_timer was left
> running if the test does not timeout? Because I was not able to find it.
Ups there was a bug in my command. Redirection of the output of the test 
to /dev/null does not trigger the long delay:
Please try with time sh -c './timeout02.sh | cat'
Sorry for that...

The line "sleep $sec && _tst_kill_test &" spawns two processes:
sleep and a shell process, that is (probably) forked from the running 
shell. The pid returned by $! is the pid of this shell.
When killing the timeout process, only this shell process, but not the 
sleep is killed. That is also were the slowdown comes from.

However, this might be shell implementation specific. At least for 
busybox sh and I think dash and bash the behavior is the same.

> Interesting slowdown. It looks to me it's exit $ret in final _tst_do_exit()
> takes so much time. I have no idea why, but it was here before 25ad54dba
> ("tst_test.sh: Run cleanup also after test timeout").
I think what actually is consuming the time is the sleep process, that 
has stdout still opened.
Redirecting the output of sleep to /dev/null, fixes the hanging, but 
there is still the orphaned sleep process lingering around.
Try "sleep $sec >/dev/null && _tst_kill_test &"

$ ps; time sh -c 'PATH="$PWD:$PWD/../../../testcases/lib/:$PATH" 
./timeout02.sh | cat' ; ps
 ??? PID TTY????????? TIME CMD
 ?? 2352 pts/5??? 00:00:00 bash
 ? 19981 pts/5??? 00:00:00 ps
timeout02 1 TINFO: timeout per run is 0h 0m 2s
timeout02 1 TPASS: timeout 2 set (LTP_TIMEOUT_MUL='1')

Summary:
passed?? 1
failed?? 0
broken?? 0
skipped? 0
warnings 0

real??? 0m0,013s
user??? 0m0,012s
sys??? 0m0,005s
 ??? PID TTY????????? TIME CMD
 ?? 2352 pts/5??? 00:00:00 bash
 ? 19998 pts/5??? 00:00:00 sleep
 ? 20001 pts/5??? 00:00:00 ps

>> The only way to fix this really portable I can think of is moving the
>> timeout code (including the logic in _tst_kill_test) into c code. This way
>> there would only be one binary, that can be killed flawlessly.
> Maybe set -m would be enough. But sure, rewriting C is usually the best approach
> for shell problems, we use quite a lot of C helpers for shell already.
I will send the patch, if this introduces any new issues, we can still 
switch to a c based implementation.

J?rg
