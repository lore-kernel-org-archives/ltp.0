From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 10 Aug 2016 11:40:58 +0300
Subject: [LTP] waitpid: new API (part 2)
Message-ID: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

This is the second (and last) part of changes to syscalls/waitpid test cases
with the final aim to substitute wait_for_parent() with the checkpoint interface.

waitpid09 was updated in accordance with

http://lists.linux.it/pipermail/ltp/2016-July/002238.html

In particular:
 * the code from do_exit() was moved to the 'if' block
 * used tst_strerrno() to print set and expected errno values

As for waitpid12. In contrast with

http://lists.linux.it/pipermail/ltp/2016-July/002218.html

I decided to keep the process group logic in order to have uniform coverage:

waitpid06: waitpid(-1, , 0)
waitpid07: waitpid(-1, , WNOHANG)
waitpid08: waitpid(-1, , WUNTRACED)
waitpid11: waitpid(0, , 0), waitpid(-group, , 0)
waitpid12: waitpid(0, , WNOHANG), waitpid(-group, , WNOHANG)
waitpid13: waitpid(0, , WUNTRACED), waitpid(-group, , WUNTRACED)

All other patches are new.

Thanks.
 

