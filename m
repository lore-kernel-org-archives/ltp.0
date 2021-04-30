From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 30 Apr 2021 13:08:26 +0200
Subject: [LTP] [RFC] Shell API timeout sleep orphan processes
Message-ID: <f781c0d8-6707-56ba-fa14-e0dbc1b645a1@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I am looking into getting rid of our custom patches for ltp.
One of these patches fixes the problem, that the timeout sleep process 
is orphaned, if the test does not timeout.

The kill code is not working as expected, because it only kills the 
shell process spawned by "sleep $sec && _tst_kill_test &".
We are running single ltp tests using robot framework and robot waits 
until all processes of session have finished.

This can also be seen by piping the output of a testrun into cat (eg. 
with timeout02.sh from newlib_test/shell):
$ time sh -c './timeout02.sh >/dev/null | cat'
timeout02 1 TINFO: timeout per run is 0h 0m 2s
timeout02 1 TPASS: timeout 2 set (LTP_TIMEOUT_MUL='1')

[snip]

real??? 0m2,011s


The test does nothing, and completes in < 100ms. This can be seen 
without piping through cat:

time sh -c 'PATH="$PWD:$PWD/../../../testcases/lib/:$PATH" ./timeout02.sh'
timeout02 1 TINFO: timeout per run is 0h 0m 2s
timeout02 1 TPASS: timeout 2 set (LTP_TIMEOUT_MUL='1')

[snip]

real??? 0m0,010s


I am not sure what the best approach for fixing these sleep orphans is. 
Out patch uses "set -m" around the start of the timer, this makes most 
of the shells create a new process group, but it failed (at least did 
not work) in zsh. The killing of the timeout process is then changed to 
kill the process group (kill -- -$_tst_setup_timer_pid).
This works fine@least for some shells.

The only way to fix this really portable I can think of is moving the 
timeout code (including the logic in _tst_kill_test) into c code. This 
way there would only be one binary, that can be killed flawlessly.

Do you have any other idea or do you think this "bug" is not relevant 
enough to be fixed?

Thanks,
Joerg
