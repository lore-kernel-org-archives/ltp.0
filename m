From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Mar 2021 10:51:46 +0000
Subject: [LTP] [PATCH] open_posix_testsuite: use PTS_ prefix instead of LTP_
Message-ID: <20210317105146.25427-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add GPLv2-or-later SPDX in tempfile.h

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 .../definitions/pthread_h/4-1-buildonly.c          |  2 +-
 .../conformance/interfaces/aio_cancel/1-1.c        |  2 +-
 .../conformance/interfaces/aio_cancel/2-1.c        |  2 +-
 .../conformance/interfaces/aio_cancel/2-2.c        |  2 +-
 .../conformance/interfaces/aio_cancel/3-1.c        |  6 +++---
 .../conformance/interfaces/aio_cancel/4-1.c        |  2 +-
 .../conformance/interfaces/aio_cancel/5-1.c        |  2 +-
 .../conformance/interfaces/aio_cancel/6-1.c        |  2 +-
 .../conformance/interfaces/aio_cancel/7-1.c        |  2 +-
 .../conformance/interfaces/aio_cancel/8-1.c        |  2 +-
 .../conformance/interfaces/aio_error/1-1.c         |  2 +-
 .../conformance/interfaces/aio_error/2-1.c         |  2 +-
 .../conformance/interfaces/aio_error/3-1.c         |  2 +-
 .../conformance/interfaces/aio_fsync/14-1.c        |  2 +-
 .../conformance/interfaces/aio_fsync/2-1.c         |  2 +-
 .../conformance/interfaces/aio_fsync/3-1.c         |  2 +-
 .../conformance/interfaces/aio_fsync/4-1.c         |  2 +-
 .../conformance/interfaces/aio_fsync/5-1.c         |  2 +-
 .../conformance/interfaces/aio_fsync/8-1.c         |  2 +-
 .../conformance/interfaces/aio_fsync/8-2.c         |  2 +-
 .../conformance/interfaces/aio_fsync/8-3.c         |  2 +-
 .../conformance/interfaces/aio_fsync/8-4.c         |  2 +-
 .../conformance/interfaces/aio_fsync/9-1.c         |  2 +-
 .../conformance/interfaces/aio_read/1-1.c          |  2 +-
 .../conformance/interfaces/aio_read/11-1.c         |  2 +-
 .../conformance/interfaces/aio_read/11-2.c         |  2 +-
 .../conformance/interfaces/aio_read/3-1.c          |  2 +-
 .../conformance/interfaces/aio_read/3-2.c          |  2 +-
 .../conformance/interfaces/aio_read/4-1.c          |  2 +-
 .../conformance/interfaces/aio_read/5-1.c          |  2 +-
 .../conformance/interfaces/aio_read/7-1.c          |  2 +-
 .../conformance/interfaces/aio_read/9-1.c          |  2 +-
 .../conformance/interfaces/aio_return/1-1.c        |  2 +-
 .../conformance/interfaces/aio_return/2-1.c        |  2 +-
 .../conformance/interfaces/aio_return/3-1.c        |  2 +-
 .../conformance/interfaces/aio_return/3-2.c        |  2 +-
 .../conformance/interfaces/aio_return/4-1.c        |  2 +-
 .../conformance/interfaces/aio_suspend/1-1.c       |  6 +++---
 .../conformance/interfaces/aio_suspend/3-1.c       |  2 +-
 .../conformance/interfaces/aio_suspend/4-1.c       |  2 +-
 .../conformance/interfaces/aio_suspend/9-1.c       |  2 +-
 .../conformance/interfaces/aio_write/1-1.c         |  2 +-
 .../conformance/interfaces/aio_write/1-2.c         |  2 +-
 .../conformance/interfaces/aio_write/2-1.c         |  2 +-
 .../conformance/interfaces/aio_write/3-1.c         |  2 +-
 .../conformance/interfaces/aio_write/5-1.c         |  2 +-
 .../conformance/interfaces/aio_write/7-1.c         |  2 +-
 .../conformance/interfaces/aio_write/8-2.c         |  2 +-
 .../conformance/interfaces/aio_write/9-1.c         |  2 +-
 .../conformance/interfaces/aio_write/9-2.c         |  2 +-
 .../conformance/interfaces/fsync/4-1.c             |  2 +-
 .../conformance/interfaces/lio_listio/1-1.c        |  8 ++++----
 .../conformance/interfaces/lio_listio/10-1.c       | 12 ++++++------
 .../conformance/interfaces/lio_listio/12-1.c       |  2 +-
 .../conformance/interfaces/lio_listio/13-1.c       |  2 +-
 .../conformance/interfaces/lio_listio/14-1.c       | 14 +++++++-------
 .../conformance/interfaces/lio_listio/15-1.c       | 14 +++++++-------
 .../conformance/interfaces/lio_listio/18-1.c       |  2 +-
 .../conformance/interfaces/lio_listio/2-1.c        | 12 ++++++------
 .../conformance/interfaces/lio_listio/3-1.c        | 12 ++++++------
 .../conformance/interfaces/lio_listio/4-1.c        | 14 +++++++-------
 .../conformance/interfaces/lio_listio/5-1.c        |  2 +-
 .../conformance/interfaces/lio_listio/7-1.c        | 14 +++++++-------
 .../conformance/interfaces/lio_listio/8-1.c        |  2 +-
 .../conformance/interfaces/lio_listio/9-1.c        |  2 +-
 .../conformance/interfaces/mmap/1-1.c              |  2 +-
 .../conformance/interfaces/mmap/10-1.c             |  2 +-
 .../conformance/interfaces/mmap/11-1.c             |  2 +-
 .../conformance/interfaces/mmap/11-2.c             |  2 +-
 .../conformance/interfaces/mmap/11-4.c             |  4 ++--
 .../conformance/interfaces/mmap/11-6.c             |  2 +-
 .../conformance/interfaces/mmap/12-1.c             |  2 +-
 .../conformance/interfaces/mmap/13-1.c             |  4 ++--
 .../conformance/interfaces/mmap/14-1.c             |  2 +-
 .../conformance/interfaces/mmap/21-1.c             |  2 +-
 .../conformance/interfaces/mmap/27-1.c             |  2 +-
 .../conformance/interfaces/mmap/3-1.c              |  4 ++--
 .../conformance/interfaces/mmap/31-1.c             |  2 +-
 .../conformance/interfaces/mmap/32-1.c             |  2 +-
 .../conformance/interfaces/mmap/5-1.c              |  2 +-
 .../conformance/interfaces/mmap/6-1.c              |  2 +-
 .../conformance/interfaces/mmap/6-2.c              |  2 +-
 .../conformance/interfaces/mmap/6-3.c              |  2 +-
 .../conformance/interfaces/mmap/6-4.c              |  2 +-
 .../conformance/interfaces/mmap/6-5.c              |  2 +-
 .../conformance/interfaces/mmap/6-6.c              |  2 +-
 .../conformance/interfaces/mmap/7-1.c              |  2 +-
 .../conformance/interfaces/mmap/7-2.c              |  2 +-
 .../conformance/interfaces/mmap/9-1.c              |  2 +-
 .../conformance/interfaces/mq_close/2-1.c          |  2 +-
 .../conformance/interfaces/mq_open/16-1.c          |  2 +-
 .../conformance/interfaces/mq_receive/13-1.c       |  2 +-
 .../conformance/interfaces/mq_send/12-1.c          |  2 +-
 .../conformance/interfaces/mq_send/5-2.c           |  2 +-
 .../conformance/interfaces/mq_timedreceive/18-1.c  |  2 +-
 .../conformance/interfaces/mq_timedreceive/18-2.c  |  2 +-
 .../conformance/interfaces/mq_timedreceive/5-2.c   |  2 +-
 .../conformance/interfaces/mq_timedreceive/5-3.c   |  2 +-
 .../conformance/interfaces/mq_timedreceive/8-1.c   |  2 +-
 .../conformance/interfaces/mq_timedsend/12-1.c     |  4 ++--
 .../conformance/interfaces/mq_timedsend/15-1.c     |  2 +-
 .../conformance/interfaces/mq_timedsend/16-1.c     |  2 +-
 .../conformance/interfaces/mq_timedsend/20-1.c     |  2 +-
 .../conformance/interfaces/mq_timedsend/5-1.c      |  2 +-
 .../conformance/interfaces/mq_timedsend/5-2.c      |  2 +-
 .../conformance/interfaces/mq_timedsend/5-3.c      |  2 +-
 .../conformance/interfaces/mq_unlink/2-1.c         |  2 +-
 .../conformance/interfaces/mq_unlink/2-2.c         |  2 +-
 .../conformance/interfaces/munmap/1-1.c            |  4 ++--
 .../conformance/interfaces/munmap/1-2.c            |  4 ++--
 .../conformance/interfaces/munmap/3-1.c            |  2 +-
 .../conformance/interfaces/munmap/4-1.c            |  2 +-
 .../conformance/interfaces/munmap/9-1.c            |  2 +-
 .../conformance/interfaces/nanosleep/1-3.c         |  2 +-
 .../conformance/interfaces/nanosleep/3-1.c         |  2 +-
 .../conformance/interfaces/nanosleep/5-2.c         |  2 +-
 .../conformance/interfaces/nanosleep/7-1.c         |  2 +-
 .../conformance/interfaces/nanosleep/7-2.c         |  2 +-
 .../conformance/interfaces/pthread_atfork/1-2.c    |  2 +-
 .../conformance/interfaces/pthread_atfork/2-2.c    |  2 +-
 .../conformance/interfaces/pthread_atfork/3-2.c    |  2 +-
 .../conformance/interfaces/pthread_atfork/3-3.c    |  6 +++---
 .../conformance/interfaces/pthread_atfork/4-1.c    |  2 +-
 .../conformance/interfaces/pthread_attr_init/3-1.c |  2 +-
 .../interfaces/pthread_attr_setinheritsched/2-2.c  |  2 +-
 .../interfaces/pthread_attr_setinheritsched/2-3.c  |  2 +-
 .../interfaces/pthread_attr_setinheritsched/2-4.c  |  2 +-
 .../interfaces/pthread_attr_setschedparam/1-3.c    |  2 +-
 .../interfaces/pthread_attr_setschedparam/1-4.c    |  2 +-
 .../interfaces/pthread_attr_setschedpolicy/2-1.c   |  2 +-
 .../interfaces/pthread_barrier_init/4-1.c          |  2 +-
 .../interfaces/pthread_barrier_wait/1-1.c          |  2 +-
 .../interfaces/pthread_barrier_wait/3-1.c          |  2 +-
 .../interfaces/pthread_barrier_wait/3-2.c          |  2 +-
 .../conformance/interfaces/pthread_cancel/2-2.c    |  4 ++--
 .../conformance/interfaces/pthread_cancel/2-3.c    |  4 ++--
 .../conformance/interfaces/pthread_cancel/3-1.c    |  4 ++--
 .../interfaces/pthread_cleanup_pop/1-3.c           |  6 +++---
 .../interfaces/pthread_cond_broadcast/1-1.c        |  2 +-
 .../interfaces/pthread_cond_broadcast/1-2.c        |  4 ++--
 .../interfaces/pthread_cond_broadcast/2-1.c        |  2 +-
 .../interfaces/pthread_cond_broadcast/2-2.c        |  2 +-
 .../interfaces/pthread_cond_broadcast/2-3.c        |  4 ++--
 .../interfaces/pthread_cond_broadcast/4-1.c        |  2 +-
 .../interfaces/pthread_cond_broadcast/4-2.c        |  8 ++++----
 .../interfaces/pthread_cond_destroy/2-1.c          |  2 +-
 .../interfaces/pthread_cond_signal/1-1.c           |  4 ++--
 .../interfaces/pthread_cond_signal/1-2.c           |  2 +-
 .../interfaces/pthread_cond_signal/2-1.c           |  4 ++--
 .../interfaces/pthread_cond_signal/2-2.c           |  2 +-
 .../interfaces/pthread_cond_signal/4-1.c           |  4 ++--
 .../interfaces/pthread_cond_signal/4-2.c           |  8 ++++----
 .../conformance/interfaces/pthread_cond_wait/1-1.c |  4 ++--
 .../conformance/interfaces/pthread_cond_wait/2-1.c |  4 ++--
 .../conformance/interfaces/pthread_cond_wait/2-3.c |  8 ++++----
 .../conformance/interfaces/pthread_cond_wait/3-1.c |  4 ++--
 .../conformance/interfaces/pthread_cond_wait/4-1.c |  8 ++++----
 .../conformance/interfaces/pthread_equal/2-1.c     |  4 ++--
 .../conformance/interfaces/pthread_exit/1-2.c      |  2 +-
 .../conformance/interfaces/pthread_exit/2-2.c      |  2 +-
 .../conformance/interfaces/pthread_exit/3-1.c      |  4 ++--
 .../conformance/interfaces/pthread_exit/3-2.c      |  2 +-
 .../conformance/interfaces/pthread_exit/4-1.c      |  2 +-
 .../conformance/interfaces/pthread_exit/6-1.c      |  2 +-
 .../interfaces/pthread_getschedparam/1-2.c         |  2 +-
 .../conformance/interfaces/pthread_join/4-1.c      |  2 +-
 .../conformance/interfaces/pthread_join/6-3.c      |  8 ++++----
 .../interfaces/pthread_key_create/3-1.c            |  2 +-
 .../interfaces/pthread_key_delete/2-1.c            |  2 +-
 .../conformance/interfaces/pthread_kill/1-2.c      |  2 +-
 .../conformance/interfaces/pthread_kill/6-1.c      |  2 +-
 .../conformance/interfaces/pthread_kill/8-1.c      |  6 +++---
 .../interfaces/pthread_mutex_init/1-2.c            |  6 +++---
 .../interfaces/pthread_mutex_init/3-2.c            |  6 +++---
 .../interfaces/pthread_mutex_lock/1-1.c            |  2 +-
 .../interfaces/pthread_mutex_lock/3-1.c            |  6 +++---
 .../interfaces/pthread_mutex_lock/4-1.c            |  2 +-
 .../interfaces/pthread_mutex_lock/5-1.c            |  4 ++--
 .../interfaces/pthread_mutex_timedlock/1-1.c       |  2 +-
 .../interfaces/pthread_mutex_timedlock/2-1.c       |  2 +-
 .../interfaces/pthread_mutex_timedlock/4-1.c       |  2 +-
 .../interfaces/pthread_mutex_timedlock/5-1.c       |  2 +-
 .../interfaces/pthread_mutex_timedlock/5-2.c       |  2 +-
 .../interfaces/pthread_mutex_timedlock/5-3.c       |  2 +-
 .../interfaces/pthread_mutex_trylock/1-1.c         |  2 +-
 .../interfaces/pthread_mutex_trylock/4-3.c         |  6 +++---
 .../interfaces/pthread_mutex_unlock/2-1.c          |  2 +-
 .../interfaces/pthread_mutex_unlock/5-1.c          |  2 +-
 .../interfaces/pthread_mutexattr_settype/2-1.c     |  2 +-
 .../conformance/interfaces/pthread_once/6-1.c      |  6 +++---
 .../interfaces/pthread_rwlock_init/1-1.c           |  2 +-
 .../interfaces/pthread_rwlock_init/2-1.c           |  2 +-
 .../interfaces/pthread_rwlock_rdlock/1-1.c         |  2 +-
 .../interfaces/pthread_rwlock_rdlock/4-1.c         |  2 +-
 .../interfaces/pthread_rwlock_timedrdlock/1-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedrdlock/2-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedrdlock/3-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedrdlock/5-1.c    |  4 ++--
 .../interfaces/pthread_rwlock_timedrdlock/6-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedrdlock/6-2.c    |  2 +-
 .../interfaces/pthread_rwlock_timedwrlock/1-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedwrlock/2-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedwrlock/3-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedwrlock/5-1.c    |  4 ++--
 .../interfaces/pthread_rwlock_timedwrlock/6-1.c    |  2 +-
 .../interfaces/pthread_rwlock_timedwrlock/6-2.c    |  2 +-
 .../interfaces/pthread_rwlock_tryrdlock/1-1.c      |  4 ++--
 .../interfaces/pthread_rwlock_trywrlock/1-1.c      |  2 +-
 .../interfaces/pthread_rwlock_unlock/1-1.c         |  2 +-
 .../interfaces/pthread_rwlock_unlock/2-1.c         |  2 +-
 .../interfaces/pthread_rwlock_unlock/4-2.c         |  2 +-
 .../interfaces/pthread_rwlock_wrlock/1-1.c         |  2 +-
 .../interfaces/pthread_rwlock_wrlock/2-1.c         |  2 +-
 .../interfaces/pthread_setschedparam/4-1.c         |  2 +-
 .../interfaces/pthread_setschedparam/5-1.c         |  4 ++--
 .../conformance/interfaces/pthread_sigmask/18-1.c  |  6 +++---
 .../conformance/interfaces/pthread_sigmask/4-1.c   |  2 +-
 .../conformance/interfaces/pthread_sigmask/5-1.c   |  2 +-
 .../conformance/interfaces/pthread_sigmask/6-1.c   |  2 +-
 .../conformance/interfaces/pthread_sigmask/9-1.c   |  2 +-
 .../interfaces/pthread_spin_destroy/3-1.c          |  2 +-
 .../conformance/interfaces/pthread_spin_init/4-1.c |  2 +-
 .../conformance/interfaces/raise/1-1.c             |  2 +-
 .../conformance/interfaces/raise/1-2.c             |  4 ++--
 .../conformance/interfaces/raise/10000-1.c         |  2 +-
 .../conformance/interfaces/raise/2-1.c             |  2 +-
 .../conformance/interfaces/raise/4-1.c             |  2 +-
 .../conformance/interfaces/sched_setparam/2-1.c    |  2 +-
 .../conformance/interfaces/sched_setparam/2-2.c    |  2 +-
 .../conformance/interfaces/sched_setparam/20-1.c   |  2 +-
 .../conformance/interfaces/sched_setparam/21-1.c   |  2 +-
 .../conformance/interfaces/sched_setparam/21-2.c   |  2 +-
 .../conformance/interfaces/sem_post/5-1.c          |  2 +-
 .../conformance/interfaces/sem_post/6-1.c          |  2 +-
 .../conformance/interfaces/sem_timedwait/9-1.c     |  2 +-
 .../conformance/interfaces/sem_wait/13-1.c         |  2 +-
 .../conformance/interfaces/sem_wait/7-1.c          |  2 +-
 .../conformance/interfaces/sigaction/1-1.c         |  2 +-
 .../conformance/interfaces/sigaction/1-10.c        |  2 +-
 .../conformance/interfaces/sigaction/1-11.c        |  2 +-
 .../conformance/interfaces/sigaction/1-12.c        |  2 +-
 .../conformance/interfaces/sigaction/1-13.c        |  2 +-
 .../conformance/interfaces/sigaction/1-14.c        |  2 +-
 .../conformance/interfaces/sigaction/1-15.c        |  2 +-
 .../conformance/interfaces/sigaction/1-16.c        |  2 +-
 .../conformance/interfaces/sigaction/1-17.c        |  2 +-
 .../conformance/interfaces/sigaction/1-18.c        |  2 +-
 .../conformance/interfaces/sigaction/1-19.c        |  2 +-
 .../conformance/interfaces/sigaction/1-2.c         |  2 +-
 .../conformance/interfaces/sigaction/1-20.c        |  2 +-
 .../conformance/interfaces/sigaction/1-21.c        |  2 +-
 .../conformance/interfaces/sigaction/1-22.c        |  2 +-
 .../conformance/interfaces/sigaction/1-23.c        |  2 +-
 .../conformance/interfaces/sigaction/1-24.c        |  2 +-
 .../conformance/interfaces/sigaction/1-25.c        |  2 +-
 .../conformance/interfaces/sigaction/1-26.c        |  2 +-
 .../conformance/interfaces/sigaction/1-3.c         |  2 +-
 .../conformance/interfaces/sigaction/1-4.c         |  2 +-
 .../conformance/interfaces/sigaction/1-5.c         |  2 +-
 .../conformance/interfaces/sigaction/1-6.c         |  2 +-
 .../conformance/interfaces/sigaction/1-7.c         |  2 +-
 .../conformance/interfaces/sigaction/1-8.c         |  2 +-
 .../conformance/interfaces/sigaction/1-9.c         |  2 +-
 .../conformance/interfaces/sigaction/10-1.c        |  4 ++--
 .../conformance/interfaces/sigaction/11-1.c        |  4 ++--
 .../conformance/interfaces/sigaction/12-1.c        |  2 +-
 .../conformance/interfaces/sigaction/12-10.c       |  2 +-
 .../conformance/interfaces/sigaction/12-11.c       |  2 +-
 .../conformance/interfaces/sigaction/12-12.c       |  2 +-
 .../conformance/interfaces/sigaction/12-13.c       |  2 +-
 .../conformance/interfaces/sigaction/12-14.c       |  2 +-
 .../conformance/interfaces/sigaction/12-15.c       |  2 +-
 .../conformance/interfaces/sigaction/12-16.c       |  2 +-
 .../conformance/interfaces/sigaction/12-17.c       |  2 +-
 .../conformance/interfaces/sigaction/12-18.c       |  2 +-
 .../conformance/interfaces/sigaction/12-19.c       |  2 +-
 .../conformance/interfaces/sigaction/12-2.c        |  2 +-
 .../conformance/interfaces/sigaction/12-20.c       |  2 +-
 .../conformance/interfaces/sigaction/12-21.c       |  2 +-
 .../conformance/interfaces/sigaction/12-22.c       |  2 +-
 .../conformance/interfaces/sigaction/12-23.c       |  2 +-
 .../conformance/interfaces/sigaction/12-24.c       |  2 +-
 .../conformance/interfaces/sigaction/12-25.c       |  2 +-
 .../conformance/interfaces/sigaction/12-26.c       |  2 +-
 .../conformance/interfaces/sigaction/12-27.c       |  2 +-
 .../conformance/interfaces/sigaction/12-28.c       |  2 +-
 .../conformance/interfaces/sigaction/12-29.c       |  2 +-
 .../conformance/interfaces/sigaction/12-3.c        |  2 +-
 .../conformance/interfaces/sigaction/12-30.c       |  2 +-
 .../conformance/interfaces/sigaction/12-31.c       |  2 +-
 .../conformance/interfaces/sigaction/12-32.c       |  2 +-
 .../conformance/interfaces/sigaction/12-33.c       |  2 +-
 .../conformance/interfaces/sigaction/12-34.c       |  2 +-
 .../conformance/interfaces/sigaction/12-35.c       |  2 +-
 .../conformance/interfaces/sigaction/12-36.c       |  2 +-
 .../conformance/interfaces/sigaction/12-37.c       |  2 +-
 .../conformance/interfaces/sigaction/12-38.c       |  2 +-
 .../conformance/interfaces/sigaction/12-39.c       |  2 +-
 .../conformance/interfaces/sigaction/12-4.c        |  2 +-
 .../conformance/interfaces/sigaction/12-40.c       |  2 +-
 .../conformance/interfaces/sigaction/12-41.c       |  2 +-
 .../conformance/interfaces/sigaction/12-42.c       |  2 +-
 .../conformance/interfaces/sigaction/12-43.c       |  2 +-
 .../conformance/interfaces/sigaction/12-44.c       |  2 +-
 .../conformance/interfaces/sigaction/12-45.c       |  2 +-
 .../conformance/interfaces/sigaction/12-46.c       |  2 +-
 .../conformance/interfaces/sigaction/12-47.c       |  2 +-
 .../conformance/interfaces/sigaction/12-48.c       |  2 +-
 .../conformance/interfaces/sigaction/12-49.c       |  2 +-
 .../conformance/interfaces/sigaction/12-5.c        |  2 +-
 .../conformance/interfaces/sigaction/12-50.c       |  2 +-
 .../conformance/interfaces/sigaction/12-51.c       |  2 +-
 .../conformance/interfaces/sigaction/12-52.c       |  2 +-
 .../conformance/interfaces/sigaction/12-6.c        |  2 +-
 .../conformance/interfaces/sigaction/12-7.c        |  2 +-
 .../conformance/interfaces/sigaction/12-8.c        |  2 +-
 .../conformance/interfaces/sigaction/12-9.c        |  2 +-
 .../conformance/interfaces/sigaction/13-1.c        |  2 +-
 .../conformance/interfaces/sigaction/13-10.c       |  2 +-
 .../conformance/interfaces/sigaction/13-11.c       |  2 +-
 .../conformance/interfaces/sigaction/13-12.c       |  2 +-
 .../conformance/interfaces/sigaction/13-13.c       |  2 +-
 .../conformance/interfaces/sigaction/13-14.c       |  2 +-
 .../conformance/interfaces/sigaction/13-15.c       |  2 +-
 .../conformance/interfaces/sigaction/13-16.c       |  2 +-
 .../conformance/interfaces/sigaction/13-17.c       |  2 +-
 .../conformance/interfaces/sigaction/13-18.c       |  2 +-
 .../conformance/interfaces/sigaction/13-19.c       |  2 +-
 .../conformance/interfaces/sigaction/13-2.c        |  2 +-
 .../conformance/interfaces/sigaction/13-20.c       |  2 +-
 .../conformance/interfaces/sigaction/13-21.c       |  2 +-
 .../conformance/interfaces/sigaction/13-22.c       |  2 +-
 .../conformance/interfaces/sigaction/13-23.c       |  2 +-
 .../conformance/interfaces/sigaction/13-24.c       |  2 +-
 .../conformance/interfaces/sigaction/13-25.c       |  2 +-
 .../conformance/interfaces/sigaction/13-26.c       |  2 +-
 .../conformance/interfaces/sigaction/13-3.c        |  2 +-
 .../conformance/interfaces/sigaction/13-4.c        |  2 +-
 .../conformance/interfaces/sigaction/13-5.c        |  2 +-
 .../conformance/interfaces/sigaction/13-6.c        |  2 +-
 .../conformance/interfaces/sigaction/13-7.c        |  2 +-
 .../conformance/interfaces/sigaction/13-8.c        |  2 +-
 .../conformance/interfaces/sigaction/13-9.c        |  2 +-
 .../conformance/interfaces/sigaction/17-1.c        |  2 +-
 .../conformance/interfaces/sigaction/17-10.c       |  2 +-
 .../conformance/interfaces/sigaction/17-11.c       |  2 +-
 .../conformance/interfaces/sigaction/17-12.c       |  2 +-
 .../conformance/interfaces/sigaction/17-13.c       |  2 +-
 .../conformance/interfaces/sigaction/17-14.c       |  2 +-
 .../conformance/interfaces/sigaction/17-15.c       |  2 +-
 .../conformance/interfaces/sigaction/17-16.c       |  2 +-
 .../conformance/interfaces/sigaction/17-17.c       |  2 +-
 .../conformance/interfaces/sigaction/17-18.c       |  2 +-
 .../conformance/interfaces/sigaction/17-19.c       |  2 +-
 .../conformance/interfaces/sigaction/17-2.c        |  2 +-
 .../conformance/interfaces/sigaction/17-20.c       |  2 +-
 .../conformance/interfaces/sigaction/17-21.c       |  2 +-
 .../conformance/interfaces/sigaction/17-22.c       |  2 +-
 .../conformance/interfaces/sigaction/17-23.c       |  2 +-
 .../conformance/interfaces/sigaction/17-24.c       |  2 +-
 .../conformance/interfaces/sigaction/17-25.c       |  2 +-
 .../conformance/interfaces/sigaction/17-26.c       |  2 +-
 .../conformance/interfaces/sigaction/17-3.c        |  2 +-
 .../conformance/interfaces/sigaction/17-4.c        |  2 +-
 .../conformance/interfaces/sigaction/17-5.c        |  2 +-
 .../conformance/interfaces/sigaction/17-6.c        |  2 +-
 .../conformance/interfaces/sigaction/17-7.c        |  2 +-
 .../conformance/interfaces/sigaction/17-8.c        |  2 +-
 .../conformance/interfaces/sigaction/17-9.c        |  2 +-
 .../conformance/interfaces/sigaction/2-1.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-10.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-11.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-12.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-13.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-14.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-15.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-16.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-17.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-18.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-19.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-2.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-20.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-21.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-22.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-23.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-24.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-25.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-26.c        |  4 ++--
 .../conformance/interfaces/sigaction/2-3.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-4.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-5.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-6.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-7.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-8.c         |  4 ++--
 .../conformance/interfaces/sigaction/2-9.c         |  4 ++--
 .../conformance/interfaces/sigaction/21-1.c        |  2 +-
 .../conformance/interfaces/sigaction/22-1.c        |  2 +-
 .../conformance/interfaces/sigaction/22-10.c       |  2 +-
 .../conformance/interfaces/sigaction/22-11.c       |  2 +-
 .../conformance/interfaces/sigaction/22-12.c       |  2 +-
 .../conformance/interfaces/sigaction/22-13.c       |  2 +-
 .../conformance/interfaces/sigaction/22-14.c       |  2 +-
 .../conformance/interfaces/sigaction/22-15.c       |  2 +-
 .../conformance/interfaces/sigaction/22-16.c       |  2 +-
 .../conformance/interfaces/sigaction/22-17.c       |  2 +-
 .../conformance/interfaces/sigaction/22-18.c       |  2 +-
 .../conformance/interfaces/sigaction/22-19.c       |  2 +-
 .../conformance/interfaces/sigaction/22-2.c        |  2 +-
 .../conformance/interfaces/sigaction/22-20.c       |  2 +-
 .../conformance/interfaces/sigaction/22-21.c       |  2 +-
 .../conformance/interfaces/sigaction/22-22.c       |  2 +-
 .../conformance/interfaces/sigaction/22-23.c       |  2 +-
 .../conformance/interfaces/sigaction/22-24.c       |  2 +-
 .../conformance/interfaces/sigaction/22-25.c       |  2 +-
 .../conformance/interfaces/sigaction/22-26.c       |  2 +-
 .../conformance/interfaces/sigaction/22-3.c        |  2 +-
 .../conformance/interfaces/sigaction/22-4.c        |  2 +-
 .../conformance/interfaces/sigaction/22-5.c        |  2 +-
 .../conformance/interfaces/sigaction/22-6.c        |  2 +-
 .../conformance/interfaces/sigaction/22-7.c        |  2 +-
 .../conformance/interfaces/sigaction/22-8.c        |  2 +-
 .../conformance/interfaces/sigaction/22-9.c        |  2 +-
 .../conformance/interfaces/sigaction/23-1.c        |  2 +-
 .../conformance/interfaces/sigaction/23-10.c       |  2 +-
 .../conformance/interfaces/sigaction/23-11.c       |  2 +-
 .../conformance/interfaces/sigaction/23-12.c       |  2 +-
 .../conformance/interfaces/sigaction/23-13.c       |  2 +-
 .../conformance/interfaces/sigaction/23-14.c       |  2 +-
 .../conformance/interfaces/sigaction/23-15.c       |  2 +-
 .../conformance/interfaces/sigaction/23-16.c       |  2 +-
 .../conformance/interfaces/sigaction/23-17.c       |  2 +-
 .../conformance/interfaces/sigaction/23-18.c       |  2 +-
 .../conformance/interfaces/sigaction/23-19.c       |  2 +-
 .../conformance/interfaces/sigaction/23-2.c        |  2 +-
 .../conformance/interfaces/sigaction/23-20.c       |  2 +-
 .../conformance/interfaces/sigaction/23-21.c       |  2 +-
 .../conformance/interfaces/sigaction/23-22.c       |  2 +-
 .../conformance/interfaces/sigaction/23-23.c       |  2 +-
 .../conformance/interfaces/sigaction/23-24.c       |  2 +-
 .../conformance/interfaces/sigaction/23-25.c       |  2 +-
 .../conformance/interfaces/sigaction/23-26.c       |  2 +-
 .../conformance/interfaces/sigaction/23-3.c        |  2 +-
 .../conformance/interfaces/sigaction/23-4.c        |  2 +-
 .../conformance/interfaces/sigaction/23-5.c        |  2 +-
 .../conformance/interfaces/sigaction/23-6.c        |  2 +-
 .../conformance/interfaces/sigaction/23-7.c        |  2 +-
 .../conformance/interfaces/sigaction/23-8.c        |  2 +-
 .../conformance/interfaces/sigaction/23-9.c        |  2 +-
 .../conformance/interfaces/sigaction/25-1.c        |  2 +-
 .../conformance/interfaces/sigaction/25-10.c       |  2 +-
 .../conformance/interfaces/sigaction/25-11.c       |  2 +-
 .../conformance/interfaces/sigaction/25-12.c       |  2 +-
 .../conformance/interfaces/sigaction/25-13.c       |  2 +-
 .../conformance/interfaces/sigaction/25-14.c       |  2 +-
 .../conformance/interfaces/sigaction/25-15.c       |  2 +-
 .../conformance/interfaces/sigaction/25-16.c       |  2 +-
 .../conformance/interfaces/sigaction/25-17.c       |  2 +-
 .../conformance/interfaces/sigaction/25-18.c       |  2 +-
 .../conformance/interfaces/sigaction/25-19.c       |  2 +-
 .../conformance/interfaces/sigaction/25-2.c        |  2 +-
 .../conformance/interfaces/sigaction/25-20.c       |  2 +-
 .../conformance/interfaces/sigaction/25-21.c       |  2 +-
 .../conformance/interfaces/sigaction/25-22.c       |  2 +-
 .../conformance/interfaces/sigaction/25-23.c       |  2 +-
 .../conformance/interfaces/sigaction/25-24.c       |  2 +-
 .../conformance/interfaces/sigaction/25-25.c       |  2 +-
 .../conformance/interfaces/sigaction/25-26.c       |  2 +-
 .../conformance/interfaces/sigaction/25-3.c        |  2 +-
 .../conformance/interfaces/sigaction/25-4.c        |  2 +-
 .../conformance/interfaces/sigaction/25-5.c        |  2 +-
 .../conformance/interfaces/sigaction/25-6.c        |  2 +-
 .../conformance/interfaces/sigaction/25-7.c        |  2 +-
 .../conformance/interfaces/sigaction/25-8.c        |  2 +-
 .../conformance/interfaces/sigaction/25-9.c        |  2 +-
 .../conformance/interfaces/sigaction/29-1.c        |  4 ++--
 .../conformance/interfaces/sigaction/3-1.c         |  2 +-
 .../conformance/interfaces/sigaction/3-10.c        |  2 +-
 .../conformance/interfaces/sigaction/3-11.c        |  2 +-
 .../conformance/interfaces/sigaction/3-12.c        |  2 +-
 .../conformance/interfaces/sigaction/3-13.c        |  2 +-
 .../conformance/interfaces/sigaction/3-14.c        |  2 +-
 .../conformance/interfaces/sigaction/3-15.c        |  2 +-
 .../conformance/interfaces/sigaction/3-16.c        |  2 +-
 .../conformance/interfaces/sigaction/3-17.c        |  2 +-
 .../conformance/interfaces/sigaction/3-18.c        |  2 +-
 .../conformance/interfaces/sigaction/3-19.c        |  2 +-
 .../conformance/interfaces/sigaction/3-2.c         |  2 +-
 .../conformance/interfaces/sigaction/3-20.c        |  2 +-
 .../conformance/interfaces/sigaction/3-21.c        |  2 +-
 .../conformance/interfaces/sigaction/3-22.c        |  2 +-
 .../conformance/interfaces/sigaction/3-23.c        |  2 +-
 .../conformance/interfaces/sigaction/3-24.c        |  2 +-
 .../conformance/interfaces/sigaction/3-25.c        |  2 +-
 .../conformance/interfaces/sigaction/3-26.c        |  2 +-
 .../conformance/interfaces/sigaction/3-3.c         |  2 +-
 .../conformance/interfaces/sigaction/3-4.c         |  2 +-
 .../conformance/interfaces/sigaction/3-5.c         |  2 +-
 .../conformance/interfaces/sigaction/3-6.c         |  2 +-
 .../conformance/interfaces/sigaction/3-7.c         |  2 +-
 .../conformance/interfaces/sigaction/3-8.c         |  2 +-
 .../conformance/interfaces/sigaction/3-9.c         |  2 +-
 .../conformance/interfaces/sigaction/30-1.c        |  2 +-
 .../conformance/interfaces/sigaction/4-1.c         |  2 +-
 .../conformance/interfaces/sigaction/4-10.c        |  2 +-
 .../conformance/interfaces/sigaction/4-100.c       |  2 +-
 .../conformance/interfaces/sigaction/4-101.c       |  2 +-
 .../conformance/interfaces/sigaction/4-102.c       |  2 +-
 .../conformance/interfaces/sigaction/4-103.c       |  2 +-
 .../conformance/interfaces/sigaction/4-104.c       |  2 +-
 .../conformance/interfaces/sigaction/4-11.c        |  2 +-
 .../conformance/interfaces/sigaction/4-12.c        |  2 +-
 .../conformance/interfaces/sigaction/4-13.c        |  2 +-
 .../conformance/interfaces/sigaction/4-14.c        |  2 +-
 .../conformance/interfaces/sigaction/4-15.c        |  2 +-
 .../conformance/interfaces/sigaction/4-16.c        |  2 +-
 .../conformance/interfaces/sigaction/4-17.c        |  2 +-
 .../conformance/interfaces/sigaction/4-18.c        |  2 +-
 .../conformance/interfaces/sigaction/4-19.c        |  2 +-
 .../conformance/interfaces/sigaction/4-2.c         |  2 +-
 .../conformance/interfaces/sigaction/4-20.c        |  2 +-
 .../conformance/interfaces/sigaction/4-21.c        |  2 +-
 .../conformance/interfaces/sigaction/4-22.c        |  2 +-
 .../conformance/interfaces/sigaction/4-23.c        |  2 +-
 .../conformance/interfaces/sigaction/4-24.c        |  2 +-
 .../conformance/interfaces/sigaction/4-25.c        |  2 +-
 .../conformance/interfaces/sigaction/4-26.c        |  2 +-
 .../conformance/interfaces/sigaction/4-27.c        |  2 +-
 .../conformance/interfaces/sigaction/4-28.c        |  2 +-
 .../conformance/interfaces/sigaction/4-29.c        |  2 +-
 .../conformance/interfaces/sigaction/4-3.c         |  2 +-
 .../conformance/interfaces/sigaction/4-30.c        |  2 +-
 .../conformance/interfaces/sigaction/4-31.c        |  2 +-
 .../conformance/interfaces/sigaction/4-32.c        |  2 +-
 .../conformance/interfaces/sigaction/4-33.c        |  2 +-
 .../conformance/interfaces/sigaction/4-34.c        |  2 +-
 .../conformance/interfaces/sigaction/4-35.c        |  2 +-
 .../conformance/interfaces/sigaction/4-36.c        |  2 +-
 .../conformance/interfaces/sigaction/4-37.c        |  2 +-
 .../conformance/interfaces/sigaction/4-38.c        |  2 +-
 .../conformance/interfaces/sigaction/4-39.c        |  2 +-
 .../conformance/interfaces/sigaction/4-4.c         |  2 +-
 .../conformance/interfaces/sigaction/4-40.c        |  2 +-
 .../conformance/interfaces/sigaction/4-41.c        |  2 +-
 .../conformance/interfaces/sigaction/4-42.c        |  2 +-
 .../conformance/interfaces/sigaction/4-43.c        |  2 +-
 .../conformance/interfaces/sigaction/4-44.c        |  2 +-
 .../conformance/interfaces/sigaction/4-45.c        |  2 +-
 .../conformance/interfaces/sigaction/4-46.c        |  2 +-
 .../conformance/interfaces/sigaction/4-47.c        |  2 +-
 .../conformance/interfaces/sigaction/4-48.c        |  2 +-
 .../conformance/interfaces/sigaction/4-49.c        |  2 +-
 .../conformance/interfaces/sigaction/4-5.c         |  2 +-
 .../conformance/interfaces/sigaction/4-50.c        |  2 +-
 .../conformance/interfaces/sigaction/4-51.c        |  2 +-
 .../conformance/interfaces/sigaction/4-52.c        |  2 +-
 .../conformance/interfaces/sigaction/4-53.c        |  2 +-
 .../conformance/interfaces/sigaction/4-54.c        |  2 +-
 .../conformance/interfaces/sigaction/4-55.c        |  2 +-
 .../conformance/interfaces/sigaction/4-56.c        |  2 +-
 .../conformance/interfaces/sigaction/4-57.c        |  2 +-
 .../conformance/interfaces/sigaction/4-58.c        |  2 +-
 .../conformance/interfaces/sigaction/4-59.c        |  2 +-
 .../conformance/interfaces/sigaction/4-6.c         |  2 +-
 .../conformance/interfaces/sigaction/4-60.c        |  2 +-
 .../conformance/interfaces/sigaction/4-61.c        |  2 +-
 .../conformance/interfaces/sigaction/4-62.c        |  2 +-
 .../conformance/interfaces/sigaction/4-63.c        |  2 +-
 .../conformance/interfaces/sigaction/4-64.c        |  2 +-
 .../conformance/interfaces/sigaction/4-65.c        |  2 +-
 .../conformance/interfaces/sigaction/4-66.c        |  2 +-
 .../conformance/interfaces/sigaction/4-67.c        |  2 +-
 .../conformance/interfaces/sigaction/4-68.c        |  2 +-
 .../conformance/interfaces/sigaction/4-69.c        |  2 +-
 .../conformance/interfaces/sigaction/4-7.c         |  2 +-
 .../conformance/interfaces/sigaction/4-70.c        |  2 +-
 .../conformance/interfaces/sigaction/4-71.c        |  2 +-
 .../conformance/interfaces/sigaction/4-72.c        |  2 +-
 .../conformance/interfaces/sigaction/4-73.c        |  2 +-
 .../conformance/interfaces/sigaction/4-74.c        |  2 +-
 .../conformance/interfaces/sigaction/4-75.c        |  2 +-
 .../conformance/interfaces/sigaction/4-76.c        |  2 +-
 .../conformance/interfaces/sigaction/4-77.c        |  2 +-
 .../conformance/interfaces/sigaction/4-78.c        |  2 +-
 .../conformance/interfaces/sigaction/4-79.c        |  2 +-
 .../conformance/interfaces/sigaction/4-8.c         |  2 +-
 .../conformance/interfaces/sigaction/4-80.c        |  2 +-
 .../conformance/interfaces/sigaction/4-81.c        |  2 +-
 .../conformance/interfaces/sigaction/4-82.c        |  2 +-
 .../conformance/interfaces/sigaction/4-83.c        |  2 +-
 .../conformance/interfaces/sigaction/4-84.c        |  2 +-
 .../conformance/interfaces/sigaction/4-85.c        |  2 +-
 .../conformance/interfaces/sigaction/4-86.c        |  2 +-
 .../conformance/interfaces/sigaction/4-87.c        |  2 +-
 .../conformance/interfaces/sigaction/4-88.c        |  2 +-
 .../conformance/interfaces/sigaction/4-89.c        |  2 +-
 .../conformance/interfaces/sigaction/4-9.c         |  2 +-
 .../conformance/interfaces/sigaction/4-90.c        |  2 +-
 .../conformance/interfaces/sigaction/4-91.c        |  2 +-
 .../conformance/interfaces/sigaction/4-92.c        |  2 +-
 .../conformance/interfaces/sigaction/4-93.c        |  2 +-
 .../conformance/interfaces/sigaction/4-94.c        |  2 +-
 .../conformance/interfaces/sigaction/4-95.c        |  2 +-
 .../conformance/interfaces/sigaction/4-96.c        |  2 +-
 .../conformance/interfaces/sigaction/4-97.c        |  2 +-
 .../conformance/interfaces/sigaction/4-98.c        |  2 +-
 .../conformance/interfaces/sigaction/4-99.c        |  2 +-
 .../conformance/interfaces/sigaction/6-1.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-10.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-11.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-12.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-13.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-14.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-15.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-16.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-17.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-18.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-19.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-2.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-20.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-21.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-22.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-23.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-24.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-25.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-26.c        |  6 +++---
 .../conformance/interfaces/sigaction/6-3.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-4.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-5.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-6.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-7.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-8.c         |  6 +++---
 .../conformance/interfaces/sigaction/6-9.c         |  6 +++---
 .../conformance/interfaces/sigaction/8-1.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-10.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-11.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-12.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-13.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-14.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-15.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-16.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-17.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-18.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-19.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-2.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-20.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-21.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-22.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-23.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-24.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-25.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-26.c        |  4 ++--
 .../conformance/interfaces/sigaction/8-3.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-4.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-5.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-6.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-7.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-8.c         |  4 ++--
 .../conformance/interfaces/sigaction/8-9.c         |  4 ++--
 .../conformance/interfaces/sigaction/9-1.c         |  4 ++--
 .../conformance/interfaces/sighold/1-1.c           |  2 +-
 .../conformance/interfaces/sigignore/1-1.c         |  2 +-
 .../conformance/interfaces/signal/1-1.c            |  2 +-
 .../conformance/interfaces/signal/2-1.c            |  2 +-
 .../conformance/interfaces/signal/3-1.c            |  2 +-
 .../conformance/interfaces/signal/5-1.c            |  4 ++--
 .../conformance/interfaces/signal/6-1.c            |  2 +-
 .../conformance/interfaces/signal/7-1.c            |  2 +-
 .../conformance/interfaces/sigpending/1-2.c        |  2 +-
 .../conformance/interfaces/sigpending/1-3.c        |  2 +-
 .../conformance/interfaces/sigprocmask/4-1.c       |  2 +-
 .../conformance/interfaces/sigprocmask/5-1.c       |  2 +-
 .../conformance/interfaces/sigprocmask/6-1.c       |  2 +-
 .../conformance/interfaces/sigprocmask/9-1.c       |  2 +-
 .../conformance/interfaces/sigqueue/1-1.c          |  2 +-
 .../conformance/interfaces/sigqueue/4-1.c          |  6 +++---
 .../conformance/interfaces/sigqueue/5-1.c          |  2 +-
 .../conformance/interfaces/sigqueue/6-1.c          |  6 +++---
 .../conformance/interfaces/sigqueue/7-1.c          |  4 ++--
 .../conformance/interfaces/sigqueue/8-1.c          |  6 +++---
 .../conformance/interfaces/sigrelse/1-1.c          |  2 +-
 .../conformance/interfaces/sigset/1-1.c            |  2 +-
 .../conformance/interfaces/sigset/2-1.c            |  2 +-
 .../conformance/interfaces/sigset/3-1.c            |  2 +-
 .../conformance/interfaces/sigset/4-1.c            |  2 +-
 .../conformance/interfaces/sigset/5-1.c            |  2 +-
 .../conformance/interfaces/sigset/6-1.c            |  2 +-
 .../conformance/interfaces/sigset/7-1.c            |  2 +-
 .../conformance/interfaces/sigset/9-1.c            |  2 +-
 .../conformance/interfaces/sigsuspend/4-1.c        |  2 +-
 .../conformance/interfaces/sigsuspend/6-1.c        |  2 +-
 .../conformance/interfaces/sigtimedwait/1-1.c      |  2 +-
 .../conformance/interfaces/sigtimedwait/2-1.c      |  2 +-
 .../conformance/interfaces/sigtimedwait/4-1.c      |  2 +-
 .../conformance/interfaces/sigtimedwait/5-1.c      |  2 +-
 .../conformance/interfaces/sigtimedwait/6-1.c      |  2 +-
 .../conformance/interfaces/sigwait/6-1.c           |  2 +-
 .../conformance/interfaces/sigwait/6-2.c           |  2 +-
 .../conformance/interfaces/sigwaitinfo/1-1.c       |  2 +-
 .../conformance/interfaces/sigwaitinfo/2-1.c       |  6 +++---
 .../conformance/interfaces/sigwaitinfo/3-1.c       |  2 +-
 .../conformance/interfaces/sigwaitinfo/5-1.c       |  6 +++---
 .../conformance/interfaces/sigwaitinfo/6-1.c       |  6 +++---
 .../conformance/interfaces/sigwaitinfo/7-1.c       |  6 +++---
 .../conformance/interfaces/sigwaitinfo/8-1.c       |  6 +++---
 .../conformance/interfaces/sigwaitinfo/9-1.c       |  2 +-
 .../conformance/interfaces/timer_create/1-1.c      |  2 +-
 .../conformance/interfaces/timer_create/10-1.c     |  2 +-
 .../conformance/interfaces/timer_create/11-1.c     |  2 +-
 .../conformance/interfaces/timer_create/3-1.c      |  2 +-
 .../conformance/interfaces/timer_create/7-1.c      |  2 +-
 .../conformance/interfaces/timer_create/8-1.c      |  4 ++--
 .../conformance/interfaces/timer_create/9-1.c      |  2 +-
 .../interfaces/timer_create/speculative/5-1.c      |  2 +-
 .../conformance/interfaces/timer_delete/1-1.c      |  2 +-
 .../interfaces/timer_delete/speculative/5-2.c      |  2 +-
 .../conformance/interfaces/timer_getoverrun/1-1.c  |  2 +-
 .../conformance/interfaces/timer_settime/1-1.c     |  2 +-
 .../conformance/interfaces/timer_settime/1-2.c     |  2 +-
 .../conformance/interfaces/timer_settime/3-1.c     |  2 +-
 .../conformance/interfaces/timer_settime/3-2.c     |  2 +-
 .../conformance/interfaces/timer_settime/3-3.c     |  2 +-
 .../conformance/interfaces/timer_settime/5-1.c     |  2 +-
 .../conformance/interfaces/timer_settime/5-2.c     |  2 +-
 .../conformance/interfaces/timer_settime/5-3.c     |  2 +-
 .../functional/semaphores/sem_readerwriter.c       |  2 +-
 .../functional/semaphores/sem_sleepingbarber.c     |  2 +-
 testcases/open_posix_testsuite/include/noatime.h   |  2 +-
 testcases/open_posix_testsuite/include/posixtest.h |  6 +++---
 testcases/open_posix_testsuite/include/proc.h      |  4 ++--
 testcases/open_posix_testsuite/include/tempfile.h  | 14 ++++++++++----
 730 files changed, 973 insertions(+), 967 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/definitions/pthread_h/4-1-buildonly.c b/testcases/open_posix_testsuite/conformance/definitions/pthread_h/4-1-buildonly.c
index dde520c2b..f5157f272 100644
--- a/testcases/open_posix_testsuite/conformance/definitions/pthread_h/4-1-buildonly.c
+++ b/testcases/open_posix_testsuite/conformance/definitions/pthread_h/4-1-buildonly.c
@@ -14,7 +14,7 @@
 #include <pthread.h>
 #include "posixtest.h"
 
-static void *thread_function(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thread_function(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	return NULL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c
index c3a54239f..c5c9b8d23 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/1-1.c
@@ -47,7 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c
index 738b47479..63dc6b0ec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-1.c
@@ -51,7 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c
index 5921bc577..fa782767a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/2-2.c
@@ -44,7 +44,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_2_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_2_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
index 90d2e8f3a..b74d11c6c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
@@ -50,8 +50,8 @@
 static volatile int countdown = BUF_NB;
 static volatile int canceled;
 
-static void sig_handler(int signum LTP_ATTRIBUTE_UNUSED, siginfo_t *info,
-    void *context LTP_ATTRIBUTE_UNUSED)
+static void sig_handler(int signum PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
+    void *context PTS_ATTRIBUTE_UNUSED)
 {
 	struct aiocb *a = info->si_value.sival_ptr;
 
@@ -78,7 +78,7 @@ int main(void)
 		return PTS_UNSUPPORTED;
 	}
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_3_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
index daf72b799..ef615ae64 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/4-1.c
@@ -55,7 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index bebe6c7ae..5ed4f6d42 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -55,7 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_5_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
index a474d2410..c35aeee9a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/6-1.c
@@ -57,7 +57,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_6_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_6_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index 8c418d583..34b263245 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -55,7 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_7_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
index da5a9347b..139e9b5a9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/8-1.c
@@ -50,7 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c
index add59bf50..70b0a9dbb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/1-1.c
@@ -47,7 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_error_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_error_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
index 31d527a7a..c35bcfd9a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/2-1.c
@@ -49,7 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_error_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_error_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
index 82b30f993..102d99274 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
@@ -47,7 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_error_3_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_error_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
index d912af981..6f6f190e1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/14-1.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_14_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_14_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
index 78d3c810b..6faa20a04 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/2-1.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
index ebc666174..fa5adb463 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/3-1.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_3_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
index 881cf3a42..172b12f34 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/4-1.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
index 2a4e4d42d..2f6c2a164 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/5-1.c
@@ -37,7 +37,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_5_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
index 813e11b11..69378e71b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-1.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
index 17508ca2d..ee0d25c75 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-2.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
index daf09e584..867fbf0c0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-3.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_3");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_3");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
index d4d317d4d..0db00ca14 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/8-4.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_4");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_8_4");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
index da44f99ad..658c1a1e4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_fsync/9-1.c
@@ -36,7 +36,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_9_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_fsync_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c
index 4c3f5e03e..37fd557ad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/1-1.c
@@ -51,7 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c
index b8e47795d..8f78970e0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-1.c
@@ -48,7 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_11_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_11_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c
index d4f75bf5a..4c1cba6ac 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/11-2.c
@@ -47,7 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_11_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_11_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c
index 57d162bd4..00250cbd9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-1.c
@@ -47,7 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_3_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c
index 63efc0d56..b19c2b3be 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/3-2.c
@@ -47,7 +47,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_3_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_3_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c
index 8f937e0f7..d80a65575 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/4-1.c
@@ -48,7 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c
index 514e066ce..ce9c09a43 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/5-1.c
@@ -49,7 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_5_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
index 7051b04c7..a5d3ef7a0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/7-1.c
@@ -48,7 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_read_7_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_read_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
index 1e8836730..5b980be17 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
@@ -55,7 +55,7 @@ int main(void)
 	    || sysconf(_SC_AIO_MAX) == -1)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
index 764c653ef..70499a0ae 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
@@ -48,7 +48,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_return_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
index 2216256e3..dc929c5fa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/2-1.c
@@ -46,7 +46,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_return_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
index d80c58edf..32ca22d9a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-1.c
@@ -51,7 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_3_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_return_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
index 18a965ca9..30a850dbd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/3-2.c
@@ -49,7 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_3_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_return_3_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
index 8f25f4e2d..f3805316e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_return/4-1.c
@@ -50,7 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_return_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_return_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
index 8d411acfe..04f6d2b7f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/1-1.c
@@ -53,8 +53,8 @@
 
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED, void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED, void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -77,7 +77,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_1_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
index c275f57dd..ed8173e42 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/3-1.c
@@ -53,7 +53,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
index c3d599e0d..0de8c9a96 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/4-1.c
@@ -75,7 +75,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_SYNC | O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c
index f0c825e48..d7cdf0d87 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/9-1.c
@@ -62,7 +62,7 @@ static int do_test(int num_aiocbs, size_t buf_size)
 	int err = PTS_UNRESOLVED;
 	int i;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_9_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_suspend_9_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c
index 9dfa0b2fd..299d19472 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-1.c
@@ -52,7 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c
index 35c3bf422..650cec2d2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/1-2.c
@@ -53,7 +53,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_1_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_1_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c
index bc66ce0f9..2dbfcd1f0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/2-1.c
@@ -60,7 +60,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_2_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_APPEND | O_RDWR | O_EXCL,
 		  S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c
index 14fc69573..ea3f9aa11 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/3-1.c
@@ -52,7 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_3_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_3_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c
index 1cf91688c..c56f7ebed 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/5-1.c
@@ -50,7 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_5_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
index 8184e1c11..5311a4ab8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
@@ -55,7 +55,7 @@ int main(void)
 	    || sysconf(_SC_AIO_MAX) == -1)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
index 8b9f8e49c..3cc3fd5c1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
@@ -49,7 +49,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_8_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_8_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDONLY | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c
index ed49754b0..68d4d0bdf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-1.c
@@ -51,7 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_9_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c
index b620eb8a4..d9ddcb30b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/9-2.c
@@ -51,7 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		return PTS_UNSUPPORTED;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_write_9_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_aio_write_9_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c
index ebfe9902b..c20087816 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fsync/4-1.c
@@ -35,7 +35,7 @@ int main(void)
 	int total_size = 1024;
 	int fd;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_fsync_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_fsync_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
index bd50e3d58..06381002e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/1-1.c
@@ -41,9 +41,9 @@
 
 static volatile int received_all = 0;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -65,7 +65,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_1_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c
index 2087b3a93..87ecdf63b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/10-1.c
@@ -41,15 +41,15 @@
 static volatile int received_selected;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED, siginfo_t* info,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED, siginfo_t* info,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_selected = info->si_value.sival_int;
 }
 
-static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -71,7 +71,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_10_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_10_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c
index af393f8ad..fe3163da5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/12-1.c
@@ -52,7 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_12_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_12_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c
index 6e511aadf..33915a440 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/13-1.c
@@ -52,7 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_13_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_13_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c
index 477e66b7d..f398f44a6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/14-1.c
@@ -41,16 +41,16 @@
 static volatile int num_received;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	num_received++;
 }
 
-static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -72,7 +72,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_14_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_14_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c
index 6e03cb1f7..a72d6d6e7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/15-1.c
@@ -41,16 +41,16 @@
 static volatile int num_received;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	num_received++;
 }
 
-static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -72,7 +72,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_15_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_15_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c
index 3cd26f230..4b3ecf818 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/18-1.c
@@ -50,7 +50,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_18_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_18_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
index 3cdd106fe..4f458a06b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/2-1.c
@@ -40,16 +40,16 @@
 static volatile int received_selected;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
 	siginfo_t *info,
-	void *context LTP_ATTRIBUTE_UNUSED)
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_selected = info->si_value.sival_int;
 }
 
-static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -71,7 +71,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_2_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_2_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c
index 0b8becf80..ad3c2814b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/3-1.c
@@ -41,15 +41,15 @@
 static volatile int received_selected;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED, siginfo_t *info,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_selected = info->si_value.sival_int;
 }
 
-static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -71,7 +71,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_3_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_3_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c
index ae1b749ea..5d7a99873 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/4-1.c
@@ -41,16 +41,16 @@
 static volatile int num_received;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	num_received++;
 }
 
-static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -72,7 +72,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
index 5a2c140e0..e44577389 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/5-1.c
@@ -55,7 +55,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
index af953123f..444555ebc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/7-1.c
@@ -42,16 +42,16 @@
 static volatile int num_received;
 static volatile int received_all;
 
-static void sigrt1_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt1_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	num_received++;
 }
 
-static void sigrt2_handler(int signum LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void sigrt2_handler(int signum PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	received_all = 1;
 }
@@ -73,7 +73,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_4_1");
 	unlink(tmpfname);
 
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c
index aeec017ad..86803da99 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/8-1.c
@@ -51,7 +51,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_8_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_8_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c
index 0324a7505..abf9cc06c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/lio_listio/9-1.c
@@ -52,7 +52,7 @@ int main(void)
 	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
 		exit(PTS_UNSUPPORTED);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_9_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_lio_listio_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
index 420c83b5b..5174800a3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/1-1.c
@@ -36,7 +36,7 @@ int main(void)
 	void *pa;
 	int fd;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c
index 3b9525ba6..2e6c77deb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/10-1.c
@@ -47,7 +47,7 @@ int main(void)
 	total_size = 1024;
 	size = total_size;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_10_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_10_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c
index bfc83911c..3d78a35c9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-1.c
@@ -50,7 +50,7 @@ int main(void)
 	total_size = 3 * page_size;
 	size = page_size;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
index ebf4e47d4..d63949418 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
@@ -74,7 +74,7 @@ int main(void)
 	sigaction(SIGBUS, &sa, NULL);
 
 	/* Create tmp file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
index e7fef3359..cb238b40e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
@@ -66,11 +66,11 @@ int main(void)
 	/* mmap will create a partial page */
 	len = page_size / 2;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
 #ifdef	__linux__
 	struct statfs buf;
 
-	if (statfs(ltp_get_tmpdir(), &buf)) {
+	if (statfs(pts_get_tmpdir(), &buf)) {
 		printf("Error@statfs(): %s\n", strerror(errno));
 		return PTS_UNRESOLVED;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
index 17edf80bd..2aea92715 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-6.c
@@ -59,7 +59,7 @@ int main(void)
 	/* mmap will create a partial page */
 	len = page_size / 2;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_11_5");
 	child = fork();
 	switch (child) {
 	case 0:
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c
index 21a119e6d..b5c6e0def 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/12-1.c
@@ -41,7 +41,7 @@ int main(void)
 	ssize_t size = 1024;
 	int fd, i;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_12_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_12_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
index e6faca765..611ba85af 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/13-1.c
@@ -48,8 +48,8 @@ int main(void)
 
 	char *ch;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_13_1");
-	if (mounted_noatime(ltp_get_tmpdir()) == 1) {
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_13_1");
+	if (mounted_noatime(pts_get_tmpdir()) == 1) {
 		printf("UNTESTED: The tmpdir is mounted noatime\n");
 		return PTS_UNTESTED;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
index b262f6ecb..788b374c4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/14-1.c
@@ -46,7 +46,7 @@ int main(void)
 
 	char *ch;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_14_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_14_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
index b8df231d7..8ac110c35 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
@@ -37,7 +37,7 @@ int main(void)
 	int flag = ~0;
 	int fd;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_21_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_21_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c
index c06f48783..3b2ad0298 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/27-1.c
@@ -40,7 +40,7 @@ int main(void)
 	size_t len = total_size;
 	int fd, err = 0;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_27_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_27_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c
index f0deecb3c..c92e30641 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/3-1.c
@@ -59,8 +59,8 @@ int main(void)
 	/* Size of the file */
 	total_size = 2 * page_size;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_3_1_1");
-	LTP_GET_TMP_FILENAME(tmpfname2, "pts_mmap_3_1_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_3_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname2, "pts_mmap_3_1_2");
 
 	unlink(tmpfname);
 	unlink(tmpfname2);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
index 56bdc2357..7420d4496 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
@@ -67,7 +67,7 @@ int main(void)
 
 	long page_size = sysconf(_SC_PAGE_SIZE);
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_31_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_31_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
index 187799f33..bb3ab74be 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/32-1.c
@@ -31,7 +31,7 @@ int main(void)
 	void *pa;
 	int fd;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_31_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_31_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
index 860d3ee0b..bcb330da6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/5-1.c
@@ -95,7 +95,7 @@ int main(void)
 	int fd, fail = 0;
 	unsigned int i;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_5_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_5_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c
index 5edf66d19..609102904 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-1.c
@@ -52,7 +52,7 @@ int main(void)
 	int status;
 	int sig_num;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
index 18beb009e..6d06dbf98 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-2.c
@@ -54,7 +54,7 @@ int main(void)
 	int status;
 	int sig_num;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
index 361c26177..b38833b5a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-3.c
@@ -53,7 +53,7 @@ int main(void)
 	int status;
 	int sig_num;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c
index b5777493d..44a616e3b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-4.c
@@ -40,7 +40,7 @@ int main(void)
 	size_t size = 1024;
 	int fd;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_4");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_4");
 
 	/* Create a tmp file */
 	unlink(tmpfname);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c
index ba0a0c899..33c0575c5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-5.c
@@ -41,7 +41,7 @@ int main(void)
 	int fd;
 
 	/* Create the file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_5");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_5");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c
index 5e5d82b57..b707a2cb5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/6-6.c
@@ -40,7 +40,7 @@ int main(void)
 	int fd;
 
 	/* Create the tmp file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_6");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_6_6");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
index 719ca189c..6be5e52e7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-1.c
@@ -47,7 +47,7 @@ int main(void)
 	void *pa;
 	int fd;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_7_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_7_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
index e2b21f578..b923e1b2c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/7-2.c
@@ -47,7 +47,7 @@ int main(void)
 	void *pa;
 	int fd;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_7_2");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_7_2");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c
index 73cb19c80..883003351 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/9-1.c
@@ -49,7 +49,7 @@ int main(void)
 	size = total_size;
 
 	/* Create tmp file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_mmap_9_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_mmap_9_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
index 02973d4fe..dc03d21db 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
@@ -93,7 +93,7 @@ int main(void)
 }
 
 static int parent_process(char *qname, int read_pipe, int write_pipe,
-	pid_t child_pid LTP_ATTRIBUTE_UNUSED)
+	pid_t child_pid PTS_ATTRIBUTE_UNUSED)
 {
 	mqd_t queue;
 	struct sigevent se;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
index b41cd52cd..eee55a748 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_open/16-1.c
@@ -54,7 +54,7 @@ int main(void)
 
 	sprintf(qname, "/mq_open_16-1_%d", getpid());
 
-	LTP_GET_TMP_FILENAME(fname, "pts_mq_open_16_1");
+	PTS_GET_TMP_FILENAME(fname, "pts_mq_open_16_1");
 	unlink(fname);
 	fd = open(fname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/13-1.c
index c4dcaaaa8..d0e684ee8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_receive/13-1.c
@@ -33,7 +33,7 @@
 #define NAMESIZE 50
 #define BUFFER 40
 
-static void stopreceive(int signo LTP_ATTRIBUTE_UNUSED)
+static void stopreceive(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/12-1.c
index 964fcc17a..9a1dc1b36 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/12-1.c
@@ -46,7 +46,7 @@ static mqd_t gqueue;
  * This handler is just used to catch the signal and stop sleep (so the
  * parent knows the child is still busy sending signals).
  */
-static void justreturn_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void justreturn_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-2.c
index 5f7140cdb..541558d76 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-2.c
@@ -44,7 +44,7 @@ static mqd_t gqueue;
  * This handler is just used to catch the signal and stop sleep (so the
  * parent knows the child is still busy sending signals).
  */
-static void justreturn_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void justreturn_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-1.c
index 703a8c67a..7d0521a66 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-1.c
@@ -36,7 +36,7 @@
 #define TIMEOUT	3
 
 static int blocking;
-static void exit_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void exit_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("FAIL: the case is blocking, exit anyway\n");
 	blocking = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-2.c
index 61f54669b..7f4bd71cc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/18-2.c
@@ -37,7 +37,7 @@
 #define TIMEOUT	3
 
 static int blocking;
-static void exit_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void exit_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("FAIL: the case is blocking, exit anyway\n");
 	blocking = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-2.c
index 6bcb4dfcd..31fa2fde7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-2.c
@@ -36,7 +36,7 @@
 #define THRESHOLD (TIMEOUT - 1)
 
 static int blocking;
-static void exit_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void exit_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("FAIL: the case is blocking, exit anyway\n");
 	blocking = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
index 87f3365d5..a843c13ee 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
@@ -38,7 +38,7 @@
 #define NAMESIZE 50
 #define BUFFER 40
 
-static void stopreceive(int signo LTP_ATTRIBUTE_UNUSED)
+static void stopreceive(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/8-1.c
index 2ba153492..69428111f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/8-1.c
@@ -33,7 +33,7 @@
 #define TIMEOUT	3
 
 static int blocking;
-static void exit_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void exit_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("FAIL: the case is blocking, exit anyway\n");
 	blocking = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
index 8eaf3df69..f76c8bd7e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
@@ -57,12 +57,12 @@ static pthread_barrier_t barrier;
  * This handler is just used to catch the signal and stop sleep (so the
  * parent knows the child is still busy sending signals).
  */
-static void justreturn_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void justreturn_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	in_handler++;
 }
 
-static void *a_thread_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *a_thread_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int i, ret;
 	struct sigaction act;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/15-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/15-1.c
index 24a39bc58..80452fd73 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/15-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/15-1.c
@@ -40,7 +40,7 @@
 static char gqname[NAMESIZE];
 static mqd_t gqueue;
 
-static void testfailed_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void testfailed_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Timeout never happened\n");
 	printf("Test FAILED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/16-1.c
index 97f241370..88360cd29 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/16-1.c
@@ -51,7 +51,7 @@ static mqd_t gqueue;
  * This handler is just used to catch the signal and stop sleep (so the
  * parent knows the child is still busy sending signals).
  */
-static void stopsleep_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void stopsleep_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/20-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/20-1.c
index d41375a0c..d2a4e13c3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/20-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/20-1.c
@@ -40,7 +40,7 @@
 static char gqname[NAMESIZE];
 static mqd_t gqueue;
 
-static void testfailed_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void testfailed_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Timeout never happened\n");
 	printf("Test FAILED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
index 2ef4307f5..fb4a81fef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
@@ -47,7 +47,7 @@ static mqd_t gqueue;
  * This handler is just used to catch the signal and stop sleep (so the
  * parent knows the child is still busy sending signals).
  */
-static void stopsleep_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void stopsleep_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-2.c
index 596bbca6a..c3f36b20c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-2.c
@@ -45,7 +45,7 @@ static mqd_t gqueue;
  * This handler is just used to catch the signal and stop sleep (so the
  * parent knows the child is still busy sending signals).
  */
-static void justreturn_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void justreturn_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-3.c
index b0e650d43..3b17b1aa4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-3.c
@@ -48,7 +48,7 @@ static mqd_t gqueue;
  * This handler is just used to catch the signal and stop sleep (so the
  * parent knows the child is still busy sending signals).
  */
-static void stopsleep_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void stopsleep_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-1.c
index 297d558e9..70257b570 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-1.c
@@ -94,7 +94,7 @@ int main(void)
 }
 
 static int parent_process(char *mqname, int read_pipe, int write_pipe,
-	pid_t child_pid LTP_ATTRIBUTE_UNUSED)
+	pid_t child_pid PTS_ATTRIBUTE_UNUSED)
 {
 	mqd_t mqdes;
 	char reply;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-2.c
index 2fd1858e3..3445ebaea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/2-2.c
@@ -89,7 +89,7 @@ int main(void)
 }
 
 static int parent_process(char *mqname, int read_pipe, int write_pipe,
-	pid_t child_pid LTP_ATTRIBUTE_UNUSED)
+	pid_t child_pid PTS_ATTRIBUTE_UNUSED)
 {
 	mqd_t mqdes;
 	char reply;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c
index 13a6ae025..9a17063cb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-1.c
@@ -36,7 +36,7 @@
 
 #define TNAME "munmap/1-1.c"
 
-static void sigsegv_handler(int signum LTP_ATTRIBUTE_UNUSED)
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Got SIGSEGV\n");
 	printf("Test PASSED\n");
@@ -73,7 +73,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
index 9cfa3df88..9d0f918b5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/1-2.c
@@ -36,7 +36,7 @@
 
 #define TNAME "munmap/1-2.c"
 
-static void sigsegv_handler(int signum LTP_ATTRIBUTE_UNUSED)
+static void sigsegv_handler(int signum PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Got SIGSEGV\n");
 	printf("Test PASSED\n");
@@ -73,7 +73,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
index 06672f0c5..53e89de39 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/3-1.c
@@ -54,7 +54,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c
index 72e9e671e..3c05ab042 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/4-1.c
@@ -54,7 +54,7 @@ int main(void)
 
 	char *ch;
 
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_4_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_4_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
index 3d24e503b..0280a0e4e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munmap/9-1.c
@@ -49,7 +49,7 @@ int main(void)
 	len = page_size + 1;
 
 	/* Create tmp file */
-	LTP_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
+	PTS_GET_TMP_FILENAME(tmpfname, "pts_munmap_1_1");
 	unlink(tmpfname);
 	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
 	if (fd == -1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
index fee4ab8f0..31ac00858 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
@@ -16,7 +16,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("In handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-1.c
index 705615c81..bc6f7fbab 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-1.c
@@ -22,7 +22,7 @@
 #define CHILDSUCCESS 1
 #define CHILDFAIL 0
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Received signal - exit success\n");
 	exit(CHILDSUCCESS);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/5-2.c
index 6222ad754..ecb8bd828 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/5-2.c
@@ -19,7 +19,7 @@
 #define CHILDSUCCESS 1
 #define CHILDFAILURE 0
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("In handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c
index 6bbbb8841..e9c8ebe51 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c
@@ -20,7 +20,7 @@
 #define CHILDSUCCESS 1
 #define CHILDFAILURE 0
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("In handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
index 6de98fc8b..caf4470e4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
@@ -22,7 +22,7 @@
 
 #define OKDELTA 1
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("In handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/1-2.c
index 0cdd4f023..6e89b8a05 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/1-2.c
@@ -107,7 +107,7 @@ static void child(void)
 }
 
 /* Thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret, status;
 	pid_t child, ctl;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/2-2.c
index f3f240898..a19b029bc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/2-2.c
@@ -135,7 +135,7 @@ static void c6(void)
 }
 
 /* Thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret, status;
 	pid_t child, ctl;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-2.c
index 553b30c5f..e90a06a5c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-2.c
@@ -96,7 +96,7 @@ static void child(void)
 }
 
 /* Thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret, status;
 	pid_t child, ctl;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c
index 2a3d6c47c..32b91872b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/3-3.c
@@ -134,7 +134,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -145,7 +145,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -171,7 +171,7 @@ static void child(void)
 }
 
 /* Test function -- calls pthread_setschedparam() and checks that EINTR is never returned. */
-static void *test(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/4-1.c
index ace75b33d..98a7d9101 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_atfork/4-1.c
@@ -155,7 +155,7 @@ static void chi3(void)
 }
 
 /* Thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret, status;
 	pid_t child, ctl;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/3-1.c
index 219594add..aeca480bc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_init/3-1.c
@@ -23,7 +23,7 @@
 
 #define NUM_THREADS	5
 
-static void *a_thread_func(void *attr LTP_ATTRIBUTE_UNUSED)
+static void *a_thread_func(void *attr PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_exit(NULL);
 	return NULL;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-2.c
index 1c57c0228..1901df032 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-2.c
@@ -36,7 +36,7 @@
 
 static const long int policy = SCHED_FIFO;
 static const long int old_policy = SCHED_OTHER;
-static void *thread_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thread_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	int new_policy;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c
index b4c9821cd..a1047651c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c
@@ -32,7 +32,7 @@
 static int policy_correct = -1;
 static int priority_correct = -1;
 
-static void *thread(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void *thread(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	struct sched_param param;
 	int policy;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c
index 0eccdd945..85ac35e73 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c
@@ -32,7 +32,7 @@
 static int policy_correct = -1;
 static int priority_correct = -1;
 
-static void *thread(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void *thread(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	struct sched_param param;
 	int policy;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c
index 522da6d54..1f0289013 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c
@@ -34,7 +34,7 @@ static int policy_correct = -1;
 static int priority_correct = -1;
 
 /* Thread function which checks the scheduler settings for itself */
-static void *thread(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void *thread(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	struct sched_param param;
 	int policy;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c
index 527ddac84..5e13ea407 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c
@@ -34,7 +34,7 @@ static int policy_correct = -1;
 static int priority_correct = -1;
 
 /* Thread function which checks the scheduler settings for itself */
-static void *thread(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void *thread(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	struct sched_param param;
 	int policy;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
index 947238116..388897eeb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
@@ -49,7 +49,7 @@ static int thread_started;
 	exit(PTS_UNRESOLVED); \
 }
 
-static void *thread_func(void *data LTP_ATTRIBUTE_UNUSED)
+static void *thread_func(void *data PTS_ATTRIBUTE_UNUSED)
 {
 	struct sched_param sp;
 	int policy;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c
index ec0539b3e..a0815e21f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c
@@ -35,7 +35,7 @@ static int thread_state;
 #define EXITING_THREAD 3
 
 /* child thread */
-static void *fn_chld(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_chld(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c
index df8fc81b2..bd169c53f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c
@@ -32,7 +32,7 @@ static int thread_state;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_chld(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_chld(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 	thread_state = ENTERED_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c
index 509ba527b..22674ed57 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c
@@ -45,7 +45,7 @@ static void sig_handler()
 	printf("thread: interrupted by SIGUSR1\n");
 }
 
-static void *fn_chld(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_chld(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 	struct sigaction act;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c
index 1ff491c88..1fc612585 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c
@@ -51,7 +51,7 @@ static void sig_handler()
 	}
 }
 
-static void *fn_chld(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_chld(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 	struct sigaction act;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-2.c
index a1767a366..8417984ff 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-2.c
@@ -30,13 +30,13 @@
 static int cleanup_flag = 0;
 static int sem = 0;			/* manual semaphore */
 
-static void destructor(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void destructor(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	cleanup_flag = 1;
 }
 
 /* Thread's function. */
-static void *a_thread_func(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void *a_thread_func(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_key_t key;
 	int value = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-3.c
index f7fcb5f9d..94a8387d3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/2-3.c
@@ -37,7 +37,7 @@ static struct timespec destructor_time, cleanup_time;
 /*
    Destructor for the Thread Specific Data
  */
-static void destructor(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void destructor(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	clock_gettime(CLOCK_REALTIME, &destructor_time);
 	destructor_flag = 1;
@@ -53,7 +53,7 @@ static void cleanup_function()
 }
 
 /* Thread's function. */
-static void *a_thread_func(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void *a_thread_func(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_key_t key;
 	int value = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
index 6bac75856..3527d57fd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cancel/3-1.c
@@ -26,7 +26,7 @@ static volatile int after_cancel;
 static volatile int thread_sleep_time;
 static sem_t sem;
 
-static void cleanup_func(LTP_ATTRIBUTE_UNUSED void *unused)
+static void cleanup_func(PTS_ATTRIBUTE_UNUSED void *unused)
 {
 	struct timespec cleanup_ts = {0, SLEEP_MS*1000000};
 	do {
@@ -35,7 +35,7 @@ static void cleanup_func(LTP_ATTRIBUTE_UNUSED void *unused)
 	} while (after_cancel == 0 && thread_sleep_time < TIMEOUT_MS);
 }
 
-static void *thread_func(LTP_ATTRIBUTE_UNUSED void *unused)
+static void *thread_func(PTS_ATTRIBUTE_UNUSED void *unused)
 {
 	int waited_for_cancel_ms = 0;
 	struct timespec cancel_wait_ts = {0, SLEEP_MS*1000000};
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/1-3.c
index e3ecce59b..fae4e9380 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cleanup_pop/1-3.c
@@ -31,21 +31,21 @@ static int cleanup_flag[3];		/* Array to hold the cleanup flags for the 3 cleanu
 static int i;
 
 /* 3 Cleanup handlers */
-static void a_cleanup_func1(void *flag_val LTP_ATTRIBUTE_UNUSED)
+static void a_cleanup_func1(void *flag_val PTS_ATTRIBUTE_UNUSED)
 {
 	cleanup_flag[i] = 1;
 	i++;
 	return;
 }
 
-static void a_cleanup_func2(void *flag_val LTP_ATTRIBUTE_UNUSED)
+static void a_cleanup_func2(void *flag_val PTS_ATTRIBUTE_UNUSED)
 {
 	cleanup_flag[i] = 2;
 	i++;
 	return;
 }
 
-static void a_cleanup_func3(void *flag_val LTP_ATTRIBUTE_UNUSED)
+static void a_cleanup_func3(void *flag_val PTS_ATTRIBUTE_UNUSED)
 {
 	cleanup_flag[i] = 3;
 	i++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-1.c
index a572d5a1e..3c7b5975c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-1.c
@@ -27,7 +27,7 @@ static struct testdata {
 static int start_num;
 static int waken_num;
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	pthread_t self = pthread_self();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
index 950ecdeb9..22e7c3638 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
@@ -167,7 +167,7 @@ struct testdata {
 static struct testdata *td;
 
 /* Child function (either in a thread or in a process) */
-static void *child(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *child(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	struct timespec ts;
@@ -237,7 +237,7 @@ static children_t *children = &sentinel;
 
 static sem_t sem_tmr;
 
-static void *timer(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *timer(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	unsigned int to = TIMEOUT;
 	int ret;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-1.c
index 06b332084..cd39dbd93 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-1.c
@@ -28,7 +28,7 @@ static struct testdata {
 static int start_num;
 static int waken_num;
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	pthread_t self = pthread_self();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-2.c
index 5b4fb7aa2..2ae84f477 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-2.c
@@ -31,7 +31,7 @@ static struct testdata {
 static int start_num;
 static int waken_num;
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	struct timespec timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-3.c
index 4a29fe757..d82f6773d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/2-3.c
@@ -157,7 +157,7 @@ static struct {
 	int nb;
 } children;
 
-static void *child(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *child(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	int timed;
@@ -228,7 +228,7 @@ static void *child(void *arg LTP_ATTRIBUTE_UNUSED)
 	return NULL;
 }
 
-static void *timer(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *timer(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	unsigned int to = TIMEOUT;
 	do {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-1.c
index 6f5066996..09d5fdff7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-1.c
@@ -27,7 +27,7 @@ static struct testdata {
 static int start_num;
 static int waken_num;
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	pthread_t self = pthread_self();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-2.c
index d6a515c40..d7082d07d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/4-2.c
@@ -102,7 +102,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig1))
@@ -111,7 +111,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig2))
@@ -121,7 +121,7 @@ static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
 
 /* The following function will wait on the cond
  * it does check that no error code of EINTR is returned */
-static void *waiter(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *waiter(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 
@@ -152,7 +152,7 @@ static void *waiter(void *arg LTP_ATTRIBUTE_UNUSED)
 }
 
 /* The next function will signal the condition */
-static void *worker(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *worker(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/2-1.c
index c3a655bdd..63363bbea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_destroy/2-1.c
@@ -208,7 +208,7 @@ typedef struct {
 static testdata_t *td;
 
 /* Child function (either in a thread or in a process) */
-static void *child(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *child(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	struct timespec ts;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
index a0d53405e..d638190f3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
@@ -31,7 +31,7 @@ static int start_num = 0;
 static int waken_num = 0;
 
 /* Alarm handler */
-static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void alarm_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	int i;
 	printf("Error: failed to wakeup all threads\n");
@@ -42,7 +42,7 @@ static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
 	exit(PTS_UNRESOLVED);
 }
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	pthread_t self = pthread_self();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-2.c
index ff7d29f8f..89e20171d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-2.c
@@ -205,7 +205,7 @@ typedef struct {
 static testdata_t *td;
 
 /* Child function (either in a thread or in a process) */
-static void *child(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *child(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	struct timespec ts;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-1.c
index ff62336c9..6db863954 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-1.c
@@ -32,7 +32,7 @@ static int start_num = 0;
 static int waken_num = 0;
 
 /* Alarm handler */
-static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void alarm_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	int i;
 	printf("Error: failed to wakeup all threads\n");
@@ -43,7 +43,7 @@ static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
 	exit(PTS_UNRESOLVED);
 }
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	pthread_t self = pthread_self();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-2.c
index e2f61d8e9..375afdbd6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/2-2.c
@@ -31,7 +31,7 @@ static struct testdata {
 static int start_num = 0;
 static int waken_num = 0;
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	struct timespec timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-1.c
index 36dc91ec9..54d3a1b88 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-1.c
@@ -31,7 +31,7 @@ static int start_num = 0;
 static int waken_num = 0;
 
 /* Alarm handler */
-static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void alarm_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	int i;
 	printf("Error: failed to wakeup all threads\n");
@@ -42,7 +42,7 @@ static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
 	exit(PTS_UNRESOLVED);
 }
 
-static void *thr_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thr_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	pthread_t self = pthread_self();
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-2.c
index 972ac4ced..39fc0a089 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/4-2.c
@@ -134,7 +134,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig1)) {
@@ -144,7 +144,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig2)) {
@@ -155,7 +155,7 @@ static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
 
 /* The following function will wait on the cond
  * it does check that no error code of EINTR is returned */
-static void *waiter(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *waiter(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 
@@ -191,7 +191,7 @@ static void *waiter(void *arg LTP_ATTRIBUTE_UNUSED)
 }
 
 /* The next function will signal the condition */
-static void *worker(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *worker(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/1-1.c
index fd3e6b4b7..fd2752927 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/1-1.c
@@ -29,14 +29,14 @@ static int t1_start = 0;
 static int signaled = 0;
 
 /* Alarm handler */
-static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void alarm_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Error: failed to wakeup thread\n");
 	pthread_cancel(thread1);
 	exit(PTS_UNRESOLVED);
 }
 
-static void *t1_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *t1_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-1.c
index 85c4bb357..8ee37f1fb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-1.c
@@ -29,14 +29,14 @@ static int t1_start = 0;
 static int signaled = 0;
 
 /* Alarm handler */
-static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void alarm_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Error: failed to wakeup thread\n");
 	pthread_cancel(thread1);
 	exit(PTS_UNRESOLVED);
 }
 
-static void *t1_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *t1_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-3.c
index 54b22381f..eaa248888 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/2-3.c
@@ -90,7 +90,7 @@ static struct {
 /****  First handler that will be poped
  *  This one works only with recursive mutexes
  */
-static void clnp1(void *arg LTP_ATTRIBUTE_UNUSED)
+static void clnp1(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	if (data.type == PTHREAD_MUTEX_RECURSIVE) {
@@ -111,7 +111,7 @@ static void clnp1(void *arg LTP_ATTRIBUTE_UNUSED)
 /**** Second handler
  *  This one will trigger an action in main thread, while we are owning the mutex
  */
-static void clnp2(void *arg LTP_ATTRIBUTE_UNUSED)
+static void clnp2(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	do {
@@ -134,7 +134,7 @@ static void clnp2(void *arg LTP_ATTRIBUTE_UNUSED)
 /**** Third handler
  *  Will actually unlock the mutex, then try to unlock second time to check an error is returned
  */
-static void clnp3(void *arg LTP_ATTRIBUTE_UNUSED)
+static void clnp3(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 
@@ -159,7 +159,7 @@ static void clnp3(void *arg LTP_ATTRIBUTE_UNUSED)
  * This function will lock the mutex, then install the cleanup handlers
  * and wait for the cond. At this point it will be canceled.
  */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/3-1.c
index 74f36f4ba..e9dec867d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/3-1.c
@@ -28,14 +28,14 @@ static int t1_start = 0;
 static int signaled = 0;
 
 /* Alarm handler */
-static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void alarm_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Error: failed to wakeup thread\n");
 	pthread_cancel(thread1);
 	exit(PTS_UNRESOLVED);
 }
 
-static void *t1_func(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *t1_func(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/4-1.c
index 35b7fa63a..30f8a636e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_wait/4-1.c
@@ -136,7 +136,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig1)) {
@@ -146,7 +146,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig2)) {
@@ -157,7 +157,7 @@ static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
 
 /* The following function will wait on the cond
  * it does check that no error code of EINTR is returned */
-static void *waiter(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *waiter(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 
@@ -198,7 +198,7 @@ static void *waiter(void *arg LTP_ATTRIBUTE_UNUSED)
 }
 
 /* The next function will signal the condition@periodic interval */
-static void *worker(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *worker(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c
index 52105731a..9b43ccd8f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c
@@ -127,7 +127,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig1)) {
@@ -137,7 +137,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig2)) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c
index 53b938219..82be6f982 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/1-2.c
@@ -91,7 +91,7 @@
 /***********************************    Real Test   *****************************************/
 /********************************************************************************************/
 
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_exit(NULL + 1);
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
index 9efd6f7a7..2fc3ff700 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
@@ -102,7 +102,7 @@ CLEANUP(1)
     CLEANUP(2)
     CLEANUP(3)
 
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_cleanup_push(clnp3, NULL);
 	pthread_cleanup_push(clnp2, NULL);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-1.c
index 71701dfc4..e0dfd24ed 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-1.c
@@ -31,13 +31,13 @@
 /* Flag to indicate that the destructor was called */
 static int cleanup_flag = 0;
 
-static void destructor(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void destructor(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	cleanup_flag = 1;
 }
 
 /* Thread's function. */
-static void *a_thread_func(void *tmp LTP_ATTRIBUTE_UNUSED)
+static void *a_thread_func(void *tmp PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_key_t key;
 	int value = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
index 033210ad4..5fa6c8b50 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
@@ -112,7 +112,7 @@ static void destructor(void *arg)
 }
 
 /* Thread routine */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
index 3ca218d43..1252d5619 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/4-1.c
@@ -103,7 +103,7 @@ static void at2(void)
 }
 
 /* Thread routine */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/6-1.c
index b7dbf78f9..b21e43d7b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/6-1.c
@@ -105,7 +105,7 @@ static void clnp(void)
 }
 
 /* Thread routine */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/1-2.c
index fbf5927e1..4b44242da 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_getschedparam/1-2.c
@@ -27,7 +27,7 @@
 #define ERR_MSG(f, rc)  printf("Failed: func %s rc: %s (%u)\n", \
 				f, strerror(rc), rc)
 
-static void *thread_func(void* arg LTP_ATTRIBUTE_UNUSED)
+static void *thread_func(void* arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct sched_param sparam;
 	int policy, priority, policy_1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
index 7bc0746e0..b7bc56eac 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/4-1.c
@@ -48,7 +48,7 @@
 static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
 
 /* 1st thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-3.c
index 2e6b0ff0e..7325defc3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_join/6-3.c
@@ -96,7 +96,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig1))
@@ -105,7 +105,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig2))
@@ -113,13 +113,13 @@ static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
 #endif
 }
 
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	sched_yield();
 	return NULL;
 }
 
-static void *test(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	pthread_t child;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c
index b2b670a9a..7e46d2d07 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_create/3-1.c
@@ -32,7 +32,7 @@ static pthread_key_t key;
 static int dest_cnt;
 
 /* Destructor function */
-static void dest_func(void *p LTP_ATTRIBUTE_UNUSED)
+static void dest_func(void *p PTS_ATTRIBUTE_UNUSED)
 {
 	dest_cnt++;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c
index 8ae683399..b30bebcb6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_key_delete/2-1.c
@@ -30,7 +30,7 @@ static pthread_key_t key;
 static int dest_cnt;
 
 /* Destructor function */
-static void dest_func(void *p LTP_ATTRIBUTE_UNUSED)
+static void dest_func(void *p PTS_ATTRIBUTE_UNUSED)
 {
 	dest_cnt++;
 	/* Delete the key and check if an error has occured */
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c
index dcfa19648..f4c7eea5a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/1-2.c
@@ -93,7 +93,7 @@ static void handler(int sig)
 }
 
 /* Thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rebours = 3;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c
index 5a84aa4bd..a462ba8e0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/6-1.c
@@ -21,7 +21,7 @@
 #include <string.h>
 #include "posixtest.h"
 
-static void *thread_function(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *thread_function(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	/* Does nothing */
 	pthread_exit(NULL);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
index bc0138bd5..086a0cf5c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/8-1.c
@@ -132,7 +132,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -143,7 +143,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -162,7 +162,7 @@ static void initializer(void)
 }
 
 /* Test function -- calls pthread_kill() and checks that EINTR is never returned. */
-static void *test(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/1-2.c
index c82e0c805..99286d9cf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/1-2.c
@@ -92,14 +92,14 @@ static int canceled = 0;
 static sem_t semA, semB;
 
 /***** Cancelation handlers  *****/
-static void cleanup_deadlk(void *arg LTP_ATTRIBUTE_UNUSED)
+static void cleanup_deadlk(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	canceled = 1;
 	pthread_mutex_unlock(p_mtx);
 }
 
 /***** Threads functions *****/
-static void *deadlk_issue(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *deadlk_issue(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret, tmp;
 
@@ -131,7 +131,7 @@ static void *deadlk_issue(void *arg LTP_ATTRIBUTE_UNUSED)
 	return NULL;
 }
 
-static void *unlock_issue(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *unlock_issue(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-2.c
index bcfa4a191..53e4122c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-2.c
@@ -98,14 +98,14 @@ static int canceled = 0;
 static sem_t semA, semB;
 
 /***** Cancelation handlers  *****/
-static void cleanup_deadlk(void *arg LTP_ATTRIBUTE_UNUSED)
+static void cleanup_deadlk(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	canceled = 1;
 	pthread_mutex_unlock(p_mtx);
 }
 
 /***** Threads functions *****/
-static void *deadlk_issue(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *deadlk_issue(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret, tmp;
 
@@ -137,7 +137,7 @@ static void *deadlk_issue(void *arg LTP_ATTRIBUTE_UNUSED)
 	return NULL;
 }
 
-static void *unlock_issue(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *unlock_issue(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c
index 7201927ac..913251914 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/1-1.c
@@ -69,7 +69,7 @@ int main(void)
 	return PTS_PASS;
 }
 
-static void *f1(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *f1(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	int i, tmp;
 	int rc = 0;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
index a8503e072..78685af3d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
@@ -122,7 +122,7 @@ static void *sendsig(void *arg)
 }
 
 /* Next are the signal handlers. */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if ((sem_post(&semsig1))) {
@@ -131,7 +131,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 #endif
 }
 
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if ((sem_post(&semsig2))) {
@@ -143,7 +143,7 @@ static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
 /* The following function loops on init/destroy some mutex (with different attributes)
  * it does check that no error code of EINTR is returned */
 
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	pthread_mutexattr_t ma[4], *pma[5];
 	pthread_mutex_t m[5];
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/4-1.c
index ab6f3a74a..9529f6cc0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/4-1.c
@@ -90,7 +90,7 @@ static pthread_mutex_t mtx;
 static sem_t sem;
 
 /** child thread function **/
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	/* Try to lock the mutex once. The call must fail here. */
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/5-1.c
index 125e08b52..3984d6b92 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/5-1.c
@@ -91,7 +91,7 @@ static sem_t semsig, semstart;
 static int ctrl = 0;
 
 /*********  signal handler  **********/
-static void sighdl(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	if (sem_post(&semsig)) {
 		UNRESOLVED(errno, "Sem_post in signal handler");
@@ -99,7 +99,7 @@ static void sighdl(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /********** thread *********/
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret, i;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/1-1.c
index 878b18857..9955929ea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/1-1.c
@@ -106,7 +106,7 @@ int main(void)
  * f1()
  *
  * *************************/
-static void *f1(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *f1(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/2-1.c
index 0fee00e50..8015dd2e9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/2-1.c
@@ -109,7 +109,7 @@ int main(void)
  * f1()
  *
  * *************************/
-static void *f1(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *f1(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout, ts;
 	int rc;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
index 0e8fa1d58..a7099688b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
@@ -72,7 +72,7 @@ int main(void)
  * f1()
  *
  * *************************/
-static void *f1(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *f1(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
index 02d3b0381..077bfe76d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
@@ -81,7 +81,7 @@ int main(void)
  * f1()
  *
  * *************************/
-static void *f1(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *f1(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
index dc19aa3ff..0eda6e58f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
@@ -81,7 +81,7 @@ int main(void)
  * f1()
  *
  * *************************/
-static void *f1(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *f1(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
index 5f7874a90..baf429503 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
@@ -95,7 +95,7 @@ int main(void)
  * f1()
  *
  * *************************/
-static void *f1(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *f1(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-1.c
index 04a8fcc00..ee3f4587c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/1-1.c
@@ -84,7 +84,7 @@ int main(void)
 	return PTS_PASS;
 }
 
-static void *func(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *func(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
index e2db1b760..e7e86bfa8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
@@ -155,7 +155,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig1)) {
@@ -165,7 +165,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 	if (sem_post(&semsig2)) {
@@ -175,7 +175,7 @@ static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* Test function -- This one calls pthread_mutex_trylock and check that no EINTR is returned. */
-static void *test(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	int i;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
index 3771d59bc..27f0ee3d7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
@@ -65,7 +65,7 @@ int main(void)
 	return PTS_PASS;
 }
 
-static void *func(void *parm LTP_ATTRIBUTE_UNUSED)
+static void *func(void *parm PTS_ATTRIBUTE_UNUSED)
 {
 	int i, tmp;
 	int rc = 0;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/5-1.c
index 44faa1252..f413e55cf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/5-1.c
@@ -79,7 +79,7 @@
 static pthread_mutex_t m;
 
 /** child thread function **/
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	ret = pthread_mutex_unlock(&m);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/2-1.c
index 6eb63fd7b..96c2d4744 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_settype/2-1.c
@@ -31,7 +31,7 @@
 #include <stdlib.h>
 #include "posixtest.h"
 
-static void alarm_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void alarm_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Got SIGALRM after 1 second\n");
 	printf("Test PASSED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/6-1.c
index d7417f71e..018ad6b0c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/6-1.c
@@ -131,7 +131,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -142,7 +142,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -161,7 +161,7 @@ static void initializer(void)
 }
 
 /* Test function -- calls pthread_equal() and checks that EINTR is never returned. */
-static void *test(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/1-1.c
index 187719571..6dca3ce1d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/1-1.c
@@ -25,7 +25,7 @@
 static pthread_rwlock_t rwlock;
 static int thread_state;
 
-static void *fn_rd(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	thread_state = 2;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/2-1.c
index 436b27efa..31ed137de 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_init/2-1.c
@@ -25,7 +25,7 @@
 static pthread_rwlock_t rwlock;
 static int thread_state;
 
-static void *fn_rd(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	thread_state = 2;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c
index 0f201fa25..facdacd94 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c
@@ -42,7 +42,7 @@ static int thread_state;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_rd(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 	thread_state = ENTERED_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/4-1.c
index ae45bf97a..176262713 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/4-1.c
@@ -54,7 +54,7 @@ static void sig_handler()
 	}
 }
 
-static void *th_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct sigaction act;
 	int rc = 0;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/1-1.c
index 0b2251073..f13e8c414 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/1-1.c
@@ -47,7 +47,7 @@ static pthread_rwlock_t rwlock;
 static int thread_state;
 static struct timeval currsec1, currsec2;
 
-static void *fn_rd(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	thread_state = ENTERED_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/2-1.c
index 4f703a43a..2e57403aa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/2-1.c
@@ -45,7 +45,7 @@ static int thread_state;
 static time_t currsec1, currsec2;
 static int expired;
 
-static void *fn_rd(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec abs_timeout;
 	int rc;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/3-1.c
index f4c9e18b7..2585fddc5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/3-1.c
@@ -50,7 +50,7 @@ static pthread_rwlock_t rwlock;
 static int thread_state;
 static struct timeval currsec1, currsec2;
 
-static void *fn_rd(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	thread_state = ENTERED_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c
index 64aeba16a..ae541ffc3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c
@@ -37,7 +37,7 @@ static int thread_state;
 static time_t currsec1;
 static int expired;
 
-static void *fn_rd_1(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd_1(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	thread_state = ENTERED_THREAD;
 	struct timespec abs_timeout;
@@ -82,7 +82,7 @@ static void *fn_rd_1(void *arg LTP_ATTRIBUTE_UNUSED)
 	return NULL;
 }
 
-static void *fn_rd_2(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd_2(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	thread_state = ENTERED_THREAD;
 	struct timespec abs_timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-1.c
index b13656293..ba09b981b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-1.c
@@ -69,7 +69,7 @@ static void sig_handler()
 	}
 }
 
-static void *th_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct sigaction act;
 	struct timespec abs_timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c
index 01ca8663a..7ba2aa91f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c
@@ -78,7 +78,7 @@ static void sig_handler()
 	handler_state = 3;
 }
 
-static void *th_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct sigaction act;
 	struct timespec abs_timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/1-1.c
index 03f91b58f..cdf9d6074 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/1-1.c
@@ -51,7 +51,7 @@ static int expired;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_wr(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_wr(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout;
 	int rc;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/2-1.c
index dfeb7d74c..5bf76b8d5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/2-1.c
@@ -46,7 +46,7 @@ static int expired;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec abs_timeout;
 	int rc;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/3-1.c
index 163439bc1..9dd3f7091 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/3-1.c
@@ -53,7 +53,7 @@ static int expired;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_wr(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_wr(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec timeout, ts;
 	int rc;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c
index f5bebca58..3d9086a83 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c
@@ -44,7 +44,7 @@ static int expired;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_wr_1(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_wr_1(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	thread_state = ENTERED_THREAD;
 	struct timespec abs_timeout;
@@ -89,7 +89,7 @@ static void *fn_wr_1(void *arg LTP_ATTRIBUTE_UNUSED)
 	return NULL;
 }
 
-static void *fn_wr_2(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_wr_2(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	thread_state = ENTERED_THREAD;
 	struct timespec abs_timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-1.c
index 05be6e61a..8253485d1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-1.c
@@ -69,7 +69,7 @@ static void sig_handler()
 	}
 }
 
-static void *th_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct sigaction act;
 	struct timespec abs_timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c
index 08c17478b..a976f48bd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c
@@ -78,7 +78,7 @@ static void sig_handler()
 	handler_state = 3;
 }
 
-static void *th_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct sigaction act;
 	struct timespec abs_timeout;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/1-1.c
index 00690d800..d107d80df 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_tryrdlock/1-1.c
@@ -44,7 +44,7 @@ static int thread_state;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_rd_1(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd_1(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 
@@ -67,7 +67,7 @@ static void *fn_rd_1(void *arg LTP_ATTRIBUTE_UNUSED)
 	return NULL;
 }
 
-static void *fn_rd_2(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd_2(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	thread_state = ENTERED_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c
index c5a14b2a7..b92232878 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_trywrlock/1-1.c
@@ -42,7 +42,7 @@ static int get_ebusy;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_wr(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_wr(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	thread_state = ENTERED_THREAD;
 	int rc;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/1-1.c
index deaea14d7..624dec055 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/1-1.c
@@ -47,7 +47,7 @@ static int thread_state;
 #define PASSED_RLOCK2 4
 #define EXITING_THREAD 5
 
-static void *fn_rd(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_rd(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/2-1.c
index ea3c0c488..b35c141c5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/2-1.c
@@ -40,7 +40,7 @@ static int thread_state;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_wr(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_wr(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
index 5a5c8ecc6..6b52b938a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/4-2.c
@@ -41,7 +41,7 @@ static int rc, thread_state;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_unlk(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_unlk(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	thread_state = ENTERED_THREAD;
 	printf("un_thread: unlock read lock\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/1-1.c
index 17f495937..6786238e7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/1-1.c
@@ -41,7 +41,7 @@ static int thread_state;
 #define ENTERED_THREAD 2
 #define EXITING_THREAD 3
 
-static void *fn_wr(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_wr(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	thread_state = ENTERED_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/2-1.c
index 68158c196..774deb4d9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_wrlock/2-1.c
@@ -54,7 +54,7 @@ static void sig_handler()
 	}
 }
 
-static void *th_fn(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	struct sigaction act;
 	int rc = 0;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/4-1.c
index 5344d0e4b..d09e05673 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/4-1.c
@@ -107,7 +107,7 @@ static void check_param(pthread_t thread, int policy, int priority)
 }
 
 /* thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c
index db155d033..23dfb2659 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_setschedparam/5-1.c
@@ -133,7 +133,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -144,7 +144,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
index 7e2906c7d..81ba4ea9b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/18-1.c
@@ -132,7 +132,7 @@ static void *sendsig(void *arg)
 
 /* Next are the signal handlers. */
 /* This one is registered for signal SIGUSR1 */
-static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl1(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -143,7 +143,7 @@ static void sighdl1(int sig LTP_ATTRIBUTE_UNUSED)
 }
 
 /* This one is registered for signal SIGUSR2 */
-static void sighdl2(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl2(int sig PTS_ATTRIBUTE_UNUSED)
 {
 #ifdef WITH_SYNCHRO
 
@@ -162,7 +162,7 @@ static void initializer(void)
 }
 
 /* Test function -- calls pthread_sigmask() and checks that EINTR is never returned. */
-static void *test(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *test(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret = 0;
 	sigset_t set;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/4-1.c
index b5fa89fc1..b02a1aef8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/4-1.c
@@ -34,7 +34,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/5-1.c
index a337270ba..63f6721c8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/5-1.c
@@ -36,7 +36,7 @@ that SIG_SETMASK removed the old signal from the set.
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c
index bd9c84fe5..3f8e706cb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c
@@ -34,7 +34,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/9-1.c
index ae34a9986..1b9affc4f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/9-1.c
@@ -27,7 +27,7 @@
 static volatile int handler_called;
 static int pthread_sigmask_return_val = 1;	/* some value that's not a 1 or 0 */
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 	if (pthread_sigmask_return_val != 1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/3-1.c
index d763567ae..b3fdf821f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/3-1.c
@@ -31,7 +31,7 @@
 
 static pthread_spinlock_t spinlock;
 
-static void *fn_chld(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_chld(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/4-1.c
index 1a0108bb0..f454290c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_init/4-1.c
@@ -33,7 +33,7 @@
 static pthread_spinlock_t spinlock;
 static int pshared;
 
-static void *fn_chld(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *fn_chld(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int rc;
 	/* child: initialize a spin lock being locked by main thread */
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/raise/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/raise/1-1.c
index 3e2572730..eae549ee6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/raise/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/raise/1-1.c
@@ -22,7 +22,7 @@
 
 #define SIGTOTEST SIGABRT
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal being tested!\n");
 	printf("Test PASSED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/raise/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/raise/1-2.c
index 707730155..474e85a11 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/raise/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/raise/1-2.c
@@ -32,13 +32,13 @@
 
 #define SIGTOTEST SIGABRT
 
-static void parenthandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void parenthandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal from parent!\n");
 	exit(-1);
 }
 
-static void childhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void childhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal from child!\n");
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/raise/10000-1.c b/testcases/open_posix_testsuite/conformance/interfaces/raise/10000-1.c
index 74f9ad95c..c41c89fb1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/raise/10000-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/raise/10000-1.c
@@ -51,7 +51,7 @@ static int invalid_tests[NUMINVALIDTESTS] = {
 	INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192, 1073743192
 };
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal being tested!\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/raise/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/raise/2-1.c
index bb3ed01a7..1dfee2efe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/raise/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/raise/2-1.c
@@ -34,7 +34,7 @@
 #define LEAVINGHANDLER 3
 static int globalStatus = BEFOREHANDLER;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	globalStatus = INHANDLER;
 	printf("Caught signal being tested!\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/raise/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/raise/4-1.c
index 8a27f50e2..1a6ebb23e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/raise/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/raise/4-1.c
@@ -27,7 +27,7 @@
 
 #define SIGTOTEST SIGABRT
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal being tested!\n");
 	printf("Test PASSED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
index 4f4379425..889ff1767 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-1.c
@@ -67,7 +67,7 @@ static void child_process(int id)
 	}
 }
 
-static void sigterm_handler(int signum LTP_ATTRIBUTE_UNUSED)
+static void sigterm_handler(int signum PTS_ATTRIBUTE_UNUSED)
 {
 	close(STDOUT);
 	close(the_pipe[0]);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
index 09d2dd4de..1456b9731 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/2-2.c
@@ -68,7 +68,7 @@ static void child_process(int id)
 	}
 }
 
-static void sigterm_handler(int signum LTP_ATTRIBUTE_UNUSED)
+static void sigterm_handler(int signum PTS_ATTRIBUTE_UNUSED)
 {
 	close(STDOUT);
 	close(the_pipe[0]);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c
index afe9ff310..f198b8052 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c
@@ -19,7 +19,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void *runner(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *runner(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	while (1)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c
index d25cc89b5..6e8a7b3b1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c
@@ -19,7 +19,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void *runner(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *runner(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	while (1)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c
index d37910d39..ae75f186a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c
@@ -19,7 +19,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void *runner(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *runner(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 
 	while (1)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/5-1.c
index 7e5c63b9c..d83f9c9b2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/5-1.c
@@ -35,7 +35,7 @@
 
 static sem_t *gsemp;
 
-static void sighdl(int sig LTP_ATTRIBUTE_UNUSED)
+static void sighdl(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/6-1.c
index 0963935db..009e8ba43 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/6-1.c
@@ -34,7 +34,7 @@
 
 static sem_t *gsemp;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	if (sem_post(gsemp) == -1) {
 		perror(ERROR_PREFIX "sem_post");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c
index 51004e351..f9175839d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/9-1.c
@@ -29,7 +29,7 @@
 #define CHILDPASS 1
 #define CHILDFAIL 0
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("In handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c
index 42cec356d..998100f80 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/13-1.c
@@ -51,7 +51,7 @@
 
 static sem_t sem;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	ret = sem_post(&sem);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/7-1.c
index d163b2034..744667055 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/7-1.c
@@ -27,7 +27,7 @@
 #define CHILDPASS 1
 #define CHILDFAIL 0
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("In handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-1.c
index b27b765c4..2e77bd127 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-1.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-10.c
index 9ccf4dda4..31c6e38ef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-10.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-11.c
index 639f7953d..299821a9e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-11.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-12.c
index 50c6df07a..73d763393 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-12.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-13.c
index d6eb3f2ff..dab4b280f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-13.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-14.c
index 7de3bd75e..88f7ff642 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-14.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-15.c
index ffc32ac20..bc6c7c7ee 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-15.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-16.c
index d8b2cce8f..42daccd25 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-16.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-17.c
index 992f5482c..14803fd06 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-17.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-18.c
index 4c501c311..79a955605 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-18.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-19.c
index c5be3f550..542640315 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-19.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-2.c
index 4c501c311..79a955605 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-2.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-20.c
index 910e1db07..0a38ce4f6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-20.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-21.c
index dd77db16f..cb7957d4f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-21.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-22.c
index 58bf730e7..d252300c0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-22.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-23.c
index 28bd20761..06163a609 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-23.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-24.c
index 19ebef3d7..12efdbf58 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-24.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-25.c
index af42bf6e1..80ff5f053 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-25.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-26.c
index fe21361d0..d52da61e8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-26.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-3.c
index b14ba8745..43d02fea4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-3.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-4.c
index 6d717cffd..a5876a562 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-4.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-5.c
index c3a11c13e..2640b0750 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-5.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-6.c
index b6f7d7663..3e45abc49 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-6.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-7.c
index ffda01b24..f5d465c36 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-7.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-8.c
index 0c97d8e02..3ea22e0ea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-8.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-9.c
index 88d0fa0ee..361a44f80 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/1-9.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
index 16f33f70c..02150a150 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
@@ -23,8 +23,8 @@ static volatile int child_stopped;
 static volatile int child_continued;
 static volatile int notification;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED, siginfo_t *info,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	if (!info)
 		return;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
index c33b827b5..41db84865 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
@@ -30,8 +30,8 @@
 static volatile int child_continued;
 static volatile int waiting = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED, siginfo_t *info,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	if (info && info->si_code == CLD_CONTINUED) {
 		printf("Child has been stopped\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-1.c
index 1c6182baf..207e41f71 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-1.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-10.c
index fd73b31ab..6f8d30a3b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-10.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-11.c
index 49baacb7c..8967b032b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-11.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-12.c
index f16799600..a3cef8e26 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-12.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-13.c
index dc223f114..6e1bc43fc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-13.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-14.c
index f7d831a0e..efb6a8aaa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-14.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-15.c
index daf4405b3..4b196a6ee 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-15.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-16.c
index e64a9a871..f38bf17e2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-16.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-17.c
index a42ea572c..0c2662aa2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-17.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-18.c
index e0c75c5a8..07b193fd8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-18.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-19.c
index e0c75c5a8..07b193fd8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-19.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-2.c
index e0c75c5a8..07b193fd8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-2.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-20.c
index 2ec8c010f..507fa068e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-20.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-21.c
index 7d43233aa..e83a50577 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-21.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-22.c
index 35fabf935..e65cbece4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-22.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-23.c
index 8a0694adb..7c1780703 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-23.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-24.c
index 4776c4dc2..544890a55 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-24.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-25.c
index f62cbca12..490a37f3d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-25.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-26.c
index 27c7aa565..fcd017711 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-26.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-27.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-27.c
index ba81c3fd5..2820e8ad0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-27.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-27.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-28.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-28.c
index ff8b95fb0..48067add8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-28.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-28.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-29.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-29.c
index 7a99bb91f..603f52656 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-29.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-29.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-3.c
index 6e091d3c1..2de66a68b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-3.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-30.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-30.c
index e4e758e99..284ca8c25 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-30.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-30.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-31.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-31.c
index 14a37949d..515d11801 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-31.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-31.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-32.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-32.c
index 9474fe7be..222aaedbd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-32.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-32.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-33.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-33.c
index 092771035..24cb0150f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-33.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-33.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-34.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-34.c
index b98cc959f..658041327 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-34.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-34.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-35.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-35.c
index 93e3635c0..9d5d71b8d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-35.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-35.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-36.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-36.c
index 2b188ae8a..a8db824a9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-36.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-36.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-37.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-37.c
index 8542c0589..80836bd17 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-37.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-37.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-38.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-38.c
index 9f277398a..80cafc6c2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-38.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-38.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-39.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-39.c
index 083993663..d329344e7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-39.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-39.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-4.c
index e242717f7..292f24aa8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-4.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-40.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-40.c
index 3261cb987..745ee813d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-40.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-40.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-41.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-41.c
index 0b63dd9f4..036a034e8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-41.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-41.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-42.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-42.c
index 219669541..07d443771 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-42.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-42.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-43.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-43.c
index 5a3f6dc8d..33a52bdc9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-43.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-43.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-44.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-44.c
index ff8b95fb0..48067add8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-44.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-44.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-45.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-45.c
index ff8b95fb0..48067add8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-45.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-45.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-46.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-46.c
index a2fbcc9ff..69b4432a9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-46.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-46.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-47.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-47.c
index f986a28cf..ebff7d171 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-47.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-47.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-48.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-48.c
index a673976fb..50a74ae06 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-48.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-48.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-49.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-49.c
index d13abc22b..6ce3fb6b6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-49.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-49.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-5.c
index 984763c29..f5870180c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-5.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-50.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-50.c
index 2e90b8142..f48d7c35f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-50.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-50.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-51.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-51.c
index dfe928f86..73e675467 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-51.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-51.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-52.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-52.c
index 3292291ec..ff4a8e7d5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-52.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-52.c
@@ -22,7 +22,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-6.c
index 3933a804c..4ad282966 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-6.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-7.c
index a1535f0c0..9f7657380 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-7.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-8.c
index d9edcacbf..295548523 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-8.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-9.c
index 757e9241e..beb0f2e26 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/12-9.c
@@ -24,7 +24,7 @@
 
 static stack_t alt_ss;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t ss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-1.c
index 44709eaf3..69d123619 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-1.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-10.c
index 4e09652f8..85932092a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-10.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-11.c
index d06510145..ea3e41e00 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-11.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-12.c
index 02678b114..5df208ce6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-12.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-13.c
index 387631497..d4044d9c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-13.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-14.c
index e7b29b4d7..01758234c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-14.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-15.c
index 445d91c77..a4dedd19f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-15.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-16.c
index 66fda191a..152a5f8e8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-16.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-17.c
index 437ddadfc..9bddb4120 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-17.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-18.c
index 719cecc1f..9ce3e5af5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-18.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-19.c
index 719cecc1f..9ce3e5af5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-19.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-2.c
index 719cecc1f..9ce3e5af5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-2.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-20.c
index 4de5f6671..4270861ec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-20.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-21.c
index fa9f23046..42c19d27f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-21.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-22.c
index dc3174b05..34b7912b9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-22.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-23.c
index 1e61f444b..6d29caf14 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-23.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-24.c
index dc330b47e..55651486c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-24.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-25.c
index a0d98f524..c606099e3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-25.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-26.c
index 99e788ef0..eb9e26ebf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-26.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-3.c
index b40037977..00bca9005 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-3.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-4.c
index ac34f5ec3..549665c71 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-4.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-5.c
index c9c20cfe6..527596025 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-5.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-6.c
index f54963c48..833f5915a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-6.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-7.c
index 49078d728..73cb94648 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-7.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-8.c
index c49e5e3a9..7d1784818 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-8.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-9.c
index 69ceb5d6b..75dadd75a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/13-9.c
@@ -23,7 +23,7 @@
 
 static stack_t current;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	stack_t oss;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-1.c
index f6ed3dfc9..bb5d60584 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-1.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGABRT\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-10.c
index a247721a2..68b21e92f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-10.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGPIPE\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-11.c
index 2bd59353e..5c3584e7e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-11.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGQUIT\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-12.c
index bf9db5ff4..cf9b45609 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-12.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGSEGV\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-13.c
index c2f652418..36d1da95d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-13.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTERM\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-14.c
index d91fce338..46e88137f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-14.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTSTP\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-15.c
index ea3fba181..c7a531d0f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-15.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTTIN\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-16.c
index 6a4970a38..ff7583645 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-16.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTTOU\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-17.c
index 33ff02158..208dc8ed7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-17.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGUSR1\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-18.c
index deb7c18b0..4e2ec064f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-18.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGUSR2\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-19.c
index 388d754b7..baede765c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-19.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	wakeup++;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-2.c
index 7277332a2..5f4c10503 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-2.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGALRM\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-20.c
index e0f391602..a90627802 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-20.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGPROF\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-21.c
index fc1e6e84b..4cf3b2d88 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-21.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGSYS\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-22.c
index 835590260..13adff8e0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-22.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTRAP\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-23.c
index 870aa6452..8569ba58e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-23.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGURG\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-24.c
index ef3cc257b..2969f11ad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-24.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGVTALRM\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-25.c
index f3c44f9b0..16fa963d0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-25.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGXCPU\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-26.c
index b22ce56ae..4285781bc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-26.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGXFSZ\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-3.c
index 03d92590c..0dffc9f28 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-3.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGBUS\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-4.c
index 9e27fae5f..8158a700a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-4.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGCHLD\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-5.c
index 903f99e48..39df520ac 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-5.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGCONT\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-6.c
index a8c76a1b1..96d4901b9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-6.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGFPE\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-7.c
index 2d3ec8342..1ba685231 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-7.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGHUP\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-8.c
index 01ab0eb43..4911c4f4c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-8.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGILL\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-9.c
index e305ca028..a1391e4eb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/17-9.c
@@ -27,7 +27,7 @@
 
 static volatile sig_atomic_t wakeup = 1;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGINT\n");
 	wakeup++;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-1.c
index bf82278f8..2421a8e20 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-1.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-10.c
index 798954a22..fdad7cd38 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-10.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-11.c
index 46cc55f7f..e3cf6a91b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-11.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-12.c
index 86970098a..c2458191d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-12.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-13.c
index 78fa6c6e2..80915af32 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-13.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-14.c
index be35b459b..59ed6c252 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-14.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-15.c
index dc67d4a2f..581058985 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-15.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-16.c
index b0390b8b6..b5e2e0bcd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-16.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-17.c
index 19014c0e3..df8bd4967 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-17.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-18.c
index 36ce034ad..117efcd61 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-18.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-19.c
index a12cec7b4..3565a97b6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-19.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-2.c
index a12cec7b4..3565a97b6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-2.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-20.c
index 7486a14f4..eaa6da11a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-20.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-21.c
index 57ec5b989..bc48f9806 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-21.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-22.c
index 0ebfcf3f8..f947ee5eb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-22.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-23.c
index 209caf410..178bfb422 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-23.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-24.c
index 08b5aad74..64e9d957c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-24.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-25.c
index 27f29eb3b..3b39e342e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-25.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-26.c
index 3dfbc2941..c570d6e08 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-26.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-3.c
index e684efb1f..18a159656 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-3.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-4.c
index 78cb5d817..9fdeca2e4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-4.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-5.c
index 2004b734f..01119afce 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-5.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-6.c
index 8e526c6cb..54d9a4583 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-6.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-7.c
index 6cfea8b55..1122cc81d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-7.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-8.c
index 11c6e139c..11ad5a3d0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-8.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-9.c
index c2d6640eb..582dde8d2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/2-9.c
@@ -21,11 +21,11 @@
 #include <stdio.h>
 #include "posixtest.h"
 
-static void handler1(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler1(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
-static void handler2(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler2(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/21-1.c
index 95a6e0b4b..ec7803cb0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/21-1.c
@@ -13,7 +13,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGCHLD\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-1.c
index f348183ee..01b85efb7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-1.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-10.c
index ab3a7bbd8..4d8c9c09c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-10.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-11.c
index 84ed3c137..1390779f2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-11.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-12.c
index 69646d218..79d61572e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-12.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-13.c
index 3e6370d34..174775e9b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-13.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-14.c
index 916292585..ec6f83611 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-14.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-15.c
index 65f04518e..a524f8a96 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-15.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-16.c
index 4bbb509c4..810ac6880 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-16.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-17.c
index 7a5670e64..38019e9ad 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-17.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-18.c
index a56e6da37..283e7cd83 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-18.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-19.c
index a56e6da37..283e7cd83 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-19.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-2.c
index a56e6da37..283e7cd83 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-2.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-20.c
index 2b72bda41..d465bc064 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-20.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-21.c
index 651b9905a..7d128cb22 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-21.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-22.c
index 13186aa8d..2c0d4c249 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-22.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-23.c
index e815537cc..c13b5fa35 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-23.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-24.c
index 6e6fbe54f..1b1906130 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-24.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-25.c
index cb391d71b..17ececc21 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-25.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-26.c
index 45ea22d00..709ebe164 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-26.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-3.c
index 9d8abdd98..e85f47638 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-3.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-4.c
index 53d3eb9c2..ec2837070 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-4.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-5.c
index 694b01d2b..5942430d6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-5.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-6.c
index fe7aebcf4..a5118f4db 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-6.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-7.c
index 1f115a301..bc27c272c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-7.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-8.c
index f0139a2e8..4fb388bd5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-8.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-9.c
index 3e640e053..2edaa6e14 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/22-9.c
@@ -36,7 +36,7 @@
 
 static int handler_count = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-1.c
index 3a1e266b1..d1a11ffe6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-1.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-10.c
index 9274e1154..ae3c43738 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-10.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-11.c
index 099ed9b24..eb4349c0c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-11.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-12.c
index a08d2ecf2..ff045cc92 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-12.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-13.c
index 76df03293..5a8a33daa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-13.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-14.c
index 9e964540d..23e9a1cc0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-14.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-15.c
index 7539d613b..3eb7d768e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-15.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-16.c
index 2abcb9515..1df6d0dd5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-16.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-17.c
index e920b0076..366a00a5b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-17.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-18.c
index 567097b6f..c10f4bd60 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-18.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-19.c
index 3f54e5c6e..e0bf1c50d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-19.c
@@ -72,7 +72,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-2.c
index a33ae205b..966945fa4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-2.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-20.c
index a257ba4e5..ac6329479 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-20.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-21.c
index 76bcbf1a7..abc2bd39a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-21.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-22.c
index d92acfd34..541fd7034 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-22.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-23.c
index 1a055dbef..6abf0d6bf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-23.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-24.c
index 8800f21d0..10edaab39 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-24.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-25.c
index 4b565af60..303e3bdeb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-25.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-26.c
index 275b4ab0c..bcae46282 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-26.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-3.c
index 68d7ea449..fbab86dfb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-3.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-4.c
index af942ab77..fbc8fc1db 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-4.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-5.c
index 29d2f42c5..4f4015d9c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-5.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-6.c
index c5da41ead..ead73d7a0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-6.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-7.c
index b56a5e6a5..d2e1b478d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-7.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-8.c
index 7504438b2..ba284a70f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-8.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-9.c
index 1bdadc68e..339941796 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/23-9.c
@@ -80,7 +80,7 @@
 
 static int called = 0;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	sigset_t pending;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-1.c
index 0c1b01661..ce52d7e17 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-1.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-10.c
index 7203dbd10..a9e056433 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-10.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-11.c
index bb2824115..757a2f2d5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-11.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-12.c
index b03fd3d95..41dabf7e3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-12.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-13.c
index f55b22a23..6e69d986c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-13.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-14.c
index 2ee4094b2..ff0b05f81 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-14.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-15.c
index 215d08b46..ad2e6aa42 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-15.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-16.c
index cff66c8b4..003612c9b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-16.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-17.c
index 6163f33b0..768ba5299 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-17.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-18.c
index 74c8ffccf..bf41e8daa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-18.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-19.c
index 74c8ffccf..bf41e8daa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-19.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-2.c
index 74c8ffccf..bf41e8daa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-2.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-20.c
index f3985b15a..98fef5f0f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-20.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-21.c
index 9eed0d208..70d5e95cf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-21.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-22.c
index c0dff5dac..6ced35c5e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-22.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-23.c
index 530bfbbd3..201e41570 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-23.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-24.c
index a6314bbee..0ca43c2cc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-24.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-25.c
index 1a518c07d..49990d65f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-25.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-26.c
index 6cd1a13ca..44b80c80d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-26.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-3.c
index 0946c67fc..e52fde8f9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-3.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-4.c
index 647e52f94..f0cb4d842 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-4.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-5.c
index b190031f7..42e6f57c5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-5.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-6.c
index e553f1ff6..b971cddfa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-6.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-7.c
index a18b4e02a..fa76618d9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-7.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-8.c
index b456ffbf1..bd73963d8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-8.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-9.c
index 291836be4..b34fcafd6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/25-9.c
@@ -34,7 +34,7 @@
 static int handler_count = 0;
 static int handler_error = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	static int inside_handler = 0;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/29-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/29-1.c
index 55dbaca33..5069efc50 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/29-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/29-1.c
@@ -86,8 +86,8 @@
 
 static volatile sig_atomic_t latest;
 
-static void handler(int sig LTP_ATTRIBUTE_UNUSED, siginfo_t *info,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int sig PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	if (info->si_signo != SIGRTMAX) {
 		output("Received unexpected signal %d\n", info->si_signo);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-1.c
index 33c3a44f8..2d88215fe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-1.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-10.c
index 2a1b3d7b1..8c586a480 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-10.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-11.c
index c2532fbab..462808f83 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-11.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-12.c
index 7145fc5fd..c6cdd2b27 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-12.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-13.c
index 02206c961..8a9cbe56b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-13.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-14.c
index dd74a1dfc..ed4432f7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-14.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-15.c
index 16f5b401e..43d365955 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-15.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-16.c
index d10e1a52a..9df835116 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-16.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-17.c
index 00a85da05..e18f03db4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-17.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-18.c
index 0501bec1d..f59dd7167 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-18.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-19.c
index 0501bec1d..f59dd7167 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-19.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-2.c
index 0501bec1d..f59dd7167 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-2.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-20.c
index cb97b3536..dd3932bbe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-20.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-21.c
index 1ce6f14b9..940589213 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-21.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-22.c
index 5f410c90b..f25f9cb68 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-22.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-23.c
index b8a71c779..8928ad1c2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-23.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-24.c
index edbe56253..798cf36b2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-24.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-25.c
index ca27b988e..07a7130ff 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-25.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-26.c
index fc38226ad..c1f3828d4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-26.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-3.c
index 86a6b3e6a..3a5d5d749 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-3.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-4.c
index 73b104494..59a22beb9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-4.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-5.c
index 1226f74bf..683e4737c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-5.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-6.c
index 5a55a2e3a..961c71554 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-6.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-7.c
index 7a0aff122..684cced4b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-7.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-8.c
index 9b74ba1cb..e3f8c39ef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-8.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-9.c
index 7a66cf5ed..22e10231c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/3-9.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/30-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/30-1.c
index f04ab82f0..0251e49fc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/30-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/30-1.c
@@ -80,7 +80,7 @@
 /***************************    Test case   ***********************************/
 /******************************************************************************/
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	return;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-1.c
index a8e51f558..596e56dcf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-1.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-10.c
index 9a572adc5..5f8e79ea2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-10.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-100.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-100.c
index d3fb41699..e49fc9aa8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-100.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-100.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-101.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-101.c
index 783c3224e..006b884a5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-101.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-101.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-102.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-102.c
index 44c8b4571..053fda365 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-102.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-102.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-103.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-103.c
index bfb6bbdbb..425678524 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-103.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-103.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-104.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-104.c
index f463648bb..cd9c075ab 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-104.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-104.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-11.c
index eef68f77d..57d7f63c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-11.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-12.c
index 02cb15ee7..79b786496 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-12.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-13.c
index 2a78e3b70..8d7f33724 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-13.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-14.c
index 53b5bfdc2..334d39367 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-14.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-15.c
index 543fd49b1..fff90d000 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-15.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-16.c
index e6818eca0..f86b4103b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-16.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-17.c
index 46129d9f9..c99a06ac6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-17.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-18.c
index 26c9e2fbb..f8bea65fd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-18.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-19.c
index 26c9e2fbb..f8bea65fd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-19.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-2.c
index 26c9e2fbb..f8bea65fd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-2.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-20.c
index ed28bd346..0c759120e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-20.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-21.c
index 441edb791..ba014a5ab 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-21.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-22.c
index 89f28d5f5..2822977f0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-22.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-23.c
index 3cbbbfa25..b9cdc2a59 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-23.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-24.c
index e7103a4c6..ee9b9823d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-24.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-25.c
index d25c34422..259dd7d9a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-25.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-26.c
index af0656bb2..09ee6b0fc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-26.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-27.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-27.c
index d669e0061..a460dfb3a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-27.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-27.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-28.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-28.c
index c672e9fba..715cdba44 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-28.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-28.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-29.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-29.c
index 283cc219e..234ad5b0d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-29.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-29.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-3.c
index 3cb215cc8..a63605023 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-3.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-30.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-30.c
index 759785e2c..dca9a1d8d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-30.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-30.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-31.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-31.c
index dfd91a381..4e697b35d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-31.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-31.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-32.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-32.c
index b9abb704d..7927567f8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-32.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-32.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-33.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-33.c
index 4ac8e0569..a60910077 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-33.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-33.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-34.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-34.c
index 243c7f9b2..e5e8fa2b1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-34.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-34.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-35.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-35.c
index 2b00e2f8e..a3b515701 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-35.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-35.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-36.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-36.c
index 9a62ea91c..d4208c466 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-36.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-36.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-37.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-37.c
index 25cd8217a..40c1effe2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-37.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-37.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-38.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-38.c
index 4b467db74..58e44c9cc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-38.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-38.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-39.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-39.c
index 64d578de9..90b032684 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-39.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-39.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-4.c
index 9cf5df0b2..d5d0869f9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-4.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-40.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-40.c
index 1c180e1df..c4a192d98 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-40.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-40.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-41.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-41.c
index f363d20e7..1c73ceffc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-41.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-41.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-42.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-42.c
index 0b6875530..959f3216b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-42.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-42.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-43.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-43.c
index 4a91190da..736f67c28 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-43.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-43.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-44.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-44.c
index c672e9fba..715cdba44 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-44.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-44.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-45.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-45.c
index c672e9fba..715cdba44 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-45.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-45.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-46.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-46.c
index 0cb2d8d73..185776ee7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-46.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-46.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-47.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-47.c
index 24f9c118c..96722c6c0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-47.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-47.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-48.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-48.c
index af57f8dfb..643b36ec0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-48.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-48.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-49.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-49.c
index a5d241baf..624d576bf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-49.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-49.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-5.c
index cf37081d5..0e1de9efb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-5.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-50.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-50.c
index 79e9164bf..bf53fd04a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-50.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-50.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-51.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-51.c
index 3bc46bbdb..4fd3c889a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-51.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-51.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-52.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-52.c
index 8023f1e96..2bcda90c7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-52.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-52.c
@@ -30,7 +30,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("About to stop child\n");
 	raise(SIGSTOP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-53.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-53.c
index 47aeb5774..6b4107a34 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-53.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-53.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-54.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-54.c
index 876eb533e..8267ed2ba 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-54.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-54.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-55.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-55.c
index d5f879f2f..50aa80c18 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-55.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-55.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-56.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-56.c
index 4cdd92895..08f059b48 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-56.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-56.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-57.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-57.c
index 2d7742ab0..43d4cba41 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-57.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-57.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-58.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-58.c
index a1272f631..9cf85191c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-58.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-58.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-59.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-59.c
index 2d35f6e41..3a9c1e00d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-59.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-59.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-6.c
index 71b247a39..018e745b6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-6.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-60.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-60.c
index 5d8955c40..0e3bc9d3e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-60.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-60.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-61.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-61.c
index 11172bce5..aa08b220f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-61.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-61.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-62.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-62.c
index 63e768e1c..192cae683 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-62.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-62.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-63.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-63.c
index 53964612b..2a28dfe15 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-63.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-63.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-64.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-64.c
index f579834b2..7262039b4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-64.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-64.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-65.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-65.c
index 345f94669..2bd830212 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-65.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-65.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-66.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-66.c
index ec406c992..bef063761 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-66.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-66.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-67.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-67.c
index 528605688..62b3ee0c2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-67.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-67.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-68.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-68.c
index aeb9bda86..a8b9927e6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-68.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-68.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-69.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-69.c
index c2f7def65..a90a76031 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-69.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-69.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-7.c
index 91c6ffc5b..8f8905d68 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-7.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-70.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-70.c
index bde8e07e6..bbb35adf1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-70.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-70.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-71.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-71.c
index 876eb533e..8267ed2ba 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-71.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-71.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-72.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-72.c
index 1cc7eb6bb..47ed9c146 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-72.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-72.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-73.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-73.c
index fa4804dd4..694301ad2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-73.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-73.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-74.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-74.c
index 4c66f0297..4eb18e08d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-74.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-74.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-75.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-75.c
index aec4b59c4..66b8579de 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-75.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-75.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-76.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-76.c
index 10ca5bb06..e90c37282 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-76.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-76.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-77.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-77.c
index 2db0d383a..8a9aa8af8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-77.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-77.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-78.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-78.c
index b77d68749..4bb1e1122 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-78.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-78.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-79.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-79.c
index f58548f2e..ce3afda49 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-79.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-79.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-8.c
index 29f1dfa47..f8ccf6224 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-8.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-80.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-80.c
index f9efce7c9..ba2646d5e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-80.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-80.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-81.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-81.c
index d57b5f0d0..2f210586a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-81.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-81.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-82.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-82.c
index e1566cedc..d0a688c50 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-82.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-82.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-83.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-83.c
index 279637ab7..aa853f2ed 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-83.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-83.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-84.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-84.c
index 80b6ea8c3..52ea39be7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-84.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-84.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-85.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-85.c
index a00a4509e..0c332440a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-85.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-85.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-86.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-86.c
index cd47dd94c..25551cc4f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-86.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-86.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-87.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-87.c
index 19ca3f6e2..b858f00eb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-87.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-87.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-88.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-88.c
index a66ebbde5..7bdd4a7a3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-88.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-88.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-89.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-89.c
index 6fc426027..5d184df35 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-89.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-89.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-9.c
index 9b3b559a6..af9e2e409 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-9.c
@@ -29,7 +29,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGKILL);
 	exit(0);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-90.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-90.c
index 0fbe33cd0..f96f798f1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-90.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-90.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-91.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-91.c
index 10148b3f0..5d60676e9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-91.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-91.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-92.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-92.c
index 5e157f222..e607a28c5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-92.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-92.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-93.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-93.c
index f25104808..83b5ead40 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-93.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-93.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-94.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-94.c
index 8493484b2..6cf5086e1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-94.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-94.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-95.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-95.c
index cb10f02b6..a207d888b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-95.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-95.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-96.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-96.c
index 0d56f13f3..256ccded0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-96.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-96.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-97.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-97.c
index f9efce7c9..ba2646d5e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-97.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-97.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-98.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-98.c
index 6217e5fab..56031b9ab 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-98.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-98.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-99.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-99.c
index 53c0d1ce1..0d4da954b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-99.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/4-99.c
@@ -18,7 +18,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-1.c
index 509898307..d9646716e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-1.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-10.c
index dee47114e..a80c91b36 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-10.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-11.c
index db8fcb0f0..1a0c62853 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-11.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-12.c
index 1237406ca..3c85e679a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-12.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-13.c
index d006b37f8..9b4217917 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-13.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-14.c
index b6d0943f5..85fb4e222 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-14.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-15.c
index 9b1dce0b0..dbf199f8b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-15.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-16.c
index ea2ea66ef..94ee1cc2a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-16.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-17.c
index 7cd51c879..79a730ed9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-17.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-18.c
index 7ddeac83a..5fa60e8ac 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-18.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-19.c
index 7ddeac83a..5fa60e8ac 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-19.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-2.c
index 7ddeac83a..5fa60e8ac 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-2.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-20.c
index 67b5814de..5e9534cb1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-20.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-21.c
index a7208584c..19270c24c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-21.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-22.c
index 80bd1d320..05fcf55c9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-22.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-23.c
index 312cae7f8..810aee370 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-23.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-24.c
index 8cc4dfb60..23f3ab3f9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-24.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-25.c
index 08709ea5b..76efdd2d3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-25.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-26.c
index 2843ab2b6..df5c80de4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-26.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-3.c
index 3b3863887..4d98c90a4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-3.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-4.c
index 4d789fa54..77ae20b8c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-4.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-5.c
index 6eb7a0473..1034c7325 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-5.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-6.c
index f88bdb361..282dbe2f6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-6.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-7.c
index d415a33fb..142485f6e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-7.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-8.c
index 452a0161f..fd7f1104e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-8.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-9.c
index 7b4dd5639..353eb779c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/6-9.c
@@ -20,9 +20,9 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-1.c
index 55dc31250..c9b530e7b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-1.c
@@ -20,13 +20,13 @@
 
 static int SIGXFSZ_count = 0;
 
-static void SIGXFSZ_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGXFSZ_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGXFSZ_count++;
 	printf("Caught SIGXFSZ\n");
 }
 
-static void SIGABRT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGABRT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGABRT\n");
 	raise(SIGXFSZ);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-10.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-10.c
index 57bcc36de..c51c996a7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-10.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-10.c
@@ -20,13 +20,13 @@
 
 static int SIGINT_count = 0;
 
-static void SIGINT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGINT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGINT_count++;
 	printf("Caught SIGINT\n");
 }
 
-static void SIGPIPE_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGPIPE_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGPIPE\n");
 	raise(SIGINT);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-11.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-11.c
index bc4073bf0..9ea72cc6a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-11.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-11.c
@@ -20,13 +20,13 @@
 
 static int SIGPIPE_count = 0;
 
-static void SIGPIPE_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGPIPE_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGPIPE_count++;
 	printf("Caught SIGPIPE\n");
 }
 
-static void SIGQUIT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGQUIT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGQUIT\n");
 	raise(SIGPIPE);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-12.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-12.c
index a7cc35cd7..2ff2a3287 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-12.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-12.c
@@ -20,13 +20,13 @@
 
 static int SIGQUIT_count = 0;
 
-static void SIGQUIT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGQUIT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGQUIT_count++;
 	printf("Caught SIGQUIT\n");
 }
 
-static void SIGSEGV_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGSEGV_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGSEGV\n");
 	raise(SIGQUIT);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-13.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-13.c
index 087794cad..dba7f9935 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-13.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-13.c
@@ -20,13 +20,13 @@
 
 static int SIGSEGV_count = 0;
 
-static void SIGSEGV_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGSEGV_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGSEGV_count++;
 	printf("Caught SIGSEGV\n");
 }
 
-static void SIGTERM_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTERM_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTERM\n");
 	raise(SIGSEGV);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-14.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-14.c
index 9181509bf..1b2984884 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-14.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-14.c
@@ -20,13 +20,13 @@
 
 static int SIGTERM_count = 0;
 
-static void SIGTERM_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTERM_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGTERM_count++;
 	printf("Caught SIGTERM\n");
 }
 
-static void SIGTSTP_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTSTP_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTSTP\n");
 	raise(SIGTERM);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-15.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-15.c
index 3fddc0bf3..0167d8e7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-15.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-15.c
@@ -20,13 +20,13 @@
 
 static int SIGTSTP_count = 0;
 
-static void SIGTSTP_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTSTP_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGTSTP_count++;
 	printf("Caught SIGTSTP\n");
 }
 
-static void SIGTTIN_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTTIN_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTTIN\n");
 	raise(SIGTSTP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-16.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-16.c
index 211724de1..755b88d92 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-16.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-16.c
@@ -20,13 +20,13 @@
 
 static int SIGTTIN_count = 0;
 
-static void SIGTTIN_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTTIN_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGTTIN_count++;
 	printf("Caught SIGTTIN\n");
 }
 
-static void SIGTTOU_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTTOU_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTTOU\n");
 	raise(SIGTTIN);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-17.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-17.c
index 6863f12cc..c7a603c5c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-17.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-17.c
@@ -20,13 +20,13 @@
 
 static int SIGTTOU_count = 0;
 
-static void SIGTTOU_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTTOU_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGTTOU_count++;
 	printf("Caught SIGTTOU\n");
 }
 
-static void SIGUSR1_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR1_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGUSR1\n");
 	raise(SIGTTOU);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-18.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-18.c
index 6a57f4de2..c5c4d6659 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-18.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-18.c
@@ -20,13 +20,13 @@
 
 static int SIGUSR1_count = 0;
 
-static void SIGUSR1_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR1_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGUSR1_count++;
 	printf("Caught SIGUSR1\n");
 }
 
-static void SIGUSR2_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR2_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGUSR2\n");
 	raise(SIGUSR1);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-19.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-19.c
index cedc94ba3..f67ea540d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-19.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-19.c
@@ -20,12 +20,12 @@
 
 static int SIGUSR2_count = 0;
 
-static void SIGUSR2_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR2_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGUSR2_count++;
 }
 
-static void SIGUSR1_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR1_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	raise(SIGUSR2);
 	if (SIGUSR2_count) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-2.c
index 76f64d4db..af19bab27 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-2.c
@@ -20,13 +20,13 @@
 
 static int SIGABRT_count = 0;
 
-static void SIGABRT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGABRT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGABRT_count++;
 	printf("Caught SIGABRT\n");
 }
 
-static void SIGUSR2_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR2_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGUSR2\n");
 	raise(SIGABRT);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-20.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-20.c
index dc77e0d00..edf80952e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-20.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-20.c
@@ -20,13 +20,13 @@
 
 static int SIGUSR2_count = 0;
 
-static void SIGUSR2_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR2_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGUSR2_count++;
 	printf("Caught SIGUSR2\n");
 }
 
-static void SIGPROF_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGPROF_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGPROF\n");
 	raise(SIGUSR2);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-21.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-21.c
index 0216b117c..8118c99f7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-21.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-21.c
@@ -20,13 +20,13 @@
 
 static int SIGPROF_count = 0;
 
-static void SIGPROF_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGPROF_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGPROF_count++;
 	printf("Caught SIGPROF\n");
 }
 
-static void SIGSYS_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGSYS_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGSYS\n");
 	raise(SIGPROF);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-22.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-22.c
index 4e2a4a5bb..7ca6a7155 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-22.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-22.c
@@ -20,13 +20,13 @@
 
 static int SIGSYS_count = 0;
 
-static void SIGSYS_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGSYS_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGSYS_count++;
 	printf("Caught SIGSYS\n");
 }
 
-static void SIGTRAP_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTRAP_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGTRAP\n");
 	raise(SIGSYS);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-23.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-23.c
index b17723de9..a04db1706 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-23.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-23.c
@@ -20,13 +20,13 @@
 
 static int SIGTRAP_count = 0;
 
-static void SIGTRAP_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGTRAP_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGTRAP_count++;
 	printf("Caught SIGTRAP\n");
 }
 
-static void SIGURG_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGURG_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGURG\n");
 	raise(SIGTRAP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-24.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-24.c
index 69dd3ad1f..f343eb9df 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-24.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-24.c
@@ -20,13 +20,13 @@
 
 static int SIGURG_count = 0;
 
-static void SIGURG_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGURG_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGURG_count++;
 	printf("Caught SIGURG\n");
 }
 
-static void SIGVTALRM_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGVTALRM_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGVTALRM\n");
 	raise(SIGURG);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-25.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-25.c
index 45a329ffa..0688e5947 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-25.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-25.c
@@ -20,13 +20,13 @@
 
 static int SIGVTALRM_count = 0;
 
-static void SIGVTALRM_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGVTALRM_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGVTALRM_count++;
 	printf("Caught SIGVTALRM\n");
 }
 
-static void SIGXCPU_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGXCPU_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGXCPU\n");
 	raise(SIGVTALRM);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-26.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-26.c
index 302232175..81878cd74 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-26.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-26.c
@@ -20,13 +20,13 @@
 
 static int SIGXCPU_count = 0;
 
-static void SIGXCPU_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGXCPU_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGXCPU_count++;
 	printf("Caught SIGXCPU\n");
 }
 
-static void SIGXFSZ_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGXFSZ_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGXFSZ\n");
 	raise(SIGXCPU);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-3.c
index e97ba66ad..2f78ec9bf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-3.c
@@ -20,13 +20,13 @@
 
 static int SIGUSR2_count = 0;
 
-static void SIGUSR2_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR2_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGUSR2_count++;
 	printf("Caught SIGUSR2\n");
 }
 
-static void SIGBUS_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGBUS_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGBUS\n");
 	raise(SIGUSR2);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-4.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-4.c
index 4910bc2c1..c5a2f5dfe 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-4.c
@@ -20,13 +20,13 @@
 
 static int SIGBUS_count = 0;
 
-static void SIGBUS_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGBUS_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGBUS_count++;
 	printf("Caught SIGBUS\n");
 }
 
-static void SIGCHLD_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGCHLD_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGCHLD\n");
 	raise(SIGBUS);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-5.c
index 2c4175b22..018d94bcb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-5.c
@@ -20,13 +20,13 @@
 
 static int SIGCHLD_count = 0;
 
-static void SIGCHLD_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGCHLD_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGCHLD_count++;
 	printf("Caught SIGCHLD\n");
 }
 
-static void SIGCONT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGCONT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGCONT\n");
 	raise(SIGCHLD);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-6.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-6.c
index 31665282d..fab686b3e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-6.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-6.c
@@ -20,13 +20,13 @@
 
 static int SIGCONT_count = 0;
 
-static void SIGCONT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGCONT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGCONT_count++;
 	printf("Caught SIGCONT\n");
 }
 
-static void SIGFPE_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGFPE_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGFPE\n");
 	raise(SIGCONT);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-7.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-7.c
index 29203c701..119f8fdbb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-7.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-7.c
@@ -20,13 +20,13 @@
 
 static int SIGFPE_count = 0;
 
-static void SIGFPE_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGFPE_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGFPE_count++;
 	printf("Caught SIGFPE\n");
 }
 
-static void SIGHUP_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGHUP_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGHUP\n");
 	raise(SIGFPE);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-8.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-8.c
index 493cd7c5f..bd887ded9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-8.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-8.c
@@ -20,13 +20,13 @@
 
 static int SIGHUP_count = 0;
 
-static void SIGHUP_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGHUP_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGHUP_count++;
 	printf("Caught SIGHUP\n");
 }
 
-static void SIGILL_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGILL_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGILL\n");
 	raise(SIGHUP);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-9.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-9.c
index 8d8a49305..0601917aa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-9.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/8-9.c
@@ -20,13 +20,13 @@
 
 static int SIGILL_count = 0;
 
-static void SIGILL_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGILL_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	SIGILL_count++;
 	printf("Caught SIGILL\n");
 }
 
-static void SIGINT_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGINT_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught SIGINT\n");
 	raise(SIGILL);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
index 2bad3209e..1d45c09c6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
@@ -31,8 +31,8 @@
 
 static volatile int child_stopped;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED, siginfo_t *info,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED, siginfo_t *info,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	if (info && info->si_code == CLD_STOPPED) {
 		printf("Child has been stopped\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sighold/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sighold/1-1.c
index 632596a84..d00e4e11f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sighold/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sighold/1-1.c
@@ -21,7 +21,7 @@
 
 static int handler_called = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigignore/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigignore/1-1.c
index 69c5886e3..97a926f19 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigignore/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigignore/1-1.c
@@ -20,7 +20,7 @@ signal is ever raised.
 
 static int handler_called = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/signal/1-1.c
index 73c348fac..c4ebf5bec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/signal/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/signal/1-1.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGCHLD called. Inside handler\n");
 	handler_called = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/signal/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/signal/2-1.c
index 7468dd5db..35b7f49ea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/signal/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/signal/2-1.c
@@ -23,7 +23,7 @@
 
 static volatile int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGCHLD called. Inside handler\n");
 	handler_called = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/signal/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/signal/3-1.c
index 9aa8f800b..914be5971 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/signal/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/signal/3-1.c
@@ -21,7 +21,7 @@
 
 static volatile int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGCHLD called. Inside handler\n");
 	handler_called = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/signal/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/signal/5-1.c
index af1b90069..e07399d33 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/signal/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/signal/5-1.c
@@ -22,12 +22,12 @@
 #include <stdlib.h>
 #include "posixtest.h"
 
-static void SIGUSR1_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR1_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("do nothing useful\n");
 }
 
-static void SIGUSR2_handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void SIGUSR2_handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("do nothing useful\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/signal/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/signal/6-1.c
index 85cb80bd0..e49045ad1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/signal/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/signal/6-1.c
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("handler does nothing useful.\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/signal/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/signal/7-1.c
index 1803df588..f70f85eec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/signal/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/signal/7-1.c
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("handler does nothing useful.\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-2.c
index ee39041b8..3537ce85f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-2.c
@@ -32,7 +32,7 @@
 #include <stdlib.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	sigset_t pendingset;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-3.c
index c32477eb4..80aa4a6d7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigpending/1-3.c
@@ -33,7 +33,7 @@
 #include <stdlib.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	sigset_t pendingset;
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/4-1.c
index d0dd27819..fac3229f8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/4-1.c
@@ -17,7 +17,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/5-1.c
index 7def690de..d00af5a81 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/5-1.c
@@ -15,7 +15,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/6-1.c
index 5c3cb5303..395a5f409 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/6-1.c
@@ -17,7 +17,7 @@
 
 static volatile int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/9-1.c
index f3257d1b3..ef197e53d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigprocmask/9-1.c
@@ -26,7 +26,7 @@
 static volatile int handler_called;
 static int sigprocmask_return_val = 1;	/* some value that's not a 1 or 0 */
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 	if (sigprocmask_return_val != 1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/1-1.c
index a8e2cce3b..e456c4829 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/1-1.c
@@ -29,7 +29,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo, siginfo_t *info, void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo, siginfo_t *info, void *context PTS_ATTRIBUTE_UNUSED)
 {
 	if (signo == SIGTOTEST && info->si_value.sival_int == VALTOTEST) {
 		printf
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/4-1.c
index 4cb1c0676..a38fa7a49 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/4-1.c
@@ -31,9 +31,9 @@
 
 static volatile int counter;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	counter++;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c
index a38897086..87e997d84 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/5-1.c
@@ -31,7 +31,7 @@
 
 static volatile int counter = 0;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	counter++;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/6-1.c
index e6e3cde2b..25b7ac670 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/6-1.c
@@ -37,9 +37,9 @@
 static int return_val = 1;
 static volatile int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 	if (return_val != 1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/7-1.c
index d1704724a..fac11ea43 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/7-1.c
@@ -34,8 +34,8 @@
 static int last_signal;
 static volatile int test_failed;
 
-static void myhandler(int signo, siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo, siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	printf("%d, ", signo);
 	if (last_signal >= signo) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/8-1.c
index 8494bc3cd..e7d1ec802 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigqueue/8-1.c
@@ -32,9 +32,9 @@
 
 static volatile int counter;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	counter++;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigrelse/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigrelse/1-1.c
index ad212ce4e..60d0a95cb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigrelse/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigrelse/1-1.c
@@ -25,7 +25,7 @@
 
 static int handler_called;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/1-1.c
index d728589ab..80dfdf328 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/1-1.c
@@ -25,7 +25,7 @@
 
 static volatile int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGCHLD called. Inside handler\n");
 	handler_called = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/2-1.c
index eca1db24a..a3edbdd61 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/2-1.c
@@ -24,7 +24,7 @@
 
 static volatile int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGUSR1 called. Inside handler\n");
 	handler_called = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/3-1.c
index 3233d207c..39e0531c5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/3-1.c
@@ -22,7 +22,7 @@
 
 static volatile int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGCHLD called. Inside handler\n");
 	handler_called = 1;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/4-1.c
index 8d6c31d55..3634caec0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/4-1.c
@@ -18,7 +18,7 @@
 
 static int signal_blocked = 0;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGCHLD called. Inside handler\n");
 	sigset_t mask;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/5-1.c
index 62317e5a4..1b91717c9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/5-1.c
@@ -50,7 +50,7 @@ static int is_empty(sigset_t * set)
 	return 1;
 }
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
index b8b43d8d6..25c4f16aa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
@@ -27,7 +27,7 @@
 #define ERR_MSG(f, rc) printf("Failed: func: %s rc: %u errno: %s\n", \
 						f, rc, strerror(errno))
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGCHLD called. Inside handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
index a6254bbfe..d4082cc49 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
@@ -34,7 +34,7 @@
 
 static int handler_called;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	handler_called = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/9-1.c
index b8d8a7336..4e5d74e8c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/9-1.c
@@ -16,7 +16,7 @@
 #include <stdlib.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("SIGUSR1 called. Inside handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/4-1.c
index acfe85f1c..b3b0c4c19 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/4-1.c
@@ -35,7 +35,7 @@
 
 #define NUMSIGNALS (sizeof(siglist) / sizeof(siglist[0]))
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 }
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/6-1.c
index 6fd6e4f5b..727610799 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigsuspend/6-1.c
@@ -25,7 +25,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Now inside signal handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c
index 78ab585d2..785751295 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/1-1.c
@@ -45,7 +45,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf
 	    ("Test FAILED: %d seconds have elapsed and sigtimedwait() has not yet returned.\n",
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c
index b4ebc2961..4677a12ea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/2-1.c
@@ -46,7 +46,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf
 	    ("Test FAILED: %d seconds have elapsed and sigtimedwait() has not yet returned.\n",
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/4-1.c
index 08955956f..c3cd42f18 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/4-1.c
@@ -26,7 +26,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Inside handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/5-1.c
index 7a5e50a38..9496764ee 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/5-1.c
@@ -39,7 +39,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf
 	    ("Test FAILED: %d seconds have elapsed and sigtimedwait() has not yet returned.\n",
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/6-1.c
index 6ecb9f916..ac5eee49b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigtimedwait/6-1.c
@@ -41,7 +41,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf
 	    ("Test FAILED: %d seconds have elapsed and sigtimedwait() has not yet returned.\n",
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c
index 3b9004635..1d1fddedd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-1.c
@@ -85,7 +85,7 @@ static volatile int n_awaken = 0;
 static sigset_t setusr;
 
 /* Thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	int sig;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-2.c
index a7864ee7c..a1f49a651 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/6-2.c
@@ -85,7 +85,7 @@ static pthread_t last_awaken;
 static sigset_t setusr;
 
 /* Thread function */
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg PTS_ATTRIBUTE_UNUSED)
 {
 	int ret;
 	int sig;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/1-1.c
index 33310f684..2449055c7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/1-1.c
@@ -26,7 +26,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Inside handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/2-1.c
index dfbea295d..6983eda12 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/2-1.c
@@ -28,9 +28,9 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Inside dummy handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/3-1.c
index 68185949a..3983a3dbc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/3-1.c
@@ -26,7 +26,7 @@
 #include <unistd.h>
 #include "posixtest.h"
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Inside dummy handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/5-1.c
index 58705abda..4e33fca30 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/5-1.c
@@ -25,9 +25,9 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Inside handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/6-1.c
index 5ef3d4a6d..197aae55c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/6-1.c
@@ -25,9 +25,9 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Inside handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/7-1.c
index 98600ac1a..2ed4ca81b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/7-1.c
@@ -32,9 +32,9 @@
 
 static int counter;
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	counter++;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/8-1.c
index a6e83f74a..f999aa37d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/8-1.c
@@ -31,9 +31,9 @@
 #include <errno.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED,
-	siginfo_t *info LTP_ATTRIBUTE_UNUSED,
-	void *context LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED,
+	siginfo_t *info PTS_ATTRIBUTE_UNUSED,
+	void *context PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Just a dummy handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/9-1.c
index 1b613b16b..97b06382d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwaitinfo/9-1.c
@@ -25,7 +25,7 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
-static void myhandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void myhandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Inside handler\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/1-1.c
index 4c87254b6..89a1cab80 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/1-1.c
@@ -34,7 +34,7 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
index 4c6198503..9cec5d7da 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/10-1.c
@@ -23,7 +23,7 @@
 
 static volatile int caught_signal;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	caught_signal = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
index 388441336..34afee0d2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
@@ -23,7 +23,7 @@
 
 static volatile int caught_signal;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	caught_signal = 1;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/3-1.c
index 07d4e4439..a843d02af 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/3-1.c
@@ -24,7 +24,7 @@
 #define SIGTOTEST SIGALRM
 #define SLEEPTIME 3
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/7-1.c
index 6e688e832..d6c8d2475 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/7-1.c
@@ -24,7 +24,7 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/8-1.c
index ceaf083b2..fe771a559 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/8-1.c
@@ -43,12 +43,12 @@
 #define CHILDSUCCESS 1
 #define CHILDFAILURE 0
 
-static void parenthandler(int signo LTP_ATTRIBUTE_UNUSED)
+static void parenthandler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Expected - Caught signal\n");
 }
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Not expected - Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c
index 47d95e34d..a68879389 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/9-1.c
@@ -29,7 +29,7 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/5-1.c
index a67de44ce..a2c06f706 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/speculative/5-1.c
@@ -42,7 +42,7 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/1-1.c
index 24c6b3322..c4bfb490e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/1-1.c
@@ -31,7 +31,7 @@
 #define SIGTOTEST SIGALRM
 #define TIMERSEC 3
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Should not have caught signal\n");
 	exit(PTS_FAIL);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
index a50036c3d..e8f4459bb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_delete/speculative/5-2.c
@@ -26,7 +26,7 @@
 #define SIGTOTEST SIGALRM
 #define TIMERSEC 3
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Should not have caught signal\n");
 	exit(PTS_FAIL);
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/1-1.c
index 31f914159..70fb9941b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/1-1.c
@@ -27,7 +27,7 @@
 
 static int madeit = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	madeit++;
 	if (madeit > 1) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-1.c
index 8bf54b8e6..512f93dba 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-1.c
@@ -36,7 +36,7 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-2.c
index 911dc6961..25e07adbb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/1-2.c
@@ -28,7 +28,7 @@
 #define ACCEPTABLEDELTA 1
 #define NUMTESTS 6
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-1.c
index 2ee5d92e5..315849213 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-1.c
@@ -30,7 +30,7 @@
 #define SIGTOTEST SIGALRM
 #define SLEEPDELTA 3
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Incorrectly in signal handler\n");
 	printf("Test FAILED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-2.c
index a057a2810..f81da9408 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-2.c
@@ -22,7 +22,7 @@
 #define SIGTOTEST SIGALRM
 #define TIMEREXPIRE 3
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Incorrectly in signal handler\n");
 	printf("Test FAILED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-3.c
index bf9c621b4..b9fc829a6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/3-3.c
@@ -24,7 +24,7 @@
 
 #define SIGTOTEST SIGALRM
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("OK to be in once\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-1.c
index 87413512a..3425294bf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-1.c
@@ -31,7 +31,7 @@
 #define SLEEPDELTA 3
 #define ACCEPTABLEDELTA 1
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-2.c
index 9655943cc..51e533530 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-2.c
@@ -34,7 +34,7 @@
 
 #define LONGSLEEPTIME 10
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 	printf("Test PASSED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
index 6d8f8bd6d..708046c6c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
@@ -35,7 +35,7 @@
 
 static int fails = 0, passes = 0;
 
-static void handler(int signo LTP_ATTRIBUTE_UNUSED)
+static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("Caught signal\n");
 	passes += 1;
diff --git a/testcases/open_posix_testsuite/functional/semaphores/sem_readerwriter.c b/testcases/open_posix_testsuite/functional/semaphores/sem_readerwriter.c
index 01c272dc9..38b4ea5a0 100644
--- a/testcases/open_posix_testsuite/functional/semaphores/sem_readerwriter.c
+++ b/testcases/open_posix_testsuite/functional/semaphores/sem_readerwriter.c
@@ -32,7 +32,7 @@ static sem_t r_lock, w_lock;
 static int reader_count = 0;
 static int data = 0;
 
-static int read_fun(int ID LTP_ATTRIBUTE_UNUSED)
+static int read_fun(int ID PTS_ATTRIBUTE_UNUSED)
 {
 	printf("read the board, data=%d \n", data);
 	return 0;
diff --git a/testcases/open_posix_testsuite/functional/semaphores/sem_sleepingbarber.c b/testcases/open_posix_testsuite/functional/semaphores/sem_sleepingbarber.c
index 1a32417e0..0488c5fcc 100644
--- a/testcases/open_posix_testsuite/functional/semaphores/sem_sleepingbarber.c
+++ b/testcases/open_posix_testsuite/functional/semaphores/sem_sleepingbarber.c
@@ -50,7 +50,7 @@ static void mdelay(unsigned msecs)
 	nanosleep(&req, NULL);
 }
 
-static void *barbers(void *unused LTP_ATTRIBUTE_UNUSED)
+static void *barbers(void *unused PTS_ATTRIBUTE_UNUSED)
 {
 	int i;
 	for (i = 0; i < LOOP_NUM; i++) {
diff --git a/testcases/open_posix_testsuite/include/noatime.h b/testcases/open_posix_testsuite/include/noatime.h
index a9173765c..43e8bcbe0 100644
--- a/testcases/open_posix_testsuite/include/noatime.h
+++ b/testcases/open_posix_testsuite/include/noatime.h
@@ -86,7 +86,7 @@ int mounted_noatime(const char *path)
 	return (_statfs.f_flags & MNT_NOATIME);
 }
 #else
-int mounted_noatime(const char *path LTP_ATTRIBUTE_UNUSED)
+int mounted_noatime(const char *path PTS_ATTRIBUTE_UNUSED)
 {
 	return 0;
 }
diff --git a/testcases/open_posix_testsuite/include/posixtest.h b/testcases/open_posix_testsuite/include/posixtest.h
index cf0952cbf..833488280 100644
--- a/testcases/open_posix_testsuite/include/posixtest.h
+++ b/testcases/open_posix_testsuite/include/posixtest.h
@@ -20,6 +20,6 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 #endif
 
-#define LTP_ATTRIBUTE_NORETURN		__attribute__((noreturn))
-#define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
-#define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
+#define PTS_ATTRIBUTE_NORETURN		__attribute__((noreturn))
+#define PTS_ATTRIBUTE_UNUSED		__attribute__((unused))
+#define PTS_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
diff --git a/testcases/open_posix_testsuite/include/proc.h b/testcases/open_posix_testsuite/include/proc.h
index ac40729b4..befb837fc 100644
--- a/testcases/open_posix_testsuite/include/proc.h
+++ b/testcases/open_posix_testsuite/include/proc.h
@@ -58,8 +58,8 @@ int tst_process_state_wait3(pid_t pid, const char state,
 	return 1;
 }
 #else
-int tst_process_state_wait3(pid_t pid LTP_ATTRIBUTE_UNUSED,
-	const char state LTP_ATTRIBUTE_UNUSED, long maxwait_s)
+int tst_process_state_wait3(pid_t pid PTS_ATTRIBUTE_UNUSED,
+	const char state PTS_ATTRIBUTE_UNUSED, long maxwait_s)
 {
 	struct timespec maxwait_ts;
 
diff --git a/testcases/open_posix_testsuite/include/tempfile.h b/testcases/open_posix_testsuite/include/tempfile.h
index cc67cf832..1d904096f 100644
--- a/testcases/open_posix_testsuite/include/tempfile.h
+++ b/testcases/open_posix_testsuite/include/tempfile.h
@@ -1,14 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Joerg Vehlow <lkml@jv-coder.de>
+ */
+
+
 #include <stdlib.h>
 #include <stdio.h>
 #include <limits.h>
 
-#define LTP_GET_TMP_FILENAME(target, prefix) \
+#define PTS_GET_TMP_FILENAME(target, prefix) \
     snprintf(target, sizeof(target), \
-    "%s/" prefix "%d", ltp_get_tmpdir(), getpid());
+    "%s/" prefix "%d", pts_get_tmpdir(), getpid());
 
-static inline const char *ltp_get_tmpdir(void)
+static inline const char *pts_get_tmpdir(void)
 {
     const char *tmpdir_env;
     tmpdir_env = getenv("TMPDIR");
     return tmpdir_env ? tmpdir_env : "/tmp";
-}
\ No newline at end of file
+}
-- 
2.30.2

