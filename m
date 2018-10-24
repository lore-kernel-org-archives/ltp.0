From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Wed, 24 Oct 2018 14:26:56 +1100
Subject: [LTP] [RFC 0/3] syscalls/fanotify03: add support and tests for new
 FAN_OPEN_EXEC_PERM flag
Message-ID: <cover.1540348505.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch series contains the modifications that I'm proposing in order        
to support the testing of the new permission flag FAN_OPEN_EXEC_PERM            
that is to be made available within fanotify.                                   
                                                                                 
The overall idea behind the changes are to allow more control over each         
individual test case based upon how it has been configured. At the same
time, it increases the overall test coverage by performing more operations
on file system objects that have been marked accordingly.
                                                                                
All modifications within this patch series are based on Amir's
'fanotify_sb' branch, which can be found below.                  
                                                                                 
https://github.com/amir73il/ltp/tree/fanotify_sb
                                                                                 
Please note, this is a RFC for testing functionality that is not yet
merged upstream.

---

Matthew Bobrowski (3):
  syscalls/fanotify03: defined additional tcase members to support more
    tcase control
  syscalls/fanotify03: included execve() to generate_events() to
    increase test coverage
  syscalls/fanotify03: add FAN_OPEN_EXEC_PERM tcase support

 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  14 ++
 .../kernel/syscalls/fanotify/fanotify03.c     | 194 ++++++++++++------
 .../kernel/syscalls/fanotify/fanotify_child.c |  14 ++
 4 files changed, 157 insertions(+), 66 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify_child.c

-- 
2.17.2


-- 
Matthew Bobrowski <mbobrowski@mbobrowski.org>
