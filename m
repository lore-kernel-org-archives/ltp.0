Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UDVmv-00071v-Du
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:02:53 +0000
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UDVmf-00029V-2X
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:02:53 +0000
Received: by mail-pa0-f43.google.com with SMTP id bh2so275659pad.30
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Mar 2013 00:02:31 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  7 Mar 2013 15:38:32 +0800
Message-Id: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.8.1.4"
Subject: [LTP] [PATCH 1/3] s/Tst_count/tst_count/ to avoid CamelCase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.8.1.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


when using latest checkpatch.pl, CamelCase variables are not encouraged,
this patch does a batch update to replace all var `Tst_count` with
`tst_count`.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 doc/examples/quickhit.c                            |  6 +-
 doc/man3/tst_res.3                                 | 20 +++----
 doc/man3/tst_set_error.3                           | 18 +++---
 doc/man3/tst_sig.3                                 |  8 +--
 include/test.h                                     |  2 +-
 lib/tst_res.c                                      | 16 ++---
 testcases/kernel/fs/proc/proc01.c                  |  2 +-
 testcases/kernel/mem/cpuset/cpuset01.c             |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |  4 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  2 +-
 testcases/kernel/mem/ksm/ksm01.c                   |  2 +-
 testcases/kernel/mem/ksm/ksm02.c                   |  2 +-
 testcases/kernel/mem/ksm/ksm03.c                   |  2 +-
 testcases/kernel/mem/ksm/ksm04.c                   |  2 +-
 testcases/kernel/mem/ksm/ksm05.c                   |  2 +-
 testcases/kernel/mem/mem/mem01.c                   |  2 +-
 .../kernel/mem/mmapstress/mmap-corruption01.c      |  2 +-
 testcases/kernel/mem/oom/oom01.c                   |  2 +-
 testcases/kernel/mem/oom/oom02.c                   |  2 +-
 testcases/kernel/mem/oom/oom03.c                   |  2 +-
 testcases/kernel/mem/oom/oom04.c                   |  2 +-
 testcases/kernel/mem/swapping/swapping01.c         |  2 +-
 testcases/kernel/mem/thp/thp02.c                   |  2 +-
 testcases/kernel/mem/thp/thp03.c                   |  2 +-
 testcases/kernel/mem/tunable/max_map_count.c       |  2 +-
 testcases/kernel/mem/tunable/min_free_kbytes.c     |  2 +-
 testcases/kernel/mem/tunable/overcommit_memory.c   |  2 +-
 testcases/kernel/mem/vma/vma01.c                   |  2 +-
 testcases/kernel/mem/vma/vma02.c                   |  2 +-
 testcases/kernel/mem/vma/vma03.c                   |  2 +-
 testcases/kernel/mem/vma/vma04.c                   |  2 +-
 testcases/kernel/mem/zram/zram01.c                 |  2 +-
 .../kernel/module/create_module/create_module01.c  |  4 +-
 .../kernel/module/create_module/create_module02.c  |  4 +-
 .../kernel/module/delete_module/delete_module01.c  |  4 +-
 .../kernel/module/delete_module/delete_module02.c  |  4 +-
 .../kernel/module/delete_module/delete_module03.c  |  4 +-
 .../kernel/module/query_module/query_module01.c    |  4 +-
 .../kernel/module/query_module/query_module02.c    |  4 +-
 .../kernel/module/query_module/query_module03.c    |  4 +-
 testcases/kernel/numa/support_numa.c               |  2 +-
 .../performance_counters/performance_counter01.c   |  2 +-
 testcases/kernel/syscalls/accept/accept01.c        |  2 +-
 testcases/kernel/syscalls/access/access01.c        |  2 +-
 testcases/kernel/syscalls/access/access02.c        |  2 +-
 testcases/kernel/syscalls/access/access03.c        |  2 +-
 testcases/kernel/syscalls/access/access04.c        |  2 +-
 testcases/kernel/syscalls/access/access05.c        |  2 +-
 testcases/kernel/syscalls/add_key/add_key02.c      |  2 +-
 testcases/kernel/syscalls/adjtimex/adjtimex01.c    |  2 +-
 testcases/kernel/syscalls/adjtimex/adjtimex02.c    |  2 +-
 testcases/kernel/syscalls/alarm/alarm01.c          |  2 +-
 testcases/kernel/syscalls/alarm/alarm02.c          |  2 +-
 testcases/kernel/syscalls/alarm/alarm03.c          |  4 +-
 testcases/kernel/syscalls/alarm/alarm05.c          |  2 +-
 testcases/kernel/syscalls/alarm/alarm06.c          |  2 +-
 testcases/kernel/syscalls/alarm/alarm07.c          |  2 +-
 testcases/kernel/syscalls/asyncio/asyncio02.c      |  2 +-
 testcases/kernel/syscalls/bdflush/bdflush01.c      |  2 +-
 testcases/kernel/syscalls/bind/bind01.c            |  2 +-
 testcases/kernel/syscalls/brk/brk01.c              |  2 +-
 .../kernel/syscalls/cacheflush/cacheflush01.c      |  2 +-
 testcases/kernel/syscalls/capget/capget01.c        |  2 +-
 testcases/kernel/syscalls/capget/capget02.c        |  2 +-
 testcases/kernel/syscalls/capset/capset01.c        |  2 +-
 testcases/kernel/syscalls/capset/capset02.c        |  2 +-
 testcases/kernel/syscalls/chdir/chdir01.c          |  2 +-
 testcases/kernel/syscalls/chdir/chdir02.c          |  2 +-
 testcases/kernel/syscalls/chdir/chdir03.c          |  2 +-
 testcases/kernel/syscalls/chdir/chdir04.c          |  2 +-
 testcases/kernel/syscalls/chmod/chmod01.c          |  2 +-
 testcases/kernel/syscalls/chmod/chmod02.c          |  4 +-
 testcases/kernel/syscalls/chmod/chmod03.c          |  2 +-
 testcases/kernel/syscalls/chmod/chmod04.c          |  2 +-
 testcases/kernel/syscalls/chmod/chmod05.c          |  2 +-
 testcases/kernel/syscalls/chmod/chmod06.c          |  2 +-
 testcases/kernel/syscalls/chmod/chmod07.c          |  2 +-
 testcases/kernel/syscalls/chown/chown01.c          |  2 +-
 testcases/kernel/syscalls/chown/chown02.c          |  2 +-
 testcases/kernel/syscalls/chown/chown03.c          |  2 +-
 testcases/kernel/syscalls/chown/chown04.c          |  2 +-
 testcases/kernel/syscalls/chown/chown05.c          |  2 +-
 testcases/kernel/syscalls/chroot/chroot01.c        |  2 +-
 testcases/kernel/syscalls/chroot/chroot02.c        |  4 +-
 testcases/kernel/syscalls/chroot/chroot03.c        |  4 +-
 testcases/kernel/syscalls/chroot/chroot04.c        |  4 +-
 .../kernel/syscalls/clock_getres/clock_getres01.c  |  2 +-
 .../syscalls/clock_nanosleep/clock_nanosleep01.c   |  2 +-
 .../clock_nanosleep2/clock_nanosleep2_01.c         |  2 +-
 testcases/kernel/syscalls/clone/clone01.c          |  2 +-
 testcases/kernel/syscalls/clone/clone02.c          |  2 +-
 testcases/kernel/syscalls/clone/clone03.c          |  2 +-
 testcases/kernel/syscalls/clone/clone04.c          |  2 +-
 testcases/kernel/syscalls/clone/clone05.c          |  2 +-
 testcases/kernel/syscalls/clone/clone06.c          |  2 +-
 testcases/kernel/syscalls/clone/clone07.c          |  2 +-
 testcases/kernel/syscalls/close/close01.c          |  2 +-
 testcases/kernel/syscalls/close/close02.c          |  4 +-
 testcases/kernel/syscalls/close/close08.c          |  2 +-
 testcases/kernel/syscalls/cma/process_vm01.c       |  2 +-
 testcases/kernel/syscalls/cma/process_vm_readv02.c |  2 +-
 testcases/kernel/syscalls/cma/process_vm_readv03.c |  2 +-
 .../kernel/syscalls/cma/process_vm_writev02.c      |  2 +-
 testcases/kernel/syscalls/connect/connect01.c      |  2 +-
 testcases/kernel/syscalls/creat/creat01.c          |  2 +-
 testcases/kernel/syscalls/creat/creat03.c          |  2 +-
 testcases/kernel/syscalls/creat/creat04.c          |  4 +-
 testcases/kernel/syscalls/creat/creat05.c          |  4 +-
 testcases/kernel/syscalls/creat/creat06.c          |  4 +-
 testcases/kernel/syscalls/creat/creat07.c          |  2 +-
 testcases/kernel/syscalls/creat/creat09.c          |  2 +-
 testcases/kernel/syscalls/dup/dup01.c              |  2 +-
 testcases/kernel/syscalls/dup/dup02.c              |  2 +-
 testcases/kernel/syscalls/dup/dup03.c              |  2 +-
 testcases/kernel/syscalls/dup/dup04.c              |  6 +-
 testcases/kernel/syscalls/dup/dup05.c              |  2 +-
 testcases/kernel/syscalls/dup2/dup201.c            |  2 +-
 testcases/kernel/syscalls/dup2/dup202.c            |  2 +-
 testcases/kernel/syscalls/dup2/dup203.c            |  2 +-
 testcases/kernel/syscalls/dup2/dup204.c            |  2 +-
 testcases/kernel/syscalls/eventfd/eventfd01.c      |  2 +-
 testcases/kernel/syscalls/eventfd2/eventfd2_02.c   |  2 +-
 testcases/kernel/syscalls/execl/execl01.c          |  2 +-
 testcases/kernel/syscalls/execle/execle01.c        |  2 +-
 testcases/kernel/syscalls/execlp/execlp01.c        |  2 +-
 testcases/kernel/syscalls/execv/execv01.c          |  2 +-
 testcases/kernel/syscalls/execve/execve01.c        |  2 +-
 testcases/kernel/syscalls/execve/execve02.c        |  2 +-
 testcases/kernel/syscalls/execve/execve03.c        |  2 +-
 testcases/kernel/syscalls/execve/execve04.c        |  2 +-
 testcases/kernel/syscalls/execve/execve05.c        |  2 +-
 testcases/kernel/syscalls/execvp/execvp01.c        |  2 +-
 testcases/kernel/syscalls/exit/exit01.c            |  2 +-
 testcases/kernel/syscalls/exit/exit02.c            |  4 +-
 testcases/kernel/syscalls/faccessat/faccessat01.c  |  2 +-
 .../kernel/syscalls/fadvise/posix_fadvise01.c      |  2 +-
 .../kernel/syscalls/fadvise/posix_fadvise02.c      |  2 +-
 .../kernel/syscalls/fadvise/posix_fadvise03.c      |  2 +-
 .../kernel/syscalls/fadvise/posix_fadvise04.c      |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate01.c  |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate02.c  |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate03.c  |  4 +-
 testcases/kernel/syscalls/fchdir/fchdir01.c        |  2 +-
 testcases/kernel/syscalls/fchdir/fchdir02.c        |  2 +-
 testcases/kernel/syscalls/fchdir/fchdir03.c        |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod01.c        |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod02.c        |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod03.c        |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod04.c        |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod05.c        |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod06.c        |  2 +-
 testcases/kernel/syscalls/fchmod/fchmod07.c        |  2 +-
 testcases/kernel/syscalls/fchmodat/fchmodat01.c    |  2 +-
 testcases/kernel/syscalls/fchown/fchown01.c        |  2 +-
 testcases/kernel/syscalls/fchown/fchown02.c        |  2 +-
 testcases/kernel/syscalls/fchown/fchown03.c        |  2 +-
 testcases/kernel/syscalls/fchown/fchown04.c        |  2 +-
 testcases/kernel/syscalls/fchown/fchown05.c        |  2 +-
 testcases/kernel/syscalls/fchownat/fchownat01.c    |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl01.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl02.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl03.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl04.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl05.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl07.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl07B.c         |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl08.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl09.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl10.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl12.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl13.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl14.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl15.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl16.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl17.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl19.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl20.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl21.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl22.c          |  4 +-
 testcases/kernel/syscalls/fcntl/fcntl23.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl24.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl25.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl26.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl27.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl28.c          |  2 +-
 testcases/kernel/syscalls/fdatasync/fdatasync01.c  |  4 +-
 testcases/kernel/syscalls/fdatasync/fdatasync02.c  |  4 +-
 testcases/kernel/syscalls/flock/flock01.c          |  4 +-
 testcases/kernel/syscalls/flock/flock02.c          |  2 +-
 testcases/kernel/syscalls/flock/flock03.c          |  2 +-
 testcases/kernel/syscalls/flock/flock04.c          |  2 +-
 testcases/kernel/syscalls/flock/flock05.c          |  4 +-
 testcases/kernel/syscalls/flock/flock06.c          |  4 +-
 testcases/kernel/syscalls/fork/fork01.c            |  2 +-
 testcases/kernel/syscalls/fork/fork02.c            |  2 +-
 testcases/kernel/syscalls/fork/fork03.c            |  2 +-
 testcases/kernel/syscalls/fork/fork04.c            |  2 +-
 testcases/kernel/syscalls/fork/fork06.c            |  2 +-
 testcases/kernel/syscalls/fork/fork07.c            |  2 +-
 testcases/kernel/syscalls/fork/fork08.c            |  2 +-
 testcases/kernel/syscalls/fork/fork09.c            |  2 +-
 testcases/kernel/syscalls/fork/fork10.c            |  2 +-
 testcases/kernel/syscalls/fork/fork11.c            |  2 +-
 testcases/kernel/syscalls/fork/fork12.c            |  2 +-
 testcases/kernel/syscalls/fork/fork13.c            |  2 +-
 testcases/kernel/syscalls/fpathconf/fpathconf01.c  |  2 +-
 testcases/kernel/syscalls/fstat/fstat01.c          |  2 +-
 testcases/kernel/syscalls/fstat/fstat02.c          |  2 +-
 testcases/kernel/syscalls/fstat/fstat03.c          |  2 +-
 testcases/kernel/syscalls/fstat/fstat04.c          |  2 +-
 testcases/kernel/syscalls/fstat/fstat05.c          |  2 +-
 testcases/kernel/syscalls/fstatat/fstatat01.c      |  2 +-
 testcases/kernel/syscalls/fstatfs/fstatfs01.c      |  2 +-
 testcases/kernel/syscalls/fstatfs/fstatfs02.c      |  2 +-
 testcases/kernel/syscalls/fsync/fsync01.c          |  2 +-
 testcases/kernel/syscalls/fsync/fsync02.c          |  2 +-
 testcases/kernel/syscalls/fsync/fsync03.c          |  2 +-
 testcases/kernel/syscalls/ftruncate/ftruncate01.c  |  2 +-
 testcases/kernel/syscalls/ftruncate/ftruncate02.c  |  2 +-
 testcases/kernel/syscalls/futimesat/futimesat01.c  |  2 +-
 .../syscalls/get_mempolicy/get_mempolicy01.c       |  2 +-
 .../syscalls/get_robust_list/get_robust_list01.c   |  2 +-
 .../kernel/syscalls/getcontext/getcontext01.c      |  2 +-
 testcases/kernel/syscalls/getcpu/getcpu01.c        |  4 +-
 testcases/kernel/syscalls/getcwd/getcwd01.c        |  2 +-
 testcases/kernel/syscalls/getcwd/getcwd02.c        |  2 +-
 testcases/kernel/syscalls/getcwd/getcwd03.c        |  2 +-
 testcases/kernel/syscalls/getdents/getdents01.c    |  2 +-
 testcases/kernel/syscalls/getdents/getdents02.c    |  2 +-
 testcases/kernel/syscalls/getdents/getdents03.c    |  2 +-
 testcases/kernel/syscalls/getdents/getdents04.c    |  2 +-
 .../syscalls/getdomainname/getdomainname01.c       |  2 +-
 testcases/kernel/syscalls/getegid/getegid01.c      |  2 +-
 testcases/kernel/syscalls/getegid/getegid02.c      |  4 +-
 testcases/kernel/syscalls/geteuid/geteuid01.c      |  2 +-
 testcases/kernel/syscalls/getgid/getgid01.c        |  2 +-
 testcases/kernel/syscalls/getgid/getgid03.c        |  4 +-
 testcases/kernel/syscalls/getgroups/getgroups01.c  |  2 +-
 testcases/kernel/syscalls/getgroups/getgroups02.c  |  2 +-
 testcases/kernel/syscalls/getgroups/getgroups03.c  |  2 +-
 testcases/kernel/syscalls/getgroups/getgroups04.c  |  2 +-
 testcases/kernel/syscalls/gethostid/gethostid01.c  |  2 +-
 .../kernel/syscalls/gethostname/gethostname01.c    |  2 +-
 testcases/kernel/syscalls/getitimer/getitimer01.c  |  4 +-
 testcases/kernel/syscalls/getitimer/getitimer02.c  |  4 +-
 testcases/kernel/syscalls/getitimer/getitimer03.c  |  4 +-
 .../kernel/syscalls/getpagesize/getpagesize01.c    |  2 +-
 .../kernel/syscalls/getpeername/getpeername01.c    |  2 +-
 testcases/kernel/syscalls/getpgid/getpgid01.c      |  2 +-
 testcases/kernel/syscalls/getpgid/getpgid02.c      |  4 +-
 testcases/kernel/syscalls/getpgrp/getpgrp01.c      |  2 +-
 testcases/kernel/syscalls/getpid/getpid01.c        |  2 +-
 testcases/kernel/syscalls/getpid/getpid02.c        |  2 +-
 testcases/kernel/syscalls/getppid/getppid01.c      |  2 +-
 testcases/kernel/syscalls/getppid/getppid02.c      |  2 +-
 .../kernel/syscalls/getpriority/getpriority01.c    |  2 +-
 .../kernel/syscalls/getpriority/getpriority02.c    |  2 +-
 testcases/kernel/syscalls/getresgid/getresgid01.c  |  2 +-
 testcases/kernel/syscalls/getresgid/getresgid02.c  |  2 +-
 testcases/kernel/syscalls/getresgid/getresgid03.c  |  2 +-
 testcases/kernel/syscalls/getresuid/getresuid01.c  |  2 +-
 testcases/kernel/syscalls/getresuid/getresuid02.c  |  2 +-
 testcases/kernel/syscalls/getresuid/getresuid03.c  |  2 +-
 testcases/kernel/syscalls/getrlimit/getrlimit01.c  |  2 +-
 testcases/kernel/syscalls/getrlimit/getrlimit02.c  |  2 +-
 testcases/kernel/syscalls/getrusage/getrusage01.c  |  2 +-
 testcases/kernel/syscalls/getrusage/getrusage02.c  |  2 +-
 testcases/kernel/syscalls/getrusage/getrusage03.c  |  2 +-
 .../kernel/syscalls/getrusage/getrusage03_child.c  |  2 +-
 testcases/kernel/syscalls/getrusage/getrusage04.c  |  2 +-
 testcases/kernel/syscalls/getsid/getsid01.c        |  4 +-
 testcases/kernel/syscalls/getsid/getsid02.c        |  2 +-
 .../kernel/syscalls/getsockname/getsockname01.c    |  2 +-
 .../kernel/syscalls/getsockopt/getsockopt01.c      |  2 +-
 testcases/kernel/syscalls/gettid/gettid01.c        |  2 +-
 .../kernel/syscalls/gettimeofday/gettimeofday01.c  |  4 +-
 testcases/kernel/syscalls/getuid/getuid01.c        |  2 +-
 testcases/kernel/syscalls/getuid/getuid02.c        |  2 +-
 testcases/kernel/syscalls/getuid/getuid03.c        |  2 +-
 testcases/kernel/syscalls/getxattr/getxattr01.c    |  2 +-
 testcases/kernel/syscalls/getxattr/getxattr02.c    |  2 +-
 testcases/kernel/syscalls/getxattr/getxattr03.c    |  2 +-
 testcases/kernel/syscalls/inotify/inotify01.c      | 36 ++++++------
 testcases/kernel/syscalls/inotify/inotify02.c      | 62 ++++++++++----------
 testcases/kernel/syscalls/inotify/inotify03.c      | 18 +++---
 testcases/kernel/syscalls/inotify/inotify04.c      | 40 ++++++-------
 .../syscalls/inotify_init/inotify_init1_01.c       |  2 +-
 .../syscalls/inotify_init/inotify_init1_02.c       |  2 +-
 testcases/kernel/syscalls/io_cancel/io_cancel01.c  |  2 +-
 .../kernel/syscalls/io_destroy/io_destroy01.c      |  2 +-
 .../kernel/syscalls/io_getevents/io_getevents01.c  |  2 +-
 testcases/kernel/syscalls/io_setup/io_setup01.c    |  2 +-
 testcases/kernel/syscalls/io_submit/io_submit01.c  |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl01.c          |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl02.c          |  2 +-
 testcases/kernel/syscalls/ioperm/ioperm01.c        |  2 +-
 testcases/kernel/syscalls/ioperm/ioperm02.c        |  2 +-
 testcases/kernel/syscalls/iopl/iopl01.c            |  2 +-
 testcases/kernel/syscalls/iopl/iopl02.c            |  2 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl01.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl02.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl04.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgget/msgget01.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgget/msgget02.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgget/msgget03.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgget/msgget04.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c    |  2 +-
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c    |  4 +-
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c    |  4 +-
 testcases/kernel/syscalls/ipc/semctl/semctl01.c    |  4 +-
 testcases/kernel/syscalls/ipc/semctl/semctl02.c    |  4 +-
 testcases/kernel/syscalls/ipc/semctl/semctl03.c    |  4 +-
 testcases/kernel/syscalls/ipc/semctl/semctl04.c    |  4 +-
 testcases/kernel/syscalls/ipc/semctl/semctl05.c    |  4 +-
 testcases/kernel/syscalls/ipc/semget/semget01.c    |  4 +-
 testcases/kernel/syscalls/ipc/semget/semget02.c    |  4 +-
 testcases/kernel/syscalls/ipc/semget/semget03.c    |  4 +-
 testcases/kernel/syscalls/ipc/semget/semget05.c    |  4 +-
 testcases/kernel/syscalls/ipc/semget/semget06.c    |  4 +-
 testcases/kernel/syscalls/ipc/semop/semop01.c      |  4 +-
 testcases/kernel/syscalls/ipc/semop/semop02.c      |  4 +-
 testcases/kernel/syscalls/ipc/semop/semop03.c      |  4 +-
 testcases/kernel/syscalls/ipc/semop/semop04.c      |  4 +-
 testcases/kernel/syscalls/ipc/semop/semop05.c      |  4 +-
 testcases/kernel/syscalls/ipc/shmat/shmat01.c      |  4 +-
 testcases/kernel/syscalls/ipc/shmat/shmat02.c      |  2 +-
 testcases/kernel/syscalls/ipc/shmat/shmat03.c      |  4 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl02.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl03.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmdt/shmdt01.c      |  4 +-
 testcases/kernel/syscalls/ipc/shmdt/shmdt02.c      |  4 +-
 testcases/kernel/syscalls/ipc/shmget/shmget01.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmget/shmget02.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmget/shmget03.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmget/shmget04.c    |  4 +-
 testcases/kernel/syscalls/ipc/shmget/shmget05.c    |  4 +-
 testcases/kernel/syscalls/keyctl/keyctl01.c        |  2 +-
 testcases/kernel/syscalls/kill/kill01.c            |  4 +-
 testcases/kernel/syscalls/kill/kill02.c            |  6 +-
 testcases/kernel/syscalls/kill/kill03.c            |  4 +-
 testcases/kernel/syscalls/kill/kill04.c            |  4 +-
 testcases/kernel/syscalls/kill/kill05.c            |  2 +-
 testcases/kernel/syscalls/kill/kill06.c            |  4 +-
 testcases/kernel/syscalls/kill/kill07.c            |  4 +-
 testcases/kernel/syscalls/kill/kill08.c            |  4 +-
 testcases/kernel/syscalls/kill/kill09.c            |  2 +-
 testcases/kernel/syscalls/kill/kill10.c            |  2 +-
 testcases/kernel/syscalls/lchown/lchown01.c        |  2 +-
 testcases/kernel/syscalls/lchown/lchown02.c        |  2 +-
 testcases/kernel/syscalls/link/link02.c            |  2 +-
 testcases/kernel/syscalls/link/link03.c            |  4 +-
 testcases/kernel/syscalls/link/link04.c            |  4 +-
 testcases/kernel/syscalls/link/link05.c            |  6 +-
 testcases/kernel/syscalls/link/link06.c            |  2 +-
 testcases/kernel/syscalls/link/link07.c            |  2 +-
 testcases/kernel/syscalls/linkat/linkat01.c        |  2 +-
 testcases/kernel/syscalls/listen/listen01.c        |  2 +-
 testcases/kernel/syscalls/llseek/llseek01.c        |  2 +-
 testcases/kernel/syscalls/llseek/llseek02.c        |  2 +-
 testcases/kernel/syscalls/lseek/lseek01.c          |  4 +-
 testcases/kernel/syscalls/lseek/lseek02.c          |  4 +-
 testcases/kernel/syscalls/lseek/lseek03.c          |  4 +-
 testcases/kernel/syscalls/lseek/lseek04.c          |  4 +-
 testcases/kernel/syscalls/lseek/lseek05.c          |  4 +-
 testcases/kernel/syscalls/lseek/lseek06.c          |  2 +-
 testcases/kernel/syscalls/lseek/lseek07.c          |  2 +-
 testcases/kernel/syscalls/lseek/lseek08.c          |  2 +-
 testcases/kernel/syscalls/lseek/lseek09.c          |  2 +-
 testcases/kernel/syscalls/lseek/lseek10.c          |  2 +-
 testcases/kernel/syscalls/lstat/lstat01.c          |  2 +-
 testcases/kernel/syscalls/lstat/lstat02.c          |  2 +-
 testcases/kernel/syscalls/lstat/lstat03.c          |  2 +-
 testcases/kernel/syscalls/madvise/madvise01.c      |  2 +-
 testcases/kernel/syscalls/madvise/madvise02.c      |  2 +-
 testcases/kernel/syscalls/madvise/madvise03.c      |  2 +-
 testcases/kernel/syscalls/madvise/madvise04.c      |  2 +-
 testcases/kernel/syscalls/mallopt/mallopt01.c      |  2 +-
 testcases/kernel/syscalls/mbind/mbind01.c          |  2 +-
 .../syscalls/migrate_pages/migrate_pages01.c       |  2 +-
 .../syscalls/migrate_pages/migrate_pages02.c       |  2 +-
 testcases/kernel/syscalls/mincore/mincore01.c      |  4 +-
 testcases/kernel/syscalls/mkdir/mkdir01.c          |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir02.c          |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir03.c          |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir04.c          |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir05.c          |  2 +-
 testcases/kernel/syscalls/mkdir/mkdir08.c          |  2 +-
 testcases/kernel/syscalls/mkdirat/mkdirat01.c      |  2 +-
 testcases/kernel/syscalls/mknod/mknod01.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod02.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod03.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod04.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod05.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod06.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod07.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod08.c          |  2 +-
 testcases/kernel/syscalls/mknod/mknod09.c          |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat01.c      |  2 +-
 testcases/kernel/syscalls/mlock/mlock01.c          |  2 +-
 testcases/kernel/syscalls/mlock/mlock02.c          |  2 +-
 testcases/kernel/syscalls/mlockall/mlockall01.c    |  2 +-
 testcases/kernel/syscalls/mlockall/mlockall02.c    |  2 +-
 testcases/kernel/syscalls/mlockall/mlockall03.c    |  2 +-
 testcases/kernel/syscalls/mmap/mmap001.c           |  2 +-
 testcases/kernel/syscalls/mmap/mmap01.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap02.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap03.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap04.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap05.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap06.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap07.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap08.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap09.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap10.c            |  2 +-
 testcases/kernel/syscalls/mmap/mmap11.c            |  2 +-
 .../kernel/syscalls/modify_ldt/modify_ldt01.c      |  4 +-
 .../kernel/syscalls/modify_ldt/modify_ldt02.c      |  4 +-
 testcases/kernel/syscalls/mount/mount01.c          |  2 +-
 testcases/kernel/syscalls/mount/mount02.c          |  2 +-
 testcases/kernel/syscalls/mount/mount03.c          |  2 +-
 testcases/kernel/syscalls/mount/mount04.c          |  2 +-
 .../kernel/syscalls/move_pages/move_pages01.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages02.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages03.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages04.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages05.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages06.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages07.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages08.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages09.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages10.c      |  4 +-
 .../kernel/syscalls/move_pages/move_pages11.c      |  4 +-
 testcases/kernel/syscalls/mprotect/mprotect01.c    |  4 +-
 testcases/kernel/syscalls/mprotect/mprotect02.c    |  2 +-
 testcases/kernel/syscalls/mprotect/mprotect03.c    |  4 +-
 testcases/kernel/syscalls/mq_notify/mq_notify01.c  |  2 +-
 testcases/kernel/syscalls/mq_open/mq_open01.c      |  2 +-
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   |  2 +-
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |  2 +-
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c  |  2 +-
 testcases/kernel/syscalls/mremap/mremap01.c        |  2 +-
 testcases/kernel/syscalls/mremap/mremap02.c        |  2 +-
 testcases/kernel/syscalls/mremap/mremap03.c        |  2 +-
 testcases/kernel/syscalls/mremap/mremap04.c        |  2 +-
 testcases/kernel/syscalls/mremap/mremap05.c        |  2 +-
 testcases/kernel/syscalls/msync/msync01.c          |  2 +-
 testcases/kernel/syscalls/msync/msync02.c          |  2 +-
 testcases/kernel/syscalls/msync/msync03.c          |  2 +-
 testcases/kernel/syscalls/msync/msync04.c          |  2 +-
 testcases/kernel/syscalls/msync/msync05.c          |  2 +-
 testcases/kernel/syscalls/munlock/munlock01.c      |  2 +-
 testcases/kernel/syscalls/munlock/munlock02.c      |  2 +-
 .../kernel/syscalls/munlockall/munlockall01.c      |  2 +-
 .../kernel/syscalls/munlockall/munlockall02.c      |  2 +-
 testcases/kernel/syscalls/munmap/munmap01.c        |  2 +-
 testcases/kernel/syscalls/munmap/munmap02.c        |  2 +-
 testcases/kernel/syscalls/munmap/munmap03.c        |  2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep01.c  |  2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep02.c  |  2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep03.c  |  2 +-
 testcases/kernel/syscalls/nanosleep/nanosleep04.c  |  2 +-
 testcases/kernel/syscalls/newuname/newuname01.c    |  2 +-
 testcases/kernel/syscalls/nice/nice01.c            |  2 +-
 testcases/kernel/syscalls/nice/nice02.c            |  2 +-
 testcases/kernel/syscalls/nice/nice03.c            |  2 +-
 testcases/kernel/syscalls/nice/nice04.c            |  2 +-
 testcases/kernel/syscalls/nice/nice05.c            |  2 +-
 testcases/kernel/syscalls/open/open01.c            |  2 +-
 testcases/kernel/syscalls/open/open02.c            |  2 +-
 testcases/kernel/syscalls/open/open03.c            |  2 +-
 testcases/kernel/syscalls/open/open04.c            |  2 +-
 testcases/kernel/syscalls/open/open05.c            |  4 +-
 testcases/kernel/syscalls/open/open06.c            |  2 +-
 testcases/kernel/syscalls/open/open07.c            |  2 +-
 testcases/kernel/syscalls/open/open08.c            |  2 +-
 testcases/kernel/syscalls/openat/openat01.c        |  2 +-
 testcases/kernel/syscalls/pathconf/pathconf01.c    |  2 +-
 testcases/kernel/syscalls/pause/pause01.c          |  2 +-
 testcases/kernel/syscalls/pause/pause02.c          |  2 +-
 testcases/kernel/syscalls/pause/pause03.c          |  2 +-
 .../kernel/syscalls/personality/personality01.c    |  4 +-
 .../kernel/syscalls/personality/personality02.c    |  4 +-
 testcases/kernel/syscalls/pipe/pipe01.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe02.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe03.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe04.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe05.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe06.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe07.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe08.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe09.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe10.c            |  4 +-
 testcases/kernel/syscalls/pipe/pipe11.c            |  4 +-
 testcases/kernel/syscalls/pipe2/pipe2_01.c         |  2 +-
 testcases/kernel/syscalls/pipe2/pipe2_02.c         |  2 +-
 testcases/kernel/syscalls/poll/poll01.c            |  2 +-
 testcases/kernel/syscalls/prctl/prctl01.c          |  2 +-
 testcases/kernel/syscalls/prctl/prctl02.c          |  2 +-
 testcases/kernel/syscalls/pread/pread01.c          |  4 +-
 testcases/kernel/syscalls/pread/pread02.c          |  2 +-
 testcases/kernel/syscalls/pread/pread03.c          |  4 +-
 testcases/kernel/syscalls/ptrace/ptrace01.c        |  2 +-
 testcases/kernel/syscalls/ptrace/ptrace02.c        |  2 +-
 testcases/kernel/syscalls/ptrace/ptrace03.c        |  2 +-
 testcases/kernel/syscalls/pwrite/pwrite01.c        |  2 +-
 testcases/kernel/syscalls/pwrite/pwrite02.c        |  2 +-
 testcases/kernel/syscalls/pwrite/pwrite03.c        |  2 +-
 testcases/kernel/syscalls/quotactl/quotactl01.c    |  2 +-
 testcases/kernel/syscalls/read/read01.c            |  2 +-
 testcases/kernel/syscalls/read/read02.c            |  4 +-
 testcases/kernel/syscalls/read/read03.c            |  4 +-
 testcases/kernel/syscalls/read/read04.c            |  2 +-
 testcases/kernel/syscalls/readahead/readahead01.c  |  2 +-
 testcases/kernel/syscalls/readahead/readahead02.c  |  2 +-
 testcases/kernel/syscalls/readdir/readdir01.c      |  2 +-
 testcases/kernel/syscalls/readdir/readdir02.c      |  2 +-
 testcases/kernel/syscalls/readlink/readlink01.c    |  2 +-
 testcases/kernel/syscalls/readlink/readlink02.c    |  2 +-
 testcases/kernel/syscalls/readlink/readlink03.c    |  2 +-
 testcases/kernel/syscalls/readlink/readlink04.c    |  2 +-
 .../kernel/syscalls/readlinkat/readlinkat01.c      |  2 +-
 testcases/kernel/syscalls/readv/readv01.c          |  4 +-
 testcases/kernel/syscalls/readv/readv02.c          |  4 +-
 testcases/kernel/syscalls/readv/readv03.c          |  4 +-
 testcases/kernel/syscalls/reboot/reboot01.c        |  2 +-
 testcases/kernel/syscalls/reboot/reboot02.c        |  2 +-
 testcases/kernel/syscalls/recv/recv01.c            |  2 +-
 testcases/kernel/syscalls/recvfrom/recvfrom01.c    |  2 +-
 testcases/kernel/syscalls/recvmsg/recvmsg01.c      |  2 +-
 .../syscalls/remap_file_pages/remap_file_pages01.c |  2 +-
 .../syscalls/remap_file_pages/remap_file_pages02.c |  2 +-
 testcases/kernel/syscalls/rename/rename01.c        |  2 +-
 testcases/kernel/syscalls/rename/rename02.c        |  2 +-
 testcases/kernel/syscalls/rename/rename03.c        |  2 +-
 testcases/kernel/syscalls/rename/rename04.c        |  2 +-
 testcases/kernel/syscalls/rename/rename05.c        |  2 +-
 testcases/kernel/syscalls/rename/rename06.c        |  2 +-
 testcases/kernel/syscalls/rename/rename07.c        |  2 +-
 testcases/kernel/syscalls/rename/rename08.c        |  2 +-
 testcases/kernel/syscalls/rename/rename09.c        |  2 +-
 testcases/kernel/syscalls/rename/rename10.c        |  2 +-
 testcases/kernel/syscalls/rename/rename12.c        |  2 +-
 testcases/kernel/syscalls/rename/rename13.c        |  2 +-
 testcases/kernel/syscalls/renameat/renameat01.c    |  2 +-
 testcases/kernel/syscalls/rmdir/rmdir01.c          |  2 +-
 testcases/kernel/syscalls/rmdir/rmdir02.c          |  2 +-
 testcases/kernel/syscalls/rmdir/rmdir03.c          |  2 +-
 testcases/kernel/syscalls/rmdir/rmdir04.c          |  2 +-
 testcases/kernel/syscalls/rmdir/rmdir05.c          |  2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |  2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |  2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |  2 +-
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |  4 +-
 .../syscalls/rt_sigprocmask/rt_sigprocmask02.c     |  2 +-
 .../syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c   |  2 +-
 .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |  2 +-
 testcases/kernel/syscalls/sbrk/sbrk01.c            |  2 +-
 .../sched_get_priority_max01.c                     |  2 +-
 .../sched_get_priority_max02.c                     |  2 +-
 .../sched_get_priority_min01.c                     |  2 +-
 .../sched_get_priority_min02.c                     |  2 +-
 .../sched_getaffinity/sched_getaffinity01.c        |  2 +-
 .../syscalls/sched_getparam/sched_getparam01.c     |  2 +-
 .../syscalls/sched_getparam/sched_getparam02.c     |  2 +-
 .../syscalls/sched_getparam/sched_getparam03.c     |  4 +-
 .../sched_getscheduler/sched_getscheduler01.c      |  2 +-
 .../sched_getscheduler/sched_getscheduler02.c      |  4 +-
 .../sched_rr_get_interval01.c                      |  2 +-
 .../sched_rr_get_interval02.c                      |  2 +-
 .../sched_rr_get_interval03.c                      |  2 +-
 .../syscalls/sched_setparam/sched_setparam01.c     |  2 +-
 .../syscalls/sched_setparam/sched_setparam02.c     |  2 +-
 .../syscalls/sched_setparam/sched_setparam03.c     |  2 +-
 .../syscalls/sched_setparam/sched_setparam04.c     |  4 +-
 .../syscalls/sched_setparam/sched_setparam05.c     |  2 +-
 .../sched_setscheduler/sched_setscheduler01.c      |  4 +-
 .../sched_setscheduler/sched_setscheduler02.c      |  4 +-
 .../kernel/syscalls/sched_yield/sched_yield01.c    |  4 +-
 testcases/kernel/syscalls/select/select01.c        |  2 +-
 testcases/kernel/syscalls/select/select02.c        |  2 +-
 testcases/kernel/syscalls/select/select03.c        |  2 +-
 testcases/kernel/syscalls/send/send01.c            |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile02.c    |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile03.c    |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile04.c    |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile05.c    |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile06.c    |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile07.c    |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c      |  2 +-
 testcases/kernel/syscalls/sendto/sendto01.c        |  2 +-
 .../syscalls/set_robust_list/set_robust_list01.c   |  2 +-
 .../syscalls/set_tid_address/set_tid_address01.c   |  2 +-
 .../syscalls/setdomainname/setdomainname01.c       |  2 +-
 .../syscalls/setdomainname/setdomainname02.c       |  4 +-
 .../syscalls/setdomainname/setdomainname03.c       |  2 +-
 testcases/kernel/syscalls/setfsgid/setfsgid01.c    |  4 +-
 testcases/kernel/syscalls/setfsgid/setfsgid02.c    |  4 +-
 testcases/kernel/syscalls/setfsgid/setfsgid03.c    |  4 +-
 testcases/kernel/syscalls/setfsuid/setfsuid01.c    |  4 +-
 testcases/kernel/syscalls/setfsuid/setfsuid02.c    |  4 +-
 testcases/kernel/syscalls/setfsuid/setfsuid03.c    |  4 +-
 testcases/kernel/syscalls/setfsuid/setfsuid04.c    |  2 +-
 testcases/kernel/syscalls/setgid/setgid01.c        |  2 +-
 testcases/kernel/syscalls/setgid/setgid02.c        |  4 +-
 testcases/kernel/syscalls/setgid/setgid03.c        |  4 +-
 testcases/kernel/syscalls/setgroups/setgroups01.c  |  2 +-
 testcases/kernel/syscalls/setgroups/setgroups02.c  |  2 +-
 testcases/kernel/syscalls/setgroups/setgroups03.c  |  2 +-
 testcases/kernel/syscalls/setgroups/setgroups04.c  |  2 +-
 .../kernel/syscalls/sethostname/sethostname01.c    |  2 +-
 .../kernel/syscalls/sethostname/sethostname02.c    |  2 +-
 .../kernel/syscalls/sethostname/sethostname03.c    |  2 +-
 testcases/kernel/syscalls/setitimer/setitimer01.c  |  4 +-
 testcases/kernel/syscalls/setitimer/setitimer02.c  |  4 +-
 testcases/kernel/syscalls/setitimer/setitimer03.c  |  4 +-
 testcases/kernel/syscalls/setpgid/setpgid01.c      |  2 +-
 testcases/kernel/syscalls/setpgid/setpgid02.c      |  4 +-
 testcases/kernel/syscalls/setpgid/setpgid03.c      |  4 +-
 testcases/kernel/syscalls/setpgrp/setpgrp01.c      |  2 +-
 testcases/kernel/syscalls/setpgrp/setpgrp02.c      |  4 +-
 .../kernel/syscalls/setpriority/setpriority01.c    |  4 +-
 .../kernel/syscalls/setpriority/setpriority02.c    |  4 +-
 .../kernel/syscalls/setpriority/setpriority03.c    |  4 +-
 .../kernel/syscalls/setpriority/setpriority04.c    |  4 +-
 .../kernel/syscalls/setpriority/setpriority05.c    |  4 +-
 testcases/kernel/syscalls/setregid/setregid01.c    |  2 +-
 testcases/kernel/syscalls/setregid/setregid02.c    |  4 +-
 testcases/kernel/syscalls/setregid/setregid03.c    |  4 +-
 testcases/kernel/syscalls/setregid/setregid04.c    |  4 +-
 testcases/kernel/syscalls/setresgid/setresgid01.c  |  4 +-
 testcases/kernel/syscalls/setresgid/setresgid02.c  |  4 +-
 testcases/kernel/syscalls/setresgid/setresgid03.c  |  4 +-
 testcases/kernel/syscalls/setresuid/setresuid01.c  |  4 +-
 testcases/kernel/syscalls/setresuid/setresuid02.c  |  4 +-
 testcases/kernel/syscalls/setresuid/setresuid03.c  |  4 +-
 testcases/kernel/syscalls/setresuid/setresuid04.c  |  6 +-
 testcases/kernel/syscalls/setreuid/setreuid01.c    |  2 +-
 testcases/kernel/syscalls/setreuid/setreuid02.c    |  4 +-
 testcases/kernel/syscalls/setreuid/setreuid03.c    |  4 +-
 testcases/kernel/syscalls/setreuid/setreuid04.c    |  4 +-
 testcases/kernel/syscalls/setreuid/setreuid05.c    |  4 +-
 testcases/kernel/syscalls/setreuid/setreuid06.c    |  4 +-
 testcases/kernel/syscalls/setreuid/setreuid07.c    |  6 +-
 testcases/kernel/syscalls/setrlimit/setrlimit01.c  |  4 +-
 testcases/kernel/syscalls/setrlimit/setrlimit02.c  |  2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit03.c  |  2 +-
 testcases/kernel/syscalls/setsid/setsid01.c        |  4 +-
 .../kernel/syscalls/setsockopt/setsockopt01.c      |  2 +-
 .../kernel/syscalls/settimeofday/settimeofday01.c  |  4 +-
 .../kernel/syscalls/settimeofday/settimeofday02.c  |  4 +-
 testcases/kernel/syscalls/setuid/setuid01.c        |  2 +-
 testcases/kernel/syscalls/setuid/setuid02.c        |  2 +-
 testcases/kernel/syscalls/setuid/setuid03.c        |  4 +-
 testcases/kernel/syscalls/setuid/setuid04.c        |  4 +-
 testcases/kernel/syscalls/setxattr/setxattr01.c    |  2 +-
 testcases/kernel/syscalls/setxattr/setxattr02.c    |  2 +-
 testcases/kernel/syscalls/setxattr/setxattr03.c    |  2 +-
 testcases/kernel/syscalls/sgetmask/sgetmask01.c    |  2 +-
 testcases/kernel/syscalls/sigaction/sigaction01.c  |  4 +-
 .../kernel/syscalls/sigaltstack/sigaltstack01.c    |  4 +-
 .../kernel/syscalls/sigaltstack/sigaltstack02.c    |  4 +-
 testcases/kernel/syscalls/sighold/sighold02.c      |  6 +-
 testcases/kernel/syscalls/signal/signal01.c        | 18 +++---
 testcases/kernel/syscalls/signal/signal02.c        |  6 +-
 testcases/kernel/syscalls/signal/signal03.c        |  4 +-
 testcases/kernel/syscalls/signal/signal04.c        |  4 +-
 testcases/kernel/syscalls/signal/signal05.c        |  4 +-
 testcases/kernel/syscalls/signalfd/signalfd01.c    |  2 +-
 testcases/kernel/syscalls/signalfd4/signalfd4_01.c |  2 +-
 testcases/kernel/syscalls/signalfd4/signalfd4_02.c |  2 +-
 .../kernel/syscalls/sigpending/sigpending02.c      |  2 +-
 .../kernel/syscalls/sigprocmask/sigprocmask01.c    |  4 +-
 testcases/kernel/syscalls/sigrelse/sigrelse01.c    |  2 +-
 .../kernel/syscalls/sigsuspend/sigsuspend01.c      |  4 +-
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 10 ++--
 testcases/kernel/syscalls/socket/socket01.c        |  2 +-
 testcases/kernel/syscalls/socket/socket02.c        |  2 +-
 testcases/kernel/syscalls/socket/socket03.c        |  2 +-
 .../kernel/syscalls/socketcall/socketcall01.c      |  2 +-
 .../kernel/syscalls/socketcall/socketcall02.c      |  2 +-
 .../kernel/syscalls/socketcall/socketcall03.c      |  2 +-
 .../kernel/syscalls/socketcall/socketcall04.c      |  2 +-
 .../kernel/syscalls/socketpair/socketpair01.c      |  2 +-
 testcases/kernel/syscalls/sockioctl/sockioctl01.c  |  2 +-
 testcases/kernel/syscalls/splice/splice01.c        |  2 +-
 testcases/kernel/syscalls/ssetmask/ssetmask01.c    |  2 +-
 testcases/kernel/syscalls/stat/stat01.c            |  4 +-
 testcases/kernel/syscalls/stat/stat02.c            |  4 +-
 testcases/kernel/syscalls/stat/stat03.c            |  4 +-
 testcases/kernel/syscalls/stat/stat05.c            |  2 +-
 testcases/kernel/syscalls/stat/stat06.c            |  4 +-
 testcases/kernel/syscalls/statfs/statfs01.c        |  2 +-
 testcases/kernel/syscalls/statfs/statfs02.c        |  2 +-
 testcases/kernel/syscalls/statfs/statfs03.c        |  2 +-
 testcases/kernel/syscalls/statvfs/statvfs01.c      |  2 +-
 testcases/kernel/syscalls/stime/stime01.c          |  2 +-
 testcases/kernel/syscalls/stime/stime02.c          |  4 +-
 testcases/kernel/syscalls/swapoff/swapoff01.c      |  2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c      |  2 +-
 testcases/kernel/syscalls/swapon/swapon01.c        |  2 +-
 testcases/kernel/syscalls/swapon/swapon02.c        |  2 +-
 testcases/kernel/syscalls/swapon/swapon03.c        |  2 +-
 testcases/kernel/syscalls/symlink/symlink01.c      | 68 +++++++++++-----------
 testcases/kernel/syscalls/symlink/symlink02.c      |  2 +-
 testcases/kernel/syscalls/symlink/symlink03.c      |  4 +-
 testcases/kernel/syscalls/symlink/symlink04.c      |  4 +-
 testcases/kernel/syscalls/symlink/symlink05.c      |  4 +-
 testcases/kernel/syscalls/symlinkat/symlinkat01.c  |  2 +-
 testcases/kernel/syscalls/sync/sync01.c            |  2 +-
 testcases/kernel/syscalls/sync/sync02.c            |  4 +-
 testcases/kernel/syscalls/sysctl/sysctl01.c        |  4 +-
 testcases/kernel/syscalls/sysctl/sysctl03.c        |  4 +-
 testcases/kernel/syscalls/sysctl/sysctl04.c        |  4 +-
 testcases/kernel/syscalls/sysctl/sysctl05.c        |  4 +-
 testcases/kernel/syscalls/sysfs/sysfs01.c          |  2 +-
 testcases/kernel/syscalls/sysfs/sysfs02.c          |  2 +-
 testcases/kernel/syscalls/sysfs/sysfs03.c          |  2 +-
 testcases/kernel/syscalls/sysfs/sysfs04.c          |  2 +-
 testcases/kernel/syscalls/sysfs/sysfs05.c          |  2 +-
 testcases/kernel/syscalls/sysfs/sysfs06.c          |  2 +-
 testcases/kernel/syscalls/sysinfo/sysinfo01.c      |  4 +-
 testcases/kernel/syscalls/sysinfo/sysinfo02.c      |  4 +-
 testcases/kernel/syscalls/syslog/syslog11.c        |  4 +-
 testcases/kernel/syscalls/syslog/syslog12.c        |  4 +-
 testcases/kernel/syscalls/tee/tee01.c              |  2 +-
 testcases/kernel/syscalls/time/time01.c            |  2 +-
 testcases/kernel/syscalls/time/time02.c            |  4 +-
 .../syscalls/timer_getoverrun/timer_getoverrun01.c | 12 ++--
 .../syscalls/timer_gettime/timer_gettime01.c       | 16 ++---
 testcases/kernel/syscalls/timerfd/timerfd02.c      |  2 +-
 testcases/kernel/syscalls/timerfd/timerfd03.c      |  2 +-
 testcases/kernel/syscalls/times/times01.c          |  2 +-
 testcases/kernel/syscalls/tkill/tkill01.c          |  2 +-
 testcases/kernel/syscalls/truncate/truncate01.c    |  4 +-
 testcases/kernel/syscalls/truncate/truncate02.c    |  4 +-
 testcases/kernel/syscalls/truncate/truncate03.c    |  4 +-
 testcases/kernel/syscalls/truncate/truncate04.c    |  2 +-
 testcases/kernel/syscalls/ulimit/ulimit01.c        |  2 +-
 testcases/kernel/syscalls/umask/umask01.c          |  2 +-
 testcases/kernel/syscalls/umask/umask02.c          |  4 +-
 testcases/kernel/syscalls/umask/umask03.c          |  4 +-
 testcases/kernel/syscalls/umount/umount01.c        |  2 +-
 testcases/kernel/syscalls/umount/umount02.c        |  2 +-
 testcases/kernel/syscalls/umount/umount03.c        |  2 +-
 testcases/kernel/syscalls/uname/uname01.c          |  2 +-
 testcases/kernel/syscalls/uname/uname02.c          |  2 +-
 testcases/kernel/syscalls/uname/uname03.c          |  4 +-
 testcases/kernel/syscalls/unlink/unlink05.c        |  2 +-
 testcases/kernel/syscalls/unlink/unlink06.c        |  4 +-
 testcases/kernel/syscalls/unlink/unlink07.c        |  4 +-
 testcases/kernel/syscalls/unlink/unlink08.c        |  6 +-
 testcases/kernel/syscalls/unlinkat/unlinkat01.c    |  2 +-
 testcases/kernel/syscalls/unshare/unshare01.c      |  2 +-
 testcases/kernel/syscalls/unshare/unshare02.c      |  2 +-
 testcases/kernel/syscalls/ustat/ustat01.c          |  2 +-
 testcases/kernel/syscalls/ustat/ustat02.c          |  2 +-
 testcases/kernel/syscalls/utime/utime01.c          |  4 +-
 testcases/kernel/syscalls/utime/utime02.c          |  4 +-
 testcases/kernel/syscalls/utime/utime03.c          |  4 +-
 testcases/kernel/syscalls/utime/utime04.c          |  4 +-
 testcases/kernel/syscalls/utime/utime05.c          |  4 +-
 testcases/kernel/syscalls/utime/utime06.c          |  4 +-
 testcases/kernel/syscalls/utimes/utimes01.c        |  2 +-
 testcases/kernel/syscalls/vfork/vfork01.c          |  4 +-
 testcases/kernel/syscalls/vfork/vfork02.c          |  4 +-
 testcases/kernel/syscalls/vhangup/vhangup01.c      |  4 +-
 testcases/kernel/syscalls/vhangup/vhangup02.c      |  4 +-
 testcases/kernel/syscalls/vmsplice/vmsplice01.c    |  2 +-
 testcases/kernel/syscalls/wait/wait02.c            |  2 +-
 testcases/kernel/syscalls/wait4/wait401.c          |  2 +-
 testcases/kernel/syscalls/wait4/wait402.c          |  2 +-
 testcases/kernel/syscalls/waitid/waitid01.c        |  2 +-
 testcases/kernel/syscalls/waitid/waitid02.c        |  2 +-
 testcases/kernel/syscalls/waitpid/waitpid01.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid02.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid03.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid04.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid05.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid06.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid07.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid08.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid09.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid10.c      |  4 +-
 testcases/kernel/syscalls/waitpid/waitpid11.c      |  2 +-
 testcases/kernel/syscalls/waitpid/waitpid12.c      |  2 +-
 testcases/kernel/syscalls/waitpid/waitpid13.c      |  2 +-
 testcases/kernel/syscalls/write/write01.c          |  2 +-
 testcases/kernel/syscalls/write/write02.c          |  4 +-
 testcases/kernel/syscalls/write/write03.c          |  4 +-
 testcases/kernel/syscalls/write/write04.c          |  4 +-
 testcases/kernel/syscalls/write/write05.c          |  4 +-
 testcases/kernel/syscalls/writev/writev01.c        |  2 +-
 testcases/kernel/syscalls/writev/writev02.c        |  2 +-
 testcases/kernel/syscalls/writev/writev03.c        |  2 +-
 testcases/kernel/syscalls/writev/writev04.c        |  4 +-
 testcases/kernel/syscalls/writev/writev05.c        |  4 +-
 testcases/kernel/syscalls/writev/writev06.c        |  4 +-
 .../kernel/timers/clock_gettime/clock_gettime02.c  |  2 +-
 .../kernel/timers/clock_gettime/clock_gettime03.c  |  2 +-
 .../kernel/timers/clock_settime/clock_settime02.c  |  2 +-
 .../kernel/timers/clock_settime/clock_settime03.c  |  2 +-
 testcases/kernel/timers/leapsec/leapsec_timer.c    |  2 +-
 .../kernel/timers/timer_create/timer_create02.c    |  2 +-
 .../kernel/timers/timer_create/timer_create03.c    |  2 +-
 .../kernel/timers/timer_create/timer_create04.c    |  2 +-
 .../kernel/timers/timer_delete/timer_delete02.c    |  4 +-
 .../kernel/timers/timer_delete/timer_delete03.c    |  2 +-
 .../kernel/timers/timer_settime/timer_settime02.c  |  2 +-
 .../kernel/timers/timer_settime/timer_settime03.c  |  2 +-
 testcases/misc/crash/crash01.c                     |  2 +-
 testcases/misc/crash/crash02.c                     |  2 +-
 testcases/misc/tcore_patch_test_suites/tcore.c     |  2 +-
 tools/apicmds/ltpapicmd.c                          | 18 +++---
 840 files changed, 1275 insertions(+), 1275 deletions(-)


--------------1.8.1.4
Content-Type: text/x-patch;
	name="0001-s-Tst_count-tst_count-to-avoid-CamelCase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-s-Tst_count-tst_count-to-avoid-CamelCase.patch"

diff --git a/doc/examples/quickhit.c b/doc/examples/quickhit.c
index 3eabcdb..d662b03 100644
--- a/doc/examples/quickhit.c
+++ b/doc/examples/quickhit.c
@@ -216,8 +216,8 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping. */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping. */
+		tst_count = 0;
 
 		if (Nlinks)
 			nlinks = Nlinks;
@@ -292,7 +292,7 @@ int main(int ac, char **av)
 					 nlinks, fbuf.st_nlink);
 			}
 		} else
-			Tst_count++;
+			tst_count++;
 
 		/* Here we clean up after the test case so we can do another
 		 * iteration.
diff --git a/doc/man3/tst_res.3 b/doc/man3/tst_res.3
index 90159aa..0c1fe6c 100644
--- a/doc/man3/tst_res.3
+++ b/doc/man3/tst_res.3
@@ -66,9 +66,9 @@ char *\fItmesg, [arg ...]\fR)
 .P
 \fBint  tst_environ()
 .P
-\fBextern int Tst_count;
+\fBextern int tst_count;
 .br
-extern int Tst_range;
+extern int tst_range;
 .br
 \fR
 .SH DESCRIPTION
@@ -79,7 +79,7 @@ library have a distinct number of test cases, and that each test case is
 distinct and uniquely identified by the test case number.  It is also assumed
 that test case results are printed in consecutive order, starting with 1.
 The library maintains a set of global variables (\fBTCID\fR, \fBTST_TOTAL\fR,
-\fBTst_count\fR), which are used by the various functions to format the
+\fBtst_count\fR), which are used by the various functions to format the
 results and to keep track of the current result reporting state (i.e. how many
 total test cases there are, and how many have been reported so far) for the
 calling test.
@@ -91,7 +91,7 @@ library, and MUST be defined/initialized by tests using the library.
 reported.
 .P
 The other global variables are available as externs to tests linked with
-tst_res.o.  \fBTst_count\fR is the running count of the number of test
+tst_res.o.  \fBtst_count\fR is the running count of the number of test
 results that have been reported so far.  The library initializes it to 0, and
 it should not be modified by the test.
 The details are described below under the appropriate functions.
@@ -156,11 +156,11 @@ correspond to a test case result and does not indicate a problem.
 \fBtst_res()\fR and \fBtst_resm()\fR are the basic result reporting
 functions.  They report 1 or more test case results of the specified
 \fIttype\fR.  All result types are valid for these functions.  The
-\fBTst_range\fR global variable indicates the number of results that will be
+\fBtst_range\fR global variable indicates the number of results that will be
 reported for each call to one of these functions.  It is initialized by the
 library to 1, but may be set to a value > 1 by the test.  Each call to one of
-these functions will result in \fBTst_range\fR test case results being
-reported, each with an identical message (\fItmesg\fR).  \fBTst_range\fR is
+these functions will result in \fBtst_range\fR test case results being
+reported, each with an identical message (\fItmesg\fR).  \fBtst_range\fR is
 always reset to 1 by the library before returning to the caller.  If
 \fBtst_res()\fR is called with a \fIfname\fR argument, the contents of the
 file will only be printed for the first reported result.  \fBtst_res()\fR
@@ -168,7 +168,7 @@ takes the \fIfname\fR argument whereas \fBtst_resm()\fR does not.
 .P
 NOTE: All calls to \fBtst_res()\fR specifying a \fIttype\fR of \fBTWARN\fR or
 \fBTINFO\fR will be printed with a test case number of zero.  Because of
-this, a \fBTst_range\fR value > 1 is not valid for these types.
+this, a \fBtst_range\fR value > 1 is not valid for these types.
 .P
 \fBtst_brk()\fR and \fBtst_brkm()\fR are used to report results for all test
 cases remaining in the test, and then call a cleanup function.  The only
@@ -306,7 +306,7 @@ A WARN result message will be printed if any of the following occur:
 .P
 If an invalid test type is specified.
 .P
-If \fBTst_count\fR is negative.
+If \fBtst_count\fR is negative.
 .P
 If one of the \fBtst_brk[m]()\fR routines is called with a test type
 other than \fBTFAIL, TBROK, TCONF\fR, or \fBTRETR\fR.
@@ -319,5 +319,5 @@ will be empty.  This allows a test to not print a message for a result, but
 it is not advised.
 .SH BUGS
 .P
-The programmer is free to alter the value of \fBTst_count\fR causing possible
+The programmer is free to alter the value of \fBtst_count\fR causing possible
 test result order problems.
diff --git a/doc/man3/tst_set_error.3 b/doc/man3/tst_set_error.3
index 29becd3..44f6f26 100644
--- a/doc/man3/tst_set_error.3
+++ b/doc/man3/tst_set_error.3
@@ -33,9 +33,9 @@
 .\"
 .TH TST_SET_ERROR 3 07/25/2000 "Linux Test Project"
 .SH NAME
-tst_set_error \- Sets global Tst_error values
+tst_set_error \- Sets global tst_error values
 .br
-tst_clear_error \- clears global Tst_error values
+tst_clear_error \- clears global tst_error values
 .SH SYNOPSIS
 .nf
 \fB
@@ -56,14 +56,14 @@ tst_clear_error()
 .SH DESCRIPTION
 These two functions provide a simple interface to allow
 a programmer set and clear the global variables in
-\fBTst_error\fR defined in \fItest_error.c\fR.
+\fBtst_error\fR defined in \fItest_error.c\fR.
 
 The purpose of these global variables to provide space
 for error messages passing.  Functions within our library
 can use this space and these routines to a pass error messages and
 some debug data to the caller.
 
-\fBTst_error\fR is a global variable, which is really a structure
+\fBtst_error\fR is a global variable, which is really a structure
 of five elements.   The structure is defined \fItest.h\fR and looks
 like:
 
@@ -97,7 +97,7 @@ This does not say that for long error messages, that there can not be
 newlines in the message.
 
 \fBtst_set_error()\fR will not overwrite these global variables if
-\fBTst_error.te_level\fR is not zero.
+\fBtst_error.te_level\fR is not zero.
 
 \fBtst_clear_error()\fR will make all strings zero length and set all integers to zero.
 
@@ -106,7 +106,7 @@ method for determining if there is an error.  The functions that use
 \fBtst_set_error\fR, should provide another way to indicating that an error
 has occurred.  These variables should be used reporting the error message.
 Although, if you use \fBtst_clear_error()\fR prior to calling any functions
-and \fBTst_error.te_mesg\fR[0] != '\0', you know someone reported an error or
+and \fBtst_error.te_mesg\fR[0] != '\0', you know someone reported an error or
 at least used the space.
 
 .RE
@@ -136,7 +136,7 @@ To access the error information an issue an error message:
 .nf
 #include "test.h"
  	....
-	fprintf(stderr, "%s: funcname failed: %s\n", Prog, Tst_error.te_mesg);
+	fprintf(stderr, "%s: funcname failed: %s\n", Prog, tst_error.te_mesg);
 
 .fi
 
@@ -144,7 +144,7 @@ To access the error information an issue an error message:
 Both functions are void, thus not return value.
 
 .SH BUGS
-There is no space overwrite preventions on the \fBTst_error.te_mesg\fR field.
+There is no space overwrite preventions on the \fBtst_error.te_mesg\fR field.
 If \fIfmt\fR parameter of \fBtst_set_error\fR expands to a string
-larger than the space in \fBTst_error.te_mesg\fR, you will start overwriting
+larger than the space in \fBtst_error.te_mesg\fR, you will start overwriting
 memory.  This field contains 1024 bytes, which is fairly big error message.
diff --git a/doc/man3/tst_sig.3 b/doc/man3/tst_sig.3
index 81e8944..4fdf151 100644
--- a/doc/man3/tst_sig.3
+++ b/doc/man3/tst_sig.3
@@ -47,11 +47,11 @@ void (*cleanup)();
 .fi
 .SH DESCRIPTION
 .P
-\fITst_sig\fR is used by UNICOS test case programs
+\fItst_sig\fR is used by UNICOS test case programs
 to set up signal handling functions for unexpected
 signals.  This provides test cases with a graceful means
 of exiting following an unexpected interruption by a signal.
-\fITst_sig\fR should be called only once by a test
+\fItst_sig\fR should be called only once by a test
 program.
 .P
 The \fIfork_flag\fR parameter is used to tell \fItst_sig\fR
@@ -85,7 +85,7 @@ signal, the \fIdefault handler\fR will generate
 not been completed at the time of the signal, execute the
 \fIcleanup\fR routine, if provided, and call \fItst_exit\fR.
 Note: if the \fIdefault handler\fR is used, the variables
-\fBTCID\fR and \fBTst_count\fR must be defined and available to
+\fBTCID\fR and \fBtst_count\fR must be defined and available to
 \fItst_sig\fR (see \fItst_res\fR(3)).
 .P
 The \fIcleanup\fR parameter is a pointer to a user-defined
@@ -138,5 +138,5 @@ tst_res(3),
 tst_setup(1).
 .SH DIAGNOSTICS
 .P
-\fITst_sig\fR will output warnings in standard \fItst_res\fR
+\fItst_sig\fR will output warnings in standard \fItst_res\fR
 format if it cannot set up the signal handlers.
diff --git a/include/test.h b/include/test.h
index dfb731c..e36ca38 100644
--- a/include/test.h
+++ b/include/test.h
@@ -200,7 +200,7 @@ int  tst_environ(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
 void tst_flush(void);
 
-extern int Tst_count;
+extern int tst_count;
 
 /* lib/tst_sig.c */
 void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
diff --git a/lib/tst_res.c b/lib/tst_res.c
index bbed538..ffac6d7 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -164,8 +164,8 @@ static char *Last_mesg;		/* previous test result message */
 /*
  * These globals may be externed by the test.
  */
-int Tst_count = 0;		/* current count of test cases executed; NOTE: */
-			/* Tst_count may be externed by other programs */
+int tst_count = 0;		/* current count of test cases executed; NOTE: */
+			/* tst_count may be externed by other programs */
 
 /*
  * These globals must be defined in the test.
@@ -263,7 +263,7 @@ void tst_res(int ttype, char *fname, char *arg_fmt, ...)
 	int ttype_result = TTYPE_RESULT(ttype);
 
 #if DEBUG
-	printf("IN tst_res; Tst_count = %d\n", Tst_count);
+	printf("IN tst_res; tst_count = %d\n", tst_count);
 	fflush(stdout);
 #endif
 
@@ -298,9 +298,9 @@ void tst_res(int ttype, char *fname, char *arg_fmt, ...)
 	if (ttype_result == TWARN || ttype_result == TINFO) {
 		tst_print(TCID, 0, ttype, tmesg);
 	} else {
-		if (Tst_count < 0)
+		if (tst_count < 0)
 			tst_print(TCID, 0, TWARN,
-				  "tst_res(): Tst_count < 0 is not valid");
+				  "tst_res(): tst_count < 0 is not valid");
 
 		/*
 		 * Process each display type.
@@ -309,14 +309,14 @@ void tst_res(int ttype, char *fname, char *arg_fmt, ...)
 		case DISCARD:
 			break;
 		case NOPASS:	/* filtered by tst_print() */
-			tst_condense(Tst_count + 1, ttype, tmesg);
+			tst_condense(tst_count + 1, ttype, tmesg);
 			break;
 		default:	/* VERBOSE */
-			tst_print(TCID, Tst_count + 1, ttype, tmesg);
+			tst_print(TCID, tst_count + 1, ttype, tmesg);
 			break;
 		}
 
-		Tst_count++;
+		tst_count++;
 	}
 
 }
diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index 3e54b8d..bfeb216 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -454,7 +454,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(readproc(procpath));
 
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index b473e45..1069335 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -114,7 +114,7 @@ static void testcpuset(void)
 		exit(mem_hog_cpuset(ncpus > 1 ? ncpus : 1));
 	}
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		snprintf(buf, BUFSIZ, "%d", nodes[0]);
 		write_cpuset_files(CPATH_NEW, "mems", buf);
 		snprintf(buf, BUFSIZ, "%d", nodes[1]);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index d7db0ec..f0125dd 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 			tst_brkm(TFAIL | TERRNO, cleanup, "open %s failed",
 				 TEMPFILE);
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Note the number of free huge pages BEFORE testing */
 		beforetest = read_meminfo("HugePages_Free:");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 209c63d..e6ea7bf 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -121,7 +121,7 @@ int main(int ac, char **av)
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "opening /dev/zero failed");
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap on /dev/zero 5 times
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index 0168f96..c0338ff 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 		if (fildes < 0)
 			tst_brkm(TBROK | TERRNO, cleanup, "open %s", TEMPFILE);
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Attempt to mmap into highmem addr, should get ENOMEM */
 		addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 4727c6f..8ed6821 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 			tst_brkm(TFAIL | TERRNO, cleanup, "open %s failed",
 				 TEMPFILE);
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Note the number of free huge pages BEFORE testing */
 		freepages = read_meminfo("HugePages_Free:");
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 743801e..ef7aa78 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -81,7 +81,7 @@ char path_sys_sz_huge[BUFSIZ];
 #endif
 
 char *TCID = "hugemmap05";
-int TST_TOTAL = 1, Tst_count;
+int TST_TOTAL = 1, tst_count;
 static char nr_hugepages[BUFSIZ], nr_overcommit_hugepages[BUFSIZ];
 static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
 static char shmmax[BUFSIZ];
@@ -135,7 +135,7 @@ int main(int argc, char *argv[])
 	}
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		overcommit();
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 3d8eee0..fb05c91 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			addr = shmat(*(TC[i].shmid), TC[i].addr, TC[i].flags);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index f5a41b9..50eec00 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			addr = shmat(*(TC[i].shmid), TC[i].addr, 0);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 2477ebf..40a733e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -114,7 +114,7 @@ static void do_child(void)
 	int lc;
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		addr = shmat(shm_id_1, NULL, 0);
 		if (addr != (void *)-1) {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index a4cf337..865c414 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* initialize stat_time */
 		stat_time = FIRST;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 1fd3f15..d89b815 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].sbuf));
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 3cd6308..5eb8fda 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -133,7 +133,7 @@ static void do_child(void)
 	int i, lc;
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].sbuf));
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index cba8fbf..018b690 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (shmdt(shared) == -1) {
 			tst_resm(TFAIL | TERRNO, "shmdt");
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 6f6f53e..2334bbd 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -89,7 +89,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		shm_id_1 = shmget(shmkey, shm_size,
 				  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 1193e80..5924cb2 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* If this key is existent, just remove it */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 62adc26..3898618 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -92,7 +92,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(shmget(IPC_PRIVATE, shm_size,
 			    SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW));
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 2f8d859..110641b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -117,7 +117,7 @@ static void do_child(void)
 	int lc;
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(shmget(shmkey, shm_size, SHM_HUGETLB | SHM_RW));
 		if (TEST_RETURN != -1) {
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index bbb9747..514d702 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -91,7 +91,7 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 		create_same_memory(size, num, unit);
 	}
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index be9ff96..412b52e 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -100,7 +100,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 
 		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 07b7c4b..4480399 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -91,7 +91,7 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 		write_memcg();
 		create_same_memory(size, num, unit);
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index e4aa417..e164b29 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -100,7 +100,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 
 		write_memcg();
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index ccb0621..089a9ff 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -94,7 +94,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (pid = fork()) {
 		case -1:
diff --git a/testcases/kernel/mem/mem/mem01.c b/testcases/kernel/mem/mem/mem01.c
index 2c06f9d..7e7b247 100644
--- a/testcases/kernel/mem/mem/mem01.c
+++ b/testcases/kernel/mem/mem/mem01.c
@@ -180,7 +180,7 @@ int main(int argc, char *argv[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (!m_opt) {
 			/* find out by ourselves! */
diff --git a/testcases/kernel/mem/mmapstress/mmap-corruption01.c b/testcases/kernel/mem/mmapstress/mmap-corruption01.c
index 7628eae..0539cd4 100644
--- a/testcases/kernel/mem/mmapstress/mmap-corruption01.c
+++ b/testcases/kernel/mem/mmapstress/mmap-corruption01.c
@@ -56,7 +56,7 @@
 #include "usctest.h"
 
 /* Extern Global Variables */
-extern int Tst_count;
+extern int tst_count;
 
 /* Global Variables */
 char *TCID = "mmap-corruption01";	/* test program identifier.          */
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 25ab805..0401e31 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -58,7 +58,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		set_sys_tune("overcommit_memory", 2, 1);
 		oom(OVERCOMMIT, 0, 0);
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index f0e784f..abd8aa2 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -60,7 +60,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		tst_resm(TINFO, "process mempolicy.");
 		testoom(1, 0, 1);
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 54d66b7..95e34d5 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -57,7 +57,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		snprintf(buf, BUFSIZ, "%d", getpid());
 		write_file(MEMCG_PATH_NEW "/tasks", buf);
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index e182f04..bc51046 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -62,7 +62,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		snprintf(buf, BUFSIZ, "%d", getpid());
 		write_file(MEMCG_PATH_NEW "/tasks", buf);
diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 92fb32b..84e205b 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -91,7 +91,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		init_meminfo();
 
diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
index c15add5..1f2aa41 100644
--- a/testcases/kernel/mem/thp/thp02.c
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		do_mremap();
 	}
diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
index 80356f4..8b54243 100644
--- a/testcases/kernel/mem/thp/thp03.c
+++ b/testcases/kernel/mem/thp/thp03.c
@@ -72,7 +72,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		thp_test();
 	}
diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index fc26e34..e948868 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -89,7 +89,7 @@ int main(int argc, char *argv[])
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		max_map_count_test();
 	}
 
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index b4d0f75..5c49d6b 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -94,7 +94,7 @@ int main(int argc, char *argv[])
 	}
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		test_tune(2);
 		test_tune(0);
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 962d40e..0c7ba33 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -130,7 +130,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		overcommit_memory_test();
 	}
diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index fc6e692..7cd22c0 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -81,7 +81,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		check_vma();
 	}
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index 19a1d4c..a9a85e0 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -88,7 +88,7 @@ int main(int argc, char **argv)
 	numa_bitmask_setbit(nmask, node);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		addr = mmap(NULL, pagesize * 3, PROT_WRITE,
 			    MAP_ANON | MAP_PRIVATE, 0, 0);
 		if (addr == MAP_FAILED)
diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 3032ee2..54f605a 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -83,7 +83,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = open(TESTFILE, O_RDWR);
 		if (fd == -1)
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index 2ee7d6b..381a1eb 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -108,7 +108,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		case4();
 		case5();
diff --git a/testcases/kernel/mem/zram/zram01.c b/testcases/kernel/mem/zram/zram01.c
index 633ea99..d439172 100644
--- a/testcases/kernel/mem/zram/zram01.c
+++ b/testcases/kernel/mem/zram/zram01.c
@@ -64,7 +64,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		set_disksize();
 
diff --git a/testcases/kernel/module/create_module/create_module01.c b/testcases/kernel/module/create_module/create_module01.c
index 132a131..1a683f5 100644
--- a/testcases/kernel/module/create_module/create_module01.c
+++ b/testcases/kernel/module/create_module/create_module01.c
@@ -93,8 +93,8 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* Test the system call */
 		TEST(create_module(modname, MODSIZE));
diff --git a/testcases/kernel/module/create_module/create_module02.c b/testcases/kernel/module/create_module/create_module02.c
index b97e18d..d1e7b1c 100644
--- a/testcases/kernel/module/create_module/create_module02.c
+++ b/testcases/kernel/module/create_module/create_module02.c
@@ -170,8 +170,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			if ((tdat[testno].setup) && (tdat[testno].setup())) {
diff --git a/testcases/kernel/module/delete_module/delete_module01.c b/testcases/kernel/module/delete_module/delete_module01.c
index b09a028..b96564d 100644
--- a/testcases/kernel/module/delete_module/delete_module01.c
+++ b/testcases/kernel/module/delete_module/delete_module01.c
@@ -93,8 +93,8 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* Execute system call */
 		sprintf(cmd, "/sbin/insmod %s/%s.ko", dirname(argv[0]),
diff --git a/testcases/kernel/module/delete_module/delete_module02.c b/testcases/kernel/module/delete_module/delete_module02.c
index 6d61121..23b0b0a 100644
--- a/testcases/kernel/module/delete_module/delete_module02.c
+++ b/testcases/kernel/module/delete_module/delete_module02.c
@@ -159,8 +159,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			if ((tdat[testno].setup) && (tdat[testno].setup())) {
diff --git a/testcases/kernel/module/delete_module/delete_module03.c b/testcases/kernel/module/delete_module/delete_module03.c
index 71f3ecd..f38c03a 100644
--- a/testcases/kernel/module/delete_module/delete_module03.c
+++ b/testcases/kernel/module/delete_module/delete_module03.c
@@ -142,8 +142,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* Test the system call */
 		TEST(delete_module(DUMMY_MOD));
diff --git a/testcases/kernel/module/query_module/query_module01.c b/testcases/kernel/module/query_module/query_module01.c
index 48b2192..2f2973d 100644
--- a/testcases/kernel/module/query_module/query_module01.c
+++ b/testcases/kernel/module/query_module/query_module01.c
@@ -173,8 +173,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			if ((tdat[testno].setup) && (tdat[testno].setup())) {
diff --git a/testcases/kernel/module/query_module/query_module02.c b/testcases/kernel/module/query_module/query_module02.c
index ed131f9..22482e4 100644
--- a/testcases/kernel/module/query_module/query_module02.c
+++ b/testcases/kernel/module/query_module/query_module02.c
@@ -151,8 +151,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/module/query_module/query_module03.c b/testcases/kernel/module/query_module/query_module03.c
index eee1629..235590d 100644
--- a/testcases/kernel/module/query_module/query_module03.c
+++ b/testcases/kernel/module/query_module/query_module03.c
@@ -170,8 +170,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index 2975a95..06fcbeb 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -47,7 +47,7 @@
 #define barrier() __asm__ __volatile__("": : :"memory")
 
 /* Extern Global Variables */
-extern int Tst_count;		/* to avoid compilation errors. */
+extern int tst_count;		/* to avoid compilation errors. */
 extern char *TESTDIR;		/* to avoid compilation errors. */
 
 /* Global Variables */
diff --git a/testcases/kernel/performance_counters/performance_counter01.c b/testcases/kernel/performance_counters/performance_counter01.c
index 4f56060..6d7cbc9 100644
--- a/testcases/kernel/performance_counters/performance_counter01.c
+++ b/testcases/kernel/performance_counters/performance_counter01.c
@@ -43,7 +43,7 @@
 #include "linux_syscall_numbers.h"
 
 /* Extern Global Variables */
-extern int Tst_count;
+extern int tst_count;
 extern char *TESTDIR;		/* temporary dir created by tst_tmpdir() */
 /* Global Variables */
 char *TCID = "performance_counter01";	/* test program identifier.          */
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index a466711..30bc166 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -115,7 +115,7 @@ int main(int ac, char *av[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index a6fa743..648f45b 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -167,7 +167,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (tc = 0; tc < Ntc; tc++) {
 			/*
diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index a324544..61cdc43 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -138,7 +138,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			file_name = test_cases[i].pathname;
diff --git a/testcases/kernel/syscalls/access/access03.c b/testcases/kernel/syscalls/access/access03.c
index b1b4d29..540f7bf 100644
--- a/testcases/kernel/syscalls/access/access03.c
+++ b/testcases/kernel/syscalls/access/access03.c
@@ -151,7 +151,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST_ACCESS(low_addr, R_OK);
 		TEST_ACCESS(low_addr, W_OK);
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index b4c7cd9..5cfae45 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(access(TESTFILE, F_OK));
 
diff --git a/testcases/kernel/syscalls/access/access05.c b/testcases/kernel/syscalls/access/access05.c
index 02262f5..f47d7fc 100644
--- a/testcases/kernel/syscalls/access/access05.c
+++ b/testcases/kernel/syscalls/access/access05.c
@@ -159,7 +159,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			file_name = test_cases[i].pathname;
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index 591fa0c..c394722 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (i = 0; i < test_count; i++) {
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex01.c b/testcases/kernel/syscalls/adjtimex/adjtimex01.c
index c8a4592..51d5d2a 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex01.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex01.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Call adjtimex(2) */
 		tim_save.modes = SET_MODE;
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index 9501191..aac1e18 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -150,7 +150,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			/*
diff --git a/testcases/kernel/syscalls/alarm/alarm01.c b/testcases/kernel/syscalls/alarm/alarm01.c
index 0ee4c95..085c025 100644
--- a/testcases/kernel/syscalls/alarm/alarm01.c
+++ b/testcases/kernel/syscalls/alarm/alarm01.c
@@ -133,7 +133,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call alarm(2)
diff --git a/testcases/kernel/syscalls/alarm/alarm02.c b/testcases/kernel/syscalls/alarm/alarm02.c
index a4f9a23..28971a6 100644
--- a/testcases/kernel/syscalls/alarm/alarm02.c
+++ b/testcases/kernel/syscalls/alarm/alarm02.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/alarm/alarm03.c b/testcases/kernel/syscalls/alarm/alarm03.c
index e4e8f63..552a020 100644
--- a/testcases/kernel/syscalls/alarm/alarm03.c
+++ b/testcases/kernel/syscalls/alarm/alarm03.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call alarm(2)
@@ -150,7 +150,7 @@ int main(int ac, char **av)
 			break;
 
 		default:
-			Tst_count++;
+			tst_count++;
 			TEST(alarm(0));
 /* The timer may be rounded up to the next nearest second, this is OK */
 			if (TEST_RETURN <= 0 || TEST_RETURN > 101) {
diff --git a/testcases/kernel/syscalls/alarm/alarm05.c b/testcases/kernel/syscalls/alarm/alarm05.c
index 6f4daf8..9df1458 100644
--- a/testcases/kernel/syscalls/alarm/alarm05.c
+++ b/testcases/kernel/syscalls/alarm/alarm05.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Reset alarms_received for every iteration, since it has
diff --git a/testcases/kernel/syscalls/alarm/alarm06.c b/testcases/kernel/syscalls/alarm/alarm06.c
index 5f05e4f..8e5ff11 100644
--- a/testcases/kernel/syscalls/alarm/alarm06.c
+++ b/testcases/kernel/syscalls/alarm/alarm06.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call First alarm() with non-zero time parameter
diff --git a/testcases/kernel/syscalls/alarm/alarm07.c b/testcases/kernel/syscalls/alarm/alarm07.c
index d2ced82..12f6f25 100644
--- a/testcases/kernel/syscalls/alarm/alarm07.c
+++ b/testcases/kernel/syscalls/alarm/alarm07.c
@@ -97,7 +97,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call First alarm() with non-zero time parameter
diff --git a/testcases/kernel/syscalls/asyncio/asyncio02.c b/testcases/kernel/syscalls/asyncio/asyncio02.c
index feca8b4..cbdffa8 100644
--- a/testcases/kernel/syscalls/asyncio/asyncio02.c
+++ b/testcases/kernel/syscalls/asyncio/asyncio02.c
@@ -159,7 +159,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (flag_cnt = 0; flag_cnt < Num_flags; flag_cnt++) {
 
diff --git a/testcases/kernel/syscalls/bdflush/bdflush01.c b/testcases/kernel/syscalls/bdflush/bdflush01.c
index a0441a3..e3a48b6 100644
--- a/testcases/kernel/syscalls/bdflush/bdflush01.c
+++ b/testcases/kernel/syscalls/bdflush/bdflush01.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 	 * missing.
 	 */
 	data = 0;
-	Tst_count = 1;
+	tst_count = 1;
 	for (testno = 0; testno < TST_TOTAL; ++testno) {
 		TEST(ltp_syscall(__NR_bdflush, 3, data));
 		if (TEST_RETURN == -1)
diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 29ef046..05240f7 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -121,7 +121,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index 44c3ce6..229de0a 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -149,7 +149,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Determine new value to give brk
diff --git a/testcases/kernel/syscalls/cacheflush/cacheflush01.c b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
index c197b74..cb3fb5a 100644
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
@@ -135,7 +135,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 	/* Create some user address range */
 	addr = malloc(getpagesize());
 	if (addr == NULL) {
diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
index 0b66c1c..0de68c0 100644
--- a/testcases/kernel/syscalls/capget/capget01.c
+++ b/testcases/kernel/syscalls/capget/capget01.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(ltp_syscall(__NR_capget, &header, &data));
 
diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
index 6fc955e..d63f66c 100644
--- a/testcases/kernel/syscalls/capget/capget02.c
+++ b/testcases/kernel/syscalls/capget/capget02.c
@@ -133,7 +133,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			test_setup(i);
diff --git a/testcases/kernel/syscalls/capset/capset01.c b/testcases/kernel/syscalls/capset/capset01.c
index 09b37d2..c367865 100644
--- a/testcases/kernel/syscalls/capset/capset01.c
+++ b/testcases/kernel/syscalls/capset/capset01.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(ltp_syscall(__NR_capset, &header, &data));
 
diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index b51594e..0c3f911 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef UCLINUX
 		i = 2;
diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index f678f35..d69f42a 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -88,7 +88,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		SAFE_CHDIR(cleanup, testdir);
 
diff --git a/testcases/kernel/syscalls/chdir/chdir02.c b/testcases/kernel/syscalls/chdir/chdir02.c
index 6cabbde..f119f75 100644
--- a/testcases/kernel/syscalls/chdir/chdir02.c
+++ b/testcases/kernel/syscalls/chdir/chdir02.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(chdir(dirs[lc % 2]));
 
diff --git a/testcases/kernel/syscalls/chdir/chdir03.c b/testcases/kernel/syscalls/chdir/chdir03.c
index f8fb160..a33b4f3 100644
--- a/testcases/kernel/syscalls/chdir/chdir03.c
+++ b/testcases/kernel/syscalls/chdir/chdir03.c
@@ -93,7 +93,7 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) < 0) {
 			tst_brkm(TBROK, cleanup, "first fork failed");
diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
index 774b8ff..518440d 100644
--- a/testcases/kernel/syscalls/chdir/chdir04.c
+++ b/testcases/kernel/syscalls/chdir/chdir04.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/chmod/chmod01.c b/testcases/kernel/syscalls/chmod/chmod01.c
index 90d6036..51974bf 100644
--- a/testcases/kernel/syscalls/chmod/chmod01.c
+++ b/testcases/kernel/syscalls/chmod/chmod01.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			mode = modes[i];
diff --git a/testcases/kernel/syscalls/chmod/chmod02.c b/testcases/kernel/syscalls/chmod/chmod02.c
index 9462fc6..4a80db1 100644
--- a/testcases/kernel/syscalls/chmod/chmod02.c
+++ b/testcases/kernel/syscalls/chmod/chmod02.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			mode = Modes[ind];
@@ -162,7 +162,7 @@ int main(int ac, char **av)
 						 "chmod(%s, %#o) returned %ld",
 						 fname, mode, TEST_RETURN);
 				} else
-					Tst_count++;
+					tst_count++;
 			}
 		}
 
diff --git a/testcases/kernel/syscalls/chmod/chmod03.c b/testcases/kernel/syscalls/chmod/chmod03.c
index f81a626..4275e9b 100644
--- a/testcases/kernel/syscalls/chmod/chmod03.c
+++ b/testcases/kernel/syscalls/chmod/chmod03.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(chmod(TESTFILE, PERMS));
 
diff --git a/testcases/kernel/syscalls/chmod/chmod04.c b/testcases/kernel/syscalls/chmod/chmod04.c
index 18b2f24..496c724 100644
--- a/testcases/kernel/syscalls/chmod/chmod04.c
+++ b/testcases/kernel/syscalls/chmod/chmod04.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call chmod(2) with mode argument to
diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index 6cfced3..6696515 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(chmod(TESTDIR, PERMS));
 
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index 2598c3f..0745f02 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -171,7 +171,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index 754faa2..a898671 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call chmod(2) with specified mode argument
diff --git a/testcases/kernel/syscalls/chown/chown01.c b/testcases/kernel/syscalls/chown/chown01.c
index 1844924..9139ec4 100644
--- a/testcases/kernel/syscalls/chown/chown01.c
+++ b/testcases/kernel/syscalls/chown/chown01.c
@@ -143,7 +143,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(chown(fname, uid, gid));
 
diff --git a/testcases/kernel/syscalls/chown/chown02.c b/testcases/kernel/syscalls/chown/chown02.c
index f6f0e0f..7ca8bf2 100644
--- a/testcases/kernel/syscalls/chown/chown02.c
+++ b/testcases/kernel/syscalls/chown/chown02.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index 112f232..cb8e8e0 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		user_id = geteuid();
 		group_id = getegid();
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 0a8beed..f45afc5 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -153,7 +153,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			file_name = test_cases[i].pathname;
diff --git a/testcases/kernel/syscalls/chown/chown05.c b/testcases/kernel/syscalls/chown/chown05.c
index c2c45b7..ab98c31 100644
--- a/testcases/kernel/syscalls/chown/chown05.c
+++ b/testcases/kernel/syscalls/chown/chown05.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			user_id = test_cases[i].user_id;
diff --git a/testcases/kernel/syscalls/chroot/chroot01.c b/testcases/kernel/syscalls/chroot/chroot01.c
index 9936928..99f26be 100644
--- a/testcases/kernel/syscalls/chroot/chroot01.c
+++ b/testcases/kernel/syscalls/chroot/chroot01.c
@@ -77,7 +77,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(chroot(path));
 
diff --git a/testcases/kernel/syscalls/chroot/chroot02.c b/testcases/kernel/syscalls/chroot/chroot02.c
index 4f787ae..8fc76e1 100644
--- a/testcases/kernel/syscalls/chroot/chroot02.c
+++ b/testcases/kernel/syscalls/chroot/chroot02.c
@@ -77,8 +77,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "Could not fork");
diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index 4079bce..c34d8ea 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -132,8 +132,8 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/chroot/chroot04.c b/testcases/kernel/syscalls/chroot/chroot04.c
index 5c544cf..f263b91 100644
--- a/testcases/kernel/syscalls/chroot/chroot04.c
+++ b/testcases/kernel/syscalls/chroot/chroot04.c
@@ -80,8 +80,8 @@ int main(int ac, char **av)
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(chroot(TEST_TMPDIR));
 
diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 63c25a1..80e7ce5 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -275,7 +275,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST(c = getopt_long(ac, av, "dh", long_options, NULL));
 			while (TEST_RETURN != -1) {
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index a8d6e3e..b78041e 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -377,7 +377,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
index d1c3527..e210a16 100644
--- a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST(clock_gettime(CLOCK_TO_USE, &ts));
 			for (i = 0; i <= 50; i++) {
diff --git a/testcases/kernel/syscalls/clone/clone01.c b/testcases/kernel/syscalls/clone/clone01.c
index 5157b99..561f5ac 100644
--- a/testcases/kernel/syscalls/clone/clone01.c
+++ b/testcases/kernel/syscalls/clone/clone01.c
@@ -56,7 +56,7 @@ int main(int ac, char **av)
 	if (child_stack == NULL)
 		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	TEST(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE, child_stack));
 	if (TEST_RETURN == -1)
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index 4722050..c49a3d7 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			if (test_setup() != 0) {
diff --git a/testcases/kernel/syscalls/clone/clone03.c b/testcases/kernel/syscalls/clone/clone03.c
index c60ac07..0585322 100644
--- a/testcases/kernel/syscalls/clone/clone03.c
+++ b/testcases/kernel/syscalls/clone/clone03.c
@@ -75,7 +75,7 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pipe(pfd)) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "pipe failed");
diff --git a/testcases/kernel/syscalls/clone/clone04.c b/testcases/kernel/syscalls/clone/clone04.c
index 217d538..37afb46 100644
--- a/testcases/kernel/syscalls/clone/clone04.c
+++ b/testcases/kernel/syscalls/clone/clone04.c
@@ -66,7 +66,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			if (test_cases[ind].child_stack == NULL) {
diff --git a/testcases/kernel/syscalls/clone/clone05.c b/testcases/kernel/syscalls/clone/clone05.c
index 06b84ed..3c3e28b 100644
--- a/testcases/kernel/syscalls/clone/clone05.c
+++ b/testcases/kernel/syscalls/clone/clone05.c
@@ -58,7 +58,7 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
 		               CHILD_STACK_SIZE, child_stack));
diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
index 0bafc84..1686cb5 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -64,7 +64,7 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, cleanup, "Cannot allocate stack for child");
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pipe(pfd)) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "pipe() failed");
diff --git a/testcases/kernel/syscalls/clone/clone07.c b/testcases/kernel/syscalls/clone/clone07.c
index 12350ac..29fd069 100644
--- a/testcases/kernel/syscalls/clone/clone07.c
+++ b/testcases/kernel/syscalls/clone/clone07.c
@@ -60,7 +60,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		child_stack = malloc(CHILD_STACK_SIZE);
 		if (child_stack == NULL)
 			tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/close/close01.c b/testcases/kernel/syscalls/close/close01.c
index 6c9efc9..3caa1ad 100644
--- a/testcases/kernel/syscalls/close/close01.c
+++ b/testcases/kernel/syscalls/close/close01.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((fild = creat(fname, 0777)) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "can't open file %s",
diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index 10c9662..2a41056 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -84,8 +84,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(close(-1));
 
diff --git a/testcases/kernel/syscalls/close/close08.c b/testcases/kernel/syscalls/close/close08.c
index eaf3a37..931fc5c 100644
--- a/testcases/kernel/syscalls/close/close08.c
+++ b/testcases/kernel/syscalls/close/close08.c
@@ -142,7 +142,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
 			tst_brkm(TBROK | TTERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 6ae8fb8..1a91570 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -91,7 +91,7 @@ int main(int argc, char *argv[])
 
 	setup(argv);
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		cma_test_errnos();
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index c0e3aff..dea1bbe 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -57,7 +57,7 @@ int main(int argc, char **argv)
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		len = strlen(tst_string);
 
 		if (pipe(pipe_fd) < 0)
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index c0a047a..7475a64 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (pipe(pipe_fd) < 0)
 			tst_brkm(TBROK | TERRNO, cleanup, "pipe");
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 10d1d50..0ea956d 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -67,7 +67,7 @@ int main(int argc, char **argv)
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (pipe(pipe_fd) < 0)
 			tst_brkm(TBROK | TERRNO, cleanup, "pipe");
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 83f11f0..c61ab0a 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -142,7 +142,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/creat/creat01.c b/testcases/kernel/syscalls/creat/creat01.c
index fd90d0c..5cb3823 100644
--- a/testcases/kernel/syscalls/creat/creat01.c
+++ b/testcases/kernel/syscalls/creat/creat01.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(fd = creat(filename, TC[i].mode));
diff --git a/testcases/kernel/syscalls/creat/creat03.c b/testcases/kernel/syscalls/creat/creat03.c
index 040bada..bd7778d 100644
--- a/testcases/kernel/syscalls/creat/creat03.c
+++ b/testcases/kernel/syscalls/creat/creat03.c
@@ -74,7 +74,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(creat(pfilname, FMODE));
 
diff --git a/testcases/kernel/syscalls/creat/creat04.c b/testcases/kernel/syscalls/creat/creat04.c
index 815e4fb..5ab3428 100644
--- a/testcases/kernel/syscalls/creat/creat04.c
+++ b/testcases/kernel/syscalls/creat/creat04.c
@@ -101,8 +101,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() #1 failed");
diff --git a/testcases/kernel/syscalls/creat/creat05.c b/testcases/kernel/syscalls/creat/creat05.c
index 741aad6..7866335 100644
--- a/testcases/kernel/syscalls/creat/creat05.c
+++ b/testcases/kernel/syscalls/creat/creat05.c
@@ -85,8 +85,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(creat(fname, MODE));
 
diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index e6e6fcc..51e46ab 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -142,8 +142,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index a82c036..578f54a 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -61,7 +61,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "fork #1 failed");
diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index bd4e467..0112a04 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -142,7 +142,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(creat(fname, 0700));
 
diff --git a/testcases/kernel/syscalls/dup/dup01.c b/testcases/kernel/syscalls/dup/dup01.c
index 33364f8..0785478 100644
--- a/testcases/kernel/syscalls/dup/dup01.c
+++ b/testcases/kernel/syscalls/dup/dup01.c
@@ -143,7 +143,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call dup(2)
diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index bb86feb..c369c73 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -142,7 +142,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < nfds; ind++) {
 
diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index e7cc18d..214a25a 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(dup(fd[0]));
 
diff --git a/testcases/kernel/syscalls/dup/dup04.c b/testcases/kernel/syscalls/dup/dup04.c
index 88de646..e9270c6 100644
--- a/testcases/kernel/syscalls/dup/dup04.c
+++ b/testcases/kernel/syscalls/dup/dup04.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(dup(fd[0]));
 
@@ -159,7 +159,7 @@ int main(int ac, char **av)
 					 fd[0], TEST_RETURN);
 
 			} else
-				Tst_count++;
+				tst_count++;
 
 			if (close(TEST_RETURN) == -1)
 				tst_brkm(TBROK, cleanup, "close failed");
@@ -178,7 +178,7 @@ int main(int ac, char **av)
 					 fd[1], TEST_RETURN);
 
 			} else
-				Tst_count++;
+				tst_count++;
 
 			if (close(TEST_RETURN) == -1)
 				tst_brkm(TBROK | TTERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/dup/dup05.c b/testcases/kernel/syscalls/dup/dup05.c
index 974742a..27f603b 100644
--- a/testcases/kernel/syscalls/dup/dup05.c
+++ b/testcases/kernel/syscalls/dup/dup05.c
@@ -143,7 +143,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(dup(fd));
 
diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
index 59be0f0..5cebca6 100644
--- a/testcases/kernel/syscalls/dup2/dup201.c
+++ b/testcases/kernel/syscalls/dup2/dup201.c
@@ -117,7 +117,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 
diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index d05290a..0dc0415 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index 878415b..3dae9ee 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -73,7 +73,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 //block1:
 		tst_resm(TINFO, "Enter block 1");
 		tst_resm(TINFO, "Test duping over an open fd");
diff --git a/testcases/kernel/syscalls/dup2/dup204.c b/testcases/kernel/syscalls/dup2/dup204.c
index 9740cdf..ad15590 100644
--- a/testcases/kernel/syscalls/dup2/dup204.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -75,7 +75,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index 31c992d..5521c47 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -669,7 +669,7 @@ int main(int argc, char **argv)
 		int ret;
 		uint64_t einit = 10;
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = myeventfd(einit, 0);
 		if (fd == -1)
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
index eb120a9..fba2e06 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
@@ -135,7 +135,7 @@ int main(int argc, char *argv[])
 	}
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 	fd = ltp_syscall(__NR_eventfd2, 1, 0);
 	if (fd == -1) {
 		tst_brkm(TFAIL, cleanup, "eventfd2(0) failed");
diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
index 8f195e6..94a4a20 100644
--- a/testcases/kernel/syscalls/execl/execl01.c
+++ b/testcases/kernel/syscalls/execl/execl01.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE:
diff --git a/testcases/kernel/syscalls/execle/execle01.c b/testcases/kernel/syscalls/execle/execle01.c
index 1d0cf83..9c36dc5 100644
--- a/testcases/kernel/syscalls/execle/execle01.c
+++ b/testcases/kernel/syscalls/execle/execle01.c
@@ -144,7 +144,7 @@ int main(int ac, char **av, char **environ)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (pid = FORK_OR_VFORK()) {
 		case 0:	/* CHILD - Call execle(2) */
diff --git a/testcases/kernel/syscalls/execlp/execlp01.c b/testcases/kernel/syscalls/execlp/execlp01.c
index be7a362..0924683 100644
--- a/testcases/kernel/syscalls/execlp/execlp01.c
+++ b/testcases/kernel/syscalls/execlp/execlp01.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (pid = FORK_OR_VFORK()) {
 		case 0:
diff --git a/testcases/kernel/syscalls/execv/execv01.c b/testcases/kernel/syscalls/execv/execv01.c
index f77ee21..b655489 100644
--- a/testcases/kernel/syscalls/execv/execv01.c
+++ b/testcases/kernel/syscalls/execv/execv01.c
@@ -146,7 +146,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (pid = FORK_OR_VFORK()) {
 		case 0:
diff --git a/testcases/kernel/syscalls/execve/execve01.c b/testcases/kernel/syscalls/execve/execve01.c
index e142615..31432c9 100644
--- a/testcases/kernel/syscalls/execve/execve01.c
+++ b/testcases/kernel/syscalls/execve/execve01.c
@@ -146,7 +146,7 @@ int main(int ac, char **av, char **environ)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (pid = FORK_OR_VFORK()) {
 		case 0:	/* CHILD - Call execve(2) */
diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
index 94f3100..ce78611 100644
--- a/testcases/kernel/syscalls/execve/execve02.c
+++ b/testcases/kernel/syscalls/execve/execve02.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (chmod(test_app, 0700) != 0)
 			tst_resm(TFAIL | TERRNO, "chmod failed");
diff --git a/testcases/kernel/syscalls/execve/execve03.c b/testcases/kernel/syscalls/execve/execve03.c
index 17fb47b..aa45009 100644
--- a/testcases/kernel/syscalls/execve/execve03.c
+++ b/testcases/kernel/syscalls/execve/execve03.c
@@ -142,7 +142,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
index f7cd7bb..26fbb5f 100644
--- a/testcases/kernel/syscalls/execve/execve04.c
+++ b/testcases/kernel/syscalls/execve/execve04.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (sync_pipe_create(start_sync_pipes, PIPE_NAME_START) == -1)
 			tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index b8c4d11..7603b1e 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -86,7 +86,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		prog = av[0];
 		iterations = atoi(av[1]);
diff --git a/testcases/kernel/syscalls/execvp/execvp01.c b/testcases/kernel/syscalls/execvp/execvp01.c
index 76b0bbf..0ffcd36 100644
--- a/testcases/kernel/syscalls/execvp/execvp01.c
+++ b/testcases/kernel/syscalls/execvp/execvp01.c
@@ -146,7 +146,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (pid = FORK_OR_VFORK()) {
 		case 0:	/* CHILD - Call execvp(2) */
diff --git a/testcases/kernel/syscalls/exit/exit01.c b/testcases/kernel/syscalls/exit/exit01.c
index e3a39fa..a90b27e 100644
--- a/testcases/kernel/syscalls/exit/exit01.c
+++ b/testcases/kernel/syscalls/exit/exit01.c
@@ -51,7 +51,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		sig = 0;
 		exno = 1;
diff --git a/testcases/kernel/syscalls/exit/exit02.c b/testcases/kernel/syscalls/exit/exit02.c
index 10f0976..be6fbd8 100644
--- a/testcases/kernel/syscalls/exit/exit02.c
+++ b/testcases/kernel/syscalls/exit/exit02.c
@@ -88,9 +88,9 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		/*
-		 * reset Tst_count in case we are looping.
+		 * reset tst_count in case we are looping.
 		 */
-		Tst_count = 0;
+		tst_count = 0;
 
 		strcpy(wbuf, "abcd");
 		len = strlen(wbuf);
diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index 45be493..5c493bc 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call faccessat
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index 9e5c27c..c16ce0a 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < defined_advise_total; i++) {
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
index 5e0f725..61a8b31 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index ea9ba07..1c74405 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -127,7 +127,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (advise = 0; advise < advise_limit; advise++) {
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
index b9ade2e..829f614 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index 6270e37..c6c0546 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -219,7 +219,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (mode = DEFAULT; mode <= FALLOC_FL_KEEP_SIZE; mode++) {
 			switch (mode) {
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index b26ef70..d27d159 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -269,7 +269,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 		for (test_index = 0; test_index < TST_TOTAL; test_index++) {
 			switch (test_data[test_index].file) {
 			case RFILE:
diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
index ac044e0..bfce49e 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate03.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
@@ -261,8 +261,8 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		for (test_index = 0; test_index < TST_TOTAL; test_index++) {
 			TEST(fallocate
 			     (fd, test_data[test_index].mode,
diff --git a/testcases/kernel/syscalls/fchdir/fchdir01.c b/testcases/kernel/syscalls/fchdir/fchdir01.c
index 6788251..a5e97f8 100644
--- a/testcases/kernel/syscalls/fchdir/fchdir01.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir01.c
@@ -89,7 +89,7 @@ int main(int ac, char **av)
 	setup();		/* global setup */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* get the name of the test dirctory */
 		if ((temp_dir = (getcwd(temp_dir, 0))) == NULL)
diff --git a/testcases/kernel/syscalls/fchdir/fchdir02.c b/testcases/kernel/syscalls/fchdir/fchdir02.c
index c5b4bd3..774a256 100644
--- a/testcases/kernel/syscalls/fchdir/fchdir02.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir02.c
@@ -80,7 +80,7 @@ int main(int ac, char **av)
 	setup();		/* global setup */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fchdir(bad_fd));
 
diff --git a/testcases/kernel/syscalls/fchdir/fchdir03.c b/testcases/kernel/syscalls/fchdir/fchdir03.c
index c95e89e..d23407f 100644
--- a/testcases/kernel/syscalls/fchdir/fchdir03.c
+++ b/testcases/kernel/syscalls/fchdir/fchdir03.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1)
 			tst_brkm(TBROK, cleanup, "fork failed");
diff --git a/testcases/kernel/syscalls/fchmod/fchmod01.c b/testcases/kernel/syscalls/fchmod/fchmod01.c
index 3706eb2..f61c461 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod01.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod01.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fchmod(fd, 0700));
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index 893ca46..65ad6ae 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -116,7 +116,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call fchmod(2) with specified mode argument
diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c b/testcases/kernel/syscalls/fchmod/fchmod03.c
index 36f6849..0341e03 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fchmod(fd, PERMS));
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod04.c b/testcases/kernel/syscalls/fchmod/fchmod04.c
index bee0959..5602472 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod04.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod04.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call fchmod(2) with mode argument to
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 1d75cb2..8daea52 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call fchmod(2) with mode argument
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 75de7b4..f510839 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			fd = test_cases[i].fd;
diff --git a/testcases/kernel/syscalls/fchmod/fchmod07.c b/testcases/kernel/syscalls/fchmod/fchmod07.c
index c383df6..3a0b955 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod07.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod07.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			mode = Modes[ind];
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 2100eb8..fc21aac 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call fchmodat
diff --git a/testcases/kernel/syscalls/fchown/fchown01.c b/testcases/kernel/syscalls/fchown/fchown01.c
index c04a06d..be79ef4 100644
--- a/testcases/kernel/syscalls/fchown/fchown01.c
+++ b/testcases/kernel/syscalls/fchown/fchown01.c
@@ -138,7 +138,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fchown(fd, geteuid(), getegid()));
 
diff --git a/testcases/kernel/syscalls/fchown/fchown02.c b/testcases/kernel/syscalls/fchown/fchown02.c
index f2904a9..333eb44 100644
--- a/testcases/kernel/syscalls/fchown/fchown02.c
+++ b/testcases/kernel/syscalls/fchown/fchown02.c
@@ -138,7 +138,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			fildes = Test_cases[ind].fd;
diff --git a/testcases/kernel/syscalls/fchown/fchown03.c b/testcases/kernel/syscalls/fchown/fchown03.c
index c5ee0c3..bb3abf3 100644
--- a/testcases/kernel/syscalls/fchown/fchown03.c
+++ b/testcases/kernel/syscalls/fchown/fchown03.c
@@ -116,7 +116,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Get the euid/egid of the process */
 		user_id = geteuid();
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index c601ae9..a3fdd7a 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/fchown/fchown05.c b/testcases/kernel/syscalls/fchown/fchown05.c
index 1c0426c..3d88b67 100644
--- a/testcases/kernel/syscalls/fchown/fchown05.c
+++ b/testcases/kernel/syscalls/fchown/fchown05.c
@@ -123,7 +123,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			test_desc = Test_cases[ind].desc;
diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 7b3e8f2..7a096e9 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -116,7 +116,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call fchownat
diff --git a/testcases/kernel/syscalls/fcntl/fcntl01.c b/testcases/kernel/syscalls/fcntl/fcntl01.c
index 6c44cc0..a8cdd50 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl01.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl01.c
@@ -59,7 +59,7 @@ int main(int ac, char **av)
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		mypid = getpid();
 		for (i = 0; i < 8; i++) {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl02.c b/testcases/kernel/syscalls/fcntl/fcntl02.c
index 998914f..537d6e6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl02.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl02.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fcntl(fd, F_DUPFD, 0));
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl03.c b/testcases/kernel/syscalls/fcntl/fcntl03.c
index 0e7ba5b..46ef658 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl03.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl03.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fcntl(fd, F_GETFD, 0));
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl04.c b/testcases/kernel/syscalls/fcntl/fcntl04.c
index fdc48dc..07bed2d 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl04.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl04.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fcntl(fd, F_GETFL, 0));
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl05.c b/testcases/kernel/syscalls/fcntl/fcntl05.c
index 324f879..0a359b8 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl05.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl05.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		flocks.l_type = F_RDLCK;
 		TEST(fcntl(fd, F_GETLK, &flocks));
diff --git a/testcases/kernel/syscalls/fcntl/fcntl07.c b/testcases/kernel/syscalls/fcntl/fcntl07.c
index 3bcd860..763157f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl07.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl07.c
@@ -213,7 +213,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (tcp = testfds, tcd = testfdtypes; *tcp; tcp++, tcd++) {
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl07B.c b/testcases/kernel/syscalls/fcntl/fcntl07B.c
index 0d87c8b..60579c3 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl07B.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl07B.c
@@ -222,7 +222,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (tcp = testfds, tcd = testfdtypes; *tcp; tcp++, tcd++) {
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl08.c b/testcases/kernel/syscalls/fcntl/fcntl08.c
index a4a3094..8c3d815 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl08.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl08.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fcntl(fd, F_SETFL, arg));
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl09.c b/testcases/kernel/syscalls/fcntl/fcntl09.c
index 2d34574..7afa879 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl09.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl09.c
@@ -157,7 +157,7 @@ int main(int ac, char **av)
 		int type;
 		for (type = 0; type < 2; type++) {
 
-			Tst_count = 0;
+			tst_count = 0;
 
 			flocks.l_type = type ? F_RDLCK : F_WRLCK;
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl10.c b/testcases/kernel/syscalls/fcntl/fcntl10.c
index d2b3771..6243f96 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl10.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl10.c
@@ -157,7 +157,7 @@ int main(int ac, char **av)
 		int type;
 		for (type = 0; type < 2; type++) {
 
-			Tst_count = 0;
+			tst_count = 0;
 
 			flocks.l_type = type ? F_RDLCK : F_WRLCK;
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index 4f36b6c..2afd385 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -259,8 +259,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((child_pid = FORK_OR_VFORK()) == 0) {	/* parent */
 #ifdef UCLINUX
diff --git a/testcases/kernel/syscalls/fcntl/fcntl12.c b/testcases/kernel/syscalls/fcntl/fcntl12.c
index ad6d992..ca3a781 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl12.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl12.c
@@ -71,8 +71,8 @@ int main(int ac, char **av)
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 /* //block1: */
 		tst_resm(TINFO, "Enter block 1");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl13.c b/testcases/kernel/syscalls/fcntl/fcntl13.c
index b20fb68..7bc4e53 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl13.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl13.c
@@ -64,8 +64,8 @@ int main(int ac, char **av)
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 /* //block1: */
 		tst_resm(TINFO, "Enter block 1");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 82efe02..a622b59 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -1000,8 +1000,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 /* //block1: */
 		tst_resm(TINFO, "Enter block 1: without mandatory locking");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl15.c b/testcases/kernel/syscalls/fcntl/fcntl15.c
index 6d6d6f4..2343617 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl15.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl15.c
@@ -562,8 +562,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* Set up to catch alarm signal */
 		if ((signal(SIGALRM, alarm_sig)) == SIG_ERR) {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index e41d6e9..d985ae1 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -671,8 +671,8 @@ int main(int ac, char **av)
 	setup();		/* global setup */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 /* //block1: */
 		/*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl17.c b/testcases/kernel/syscalls/fcntl/fcntl17.c
index f67fc0a..f1b391e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl17.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl17.c
@@ -453,8 +453,8 @@ int main(int ac, char **av)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		tst_resm(TINFO, "Enter preparation phase");
 		if ((child_pid1 = FORK_OR_VFORK()) == 0) {	/* first child */
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index 780d031..59e0e3b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -299,8 +299,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((child_pid = FORK_OR_VFORK()) == 0) {	/* child */
 #ifdef UCLINUX
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index 32a6170..ecdaa2b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -298,8 +298,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((child_pid = FORK_OR_VFORK()) == 0) {	/* child */
 #ifdef UCLINUX
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index af24536..ce20a00 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -309,8 +309,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((child_pid = FORK_OR_VFORK()) == 0) {
 #ifdef UCLINUX
diff --git a/testcases/kernel/syscalls/fcntl/fcntl22.c b/testcases/kernel/syscalls/fcntl/fcntl22.c
index 8a31e4d..8e1159b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl22.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl22.c
@@ -119,8 +119,8 @@ int main(int ac, char **av)
 		test_desc = "EAGAIN";
 #endif
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* duplicate process */
 		if ((child_pid = FORK_OR_VFORK()) == 0) {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl23.c b/testcases/kernel/syscalls/fcntl/fcntl23.c
index 43a42ae..a1e8f18 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl23.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl23.c
@@ -138,7 +138,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef F_SETLEASE
 		/*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl24.c b/testcases/kernel/syscalls/fcntl/fcntl24.c
index a090ca2..6c95bec 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl24.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl24.c
@@ -154,7 +154,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef F_SETLEASE
 		/*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl25.c b/testcases/kernel/syscalls/fcntl/fcntl25.c
index b82c3df..bd8479f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl25.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl25.c
@@ -155,7 +155,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef F_SETLEASE
 		/*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl26.c b/testcases/kernel/syscalls/fcntl/fcntl26.c
index 6424de7..08cce97 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl26.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl26.c
@@ -155,7 +155,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef F_SETLEASE
 		/*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl27.c b/testcases/kernel/syscalls/fcntl/fcntl27.c
index 01ce4dd..3edc5ad 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl27.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl27.c
@@ -132,7 +132,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef F_SETLEASE
 		/*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl28.c b/testcases/kernel/syscalls/fcntl/fcntl28.c
index 634fe31..40eb1ef 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl28.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl28.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef F_SETLEASE
 		/*
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync01.c b/testcases/kernel/syscalls/fdatasync/fdatasync01.c
index 24f19fe..775efc8 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync01.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync01.c
@@ -93,8 +93,8 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* Test the system call */
 		TEST(fdatasync(fd));
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync02.c b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
index cf5c556..ec0b0e6 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync02.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
@@ -119,8 +119,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			if ((tdat[testno].setup) && (tdat[testno].setup())) {
diff --git a/testcases/kernel/syscalls/flock/flock01.c b/testcases/kernel/syscalls/flock/flock01.c
index be2e249..cbc7523 100644
--- a/testcases/kernel/syscalls/flock/flock01.c
+++ b/testcases/kernel/syscalls/flock/flock01.c
@@ -109,8 +109,8 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/flock/flock02.c b/testcases/kernel/syscalls/flock/flock02.c
index 4853200..75e2d97 100644
--- a/testcases/kernel/syscalls/flock/flock02.c
+++ b/testcases/kernel/syscalls/flock/flock02.c
@@ -102,7 +102,7 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(flock(-1, LOCK_SH));
 
diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
index dd668dc..bacf4f6 100644
--- a/testcases/kernel/syscalls/flock/flock03.c
+++ b/testcases/kernel/syscalls/flock/flock03.c
@@ -77,7 +77,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = open(FILE_NAME, O_RDWR);
 
diff --git a/testcases/kernel/syscalls/flock/flock04.c b/testcases/kernel/syscalls/flock/flock04.c
index d827717..64218f8 100644
--- a/testcases/kernel/syscalls/flock/flock04.c
+++ b/testcases/kernel/syscalls/flock/flock04.c
@@ -101,7 +101,7 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(flock(fd, LOCK_SH));
 		if (TEST_RETURN == 0) {
diff --git a/testcases/kernel/syscalls/flock/flock05.c b/testcases/kernel/syscalls/flock/flock05.c
index 945f9ab..36e3f34 100644
--- a/testcases/kernel/syscalls/flock/flock05.c
+++ b/testcases/kernel/syscalls/flock/flock05.c
@@ -107,8 +107,8 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* Testing Shared lock on Exclusive Locked file */
 		TEST(flock(fd, LOCK_EX));
diff --git a/testcases/kernel/syscalls/flock/flock06.c b/testcases/kernel/syscalls/flock/flock06.c
index 67fb109..b60e223 100644
--- a/testcases/kernel/syscalls/flock/flock06.c
+++ b/testcases/kernel/syscalls/flock/flock06.c
@@ -92,8 +92,8 @@ int main(int argc, char **argv)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int fd1, fd2;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		fd1 = open(filename, O_RDWR);
 		if (fd1 == -1)
diff --git a/testcases/kernel/syscalls/fork/fork01.c b/testcases/kernel/syscalls/fork/fork01.c
index 2468101..db172b7 100644
--- a/testcases/kernel/syscalls/fork/fork01.c
+++ b/testcases/kernel/syscalls/fork/fork01.c
@@ -175,7 +175,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		fails = 0;
 
 		TEST(fork());
diff --git a/testcases/kernel/syscalls/fork/fork02.c b/testcases/kernel/syscalls/fork/fork02.c
index 8355cc2..03c343f 100644
--- a/testcases/kernel/syscalls/fork/fork02.c
+++ b/testcases/kernel/syscalls/fork/fork02.c
@@ -67,7 +67,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		pid1 = fork();
 		if (pid1 == -1)
diff --git a/testcases/kernel/syscalls/fork/fork03.c b/testcases/kernel/syscalls/fork/fork03.c
index 7220ce0..0946994 100644
--- a/testcases/kernel/syscalls/fork/fork03.c
+++ b/testcases/kernel/syscalls/fork/fork03.c
@@ -67,7 +67,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		pid1 = fork();
 		if (pid1 == -1)
 			tst_brkm(TBROK, cleanup, "fork() failed");
diff --git a/testcases/kernel/syscalls/fork/fork04.c b/testcases/kernel/syscalls/fork/fork04.c
index 8059df2..0d49eb2 100644
--- a/testcases/kernel/syscalls/fork/fork04.c
+++ b/testcases/kernel/syscalls/fork/fork04.c
@@ -290,7 +290,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		fails = 0;
 
 		TEST(fork());
diff --git a/testcases/kernel/syscalls/fork/fork06.c b/testcases/kernel/syscalls/fork/fork06.c
index 4fb6d50..5414481 100644
--- a/testcases/kernel/syscalls/fork/fork06.c
+++ b/testcases/kernel/syscalls/fork/fork06.c
@@ -65,7 +65,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		succeed = 0;
 		fail = 0;
 
diff --git a/testcases/kernel/syscalls/fork/fork07.c b/testcases/kernel/syscalls/fork/fork07.c
index bfa23b2..d4d6948 100644
--- a/testcases/kernel/syscalls/fork/fork07.c
+++ b/testcases/kernel/syscalls/fork/fork07.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		writ = fopen(fnamebuf, "w");
 		if (writ == NULL)
diff --git a/testcases/kernel/syscalls/fork/fork08.c b/testcases/kernel/syscalls/fork/fork08.c
index 98c1e01..353c02e 100644
--- a/testcases/kernel/syscalls/fork/fork08.c
+++ b/testcases/kernel/syscalls/fork/fork08.c
@@ -70,7 +70,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		writ = fopen(fnamebuf, "w");
 		if (writ == NULL)
diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index 364fed7..4ee4f3f 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -80,7 +80,7 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, cleanup, "malloc failed");
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		mypid = getpid();
 
 		tst_resm(TINFO, "OPEN_MAX is %ld", OPEN_MAX);
diff --git a/testcases/kernel/syscalls/fork/fork10.c b/testcases/kernel/syscalls/fork/fork10.c
index 49110c8..ba20ada 100644
--- a/testcases/kernel/syscalls/fork/fork10.c
+++ b/testcases/kernel/syscalls/fork/fork10.c
@@ -74,7 +74,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fildes = creat(fnamebuf, 0600);
 		if (fildes < 0)
diff --git a/testcases/kernel/syscalls/fork/fork11.c b/testcases/kernel/syscalls/fork/fork11.c
index 843fdf8..cda81da 100644
--- a/testcases/kernel/syscalls/fork/fork11.c
+++ b/testcases/kernel/syscalls/fork/fork11.c
@@ -64,7 +64,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < NUMFORKS; i++) {
 			pid = fork();
diff --git a/testcases/kernel/syscalls/fork/fork12.c b/testcases/kernel/syscalls/fork/fork12.c
index 9a1d879..619d8a3 100644
--- a/testcases/kernel/syscalls/fork/fork12.c
+++ b/testcases/kernel/syscalls/fork/fork12.c
@@ -67,7 +67,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		tst_resm(TINFO, "Forking as many kids as possible");
 		forks = 0;
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index b184c01..c8fcde8 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -93,7 +93,7 @@ static void check(void)
 	int child_exit_code, distance, reaped, status;
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		child_exit_code = lc % RETURN;
 		switch (pid = fork()) {
 		case -1:
diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index 271243c..e566dfa 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -163,7 +163,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/fstat/fstat01.c b/testcases/kernel/syscalls/fstat/fstat01.c
index c4b373e..ad3e422 100644
--- a/testcases/kernel/syscalls/fstat/fstat01.c
+++ b/testcases/kernel/syscalls/fstat/fstat01.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fstat(fd, &statter));
 
diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index 2e0925d..1e68cf3 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(fstat(fildes, &stat_buf));
 
diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index 0cf0ec5..b10115f 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 		/*
 		 * Call fstat(2) to get the status information
 		 * of a closed testfile pointed to by 'fd'.
diff --git a/testcases/kernel/syscalls/fstat/fstat04.c b/testcases/kernel/syscalls/fstat/fstat04.c
index 720a021..2a697e4 100644
--- a/testcases/kernel/syscalls/fstat/fstat04.c
+++ b/testcases/kernel/syscalls/fstat/fstat04.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call fstat(2) to get the status of
diff --git a/testcases/kernel/syscalls/fstat/fstat05.c b/testcases/kernel/syscalls/fstat/fstat05.c
index f820890..5c5f417 100644
--- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ b/testcases/kernel/syscalls/fstat/fstat05.c
@@ -154,7 +154,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call fstat(2).
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index 7fea942..b0f6ba4 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -127,7 +127,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(myfstatat
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs01.c b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
index 47ab00f..068da69 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs01.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 #ifdef __linux__
 #define FSTATFSCALL fstatfs(fd, &stats)
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index bed6713..10d173c 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index a8135aa..f597889 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (write(fd, &buf, strlen(buf)) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "write failed");
diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index 8fe8ba4..564f5c6 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -93,7 +93,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		while (max_block <= data_blocks) {
 			random_number = random();
diff --git a/testcases/kernel/syscalls/fsync/fsync03.c b/testcases/kernel/syscalls/fsync/fsync03.c
index ca5a7c9..653c0e3 100644
--- a/testcases/kernel/syscalls/fsync/fsync03.c
+++ b/testcases/kernel/syscalls/fsync/fsync03.c
@@ -90,7 +90,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
index 984ead9..85f4ed4 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call ftruncate(2) to truncate a test file to a
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate02.c b/testcases/kernel/syscalls/ftruncate/ftruncate02.c
index 9319794..b885477 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate02.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate02.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call ftruncate(2) to truncate a test file to a
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index 2aa8dfb..ba3d8b3 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call futimesat
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index f9b6232..7b84856 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 	ret = 0;
 	testno = (int)(sizeof(tcase) / sizeof(*tcase));
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < testno; i++) {
 			tst_resm(TINFO, "(case%02d) START", i);
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index d3ab244..ea1100f 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -87,7 +87,7 @@ int main(int argc, char **argv)
 	len_ptr = sizeof(struct robust_list_head);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * The get_robust_list function fails with EFAULT if the size of the
diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c b/testcases/kernel/syscalls/getcontext/getcontext01.c
index 866ce46..b3bdd24 100644
--- a/testcases/kernel/syscalls/getcontext/getcontext01.c
+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c
@@ -69,7 +69,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getcontext(&ptr));
 
diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
index 2536a35..437f441 100644
--- a/testcases/kernel/syscalls/getcpu/getcpu01.c
+++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
@@ -119,8 +119,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* call the system call with the TEST() macro */
 		cpu_set = set_cpu_affinity();
diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index c262389..ab173c7 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -i option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			tst_resm(TINFO, "%s", testcases[i].desc);
diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index a1e7900..b68c05e 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -i option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((fin = popen(pwd, "r")) == NULL) {
 			tst_resm(TINFO, "%s: can't run %s", TCID, pwd);
diff --git a/testcases/kernel/syscalls/getcwd/getcwd03.c b/testcases/kernel/syscalls/getcwd/getcwd03.c
index 9203244..34d5e8b 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd03.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd03.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -i option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		flag = 0;
 
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index 76428c6..af0ac1a 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -87,7 +87,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((dir_name = getcwd(dir_name, size)) == NULL)
 			tst_brkm(TBROK, cleanup, "Can not get current "
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index d792a55..ee34de2 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -85,7 +85,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((dir_name = getcwd(dir_name, size)) == NULL)
 			tst_brkm(TBROK, cleanup, "Can not get current "
diff --git a/testcases/kernel/syscalls/getdents/getdents03.c b/testcases/kernel/syscalls/getdents/getdents03.c
index 40d84c9..700e54b 100644
--- a/testcases/kernel/syscalls/getdents/getdents03.c
+++ b/testcases/kernel/syscalls/getdents/getdents03.c
@@ -88,7 +88,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((dir_name = getcwd(dir_name, size)) == NULL)
 			tst_brkm(TBROK, cleanup, "Can not get current "
diff --git a/testcases/kernel/syscalls/getdents/getdents04.c b/testcases/kernel/syscalls/getdents/getdents04.c
index 0de17f2..89479a4 100644
--- a/testcases/kernel/syscalls/getdents/getdents04.c
+++ b/testcases/kernel/syscalls/getdents/getdents04.c
@@ -90,7 +90,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((dir_name = getcwd(dir_name, size)) == NULL)
 			tst_brkm(TBROK, cleanup, "Can not get current "
diff --git a/testcases/kernel/syscalls/getdomainname/getdomainname01.c b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
index f21cbfd..593e2aa 100644
--- a/testcases/kernel/syscalls/getdomainname/getdomainname01.c
+++ b/testcases/kernel/syscalls/getdomainname/getdomainname01.c
@@ -90,7 +90,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call getdomainname(2)
diff --git a/testcases/kernel/syscalls/getegid/getegid01.c b/testcases/kernel/syscalls/getegid/getegid01.c
index dcf3c89..fefbe9c 100644
--- a/testcases/kernel/syscalls/getegid/getegid01.c
+++ b/testcases/kernel/syscalls/getegid/getegid01.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(GETEGID());
 
diff --git a/testcases/kernel/syscalls/getegid/getegid02.c b/testcases/kernel/syscalls/getegid/getegid02.c
index a6402f6..e8b4022 100644
--- a/testcases/kernel/syscalls/getegid/getegid02.c
+++ b/testcases/kernel/syscalls/getegid/getegid02.c
@@ -88,8 +88,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(GETEGID());
 
diff --git a/testcases/kernel/syscalls/geteuid/geteuid01.c b/testcases/kernel/syscalls/geteuid/geteuid01.c
index 57103d7..0b641d7 100644
--- a/testcases/kernel/syscalls/geteuid/geteuid01.c
+++ b/testcases/kernel/syscalls/geteuid/geteuid01.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(GETEUID());
 
diff --git a/testcases/kernel/syscalls/getgid/getgid01.c b/testcases/kernel/syscalls/getgid/getgid01.c
index f801974..1ca7a0a 100644
--- a/testcases/kernel/syscalls/getgid/getgid01.c
+++ b/testcases/kernel/syscalls/getgid/getgid01.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(GETGID());
 
diff --git a/testcases/kernel/syscalls/getgid/getgid03.c b/testcases/kernel/syscalls/getgid/getgid03.c
index cf5fe3a..35325d9 100644
--- a/testcases/kernel/syscalls/getgid/getgid03.c
+++ b/testcases/kernel/syscalls/getgid/getgid03.c
@@ -89,8 +89,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(GETGID());
 
diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
index ab80fa1..75f2f63 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups01.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getgroups(-1, gidset));
 
diff --git a/testcases/kernel/syscalls/getgroups/getgroups02.c b/testcases/kernel/syscalls/getgroups/getgroups02.c
index 1882724..977996c 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups02.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups02.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getgroups(GID_ARRAY_SIZE, gidset));
 
diff --git a/testcases/kernel/syscalls/getgroups/getgroups03.c b/testcases/kernel/syscalls/getgroups/getgroups03.c
index cce1e6f..5950fc4 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups03.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups03.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getgroups(gidsetsize, groups_list));
 
diff --git a/testcases/kernel/syscalls/getgroups/getgroups04.c b/testcases/kernel/syscalls/getgroups/getgroups04.c
index e440c52..e1beaff 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups04.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups04.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			gidsetsize = test_cases[i].gsize;
diff --git a/testcases/kernel/syscalls/gethostid/gethostid01.c b/testcases/kernel/syscalls/gethostid/gethostid01.c
index 4b9cfee..396d3f2 100644
--- a/testcases/kernel/syscalls/gethostid/gethostid01.c
+++ b/testcases/kernel/syscalls/gethostid/gethostid01.c
@@ -159,7 +159,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(gethostid());
 
diff --git a/testcases/kernel/syscalls/gethostname/gethostname01.c b/testcases/kernel/syscalls/gethostname/gethostname01.c
index e23c025..87328666 100644
--- a/testcases/kernel/syscalls/gethostname/gethostname01.c
+++ b/testcases/kernel/syscalls/gethostname/gethostname01.c
@@ -138,7 +138,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(gethostname(hname, sizeof(hname)));
 
diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index b13cc67..56c56e0 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -78,8 +78,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* allocate space for the itimerval structure */
 
diff --git a/testcases/kernel/syscalls/getitimer/getitimer02.c b/testcases/kernel/syscalls/getitimer/getitimer02.c
index 7ccd1f0..775fa31 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer02.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer02.c
@@ -81,8 +81,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * issue the system call with the TEST() macro
diff --git a/testcases/kernel/syscalls/getitimer/getitimer03.c b/testcases/kernel/syscalls/getitimer/getitimer03.c
index c7828a6..3e8e41b 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer03.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer03.c
@@ -83,8 +83,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* allocate some space for the timer structure */
 
diff --git a/testcases/kernel/syscalls/getpagesize/getpagesize01.c b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
index acbca4f..e7665d5 100644
--- a/testcases/kernel/syscalls/getpagesize/getpagesize01.c
+++ b/testcases/kernel/syscalls/getpagesize/getpagesize01.c
@@ -70,7 +70,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getpagesize());
 
diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c b/testcases/kernel/syscalls/getpeername/getpeername01.c
index 0c461d8..cda7c8d 100644
--- a/testcases/kernel/syscalls/getpeername/getpeername01.c
+++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
@@ -123,7 +123,7 @@ int main(int argc, char *argv[])
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/getpgid/getpgid01.c b/testcases/kernel/syscalls/getpgid/getpgid01.c
index f9c1fb3..84942d9 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid01.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid01.c
@@ -72,7 +72,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pgid_0 = FORK_OR_VFORK()) == -1)
 			tst_brkm(TBROK, cleanup, "fork failed");
diff --git a/testcases/kernel/syscalls/getpgid/getpgid02.c b/testcases/kernel/syscalls/getpgid/getpgid02.c
index f02e466..e44eb69 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid02.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid02.c
@@ -92,8 +92,8 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/getpgrp/getpgrp01.c b/testcases/kernel/syscalls/getpgrp/getpgrp01.c
index e63e5e7..60cfdeb 100644
--- a/testcases/kernel/syscalls/getpgrp/getpgrp01.c
+++ b/testcases/kernel/syscalls/getpgrp/getpgrp01.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getpgrp());
 
diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index 628a8f3..2492a23 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -137,7 +137,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getpid());
 
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 85fd2bd..df25461 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getpid());
 
diff --git a/testcases/kernel/syscalls/getppid/getppid01.c b/testcases/kernel/syscalls/getppid/getppid01.c
index 8397545..ddc3222 100644
--- a/testcases/kernel/syscalls/getppid/getppid01.c
+++ b/testcases/kernel/syscalls/getppid/getppid01.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getppid());
 
diff --git a/testcases/kernel/syscalls/getppid/getppid02.c b/testcases/kernel/syscalls/getppid/getppid02.c
index 8b81b0a..d88864e 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -66,7 +66,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		ppid = getpid();
 		pid = FORK_OR_VFORK();
diff --git a/testcases/kernel/syscalls/getpriority/getpriority01.c b/testcases/kernel/syscalls/getpriority/getpriority01.c
index 9b04543..2ba9274 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority01.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority01.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			which = prio_which[ind];
diff --git a/testcases/kernel/syscalls/getpriority/getpriority02.c b/testcases/kernel/syscalls/getpriority/getpriority02.c
index 15d5906..3ffa0df 100644
--- a/testcases/kernel/syscalls/getpriority/getpriority02.c
+++ b/testcases/kernel/syscalls/getpriority/getpriority02.c
@@ -126,7 +126,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			which = Test_cases[ind].pro_which;
diff --git a/testcases/kernel/syscalls/getresgid/getresgid01.c b/testcases/kernel/syscalls/getresgid/getresgid01.c
index fc56999..39224db 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid01.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid01.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call getresgid() to get the real/effective/saved
diff --git a/testcases/kernel/syscalls/getresgid/getresgid02.c b/testcases/kernel/syscalls/getresgid/getresgid02.c
index f974100..deaba7e 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid02.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid02.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call getresgid() to get the real/effective/saved
diff --git a/testcases/kernel/syscalls/getresgid/getresgid03.c b/testcases/kernel/syscalls/getresgid/getresgid03.c
index a6347a9..56172ef 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid03.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid03.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call getresgid() to get the real/effective/saved
diff --git a/testcases/kernel/syscalls/getresuid/getresuid01.c b/testcases/kernel/syscalls/getresuid/getresuid01.c
index a6057f8..80ed099 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid01.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid01.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call getresuid() to get the real/effective/saved
diff --git a/testcases/kernel/syscalls/getresuid/getresuid02.c b/testcases/kernel/syscalls/getresuid/getresuid02.c
index 87aa4f3..15dc33e 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid02.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid02.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call getresuid() to get the real/effective/saved
diff --git a/testcases/kernel/syscalls/getresuid/getresuid03.c b/testcases/kernel/syscalls/getresuid/getresuid03.c
index c0fb857..8b45ef0 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid03.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid03.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call getresuid() to get the real/effective/saved
diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
index 9bc927d..5e8ec60 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit02.c b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
index b2f002c..ba2b53f 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit02.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/getrusage/getrusage01.c b/testcases/kernel/syscalls/getrusage/getrusage01.c
index 0a7af5f..0106ad5 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage01.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage01.c
@@ -92,7 +92,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(getrusage(who[i], &usage));
diff --git a/testcases/kernel/syscalls/getrusage/getrusage02.c b/testcases/kernel/syscalls/getrusage/getrusage02.c
index 8ce0351..e6383a3 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage02.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage02.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(getrusage(test_cases[i].who, test_cases[i].usage));
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index ae78be3..202356c 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -78,7 +78,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		tst_resm(TINFO, "allocate 100MB");
 		consume(100);
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
index 827e007..52bd15e 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
@@ -74,7 +74,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (opt_consume) {
 			consume_nr = SAFE_STRTOL(cleanup,
diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index 95c701d..96e24a4 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -104,7 +104,7 @@ int main(int argc, char *argv[])
 		 "increment (1000+%ldus)!", factor_nr, BIAS_MAX * factor_nr);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		i = 0;
 		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
 		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
diff --git a/testcases/kernel/syscalls/getsid/getsid01.c b/testcases/kernel/syscalls/getsid/getsid01.c
index 69fcef6..f508c80 100644
--- a/testcases/kernel/syscalls/getsid/getsid01.c
+++ b/testcases/kernel/syscalls/getsid/getsid01.c
@@ -86,8 +86,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* call the system call with the TEST() macro */
 
diff --git a/testcases/kernel/syscalls/getsid/getsid02.c b/testcases/kernel/syscalls/getsid/getsid02.c
index 4832934..4f0c401 100644
--- a/testcases/kernel/syscalls/getsid/getsid02.c
+++ b/testcases/kernel/syscalls/getsid/getsid02.c
@@ -46,7 +46,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getsid(pid_max + 1));
 
diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c b/testcases/kernel/syscalls/getsockname/getsockname01.c
index adc5f73..dc16207 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt01.c b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
index a30e645..1b942b1 100644
--- a/testcases/kernel/syscalls/getsockopt/getsockopt01.c
+++ b/testcases/kernel/syscalls/getsockopt/getsockopt01.c
@@ -144,7 +144,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/gettid/gettid01.c b/testcases/kernel/syscalls/gettid/gettid01.c
index 8e32c05..ad48c76 100644
--- a/testcases/kernel/syscalls/gettid/gettid01.c
+++ b/testcases/kernel/syscalls/gettid/gettid01.c
@@ -61,7 +61,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(my_gettid());
 
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
index 1bb46b0..a26d7fc 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday01.c
@@ -78,8 +78,8 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(gettimeofday((void *)-1, (void *)-1));
 
diff --git a/testcases/kernel/syscalls/getuid/getuid01.c b/testcases/kernel/syscalls/getuid/getuid01.c
index 9eaaf10..92ac7f9 100644
--- a/testcases/kernel/syscalls/getuid/getuid01.c
+++ b/testcases/kernel/syscalls/getuid/getuid01.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(GETUID());
 
diff --git a/testcases/kernel/syscalls/getuid/getuid02.c b/testcases/kernel/syscalls/getuid/getuid02.c
index bf2f28d..27a24e0 100644
--- a/testcases/kernel/syscalls/getuid/getuid02.c
+++ b/testcases/kernel/syscalls/getuid/getuid02.c
@@ -64,7 +64,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(GETEUID());
 
diff --git a/testcases/kernel/syscalls/getuid/getuid03.c b/testcases/kernel/syscalls/getuid/getuid03.c
index 3cfa5ca..a5fd7f1 100644
--- a/testcases/kernel/syscalls/getuid/getuid03.c
+++ b/testcases/kernel/syscalls/getuid/getuid03.c
@@ -65,7 +65,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(GETUID());
 
diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index 96392f8..4b8e531 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -109,7 +109,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < (sizeof(tc) / sizeof(tc[0])); i++) {
 			TEST(getxattr(tc[i].fname, tc[i].key, tc[i].value,
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index 078ac96..214c62b 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -92,7 +92,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Before kernel 3.0.0, getxattr(2) will set errno with 'EPERM'
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index 51506a6..cc121fd 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -69,7 +69,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(getxattr(TESTFILE, XATTR_TEST_KEY, NULL, 0));
 
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index ce7fa36..512473a 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 	 */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * generate sequence of events
@@ -107,54 +107,54 @@ int main(int ac, char **av)
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "chmod(%s, 0755) failed", fname);
 		}
-		event_set[Tst_count] = IN_ATTRIB;
-		Tst_count++;
+		event_set[tst_count] = IN_ATTRIB;
+		tst_count++;
 
 		if ((fd = open(fname, O_RDONLY)) == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
 		}
-		event_set[Tst_count] = IN_OPEN;
-		Tst_count++;
+		event_set[tst_count] = IN_OPEN;
+		tst_count++;
 
 		if (read(fd, buf, BUF_SIZE) == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "read(%d, buf, %d) failed", fd, BUF_SIZE);
 		}
-		event_set[Tst_count] = IN_ACCESS;
-		Tst_count++;
+		event_set[tst_count] = IN_ACCESS;
+		tst_count++;
 
 		if (close(fd) == -1) {
 			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
 		}
-		event_set[Tst_count] = IN_CLOSE_NOWRITE;
-		Tst_count++;
+		event_set[tst_count] = IN_CLOSE_NOWRITE;
+		tst_count++;
 
 		if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
 			tst_brkm(TBROK, cleanup,
 				 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
 		}
-		event_set[Tst_count] = IN_OPEN;
-		Tst_count++;
+		event_set[tst_count] = IN_OPEN;
+		tst_count++;
 
 		if (write(fd, buf, BUF_SIZE) == -1) {
 			tst_brkm(TBROK, cleanup,
 				 "write(%d, %s, 1) failed", fd, fname);
 		}
-		event_set[Tst_count] = IN_MODIFY;
-		Tst_count++;
+		event_set[tst_count] = IN_MODIFY;
+		tst_count++;
 
 		if (close(fd) == -1) {
 			tst_brkm(TBROK, cleanup, "close(%s) failed", fname);
 		}
-		event_set[Tst_count] = IN_CLOSE_WRITE;
-		Tst_count++;
+		event_set[tst_count] = IN_CLOSE_WRITE;
+		tst_count++;
 
-		if (TST_TOTAL != Tst_count) {
+		if (TST_TOTAL != tst_count) {
 			tst_brkm(TBROK, cleanup,
-				 "TST_TOTAL and Tst_count are not equal");
+				 "TST_TOTAL and tst_count are not equal");
 		}
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * get list on events
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 4dbf738..a2df236 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * generate sequence of events
@@ -123,41 +123,41 @@ int main(int ac, char **av)
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "chmod(\".\", 0755) failed");
 		}
-		event_set[Tst_count].mask = IN_ISDIR | IN_ATTRIB;
-		strcpy(event_set[Tst_count].name, "");
-		Tst_count++;
+		event_set[tst_count].mask = IN_ISDIR | IN_ATTRIB;
+		strcpy(event_set[tst_count].name, "");
+		tst_count++;
 
 		if ((fd = creat(FILE_NAME1, 0755)) == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "creat(\"%s\", 755) failed", FILE_NAME1);
 		}
 
-		event_set[Tst_count].mask = IN_CREATE;
-		strcpy(event_set[Tst_count].name, FILE_NAME1);
-		Tst_count++;
-		event_set[Tst_count].mask = IN_OPEN;
-		strcpy(event_set[Tst_count].name, FILE_NAME1);
-		Tst_count++;
+		event_set[tst_count].mask = IN_CREATE;
+		strcpy(event_set[tst_count].name, FILE_NAME1);
+		tst_count++;
+		event_set[tst_count].mask = IN_OPEN;
+		strcpy(event_set[tst_count].name, FILE_NAME1);
+		tst_count++;
 
 		if (close(fd) == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "close(%s) failed", FILE_NAME1);
 		}
-		event_set[Tst_count].mask = IN_CLOSE_WRITE;
-		strcpy(event_set[Tst_count].name, FILE_NAME1);
-		Tst_count++;
+		event_set[tst_count].mask = IN_CLOSE_WRITE;
+		strcpy(event_set[tst_count].name, FILE_NAME1);
+		tst_count++;
 
 		if (rename(FILE_NAME1, FILE_NAME2) == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "rename(%s, %s) failed",
 				 FILE_NAME1, FILE_NAME2);
 		}
-		event_set[Tst_count].mask = IN_MOVED_FROM;
-		strcpy(event_set[Tst_count].name, FILE_NAME1);
-		Tst_count++;
-		event_set[Tst_count].mask = IN_MOVED_TO;
-		strcpy(event_set[Tst_count].name, FILE_NAME2);
-		Tst_count++;
+		event_set[tst_count].mask = IN_MOVED_FROM;
+		strcpy(event_set[tst_count].name, FILE_NAME1);
+		tst_count++;
+		event_set[tst_count].mask = IN_MOVED_TO;
+		strcpy(event_set[tst_count].name, FILE_NAME2);
+		tst_count++;
 
 		if (getcwd(fname1, BUF_SIZE) == NULL) {
 			tst_brkm(TBROK | TERRNO, cleanup,
@@ -169,17 +169,17 @@ int main(int ac, char **av)
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "rename(%s, %s) failed", fname1, fname2);
 		}
-		event_set[Tst_count].mask = IN_MOVE_SELF;
-		strcpy(event_set[Tst_count].name, "");
-		Tst_count++;
+		event_set[tst_count].mask = IN_MOVE_SELF;
+		strcpy(event_set[tst_count].name, "");
+		tst_count++;
 
 		if (unlink(FILE_NAME2) == -1) {
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "unlink(%s) failed", FILE_NAME2);
 		}
-		event_set[Tst_count].mask = IN_DELETE;
-		strcpy(event_set[Tst_count].name, FILE_NAME2);
-		Tst_count++;
+		event_set[tst_count].mask = IN_DELETE;
+		strcpy(event_set[tst_count].name, FILE_NAME2);
+		tst_count++;
 
 		/*
 		 * test that duplicate events will be coalesced into
@@ -197,16 +197,16 @@ int main(int ac, char **av)
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "rename(%s, %s) failed", fname3, fname1);
 		}
-		event_set[Tst_count].mask = IN_MOVE_SELF;
-		strcpy(event_set[Tst_count].name, "");
-		Tst_count++;
+		event_set[tst_count].mask = IN_MOVE_SELF;
+		strcpy(event_set[tst_count].name, "");
+		tst_count++;
 
-		if (Tst_count != TST_TOTAL) {
+		if (tst_count != TST_TOTAL) {
 			tst_brkm(TBROK, cleanup,
-				 "Tst_count and TST_TOTAL are not equal");
+				 "tst_count and TST_TOTAL are not equal");
 		}
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		int len, i = 0, test_num = 0;
 		if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) == -1) {
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 8d70f85..5d31f88 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -128,21 +128,21 @@ int main(int ac, char **av)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 
-	event_set[Tst_count] = IN_UNMOUNT;
-	Tst_count++;
-	event_set[Tst_count] = IN_IGNORED;
-	Tst_count++;
+	event_set[tst_count] = IN_UNMOUNT;
+	tst_count++;
+	event_set[tst_count] = IN_IGNORED;
+	tst_count++;
 
 	/*check exit code from inotify_rm_watch */
-	Tst_count++;
+	tst_count++;
 
-	if (TST_TOTAL != Tst_count) {
+	if (TST_TOTAL != tst_count) {
 		tst_brkm(TBROK, cleanup,
-			 "TST_TOTAL and Tst_count are not equal");
+			 "TST_TOTAL and tst_count are not equal");
 	}
-	Tst_count = 0;
+	tst_count = 0;
 
 	tst_resm(TINFO, "umount %s", device);
 	TEST(umount(mntpoint));
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index bbb73fa..df91acb 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -154,15 +154,15 @@ int main(int argc, char **argv)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	rmdir(TEST_DIR);
-	event_set[Tst_count].mask = IN_DELETE_SELF;
-	strcpy(event_set[Tst_count].name, "");
-	Tst_count++;
-	event_set[Tst_count].mask = IN_IGNORED;
-	strcpy(event_set[Tst_count].name, "");
-	Tst_count++;
+	event_set[tst_count].mask = IN_DELETE_SELF;
+	strcpy(event_set[tst_count].name, "");
+	tst_count++;
+	event_set[tst_count].mask = IN_IGNORED;
+	strcpy(event_set[tst_count].name, "");
+	tst_count++;
 
 	unlink(TEST_FILE);
 	/*
@@ -173,23 +173,23 @@ int main(int argc, char **argv)
 	 * understand how Unix works.
 	 */
 	if (0 <= tst_kvercmp(2, 6, 25)) {
-		event_set[Tst_count].mask = IN_ATTRIB;
-		strcpy(event_set[Tst_count].name, "");
-		Tst_count++;
+		event_set[tst_count].mask = IN_ATTRIB;
+		strcpy(event_set[tst_count].name, "");
+		tst_count++;
 		TST_TOTAL++;
 	}
-	event_set[Tst_count].mask = IN_DELETE_SELF;
-	strcpy(event_set[Tst_count].name, TEST_FILE);
-	Tst_count++;
-	event_set[Tst_count].mask = IN_IGNORED;
-	strcpy(event_set[Tst_count].name, "");
-	Tst_count++;
-
-	if (Tst_count != TST_TOTAL)
+	event_set[tst_count].mask = IN_DELETE_SELF;
+	strcpy(event_set[tst_count].name, TEST_FILE);
+	tst_count++;
+	event_set[tst_count].mask = IN_IGNORED;
+	strcpy(event_set[tst_count].name, "");
+	tst_count++;
+
+	if (tst_count != TST_TOTAL)
 		tst_brkm(TBROK, cleanup,
-			 "Tst_count and TST_TOTAL are not equal");
+			 "tst_count and TST_TOTAL are not equal");
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
 	if (len == -1)
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
index 08b4c12..0d092cc 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
@@ -146,7 +146,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			fd = ltp_syscall(__NR_inotify_init1, 0);
 			if (fd == -1) {
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
index 0b80685..b4f43a2 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
@@ -141,7 +141,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			fd = ltp_syscall(__NR_inotify_init1, 0);
 			if (fd == -1) {
diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel01.c b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
index b3fc12d..a5e421d 100644
--- a/testcases/kernel/syscalls/io_cancel/io_cancel01.c
+++ b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
@@ -81,7 +81,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(io_cancel(ctx, NULL, NULL));
 
diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index 882dc96..b1dad77 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -76,7 +76,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(io_destroy(ctx));
 
diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents01.c b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
index 4f64037..042f35c 100644
--- a/testcases/kernel/syscalls/io_getevents/io_getevents01.c
+++ b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
@@ -81,7 +81,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(io_getevents(ctx, 0, 0, NULL, NULL));
 
diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index 9e30e7c..8a880b2 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -68,7 +68,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		memset(&ctx, 0, sizeof(ctx));
 		expected_return = 0;
diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index ef30b2d..77f0f8d 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -107,7 +107,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* 1 - EINVAL */
 		/* 1.1 - EINVAL: invalid ctx */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 243f263..19577a6 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -134,7 +134,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index ab41aea..d9cdc8a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -126,7 +126,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		parenttty = devname;
 		childtty = devname;
diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index 4903129..6b97444 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -100,7 +100,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Test the system call.
diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
index 1e06856..3131217 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm02.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
@@ -121,7 +121,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index bf911ab..c925489 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -94,7 +94,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Test the system call for possible privelege levels.
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index e309847..b0b6ac5 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
index dc12ff3..ec2d16a 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
@@ -82,8 +82,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Get the msqid_ds structure values for the queue
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
index 91db5e2..77c094a 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
@@ -84,8 +84,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Set the msqid_ds structure values for the queue
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
index 0ffa04c..994f75d 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
@@ -116,8 +116,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
index 995d86a..0962474 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
@@ -124,8 +124,8 @@ void do_child()
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
index 8f23f9e..b559796 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
@@ -79,8 +79,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use TEST macro to make the call to create the message queue
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
index 2f7aa0e..617870e 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
@@ -97,8 +97,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index 27612b3..5952c98 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -82,8 +82,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use a while loop to create the maximum number of queues.
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
index 6b62feb..f7e6cb0 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
@@ -85,8 +85,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
index e5562bc..c6f1533 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
@@ -96,8 +96,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * fork a child to read from the queue while the parent
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
index bb2a551..31dac5d 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
@@ -107,8 +107,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
index 7bd7a08..58c1597 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
@@ -95,8 +95,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
index cd23898..0e3bf50 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv04.c
@@ -106,8 +106,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
index bab609f..d951ed0 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 		tst_brkm(TBROK, cleanup, "sync_pipe_create failed");
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * fork a child that will attempt to read a non-existent
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
index da607fd..cde9873 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
@@ -106,8 +106,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * set up the queue here so that multiple test iterations
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 5cbcb7c..6b542be 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -87,8 +87,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use TEST macro to make the call
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index b368002..9637b78 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -98,8 +98,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * loop through the test cases
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c
index d83854f..6b64a90 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd03.c
@@ -104,8 +104,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * loop through the test cases
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c
index 211ac7f..4811a47 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd04.c
@@ -82,8 +82,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Attempt to write another message to the full queue.
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 716ec5b..8b7b1dc 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -108,8 +108,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * fork a child that will attempt to write a message
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
index 6efcc55..8ce96d3 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
@@ -104,8 +104,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		msgkey = getipckey();
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index 4b5e77e..c8957c8 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -158,8 +158,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
index 00df3d4..6d8e279 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
@@ -80,8 +80,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		un_arg.buf = &sem_ds;
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index 166a469..dd0a246 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -110,8 +110,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl04.c b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
index 6112682..7f1079a 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl04.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
@@ -129,8 +129,8 @@ void do_child()
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index 3be88a6..e4221a0 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -109,8 +109,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget01.c b/testcases/kernel/syscalls/ipc/semget/semget01.c
index 3d86526..e2f4b28 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget01.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget01.c
@@ -78,8 +78,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use TEST macro to make the call
diff --git a/testcases/kernel/syscalls/ipc/semget/semget02.c b/testcases/kernel/syscalls/ipc/semget/semget02.c
index 8db4956..17c024d 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget02.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget02.c
@@ -91,8 +91,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* use the TEST macro to make the call */
diff --git a/testcases/kernel/syscalls/ipc/semget/semget03.c b/testcases/kernel/syscalls/ipc/semget/semget03.c
index c0336b1..48bbba1 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget03.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget03.c
@@ -73,8 +73,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* use the TEST macro to make the call */
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index 215e557..f25c074 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -103,8 +103,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* use the TEST macro to make the call */
 
diff --git a/testcases/kernel/syscalls/ipc/semget/semget06.c b/testcases/kernel/syscalls/ipc/semget/semget06.c
index 98d6283..d2469fa 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget06.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget06.c
@@ -79,8 +79,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c b/testcases/kernel/syscalls/ipc/semop/semop01.c
index 29b23dc..ce3a412 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop01.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
@@ -89,8 +89,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use TEST macro to make the call
diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c b/testcases/kernel/syscalls/ipc/semop/semop02.c
index d6ba8e1..b97cc3f 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop02.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
@@ -115,8 +115,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/*
diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c b/testcases/kernel/syscalls/ipc/semop/semop03.c
index 372a2f5..a8b2f34 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop03.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
@@ -82,8 +82,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
index cf40835..2725378 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop04.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
@@ -93,8 +93,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/semop/semop05.c b/testcases/kernel/syscalls/ipc/semop/semop05.c
index afa2e28..386435e 100644
--- a/testcases/kernel/syscalls/ipc/semop/semop05.c
+++ b/testcases/kernel/syscalls/ipc/semop/semop05.c
@@ -123,8 +123,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index ae36383..51e25c5 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -100,8 +100,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index 0ec2917..630de3a 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
index 2d290be..8afbc99 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -121,8 +121,8 @@ static void do_child(void)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * use TEST macro to make the call
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 648032f..4a1b064 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -149,8 +149,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* initialize stat_time */
 		stat_time = FIRST;
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index 1826465..796b0b6 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -117,8 +117,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index e8f980d..ddfa09e 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -141,8 +141,8 @@ void do_child()
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index cfb90e4..a81be0d 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -68,8 +68,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		TEST(shmctl(0, SHM_INFO, (struct shmid_ds *)&shm_info));
 
 		if (TEST_RETURN != -1) {
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
index 6f3e746..008f69c 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
@@ -90,8 +90,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use TEST macro to make the shmdt() call
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
index 26c47c7..bd9a937 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
@@ -71,8 +71,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * make the call using the TEST() macro - attempt to
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget01.c b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
index 9702f14..38dbee7 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget01.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
@@ -78,8 +78,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use TEST macro to make the call
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index cb6f594..ed6917e 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -105,8 +105,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index a4d28fc..1ca49aa 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -82,8 +82,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * use the TEST() macro to make the call
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
index 46e423b..9dfc467 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
@@ -76,8 +76,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * use the TEST() macro to make the call
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
index 6a7ec04..f111e0b 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
@@ -121,8 +121,8 @@ void do_child()
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Look for a failure ...
diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 2b7043e..b76bae7 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (testno = 1; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/kill/kill01.c b/testcases/kernel/syscalls/kill/kill01.c
index 0e9cfb2..594e6f3 100644
--- a/testcases/kernel/syscalls/kill/kill01.c
+++ b/testcases/kernel/syscalls/kill/kill01.c
@@ -90,8 +90,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		status = 1;
 		exno = 1;
 		pid = FORK_OR_VFORK();
diff --git a/testcases/kernel/syscalls/kill/kill02.c b/testcases/kernel/syscalls/kill/kill02.c
index 00fcbff..72bd90f 100644
--- a/testcases/kernel/syscalls/kill/kill02.c
+++ b/testcases/kernel/syscalls/kill/kill02.c
@@ -234,7 +234,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pid1 = FORK_OR_VFORK()) > 0) {
 			if ((pid2 = FORK_OR_VFORK()) > 0) {
@@ -406,7 +406,7 @@ void parent_rout()
 				tst_resm(TPASS,
 					 "The signal was sent to all processes in the process group.");
 			else
-				Tst_count++;
+				tst_count++;
 		} else {	/*Process A didn't receive the signal. */
 			tst_resm(TFAIL,
 				 "Process A did not receive the signal.");
@@ -428,7 +428,7 @@ void parent_rout()
 				tst_resm(TPASS,
 					 "The signal was not sent to selective processes that were not in the process group.");
 			else
-				Tst_count++;
+				tst_count++;
 		} else {	/*Process B received the signal. */
 			tst_resm(TFAIL, "Process B received the signal.");
 		}
diff --git a/testcases/kernel/syscalls/kill/kill03.c b/testcases/kernel/syscalls/kill/kill03.c
index e12443b..b5f225a 100644
--- a/testcases/kernel/syscalls/kill/kill03.c
+++ b/testcases/kernel/syscalls/kill/kill03.c
@@ -94,8 +94,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		status = 1;
 		exno = 1;
 		pid = FORK_OR_VFORK();
diff --git a/testcases/kernel/syscalls/kill/kill04.c b/testcases/kernel/syscalls/kill/kill04.c
index 7e42c88..ae7fd0b 100644
--- a/testcases/kernel/syscalls/kill/kill04.c
+++ b/testcases/kernel/syscalls/kill/kill04.c
@@ -94,8 +94,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		status = 1;
 		exno = 1;
 		pid = FORK_OR_VFORK();
diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index 0fe9137..bdbb9cb 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -156,7 +156,7 @@ void do_master_child(char **av)
 
 	TEST_EXP_ENOS(exp_enos);
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	*flag = 0;
 
diff --git a/testcases/kernel/syscalls/kill/kill06.c b/testcases/kernel/syscalls/kill/kill06.c
index 8f5883d..a935ca4 100644
--- a/testcases/kernel/syscalls/kill/kill06.c
+++ b/testcases/kernel/syscalls/kill/kill06.c
@@ -91,8 +91,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		status = 1;
 		exno = 1;
 
diff --git a/testcases/kernel/syscalls/kill/kill07.c b/testcases/kernel/syscalls/kill/kill07.c
index 6cf63f0..cea43f3 100644
--- a/testcases/kernel/syscalls/kill/kill07.c
+++ b/testcases/kernel/syscalls/kill/kill07.c
@@ -104,8 +104,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		status = 1;
 		exno = 1;
 		my_act.sa_handler = sighandler;
diff --git a/testcases/kernel/syscalls/kill/kill08.c b/testcases/kernel/syscalls/kill/kill08.c
index 62f937e..a525606 100644
--- a/testcases/kernel/syscalls/kill/kill08.c
+++ b/testcases/kernel/syscalls/kill/kill08.c
@@ -91,8 +91,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		status = 1;
 		exno = 1;
 
diff --git a/testcases/kernel/syscalls/kill/kill09.c b/testcases/kernel/syscalls/kill/kill09.c
index e7a68da..b1b8e91 100644
--- a/testcases/kernel/syscalls/kill/kill09.c
+++ b/testcases/kernel/syscalls/kill/kill09.c
@@ -146,7 +146,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((fork_pid = FORK_OR_VFORK()) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
diff --git a/testcases/kernel/syscalls/kill/kill10.c b/testcases/kernel/syscalls/kill/kill10.c
index b27c644..6fefe9b 100644
--- a/testcases/kernel/syscalls/kill/kill10.c
+++ b/testcases/kernel/syscalls/kill/kill10.c
@@ -248,7 +248,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 		child_signal_counter = 0;
 		pgrps_ready = 0;
 		checklist_reset(0x03);
diff --git a/testcases/kernel/syscalls/lchown/lchown01.c b/testcases/kernel/syscalls/lchown/lchown01.c
index b0ec10f..738f0b9 100644
--- a/testcases/kernel/syscalls/lchown/lchown01.c
+++ b/testcases/kernel/syscalls/lchown/lchown01.c
@@ -120,7 +120,7 @@ int main(int argc, char *argv[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; test_cases[i].desc != NULL; i++) {
 			uid_t user_id = test_cases[i].user_id;
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 1a54d4a..4b20410 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -162,7 +162,7 @@ int main(int argc, char *argv[])
 	group_id = getegid();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; test_cases[i].desc != NULL; i++) {
 			char *file_name = test_cases[i].pathname;
diff --git a/testcases/kernel/syscalls/link/link02.c b/testcases/kernel/syscalls/link/link02.c
index 9ed12d3..b7a418c 100644
--- a/testcases/kernel/syscalls/link/link02.c
+++ b/testcases/kernel/syscalls/link/link02.c
@@ -158,7 +158,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call link(2)
diff --git a/testcases/kernel/syscalls/link/link03.c b/testcases/kernel/syscalls/link/link03.c
index 9235877..6768acc 100644
--- a/testcases/kernel/syscalls/link/link03.c
+++ b/testcases/kernel/syscalls/link/link03.c
@@ -188,7 +188,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (Nlinks)
 			nlinks = Nlinks;
@@ -242,7 +242,7 @@ int main(int ac, char **av)
 					 nlinks, fbuf.st_nlink);
 			}
 		} else
-			Tst_count++;
+			tst_count++;
 
 		for (cnt = 1; cnt < nlinks; cnt++) {
 
diff --git a/testcases/kernel/syscalls/link/link04.c b/testcases/kernel/syscalls/link/link04.c
index b46af70..5f92502 100644
--- a/testcases/kernel/syscalls/link/link04.c
+++ b/testcases/kernel/syscalls/link/link04.c
@@ -232,7 +232,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc1 != NULL; ind++) {
 
@@ -271,7 +271,7 @@ int main(int ac, char **av)
 							 Test_cases
 							 [ind].exp_errno);
 				} else
-					Tst_count++;
+					tst_count++;
 			} else {
 				tst_resm(TFAIL,
 					 "link(<%s>, <%s>) returned %ld, expected -1, errno:%d",
diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index 6c69df7..9427ddb 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -181,7 +181,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (cnt = 1; cnt < nlinks; cnt++) {
 
@@ -228,7 +228,7 @@ int main(int ac, char **av)
 					 nlinks, fbuf.st_nlink);
 			}
 		} else
-			Tst_count++;
+			tst_count++;
 
 #ifdef CRAY
 /*
@@ -261,7 +261,7 @@ int main(int ac, char **av)
 						 EMLINK);
 				}
 			} else
-				Tst_count++;
+				tst_count++;
 		} else {
 			tst_resm(TFAIL,
 				 "link(%s, %s) ret %d on %d link, expected -1, errno:%d",
diff --git a/testcases/kernel/syscalls/link/link06.c b/testcases/kernel/syscalls/link/link06.c
index 5272243..b9637c9 100644
--- a/testcases/kernel/syscalls/link/link06.c
+++ b/testcases/kernel/syscalls/link/link06.c
@@ -127,7 +127,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		test_desc = "EACCES";
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call link(2)
diff --git a/testcases/kernel/syscalls/link/link07.c b/testcases/kernel/syscalls/link/link07.c
index 3ca7cf6..d208331 100644
--- a/testcases/kernel/syscalls/link/link07.c
+++ b/testcases/kernel/syscalls/link/link07.c
@@ -133,7 +133,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		test_desc = "EACCES";
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call link(2)
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index 15e584f..9f57364 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -226,7 +226,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			setup_every_copy();
diff --git a/testcases/kernel/syscalls/listen/listen01.c b/testcases/kernel/syscalls/listen/listen01.c
index 56e0fe0..8dccbdf 100644
--- a/testcases/kernel/syscalls/listen/listen01.c
+++ b/testcases/kernel/syscalls/listen/listen01.c
@@ -102,7 +102,7 @@ int main(int argc, char *argv[])
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/llseek/llseek01.c b/testcases/kernel/syscalls/llseek/llseek01.c
index be2c1f8..95df4fc 100644
--- a/testcases/kernel/syscalls/llseek/llseek01.c
+++ b/testcases/kernel/syscalls/llseek/llseek01.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * set file size limit, seek to a file using llseek.
diff --git a/testcases/kernel/syscalls/llseek/llseek02.c b/testcases/kernel/syscalls/llseek/llseek02.c
index 2f3a6f3..8dc39b5 100644
--- a/testcases/kernel/syscalls/llseek/llseek02.c
+++ b/testcases/kernel/syscalls/llseek/llseek02.c
@@ -141,7 +141,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			fildes = Test_cases[ind].fd;
diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index 0a10cdb..a16a28a 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -160,7 +160,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		offset = (lc % 100) * 4096;	/* max size is 100 blocks */
 
@@ -190,7 +190,7 @@ int main(int ac, char **av)
 						 Fname, offset, Whence[ind],
 						 TEST_RETURN);
 				} else
-					Tst_count++;
+					tst_count++;
 			}
 		}
 
diff --git a/testcases/kernel/syscalls/lseek/lseek02.c b/testcases/kernel/syscalls/lseek/lseek02.c
index 912c620..f30fba5 100644
--- a/testcases/kernel/syscalls/lseek/lseek02.c
+++ b/testcases/kernel/syscalls/lseek/lseek02.c
@@ -157,7 +157,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call lseek(2)
@@ -181,7 +181,7 @@ int main(int ac, char **av)
 						 strerror(TEST_ERRNO), EBADF);
 
 			} else
-				Tst_count++;
+				tst_count++;
 
 		} else {
 
diff --git a/testcases/kernel/syscalls/lseek/lseek03.c b/testcases/kernel/syscalls/lseek/lseek03.c
index d15b082..fc615c4 100644
--- a/testcases/kernel/syscalls/lseek/lseek03.c
+++ b/testcases/kernel/syscalls/lseek/lseek03.c
@@ -64,7 +64,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
@@ -89,7 +89,7 @@ int main(int ac, char **av)
 							 EINVAL);
 					}
 				} else {
-					Tst_count++;
+					tst_count++;
 				}
 			} else {
 				tst_resm(TFAIL, "lseek(%s, 1, %d) returned %ld",
diff --git a/testcases/kernel/syscalls/lseek/lseek04.c b/testcases/kernel/syscalls/lseek/lseek04.c
index 13959fb..028bc69 100644
--- a/testcases/kernel/syscalls/lseek/lseek04.c
+++ b/testcases/kernel/syscalls/lseek/lseek04.c
@@ -156,7 +156,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call lseek(2)
@@ -178,7 +178,7 @@ int main(int ac, char **av)
 						 TEST_ERRNO,
 						 strerror(TEST_ERRNO), EINVAL);
 			} else
-				Tst_count++;
+				tst_count++;
 		} else {
 
 			tst_resm(TFAIL,
diff --git a/testcases/kernel/syscalls/lseek/lseek05.c b/testcases/kernel/syscalls/lseek/lseek05.c
index decafb3..5c2a815 100644
--- a/testcases/kernel/syscalls/lseek/lseek05.c
+++ b/testcases/kernel/syscalls/lseek/lseek05.c
@@ -157,7 +157,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call lseek(2)
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 						 TEST_ERRNO,
 						 strerror(TEST_ERRNO), EINVAL);
 			} else
-				Tst_count++;
+				tst_count++;
 		} else {
 
 			tst_resm(TFAIL,
diff --git a/testcases/kernel/syscalls/lseek/lseek06.c b/testcases/kernel/syscalls/lseek/lseek06.c
index 96b3ce8..94f1105 100644
--- a/testcases/kernel/syscalls/lseek/lseek06.c
+++ b/testcases/kernel/syscalls/lseek/lseek06.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke lseek(2) to move the read/write file
diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index 32a8310..40e6259 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Set the offset position */
 		offset = file_size + (lc * strlen(write_buf2));
diff --git a/testcases/kernel/syscalls/lseek/lseek08.c b/testcases/kernel/syscalls/lseek/lseek08.c
index 6c8fd8e..b106bc9 100644
--- a/testcases/kernel/syscalls/lseek/lseek08.c
+++ b/testcases/kernel/syscalls/lseek/lseek08.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke lseek(2) to move the read/write file
diff --git a/testcases/kernel/syscalls/lseek/lseek09.c b/testcases/kernel/syscalls/lseek/lseek09.c
index c5eb7d3..409ba41 100644
--- a/testcases/kernel/syscalls/lseek/lseek09.c
+++ b/testcases/kernel/syscalls/lseek/lseek09.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke lseek(2) to set the file
diff --git a/testcases/kernel/syscalls/lseek/lseek10.c b/testcases/kernel/syscalls/lseek/lseek10.c
index 4ce9669..7213d4b 100644
--- a/testcases/kernel/syscalls/lseek/lseek10.c
+++ b/testcases/kernel/syscalls/lseek/lseek10.c
@@ -141,7 +141,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			fildes = Test_cases[ind].fd;
diff --git a/testcases/kernel/syscalls/lstat/lstat01.c b/testcases/kernel/syscalls/lstat/lstat01.c
index b55530a..1dc88a0 100644
--- a/testcases/kernel/syscalls/lstat/lstat01.c
+++ b/testcases/kernel/syscalls/lstat/lstat01.c
@@ -154,7 +154,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call lstat(2)
diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
index cf2dcbc..bece836 100644
--- a/testcases/kernel/syscalls/lstat/lstat02.c
+++ b/testcases/kernel/syscalls/lstat/lstat02.c
@@ -168,7 +168,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			file_name = Test_cases[ind].pathname;
diff --git a/testcases/kernel/syscalls/lstat/lstat03.c b/testcases/kernel/syscalls/lstat/lstat03.c
index 2dbf481..81a152a 100644
--- a/testcases/kernel/syscalls/lstat/lstat03.c
+++ b/testcases/kernel/syscalls/lstat/lstat03.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call lstat(2) to get the status of
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index fe0de10..fb6f8d9 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -113,7 +113,7 @@ int main(int argc, char *argv[])
 	sprintf(filename, "%s-out.%d", progname, getpid());
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 84e0321..cf029e2 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -130,7 +130,7 @@ int main(int argc, char *argv[])
 	sprintf(filename, "%s-out.%d", progname, getpid());
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index b0c17e8..916bfcf 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -75,7 +75,7 @@ int main(int argc, char *argv[])
 	sprintf(filename, "%s-out.%d", progname, getpid());
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
diff --git a/testcases/kernel/syscalls/madvise/madvise04.c b/testcases/kernel/syscalls/madvise/madvise04.c
index 8824256..5a376fc 100644
--- a/testcases/kernel/syscalls/madvise/madvise04.c
+++ b/testcases/kernel/syscalls/madvise/madvise04.c
@@ -67,7 +67,7 @@ int main(int argc, char *argv[])
 	sprintf(filename, "%s-out.%d", progname, getpid());
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = open(filename, O_RDWR | O_CREAT, 0664);
 		if (fd < 0)
diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index 75a9558..bac9bfe 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -59,7 +59,7 @@ char *TCID = "mallopt01";
 int block_number;
 FILE *temp;
 int TST_TOTAL = 1;
-extern int Tst_COUNT;		/* Test Case counter for tst_routines */
+extern int tst_COUNT;		/* Test Case counter for tst_routines */
 
 void printinfo();
 
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 84937cb..f3aff81 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -192,7 +192,7 @@ int main(int argc, char **argv)
 	testno = (int)(sizeof(tcase) / sizeof(tcase[0]));
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (i = 0; i < testno; i++) {
 			tst_resm(TINFO, "(case%02d) START", i);
 			ret = do_test(&tcase[i]);
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 3896001..c23e8b0 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -220,7 +220,7 @@ int main(int argc, char *argv[])
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		test_sane_nodes();
 		test_invalid_pid();
 		test_invalid_masksize();
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 1eadc49..49129e0 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -327,7 +327,7 @@ int main(int argc, char *argv[])
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		test_migrate_current_process(nodeA, nodeB, 1);
 		test_migrate_current_process(nodeA, nodeB, 0);
 		test_migrate_other_process(nodeA, nodeB, 1);
diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index 7d97bb8..779c52f 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -113,8 +113,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/mkdir/mkdir01.c b/testcases/kernel/syscalls/mkdir/mkdir01.c
index 296a202..872103b 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir01.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir01.c
@@ -138,7 +138,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE: 1
diff --git a/testcases/kernel/syscalls/mkdir/mkdir02.c b/testcases/kernel/syscalls/mkdir/mkdir02.c
index 2b1effd..f97ea9a 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir02.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir02.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* check the inherited group ID */
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 81e7d00..500ca6c 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -154,7 +154,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/mkdir/mkdir04.c b/testcases/kernel/syscalls/mkdir/mkdir04.c
index 12db2ea..5981dd5 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir04.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir04.c
@@ -126,7 +126,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Initialize the test directories name */
 		sprintf(tstdir1, "tstdir1.%d", getpid());
diff --git a/testcases/kernel/syscalls/mkdir/mkdir05.c b/testcases/kernel/syscalls/mkdir/mkdir05.c
index 6b97946..de2a6e9 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir05.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir05.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST mkdir() base functionality
diff --git a/testcases/kernel/syscalls/mkdir/mkdir08.c b/testcases/kernel/syscalls/mkdir/mkdir08.c
index d370282..e5e4fb7 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir08.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir08.c
@@ -153,7 +153,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mkdir(2)
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat01.c b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
index 508c960..ff3b62c 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat01.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
@@ -103,7 +103,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mkdirnat
diff --git a/testcases/kernel/syscalls/mknod/mknod01.c b/testcases/kernel/syscalls/mknod/mknod01.c
index e8d5691..1230587 100644
--- a/testcases/kernel/syscalls/mknod/mknod01.c
+++ b/testcases/kernel/syscalls/mknod/mknod01.c
@@ -174,7 +174,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASES:
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index f53ec18..4a0a9c7 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Attempt to create a filesystem node with group-id bit set
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index d647d4f..4d5663a 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Attempt to create a filesystem node with group id (sgid)
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index a26be9d..db6fcec 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE CONDITION:
diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index 2862f9a..fabe527 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Attempt to create a filesystem node with group id (sgid)
diff --git a/testcases/kernel/syscalls/mknod/mknod06.c b/testcases/kernel/syscalls/mknod/mknod06.c
index 5a7995f..fb289a5 100644
--- a/testcases/kernel/syscalls/mknod/mknod06.c
+++ b/testcases/kernel/syscalls/mknod/mknod06.c
@@ -158,7 +158,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			node_name = Test_cases[ind].pathname;
diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index 7aa2e17..e7a6fc8 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			node_name = test_cases[i].pathname;
diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
index cb28f6a..9369cb9 100644
--- a/testcases/kernel/syscalls/mknod/mknod08.c
+++ b/testcases/kernel/syscalls/mknod/mknod08.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mknod() to creat a node on a directory without
diff --git a/testcases/kernel/syscalls/mknod/mknod09.c b/testcases/kernel/syscalls/mknod/mknod09.c
index 081137e..8398ba7 100644
--- a/testcases/kernel/syscalls/mknod/mknod09.c
+++ b/testcases/kernel/syscalls/mknod/mknod09.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		test_desc = "EINVAL";
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mknod(2) to test condition.
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index 6cce851..be54e48 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mknodat
diff --git a/testcases/kernel/syscalls/mlock/mlock01.c b/testcases/kernel/syscalls/mlock/mlock01.c
index 958230d..d4a989c 100644
--- a/testcases/kernel/syscalls/mlock/mlock01.c
+++ b/testcases/kernel/syscalls/mlock/mlock01.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index c272b60..a0062a3 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -92,7 +92,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/mlockall/mlockall01.c b/testcases/kernel/syscalls/mlockall/mlockall01.c
index 0cd8fb6..97cc171 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall01.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall01.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index 29e7787..5ddb3a5 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index 909bdc5..ff4d8a4 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -142,7 +142,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
index 3b1d82e..6be11e3 100644
--- a/testcases/kernel/syscalls/mmap/mmap001.c
+++ b/testcases/kernel/syscalls/mmap/mmap001.c
@@ -120,7 +120,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = open(filename, O_RDWR | O_CREAT, 0666);
 		if ((fd == -1))
diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index e3268c6..de1d694 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file beyond EOF
diff --git a/testcases/kernel/syscalls/mmap/mmap02.c b/testcases/kernel/syscalls/mmap/mmap02.c
index e6fcfc0..b03dbf9 100644
--- a/testcases/kernel/syscalls/mmap/mmap02.c
+++ b/testcases/kernel/syscalls/mmap/mmap02.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file 'TEMPFILE'
diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
index e732930..70416b9 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file 'TEMPFILE'
diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
index f48b3b5..e133331 100644
--- a/testcases/kernel/syscalls/mmap/mmap04.c
+++ b/testcases/kernel/syscalls/mmap/mmap04.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file 'TEMPFILE'
diff --git a/testcases/kernel/syscalls/mmap/mmap05.c b/testcases/kernel/syscalls/mmap/mmap05.c
index c4d9223..44ac2ca 100644
--- a/testcases/kernel/syscalls/mmap/mmap05.c
+++ b/testcases/kernel/syscalls/mmap/mmap05.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file 'TEMPFILE'
diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index cd6c0ec..b18a91c 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file 'TEMPFILE'
diff --git a/testcases/kernel/syscalls/mmap/mmap07.c b/testcases/kernel/syscalls/mmap/mmap07.c
index ace83d4..49de352 100644
--- a/testcases/kernel/syscalls/mmap/mmap07.c
+++ b/testcases/kernel/syscalls/mmap/mmap07.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file 'TEMPFILE'
diff --git a/testcases/kernel/syscalls/mmap/mmap08.c b/testcases/kernel/syscalls/mmap/mmap08.c
index d7239ac..44fa45a 100644
--- a/testcases/kernel/syscalls/mmap/mmap08.c
+++ b/testcases/kernel/syscalls/mmap/mmap08.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call mmap to map the temporary file 'TEMPFILE'
diff --git a/testcases/kernel/syscalls/mmap/mmap09.c b/testcases/kernel/syscalls/mmap/mmap09.c
index 61861e3..03e3141 100644
--- a/testcases/kernel/syscalls/mmap/mmap09.c
+++ b/testcases/kernel/syscalls/mmap/mmap09.c
@@ -93,7 +93,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(ftruncate(fd, TC[i].newsize));
 
diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
index 7dee7d0..16ad299 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -112,7 +112,7 @@ int main(int argc, char *argv[])
 
 	tst_resm(TINFO, "start tests.");
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		mmapzero();
 	}
 
diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
index 46f97eb..ffa0a01 100644
--- a/testcases/kernel/syscalls/mmap/mmap11.c
+++ b/testcases/kernel/syscalls/mmap/mmap11.c
@@ -111,7 +111,7 @@ void check(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		ret = pthread_create(&th, &attr, wait_thread, NULL);
 		if (ret) {
 			tst_resm(TINFO, "[%d] ", count);
diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
index bdcc131..cba302d 100644
--- a/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
+++ b/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
@@ -112,8 +112,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //block1:
 		/*
diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
index 71e0a0b..fa4ce26 100644
--- a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
+++ b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
@@ -108,8 +108,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //block1:
 		tst_resm(TINFO, "Enter block 1");
diff --git a/testcases/kernel/syscalls/mount/mount01.c b/testcases/kernel/syscalls/mount/mount01.c
index e268c35..78afdf2 100644
--- a/testcases/kernel/syscalls/mount/mount01.c
+++ b/testcases/kernel/syscalls/mount/mount01.c
@@ -141,7 +141,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Call mount(2) */
 		TEST(mount(device, mntpoint, Fstype, 0, NULL));
diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index 7423517..e5398a1 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -172,7 +172,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index adb20c8..0b4aead 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -184,7 +184,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/mount/mount04.c b/testcases/kernel/syscalls/mount/mount04.c
index e8c155b..e58f350 100644
--- a/testcases/kernel/syscalls/mount/mount04.c
+++ b/testcases/kernel/syscalls/mount/mount04.c
@@ -159,7 +159,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages01.c b/testcases/kernel/syscalls/move_pages/move_pages01.c
index baaeefe..df4ec70 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages01.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages01.c
@@ -87,8 +87,8 @@ int main(int argc, char **argv)
 		int status[TEST_PAGES];
 		int ret;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_linear(pages, TEST_PAGES);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index 062d263..ddd0e38 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -96,8 +96,8 @@ int main(int argc, char **argv)
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index 910b89c..5c26748 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -137,8 +137,8 @@ int main(int argc, char **argv)
 		pid_t cpid;
 		sem_t *sem;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_shared_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 9a52f68..4ceca0d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -103,8 +103,8 @@ int main(int argc, char **argv)
 		int status[TEST_PAGES];
 		unsigned long onepage = get_page_size();
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_on_node(pages, TOUCHED_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index 5ffa3bc..11c0bc1 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -138,8 +138,8 @@ int main(int argc, char **argv)
 		pid_t cpid;
 		sem_t *sem;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_shared_pages_on_node(pages + SHARED_PAGE,
 						 N_SHARED_PAGES, from_node);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 95363b7..54c4387 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -96,8 +96,8 @@ int main(int argc, char **argv)
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index d4ab668..cb0772e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -97,8 +97,8 @@ int main(int argc, char **argv)
 		int status[TEST_PAGES];
 		int ipid;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index 4c541a6..159a6ea 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -94,8 +94,8 @@ int main(int argc, char **argv)
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 25caccb..53d2189 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -93,8 +93,8 @@ int main(int argc, char **argv)
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index fa700c4..7880ae9 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -96,8 +96,8 @@ int main(int argc, char **argv)
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index e5c2ceb..094d548 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -137,8 +137,8 @@ int main(int argc, char **argv)
 		pid_t cpid;
 		sem_t *sem;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = alloc_shared_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
index 3ca15e4..ccf4cab 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect01.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
@@ -130,8 +130,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index 99040fa..0a9492f 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -89,7 +89,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		fd = SAFE_OPEN(cleanup, file1, O_RDWR | O_CREAT, 0777);
 
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index 252b214..0174418 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -93,8 +93,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((fd = open(file1, O_RDWR | O_CREAT, 0777)) < 0) {	//mode must be specified when O_CREAT is in the flag
 			tst_brkm(TBROK, cleanup, "open failed");
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 3acd0d2..370514a 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -408,7 +408,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST(c = getopt_long(ac, av, "dh", long_options, NULL));
 			while (TEST_RETURN != -1) {
diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
index d7bd4ba..170f7f7 100644
--- a/testcases/kernel/syscalls/mq_open/mq_open01.c
+++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
@@ -407,7 +407,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			/*
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 217ef81..f2c73be 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -451,7 +451,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			/*
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index f60297c..3b0c924 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -454,7 +454,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			/*
diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index 26dd307..0eac266 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -280,7 +280,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			int ret;
diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
index a92c462..47d67bf 100644
--- a/testcases/kernel/syscalls/mremap/mremap01.c
+++ b/testcases/kernel/syscalls/mremap/mremap01.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	setup();
 
diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
index 47aa2f4..24ae505 100644
--- a/testcases/kernel/syscalls/mremap/mremap02.c
+++ b/testcases/kernel/syscalls/mremap/mremap02.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Attempt to expand the existing mapped
diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
index 627784d..e579557 100644
--- a/testcases/kernel/syscalls/mremap/mremap03.c
+++ b/testcases/kernel/syscalls/mremap/mremap03.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Attempt to expand the existing mapped
diff --git a/testcases/kernel/syscalls/mremap/mremap04.c b/testcases/kernel/syscalls/mremap/mremap04.c
index 25a4f62..07ab6f5 100644
--- a/testcases/kernel/syscalls/mremap/mremap04.c
+++ b/testcases/kernel/syscalls/mremap/mremap04.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Attempt to expand the existing shared
diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index 07ec49f..d6d8fb1 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -224,7 +224,7 @@ int main(int ac, char **av)
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; testno++) {
 			tdat[testno].setup(&tdat[testno]);
 			test_mremap(&tdat[testno]);
diff --git a/testcases/kernel/syscalls/msync/msync01.c b/testcases/kernel/syscalls/msync/msync01.c
index 2454489..0d3b895 100644
--- a/testcases/kernel/syscalls/msync/msync01.c
+++ b/testcases/kernel/syscalls/msync/msync01.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		setup();
 
diff --git a/testcases/kernel/syscalls/msync/msync02.c b/testcases/kernel/syscalls/msync/msync02.c
index 7988208..48cd499 100644
--- a/testcases/kernel/syscalls/msync/msync02.c
+++ b/testcases/kernel/syscalls/msync/msync02.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	TEST(msync(addr, page_sz, MS_INVALIDATE));
 
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index 7f109f5..68fe63e 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(msync(addr, page_sz, MS_ASYNC));
 
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 5a0302c..07f40bb 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 {
 	TEST_EXP_ENOS(exp_enos);
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	setup();
 
diff --git a/testcases/kernel/syscalls/msync/msync05.c b/testcases/kernel/syscalls/msync/msync05.c
index ef1e084..9a91e05 100644
--- a/testcases/kernel/syscalls/msync/msync05.c
+++ b/testcases/kernel/syscalls/msync/msync05.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(msync(addr, page_sz, MS_SYNC));
 
diff --git a/testcases/kernel/syscalls/munlock/munlock01.c b/testcases/kernel/syscalls/munlock/munlock01.c
index a92c5a4..38edbe6 100644
--- a/testcases/kernel/syscalls/munlock/munlock01.c
+++ b/testcases/kernel/syscalls/munlock/munlock01.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/munlock/munlock02.c b/testcases/kernel/syscalls/munlock/munlock02.c
index 96567b3..040c7d1 100644
--- a/testcases/kernel/syscalls/munlock/munlock02.c
+++ b/testcases/kernel/syscalls/munlock/munlock02.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 		for (i = 0; i < TST_TOTAL; i++) {
 #ifdef __ia64__
 			TC[0].len = 8 * getpagesize();
diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index 7120576..3412a87 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -90,7 +90,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(munlockall());
 
diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcases/kernel/syscalls/munlockall/munlockall02.c
index 639554c..0f8827a 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall02.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(munlockall());
 
diff --git a/testcases/kernel/syscalls/munmap/munmap01.c b/testcases/kernel/syscalls/munmap/munmap01.c
index 61c07cd..2110684 100644
--- a/testcases/kernel/syscalls/munmap/munmap01.c
+++ b/testcases/kernel/syscalls/munmap/munmap01.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		setup();
 
diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
index e269765..5829913 100644
--- a/testcases/kernel/syscalls/munmap/munmap02.c
+++ b/testcases/kernel/syscalls/munmap/munmap02.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		setup();
 
diff --git a/testcases/kernel/syscalls/munmap/munmap03.c b/testcases/kernel/syscalls/munmap/munmap03.c
index 39b6f62..937da60 100644
--- a/testcases/kernel/syscalls/munmap/munmap03.c
+++ b/testcases/kernel/syscalls/munmap/munmap03.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		setup();
 
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index 6cc3e7a..6b616bd 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Creat a child process and suspend it till
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep02.c b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
index aa02427..65cc433 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep02.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep02.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Creat a child process and suspend its
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep03.c b/testcases/kernel/syscalls/nanosleep/nanosleep03.c
index d9fed11..2928277 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep03.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep03.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Creat a child process and suspend its
diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep04.c b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
index de79352..62f695e 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep04.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Creat a child process and suspend its
diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index cc5c61a..a36bc28 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -123,7 +123,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST(ltp_syscall(__NR_uname, &name));
 			if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/syscalls/nice/nice01.c b/testcases/kernel/syscalls/nice/nice01.c
index 8c3fe44..5f75698 100644
--- a/testcases/kernel/syscalls/nice/nice01.c
+++ b/testcases/kernel/syscalls/nice/nice01.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call nice(2) with an 'incr' parameter set
diff --git a/testcases/kernel/syscalls/nice/nice02.c b/testcases/kernel/syscalls/nice/nice02.c
index f9263c6..87cf073 100644
--- a/testcases/kernel/syscalls/nice/nice02.c
+++ b/testcases/kernel/syscalls/nice/nice02.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call nice(2) with an 'incr' parameter set
diff --git a/testcases/kernel/syscalls/nice/nice03.c b/testcases/kernel/syscalls/nice/nice03.c
index 2f1c97a..4591781 100644
--- a/testcases/kernel/syscalls/nice/nice03.c
+++ b/testcases/kernel/syscalls/nice/nice03.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call nice(2) with an 'incr' parameter set
diff --git a/testcases/kernel/syscalls/nice/nice04.c b/testcases/kernel/syscalls/nice/nice04.c
index 5413454..77d0590 100644
--- a/testcases/kernel/syscalls/nice/nice04.c
+++ b/testcases/kernel/syscalls/nice/nice04.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			incr_val = Test_cases[i].nice_val;
diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
index c0d9602..c951605 100644
--- a/testcases/kernel/syscalls/nice/nice05.c
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -148,7 +148,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		val = lc % 39;
 		/*
diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index fe8be43..5ec513f 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -86,7 +86,7 @@ int main(int ac, char **av)
 	 * check looping state if -i option given on the command line
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;	/* reset Tst_count while looping. */
+		tst_count = 0;	/* reset tst_count while looping. */
 
 		/* test #1 */
 		TEST(open(pfilname, O_RDWR | O_CREAT, 01444));
diff --git a/testcases/kernel/syscalls/open/open02.c b/testcases/kernel/syscalls/open/open02.c
index 877ac65..a0521a9 100644
--- a/testcases/kernel/syscalls/open/open02.c
+++ b/testcases/kernel/syscalls/open/open02.c
@@ -80,7 +80,7 @@ int main(int ac, char **av)
 	 * check looping state if -i option given on the command line
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;	/* reset Tst_count while looping. */
+		tst_count = 0;	/* reset tst_count while looping. */
 
 		TEST(open(pfilname, O_RDWR, 0444));
 
diff --git a/testcases/kernel/syscalls/open/open03.c b/testcases/kernel/syscalls/open/open03.c
index b47d8a4..b452967 100644
--- a/testcases/kernel/syscalls/open/open03.c
+++ b/testcases/kernel/syscalls/open/open03.c
@@ -59,7 +59,7 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(open(fname, O_RDWR | O_CREAT, 0700));
 		fd = TEST_RETURN;
diff --git a/testcases/kernel/syscalls/open/open04.c b/testcases/kernel/syscalls/open/open04.c
index 0eb00ed..154612b 100644
--- a/testcases/kernel/syscalls/open/open04.c
+++ b/testcases/kernel/syscalls/open/open04.c
@@ -63,7 +63,7 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(open(fname, O_RDWR | O_CREAT, 0777));
 
diff --git a/testcases/kernel/syscalls/open/open05.c b/testcases/kernel/syscalls/open/open05.c
index b18f29d..4623895 100644
--- a/testcases/kernel/syscalls/open/open05.c
+++ b/testcases/kernel/syscalls/open/open05.c
@@ -67,8 +67,8 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		pid = FORK_OR_VFORK();
 		if (pid == -1)
diff --git a/testcases/kernel/syscalls/open/open06.c b/testcases/kernel/syscalls/open/open06.c
index fc6c093..afb7708 100644
--- a/testcases/kernel/syscalls/open/open06.c
+++ b/testcases/kernel/syscalls/open/open06.c
@@ -58,7 +58,7 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(open(fname, O_NONBLOCK | O_WRONLY));
 		if (TEST_RETURN != -1) {
diff --git a/testcases/kernel/syscalls/open/open07.c b/testcases/kernel/syscalls/open/open07.c
index 373691a..4d9522f 100644
--- a/testcases/kernel/syscalls/open/open07.c
+++ b/testcases/kernel/syscalls/open/open07.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 	}
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; TC[i].desc != NULL; ++i) {
 			TEST(open(TC[i].filename, TC[i].flags, TC[i].mode));
diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 0e94d92..25a238a 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -108,7 +108,7 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(open(TC[i].fname, TC[i].flags,
diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index 2280b96..1417393 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call openat
diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
index 1a09a12..a675fe2 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf01.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
@@ -178,7 +178,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
index 23e2b8b..7753398 100644
--- a/testcases/kernel/syscalls/pause/pause01.c
+++ b/testcases/kernel/syscalls/pause/pause01.c
@@ -148,7 +148,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		(void)signal(SIGALRM, go);
 		alarm(1);
diff --git a/testcases/kernel/syscalls/pause/pause02.c b/testcases/kernel/syscalls/pause/pause02.c
index f3c2335..b5c9a2c 100644
--- a/testcases/kernel/syscalls/pause/pause02.c
+++ b/testcases/kernel/syscalls/pause/pause02.c
@@ -57,7 +57,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		cpid = FORK_OR_VFORK();
 		switch (cpid) {
diff --git a/testcases/kernel/syscalls/pause/pause03.c b/testcases/kernel/syscalls/pause/pause03.c
index f040517..fd650e1 100644
--- a/testcases/kernel/syscalls/pause/pause03.c
+++ b/testcases/kernel/syscalls/pause/pause03.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Creat a new process using fork() */
 		if ((cpid = FORK_OR_VFORK()) == -1) {
diff --git a/testcases/kernel/syscalls/personality/personality01.c b/testcases/kernel/syscalls/personality/personality01.c
index 969e7cb..c8a0948 100644
--- a/testcases/kernel/syscalls/personality/personality01.c
+++ b/testcases/kernel/syscalls/personality/personality01.c
@@ -94,8 +94,8 @@ int main(int ac, char **av)
 	/* The following checks the looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Start looping through our series of personalities and
diff --git a/testcases/kernel/syscalls/personality/personality02.c b/testcases/kernel/syscalls/personality/personality02.c
index cbead84..b868500 100644
--- a/testcases/kernel/syscalls/personality/personality02.c
+++ b/testcases/kernel/syscalls/personality/personality02.c
@@ -99,8 +99,8 @@ int main(int ac, char **av)
 	/* The following checks the looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(personality(PER_BAD));
 
diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index a70c03d..dfdaf9e 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -83,8 +83,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(pipe(fildes));
 
diff --git a/testcases/kernel/syscalls/pipe/pipe02.c b/testcases/kernel/syscalls/pipe/pipe02.c
index e90dd54..35a9ee1 100644
--- a/testcases/kernel/syscalls/pipe/pipe02.c
+++ b/testcases/kernel/syscalls/pipe/pipe02.c
@@ -99,8 +99,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = pipe(pp);
 		if (ret == -1)
diff --git a/testcases/kernel/syscalls/pipe/pipe03.c b/testcases/kernel/syscalls/pipe/pipe03.c
index 17ec779..6a93f3f 100644
--- a/testcases/kernel/syscalls/pipe/pipe03.c
+++ b/testcases/kernel/syscalls/pipe/pipe03.c
@@ -81,8 +81,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(pipe(fildes));
 
diff --git a/testcases/kernel/syscalls/pipe/pipe04.c b/testcases/kernel/syscalls/pipe/pipe04.c
index f67c350..30c0308 100644
--- a/testcases/kernel/syscalls/pipe/pipe04.c
+++ b/testcases/kernel/syscalls/pipe/pipe04.c
@@ -97,8 +97,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if (pipe(fildes) == -1)
 			tst_brkm(TBROK, cleanup, "pipe() failed - errno %d",
diff --git a/testcases/kernel/syscalls/pipe/pipe05.c b/testcases/kernel/syscalls/pipe/pipe05.c
index 344640f..33982db 100644
--- a/testcases/kernel/syscalls/pipe/pipe05.c
+++ b/testcases/kernel/syscalls/pipe/pipe05.c
@@ -75,8 +75,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		/* special sig11 case */
 		sa.sa_handler = &sig11_handler;
 		sigemptyset(&sa.sa_mask);
diff --git a/testcases/kernel/syscalls/pipe/pipe06.c b/testcases/kernel/syscalls/pipe/pipe06.c
index 43243dc..12a4d04 100644
--- a/testcases/kernel/syscalls/pipe/pipe06.c
+++ b/testcases/kernel/syscalls/pipe/pipe06.c
@@ -71,8 +71,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(pipe(pipes));
 
diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
index 32df083..c774870 100644
--- a/testcases/kernel/syscalls/pipe/pipe07.c
+++ b/testcases/kernel/syscalls/pipe/pipe07.c
@@ -96,8 +96,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		min = getdtablesize();
 
diff --git a/testcases/kernel/syscalls/pipe/pipe08.c b/testcases/kernel/syscalls/pipe/pipe08.c
index fd94fa1..c0c8cc6 100644
--- a/testcases/kernel/syscalls/pipe/pipe08.c
+++ b/testcases/kernel/syscalls/pipe/pipe08.c
@@ -82,8 +82,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(pipe(pipefd));
 
diff --git a/testcases/kernel/syscalls/pipe/pipe09.c b/testcases/kernel/syscalls/pipe/pipe09.c
index 38763cc..f831f17 100644
--- a/testcases/kernel/syscalls/pipe/pipe09.c
+++ b/testcases/kernel/syscalls/pipe/pipe09.c
@@ -90,8 +90,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(pipe(pipefd));
 
diff --git a/testcases/kernel/syscalls/pipe/pipe10.c b/testcases/kernel/syscalls/pipe/pipe10.c
index 11576ab..aefcc94 100644
--- a/testcases/kernel/syscalls/pipe/pipe10.c
+++ b/testcases/kernel/syscalls/pipe/pipe10.c
@@ -86,8 +86,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(pipe(fd));
 
diff --git a/testcases/kernel/syscalls/pipe/pipe11.c b/testcases/kernel/syscalls/pipe/pipe11.c
index f2daabe..fb49c1f 100644
--- a/testcases/kernel/syscalls/pipe/pipe11.c
+++ b/testcases/kernel/syscalls/pipe/pipe11.c
@@ -106,8 +106,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(pipe(fd));
 
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_01.c b/testcases/kernel/syscalls/pipe2/pipe2_01.c
index 5601c73..a5fd112 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_01.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_01.c
@@ -155,7 +155,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			if (ltp_syscall(__NR_pipe2, fd, 0) != 0) {
 				tst_resm(TFAIL, "pipe2(0) failed");
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c b/testcases/kernel/syscalls/pipe2/pipe2_02.c
index f172480..b64f5e6 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_02.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_02.c
@@ -146,7 +146,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			if (ltp_syscall(__NR_pipe2, fds, 0) == -1) {
 				tst_resm(TFAIL, "pipe2(0) failed");
diff --git a/testcases/kernel/syscalls/poll/poll01.c b/testcases/kernel/syscalls/poll/poll01.c
index a93ce95..5a3083a 100644
--- a/testcases/kernel/syscalls/poll/poll01.c
+++ b/testcases/kernel/syscalls/poll/poll01.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call poll() with the TEST macro.
diff --git a/testcases/kernel/syscalls/prctl/prctl01.c b/testcases/kernel/syscalls/prctl/prctl01.c
index 220789c..d24e222 100644
--- a/testcases/kernel/syscalls/prctl/prctl01.c
+++ b/testcases/kernel/syscalls/prctl/prctl01.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index a1029f6..28ee575 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/pread/pread01.c b/testcases/kernel/syscalls/pread/pread01.c
index ba71039..b7bb036 100644
--- a/testcases/kernel/syscalls/pread/pread01.c
+++ b/testcases/kernel/syscalls/pread/pread01.c
@@ -112,8 +112,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* Reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* Reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Call pread() of K1 data (should be 2's) at offset K2.
diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
index 2d986b6..3b6fdd0 100644
--- a/testcases/kernel/syscalls/pread/pread02.c
+++ b/testcases/kernel/syscalls/pread/pread02.c
@@ -129,7 +129,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; Test_cases[i].desc != NULL; i++) {
diff --git a/testcases/kernel/syscalls/pread/pread03.c b/testcases/kernel/syscalls/pread/pread03.c
index 4a24a1f..0a5ab0e 100644
--- a/testcases/kernel/syscalls/pread/pread03.c
+++ b/testcases/kernel/syscalls/pread/pread03.c
@@ -115,8 +115,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		test_desc = "EISDIR";
 		nbytes = K1;
diff --git a/testcases/kernel/syscalls/ptrace/ptrace01.c b/testcases/kernel/syscalls/ptrace/ptrace01.c
index bde0211..7c1facc 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace01.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace01.c
@@ -129,7 +129,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			got_signal = 0;
diff --git a/testcases/kernel/syscalls/ptrace/ptrace02.c b/testcases/kernel/syscalls/ptrace/ptrace02.c
index ac51d82..7e5c598 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace02.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace02.c
@@ -129,7 +129,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			got_signal = 0;
diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index 55a385e..c6d7c7c 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
@@ -129,7 +129,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
index a87f87c..e4e7079 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite01.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call pwrite() to write K1 bytes of data (0's) at offset 0
diff --git a/testcases/kernel/syscalls/pwrite/pwrite02.c b/testcases/kernel/syscalls/pwrite/pwrite02.c
index b1958d3..11b7f3f 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite02.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite02.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; Test_cases[i].desc != NULL; i++) {
 			fildes = Test_cases[i].fd;
diff --git a/testcases/kernel/syscalls/pwrite/pwrite03.c b/testcases/kernel/syscalls/pwrite/pwrite03.c
index 124f5a5..726f589 100644
--- a/testcases/kernel/syscalls/pwrite/pwrite03.c
+++ b/testcases/kernel/syscalls/pwrite/pwrite03.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		test_desc = "EFAULT";
 		nbytes = 1024;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index f90ec9b..6734903 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -234,7 +234,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index d0d2ecc..7401e09 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -164,7 +164,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (write(fd, s, READ_BLOCK_SIZE) == -1) {
 			tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 78855b3..8681662 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -122,8 +122,8 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -i option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/read/read03.c b/testcases/kernel/syscalls/read/read03.c
index 483ae76..1b44db4 100644
--- a/testcases/kernel/syscalls/read/read03.c
+++ b/testcases/kernel/syscalls/read/read03.c
@@ -83,8 +83,8 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -i option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(read(rfd, &c, 1));
 
diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
index 6f826ef..ffdf6d9 100644
--- a/testcases/kernel/syscalls/read/read04.c
+++ b/testcases/kernel/syscalls/read/read04.c
@@ -83,7 +83,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;	/* reset Tst_count while looping */
+		tst_count = 0;	/* reset tst_count while looping */
 
 		if ((rfild = open(fname, O_RDONLY)) == -1) {
 			tst_brkm(TBROK, cleanup, "can't open for reading");
diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
index 71ecdb2..ff50b2d 100644
--- a/testcases/kernel/syscalls/readahead/readahead01.c
+++ b/testcases/kernel/syscalls/readahead/readahead01.c
@@ -138,7 +138,7 @@ int main(int argc, char *argv[])
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		test_bad_fd();
 		test_invalid_fd();
 	}
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 5ce2a33..66158f0 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -336,7 +336,7 @@ int main(int argc, char *argv[])
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		test_readahead();
 	}
 	cleanup();
diff --git a/testcases/kernel/syscalls/readdir/readdir01.c b/testcases/kernel/syscalls/readdir/readdir01.c
index a5b6cf7..4829f34 100644
--- a/testcases/kernel/syscalls/readdir/readdir01.c
+++ b/testcases/kernel/syscalls/readdir/readdir01.c
@@ -208,7 +208,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (Nfiles)
 			nfiles = Nfiles;
diff --git a/testcases/kernel/syscalls/readdir/readdir02.c b/testcases/kernel/syscalls/readdir/readdir02.c
index 67d7a3a..175516e 100644
--- a/testcases/kernel/syscalls/readdir/readdir02.c
+++ b/testcases/kernel/syscalls/readdir/readdir02.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((test_dir = opendir(".")) == NULL) {
 			tst_resm(TFAIL, "opendir(\".\") Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index ae85579..2fc9af2 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call readlink(2) to read the contents of
diff --git a/testcases/kernel/syscalls/readlink/readlink02.c b/testcases/kernel/syscalls/readlink/readlink02.c
index b02d991..d108a9a 100644
--- a/testcases/kernel/syscalls/readlink/readlink02.c
+++ b/testcases/kernel/syscalls/readlink/readlink02.c
@@ -152,7 +152,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call readlink(2)
diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
index 75fc610..3582104 100644
--- a/testcases/kernel/syscalls/readlink/readlink03.c
+++ b/testcases/kernel/syscalls/readlink/readlink03.c
@@ -162,7 +162,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; Test_cases[i].desc != NULL; i++) {
 			sym_file = Test_cases[i].link;
diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
index abb43a0..a6a41bc 100644
--- a/testcases/kernel/syscalls/readlink/readlink04.c
+++ b/testcases/kernel/syscalls/readlink/readlink04.c
@@ -67,7 +67,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call readlink(2) to read the contents of
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index e1aeca5..aa3d0ca 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call readlinkat
diff --git a/testcases/kernel/syscalls/readv/readv01.c b/testcases/kernel/syscalls/readv/readv01.c
index 25327da..d92c1be 100644
--- a/testcases/kernel/syscalls/readv/readv01.c
+++ b/testcases/kernel/syscalls/readv/readv01.c
@@ -98,8 +98,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //test1:
 		l_seek(fd, CHUNK * 11, 0);
diff --git a/testcases/kernel/syscalls/readv/readv02.c b/testcases/kernel/syscalls/readv/readv02.c
index 34b3257..d97e4b5 100644
--- a/testcases/kernel/syscalls/readv/readv02.c
+++ b/testcases/kernel/syscalls/readv/readv02.c
@@ -113,8 +113,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //test1:
 		if (readv(fd[0], rd_iovec, 1) < 0) {
diff --git a/testcases/kernel/syscalls/readv/readv03.c b/testcases/kernel/syscalls/readv/readv03.c
index c5e926d..4076c0c 100644
--- a/testcases/kernel/syscalls/readv/readv03.c
+++ b/testcases/kernel/syscalls/readv/readv03.c
@@ -90,8 +90,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if (readv(fd, rd_iovec, 1) < 0) {
 			if (errno != EISDIR) {
diff --git a/testcases/kernel/syscalls/reboot/reboot01.c b/testcases/kernel/syscalls/reboot/reboot01.c
index f5fdbcd..2059630 100644
--- a/testcases/kernel/syscalls/reboot/reboot01.c
+++ b/testcases/kernel/syscalls/reboot/reboot01.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/reboot/reboot02.c b/testcases/kernel/syscalls/reboot/reboot02.c
index 2096846..8e76579 100644
--- a/testcases/kernel/syscalls/reboot/reboot02.c
+++ b/testcases/kernel/syscalls/reboot/reboot02.c
@@ -117,7 +117,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			Tst_count = 0;
+			tst_count = 0;
 			if (i == 0) {
 				TEST(reboot(INVALID_PARAMETER));
 			} else {
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index a1a7755..746c508 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index c0c0fc9..14b280a 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -146,7 +146,7 @@ int main(int argc, char *argv[])
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 996772f..48e258d 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -213,7 +213,7 @@ int main(int argc, char *argv[])
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
index 8b08be8..bf20768 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages01.c
@@ -132,7 +132,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		test_nonlinear(fd1);
 		tst_resm(TPASS, "Non-Linear shm file OK");
diff --git a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
index 747a645..b543957 100644
--- a/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
+++ b/testcases/kernel/syscalls/remap_file_pages/remap_file_pages02.c
@@ -151,7 +151,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* do the setup if the test have one */
diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index 4c7756e..2945cac 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/rename/rename02.c b/testcases/kernel/syscalls/rename/rename02.c
index 6c3844f..4895be8 100644
--- a/testcases/kernel/syscalls/rename/rename02.c
+++ b/testcases/kernel/syscalls/rename/rename02.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call rename(2)
diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
index 7ed8f9f..e30de45 100644
--- a/testcases/kernel/syscalls/rename/rename03.c
+++ b/testcases/kernel/syscalls/rename/rename03.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* set up the files and directories for the tests */
 		setup2();
diff --git a/testcases/kernel/syscalls/rename/rename04.c b/testcases/kernel/syscalls/rename/rename04.c
index 3a56628..6c66c3c 100644
--- a/testcases/kernel/syscalls/rename/rename04.c
+++ b/testcases/kernel/syscalls/rename/rename04.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* rename a directory to a non-empty directory */
 
diff --git a/testcases/kernel/syscalls/rename/rename05.c b/testcases/kernel/syscalls/rename/rename05.c
index 6246018..5cfa174 100644
--- a/testcases/kernel/syscalls/rename/rename05.c
+++ b/testcases/kernel/syscalls/rename/rename05.c
@@ -103,7 +103,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* attempt to rename a file to a directory */
 		/* Call rename(2) */
diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
index d11018a..383abd4 100644
--- a/testcases/kernel/syscalls/rename/rename06.c
+++ b/testcases/kernel/syscalls/rename/rename06.c
@@ -104,7 +104,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* rename a directory to a subdirectory of itself */
 		/* Call rename(2) */
diff --git a/testcases/kernel/syscalls/rename/rename07.c b/testcases/kernel/syscalls/rename/rename07.c
index 8d0e725..a4e4b26 100644
--- a/testcases/kernel/syscalls/rename/rename07.c
+++ b/testcases/kernel/syscalls/rename/rename07.c
@@ -86,7 +86,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* rename a directory to a file */
 		/* Call rename(2) */
diff --git a/testcases/kernel/syscalls/rename/rename08.c b/testcases/kernel/syscalls/rename/rename08.c
index 102fbb9..bc24f84 100644
--- a/testcases/kernel/syscalls/rename/rename08.c
+++ b/testcases/kernel/syscalls/rename/rename08.c
@@ -128,7 +128,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/rename/rename09.c b/testcases/kernel/syscalls/rename/rename09.c
index 3ed3a22..c75c662 100644
--- a/testcases/kernel/syscalls/rename/rename09.c
+++ b/testcases/kernel/syscalls/rename/rename09.c
@@ -127,7 +127,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() #1 failed");
diff --git a/testcases/kernel/syscalls/rename/rename10.c b/testcases/kernel/syscalls/rename/rename10.c
index e3da1a6..5a5ae81 100644
--- a/testcases/kernel/syscalls/rename/rename10.c
+++ b/testcases/kernel/syscalls/rename/rename10.c
@@ -121,7 +121,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
index 443b921..85d5555 100644
--- a/testcases/kernel/syscalls/rename/rename12.c
+++ b/testcases/kernel/syscalls/rename/rename12.c
@@ -121,7 +121,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * rename a file whose parent directory has
diff --git a/testcases/kernel/syscalls/rename/rename13.c b/testcases/kernel/syscalls/rename/rename13.c
index 995f924..24ae2a6 100644
--- a/testcases/kernel/syscalls/rename/rename13.c
+++ b/testcases/kernel/syscalls/rename/rename13.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST rename()works when
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index fc89b0a..79c8c1e 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call renameat
diff --git a/testcases/kernel/syscalls/rmdir/rmdir01.c b/testcases/kernel/syscalls/rmdir/rmdir01.c
index b51b3f4..855008c 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir01.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir01.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST rmdir() base functionality
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index 3d07658..59d0caf 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -162,7 +162,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* save current working directory */
 		getcwd(cwd, 255);
diff --git a/testcases/kernel/syscalls/rmdir/rmdir03.c b/testcases/kernel/syscalls/rmdir/rmdir03.c
index f3ad25c..d4af8db 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir03.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir03.c
@@ -126,7 +126,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 //test1:       $
 		/*
diff --git a/testcases/kernel/syscalls/rmdir/rmdir04.c b/testcases/kernel/syscalls/rmdir/rmdir04.c
index b11b9a7..30d194e 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir04.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir04.c
@@ -155,7 +155,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (mkdir(fname, 0777) == -1) {
 			tst_brkm(TBROK, cleanup,
diff --git a/testcases/kernel/syscalls/rmdir/rmdir05.c b/testcases/kernel/syscalls/rmdir/rmdir05.c
index 986575f..09b1c28 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir05.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir05.c
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE: 1
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index b0830cd..a724b0c 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -162,7 +162,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index 75b490d..3fa8eb6 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -161,7 +161,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {	//signal for 34 to 65
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 345c389..f866b00 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -173,7 +173,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {	//signal for 34 to 65
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index 3b2dfbb..1c27841 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -157,7 +157,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			if (sigemptyset(&set) < 0) {
@@ -233,7 +233,7 @@ int main(int ac, char **av)
 
 		}
 
-		Tst_count++;
+		tst_count++;
 
 	}
 
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
index ec350b1..f664427 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
@@ -161,7 +161,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 
 	TEST(sigfillset(&s));
 	if (TEST_RETURN == -1) {
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
index f063077..9ede6d0 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
@@ -79,7 +79,7 @@ int main(int ac, char **av)
 	pid = getpid();
 	siginfo_t uinfo;
 
-	Tst_count = 0;
+	tst_count = 0;
 	for (testno = 0; testno < TST_TOTAL; ++testno) {
 		TEST(pid = fork());
 		setup();
diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
index 5436b34..e4502aa 100644
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
@@ -127,7 +127,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (sigemptyset(&set) < 0) {
 			tst_brkm(TFAIL | TERRNO, cleanup, "sigemptyset failed");
diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c b/testcases/kernel/syscalls/sbrk/sbrk01.c
index 1eb8a6e..72ee467 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk01.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk01.c
@@ -152,7 +152,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE:
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
index 760ae88..3ecf250 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			/*
diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
index 60d7467..f21af75 100644
--- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max02.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call sched_get_priority_max(2)
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
index 9d41d37..d4e9b9e 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min01.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			/*
diff --git a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
index 7923c3d..f6b786b 100644
--- a/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
+++ b/testcases/kernel/syscalls/sched_get_priority_min/sched_get_priority_min02.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call sched_get_priority_min(2)
diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index d9d9437..c8c62b2 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -82,7 +82,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		do_test();
 	}
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index 859e412..18535ab 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -88,7 +88,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		param.sched_priority = 100;
 
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
index cef4153..8c354ab 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
@@ -100,7 +100,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (child_pid = FORK_OR_VFORK()) {
 
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index ad54139..b666561 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -114,8 +114,8 @@ int main(int ac, char **av)
 
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 
diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
index 587f2dd..6bd13c5 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
@@ -87,7 +87,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
index 5ee6ca2..349f9f6 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
@@ -70,8 +70,8 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(sched_getscheduler(INVALID_PID));
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 8751adb..96bf462 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -90,7 +90,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call sched_rr_get_interval(2) with pid=0 so that it will
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index e403a39..be0ba8e 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		tp.tv_sec = 99;
 		tp.tv_nsec = 99;
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 13147b5..a6a1fe4 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			/*
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
index e91c43c..4b390e0 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam01.c
@@ -88,7 +88,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call sched_setparam(2) with pid=0 sothat it will
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
index 2cc0da8..4d3ea0f 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam02.c
@@ -106,7 +106,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
index 68c6426..22a67c6 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (child_pid = FORK_OR_VFORK()) {
 
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
index ea8f435..b49dc3c 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
@@ -122,8 +122,8 @@ int main(int ac, char **av)
 
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 			/*
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
index 0a3e5db..3f19fba 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam05.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (child_pid = FORK_OR_VFORK()) {
 
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
index da264ec..fa77dff 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
@@ -107,8 +107,8 @@ int main(int ac, char **av)
 	}
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		setup();
 
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
index 6cb1fc7..c29884a 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
@@ -88,8 +88,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork failed");
diff --git a/testcases/kernel/syscalls/sched_yield/sched_yield01.c b/testcases/kernel/syscalls/sched_yield/sched_yield01.c
index 649a45d..5124d78 100644
--- a/testcases/kernel/syscalls/sched_yield/sched_yield01.c
+++ b/testcases/kernel/syscalls/sched_yield/sched_yield01.c
@@ -67,8 +67,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(sched_yield());
 
diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index 1e47826..1d8598c 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -160,7 +160,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Assigning the specified seconds within the timeval structure.
diff --git a/testcases/kernel/syscalls/select/select02.c b/testcases/kernel/syscalls/select/select02.c
index 4ec2feb..41fed38 100644
--- a/testcases/kernel/syscalls/select/select02.c
+++ b/testcases/kernel/syscalls/select/select02.c
@@ -155,7 +155,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Assigning the specified seconds within the timeval structure.
diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index bd6c197..bb725ab 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -159,7 +159,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Assigning the specified seconds within the timeval structure.
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index fb9fbdd..d228422 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -261,7 +261,7 @@ int main(int ac, char *av[])
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index 3473eb0..8d60c44 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -301,7 +301,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -c option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			do_sendfile(testcases[i].offset, i);
diff --git a/testcases/kernel/syscalls/sendfile/sendfile03.c b/testcases/kernel/syscalls/sendfile/sendfile03.c
index ede9dfa..48d7365 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile03.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile03.c
@@ -105,7 +105,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -c option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			if (testcases[i].setupfunc != NULL) {
diff --git a/testcases/kernel/syscalls/sendfile/sendfile04.c b/testcases/kernel/syscalls/sendfile/sendfile04.c
index 84a04f0..b366231 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile04.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile04.c
@@ -287,7 +287,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -c option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 			do_sendfile(testcases[i].protection,
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index bc45d40..09148f2 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -250,7 +250,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -c option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		do_sendfile();
 	}
diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index 0d04709..2f253be 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -272,7 +272,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -c option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		do_sendfile();
 	}
diff --git a/testcases/kernel/syscalls/sendfile/sendfile07.c b/testcases/kernel/syscalls/sendfile/sendfile07.c
index c31032e..9ba235e 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile07.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile07.c
@@ -89,7 +89,7 @@ int main(int ac, char **av)
 	 * The following loop checks looping state if -c option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(sendfile(out_fd, in_fd, NULL, 1));
 
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 2a1b2c9..90fbb5d 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -418,7 +418,7 @@ int main(int argc, char *argv[])
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index 0c330be..a571afd 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -333,7 +333,7 @@ int main(int ac, char *av[])
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c b/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c
index 497b80c..927cc8d 100644
--- a/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c
+++ b/testcases/kernel/syscalls/set_robust_list/set_robust_list01.c
@@ -101,7 +101,7 @@ int main(int argc, char **argv)
 	len = sizeof(struct robust_list_head);
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * The set_robust_list function fails with EINVAL if the len argument
diff --git a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
index f37f9f2..f9fa0e0 100644
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST(ltp_syscall(__NR_set_tid_address, &newtid));
 			if (TEST_RETURN == getpid()) {
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname01.c b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
index b019a74..3cc75f1 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call setdomainname(2)
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname02.c b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
index 30dee53..f2e11fa 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname02.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
@@ -123,8 +123,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (ind = 0; ind < TST_TOTAL; ind++) {
 
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname03.c b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
index d3ac02a..377d219 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname03.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call setdomainname(2)
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid01.c b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
index de5d2c5..fc2af5b 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid01.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid01.c
@@ -73,8 +73,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		gid = getegid();
 
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid02.c b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
index 0bd790d..c4c6880 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid02.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid02.c
@@ -77,8 +77,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		gid = 1;
 		while (getgrgid(gid)) {
diff --git a/testcases/kernel/syscalls/setfsgid/setfsgid03.c b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
index d0dbf6e..8345160 100644
--- a/testcases/kernel/syscalls/setfsgid/setfsgid03.c
+++ b/testcases/kernel/syscalls/setfsgid/setfsgid03.c
@@ -79,8 +79,8 @@ int main(int ac, char **av)
 
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		gid = 1;
 		while (!getgrgid(gid)) {
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
index 58c7d71..0fa1629 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
@@ -77,8 +77,8 @@ int main(int ac, char **av)
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(setfsuid(uid));
 
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
index 7c3b898..dce6191 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
@@ -85,8 +85,8 @@ int main(int ac, char **av)
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(setfsuid(uid));
 
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid03.c b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
index 0970609..ecd9381 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid03.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
@@ -87,8 +87,8 @@ int main(int ac, char **av)
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(setfsuid(uid));
 
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 1055712..4ee2e22 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -172,7 +172,7 @@ void do_master_child()
 	/* Test 3: Fallback to initial uid and check we can again open
 	 *         the file with RDWR permissions.
 	 */
-	Tst_count++;
+	tst_count++;
 	if (setfsuid(0) == -1) {
 		perror("setfsuid failed");
 		exit(1);
diff --git a/testcases/kernel/syscalls/setgid/setgid01.c b/testcases/kernel/syscalls/setgid/setgid01.c
index 796259f..1510035 100644
--- a/testcases/kernel/syscalls/setgid/setgid01.c
+++ b/testcases/kernel/syscalls/setgid/setgid01.c
@@ -151,7 +151,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call setgid(2)
diff --git a/testcases/kernel/syscalls/setgid/setgid02.c b/testcases/kernel/syscalls/setgid/setgid02.c
index 454407b..f3894b1 100644
--- a/testcases/kernel/syscalls/setgid/setgid02.c
+++ b/testcases/kernel/syscalls/setgid/setgid02.c
@@ -79,8 +79,8 @@ int main(int ac, char **av)
 	TEST_EXP_ENOS(exp_enos);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((rootpwent = getpwnam(root)) == NULL) {
 			tst_brkm(TBROK, cleanup, "getpwnam failed for user id "
diff --git a/testcases/kernel/syscalls/setgid/setgid03.c b/testcases/kernel/syscalls/setgid/setgid03.c
index 517fb9a..261f2ae 100644
--- a/testcases/kernel/syscalls/setgid/setgid03.c
+++ b/testcases/kernel/syscalls/setgid/setgid03.c
@@ -74,8 +74,8 @@ int main(int ac, char **av)
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(setgid(ltpuser1pwent->pw_gid));
 
diff --git a/testcases/kernel/syscalls/setgroups/setgroups01.c b/testcases/kernel/syscalls/setgroups/setgroups01.c
index a3be20f..6251d7e 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups01.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups01.c
@@ -153,7 +153,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call setgroups(2)
diff --git a/testcases/kernel/syscalls/setgroups/setgroups02.c b/testcases/kernel/syscalls/setgroups/setgroups02.c
index db572b1..b9b407c 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups02.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups02.c
@@ -100,7 +100,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call setgroups() to set supplimentary group IDs of
diff --git a/testcases/kernel/syscalls/setgroups/setgroups03.c b/testcases/kernel/syscalls/setgroups/setgroups03.c
index b020b5d..bf19e57 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups03.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups03.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			if (Test_cases[i].setupfunc != NULL) {
diff --git a/testcases/kernel/syscalls/setgroups/setgroups04.c b/testcases/kernel/syscalls/setgroups/setgroups04.c
index 8b12a65..0a2d1f7 100644
--- a/testcases/kernel/syscalls/setgroups/setgroups04.c
+++ b/testcases/kernel/syscalls/setgroups/setgroups04.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		gidsetsize = NGROUPS;
 		test_desc = "EFAULT";
diff --git a/testcases/kernel/syscalls/sethostname/sethostname01.c b/testcases/kernel/syscalls/sethostname/sethostname01.c
index 96fd962..60bed71 100644
--- a/testcases/kernel/syscalls/sethostname/sethostname01.c
+++ b/testcases/kernel/syscalls/sethostname/sethostname01.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 	/* check -c option for looping. */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Call sethostname(2) */
 		TEST(sethostname(ltphost, sizeof(ltphost)));
diff --git a/testcases/kernel/syscalls/sethostname/sethostname02.c b/testcases/kernel/syscalls/sethostname/sethostname02.c
index ba6d0ed..e5ad58b 100644
--- a/testcases/kernel/syscalls/sethostname/sethostname02.c
+++ b/testcases/kernel/syscalls/sethostname/sethostname02.c
@@ -134,7 +134,7 @@ int main(int ac, char **av)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/sethostname/sethostname03.c b/testcases/kernel/syscalls/sethostname/sethostname03.c
index 9d3e845..289e01d 100644
--- a/testcases/kernel/syscalls/sethostname/sethostname03.c
+++ b/testcases/kernel/syscalls/sethostname/sethostname03.c
@@ -107,7 +107,7 @@ int main(int ac, char **av)
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* call sethostname() */
 		TEST(sethostname(ltpthost, sizeof(ltpthost)));
diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
index 9493572..fa38015 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -82,8 +82,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* allocate some space for the timer structures */
 
diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
index 28eb493..5df95ec 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer02.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
@@ -83,8 +83,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* allocate some space for a timer structure */
 		if ((value = (struct itimerval *)malloc((size_t)
diff --git a/testcases/kernel/syscalls/setitimer/setitimer03.c b/testcases/kernel/syscalls/setitimer/setitimer03.c
index 96ef59e..cbdf468 100644
--- a/testcases/kernel/syscalls/setitimer/setitimer03.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer03.c
@@ -81,8 +81,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* allocate some space for timer structures */
 
diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c b/testcases/kernel/syscalls/setpgid/setpgid01.c
index 36deea7..c13ea3e 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid01.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
@@ -151,7 +151,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call setpgid(2)
diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index cddde58..3464dba 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -101,8 +101,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index 8dd5a46..4429fe4 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -75,8 +75,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //test1:
 		/* sid of the calling process is not same */
diff --git a/testcases/kernel/syscalls/setpgrp/setpgrp01.c b/testcases/kernel/syscalls/setpgrp/setpgrp01.c
index 49c67dd..44acb89 100644
--- a/testcases/kernel/syscalls/setpgrp/setpgrp01.c
+++ b/testcases/kernel/syscalls/setpgrp/setpgrp01.c
@@ -147,7 +147,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE:
diff --git a/testcases/kernel/syscalls/setpgrp/setpgrp02.c b/testcases/kernel/syscalls/setpgrp/setpgrp02.c
index 6a9e52a..6bbafb0 100644
--- a/testcases/kernel/syscalls/setpgrp/setpgrp02.c
+++ b/testcases/kernel/syscalls/setpgrp/setpgrp02.c
@@ -71,8 +71,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() failed");
diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index 042ac82..c0cbe15 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -84,8 +84,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Lower the priority of this process from a default of 0
diff --git a/testcases/kernel/syscalls/setpriority/setpriority02.c b/testcases/kernel/syscalls/setpriority/setpriority02.c
index 055967d..e83780a 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority02.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority02.c
@@ -85,8 +85,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Try to raise the priority of this process from a default of
diff --git a/testcases/kernel/syscalls/setpriority/setpriority03.c b/testcases/kernel/syscalls/setpriority/setpriority03.c
index 30fcd5f..c9a01f2 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority03.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority03.c
@@ -84,8 +84,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Use an invalid PRIO value by making it negative.
diff --git a/testcases/kernel/syscalls/setpriority/setpriority04.c b/testcases/kernel/syscalls/setpriority/setpriority04.c
index 1fd3979..8368514 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority04.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority04.c
@@ -101,8 +101,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Try to access an invalid process.
diff --git a/testcases/kernel/syscalls/setpriority/setpriority05.c b/testcases/kernel/syscalls/setpriority/setpriority05.c
index a39417e..6361a3a 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority05.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority05.c
@@ -86,8 +86,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Try to access the init process.
diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
index 6c798ed..59ca150 100644
--- a/testcases/kernel/syscalls/setregid/setregid01.c
+++ b/testcases/kernel/syscalls/setregid/setregid01.c
@@ -143,7 +143,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE:
diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 9268bea..5e09758 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -134,8 +134,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* Set the real or effective group id */
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index 25dffaa..6c49335 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -141,8 +141,8 @@ int main(int ac, char **av)
 		pid_t pid;
 		int status, i;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* set the appropriate ownership values */
 		if (setregid(sys_gr_gid, bin_gr_gid) == -1) {
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index 714172c..1de990b 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -129,8 +129,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* Set the real or effective group id */
diff --git a/testcases/kernel/syscalls/setresgid/setresgid01.c b/testcases/kernel/syscalls/setresgid/setresgid01.c
index c573776..dfb0a1f 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid01.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid01.c
@@ -126,8 +126,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/setresgid/setresgid02.c b/testcases/kernel/syscalls/setresgid/setresgid02.c
index 062fa4e..8c94b4b 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid02.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid02.c
@@ -133,8 +133,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/setresgid/setresgid03.c b/testcases/kernel/syscalls/setresgid/setresgid03.c
index 5e7aaf8..80dc2a3 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid03.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid03.c
@@ -126,8 +126,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/setresuid/setresuid01.c b/testcases/kernel/syscalls/setresuid/setresuid01.c
index 3a93f08..7bfd402 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid01.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid01.c
@@ -136,8 +136,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* Set the real, effective or user id */
diff --git a/testcases/kernel/syscalls/setresuid/setresuid02.c b/testcases/kernel/syscalls/setresuid/setresuid02.c
index 391312a..295006d 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid02.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid02.c
@@ -125,8 +125,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i, pid;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* set the appropriate ownership values */
 		if (setresuid(nobody_pw_uid, bin_pw_uid, nobody_pw_uid) == -1) {
diff --git a/testcases/kernel/syscalls/setresuid/setresuid03.c b/testcases/kernel/syscalls/setresuid/setresuid03.c
index 6ba1afa..9bb0abd 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid03.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid03.c
@@ -136,8 +136,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i, pid;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* set the appropriate ownership values */
 		if (setresuid(root_pw_uid, bin_pw_uid, bin_pw_uid)
diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
index 2aa62e4..b471ce6 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -108,8 +108,8 @@ void do_master_child()
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int tst_fd;
 
-		/* Reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* Reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if (setresuid(0, ltpuser->pw_uid, 0) == -1) {
 			perror("setfsuid failed");
@@ -175,7 +175,7 @@ void do_master_child()
 		/* Test 3: Fallback to initial uid and check we can again open
 		 *         the file with RDWR permissions.
 		 */
-		Tst_count++;
+		tst_count++;
 		if (setresuid(0, 0, 0) == -1) {
 			perror("setfsuid failed");
 			exit(1);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid01.c b/testcases/kernel/syscalls/setreuid/setreuid01.c
index 92f4568..43767dc 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid01.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid01.c
@@ -152,7 +152,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE:
diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index 23e8795..cc16cc2 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -120,8 +120,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* Set the real or effective user id */
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index 06ba059..5dcb1f6 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -147,8 +147,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index f636cc5..0396f05 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -118,8 +118,8 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i, pid, status;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork failed");
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index 523b79a..fe8bd89 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -145,8 +145,8 @@ int main(int argc, char **argv)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i, pid, status;
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork failed");
diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
index 31c8502..f03ab86 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid06.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
@@ -81,8 +81,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(setreuid(-1, INVAL_USER));
 		if (TEST_RETURN != -1) {
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index df7f6ae..e64700c 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -107,8 +107,8 @@ void do_master_child()
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int tst_fd;
 
-		/* Reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* Reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if (setreuid(0, ltpuser->pw_uid) == -1) {
 			perror("setfsuid failed");
@@ -174,7 +174,7 @@ void do_master_child()
 		/* Test 3: Fallback to initial uid and check we can again open
 		 *         the file with RDWR permissions.
 		 */
-		Tst_count++;
+		tst_count++;
 		if (setreuid(0, 0) == -1) {
 			perror("setfsuid failed");
 			exit(1);
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index ff35e7e..d293863 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -86,8 +86,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		test1();
 		test2();
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit02.c b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
index 9cd6ef5..3c1e2a4 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit02.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit02.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index ebfbaac..409a3df 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -78,7 +78,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (getrlimit(RLIMIT_NOFILE, &rlim) != 0)
 			tst_brkm(TFAIL, cleanup, "getrlimit failed, "
diff --git a/testcases/kernel/syscalls/setsid/setsid01.c b/testcases/kernel/syscalls/setsid/setsid01.c
index dddb5a7..8e26c96 100644
--- a/testcases/kernel/syscalls/setsid/setsid01.c
+++ b/testcases/kernel/syscalls/setsid/setsid01.c
@@ -85,8 +85,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * When the process group having forked of a child
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt01.c b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
index 04d1298..3593d48 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt01.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt01.c
@@ -144,7 +144,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday01.c b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
index 6b3c806..e19bf99 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday01.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday01.c
@@ -92,8 +92,8 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int condition_number = 1;
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		tp.tv_sec = VAL_SEC;
 		tp.tv_usec = VAL_MSEC;
diff --git a/testcases/kernel/syscalls/settimeofday/settimeofday02.c b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
index 1e61afb..2dc4dce 100644
--- a/testcases/kernel/syscalls/settimeofday/settimeofday02.c
+++ b/testcases/kernel/syscalls/settimeofday/settimeofday02.c
@@ -94,8 +94,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(settimeofday((void *)-1, NULL));
 		if (TEST_RETURN != -1) {
diff --git a/testcases/kernel/syscalls/setuid/setuid01.c b/testcases/kernel/syscalls/setuid/setuid01.c
index e28c460..6e01a35 100644
--- a/testcases/kernel/syscalls/setuid/setuid01.c
+++ b/testcases/kernel/syscalls/setuid/setuid01.c
@@ -149,7 +149,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE:
diff --git a/testcases/kernel/syscalls/setuid/setuid02.c b/testcases/kernel/syscalls/setuid/setuid02.c
index 32ee976..4c4aa14 100644
--- a/testcases/kernel/syscalls/setuid/setuid02.c
+++ b/testcases/kernel/syscalls/setuid/setuid02.c
@@ -153,7 +153,7 @@ int main(int ac, char **av)
 	uid = getuid();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * TEST CASE:
diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index bba6e98..e39ca7e 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -77,8 +77,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(setuid(ROOT_USER));
 
diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
index ac6c231..c2241fb 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -123,8 +123,8 @@ void do_master_child()
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int tst_fd;
 
-		/* Reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* Reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(tst_fd = open(testfile, O_RDWR));
 
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index a241e72..ca3f456 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -159,7 +159,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value,
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 912d751..e0e83ee 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -159,7 +159,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value,
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index 01d32b0..9ca9f3d 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -118,7 +118,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value,
diff --git a/testcases/kernel/syscalls/sgetmask/sgetmask01.c b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
index 5653844..9fa1e2c 100644
--- a/testcases/kernel/syscalls/sgetmask/sgetmask01.c
+++ b/testcases/kernel/syscalls/sgetmask/sgetmask01.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (sig = -3; sig <= SIGRTMAX + 1; sig++) {
diff --git a/testcases/kernel/syscalls/sigaction/sigaction01.c b/testcases/kernel/syscalls/sigaction/sigaction01.c
index 08f4e67..9ac1c93 100644
--- a/testcases/kernel/syscalls/sigaction/sigaction01.c
+++ b/testcases/kernel/syscalls/sigaction/sigaction01.c
@@ -248,8 +248,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		testcase_no = 0;
 
diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
index a5b6b65..edeb57d 100644
--- a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
+++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Call sigaltstack() to set up an alternate stack */
 		sigstk.ss_size = SIGSTKSZ;
@@ -179,7 +179,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "CALL succeeded.");
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
index 17b60b1..787da31 100644
--- a/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
+++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack02.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			sigstk.ss_size = Test_cases[ind].size;
@@ -172,7 +172,7 @@ int main(int ac, char **av)
 					 Test_cases[ind].exp_errno);
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index 03c6bfa..b8ba436 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -184,7 +184,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		signals_received[0] = '\0';
 
@@ -224,7 +224,7 @@ int main(int ac, char **av)
 			} else if (STD_FUNCTIONAL_TEST) {
 				tst_resm(p_p.result, "%s", p_p.mesg);
 			} else {	/* no pass results being issued */
-				Tst_count++;
+				tst_count++;
 			}
 
 			/*
@@ -283,7 +283,7 @@ int main(int ac, char **av)
 				tst_resm(p_p.result, "%s", p_p.mesg);
 
 			else
-				Tst_count++;
+				tst_count++;
 
 			/*
 			 * wait for child
diff --git a/testcases/kernel/syscalls/signal/signal01.c b/testcases/kernel/syscalls/signal/signal01.c
index 18abc22..ea77296 100644
--- a/testcases/kernel/syscalls/signal/signal01.c
+++ b/testcases/kernel/syscalls/signal/signal01.c
@@ -258,19 +258,19 @@ char **argv;
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		errno = -4;
 
 		/*
 		 * Call catch_test to test setup and catching of SIGKILL.
 		 */
-		(void)do_test(CATCH_TEST, Tst_count);
+		(void)do_test(CATCH_TEST, tst_count);
 
 		/*
 		 * Call ignore_test to test setup and ignoring of SIGKILL.
 		 */
-		(void)do_test(IGNORE_TEST, Tst_count);
+		(void)do_test(IGNORE_TEST, tst_count);
 
 		/*
 		 * Call sigdfl_test to test setting SIGKILL to default.
@@ -287,15 +287,15 @@ char **argv;
 /***********************************************************************
  *
  ***********************************************************************/
-void do_test(test_case, tst_count)
+void do_test(test_case, tst_cnt)
 int test_case;
-int tst_count;
+int tst_cnt;
 {
 	int term_stat;		/* Termination status of the child returned to   */
 	/* the parent.                                   */
 	int rd_sz;		/* size of read */
 
-	Tst_count = tst_count;
+	tst_count = tst_cnt;
 
 	/*
 	 * Create a pipe of ipc
@@ -363,7 +363,7 @@ int tst_count;
 					tst_resm(TPASS, "From child: %s",
 						 Ipc_info.mesg);
 				else
-					Tst_count++;
+					tst_count++;
 				update_timings(Ipc_info.timings);
 			} else if (Ipc_info.status == FAIL_FLAG) {
 				tst_resm(TFAIL, "From child: %s",
@@ -422,7 +422,7 @@ int tst_count;
 				}
 			}
 		} else {
-			Tst_count++;	/* increment test counter */
+			tst_count++;	/* increment test counter */
 		}
 		close(fd1[0]);
 
@@ -556,7 +556,7 @@ void sigdfl_test()
 					 Tret);
 			}
 		} else
-			Tst_count++;
+			tst_count++;
 	} else {
 		tst_resm(TFAIL,
 			 "signal(SIGKILL,SIG_DFL) ret:%p, errno:%d expected ret:-1, errno:%d",
diff --git a/testcases/kernel/syscalls/signal/signal02.c b/testcases/kernel/syscalls/signal/signal02.c
index 8724345..4b59475 100644
--- a/testcases/kernel/syscalls/signal/signal02.c
+++ b/testcases/kernel/syscalls/signal/signal02.c
@@ -86,8 +86,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * There are three cases where we should get an EINVAL
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 					 strerror(TEST_ERRNO));
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/signal/signal03.c b/testcases/kernel/syscalls/signal/signal03.c
index a9b9391..fa84fcf 100644
--- a/testcases/kernel/syscalls/signal/signal03.c
+++ b/testcases/kernel/syscalls/signal/signal03.c
@@ -104,8 +104,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * loop through the list of signals and test each one
diff --git a/testcases/kernel/syscalls/signal/signal04.c b/testcases/kernel/syscalls/signal/signal04.c
index 55218d6..8a74b00 100644
--- a/testcases/kernel/syscalls/signal/signal04.c
+++ b/testcases/kernel/syscalls/signal/signal04.c
@@ -98,8 +98,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * loop through the list of signals and test each one
diff --git a/testcases/kernel/syscalls/signal/signal05.c b/testcases/kernel/syscalls/signal/signal05.c
index d9c0b49..cfbbb92 100644
--- a/testcases/kernel/syscalls/signal/signal05.c
+++ b/testcases/kernel/syscalls/signal/signal05.c
@@ -104,8 +104,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * loop through the list of signals and test each one
diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
index f8a8d9a..de20e3f 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd01.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
@@ -288,7 +288,7 @@ int main(int argc, char **argv)
 
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		sfd = do_test1(lc, SIGUSR1);
 		if (sfd < 0)
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
index b198310..0e37c55 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
@@ -153,7 +153,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			sigemptyset(&ss);
 			sigaddset(&ss, SIGUSR1);
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
index 89c9a09..8df55ba 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
@@ -145,7 +145,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			sigemptyset(&ss);
 			sigaddset(&ss, SIGUSR1);
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index 5ecfbd3..96e8ff2 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -97,7 +97,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(sigpending(sigset));
 
diff --git a/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c b/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c
index dc43ae7..4ab59ec 100644
--- a/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c
+++ b/testcases/kernel/syscalls/sigprocmask/sigprocmask01.c
@@ -116,7 +116,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call sigprocmask() to block (SIGINT) signal
@@ -205,7 +205,7 @@ int main(int ac, char **av)
 			}
 		}
 
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index fb2c1e3..cdae248 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -208,7 +208,7 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * fork off a child process
diff --git a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
index ac1b932..c92db9c 100644
--- a/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
+++ b/testcases/kernel/syscalls/sigsuspend/sigsuspend01.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Set the alarm timer */
 		alarm(5);
@@ -156,7 +156,7 @@ int main(int ac, char **av)
 				 TEST_RETURN);
 		}
 
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index d592289..ba6dd49 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -238,7 +238,7 @@ void test_masked_matching(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
 		       SIG_SETMASK, &oldmask, &oldmask);
 
-	Tst_count--;
+	tst_count--;
 
 	if (sigismember(&oldmask, signo))
 		tst_resm(TPASS, "sigwaitinfo restored the original mask");
@@ -277,7 +277,7 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 			    && si.si_signo == signo, "Struct siginfo mismatch");
 
 	/* eat the other signal */
-	Tst_count--;
+	tst_count--;
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS_COND(signo + 1, 0, si.si_pid == child[1]
 			    && si.si_code == SI_USER
@@ -287,7 +287,7 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
 		       SIG_SETMASK, &oldmask, &oldmask);
 
-	Tst_count--;
+	tst_count--;
 
 	if (sigismember(&oldmask, signo))
 		tst_resm(TPASS, "sigwaitinfo restored the original mask");
@@ -321,7 +321,7 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo)
 	SUCCEED_OR_DIE(sigprocmask, "restoring original signal mask failed",
 		       SIG_SETMASK, &oldmask, &oldmask);
 
-	Tst_count--;
+	tst_count--;
 
 	if (sigismember(&oldmask, signo))
 		tst_resm(TPASS, "sigwaitinfo restored the original mask");
@@ -457,7 +457,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < sizeof(tests) / sizeof(*tests); i++) {
 			alarm(10);	/* arrange a 10 second timeout */
diff --git a/testcases/kernel/syscalls/socket/socket01.c b/testcases/kernel/syscalls/socket/socket01.c
index f855279..f42c84a 100644
--- a/testcases/kernel/syscalls/socket/socket01.c
+++ b/testcases/kernel/syscalls/socket/socket01.c
@@ -98,7 +98,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST((s = socket(tdat[testno].domain, tdat[testno].type,
 					 tdat[testno].proto)));
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index 7aa6df0..ed7a518 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -156,7 +156,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			fd = socket(PF_INET, SOCK_STREAM, 0);
 			if (fd == -1) {
diff --git a/testcases/kernel/syscalls/socket/socket03.c b/testcases/kernel/syscalls/socket/socket03.c
index 905a4fb..5a2085a 100644
--- a/testcases/kernel/syscalls/socket/socket03.c
+++ b/testcases/kernel/syscalls/socket/socket03.c
@@ -140,7 +140,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			fd = socket(PF_INET, SOCK_STREAM, 0);
 			if (fd == -1) {
diff --git a/testcases/kernel/syscalls/socketcall/socketcall01.c b/testcases/kernel/syscalls/socketcall/socketcall01.c
index bce3aa5..cff630e 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall01.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall01.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/socketcall/socketcall02.c b/testcases/kernel/syscalls/socketcall/socketcall02.c
index 704ac38..53fec30 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall02.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall02.c
@@ -116,7 +116,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(socketcall(TC.call, TC.args));
 
diff --git a/testcases/kernel/syscalls/socketcall/socketcall03.c b/testcases/kernel/syscalls/socketcall/socketcall03.c
index 7b6168e..72d8fff 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall03.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall03.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TC.setupfunc();
 
diff --git a/testcases/kernel/syscalls/socketcall/socketcall04.c b/testcases/kernel/syscalls/socketcall/socketcall04.c
index f37487d..10b1e6d 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall04.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall04.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 	/* check looping state */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TC.setupfunc();
 
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index 7f2e41e..cb18f1f 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -104,7 +104,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			TEST((s = socketpair(tdat[testno].domain,
 					     tdat[testno].type,
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index badb5f3..15f5b49 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -131,7 +131,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			tdat[testno].setup();
 
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index 586e08b..e03b5a3 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call splice_test
diff --git a/testcases/kernel/syscalls/ssetmask/ssetmask01.c b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
index f3818c8..12a470f 100644
--- a/testcases/kernel/syscalls/ssetmask/ssetmask01.c
+++ b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			ltp_syscall(__NR_ssetmask, SIGALRM);
 			TEST(ltp_syscall(__NR_sgetmask));
diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
index 40e7473..cf076da 100644
--- a/testcases/kernel/syscalls/stat/stat01.c
+++ b/testcases/kernel/syscalls/stat/stat01.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call stat(2) to get the status of
@@ -154,7 +154,7 @@ int main(int ac, char **av)
 				tst_resm(TINFO, "Call succeeded");
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/stat/stat02.c b/testcases/kernel/syscalls/stat/stat02.c
index ac0fcae..9af3df1 100644
--- a/testcases/kernel/syscalls/stat/stat02.c
+++ b/testcases/kernel/syscalls/stat/stat02.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call stat(2) to get the status of
@@ -155,7 +155,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "Call succeeded");
 			}
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
index 9637de1..dfbe02e 100644
--- a/testcases/kernel/syscalls/stat/stat03.c
+++ b/testcases/kernel/syscalls/stat/stat03.c
@@ -164,7 +164,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			file_name = Test_cases[ind].pathname;
@@ -203,7 +203,7 @@ int main(int ac, char **av)
 					 Test_cases[ind].exp_errno);
 			}
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	/*
diff --git a/testcases/kernel/syscalls/stat/stat05.c b/testcases/kernel/syscalls/stat/stat05.c
index 9073951..ff95809 100644
--- a/testcases/kernel/syscalls/stat/stat05.c
+++ b/testcases/kernel/syscalls/stat/stat05.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call stat(2) with F_CLRALF argument on fname
diff --git a/testcases/kernel/syscalls/stat/stat06.c b/testcases/kernel/syscalls/stat/stat06.c
index b01da8a..c1afabb 100644
--- a/testcases/kernel/syscalls/stat/stat06.c
+++ b/testcases/kernel/syscalls/stat/stat06.c
@@ -206,7 +206,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 
@@ -253,7 +253,7 @@ int main(int ac, char **av)
 							 Test_cases
 							 [ind].exp_errno);
 				} else
-					Tst_count++;
+					tst_count++;
 			} else {
 				tst_resm(TFAIL,
 					 "stat(<%s>, &stbuf) returned %ld, expected -1, errno:%d",
diff --git a/testcases/kernel/syscalls/statfs/statfs01.c b/testcases/kernel/syscalls/statfs/statfs01.c
index 50d30c3..a77a66a 100644
--- a/testcases/kernel/syscalls/statfs/statfs01.c
+++ b/testcases/kernel/syscalls/statfs/statfs01.c
@@ -148,7 +148,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Call fstatfs(2) */
 		TEST(statfs(fname, &stats));
diff --git a/testcases/kernel/syscalls/statfs/statfs02.c b/testcases/kernel/syscalls/statfs/statfs02.c
index eb14cc9..02a288c 100644
--- a/testcases/kernel/syscalls/statfs/statfs02.c
+++ b/testcases/kernel/syscalls/statfs/statfs02.c
@@ -126,7 +126,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/statfs/statfs03.c b/testcases/kernel/syscalls/statfs/statfs03.c
index 71d2ffb..a612d83 100644
--- a/testcases/kernel/syscalls/statfs/statfs03.c
+++ b/testcases/kernel/syscalls/statfs/statfs03.c
@@ -88,7 +88,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(statfs(path, &buf));
 
diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index 54eaf73..767cde6 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -69,7 +69,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(statvfs(TEST_PATH, &buf));
 
diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
index 7376ca5..f002845 100644
--- a/testcases/kernel/syscalls/stime/stime01.c
+++ b/testcases/kernel/syscalls/stime/stime01.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 		/* Get the system's new time */
 		new_time = real_time_tv.tv_sec + INCR_TIME;
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke stime(2) to set the system's time to the specified
diff --git a/testcases/kernel/syscalls/stime/stime02.c b/testcases/kernel/syscalls/stime/stime02.c
index 74eec1a..5b9b1a7 100644
--- a/testcases/kernel/syscalls/stime/stime02.c
+++ b/testcases/kernel/syscalls/stime/stime02.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke stime(2) to set the system's time
@@ -132,7 +132,7 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "stime(2) returned %ld, expected -1, "
 				 "errno:%d", TEST_RETURN, EPERM);
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index d178d8d..2921476 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
 			tst_resm(TWARN, "Failed to turn on the swap file"
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 6d993d2..ef1dff6 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -131,7 +131,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 8270bb7..9550bb2 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -101,7 +101,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));
 
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 5d1e85d..05324fc 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -149,7 +149,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (i = 0; i < TST_TOTAL; i++) {
 
 			/* do the setup if the test have one */
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 1fd9631..806c5e4 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 	 * check looping state if -i option given
 	 ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* do the test setup */
 		if (setup_swap() < 0) {
diff --git a/testcases/kernel/syscalls/symlink/symlink01.c b/testcases/kernel/syscalls/symlink/symlink01.c
index 416fb08..a866e88 100644
--- a/testcases/kernel/syscalls/symlink/symlink01.c
+++ b/testcases/kernel/syscalls/symlink/symlink01.c
@@ -556,7 +556,7 @@ int main(int argc, char *argv[])
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Execute tcs testing function and all defined test cases
@@ -918,7 +918,7 @@ struct tcses *tcs;
 		if (Selectedtests == NULL) {
 			if (strcmp(tcs->tcid, tc_ptr->tcid) != 0) {
 				TCID = tc_ptr->tcid;
-				Tst_count = 0;
+				tst_count = 0;
 			}
 		}
 		/*
@@ -1042,7 +1042,7 @@ struct all_test_cases *tc_ptr;
 			if (STD_FUNCTIONAL_TEST)
 				tst_resm(TPASS, "%s", msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s %s",
 				 "Expected EEXIST error when creating a symbolic link file",
@@ -1056,7 +1056,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else {
 
 			tst_resm(TFAIL, "%s %s",
@@ -1073,7 +1073,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s %s errno:%d %s",
 				 "Expected EEXIST error for exclusively opening an object file",
@@ -1102,7 +1102,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s %s errno:%d %s",
 				 "Expected ENOENT error for stating a non-existent directory",
@@ -1114,7 +1114,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else {
 			tst_resm(TFAIL, "%s %s errno:%d %s",
 				 "Expected ENOENT error for changing to a non-existent",
@@ -1131,7 +1131,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else {
 			tst_resm(TFAIL, "%s %s errno:%d %s",
 				 "Expected ENOENT error condition when link(2) a symbolic",
@@ -1146,7 +1146,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s %s errno:%d %s",
 				 "Expected ENOENT error condition when chmod(2) a symbolic",
@@ -1159,7 +1159,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s %s errno:%d %s",
 				 "Expected ENOENT error condition when utime(2) a symbolic",
@@ -1173,7 +1173,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s %s errno:%d %s",
 				 "Expected ENOENT error for opening a non-existent object",
@@ -1203,13 +1203,13 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else if (TEST_RESULT != TPASS || STD_FUNCTIONAL_TEST)
 			tst_resm(TEST_RESULT, "%s errno:%d %s",
 				 "Expected ELOOP errno from stat(2) (nested symb link),",
 				 errno, strerror(errno));
 		else
-			Tst_count++;
+			tst_count++;
 	} else if (cktcsid(tc_ptr->tcid, CHDIR)) {
 
 		TEST(chdir(tc_ptr->fn_arg[1]));
@@ -1219,7 +1219,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else {
 
 			tst_resm(TFAIL, "%s errno:%d %s",
@@ -1237,7 +1237,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s errno:%d %s",
 				 "Expected ELOOP error condition when link(2) a nested symbolic link:",
@@ -1251,7 +1251,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s errno:%d %s",
 				 "Expected ELOOP error condition when chmod(2) a nested symbolic link:",
@@ -1267,7 +1267,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s errno:%d %s",
 				 "Expected ELOOP error condition when utime(2) a nested symbolic link:",
@@ -1283,7 +1283,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s errno:%d %s",
 				 "Expected ELOOP error condition when open(2) a nested symbolic link:",
@@ -1316,7 +1316,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 			rmdir(tc_ptr->fn_arg[0]);
 		} else
 			tst_resm(TFAIL, "%s %s errno:%d %s",
@@ -1348,7 +1348,7 @@ struct all_test_cases *tc_ptr;
 					tst_resm(TEST_RESULT, "%s",
 						 msgs[tc_ptr->pass_msg]);
 				else
-					Tst_count++;
+					tst_count++;
 			else
 				tst_resm(TFAIL,
 					 "%s %s %s file outside of current file system",
@@ -1389,7 +1389,7 @@ struct all_test_cases *tc_ptr;
 					tst_resm(TEST_RESULT, "%s",
 						 msgs[tc_ptr->pass_msg]);
 				else
-					Tst_count++;
+					tst_count++;
 			else
 				tst_resm(TFAIL, "%s %s %d %s",
 					 "symlink(2) returned -1 when trying to create a symbolic",
@@ -1410,7 +1410,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL,
 				 "Expected ENAMETOOLONG error when reading %s symbolic link file with a path exceeding %d characters: errno:%d %s",
@@ -1440,7 +1440,7 @@ struct all_test_cases *tc_ptr;
 					tst_resm(TEST_RESULT, "%s",
 						 msgs[tc_ptr->pass_msg]);
 				else
-					Tst_count++;
+					tst_count++;
 			} else
 				tst_resm(TFAIL,
 					 "readlink(2) ret:-1, errno:%d, : Exp errno:%d",
@@ -1490,7 +1490,7 @@ struct all_test_cases *tc_ptr;
 	} else if (TEST_RESULT != TPASS || STD_FUNCTIONAL_TEST)
 		tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
 	else
-		Tst_count++;
+		tst_count++;
 }
 
 /***********************************************************************
@@ -1552,7 +1552,7 @@ struct all_test_cases *tc_ptr;
 	else if (TEST_RESULT != TPASS || STD_FUNCTIONAL_TEST)
 		tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
 	else
-		Tst_count++;
+		tst_count++;
 }
 
 /***********************************************************************
@@ -1597,7 +1597,7 @@ struct all_test_cases *tc_ptr;
 					tst_resm(TEST_RESULT, "%s",
 						 msgs[tc_ptr->pass_msg]);
 				else
-					Tst_count++;
+					tst_count++;
 			else {
 				tst_resm(TFAIL,
 					 "%s%s %s %s not equal to expected %s",
@@ -1657,7 +1657,7 @@ struct all_test_cases *tc_ptr;
 								 msgs[tc_ptr->
 								      pass_msg]);
 						else
-							Tst_count++;
+							tst_count++;
 					} else {
 						lstat(tc_ptr->fn_arg[2],
 						      &stbuf);
@@ -1711,7 +1711,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s%s %s %s", Buffer,
 				 "unlink(2) failed because it not only removed symbolic link",
@@ -1753,7 +1753,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s%s %o to %o %s", Buffer,
 				 "chmod(2) failed to change object file permissions from",
@@ -1812,7 +1812,7 @@ struct all_test_cases *tc_ptr;
 							 msgs[tc_ptr->
 							      pass_msg]);
 					else
-						Tst_count++;
+						tst_count++;
 				else
 					tst_resm(TFAIL,
 						 "%s %s %jd greater than original times",
@@ -1851,7 +1851,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		else
 			tst_resm(TFAIL, "%s", test_msg);
 	else if (!ck_symlink(tc_ptr->fn_arg[0], A_S_FILE, NULL))
@@ -1863,7 +1863,7 @@ struct all_test_cases *tc_ptr;
 	else if (TEST_RESULT != TPASS || STD_FUNCTIONAL_TEST)
 		tst_resm(TEST_RESULT, "%s", msgs[tc_ptr->pass_msg]);
 	else
-		Tst_count++;
+		tst_count++;
 }
 
 /***********************************************************************
@@ -1957,7 +1957,7 @@ struct all_test_cases *tc_ptr;
 				tst_resm(TEST_RESULT, "%s",
 					 msgs[tc_ptr->pass_msg]);
 			else
-				Tst_count++;
+				tst_count++;
 		} else {	/* Insure newly created object file is pointed at */
 			if (ck_both
 			    (tc_ptr->fn_arg[0], tc_ptr->fn_arg[1],
@@ -1966,7 +1966,7 @@ struct all_test_cases *tc_ptr;
 					tst_resm(TEST_RESULT, "%s",
 						 msgs[tc_ptr->pass_msg]);
 				else
-					Tst_count++;
+					tst_count++;
 			else
 				tst_resm(TFAIL, "%s", test_msg);
 		}
diff --git a/testcases/kernel/syscalls/symlink/symlink02.c b/testcases/kernel/syscalls/symlink/symlink02.c
index ade859d..e0247d0 100644
--- a/testcases/kernel/syscalls/symlink/symlink02.c
+++ b/testcases/kernel/syscalls/symlink/symlink02.c
@@ -152,7 +152,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call symlink(2)
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index 49e4a8f..721b311 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -175,7 +175,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			test_file = Test_cases[ind].file;
@@ -216,7 +216,7 @@ int main(int ac, char **av)
 			}
 		}
 
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/symlink/symlink04.c b/testcases/kernel/syscalls/symlink/symlink04.c
index 6765e47..695e6f1 100644
--- a/testcases/kernel/syscalls/symlink/symlink04.c
+++ b/testcases/kernel/syscalls/symlink/symlink04.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call symlink(2) to create a symlink of
@@ -159,7 +159,7 @@ int main(int ac, char **av)
 				 "unlink(%s) Failed, errno=%d : %s",
 				 SYMFILE, errno, strerror(errno));
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/symlink/symlink05.c b/testcases/kernel/syscalls/symlink/symlink05.c
index 74c6d06..e790416 100644
--- a/testcases/kernel/syscalls/symlink/symlink05.c
+++ b/testcases/kernel/syscalls/symlink/symlink05.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call symlink(2) to create a symlink of
@@ -160,7 +160,7 @@ int main(int ac, char **av)
 				 "unlink(%s) Failed, errno=%d : %s",
 				 SYMFILE, errno, strerror(errno));
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index c052fb9..43d63ce 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -178,7 +178,7 @@ int main(int ac, char **av)
 	 ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call symlinkat
diff --git a/testcases/kernel/syscalls/sync/sync01.c b/testcases/kernel/syscalls/sync/sync01.c
index 757ae37..7aca91d 100644
--- a/testcases/kernel/syscalls/sync/sync01.c
+++ b/testcases/kernel/syscalls/sync/sync01.c
@@ -147,7 +147,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call sync(2)
diff --git a/testcases/kernel/syscalls/sync/sync02.c b/testcases/kernel/syscalls/sync/sync02.c
index 886d762..b5709f8 100644
--- a/testcases/kernel/syscalls/sync/sync02.c
+++ b/testcases/kernel/syscalls/sync/sync02.c
@@ -103,7 +103,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call sync(2) to commit buffer data to disk.
@@ -147,7 +147,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "call succeeded");
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/sysctl/sysctl01.c b/testcases/kernel/syscalls/sysctl/sysctl01.c
index cc2817e..411fcb2 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl01.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl01.c
@@ -113,8 +113,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/sysctl/sysctl03.c b/testcases/kernel/syscalls/sysctl/sysctl03.c
index 6a2cae8..72ae398 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl03.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl03.c
@@ -127,8 +127,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		strcpy(osname, "Linux");
 		osnamelth = SIZE(osname);
diff --git a/testcases/kernel/syscalls/sysctl/sysctl04.c b/testcases/kernel/syscalls/sysctl/sysctl04.c
index bda1020..1c37d76 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl04.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl04.c
@@ -111,8 +111,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
diff --git a/testcases/kernel/syscalls/sysctl/sysctl05.c b/testcases/kernel/syscalls/sysctl/sysctl05.c
index e06ad6e..57af290 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl05.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl05.c
@@ -120,8 +120,8 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/sysfs/sysfs01.c b/testcases/kernel/syscalls/sysfs/sysfs01.c
index 0bebeaa..0113203 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs01.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs01.c
@@ -92,7 +92,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* option 1, buf holds fs name */
 		TEST(syscall(__NR_sysfs, 1, "proc"));
diff --git a/testcases/kernel/syscalls/sysfs/sysfs02.c b/testcases/kernel/syscalls/sysfs/sysfs02.c
index a5ffb06..8aea1ea 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs02.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs02.c
@@ -91,7 +91,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*option 2 buf holds fs name */
 		TEST(syscall(__NR_sysfs, 2, 0, buf));
diff --git a/testcases/kernel/syscalls/sysfs/sysfs03.c b/testcases/kernel/syscalls/sysfs/sysfs03.c
index 13b1828..9a8992d 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs03.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs03.c
@@ -90,7 +90,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(syscall(__NR_sysfs, 3));
 
diff --git a/testcases/kernel/syscalls/sysfs/sysfs04.c b/testcases/kernel/syscalls/sysfs/sysfs04.c
index cc8d8fb..878ca2e 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs04.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs04.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 		TEST(syscall(__NR_sysfs, INVALID_OPTION));
 
 		/* check return code */
diff --git a/testcases/kernel/syscalls/sysfs/sysfs05.c b/testcases/kernel/syscalls/sysfs/sysfs05.c
index ad7c218..32a598f 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs05.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs05.c
@@ -111,7 +111,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			Tst_count = 0;
+			tst_count = 0;
 			TEST(syscall(__NR_sysfs, option[i], fsname[i]));
 
 			/* check return code */
diff --git a/testcases/kernel/syscalls/sysfs/sysfs06.c b/testcases/kernel/syscalls/sysfs/sysfs06.c
index 7a986b2..9871c9b 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs06.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs06.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			Tst_count = 0;
+			tst_count = 0;
 			TEST(syscall
 			     (__NR_sysfs, option[i], fsindex[i], bad_addr));
 
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo01.c b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
index 356e263..7d54f67 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo01.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo01.c
@@ -99,8 +99,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(sysinfo(sys_buf));
 		/* check return code */
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo02.c b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
index ad727e5..a7674d5 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo02.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo02.c
@@ -98,8 +98,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		TEST(sysinfo(sysinfo_buf));
 		/* check return code */
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index c013970..b312a78 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -126,8 +126,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/syslog/syslog12.c b/testcases/kernel/syscalls/syslog/syslog12.c
index 3e3813f..ec961ab 100644
--- a/testcases/kernel/syscalls/syslog/syslog12.c
+++ b/testcases/kernel/syscalls/syslog/syslog12.c
@@ -144,8 +144,8 @@ int main(int argc, char **argv)
 	sigaction(SIGALRM, &sa, NULL);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 0e8f399..1c8e17f 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call tee_test
diff --git a/testcases/kernel/syscalls/time/time01.c b/testcases/kernel/syscalls/time/time01.c
index 8256dc0..d599a68 100644
--- a/testcases/kernel/syscalls/time/time01.c
+++ b/testcases/kernel/syscalls/time/time01.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call time(2)
diff --git a/testcases/kernel/syscalls/time/time02.c b/testcases/kernel/syscalls/time/time02.c
index ec85b0e..4d67bc2 100644
--- a/testcases/kernel/syscalls/time/time02.c
+++ b/testcases/kernel/syscalls/time/time02.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call time() to get the time in seconds$
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 			}
 
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	/* cleanup and exit */
diff --git a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
index 76ec56d..cc852d2 100644
--- a/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
+++ b/testcases/kernel/syscalls/timer_getoverrun/timer_getoverrun01.c
@@ -119,7 +119,7 @@ int parent;
 int block = 1;
 
 #define ENTER(normal) tst_resm(TINFO, "Enter block %d: test %d (%s)", \
-                         block, Tst_count, normal?"NORMAL":"ERROR");
+                         block, tst_count, normal?"NORMAL":"ERROR");
 
 int main(int ac, char **av)
 {
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			ev.sigev_value = (sigval_t) 0;
@@ -152,11 +152,11 @@ int main(int ac, char **av)
 				created_timer_id));
 			if (TEST_RETURN == 0) {
 				tst_resm(TPASS, "Block %d: test %d PASSED",
-					 block, Tst_count);
+					 block, tst_count);
 			} else {
 				tst_resm(TFAIL,
 					 "Block %d: test %d FAILED... errno = %d : %s",
-					 block, Tst_count, TEST_ERRNO,
+					 block, tst_count, TEST_ERRNO,
 					 strerror(TEST_ERRNO));
 				cleanup();
 				tst_exit();
@@ -166,11 +166,11 @@ int main(int ac, char **av)
 			TEST(ltp_syscall(__NR_timer_getoverrun, -1));
 			if (TEST_RETURN < 0 && TEST_ERRNO == EINVAL) {
 				tst_resm(TPASS, "Block %d: test %d PASSED",
-					 block, Tst_count);
+					 block, tst_count);
 			} else {
 				tst_resm(TFAIL,
 					 "Block %d: test %d FAILED... errno = %d : %s",
-					 block, Tst_count, TEST_ERRNO,
+					 block, tst_count, TEST_ERRNO,
 					 strerror(TEST_ERRNO));
 				cleanup();
 				tst_exit();
diff --git a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
index ab2249d..f96fe96 100644
--- a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
+++ b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
@@ -114,7 +114,7 @@ void setup()
 }
 
 #define ENTER(normal) tst_resm(TINFO, "Enter block %d: test %d (%s)", \
-		 block, Tst_count, normal?"NORMAL":"ERROR");
+		 block, tst_count, normal?"NORMAL":"ERROR");
 
 char tmpname[40];
 int parent;
@@ -135,7 +135,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			ENTER(1);
 			ev.sigev_value = (sigval_t) 0;
@@ -147,11 +147,11 @@ int main(int ac, char **av)
 				     &spec));
 			if (TEST_RETURN == 0) {
 				tst_resm(TPASS, "Block %d: test %d PASSED",
-					 block, Tst_count);
+					 block, tst_count);
 			} else {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "Block %d: test %d FAILED",
-					 block, Tst_count);
+					 block, tst_count);
 			}
 
 /*
@@ -165,11 +165,11 @@ ERRORS
 			if (TEST_RETURN < 0 && TEST_ERRNO == EINVAL) {
 				tst_resm(TPASS,
 					 "Block %d: test %d PASSED",
-					 block, Tst_count);
+					 block, tst_count);
 			} else {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "Block %d: test %d FAILED",
-					 block, Tst_count);
+					 block, tst_count);
 			}
 
 /*
@@ -184,11 +184,11 @@ ERRORS
 			if (TEST_RETURN < 0 && TEST_ERRNO == EFAULT) {
 				tst_resm(TPASS,
 					 "Block %d: test %d PASSED",
-					 block, Tst_count);
+					 block, tst_count);
 			} else {
 				tst_brkm(TFAIL | TERRNO, cleanup,
 					 "Block %d: test %d FAILED",
-					 block, Tst_count);
+					 block, tst_count);
 			}
 
 		}
diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
index 40bd4a9..f376b33 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
@@ -151,7 +151,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			fd = ltp_syscall(__NR_timerfd_create,
 				CLOCK_REALTIME, 0);
diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
index 89686d1..0d1eafd 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd03.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
@@ -147,7 +147,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			fd = ltp_syscall(__NR_timerfd_create,
 				CLOCK_REALTIME, 0);
diff --git a/testcases/kernel/syscalls/times/times01.c b/testcases/kernel/syscalls/times/times01.c
index 4ae4848..fceb413 100644
--- a/testcases/kernel/syscalls/times/times01.c
+++ b/testcases/kernel/syscalls/times/times01.c
@@ -141,7 +141,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(times(&mytimes));
 
diff --git a/testcases/kernel/syscalls/tkill/tkill01.c b/testcases/kernel/syscalls/tkill/tkill01.c
index 438d3c3..f6fe1b9 100644
--- a/testcases/kernel/syscalls/tkill/tkill01.c
+++ b/testcases/kernel/syscalls/tkill/tkill01.c
@@ -92,7 +92,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 			if (signal(SIGUSR1, &sig_action) == SIG_ERR)
 				tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/truncate/truncate01.c b/testcases/kernel/syscalls/truncate/truncate01.c
index f65ff83..509daa0 100644
--- a/testcases/kernel/syscalls/truncate/truncate01.c
+++ b/testcases/kernel/syscalls/truncate/truncate01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call truncate(2) to truncate a test file to a
@@ -164,7 +164,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s call succeeded", TCID);
 			}
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/truncate/truncate02.c b/testcases/kernel/syscalls/truncate/truncate02.c
index 81fd169..42e98a9 100644
--- a/testcases/kernel/syscalls/truncate/truncate02.c
+++ b/testcases/kernel/syscalls/truncate/truncate02.c
@@ -120,7 +120,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call truncate(2) to truncate a test file to a
@@ -233,7 +233,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s call succeeded", TCID);
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 03632db..dda98e4 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -166,7 +166,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 			file_name = Test_cases[ind].pathname;
@@ -204,7 +204,7 @@ int main(int ac, char **av)
 					 Test_cases[ind].exp_errno);
 			}
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/truncate/truncate04.c b/testcases/kernel/syscalls/truncate/truncate04.c
index aa86de7..69448c0 100644
--- a/testcases/kernel/syscalls/truncate/truncate04.c
+++ b/testcases/kernel/syscalls/truncate/truncate04.c
@@ -122,7 +122,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call truncate(2)
diff --git a/testcases/kernel/syscalls/ulimit/ulimit01.c b/testcases/kernel/syscalls/ulimit/ulimit01.c
index dde79aa..0e43bc2 100644
--- a/testcases/kernel/syscalls/ulimit/ulimit01.c
+++ b/testcases/kernel/syscalls/ulimit/ulimit01.c
@@ -178,7 +178,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/syscalls/umask/umask01.c b/testcases/kernel/syscalls/umask/umask01.c
index 8b9bf7c..7ab856d 100644
--- a/testcases/kernel/syscalls/umask/umask01.c
+++ b/testcases/kernel/syscalls/umask/umask01.c
@@ -139,7 +139,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(umask(022));
 
diff --git a/testcases/kernel/syscalls/umask/umask02.c b/testcases/kernel/syscalls/umask/umask02.c
index f8f02de..b48eed6 100644
--- a/testcases/kernel/syscalls/umask/umask02.c
+++ b/testcases/kernel/syscalls/umask/umask02.c
@@ -76,8 +76,8 @@ int main(int argc, char **argv)
 	/* Check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (umask(++mskval), i = 1; mskval < 01000;
 		     uret = umask(++mskval), i++) {
diff --git a/testcases/kernel/syscalls/umask/umask03.c b/testcases/kernel/syscalls/umask/umask03.c
index dc5871b..0333021 100644
--- a/testcases/kernel/syscalls/umask/umask03.c
+++ b/testcases/kernel/syscalls/umask/umask03.c
@@ -80,8 +80,8 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		for (umask(mskval = 0077), i = 1; mskval < 01000;
 		     i++, umask(++mskval)) {
diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 10e41a7..a5dcd3c 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -144,7 +144,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Call mount(2) */
 		TEST(mount(device, mntpoint, Fstype, 0, NULL));
diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index c71939d..ec25337 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -186,7 +186,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; ++i) {
 
diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index f815350..45c0930 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -164,7 +164,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		switch (fork()) {
 
diff --git a/testcases/kernel/syscalls/uname/uname01.c b/testcases/kernel/syscalls/uname/uname01.c
index fc65089..e369f42 100644
--- a/testcases/kernel/syscalls/uname/uname01.c
+++ b/testcases/kernel/syscalls/uname/uname01.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(uname(&un));
 
diff --git a/testcases/kernel/syscalls/uname/uname02.c b/testcases/kernel/syscalls/uname/uname02.c
index 295c411..3f92928 100644
--- a/testcases/kernel/syscalls/uname/uname02.c
+++ b/testcases/kernel/syscalls/uname/uname02.c
@@ -78,7 +78,7 @@ int main(int ac, char **av)
 	setup();		/* global setup */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * call the system call with the TEST() macro
diff --git a/testcases/kernel/syscalls/uname/uname03.c b/testcases/kernel/syscalls/uname/uname03.c
index d6c3056..c460af6 100644
--- a/testcases/kernel/syscalls/uname/uname03.c
+++ b/testcases/kernel/syscalls/uname/uname03.c
@@ -88,8 +88,8 @@ int main(int ac, char **av)
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/* Now make the system call with the TEST() macro */
 
diff --git a/testcases/kernel/syscalls/unlink/unlink05.c b/testcases/kernel/syscalls/unlink/unlink05.c
index 5304f72..f347fd4 100644
--- a/testcases/kernel/syscalls/unlink/unlink05.c
+++ b/testcases/kernel/syscalls/unlink/unlink05.c
@@ -153,7 +153,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 *  Call unlink(2)
diff --git a/testcases/kernel/syscalls/unlink/unlink06.c b/testcases/kernel/syscalls/unlink/unlink06.c
index 73dba27..4217fd7 100644
--- a/testcases/kernel/syscalls/unlink/unlink06.c
+++ b/testcases/kernel/syscalls/unlink/unlink06.c
@@ -159,7 +159,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		create_file();
 
@@ -183,7 +183,7 @@ int main(int ac, char **av)
 					 Fname, TEST_RETURN);
 			}
 		} else
-			Tst_count++;
+			tst_count++;
 
 	}
 
diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
index ce8b4fb..6b43f8a 100644
--- a/testcases/kernel/syscalls/unlink/unlink07.c
+++ b/testcases/kernel/syscalls/unlink/unlink07.c
@@ -199,7 +199,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 
@@ -230,7 +230,7 @@ int main(int ac, char **av)
 							 Test_cases
 							 [ind].exp_errno);
 				} else
-					Tst_count++;
+					tst_count++;
 			} else {
 				tst_resm(TFAIL,
 					 "unlink(<%s>) returned %ld, expected -1, errno:%d",
diff --git a/testcases/kernel/syscalls/unlink/unlink08.c b/testcases/kernel/syscalls/unlink/unlink08.c
index bab3c30..03f899e 100644
--- a/testcases/kernel/syscalls/unlink/unlink08.c
+++ b/testcases/kernel/syscalls/unlink/unlink08.c
@@ -187,7 +187,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 
@@ -217,7 +217,7 @@ int main(int ac, char **av)
 								 Test_cases
 								 [ind].exp_errno);
 					} else
-						Tst_count++;
+						tst_count++;
 				} else {
 					tst_resm(TFAIL,
 						 "unlink(<%s>) Failed, errno=%d",
@@ -234,7 +234,7 @@ int main(int ac, char **av)
 						 "unlink(<%s>) returned %ld",
 						 desc, TEST_RETURN);
 				} else
-					Tst_count++;
+					tst_count++;
 				Test_cases[ind].setupfunc(1);
 			}
 		}
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index 3bbc14f..03c2bec 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -117,7 +117,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call unlinkat
diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index f636a95..1c69534 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -167,7 +167,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			pid1 = fork();	//call to fork()
diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
index c30d508..081ed73 100644
--- a/testcases/kernel/syscalls/unshare/unshare02.c
+++ b/testcases/kernel/syscalls/unshare/unshare02.c
@@ -134,7 +134,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			TEST(pid1 = fork());	//call to fork()
diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 7b57be7..3cda930 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -94,7 +94,7 @@ int main(int argc, char *argv[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(ustat(dev_num, ubuf));
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 1903ae5..a70ce8d 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -115,7 +115,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			if (i == 0) {
diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index f445d35..cfcf904 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke utime(2) to set TEMP_FILE access and
@@ -195,7 +195,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s call succeeded", TCID);
 			}
 		}
-		Tst_count++;
+		tst_count++;
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index 9666ead..ad60cb0 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke utime(2) to set TEMP_FILE access and
@@ -201,7 +201,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s call succeeded", TCID);
 			}
 		}
-		Tst_count++;
+		tst_count++;
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
index cd57ad0..d6d6940 100644
--- a/testcases/kernel/syscalls/utime/utime03.c
+++ b/testcases/kernel/syscalls/utime/utime03.c
@@ -161,7 +161,7 @@ int main(int ac, char **av)
 
 		for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-			Tst_count = 0;
+			tst_count = 0;
 
 			/*
 			 * Invoke utime(2) to set TEMP_FILE access and
@@ -233,7 +233,7 @@ int main(int ac, char **av)
 						 TCID);
 				}
 			}
-			Tst_count++;	/* incr. TEST_LOOP counter */
+			tst_count++;	/* incr. TEST_LOOP counter */
 		}
 	} else {
 		waitpid(pid, &status, 0);
diff --git a/testcases/kernel/syscalls/utime/utime04.c b/testcases/kernel/syscalls/utime/utime04.c
index e2d94bf..d224ef8 100644
--- a/testcases/kernel/syscalls/utime/utime04.c
+++ b/testcases/kernel/syscalls/utime/utime04.c
@@ -117,7 +117,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke utime(2) to set TEMP_FILE access and
@@ -164,7 +164,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s call succeeded", TCID);
 			}
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index 9932023..d6da33e 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -123,7 +123,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Invoke utime(2) to set TEMP_FILE access and
@@ -169,7 +169,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "%s call succeeded", TCID);
 			}
 		}
-		Tst_count++;	/* incr TEST_LOOP counter */
+		tst_count++;	/* incr TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index c8de57f..659fb65 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -164,7 +164,7 @@ int main(int ac, char **av)
 
 		for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-			Tst_count = 0;
+			tst_count = 0;
 
 			for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
 				file_name = Test_cases[ind].pathname;
@@ -202,7 +202,7 @@ int main(int ac, char **av)
 				}
 			}
 
-			Tst_count++;	/* incr TEST_LOOP counter */
+			tst_count++;	/* incr TEST_LOOP counter */
 
 		}
 	} else {
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 7826e73..1717d13 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -343,7 +343,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0]));
diff --git a/testcases/kernel/syscalls/vfork/vfork01.c b/testcases/kernel/syscalls/vfork/vfork01.c
index 2d92aaa..35c9e7b 100644
--- a/testcases/kernel/syscalls/vfork/vfork01.c
+++ b/testcases/kernel/syscalls/vfork/vfork01.c
@@ -127,7 +127,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call vfork(2) to create a child process without
@@ -290,7 +290,7 @@ int main(int ac, char **av)
 					 "Child process exited abnormally");
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/vfork/vfork02.c b/testcases/kernel/syscalls/vfork/vfork02.c
index fcccdf1..f1e90f5 100644
--- a/testcases/kernel/syscalls/vfork/vfork02.c
+++ b/testcases/kernel/syscalls/vfork/vfork02.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call vfork(2) to create a child process without
@@ -168,7 +168,7 @@ int main(int ac, char **av)
 					 "Child process exited abnormally");
 			}
 		}
-		Tst_count++;	/* incr. TEST_LOOP counter */
+		tst_count++;	/* incr. TEST_LOOP counter */
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/vhangup/vhangup01.c b/testcases/kernel/syscalls/vhangup/vhangup01.c
index 993f883..de6b93b 100644
--- a/testcases/kernel/syscalls/vhangup/vhangup01.c
+++ b/testcases/kernel/syscalls/vhangup/vhangup01.c
@@ -79,8 +79,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		nobody = my_getpwnam(user1name);
 
diff --git a/testcases/kernel/syscalls/vhangup/vhangup02.c b/testcases/kernel/syscalls/vhangup/vhangup02.c
index be3c7a3..d6c8c72 100644
--- a/testcases/kernel/syscalls/vhangup/vhangup02.c
+++ b/testcases/kernel/syscalls/vhangup/vhangup02.c
@@ -71,8 +71,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		fail = 0;
 
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 1154492..66f29a1 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		setup_every_copy();
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Call vmsplice_test
diff --git a/testcases/kernel/syscalls/wait/wait02.c b/testcases/kernel/syscalls/wait/wait02.c
index 2ac4455..4159767 100644
--- a/testcases/kernel/syscalls/wait/wait02.c
+++ b/testcases/kernel/syscalls/wait/wait02.c
@@ -153,7 +153,7 @@ int main(int ac, char **av)
      ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* create a child to wait for */
 		if ((fork_pid = FORK_OR_VFORK()) == -1) {
diff --git a/testcases/kernel/syscalls/wait4/wait401.c b/testcases/kernel/syscalls/wait4/wait401.c
index 6449d84..26f60ec 100644
--- a/testcases/kernel/syscalls/wait4/wait401.c
+++ b/testcases/kernel/syscalls/wait4/wait401.c
@@ -52,7 +52,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		pid = FORK_OR_VFORK();
 
diff --git a/testcases/kernel/syscalls/wait4/wait402.c b/testcases/kernel/syscalls/wait4/wait402.c
index 9018efd..d21fa10 100644
--- a/testcases/kernel/syscalls/wait4/wait402.c
+++ b/testcases/kernel/syscalls/wait4/wait402.c
@@ -65,7 +65,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(wait4(epid, &status, 0, &rusage));
 
diff --git a/testcases/kernel/syscalls/waitid/waitid01.c b/testcases/kernel/syscalls/waitid/waitid01.c
index 0e54252..0ba53a9 100644
--- a/testcases/kernel/syscalls/waitid/waitid01.c
+++ b/testcases/kernel/syscalls/waitid/waitid01.c
@@ -136,7 +136,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			TEST(fork());
diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index a1ff48c..5995cab 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -130,7 +130,7 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		Tst_count = 0;
+		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			TEST(waitid(P_ALL, 0, &infop, WNOHANG));
diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c b/testcases/kernel/syscalls/waitpid/waitpid01.c
index b26d19a..b85065a 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid01.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
@@ -74,8 +74,8 @@ int main(int argc, char **argv)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		exno = 1;
 		sig = 14;
diff --git a/testcases/kernel/syscalls/waitpid/waitpid02.c b/testcases/kernel/syscalls/waitpid/waitpid02.c
index f40449c..45676d3 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid02.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid02.c
@@ -84,8 +84,8 @@ int main(int argc, char **argv)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		exno = 1;
 		sig = SIGFPE;
diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
index e317ade..b4dce01 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid03.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
@@ -90,9 +90,9 @@ int main(int argc, char **argv)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
+		/* reset tst_count in case we are looping */
 		int ikids = 0;
-		Tst_count = 0;
+		tst_count = 0;
 
 		/*
 		 * Set SIGTERM to SIG_DFL as test driver sets up to ignore
diff --git a/testcases/kernel/syscalls/waitpid/waitpid04.c b/testcases/kernel/syscalls/waitpid/waitpid04.c
index 517569d..8fe859b 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid04.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid04.c
@@ -76,8 +76,8 @@ int main(int ac, char **av)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		ret = waitpid(pid, &status, WNOHANG);
 		flag = 0;
diff --git a/testcases/kernel/syscalls/waitpid/waitpid05.c b/testcases/kernel/syscalls/waitpid/waitpid05.c
index fc0f961..1eb06cc 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid05.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid05.c
@@ -93,8 +93,8 @@ int main(int ac, char **av)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		/*
 		 * Set SIGTERM to SIG_DFL as test driver sets up to ignore
diff --git a/testcases/kernel/syscalls/waitpid/waitpid06.c b/testcases/kernel/syscalls/waitpid/waitpid06.c
index d72e43d..e742ed8 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid06.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid06.c
@@ -94,8 +94,8 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		pid = FORK_OR_VFORK();
 		if (pid < 0) {
diff --git a/testcases/kernel/syscalls/waitpid/waitpid07.c b/testcases/kernel/syscalls/waitpid/waitpid07.c
index 844c5c2..d94d263 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid07.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid07.c
@@ -97,8 +97,8 @@ int main(int argc, char **argv)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		pid = FORK_OR_VFORK();
 		if (pid < 0) {
diff --git a/testcases/kernel/syscalls/waitpid/waitpid08.c b/testcases/kernel/syscalls/waitpid/waitpid08.c
index b4a0844..a3dc9e8 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid08.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid08.c
@@ -95,8 +95,8 @@ int main(int argc, char **argv)
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		fail = 0;
 
 		pid = FORK_OR_VFORK();
diff --git a/testcases/kernel/syscalls/waitpid/waitpid09.c b/testcases/kernel/syscalls/waitpid/waitpid09.c
index 94b1410..28252a7 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid09.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid09.c
@@ -110,8 +110,8 @@ int main(int argc, char **argv)
 
 		/* check for looping state if -i option is given */
 		for (lc = 0; TEST_LOOPING(lc); lc++) {
-			/* reset Tst_count in case we are looping */
-			Tst_count = 0;
+			/* reset tst_count in case we are looping */
+			tst_count = 0;
 
 			intintr = 0;
 
diff --git a/testcases/kernel/syscalls/waitpid/waitpid10.c b/testcases/kernel/syscalls/waitpid/waitpid10.c
index 9f9101d..2a9598e 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid10.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid10.c
@@ -128,8 +128,8 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 		fail = 0;
 
 		if (signal(SIGALRM, alrmhandlr) == SIG_ERR) {
diff --git a/testcases/kernel/syscalls/waitpid/waitpid11.c b/testcases/kernel/syscalls/waitpid/waitpid11.c
index a130d38..bcc3686 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid11.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
@@ -86,7 +86,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 	fail = 0;
 
 	/*
diff --git a/testcases/kernel/syscalls/waitpid/waitpid12.c b/testcases/kernel/syscalls/waitpid/waitpid12.c
index f7ad898..e4af9a7 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid12.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid12.c
@@ -87,7 +87,7 @@ int main(int argc, char **argv)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 	fail = 0;
 
 	/*
diff --git a/testcases/kernel/syscalls/waitpid/waitpid13.c b/testcases/kernel/syscalls/waitpid/waitpid13.c
index 5d53463..c252332 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid13.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid13.c
@@ -87,7 +87,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	Tst_count = 0;
+	tst_count = 0;
 	fail = 0;
 
 	/*
diff --git a/testcases/kernel/syscalls/write/write01.c b/testcases/kernel/syscalls/write/write01.c
index f91d43d..fdefca1 100644
--- a/testcases/kernel/syscalls/write/write01.c
+++ b/testcases/kernel/syscalls/write/write01.c
@@ -148,7 +148,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		TEST(write(fd, &buf, 1));
 
diff --git a/testcases/kernel/syscalls/write/write02.c b/testcases/kernel/syscalls/write/write02.c
index 1a6b859..1092761 100644
--- a/testcases/kernel/syscalls/write/write02.c
+++ b/testcases/kernel/syscalls/write/write02.c
@@ -82,8 +82,8 @@ int main(int argc, char **argv)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //block1:
 		tst_resm(TINFO, "Block 1: test to see write() returns proper "
diff --git a/testcases/kernel/syscalls/write/write03.c b/testcases/kernel/syscalls/write/write03.c
index f1a1943..9aad4d4 100644
--- a/testcases/kernel/syscalls/write/write03.c
+++ b/testcases/kernel/syscalls/write/write03.c
@@ -88,8 +88,8 @@ int main(int argc, char **argv)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //block1:
 		tst_resm(TINFO, "Enter Block 1: test to check if write "
diff --git a/testcases/kernel/syscalls/write/write04.c b/testcases/kernel/syscalls/write/write04.c
index e85ac75..f2ce252 100644
--- a/testcases/kernel/syscalls/write/write04.c
+++ b/testcases/kernel/syscalls/write/write04.c
@@ -92,8 +92,8 @@ int main(int argc, char **argv)
 	 * The following loop checks looping state if -i option given
 	 */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		if (mknod(fifo, S_IFIFO | 0777, 0) < 0) {
 			tst_resm(TBROK, "mknod() failed, errno: %d", errno);
diff --git a/testcases/kernel/syscalls/write/write05.c b/testcases/kernel/syscalls/write/write05.c
index dd73f28..ad36c78 100644
--- a/testcases/kernel/syscalls/write/write05.c
+++ b/testcases/kernel/syscalls/write/write05.c
@@ -94,8 +94,8 @@ int main(int argc, char **argv)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 //block1:
 		tst_resm(TINFO, "Enter Block 1: test with bad fd");
diff --git a/testcases/kernel/syscalls/writev/writev01.c b/testcases/kernel/syscalls/writev/writev01.c
index 8bb8d6f..c55bb02 100644
--- a/testcases/kernel/syscalls/writev/writev01.c
+++ b/testcases/kernel/syscalls/writev/writev01.c
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		buf_list[0] = buf1;
 		buf_list[1] = buf2;
diff --git a/testcases/kernel/syscalls/writev/writev02.c b/testcases/kernel/syscalls/writev/writev02.c
index 3efdf33..792bbb1 100644
--- a/testcases/kernel/syscalls/writev/writev02.c
+++ b/testcases/kernel/syscalls/writev/writev02.c
@@ -107,7 +107,7 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		buf_list[0] = buf1;
 		buf_list[1] = buf2;
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 460a7c2..ac92429 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -102,7 +102,7 @@ int main(int argc, char **argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		buf_list[0] = buf1;
 		buf_list[1] = buf2;
diff --git a/testcases/kernel/syscalls/writev/writev04.c b/testcases/kernel/syscalls/writev/writev04.c
index 7bb3491..5a6e251 100644
--- a/testcases/kernel/syscalls/writev/writev04.c
+++ b/testcases/kernel/syscalls/writev/writev04.c
@@ -108,8 +108,8 @@ int main(int argc, char **argv)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		buf_list[0] = buf1;
 		buf_list[1] = buf2;
diff --git a/testcases/kernel/syscalls/writev/writev05.c b/testcases/kernel/syscalls/writev/writev05.c
index 57443e4..f9a14c8 100644
--- a/testcases/kernel/syscalls/writev/writev05.c
+++ b/testcases/kernel/syscalls/writev/writev05.c
@@ -106,8 +106,8 @@ int main(int argc, char **argv)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		buf_list[0] = buf1;
 		buf_list[1] = buf2;
diff --git a/testcases/kernel/syscalls/writev/writev06.c b/testcases/kernel/syscalls/writev/writev06.c
index 252a87f..f05fed2 100644
--- a/testcases/kernel/syscalls/writev/writev06.c
+++ b/testcases/kernel/syscalls/writev/writev06.c
@@ -94,8 +94,8 @@ int main(int argc, char **argv)
 	/* The following loop checks looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		/* reset Tst_count in case we are looping */
-		Tst_count = 0;
+		/* reset tst_count in case we are looping */
+		tst_count = 0;
 
 		fd[1] = -1;	/* Invalid file descriptor */
 
diff --git a/testcases/kernel/timers/clock_gettime/clock_gettime02.c b/testcases/kernel/timers/clock_gettime/clock_gettime02.c
index 94baef3..351c0c0 100644
--- a/testcases/kernel/timers/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/timers/clock_gettime/clock_gettime02.c
@@ -93,7 +93,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(ltp_syscall(__NR_clock_gettime, clocks[i], &spec));
diff --git a/testcases/kernel/timers/clock_gettime/clock_gettime03.c b/testcases/kernel/timers/clock_gettime/clock_gettime03.c
index a976702..31865d5 100644
--- a/testcases/kernel/timers/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/timers/clock_gettime/clock_gettime03.c
@@ -125,7 +125,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			temp = &spec;
diff --git a/testcases/kernel/timers/clock_settime/clock_settime02.c b/testcases/kernel/timers/clock_settime/clock_settime02.c
index ade05d1..5fa8f5b 100644
--- a/testcases/kernel/timers/clock_settime/clock_settime02.c
+++ b/testcases/kernel/timers/clock_settime/clock_settime02.c
@@ -92,7 +92,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		spec.tv_sec = 1;
 		spec.tv_nsec = 0;
diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
index 6ae0389..a949303 100644
--- a/testcases/kernel/timers/clock_settime/clock_settime03.c
+++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
@@ -85,7 +85,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/timers/leapsec/leapsec_timer.c b/testcases/kernel/timers/leapsec/leapsec_timer.c
index 2e7f715..1cf7935 100644
--- a/testcases/kernel/timers/leapsec/leapsec_timer.c
+++ b/testcases/kernel/timers/leapsec/leapsec_timer.c
@@ -59,7 +59,7 @@ int main(int argc, char **argv)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 		run_leapsec();
 	}
 
diff --git a/testcases/kernel/timers/timer_create/timer_create02.c b/testcases/kernel/timers/timer_create/timer_create02.c
index 57424fe..b06446a 100644
--- a/testcases/kernel/timers/timer_create/timer_create02.c
+++ b/testcases/kernel/timers/timer_create/timer_create02.c
@@ -99,7 +99,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/timers/timer_create/timer_create03.c b/testcases/kernel/timers/timer_create/timer_create03.c
index b4de179..a9f26a1 100644
--- a/testcases/kernel/timers/timer_create/timer_create03.c
+++ b/testcases/kernel/timers/timer_create/timer_create03.c
@@ -112,7 +112,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/timers/timer_create/timer_create04.c b/testcases/kernel/timers/timer_create/timer_create04.c
index e6a5f6e..4fc6208 100644
--- a/testcases/kernel/timers/timer_create/timer_create04.c
+++ b/testcases/kernel/timers/timer_create/timer_create04.c
@@ -140,7 +140,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/timers/timer_delete/timer_delete02.c b/testcases/kernel/timers/timer_delete/timer_delete02.c
index 876c339..c8aa06d 100644
--- a/testcases/kernel/timers/timer_delete/timer_delete02.c
+++ b/testcases/kernel/timers/timer_delete/timer_delete02.c
@@ -92,12 +92,12 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		/* Create a Posix timer */
 		if (ltp_syscall(__NR_timer_create, CLOCK_REALTIME, NULL,
 			&timer_id) < 0) {
-			Tst_count = TST_TOTAL;
+			tst_count = TST_TOTAL;
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "timer_delete can't be tested because "
 				 "timer_create failed");
diff --git a/testcases/kernel/timers/timer_delete/timer_delete03.c b/testcases/kernel/timers/timer_delete/timer_delete03.c
index 6441ef2..90b93fd 100644
--- a/testcases/kernel/timers/timer_delete/timer_delete03.c
+++ b/testcases/kernel/timers/timer_delete/timer_delete03.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/timers/timer_settime/timer_settime02.c b/testcases/kernel/timers/timer_settime/timer_settime02.c
index 01767eb..2c0fd91 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime02.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime02.c
@@ -96,7 +96,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/kernel/timers/timer_settime/timer_settime03.c b/testcases/kernel/timers/timer_settime/timer_settime03.c
index dbabd86..93bb215 100644
--- a/testcases/kernel/timers/timer_settime/timer_settime03.c
+++ b/testcases/kernel/timers/timer_settime/timer_settime03.c
@@ -109,7 +109,7 @@ int main(int ac, char **av)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
-		Tst_count = 0;
+		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
diff --git a/testcases/misc/crash/crash01.c b/testcases/misc/crash/crash01.c
index b1ecc3d..95656f6 100644
--- a/testcases/misc/crash/crash01.c
+++ b/testcases/misc/crash/crash01.c
@@ -187,7 +187,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		tst_resm(TINFO, "crashme %s%d.%d %d %d",
 			 (malloc_flag == 0) ? "" : "+", nbytes, incptr, nseed,
diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
index b6309cc..431766e 100644
--- a/testcases/misc/crash/crash02.c
+++ b/testcases/misc/crash/crash02.c
@@ -167,7 +167,7 @@ int main(int argc, char *argv[])
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		Tst_count = 0;
+		tst_count = 0;
 
 		tst_resm(TINFO, "crashme02 %d %d %d", sysno_max, nseed, ntries);
 
diff --git a/testcases/misc/tcore_patch_test_suites/tcore.c b/testcases/misc/tcore_patch_test_suites/tcore.c
index d5ac14a..4578448 100644
--- a/testcases/misc/tcore_patch_test_suites/tcore.c
+++ b/testcases/misc/tcore_patch_test_suites/tcore.c
@@ -22,7 +22,7 @@
 #include "usctest.h"
 
 /* Extern Global Variables */
-extern int Tst_count;
+extern int tst_count;
 extern char *TESTDIR;		/* temporary dir created by tst_tmpdir() */
 /* Global Variables */
 char *TCID = "tcore";		/* test program identifier.              */
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 40965ab..e2b0061 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -58,9 +58,9 @@
  *               TCID and TST_TOTAL were set did not print usage message.
  *               Modified code to print usage message in each case.
  * Dec 16 2002 - Modified - Code to get the test number, gets environment
- *               variable TST_COUNT and initializes Tst_count.
+ *               variable TST_COUNT and initializes tst_count.
  * Dec 16 2002 - Documentation and comment changes.
- * Feb 11 2003 - Tst_count was set to -1 during init or setup in the script.
+ * Feb 11 2003 - tst_count was set to -1 during init or setup in the script.
  *               this was causing tst_resm to issue a warning message.
  *               This bug is now fixed.
  *
@@ -128,7 +128,7 @@ int ident_ttype(char *tstype)
  *              set the value for TST_TOTAL for total number of tests this is
  *              required in case one test breaks and all following tests also
  *              should be reported as broken.
- *              Set Tst_count before every individual test.
+ *              Set tst_count before every individual test.
  *
  * Exit:        0 on success
  *              -1 on failure
@@ -139,7 +139,7 @@ int main(int argc, char *argv[])
 	char *arg_fmt;		/* message string printed along with test type */
 	char *cmd_name;		/* name by which this program is invoked tst_brk etc */
 	char *tst_total;	/* total number of tests in the file. */
-	char *tst_count;	/* sets the value of Tst_count with this value */
+	char *tst_cntstr;	/* sets the value of tst_count with this value */
 	char *file_name;	/* contents of this file are printed; see tst_res() */
 
 	arg_fmt = SAFE_MALLOC(NULL, 1024);
@@ -149,8 +149,8 @@ int main(int argc, char *argv[])
 
 	TCID = getenv("TCID");
 	tst_total = getenv("TST_TOTAL");
-	tst_count = getenv("TST_COUNT");
-	if (TCID == NULL || tst_total == NULL || tst_count == NULL) {
+	tst_cntstr = getenv("TST_COUNT");
+	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
 		if (strcmp(cmd_name, "tst_kvercmp") != 0) {
 			fprintf(stderr,
 				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
@@ -162,9 +162,9 @@ int main(int argc, char *argv[])
 		}
 	} else {
 		TST_TOTAL = atoi(tst_total);
-		Tst_count = atoi(tst_count);
-		if (Tst_count > 0)
-			Tst_count--;
+		tst_count = atoi(tst_cntstr);
+		if (tst_count > 0)
+			tst_count--;
 
 		if (strcmp(TCID, " ") == 0) {
 			fprintf(stderr,

--------------1.8.1.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
--------------1.8.1.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.8.1.4--



