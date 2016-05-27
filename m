From: Dong ZHu <bluezhudong@gmail.com>
Date: Fri, 27 May 2016 10:25:41 +0800
Subject: [LTP] cgroup_regression_test failed in CentOS 7.2
Message-ID: <CAAUgArA3oBMmf4YJebREKXYyE_XfQnsw3_eO1gV-K_b8FaKnFg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

I ran LTP test suite in CentOS 7.2 with kernel 3.10.0-327, test named
"cgroup_regression_test" Test 3 and Test 5 always failed as below:
http://pastebin.ubuntu.com/16703246/

Test 3 failed when execute "mount -t cgroup -o cpu xxx cgroup/"
Test 5 failed when execute "mount -t cgroup -o $subsys1,$subsys2 xxx
cgroup/"

cpu, hugetlb and perf_event has already been mounted in sys as below:
http://pastebin.ubuntu.com/16703384/

So the mount operation will definitely fail in the test.

I just want to know whether it is the test program issue, and whether it
can be waived ?

Could anybody help taking a look at it ? Thanks !

-- 
Best Regards,
Dong Zhu
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160527/ee9d5ef2/attachment.html>
