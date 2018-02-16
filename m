From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Feb 2018 16:13:17 +0100
Subject: [LTP] No space left on device
In-Reply-To: <BY2PR13MB0709E6ADB72B75A42150F2F990CB0@BY2PR13MB0709.namprd13.prod.outlook.com>
References: <BY2PR13MB0709E6ADB72B75A42150F2F990CB0@BY2PR13MB0709.namprd13.prod.outlook.com>
Message-ID: <20180216151317.GA11776@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I met a problem when using LTP
> Many tests failed because of "errno=ENOSPC(28): No space left on device"
> Here is one of the example:
> 
> <<<test_start>>>
> tag=readv01 stime=1518724492
> cmdline="readv01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> readv01     1  TBROK  :  safe_macros.c:440: readv01.c:113: write(6,0x30274,4294967295) failed: errno=ENOSPC(28): No space left on device
> readv01     2  TBROK  :  safe_macros.c:440: Remaining cases broken
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=2 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20170116
> ./runltp: line 973: cannot create temp file for here-document: No space left on device
> 
> root@adzs-sc589-ezlite:/opt/ltp# df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/root              7462604    555564   6504916   8% /
> devtmpfs                110608         0    110608   0% /dev
> tmpfs                   110688        40    110648   0% /run
> tmpfs                   110688        52    110636   0% /var/volatile
> 
> Notice I have plenty of space on my disk, and I also check "df -i". Inodes are free as well
> Is anyone had this problem? Please give me a hint, I'll be appreciated

I have never seen such failure.

But if you look at the the actual error message it looks like something
very wrong is happening there. The test is supposed to write 64 bytes to
the temporary file but it looks like in your case it attempts to write
4294967295 bytes, which is around 4GB if I'm counting correctly so it's
no wonder it fails with ENOSPC.

My guess is that the test is miscompiled somehow but that is just a wild
guess.

-- 
Cyril Hrubis
chrubis@suse.cz
