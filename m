From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  9 Oct 2017 12:18:22 +0200
Subject: [LTP] [PATCH 0/2] Updates to pthread_{barrier,cond}_destroy()
Message-ID: <20171009101824.17251-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Both these tests are a little suspect as they are testing undefined
behavior. They also use calls to sleep() for sychronisation and assume setting
or getting an integer with the '=' operator is atomic.

Even though they are testing undefined behavior, I think they are still useful
just to check how a particular implementation deals with these scenarios. I
have tried to relax the test as much as possible to avoid spurious
failures. Also, even though it is probably allowed by the spec, I would
consider a segfault to be a failure.

These tests do naturally include race conditions and waste time in calls to
sleep, we could mitigate them by using another synchronisation mechanism (e.g
TST_CHECKPOINT or fzsync), but not remove them completely. I'm not sure whether
introducing LTP library functions into the POSIX tests is a good idea or not.

Richard Palethorpe (2):
  POSIX: Allow pthread_barrier_destroy() to block
  POSIX: Allow pthread_cond_destroy to block

 .../interfaces/pthread_barrier_destroy/2-1.c       | 101 +++++++++++++--------
 .../pthread_cond_destroy/speculative/4-1.c         |  81 +++++++++--------
 2 files changed, 105 insertions(+), 77 deletions(-)

-- 
2.14.2

