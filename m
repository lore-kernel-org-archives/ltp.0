From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Mar 2019 17:01:42 +0100
Subject: [LTP] mbind() fails to fail with EIO
Message-ID: <20190315160142.GA8921@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've started to write tests for mbind() and found out that mbind() does
not work as described in manual page in a case that page has been
faulted on different node that we are asking it to bind to. Looks like
this is working fine on older kernels. On my testing machine with 3.0
mbind() fails correctly with EIO but succeeds unexpectedly on newer
kernels such as 4.12.

What the test does is:

* mmap() private mapping
* fault it
* find out on which node it is faulted on
* mbind() it to a different node with MPOL_BIND and MPOL_MF_STRICT and
  expects to get EIO

The test code can be seen and compiled from:

https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c

-- 
Cyril Hrubis
chrubis@suse.cz
