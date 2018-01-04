From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  4 Jan 2018 21:42:48 +0100
Subject: [LTP] [RFC PATCH 0/2] Allow to compile on archs without atomic
	support
Message-ID: <20180104204250.7032-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I know as this has quite low priority (benefit only people with old
compilers and archs), but why not to give a chance them to have at least
something from LTP?
Quite a lot of tests it's working, affected are only tests using threads
on new API or fuzzy synchronization and counting results for tests using
new api.

Kind regards,
Petr

Petr Vorel (2):
  tst_atomic.h: Allow to compile on archs without atomic support
  lib/tst_test.c: Don't print results on archs without atomic

 include/tst_atomic.h | 31 +++++++++++++++++++++++++++++--
 lib/tst_test.c       |  4 ++++
 2 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.15.1

