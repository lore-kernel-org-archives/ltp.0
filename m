From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:48 +0300
Subject: [LTP] waitpid: new API (part 2) V2
Message-ID: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Summary of changes:
 * Updated waitpid09
 * Add TST_TRACE and use it for calls to reap_children(),
   waitpid_ret_test()
 * Split waitpid13 into two patches: one is for waitpid_common.h,
   the other is for waitpid13.c


