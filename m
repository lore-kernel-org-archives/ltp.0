From: Steve Ellcey <sellcey@cavium.com>
Date: Wed, 22 Mar 2017 15:17:05 -0700
Subject: [LTP] Did it pass or did it fail
Message-ID: <201703222217.v2MMH5ZX029117@sellcey-dt.caveonetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I have a question about BROK and LTP results.  When running LTP I see
this in the log file under the results directory:

madvise09                      FAIL       2

Which would lead one to believe that the madvise09 test failed.



But in the output from runltp I see this:

<<<test_start>>>
tag=madvise09 stime=1490213376
cmdline="madvise09"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
madvise09.c:181: PASS: MADV_FREE pages were not freed immediatelly
madvise09.c:187: INFO: Setting memory limits to 8388608 16777216
safe_file_ops.c:144: BROK: Failed to open FILE '/sys/fs/cgroup/memory/ltp_madvise09_20474//memory.memsw.limit_in_bytes' for reading at madvise09.c:190: ENOENT
madvise09.c:289: BROK: Child exitted unexpectedly

Summary:
passed   1
failed   0
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>


This is less clear.  There is the passed line on the one hand and the
'failed 0' line, but then there is the termination_id on the other hand and
the BROK output as well.  Did the test pass or fail?  Is output of this type
expected, where the log shows a FAIL but the stdout from runltp doesn't
necessarily show a clear TFAIL or TPASS in the output?

Steve Ellcey
sellcey@cavium.com
