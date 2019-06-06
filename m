From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Jun 2019 15:10:16 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/pidfd_send_signal01
In-Reply-To: <20190604114702.28255-1-camann@suse.com>
References: <20190604114702.28255-1-camann@suse.com>
Message-ID: <20190606131015.GA12020@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
When I attempty to compile this code I get:

In file included from pidfd_send_signal.h:11:0,
                 from pidfd_send_signal01.c:17:
pidfd_send_signal.h: In function 'check_syscall_support':
pidfd_send_signal.h:16:14: error: '__NR_pidfd_send_signal' undeclared (first use in this function); did you mean '__NR_perf_event_open'?
  tst_syscall(__NR_pidfd_send_signal);
              ^
../../../../include/lapi/syscalls.h:39:6: note: in definition of macro 'tst_syscall'
  if (NR == __LTP__NR_INVALID_SYSCALL) { \
      ^~
pidfd_send_signal.h:16:14: note: each undeclared identifier is reported only once for each function it appears in
  tst_syscall(__NR_pidfd_send_signal);
              ^
../../../../include/lapi/syscalls.h:39:6: note: in definition of macro 'tst_syscall'
  if (NR == __LTP__NR_INVALID_SYSCALL) { \
      ^~
pidfd_send_signal.h: In function 'pidfd_send_signal':
pidfd_send_signal.h:23:21: error: '__NR_pidfd_send_signal' undeclared (first use in this function); did you mean 'pidfd_send_signal'?
  return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
                     ^
../../../../include/lapi/syscalls.h:39:6: note: in definition of macro 'tst_syscall'
  if (NR == __LTP__NR_INVALID_SYSCALL) { \
      ^~
make: *** [<builtin>: pidfd_send_signal01] Error 1


Have you forgotten to git add the *.in files with syscall numbers?

-- 
Cyril Hrubis
chrubis@suse.cz
