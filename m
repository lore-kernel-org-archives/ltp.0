From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Sep 2019 14:58:20 +0200
Subject: [LTP] [PATCH v2 0/3] LTP_TIMEOUT for shell API
Message-ID: <20190913125823.17314-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v1->v2:
addressed issues reported by Clemens and Cristian (thanks!)
* s/LTP_TIMEOUT/TST_TIMEOUT in whole patchset (assume for test variable
is better to stick with TST_ prefix)
* fix int/float $LTP_TIMEOUT_MUL detection algorithm (added missing parameter "$LTP_TIMEOUT_MUL"

+ other fixes:
* add "TIMEOUT" to filter in tst_run() (to filter out TST_TIMEOUT)
* round $sec off to make it being int, so that for $h $m $s calculations
it's possible to use $(( )).

Questions:
* I don't know how to detect TST_TIMEOUT settings made by user. That's
the difference from C, where user cannot overwrite tst_test->test.
Am I missing something or it's not possible to detect whether variable
was set in code or by user?
Maybe that was the reason TST_TIMEOUT wasn't set, but rather fixed.

* Code allowing $LTP_TIMEOUT_MUL being also float making code a bit
complex. If you don't like it, I suggest to change $LTP_TIMEOUT_MUL
being for both C and shell integer, but I'd prefer the possibility to be float.
(it's might be handy being able to set timeout 1.33x which is far less
than 2x for int).

Kind regards,
Petr

Petr Vorel (3):
  shell: Add tst_is_num()
  shell: Introduce TST_TIMEOUT variable
  net/if-mtu-change.sh: set TST_TIMEOUT

 doc/test-writing-guidelines.txt               | 89 ++++++++++++-------
 .../memcg/stress/memcg_stress_test.sh         |  2 +-
 testcases/lib/tst_test.sh                     | 43 ++++++++-
 .../network/stress/interface/if-mtu-change.sh |  4 +-
 4 files changed, 101 insertions(+), 37 deletions(-)

-- 
2.22.1

