From: Yang Shi <yang.shi@linux.alibaba.com>
Date: Tue, 5 Jun 2018 09:34:53 -0700
Subject: [LTP] [PATCH] memcg: functional: 4.16 kernel updates stat
 counter in a batch of 33 pages
In-Reply-To: <CAEemH2c5H+gL1mPFyGcBA0__bJXCf6J4vQ4-xZwFSG5Mp4cjqw@mail.gmail.com>
References: <1527207217-70686-1-git-send-email-yang.shi@linux.alibaba.com>
 <CAEemH2c5H+gL1mPFyGcBA0__bJXCf6J4vQ4-xZwFSG5Mp4cjqw@mail.gmail.com>
Message-ID: <bbb318c2-0fa5-ec52-5b96-798549343466@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 6/5/18 12:33 AM, Li Wang wrote:
> Hi Yang,
>
> Yang Shi <yang.shi@linux.alibaba.com 
> <mailto:yang.shi@linux.alibaba.com>> wrote:
>
>     Due to upstream kernel commit a983b5ebee57209c99f68c8327072f25e0e6e3da
>     ("mm: memcontrol: fix excessive complexity in memory.stat reporting"),
>     memory.stat is updated in a batch of 33 pages. This results in
>     some test
>     cases fail at checking stat counter since they just touch one page.
>
>     Introduce TST_PAGESIZE, which is 33 * PAGESIZE, used by affected test
>     cases, keep others still use PAGESIZE. And, this change doesn't break
>     pre-4.16 kernel.
>
>     Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com
>     <mailto:yang.shi@linux.alibaba.com>>
>     ---
>      testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 13
>     ++++++++-----
>      .../functional/memcg_move_charge_at_immigrate_test.sh     | 14
>     +++++++-------
>      .../kernel/controllers/memcg/functional/memcg_stat_rss.sh | 12
>     ++++++------
>      .../kernel/controllers/memcg/functional/memcg_stat_test.sh |  6
>     +++---
>      4 files changed, 24 insertions(+), 21 deletions(-)
>
>     diff --git
>     a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>     b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>     index 6a6af85..ad6db24 100755
>     --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>     +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>     @@ -34,6 +34,9 @@ if [ $? -ne 0 ]; then
>             tst_brkm TBROK "getconf PAGESIZE failed"
>      fi
>
>     +# Post 4.16 kernel updates stat in batch (> 32 pages) every time
>     +TST_PAGESIZE=$(( $PAGESIZE * 33 ))
>
>
> ​AFAIK, LTP always reserve the ‘TST_’ prefix for general-purpose library
> using, so we'd better avoid this in testcase variable naming.
>
> What about replacing it by PAGESIZES or PAGESIZE_NUM?​

"PAGESIZES" looks reasonable. Thanks for the suggestion. Will fix in v2.

Yang

>
> -- 
> Regards,
> Li Wang

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180605/356ed004/attachment.html>
