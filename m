From: Jonatas Bastos <jonatasfbastos@gmail.com>
Date: Thu, 30 Mar 2017 10:13:14 -0300
Subject: [LTP] Correlation between test cases and .c files
Message-ID: <CADKPhiMYE5VeJEMkmgUww6c5ayn9D9SpA3ieF+-KYAZ=Xhopuw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

I`m a PhD student interested in run some studies with the different LTP
releases. I would like to know how can I correlate tests cases with .c file
that contain the test case ?
All test cases listed in runtest/ directory. each file in side it contains
the list of test.

For example:  ltp-20011206 the file crashme in the runtest/ directory
contains

# Before running these: BACKUP YOUR SYSTEM!  you've been warned!
f00f f00f
# This is a simple test for handling of the pentium f00f bug.
# It is an example of a catistrophic test case.  If the system
# doesn't correctly handle this test, it will likely lockup.
crash01 crash01
# Generate random code and execute it. Read f00f comment,
# this test lockup SunOS,WindowsNT,etc. in seconds..
crash02 crash02
# Generate random syscalls and execute them, less probability
# to hose your system, but still.
mem01 mem01 -r
# Memory eater. Loves to be run in parallel with other programs.
# May panic on buggy systems if the OOM killer was not fast enough :-)
proc01 proc01
# Read every file in /proc. Not likely to crash, but does enough
# to disturb the kernel. A good kernel latency killer too.

Where the relations between f001 test case and the respective test file
(code) is established ? I need to inspect the code for each test case and
get some metrics.


-- 
Jonatas Bastos
------------------------------------------------------------ --------
Professor de Computação no Instituto Federal (IFBA)
M.Sc. Computer Science - CIn/UFPE
skype: jonatasfbastos
gtalk: jonatasfbastos@...

“Face your fears, live your dreams"
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170330/8a3bf771/attachment-0001.html>
