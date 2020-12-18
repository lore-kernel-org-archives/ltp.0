From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Dec 2020 09:06:28 +0200
Subject: [LTP] [PATCH 0/3] inotify tests for v5.9 regression
Message-ID: <20201218070631.1182292-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Here is the test for the other v5.9 regression that I mentioned earlier.
The fix commit has just been merged to master.

History:
Originally, inotify10 was written to cover a bug that was detected during
the review of the fsnotify changes for v5.9, but was not merged to v5.9.
Later, I wrote test case #3 to cover another bug that was merged to v5.9.
While testing the v5.9-bug-fix in linux-next, Hugh Dickins reported [1]
a bug introduced by the v5.9-bug-fix, so I added two more test cases
to cover the bug-in-the-bug-fix.
The bug-in-the-bug-fix was fixed before the v5.9-bug-fix was merged.

Long story short, the only test case expected to fail is test case #3 on
kernel >= v5.9 and now fixed in master :-)

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/alpine.LSU.2.11.2012101507080.1100@eggly.anvils/

Amir Goldstein (3):
  syscalls/inotify10: Generalize for more test cases
  syscalls/inotify10: Add test cases with two groups
  syscalls/inotify10: Test two inotify groups with parent and child
    watches

 testcases/kernel/syscalls/inotify/inotify10.c | 126 ++++++++++++++----
 1 file changed, 98 insertions(+), 28 deletions(-)

-- 
2.25.1

