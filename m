From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Jul 2021 13:28:44 +0200
Subject: [LTP] [PATCH 1/2] fork07: Rewrite the test to a proper
 synchronization
In-Reply-To: <20210701032931.132468-2-xieziyao@huawei.com>
References: <20210701032931.132468-1-xieziyao@huawei.com>
 <20210701032931.132468-2-xieziyao@huawei.com>
Message-ID: <YN74bEchlEFD1nDN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The more I look at the test to more I realize how broken it is.

It starts with a wrong premise that file offset changes, as a
consequences of read(), are not propagated between the child and parent
process for a file descriptor that has been opened by parent and
propagated to a child on a fork(). This is not true at all as internally
in kernel the child and parent file descriptor will refer to the same
open file structure. And the test avoids failures by reading a byte from
a libc FILE in the parent, which of course caches data in the FILE
buffer so the first read() in libc reads the whole buffer. After that
each forked child will get the exact FILE structure in it's userspace
memory with the buffered data.

In conclusion this test has to be deleted and we should write a new one
from a scratch.

When we are asked to check if file descriptors are passed down correctly
between forks it makes much more sense to do it as follows:

* Parent writes N bytes (for example 'a') to a file in setup()
* Parent opens a file descriptor for reading pointing to that file
* Parent forks N children
  - each child reads a byte from the file
    checks that the byte is 'a' then exits
* Parent waits the all the children
* Parent checks that the end of file is reached
  for example by checking that read() from the
  file descriptor returns 0


And the other way around would be:

* Parent opens a file descriptor for writing pointing to an empty file
  (the file should be unlinked() before the open with O_CREAT)
* Parent forks N children
  - each child writes a sequence of bytes 'test' or something like this
* Parent waits the all the children
* Parent checks that the file is filled with N string 'test' that are
  not interleaved

-- 
Cyril Hrubis
chrubis@suse.cz
