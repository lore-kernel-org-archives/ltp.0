From: Piotr Gawel <piotr.krzysztof.gawel@gmail.com>
Date: Wed, 24 Jul 2019 20:23:42 +0200
Subject: [LTP] [PATCH] tst_timer fixes
Message-ID: <1563992624-4968-1-git-send-email-piotr.krzysztof.gawel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello LTP community,

As requested, I've split my previous patch into two and resigned
from third change (hardening).
Please review these patches and add them to main stream.

Kind regards,
Piotr

Piotr Gawel (2):
  tst_timer: fix qsort comparison function
  tst_timer: fix verification of execution time

 lib/tst_timer_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

