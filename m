From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Sep 2019 22:13:15 +0200
Subject: [LTP] [PATCH 0/3] LTP_TIMEOUT for shell API
Message-ID: <20190912201318.30931-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

patchset replaces LTP_TIMEOUT_MUL for shell and C [1]
and memcg_stress_test.sh timeout fix [2].

It's also related to Clements fix for TST_RETRY_FN() and tst_adjust_timeout().

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=120151&state=*
[2] https://patchwork.ozlabs.org/patch/1155460/
[3] https://patchwork.ozlabs.org/project/ltp/list/?submitter=74899

Petr Vorel (3):
  shell: Add tst_is_num()
  shell: Introduce LTP_TIMEOUT variable
  net/if-mtu-change.sh: set LTP_TIMEOUT

 doc/test-writing-guidelines.txt               | 89 ++++++++++++-------
 .../memcg/stress/memcg_stress_test.sh         |  2 +-
 testcases/lib/tst_test.sh                     | 31 ++++++-
 .../network/stress/interface/if-mtu-change.sh |  4 +-
 4 files changed, 90 insertions(+), 36 deletions(-)

-- 
2.22.1

