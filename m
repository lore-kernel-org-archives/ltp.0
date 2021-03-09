From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Mar 2021 14:45:20 +0100
Subject: [LTP] [PATCH 0/6] Fuzzy Sync yielding and validation test
In-Reply-To: <20210305155123.18199-1-rpalethorpe@suse.com>
References: <20210305155123.18199-1-rpalethorpe@suse.com>
Message-ID: <YEd78LRleAgWNeN3@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

1st patch has error:
tst_fuzzy_sync01.c: In function ?delay?:
tst_fuzzy_sync01.c:107:10: error: ?struct tst_fzsync_pair? has no member named ?yield_in_wait?
  107 |  if (pair.yield_in_wait)
      |          ^
tst_fuzzy_sync01.c:113:12: error: ?struct tst_fzsync_pair? has no member named ?yield_in_wait?
  113 |    if (pair.yield_in_wait)
      |            ^
make[1]: *** [../../include/mk/rules.mk:37: tst_fuzzy_sync01] Error 1

4th patch (Leo Yu-Chi Liang's) patch has warnings:
In file included from tst_fuzzy_sync01.c:8:
../../include/tst_fuzzy_sync.h: In function ?tst_fzsync_pair_init?:
../../include/tst_fuzzy_sync.h:199:18: warning: comparison of constant ?0? with boolean expression is always false [-Wbool-compare]
  199 |  if (pair->param < low)            \
      |                  ^
../../include/tst_fuzzy_sync.h:221:2: note: in expansion of macro ?CHK?
  221 |  CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));
      |  ^~~
../../include/tst_fuzzy_sync.h:201:18: warning: comparison of constant ?1? with boolean expression is always false [-Wbool-compare]
  201 |  if (pair->param > hi)            \
      |                  ^
../../include/tst_fuzzy_sync.h:221:2: note: in expansion of macro ?CHK?
  221 |  CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));


Apart from that whole patchset LGTM, agree with Cyril's suggestions.

Kind regards,
Petr
