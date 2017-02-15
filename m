From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Feb 2017 13:19:21 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/mq_open: fix limits for queues_max
In-Reply-To: <956936356.5228861.1487177447794.JavaMail.zimbra@redhat.com>
References: <1486384930-28588-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170215152406.GB29673@rei.lan>
 <956936356.5228861.1487177447794.JavaMail.zimbra@redhat.com>
Message-ID: <1608152395.5261795.1487182761583.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> I'm looking at results of kernel-2.6.32-694.el6 (6.9), and it's passing:
> <<<test_start>>>
> tag=mq_open01 stime=1487065446
> cmdline="mq_open01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
> RESULT: return value(ret)=       7 errno=0 (Success)
> mq_open01    0  TINFO  :  (case00) START
> mq_open01    0  TINFO  :  mq_maxmsg E:20,	R:20
> mq_open01    0  TINFO  :  mq_msgsize E:16384,	R:16384
> mq_open01    0  TINFO  :  (case00) END => OK
> mq_open01    1  TPASS  :  mq_open call succeeded
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>

Oh, I see, the testcase has changed:
 8e49ed6b0fa2 "syscalls/mq_open: fix old tests + convert to use new API"
I was using ltp-20170116. git HEAD fails for me too:

# ./mq_open01
tst_test.c:812: INFO: Timeout per run is 0h 05m 00s
mq_open01.c:230: INFO: queue name "/test_mqueue"
mq_open01.c:260: PASS: NORMAL returned: 3: SUCCESS
mq_open01.c:230: INFO: queue name "/test_mqueue"
mq_open01.c:260: PASS: NORMAL returned: 3: SUCCESS
mq_open01.c:230: INFO: queue name "/caaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
mq_open01.c:260: PASS: NORMAL returned: 3: SUCCESS
mq_open01.c:230: INFO: queue name "/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
mq_open01.c:277: PASS: NORMAL returned: -1: ENAMETOOLONG
mq_open01.c:230: INFO: queue name ""
mq_open01.c:277: PASS: NORMAL returned: -1: EINVAL
mq_open01.c:230: INFO: queue name "/test_mqueue"
mq_open01.c:277: PASS: NORMAL returned: -1: EACCES
mq_open01.c:230: INFO: queue name "/test_mqueue"
mq_open01.c:277: PASS: NORMAL returned: -1: EEXIST
mq_open01.c:230: INFO: queue name "/test_mqueue"
mq_open01.c:277: PASS: NO_FILE returned: -1: EMFILE
mq_open01.c:230: INFO: queue name "/notexist"
mq_open01.c:277: PASS: NORMAL returned: -1: ENOENT
mq_open01.c:230: INFO: queue name "/test_mqueue"
safe_file_ops.c:301: BROK: Failed to close FILE '/proc/sys/fs/mqueue/queues_max' at mq_open01.c:177: EINVAL

So, yes, I'd prefer to apply Xiao's patch. It shouldn't affect
test on newer kernels, and we can test older ones too.

Regards,
Jan
