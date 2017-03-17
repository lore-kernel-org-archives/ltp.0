From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 17 Mar 2017 10:37:32 +0100
Subject: [LTP] [RFC 0/1] Test for vulnerability cve-2016-7117 in recvmmsg
 error return path
Message-ID: <20170317103732.4ce5208d@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

The following is a test for a vulnerability in recvmmsg. I have verified that
the bug is reproduced in kernels 3.16.6 (openSUSE branch) and 4.5.0-rc7
(mainline). This is the third security focused test I have created for LTP,
the idea being to detect regressions which allow particular exploits to
work. It can be considered work in progress for now.

Like many kernel exploits this vulnerability requires specific timings to
trigger a race condition. In order to trigger the system calls at the right
time I have used a delay created by nanosleep(). I have also tried using a
simple while loop which may be the better option in terms of accuracy, but I
have not yet found a measurable advantage of one over the other.

If the test successfully triggers the use-after-free then, at least some of
the time on my machine, a kernel null pointer exception is produced and the
test executable is terminated. I made some attempt to leverage the
use-after-free to cause an error on an unrelated socket, but was not
successful and did not pursue this very far as the test is satisfied by a null
pointer exception.

Any feedback or suggestions are welcome.

Thank you,
Richard.

Richard Palethorpe (1):
  Test for vulnerability cve-2016-7117 in recvmmsg error return path

 testcases/cve/2016-7117/cve-2016-7117.c | 203 ++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 testcases/cve/2016-7117/cve-2016-7117.c

-- 
2.12.0
